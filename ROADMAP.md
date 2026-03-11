# Guía de Desarrollo - Goal 2 Remake

## 🎯 Tu Roadmap Personal

Esta guía te llevará desde el MVP actual hasta un juego completo como Goal 2.

---

## FASE 1: Fundamentos Visuales (Semana 1-2)

### Día 1-3: Sprites del Jugador
**Qué hacer:**
1. Crea o descarga sprites pixel art de jugadores (16x16 o 32x32 píxels)
2. En Godot, reemplaza el ColorRect del Player por un Sprite2D
3. Añade frames de animación (idle, run, kick)

**Recursos:**
- OpenGameArt.org - sprites gratis
- Piskel.com - editor de pixel art online gratis
- Aseprite - editor profesional ($20, pero vale la pena)

**Código ejemplo:**
```gdscript
# En player.gd, añade:
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
    # ... tu código de movimiento ...
    
    if velocity.length() > 0:
        sprite.play("run")
    else:
        sprite.play("idle")
```

### Día 4-5: Sprite del Balón
**Qué hacer:**
1. Sprite de balón (círculo blanco con hexágonos negros)
2. Añadir rotación cuando el balón se mueve

**Código ejemplo:**
```gdscript
# En ball.gd, añade:
func _physics_process(delta):
    velocity *= FRICTION
    
    # Rotar según velocidad
    if velocity.length() > 0:
        rotation += velocity.length() * delta * 0.1
    
    # ... resto del código ...
```

### Día 6-7: Campo Mejorado
**Qué hacer:**
1. Añadir texturas al césped (opcional)
2. Mejorar porterías con redes
3. Añadir área de penalty

---

## FASE 2: Sonido y Feedback (Semana 3)

### Día 1-2: Efectos de Sonido
**Qué hacer:**
1. Descarga sonidos: pateo, gol, silbato
2. Crea nodos AudioStreamPlayer en la escena
3. Reproduce sonidos en momentos clave

**Recursos gratis:**
- Freesound.org
- OpenGameArt.org (sección audio)

**Código ejemplo:**
```gdscript
# En player.gd:
@onready var kick_sound = $KickSound

func try_kick():
    # ... tu código de kick ...
    if ball.has_method("kick"):
        ball.kick(kick_direction * KICK_POWER)
        kick_sound.play()  # ¡Sonido!
```

### Día 3-4: Efectos Visuales
**Qué hacer:**
1. Partículas cuando se patea el balón
2. Efecto de "¡GOL!" en pantalla
3. Cámara shake al marcar

### Día 5-7: Música de Fondo
**Qué hacer:**
1. Música de menú
2. Música durante el partido
3. Sistema para cambiar entre tracks

---

## FASE 3: IA Básica (Semana 4-5)

### Compañeros de Equipo
**Qué hacer:**
1. Crear script `teammate_ai.gd`
2. Lógica simple: seguir al balón si está cerca
3. Posicionarse en formación cuando no tienen balón

**Código base:**
```gdscript
# teammate_ai.gd
extends CharacterBody2D

const SPEED = 100.0
var home_position = Vector2.ZERO

func _ready():
    home_position = global_position

func _physics_process(delta):
    var ball = get_tree().get_first_node_in_group("ball")
    var target = home_position
    
    if ball:
        var dist_to_ball = global_position.distance_to(ball.global_position)
        
        # Si el balón está cerca, ir por él
        if dist_to_ball < 100:
            target = ball.global_position
    
    # Moverse hacia el objetivo
    var direction = (target - global_position).normalized()
    velocity = direction * SPEED
    move_and_slide()
```

### Equipo Rival
**Qué hacer:**
1. Copiar y modificar `teammate_ai.gd` → `opponent_ai.gd`
2. Lógica defensiva: bloquear al jugador
3. Lógica ofensiva: intentar marcar gol

### Portero
**Qué hacer:**
1. Script especial `goalkeeper_ai.gd`
2. Se mueve solo horizontalmente
3. Intenta atrapar el balón si está cerca

---

## FASE 4: Menús y Flujo del Juego (Semana 6)

### Menú Principal
**Qué hacer:**
1. Crear escena `menu.tscn`
2. Botones: Jugar, Opciones, Salir
3. Conectar con la escena del partido

**Estructura:**
```
Menu (Control)
├── Title (Label) - "GOAL 2 REMAKE"
├── PlayButton (Button) - "JUGAR"
├── OptionsButton (Button) - "OPCIONES"
└── QuitButton (Button) - "SALIR"
```

### Pantalla de Selección de Equipos
**Qué hacer:**
1. Mostrar banderas/nombres de equipos
2. Permitir elegir formación (4-4-2, 4-3-3, etc.)
3. Pasar datos al partido

### Pausa y Game Over
**Qué hacer:**
1. Menú de pausa (ESC)
2. Pantalla de fin de partido con estadísticas
3. Opción de reiniciar o volver al menú

---

