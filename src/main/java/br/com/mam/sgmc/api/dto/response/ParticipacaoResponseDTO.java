package br.com.mam.sgmc.api.dto.response;

import java.sql.Date;

import br.com.mam.sgmc.model.Participacao;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ParticipacaoResponseDTO {
    private Long idEvento;
    private String nomeEvento;
    private Long idMembro;
    private String nomeMembro;
    private String placaMoto;
    private String modeloMoto;
    private Date dataInscricao;

    public static ParticipacaoResponseDTO toResponseDTO(Participacao participacao) {
        return new ParticipacaoResponseDTO(
            participacao.getPk().getEvento().getId(),
            participacao.getPk().getEvento().getNome(),
            participacao.getPk().getMembro().getId(),
            participacao.getPk().getMembro().getNome(),
            participacao.getMoto() != null ? participacao.getMoto().getPlaca() : null,
            participacao.getMoto() != null && participacao.getMoto().getModelo() != null ? participacao.getMoto().getModelo().getNome() : null,
            participacao.getDataInscricao()
        );
    }
}
