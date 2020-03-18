Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853C61898EB
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 11:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCRKIJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 06:08:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37706 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRKIJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 06:08:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id f16so10976566plj.4;
        Wed, 18 Mar 2020 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pIvA0oesXfA4T0Iz+rrGcY1FoQcleU40920J5Q/l79M=;
        b=YFE5B2T7Co1QYAx4+PGIDS8NR7Pup3Kq7+dp0xyYRKfmaRw2ymHwnrK9zGYA4G/eXL
         +UH4Hk3m/CrJn1OsgrrdqbDbEleek8uiuTcvYMUuzGILtxcoCrqvuF4uRhHgL1rq4elx
         Q46ZO8JD/Mw/GltinCGR1VZSUFHZdUKGBJB7OSZyaZZ55NkugJoi9OUg2bQQMvlrhkuG
         Bj33Wpm+Ne5PIGFrrcUq/t5TGZxh+kyXU7xma25sVeU/br8ftOffIR8BP9JhZHq1UCDs
         Up+jQwwNIAa5nLUnIG40i3ciNfX9vuFBWbUzJbs+apscdOTnsa2s+tEKhBLIB2xvnPl6
         QavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pIvA0oesXfA4T0Iz+rrGcY1FoQcleU40920J5Q/l79M=;
        b=n9hR6Qrsn2OOZxxoUdt2ZAvYNyNyIWQb1wstGqPWrytsCMUzUEcF9EoXfFXalj341E
         yYa0yOM7v7uTU5KjccBSu6Wx/5EGiaa5sUxZXs71nu8lusgjwDgHKKA27cdqF1q6Duf8
         jnFwfh7F4YaITJ/nvoMmw2NNJfqQxI1X6RWtnEsTrw2lqOXpmB+Rg15rifRlgyUFNDma
         5swXH7LXfpNHUGU1e6/N9Tj8Nir5eYefp91X0hg50gDzhB2YRk4M9CBcoEk3ue96G/39
         JK1tMYtN99ZWtwXyb8qPQv7mD5Rkk/0WYQrTJcg00TRhP0XhI9R58SEddWzmjZu5Ihjt
         2nSw==
X-Gm-Message-State: ANhLgQ1FQx1pqS9h6yUZh0+25C+9aVkXf00S2u4OCPPWoJvFpLVSM5RF
        TwvYTDMu+A9Tir2SGL5uEhHpr1qH
X-Google-Smtp-Source: ADFU+vsInvAoOo1ffPR2KfqqgywprzsAZwIMZQynJiOUG5npfvIvl5DuB6ovInauebQBjU4ecMidew==
X-Received: by 2002:a17:902:ac85:: with SMTP id h5mr3005096plr.76.1584526087081;
        Wed, 18 Mar 2020 03:08:07 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6086:470e:bc8d:c185:c429:a95b])
        by smtp.gmail.com with ESMTPSA id g75sm1919565pje.37.2020.03.18.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 03:08:06 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: iio: Drop unnecessary explicit casting
Date:   Wed, 18 Mar 2020 15:37:54 +0530
Message-Id: <20200318100754.25667-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide correct specifiers while printing error logs to discard the use
of unnecessary explicit casting.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Based on previous conversations which can be found here [1].

[1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
---
 drivers/iio/accel/kxsd9-i2c.c              | 4 ++--
 drivers/iio/gyro/bmg160_i2c.c              | 4 ++--
 drivers/iio/gyro/bmg160_spi.c              | 4 ++--
 drivers/iio/gyro/mpu3050-i2c.c             | 4 ++--
 drivers/iio/imu/bmi160/bmi160_i2c.c        | 4 ++--
 drivers/iio/imu/bmi160/bmi160_spi.c        | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 4 ++--
 drivers/iio/magnetometer/bmc150_magn_spi.c | 4 ++--
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 38411e1c155b..6a2fb2e84170 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
 
 	regmap = devm_regmap_init_i2c(i2c, &config);
 	if (IS_ERR(regmap)) {
-		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&i2c->dev, "Failed to register i2c regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 4fc9c6a3321f..abb11855e1b2 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -21,8 +21,8 @@ static int bmg160_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
index 182a59c42507..104f1bac7805 100644
--- a/drivers/iio/gyro/bmg160_spi.c
+++ b/drivers/iio/gyro/bmg160_spi.c
@@ -19,8 +19,8 @@ static int bmg160_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &bmg160_regmap_spi_conf);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index afa8018b9238..9de9ca295742 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -51,8 +51,8 @@ static int mpu3050_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &mpu3050_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index e36f5e82d400..6179d60d3968 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -24,8 +24,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &bmi160_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index c19e3df35559..38fc4d124cc0 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -20,8 +20,8 @@ static int bmi160_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &bmi160_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 6993d3b87bb0..90f1f4c79605 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -122,8 +122,8 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	regmap = devm_regmap_init_i2c(client, &inv_mpu_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 673b198e6368..7ee275547531 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -53,8 +53,8 @@ static int inv_mpu_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
index ed9be0490d77..f4afad0c44cc 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -22,8 +22,8 @@ static int bmc150_magn_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &bmc150_magn_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
-			(int)PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
+			PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 	return bmc150_magn_probe(&spi->dev, regmap, spi->irq, id->name);
-- 
2.20.1