## FASE 5: Gameplay Avanzado (Semana 7-8)

### Sistema de Pases
**Qué hacer:**
1. Detectar compañeros cercanos
2. Presionar botón de pase para pasarla al más cercano
3. Visual indicator de a quién se la vas a pasar

### Tipos de Tiros
**Qué hacer:**
1. Tiro normal (espacio corto)
2. Tiro fuerte (espacio largo)
3. Pase elevado

### Físicas Mejoradas
**Qué hacer:**
1. Balón que rebota en las paredes
2. Efecto de curva en tiros
3. Altura simulada del balón (sombra)

---

## FASE 6: Modos de Juego (Semana 9-10)

### Partido Amistoso
✅ Ya lo tienes funcionando

### Modo Torneo
**Qué hacer:**
1. Crear bracket de equipos
2. Sistema de puntos
3. Pantallas entre partidos
4. Final y campeón

### Práctica de Penales
**Qué hacer:**
1. Escena especial solo con portero
2. Modo de práctica de tiros

---

## FASE 7: Pulido Final (Semana 11-12)

### Opciones
**Qué hacer:**
1. Ajustar volumen
2. Cambiar resolución
3. Controles personalizables

### Estadísticas
**Qué hacer:**
1. Goles, tiros, pases por partido
2. Guardar estadísticas del torneo
3. Tabla de posiciones

### Extras
**Qué hacer:**
1. Replay de goles
2. Diferentes condiciones climáticas
3. Tarjetas amarillas/rojas
4. Celebraciones de gol

---

## 🎓 Aprendizaje Recomendado

### Si nunca usaste Godot:
1. Tutorial oficial: "Your First 2D Game" (2-3 horas)
2. Video: "Godot in 100 seconds" - Fireship (para overview rápido)

### Si sabes programar pero no GDScript:
- GDScript es 90% Python
- Diferencias principales: 
  - `func` en vez de `def`
  - Tipado opcional con `:`
  - `@onready` para referencias a nodos

### Recursos de Pixel Art:
1. YouTube: "Pixel Art Tutorial for Beginners" - Brandon James Greer
2. Práctica: Recrea 1 sprite de Goal 2 original por día

---

## 📊 Checklist de Progreso

Marca lo que vayas completando:

**Semana 1-2:**
- [ ] Sprites de jugador
- [ ] Animaciones básicas
- [ ] Sprite de balón rotando
- [ ] Campo con texturas

**Semana 3:**
- [ ] Sonidos de pateo
- [ ] Sonido de gol
- [ ] Música de fondo
- [ ] Efectos visuales básicos

**Semana 4-5:**
- [ ] 2-3 compañeros de equipo con IA
- [ ] Equipo rival con IA
- [ ] Porteros funcionales

**Semana 6:**
- [ ] Menú principal
- [ ] Selección de equipos
- [ ] Sistema de pausa

**Semana 7-8:**
- [ ] Sistema de pases
- [ ] Diferentes tipos de tiro
- [ ] Mejores físicas

**Semana 9-10:**
- [ ] Modo torneo
- [ ] Pantallas entre partidos

**Semana 11-12:**
- [ ] Opciones completas
- [ ] Estadísticas
- [ ] Pulido general

---

## 💪 Consejos Motivacionales

1. **No compares tu Día 1 con el Día 365 de otro**
   - Goal 2 tomó un equipo y años
   - Tu remake puede tomar meses, ¡y está bien!

2. **Commit pequeños y frecuentes**
   - No esperes a "terminar todo"
   - Cada feature es un logro

3. **Muestra tu progreso**
   - Sube videos a YouTube/TikTok
   - La comunidad de Godot es super supportive

4. **Está bien copiar para aprender**
   - Usa tutoriales
   - Estudia código de otros
   - Luego personaliza

5. **Prioriza lo divertido**
   - Si un feature te aburre, déjalo para después
   - Haz primero lo que te emociona

---

## 🚨 Errores Comunes a Evitar

❌ **Perfeccionismo temprano**: No gastes semanas en el menú, enfócate en gameplay
❌ **Feature creep**: No añadas "modo online" en semana 2
❌ **Ignorar el scope**: Goal 2 es simple, mantenlo simple
❌ **No probar seguido**: Prueba cada 15-30 minutos
❌ **Código sin comentarios**: Tu yo del futuro te lo agradecerá

---

## 🎮 ¿Cuándo está "terminado"?

Tu juego está listo para compartir cuando:
- ✅ Puedes jugar un partido completo sin crashes
- ✅ Los goles se detectan correctamente
- ✅ La IA oponente es un desafío mínimo
- ✅ Tiene sonido
- ✅ Tiene un menú básico

Todo lo demás es bonus. ¡No necesitas replicar EXACTAMENTE Goal 2 para tener un gran juego!

---

**¡Recuerda: Ya tienes el MVP funcionando! Cada paso de aquí en adelante es progreso real. 🎉**

**¡Mucha suerte y diviértete! ⚽🎮**
