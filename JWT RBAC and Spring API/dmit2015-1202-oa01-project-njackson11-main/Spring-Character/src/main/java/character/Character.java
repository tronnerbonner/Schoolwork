package character;

import org.apache.tomcat.jni.Local;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
@Entity
class Character {

    private @Id @GeneratedValue Long id;
    private String name;
    private Integer health;
    private String fate;
    private Double versionAdded;
    private LocalDateTime createdDateTime;
    private LocalDateTime lastModifiedDateTime;


    Character(String name, Integer health, String fate, Double versionAdded) {

        this.name = name;
        this.health = health;
        this.fate = fate;
        this.versionAdded = versionAdded;
        this.createdDateTime = LocalDateTime.now();
        this.lastModifiedDateTime = LocalDateTime.now();
    }

    public Character() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getHealth() {
        return health;
    }

    public void setHealth(Integer health) {
        this.health = health;
    }

    public String getFate() {
        return fate;
    }

    public void setFate(String fate) {
        this.fate = fate;
    }

    public Double getVersionAdded() {
        return versionAdded;
    }

    public void setVersionAdded(Double versionAdded) {
        this.versionAdded = versionAdded;
    }

    public LocalDateTime getCreatedDateTime() {
        return createdDateTime;
    }

    public void setCreatedDateTime(LocalDateTime createdDateTime) {
        this.createdDateTime = createdDateTime;
    }

    public LocalDateTime getLastModifiedDateTime() {
        return lastModifiedDateTime;
    }

    public void setLastModifiedDateTime() {
        this.lastModifiedDateTime = LocalDateTime.now();
    }




    @Override
    public boolean equals(Object o) {

        if (this == o)
            return true;
        if (!(o instanceof Character))
            return false;
        Character character = (Character) o;
        return Objects.equals(this.id, character.id) && Objects.equals(this.name, character.name) && Objects.equals(this.health, character.health)
                && Objects.equals(this.fate, character.fate) && Objects.equals(this.versionAdded, character.versionAdded)
                && Objects.equals(this.createdDateTime, character.createdDateTime)
                && Objects.equals(this.lastModifiedDateTime, character.lastModifiedDateTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id, this.name, this.health, this.fate, this.versionAdded, this.createdDateTime, this.lastModifiedDateTime);
    }

    @Override
    public String toString() {
        return "Character{" + "id=" + this.id + ", name='" + this.name + '\'' + ", health='" + this.health + '\'' + ", fate='" + this.fate + '\'' +
                ", versionAdded='" + this.versionAdded + '\'' + ", createdDateTime='" + this.createdDateTime + '\'' + ", lastModifiedDateTime='" + this.lastModifiedDateTime + '\'' + '}';
    }
}

