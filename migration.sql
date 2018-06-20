-- basic
INSERT INTO pit.company SELECT c.*
                        FROM plant_insight.company AS c
                        WHERE c.id = 5886;
INSERT INTO pit.agg_data_calculator SELECT *
                                    FROM plant_insight.agg_data_calculator;
INSERT INTO pit.specification SELECT *
                              FROM plant_insight.specification;
INSERT INTO pit.rank SELECT *
                     FROM plant_insight.rank;
-- user privilege
INSERT INTO pit.priv_role SELECT r.*
                          FROM plant_insight.priv_role AS r
                          WHERE r.company_id = 5886;
INSERT INTO pit.priv_feature SELECT f.*
                             FROM plant_insight.priv_feature AS f
                             WHERE f.company_id IS NULL OR f.company_id = 5886;
INSERT INTO pit.priv_operation SELECT o.*
                               FROM plant_insight.priv_operation AS o
                               WHERE o.company_id IS NULL OR o.company_id = 5886;
INSERT INTO pit.priv_feature_operation (
  SELECT fo.*
  FROM plant_insight.priv_feature_operation AS fo
    LEFT OUTER JOIN plant_insight.priv_feature AS f ON f.id = fo.feature_id
    LEFT OUTER JOIN plant_insight.priv_operation AS o ON o.id = fo.operation_id
  WHERE (f.company_id IS NULL OR f.company_id = 5886)
        AND (o.company_id IS NULL OR o.company_id = 5886)
);
INSERT INTO pit.priv_role_feature_operation (
  SELECT rfo.*
  FROM plant_insight.priv_role_feature_operation AS rfo
    LEFT OUTER JOIN plant_insight.priv_role AS r ON r.id = rfo.role_id
    LEFT OUTER JOIN plant_insight.priv_feature AS f ON f.id = rfo.feature_id
    LEFT OUTER JOIN plant_insight.priv_operation AS o ON o.id = rfo.operation_id
  WHERE r.company_id = 5886
        AND (o.company_id IS NULL OR o.company_id = 5886)
        AND (f.company_id IS NULL OR f.company_id = 5886)
);
INSERT INTO pit.user SELECT u.*
                     FROM plant_insight.user AS u
                       LEFT OUTER JOIN plant_insight.priv_role AS r ON r.id = u.role_id
                     WHERE r.company_id = 5886 AND u.company_id = 5886;
-- API Gateway
INSERT INTO pit.api_gateway_route SELECT r.*
                                  FROM plant_insight.api_gateway_route AS r
                                  WHERE r.id = 5886;
INSERT INTO pit.api_gateway_project_uri SELECT u.*
                                        FROM plant_insight.api_gateway_project_uri AS u
                                          LEFT OUTER JOIN plant_insight.api_gateway_route AS r ON r.id = u.route_id
                                        WHERE r.id = 5886;
-- shift and workgroup
INSERT INTO pit.shift SELECT s.*
                      FROM plant_insight.shift AS s
                      WHERE s.company_id = 5886;
INSERT INTO pit.work_group SELECT w.*
                           FROM plant_insight.work_group AS w
                           WHERE w.company_id = 5886;
INSERT INTO pit.shift_group SELECT sg.*
                            FROM plant_insight.shift_group AS sg
                              LEFT OUTER JOIN plant_insight.shift AS s ON s.id = sg.shift_id
                              LEFT OUTER JOIN plant_insight.work_group AS w ON w.id = sg.group_id
                            WHERE s.company_id = 5886 AND w.company_id = 5886;
-- gateway / device / indicator
-- gateway有triggers
INSERT INTO pit.gateway SELECT g.*
                        FROM plant_insight.gateway AS g
                        WHERE g.company_id = 5886;
INSERT INTO pit.section SELECT s.*
                        FROM plant_insight.section AS s
                        WHERE s.company_id = 5886;
INSERT INTO pit.production_line SELECT p.*
                                FROM plant_insight.production_line AS p
                                WHERE p.company_id = 5886;
INSERT INTO pit.tag SELECT t.*
                    FROM plant_insight.tag AS t
                    WHERE t.company_id = 5886;
