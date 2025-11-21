FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

COPY worker/*.csproj worker/
RUN dotnet restore worker/Worker.csproj

COPY worker/ worker/
WORKDIR /src/worker
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app

RUN apt-get update && apt-get install -y netcat-openbsd postgresql-client redis-tools && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 appuser

COPY --from=build /app/publish .

COPY wait-for-health.sh /wait-for-health.sh
RUN chmod +x /wait-for-health.sh

USER appuser
EXPOSE 8000

CMD ["dotnet", "Worker.dll"]
