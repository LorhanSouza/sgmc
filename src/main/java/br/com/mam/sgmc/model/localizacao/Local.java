package br.com.mam.sgmc.model.localizacao;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import br.com.mam.sgmc.api.dto.request.LocalRequestDTO;
import br.com.mam.sgmc.model.Evento;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Entity
@Table(name = "local")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Local {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_local")
    private Long id;
    @Column(name = "nome", length = 255)
    private String nome;
    @Column(name = "endereco", length = 255)
    private String endereco;
    @Column(name = "bairro", length = 150)
    private String bairro;
    @Column(name = "numero", length = 6)
    private String numero;
    @Column(name = "codigo_postal", length = 10)
    private String codigoPostal;
    private int capacidade;
    @Column(name = "contato", length = 15)
    private String contato;
    
    @ManyToOne
    @JoinColumn(name = "id_cidade")
    private Cidade cidade;

    @OneToMany(mappedBy = "local")
    @JsonManagedReference
    private List<Evento> eventos;

    public static Local fromRequestDTO(LocalRequestDTO localRequestDTO) {
        Local local = new Local();
        local.setNome(localRequestDTO.getNome());
        local.setEndereco(localRequestDTO.getEndereco());
        local.setBairro(localRequestDTO.getBairro());
        local.setNumero(localRequestDTO.getNumero());
        local.setCodigoPostal(localRequestDTO.getCodigoPostal());
        local.setCapacidade(localRequestDTO.getCapacidade());
        local.setContato(localRequestDTO.getContato());
        local.setCidade(new Cidade());
        local.getCidade().setNome(localRequestDTO.getCidade());
        local.getCidade().setUf(new Uf());
        local.getCidade().getUf().setNome(localRequestDTO.getProvinciaEstado());
        local.getCidade().getUf().setPais(new Pais());
        local.getCidade().getUf().getPais().setNome(localRequestDTO.getPais());
        return local;
    }
}