INSERT INTO pit.device SELECT d.*
                       FROM plant_insight.device AS d
                       WHERE d.company_id = 5886;
INSERT INTO pit.section_device SELECT sd.*
                               FROM plant_insight.section_device AS sd
                                 LEFT OUTER JOIN plant_insight.section AS s ON s.id = sd.section_id
                                 LEFT OUTER JOIN plant_insight.device AS d ON d.id = sd.device_id
                               WHERE s.company_id = 5886 AND d.company_id = 5886;
INSERT INTO pit.device_tag SELECT t.*
                           FROM plant_insight.device_tag AS t
                             LEFT OUTER JOIN plant_insight.device AS d ON d.id = t.device_id
                           WHERE d.company_id = 5886;
INSERT INTO pit.device_log SELECT l.*
                           FROM plant_insight.device_log AS l
                             LEFT OUTER JOIN plant_insight.device AS d ON d.id = l.device_id
                           WHERE d.company_id = 5886;
INSERT INTO pit.indicator SELECT i.*
                          FROM plant_insight.indicator AS i
                            LEFT OUTER JOIN plant_insight.device AS d ON d.id = i.device_id
                          WHERE d.company_id = 5886;
INSERT INTO pit.indicator_tag SELECT it.*
                              FROM plant_insight.indicator_tag AS it
                                LEFT OUTER JOIN plant_insight.indicator AS i ON i.id = it.indicator_id
                                LEFT OUTER JOIN plant_insight.device AS d ON d.id = i.device_id
                                LEFT OUTER JOIN plant_insight.tag AS t ON t.id = it.tag_id
                              WHERE d.company_id = 5886 AND t.company_id = 5886;
INSERT INTO pit.craft_config SELECT cc.*
                             FROM plant_insight.craft_config AS cc
                               LEFT OUTER JOIN plant_insight.section AS s ON s.id = cc.section_id
                               LEFT OUTER JOIN plant_insight.device AS d ON d.id = cc.device_id
                             WHERE s.company_id = 5886 AND d.company_id = 5886;
INSERT INTO pit.ideal_process_period SELECT p.*
                                     FROM plant_insight.ideal_process_period AS p
                                       LEFT OUTER JOIN plant_insight.section AS s ON s.id = p.section_id
                                       LEFT OUTER JOIN plant_insight.device AS d ON d.id = p.device_id
                                     WHERE s.company_id = 5886 OR d.company_id = 5886;
-- rule / exception / notification
INSERT INTO pit.rule SELECT r.*
                     FROM plant_insight.rule AS r
                       LEFT OUTER JOIN plant_insight.company AS c ON c.id = r.company_id
                       LEFT OUTER JOIN plant_insight.device AS d ON d.id = r.device_id
                     WHERE r.company_id = 5886 AND d.company_id = 5886;
INSERT INTO pit.rule_condition SELECT rc.*
                               FROM plant_insight.rule_condition AS rc
                                 LEFT OUTER JOIN plant_insight.rule AS r ON r.id = rc.rule_id
                                 LEFT OUTER JOIN plant_insight.company AS c ON c.id = r.company_id
                                 LEFT OUTER JOIN plant_insight.device AS d ON d.id = r.device_id
                               WHERE r.company_id = 5886 AND d.company_id = 5886;
INSERT INTO pit.device_fixed_exception SELECT dfe.*
                                       FROM plant_insight.device_fixed_exception AS dfe
                                         LEFT OUTER JOIN plant_insight.company AS c ON c.id = dfe.company_id
                                         LEFT OUTER JOIN plant_insight.device AS d ON d.id = dfe.device_id
                                         LEFT OUTER JOIN plant_insight.user AS u ON u.id = dfe.operator_id
                                       WHERE dfe.company_id = 5886 AND d.company_id = 5886;
