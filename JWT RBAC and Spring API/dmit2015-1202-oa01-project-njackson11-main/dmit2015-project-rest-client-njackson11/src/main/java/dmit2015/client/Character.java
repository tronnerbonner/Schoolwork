package dmit2015.client;

import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.DecimalMin;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * @author Norris Jackson
 * @version 2021/02/06
 * This persistence class contains the following information about a BBTAG character
 * - id (unique identifier for the character)
 * - name (character name)
 * - health (health value for character)
 * - fate (characters game of origin)
 * - versionAdded (the version when the character was added)
 * - createdDateTime (time the entity was created)
 * - lastModifiedDateTime (time the entity was last modified)
 */

public class Character implements Serializable {

    private Long id;

    private String name;

    private String username;

    private Integer health;

    private String fate;

    private double versionAdded;

    private LocalDateTime createdDateTime;

    private LocalDateTime lastModifiedDateTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername(){return username;}

    public void setUsername(String username){this.username = username;}

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
        this.createdDateTime = LocalDateTime.now();
    }

    public LocalDateTime getLastModifiedDateTime() {
        return lastModifiedDateTime;
    }

    public void setLastModifiedDateTime(LocalDateTime lastModifiedDateTime) {
        this.lastModifiedDateTime = LocalDateTime.now(); //Sets lastModifiedDateTime t now when using the set functionality.
    }

    @PrePersist
    protected void prePersist() {
        if (this.createdDateTime == null) createdDateTime = LocalDateTime.now();
        if (this.lastModifiedDateTime == null) lastModifiedDateTime = LocalDateTime.now();
    } //This method allows for created and last modified dates to be set to the current time upon creating the entity.

    @PreUpdate
    protected void preUpdate() {
        this.lastModifiedDateTime = LocalDateTime.now();
    } //Alternate method to updating the dateTime to current dateTime for LastModified date

}
