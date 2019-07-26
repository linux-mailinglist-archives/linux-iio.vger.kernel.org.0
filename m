Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2709376185
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 11:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfGZJIg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 05:08:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33781 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZJIg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 05:08:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so24213511pfq.0;
        Fri, 26 Jul 2019 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sl9ak2o2uQzwNPD5/4s22uTgucUrMMNJrOBG4XX3NNQ=;
        b=akcpUf2+qYcrl7GEwXjRMLmRnhSMBI0S28EtF1EBs4ISYZGuZYFYUL6MhDgnf80NBS
         JkXh2FWYcJOQD1B9VPLEeOnSNczCl8hw106N4ancPc0st6mmcW/0x4AVJYdTKR5EBejD
         Cp3dlHwaEV18ZtEtxa4lrlTq/l3Wz76dlZmUvnksq/r6WLlxsOv38/NM63KdZ/Lr5SdO
         yCh1igmU9qhoP/NGOkvJROUHo/NgPFm+3z6M/ckT8Dqw8Ya2aGvV2r0ZB7PTmJjuh7F+
         6M1h6pDK6h3YonjTikTwv0g8y/4S40R+bKAgxsTFLIUivMNH4x98DB3MXu1i6TPemQuY
         kRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sl9ak2o2uQzwNPD5/4s22uTgucUrMMNJrOBG4XX3NNQ=;
        b=DAXhhV2bF41pWQsgv1DFzoUGbFnWPC9yClvPKiB4+d1sXD0k8dPet5lFALbPfZ3TEy
         9ELTMONuLpomuA935F7oj9Bu+3WGDWqz54U/TNrAM1zau1qfeI/k1y6s6QOP96T599fR
         YmwCJSyivdhIJd2mW2X9ZcKlRTExBNls4gphaUX9xCf2yf7YYfti1aSZGB2GGooeQNk0
         qJAhmrPg37ro6tPjhHNHRQXy4e4wLpvohzSqPLxG56SmE24DRMoaMOM3uwsvz6ju8g20
         h77kQln4FZsqg4hu2n8Vhpvxvs2684cxEiXwIFpsWxvxyF6omg1CSpr5CSg8TK2L4EgF
         dJEg==
X-Gm-Message-State: APjAAAVi00Dz3BFJom+W9tp7tLO5+LJ6Sw9c8wz+11+7VWLvvx0/qsLt
        h9cUmHirYjrnDemTrS/jmQM=
X-Google-Smtp-Source: APXvYqzmH4ONSATgubzOLMnn8csvaEAeMHceOnU9JLK0FdSn4cekseMXU34W0DbTlt/Ieue3yuqqhA==
X-Received: by 2002:a65:65c5:: with SMTP id y5mr89541205pgv.342.1564132114939;
        Fri, 26 Jul 2019 02:08:34 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id z24sm93209667pfr.51.2019.07.26.02.08.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 02:08:34 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] iio: light: Use device-managed APIs
Date:   Fri, 26 Jul 2019 17:08:29 +0800
Message-Id: <20190726090829.16979-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device-managed APIs to simplify the code.
The remove functions are redundant now and can
be deleted.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/iio/light/cm3323.c | 31 ++++++++++-----------------
 drivers/iio/light/si1145.c | 44 ++++++++++++++------------------------
 2 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 50f3438c2b49..fd352c0a4507 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -101,15 +101,16 @@ static int cm3323_init(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static void cm3323_disable(struct iio_dev *indio_dev)
+static void cm3323_disable(void *data)
 {
 	int ret;
-	struct cm3323_data *data = iio_priv(indio_dev);
+	struct iio_dev *indio_dev = data;
+	struct cm3323_data *cm_data = iio_priv(indio_dev);
 
-	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
+	ret = i2c_smbus_write_word_data(cm_data->client, CM3323_CMD_CONF,
 					CM3323_CONF_SD_BIT);
 	if (ret < 0)
-		dev_err(&data->client->dev, "Error writing reg_conf\n");
+		dev_err(&cm_data->client->dev, "Error writing reg_conf\n");
 }
 
 static int cm3323_set_it_bits(struct cm3323_data *data, int val, int val2)
@@ -243,25 +244,16 @@ static int cm3323_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_add_action_or_reset(&client->dev, cm3323_disable, indio_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed to register iio dev\n");
-		goto err_init;
+		return ret;
 	}
 
-	return 0;
-err_init:
-	cm3323_disable(indio_dev);
-	return ret;
-}
-
-static int cm3323_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	cm3323_disable(indio_dev);
-
 	return 0;
 }
 
@@ -276,7 +268,6 @@ static struct i2c_driver cm3323_driver = {
 		.name = CM3323_DRV_NAME,
 	},
 	.probe		= cm3323_probe,
-	.remove		= cm3323_remove,
 	.id_table	= cm3323_id,
 };
 
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 6579d2418814..61867552b27c 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1271,13 +1271,14 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static void si1145_remove_trigger(struct iio_dev *indio_dev)
+static void si1145_remove_trigger(void *data)
 {
-	struct si1145_data *data = iio_priv(indio_dev);
+	struct iio_dev *indio_dev = data;
+	struct si1145_data *si_data = iio_priv(indio_dev);
 
-	if (data->trig) {
-		iio_trigger_unregister(data->trig);
-		data->trig = NULL;
+	if (si_data->trig) {
+		iio_trigger_unregister(si_data->trig);
+		si_data->trig = NULL;
 	}
 }
 
@@ -1332,7 +1333,8 @@ static int si1145_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(&client->dev,
+		indio_dev, NULL,
 		si1145_trigger_handler, &si1145_buffer_setup_ops);
 	if (ret < 0)
 		return ret;
@@ -1340,23 +1342,21 @@ static int si1145_probe(struct i2c_client *client,
 	if (client->irq) {
 		ret = si1145_probe_trigger(indio_dev);
 		if (ret < 0)
-			goto error_free_buffer;
+			return ret;
+
+		ret = devm_add_action_or_reset(&client->dev,
+					si1145_remove_trigger, indio_dev);
+		if (ret < 0)
+			return ret;
+
 	} else {
 		dev_info(&client->dev, "no irq, using polling\n");
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret < 0)
-		goto error_free_trigger;
+		return ret;
 
 	return 0;
-
-error_free_trigger:
-	si1145_remove_trigger(indio_dev);
-error_free_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
 }
 
 static const struct i2c_device_id si1145_ids[] = {
@@ -1371,23 +1371,11 @@ static const struct i2c_device_id si1145_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, si1145_ids);
 
-static int si1145_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	si1145_remove_trigger(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return 0;
-}
-
 static struct i2c_driver si1145_driver = {
 	.driver = {
 		.name   = "si1145",
 	},
 	.probe  = si1145_probe,
-	.remove = si1145_remove,
 	.id_table = si1145_ids,
 };
 
-- 
2.20.1