INSERT INTO pit.indicator_exception SELECT ie.*
                                    FROM plant_insight.indicator_exception AS ie
                                      LEFT OUTER JOIN plant_insight.device_fixed_exception AS dfe
                                        ON dfe.id = ie.fixed_id
                                      LEFT OUTER JOIN plant_insight.rule_condition AS rc ON rc.id = ie.condition_id
                                      LEFT OUTER JOIN plant_insight.rule AS r ON r.id = rc.rule_id
                                    WHERE r.company_id = 5886 AND dfe.company_id = 5886;
INSERT INTO pit.notification SELECT n.*
                             FROM plant_insight.notification AS n
                               LEFT OUTER JOIN plant_insight.company AS c ON c.id = n.company_id
                             WHERE n.company_id = 5886;
-- maintenance
INSERT INTO pit.maintenance_group SELECT mg.*
                                  FROM plant_insight.maintenance_group AS mg
                                    LEFT OUTER JOIN plant_insight.company AS c ON c.id = mg.company_id
                                  WHERE mg.company_id = 5886;
INSERT INTO pit.maintenance SELECT m.*
                            FROM plant_insight.maintenance AS m
                              LEFT OUTER JOIN plant_insight.company AS c ON c.id = m.company_id
                            WHERE m.company_id = 5886;
INSERT INTO pit.maintenance_record SELECT mr.*
                                   FROM plant_insight.maintenance_record AS mr
                                     LEFT OUTER JOIN plant_insight.maintenance AS m ON m.id = mr.maintenance_id
                                     LEFT OUTER JOIN plant_insight.company AS c ON c.id = m.company_id
                                   WHERE m.company_id = 5886
                                   ORDER BY mr.create_time;
-- data_provider
INSERT INTO pit.data_provider SELECT dp.*
                              FROM plant_insight.data_provider AS dp
                                LEFT OUTER JOIN plant_insight.company AS c ON c.id = dp.company_id
                              WHERE dp.company_id = 5886;
INSERT INTO pit.data_provider_indicator SELECT dpi.*
                                        FROM plant_insight.data_provider_indicator AS dpi
                                          LEFT OUTER JOIN plant_insight.data_provider AS dp
                                            ON dp.id = dpi.data_provider_id
                                          LEFT OUTER JOIN plant_insight.company AS c ON c.id = dp.company_id
                                        WHERE dp.company_id = 5886;
INSERT INTO pit.data_provider_reference SELECT dpr.*
                                        FROM plant_insight.data_provider_reference AS dpr
                                          LEFT OUTER JOIN plant_insight.data_provider AS dp
                                            ON dp.id = dpr.data_provider_id
                                          LEFT OUTER JOIN plant_insight.company AS c ON c.id = dp.company_id
                                        WHERE dp.company_id = 5886;
INSERT INTO pit.data_provider_formula SELECT dpf.*
                                      FROM plant_insight.data_provider_formula AS dpf
                                        LEFT OUTER JOIN plant_insight.data_provider AS dp
                                          ON dp.id = dpf.data_provider_id
                                        LEFT OUTER JOIN plant_insight.company AS c ON c.id = dp.company_id
                                      WHERE dp.company_id = 5886;
INSERT INTO pit.device_failure_record SELECT dfr.*
                                      FROM plant_insight.device_failure_record AS dfr
                                        LEFT OUTER JOIN plant_insight.device AS d ON d.id = dfr.device_id
                                        LEFT OUTER JOIN plant_insight.company AS c ON c.id = d.company_id
                                      WHERE d.company_id = 5886;
INSERT INTO pit.scheduled_downtime SELECT sd.*
                                   FROM plant_insight.scheduled_downtime AS sd
                                     LEFT OUTER JOIN plant_insight.company AS c ON c.id = sd.company_id
                                   WHERE sd.company_id = 5886;
INSERT INTO pit.work_day_record SELECT wdr.*
                                FROM plant_insight.work_day_record AS wdr
                                  LEFT OUTER JOIN plant_insight.data_provider AS dp ON dp.id = wdr.data_provider_id
                                  LEFT OUTER JOIN plant_insight.company AS c ON c.id = dp.company_id
                                WHERE dp.company_id = 5886;
