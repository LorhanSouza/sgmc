package br.com.mam.sgmc.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.mam.sgmc.model.Evento;

public interface EventoRepository extends JpaRepository<Evento, Long> {
    
}
