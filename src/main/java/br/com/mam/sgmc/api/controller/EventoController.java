package br.com.mam.sgmc.api.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.mam.sgmc.api.openapi.EventoControllerOpenAPI;
import br.com.mam.sgmc.api.dto.request.EventoRequestDTO;
import br.com.mam.sgmc.api.dto.response.EventoResponseDTO;
import br.com.mam.sgmc.api.dto.response.MembroResponseDTO;
import br.com.mam.sgmc.model.Evento;
import br.com.mam.sgmc.model.Participacao;
import br.com.mam.sgmc.services.EventoService;
import br.com.mam.sgmc.services.MembroService;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping(value = "/eventos")
@RequiredArgsConstructor
public class EventoController implements EventoControllerOpenAPI {

    private final MembroService membroService;
    private final EventoService eventoService;

    @PostMapping
    public ResponseEntity<EventoResponseDTO> criarEvento(@RequestBody EventoRequestDTO eventoRequestDTO) {
        Evento evento = Evento.fromRequestDTO(eventoRequestDTO);
        EventoResponseDTO eventoCriado = EventoResponseDTO.toResponseDTO(this.eventoService.criarEvento(evento));
        return ResponseEntity.status(HttpStatus.CREATED).body(eventoCriado);
    }
    /*
    @GetMapping("/participacoes/{id}")
    public ResponseEntity<List<MembroResponseDTO>> listarMembrosPorEvento(@PathVariable Long id) {
        List<Participacao> participacoes = this.membroService.listarParticipacoesPorEvento(id);
        List<MembroResponseDTO> responses = participacoes.stream()
                .map(MembroResponseDTO::toResponseDTO)
                .toList();
        return ResponseEntity.status(HttpStatus.OK).body(responses);
    }
    */

    @GetMapping
    public ResponseEntity<List<EventoResponseDTO>> listarEventos() {
        List<Evento> eventos = this.eventoService.listarEventos();
        List<EventoResponseDTO> responses = eventos.stream()
                .map(EventoResponseDTO::toResponseDTO)
                .toList();
        return ResponseEntity.status(HttpStatus.OK).body(responses);
    }
    
}
