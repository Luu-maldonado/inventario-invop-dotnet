# Usa una imagen oficial de .NET 8
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia el archivo .csproj y restaura dependencias
COPY ["Proyect_InvOperativa.csproj", "./"]
RUN dotnet restore "Proyect_InvOperativa.csproj"

# Copia el resto del código y compila
COPY . .
RUN dotnet publish "Proyect_InvOperativa.csproj" -c Release -o /app/publish

# Runtime image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Proyect_InvOperativa.dll"]
