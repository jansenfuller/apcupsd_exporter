FROM golang:1.26-alpine AS build

WORKDIR /app

COPY . .

RUN go build ./cmd/apcupsd_exporter

FROM alpine AS runtime

COPY --from=build /app/apcupsd_exporter /apcupsd_exporter

RUN adduser -u 1000 -D exporter && chmod o+x /apcupsd_exporter

WORKDIR /

USER exporter
CMD ["/apcupsd_exporter"]

