package com.example.joaop.fixit;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.Toast;

import java.io.IOException;
import java.util.LinkedList;

import Classes.Chamado;
import Classes.Computador;
import Classes.Problema;

public class RealizarChamadasActivity extends AppCompatActivity {

    EditText etObservacao;
    Spinner spTipoProblema, spProblema, spSala, spComputador;
    LinkedList<Problema> problemas;
    LinkedList<Computador> computadores;
    Dados dados;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_realizar_chamadas);
        final Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        setTitle("Adicionar chamado");

        spTipoProblema = findViewById(R.id.spTipoProblema);
        spProblema = findViewById(R.id.spProblema);
        spSala = findViewById(R.id.spSala);
        spComputador = findViewById(R.id.spComputador);
        etObservacao = findViewById(R.id.etObservacao);
        dados = (Dados) getApplicationContext();

        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    dados.getOut().writeObject("Problemas");
                    problemas = (LinkedList<Problema>) dados.getIn().readObject();
                    dados.getOut().writeObject("Computadores");
                    computadores = (LinkedList<Computador>) dados.getIn().readObject();

                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            LinkedList<String> nomes_problemas = new LinkedList<>();

                            for (Problema problema : problemas) {
                                if (problema.getTipo() == 1) {
                                    nomes_problemas.add(problema.getDescricao());
                                }
                            }

                            ArrayAdapter<String> adapter = new ArrayAdapter<String>(RealizarChamadasActivity.this, android.R.layout.simple_spinner_dropdown_item, nomes_problemas);
                            spProblema.setAdapter(adapter);

                            LinkedList<String> nomes_salas = new LinkedList<>();

                            for (Computador computador : computadores) {
                                if (!nomes_salas.contains(String.valueOf(computador.getSala()))) {
                                    nomes_salas.add(String.valueOf(computador.getSala()));
                                }
                            }

                            adapter = new ArrayAdapter<String>(RealizarChamadasActivity.this, android.R.layout.simple_spinner_dropdown_item, nomes_salas);
                            spSala.setAdapter(adapter);

                            toolbar.getMenu().getItem(0).setEnabled(true);

                            spTipoProblema.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                                @Override
                                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                                    LinkedList<String> nomes_problemas = new LinkedList<>();

                                    for (Problema problema : problemas) {
                                        if (problema.getTipo() == position + 1) {
                                            nomes_problemas.add(problema.getDescricao());
                                        }
                                    }

                                    ArrayAdapter<String> adapter = new ArrayAdapter<String>(RealizarChamadasActivity.this, android.R.layout.simple_spinner_dropdown_item, nomes_problemas);
                                    spProblema.setAdapter(adapter);
                                }

                                @Override
                                public void onNothingSelected(AdapterView<?> parent) {

                                }
                            });

                            spSala.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                                @Override
                                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                                    LinkedList<String> nomes_computadores = new LinkedList<>();

                                    for (Computador computador : computadores) {
                                        if (String.valueOf(computador.getSala()).equals(spSala.getSelectedItem())) {
                                            nomes_computadores.add(String.valueOf(computador.getNumero()));
                                        }
                                    }

                                    ArrayAdapter<String> adapter = new ArrayAdapter<String>(RealizarChamadasActivity.this, android.R.layout.simple_spinner_dropdown_item, nomes_computadores);
                                    spComputador.setAdapter(adapter);
                                }

                                @Override
                                public void onNothingSelected(AdapterView<?> parent) {

                                }
                            });
                        }
                    });
                } catch (IOException | ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_realizar_chamado, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_adicionar:
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        try {
                            Computador computador = null;
                            for (Computador computador1 : computadores) {
                                if (computador1.getSala() == Integer.valueOf(spSala.getSelectedItem().toString()) && computador1.getNumero() == Integer.valueOf(spComputador.getSelectedItem().toString())) {
                                    computador = computador1;
                                    break;
                                }
                            }

                            Problema problema = null;
                            for (Problema problema1 : problemas) {
                                if (problema1.getTipo() == spTipoProblema.getSelectedItemPosition() + 1 && problema1.getDescricao().equals(spProblema.getSelectedItem().toString())) {
                                    problema = problema1;
                                    break;
                                }
                            }

<<<<<<< HEAD:Mobile/app/src/main/java/com/example/joaop/fixit/RealizarChamadasActivity.java
<<<<<<< HEAD:Mobile/app/src/main/java/com/example/joaop/fixit/AdicionarChamadoActivity.java
                                Chamado chamado = new Chamado(computador, problema, etObservacao.getText().toString());

                                dados.getOut().writeObject("AdicionarChamado");
                                dados.getIn().readObject();
                                dados.getOut().writeObject(chamado);
                                if ((int) dados.getIn().readObject() == 1) {
                                    runOnUiThread(new Runnable() {
                                        @Override
                                        public void run() {
                                            setResult(1);
                                            finish();
                                        }
                                    });
                                } else {
                                    runOnUiThread(new Runnable() {
                                        @Override
                                        public void run() {
                                            Toast.makeText(dados, "Não foi possivel adicionar o chamado!\nTente novamente.", Toast.LENGTH_SHORT).show();
                                        }
                                    });
                                }
                            } catch (IOException | ClassNotFoundException e) {
                                e.printStackTrace();
=======
=======
>>>>>>> parent of 3c7d7a2... Merge branch 'master' of https://github.com/JoaoHickmann/FixIt:Mobile/app/src/main/java/com/example/joaop/fixit/RealizarChamadasActivity.java
                            Chamado chamado = new Chamado(computador, problema, etObservacao.getText().toString());

                            dados.getOut().writeObject("AdicionarChamado");
                            dados.getIn().readObject();
                            dados.getOut().writeObject(chamado);
                            if ((int) dados.getIn().readObject() == 1) {
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        Toast.makeText(RealizarChamadasActivity.this, "Chamado adicionado.", Toast.LENGTH_SHORT).show();
                                        finish();
                                    }
                                });
                            } else {
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        Toast.makeText(dados, "Não foi possivel adicionar o chamado!\nTente novamente.", Toast.LENGTH_SHORT).show();
                                    }
                                });
<<<<<<< HEAD:Mobile/app/src/main/java/com/example/joaop/fixit/RealizarChamadasActivity.java
>>>>>>> parent of 3c7d7a2... Merge branch 'master' of https://github.com/JoaoHickmann/FixIt:Mobile/app/src/main/java/com/example/joaop/fixit/RealizarChamadasActivity.java
=======
>>>>>>> parent of 3c7d7a2... Merge branch 'master' of https://github.com/JoaoHickmann/FixIt:Mobile/app/src/main/java/com/example/joaop/fixit/RealizarChamadasActivity.java
                            }
                        } catch (IOException | ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                    }
                }).start();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

}
