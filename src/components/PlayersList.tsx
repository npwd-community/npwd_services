import {
  Box,
  ListItem,
  List,
  ListSubheader,
  Collapse,
  IconButton,
  ListItemText,
} from '@mui/material';
import React, { useState } from 'react';
import { Player } from '../types/service';
import PhoneIcon from '@mui/icons-material/Phone';
import { ServerPromiseResp } from '../types/common';
import fetchNui from '../utils/fetchNui';

interface PlayersListProps {
  isDarkMode: boolean;
  players: any;
}

export const PlayersList: React.FC<PlayersListProps> = ({ players, isDarkMode }) => {
  const [collapseId, setCollapseId] = useState<string | null>(null);

  const expandItem = (id: string) => {
    setCollapseId(id);
  };

  const handleCallPlayer = (number: string) => {
    fetchNui<ServerPromiseResp>('npwd:qb-services:callPlayer', { number }).then((res) => {
      console.log(res.data);
    });
  };

  return (
    <Box>
      {Object.keys(players).map((key) => (
        <List
          subheader={
            <ListSubheader sx={{ cursor: 'pointer' }} onClick={() => expandItem(key)}>
              {key.toUpperCase()}
            </ListSubheader>
          }
        >
          <Collapse in={collapseId === key}>
            {players[key].map((player: Player) => {
              return (
                <ListItem
                  secondaryAction={
                    <IconButton
                    onClick={() => handleCallPlayer(player.phoneNumber)}
                    >
                      <PhoneIcon />
                    </IconButton>
                  }
                >
                  <ListItemText
                    primaryTypographyProps={{
                      color: isDarkMode ? '#fff' : '#000',
                      fontWeight: 'bold',
                    }}
                    primary={player.name}
                    secondary={player.phoneNumber}
                  />
                </ListItem>
              );
            })}
          </Collapse>
        </List>
      ))}
    </Box>
  );
};