INSERT INTO pit.work_day_shift_spec_record SELECT wdrsr.*
                                           FROM plant_insight.work_day_shift_spec_record AS wdrsr
                                             LEFT OUTER JOIN plant_insight.data_provider AS dp
                                               ON dp.id = wdrsr.data_provider_id
                                             LEFT OUTER JOIN plant_insight.company AS c ON c.id = dp.company_id
                                           WHERE dp.company_id = 5886;
-- etc
INSERT INTO pit.sku SELECT s.*
                    FROM plant_insight.sku AS s
                      LEFT OUTER JOIN plant_insight.company AS c ON c.id = s.company_id
                    WHERE s.company_id = 5886;
INSERT INTO pit.sku_process SELECT sp.*
                            FROM plant_insight.sku_process AS sp
                              LEFT OUTER JOIN plant_insight.sku AS s ON s.id = sp.sku_id
                              LEFT OUTER JOIN plant_insight.company AS c ON c.id = s.company_id
                            WHERE s.company_id = 5886;
INSERT INTO pit.theoretical_capacity SELECT tc.*
                                     FROM plant_insight.theoretical_capacity AS tc
                                       LEFT OUTER JOIN plant_insight.company AS c ON c.id = tc.company_id
                                     WHERE tc.company_id = 5886;
INSERT INTO pit.web_camera SELECT wc.*
                           FROM plant_insight.web_camera AS wc
                             LEFT OUTER JOIN plant_insight.company AS c ON c.id = wc.company_id
                           WHERE wc.company_id = 5886;
INSERT INTO pit.realtime_data SELECT rd.*
                              FROM plant_insight.realtime_data AS rd
                                LEFT OUTER JOIN plant_insight.device AS d ON d.id = rd.device_id
                              WHERE d.company_id = 5886;
INSERT INTO pit.specification_process_record SELECT spr.*
                                             FROM plant_insight.specification_process_record AS spr
                                               LEFT OUTER JOIN plant_insight.device AS d ON d.id = spr.device_id
                                             WHERE d.company_id = 5886;
INSERT INTO pit.specification_source SELECT ss.*
                                     FROM plant_insight.specification_source AS ss
                                       LEFT OUTER JOIN plant_insight.company AS c ON c.id = ss.company_id
                                     WHERE ss.company_id = 5886;
INSERT INTO pit.runtime_data SELECT rd.*
                             FROM plant_insight.runtime_data AS rd
                               LEFT OUTER JOIN plant_insight.indicator AS i ON i.id = rd.indicator_id
                               LEFT OUTER JOIN plant_insight.device AS d ON d.id = i.device_id
                             WHERE d.company_id = 5886;
-- stat_config
INSERT INTO pit.stat_category SELECT sc.*
                              FROM plant_insight.stat_category AS sc
                                LEFT OUTER JOIN plant_insight.company AS c ON c.id = sc.company_id
                              WHERE sc.company_id = 5886;
INSERT INTO pit.stat_category_detail SELECT scd.*
                                     FROM plant_insight.stat_category_detail AS scd
                                       LEFT OUTER JOIN plant_insight.stat_category AS sc ON sc.id = scd.stat_category_id
                                       LEFT OUTER JOIN plant_insight.company AS c ON c.id = sc.company_id
                                     WHERE sc.company_id = 5886;
INSERT INTO pit.stat_config SELECT sc.*
                            FROM plant_insight.stat_config AS sc
                              LEFT OUTER JOIN plant_insight.company AS c ON c.id = sc.company_id
                            WHERE sc.company_id = 5886;
INSERT INTO pit.stat_config_indicator_var SELECT sciv.*
                                          FROM plant_insight.stat_config_indicator_var AS sciv
                                            LEFT OUTER JOIN plant_insight.stat_config AS sc
                                              ON sc.id = sciv.stat_config_id
                                            LEFT OUTER JOIN plant_insight.company AS c ON c.id = sc.company_id
                                          WHERE sc.company_id = 5886;
INSERT INTO pit.stat_config_agg_var SELECT scav.*
                                    FROM plant_insight.stat_config_agg_var AS scav
                                      LEFT OUTER JOIN plant_insight.stat_config AS sc ON sc.id = scav.stat_config_id
                                      LEFT OUTER JOIN plant_insight.company AS c ON c.id = sc.company_id
                                    WHERE sc.company_id = 5886;
