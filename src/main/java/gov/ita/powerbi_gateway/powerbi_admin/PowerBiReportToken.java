package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PowerBiReportToken {
  Report powerBiReport;
  Token powerBiToken;
}
