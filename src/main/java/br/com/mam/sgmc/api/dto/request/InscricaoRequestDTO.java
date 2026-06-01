package br.com.mam.sgmc.api.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class InscricaoRequestDTO {

    @NotNull(message = "O ID do membro é obrigatório")
    private Long idMembro;

    private String placaMoto;
}