INSERT INTO pit.stat_config_rank SELECT scr.*
                                 FROM plant_insight.stat_config_rank AS scr
                                   LEFT OUTER JOIN plant_insight.stat_config AS sc ON sc.id = scr.stat_config_id
                                   LEFT OUTER JOIN plant_insight.company AS c ON c.id = sc.company_id
                                 WHERE sc.company_id = 5886;
INSERT INTO pit.daily_agg SELECT da.*
                          FROM plant_insight.daily_agg AS da
                            LEFT OUTER JOIN plant_insight.company AS c ON c.id = da.company_id
                          WHERE da.company_id = 5886;
INSERT INTO pit.statistics SELECT s.*
                           FROM plant_insight.statistics AS s
                             LEFT OUTER JOIN plant_insight.stat_config AS sc ON sc.id = s.indicator_config_id
                             LEFT OUTER JOIN plant_insight.company AS c ON c.id = sc.company_id
                           WHERE sc.company_id = 5886;
-- producer
INSERT INTO pit.producer SELECT p.*
                         FROM plant_insight.producer AS p
                           LEFT OUTER JOIN plant_insight.company AS c ON c.id = p.company_id
                         WHERE p.company_id = 5886;
INSERT INTO pit.producer_data_provider SELECT pdp.*
                                       FROM plant_insight.producer_data_provider AS pdp
                                         LEFT OUTER JOIN plant_insight.producer AS p ON p.id = pdp.producer_id
                                         LEFT OUTER JOIN plant_insight.company AS c ON c.id = p.company_id
                                       WHERE p.company_id = 5886;
-- process
INSERT INTO pit.product_grade SELECT pg.*
                              FROM plant_insight.product_grade AS pg
                                LEFT OUTER JOIN plant_insight.company AS c ON c.id = pg.company_id
                              WHERE pg.company_id = 5886;
INSERT INTO pit.process SELECT pr.*
                        FROM plant_insight.process AS pr
                          LEFT OUTER JOIN plant_insight.producer AS p ON p.id = pr.producer_id
                          LEFT OUTER JOIN plant_insight.company AS c ON c.id = p.company_id
                        WHERE p.company_id = 5886;
INSERT INTO pit.process_tag SELECT pt.*
                            FROM plant_insight.process_tag AS pt
                              LEFT OUTER JOIN plant_insight.process AS pr ON pr.id = pt.process_id
                              LEFT OUTER JOIN plant_insight.producer AS p ON p.id = pr.producer_id
                              LEFT OUTER JOIN plant_insight.company AS c ON c.id = p.company_id
                            WHERE p.company_id = 5886;
INSERT INTO pit.process_craft SELECT pc.*
                              FROM plant_insight.process_craft AS pc
                                LEFT OUTER JOIN plant_insight.process AS pr ON pr.id = pc.process_id
                                LEFT OUTER JOIN plant_insight.producer AS p ON p.id = pr.producer_id
                                LEFT OUTER JOIN plant_insight.company AS c ON c.id = p.company_id
                              WHERE p.company_id = 5886;
INSERT INTO pit.process_production SELECT pp.*
                                   FROM plant_insight.process_production AS pp
                                     LEFT OUTER JOIN plant_insight.process AS pr ON pr.id = pp.process_id
                                     LEFT OUTER JOIN plant_insight.producer AS p ON p.id = pr.producer_id
                                     LEFT OUTER JOIN plant_insight.company AS c ON c.id = p.company_id
                                   WHERE p.company_id = 5886;
INSERT INTO pit.process_consumption SELECT pc.*
                                    FROM plant_insight.process_consumption AS pc
                                      LEFT OUTER JOIN plant_insight.process AS pr ON pr.id = pc.process_id
                                      LEFT OUTER JOIN plant_insight.producer AS p ON p.id = pr.producer_id
                                      LEFT OUTER JOIN plant_insight.company AS c ON c.id = p.company_id
                                    WHERE p.company_id = 5886;
