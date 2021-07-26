Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB403D53AE
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 09:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhGZGdp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 02:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhGZGdm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 02:33:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD40C0613C1
        for <linux-iio@vger.kernel.org>; Mon, 26 Jul 2021 00:14:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hp25so14786170ejc.11
        for <linux-iio@vger.kernel.org>; Mon, 26 Jul 2021 00:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4/XYGihFb5hT4wAmJdadhbqjEBIxLi+TBj3rh8JL8M=;
        b=nuih+baGKg+SoWhklk/Uk6IpF9+ZK57V/lYH6f1FHKgOenPYuJ/rbvUIjkAh7j7HRk
         PQTcJ1MDWpXUWjpEeaSZ6FfbIVkjRSIh3sqDNmC7uuEur5hsAkc4EhPDOZny0RK4jfUN
         l/9Qcpr73liqvj2haBo2/H7ocl8pqEZrFbn+r+qieVgex1Z69heNYl6fhHJU9LyV+zky
         1JdVhpjexxRVtWMCffn6xGiJG7KkdE58CHu/VBJgVyYJAUrekbD8WFOprirXOQOfHtY0
         e6BiOH6LxoVsd1C+3NSuSRyRtsoZ7O7sICgriuhqRj0pNaLPVgYhX4s63CpHYl6x3wP4
         O8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4/XYGihFb5hT4wAmJdadhbqjEBIxLi+TBj3rh8JL8M=;
        b=qAvo02/uCdPdBXORm+QO4rb+4+mdRVAcXysvb+N97wwt0MnQq1oHwLXPQaRtcaCmY4
         1SRhCglbATuPgYzVZVhK8O/uA+lVmVSbMUTN6fuTUBMhgtmEygA2lc1wKagpptTRJGgM
         d1y0s+rmSsPY0ytuVdD4ZoOl6YSJujJ973PyGRCVuhZYs5Cf13ZLvFVzbRFvRtKqXBeQ
         G9gU9JPTVOcMlULeSLrdIkF9b5ZYE7k0R57GwUSRnacAXuwY2vrlCaLH7U1Q+AtLgXfm
         XqkHPY18KLhZL4aiNqhIUKE4w3o79l6HjWEhWCaenizhHXvimadOifGfZTUmEcRC8vXk
         SuhQ==
X-Gm-Message-State: AOAM532iTQpxPusu5bfsN12J+ME9R1QU0esqZiYeXXD9UVenK8I2+dDf
        u+Nbn1EtALUYNafK1t8XP/L5UqzZ+JnrJ/aFKBU=
X-Google-Smtp-Source: ABdhPJzTNrwMOgxprCRSpb7PRFEPxbp/se+zNaXre4Mq/ASbILCc2HUgnKbWrvG6PxhSwlxcnfqVmw==
X-Received: by 2002:a17:906:180a:: with SMTP id v10mr15439218eje.112.1627283649493;
        Mon, 26 Jul 2021 00:14:09 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id v13sm13863772ejh.62.2021.07.26.00.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 00:14:09 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 2/4] iio: st_sensors: remove st_sensors_power_disable() function
Date:   Mon, 26 Jul 2021 10:14:02 +0300
Message-Id: <20210726071404.14529-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210726071404.14529-1-aardelean@deviqon.com>
References: <20210726071404.14529-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the st_sensors_power_enable() function to use
devm_add_action_or_reset() handlers to register regulator_disable hooks for
when the drivers get unloaded.

The parent device of the IIO device object is used. This is based on the
assumption that all other devm_ calls in the ST sensors use this reference.

This makes the st_sensors_power_disable() un-needed.
Removing this also changes unload order a bit, as all ST drivers would call
st_sensors_power_disable() first and iio_device_unregister() after that.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/st_accel_i2c.c              | 13 +------
 drivers/iio/accel/st_accel_spi.c              | 13 +------
 .../iio/common/st_sensors/st_sensors_core.c   | 34 ++++++++-----------
 drivers/iio/gyro/st_gyro_i2c.c                | 13 +------
 drivers/iio/gyro/st_gyro_spi.c                | 13 +------
 drivers/iio/magnetometer/st_magn_i2c.c        | 13 +------
 drivers/iio/magnetometer/st_magn_spi.c        | 13 +------
 drivers/iio/pressure/st_pressure_i2c.c        | 13 +------
 drivers/iio/pressure/st_pressure_spi.c        | 13 +------
 include/linux/iio/common/st_sensors.h         |  2 --
 10 files changed, 23 insertions(+), 117 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index f711756e41e3..b377575efc41 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -177,24 +177,13 @@ static int st_accel_i2c_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = st_accel_common_probe(indio_dev);
-	if (ret < 0)
-		goto st_accel_power_off;
-
-	return 0;
-
-st_accel_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return ret;
+	return st_accel_common_probe(indio_dev);
 }
 
 static int st_accel_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_accel_common_remove(indio_dev);
 
 	return 0;
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index bb45d9ff95b8..4ca87e73bdb3 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -127,24 +127,13 @@ static int st_accel_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_accel_common_probe(indio_dev);
-	if (err < 0)
-		goto st_accel_power_off;
-
-	return 0;
-
-st_accel_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_accel_common_probe(indio_dev);
 }
 
 static int st_accel_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_accel_common_remove(indio_dev);
 
 	return 0;
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 0bbb090b108c..a5a140de9a23 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -215,13 +215,19 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
 }
 EXPORT_SYMBOL(st_sensors_set_axis_enable);
 
+static void st_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 int st_sensors_power_enable(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *pdata = iio_priv(indio_dev);
+	struct device *parent = indio_dev->dev.parent;
 	int err;
 
 	/* Regulators not mandatory, but if requested we should enable them. */
-	pdata->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
+	pdata->vdd = devm_regulator_get(parent, "vdd");
 	if (IS_ERR(pdata->vdd)) {
 		dev_err(&indio_dev->dev, "unable to get Vdd supply\n");
 		return PTR_ERR(pdata->vdd);
@@ -233,36 +239,26 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 		return err;
 	}
 
-	pdata->vdd_io = devm_regulator_get(indio_dev->dev.parent, "vddio");
+	err = devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd);
+	if (err)
+		return err;
+
+	pdata->vdd_io = devm_regulator_get(parent, "vddio");
 	if (IS_ERR(pdata->vdd_io)) {
 		dev_err(&indio_dev->dev, "unable to get Vdd_IO supply\n");
-		err = PTR_ERR(pdata->vdd_io);
-		goto st_sensors_disable_vdd;
+		return PTR_ERR(pdata->vdd_io);
 	}
 	err = regulator_enable(pdata->vdd_io);
 	if (err != 0) {
 		dev_warn(&indio_dev->dev,
 			 "Failed to enable specified Vdd_IO supply\n");
-		goto st_sensors_disable_vdd;
+		return err;
 	}
 
-	return 0;
-
-st_sensors_disable_vdd:
-	regulator_disable(pdata->vdd);
-	return err;
+	return devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd_io);
 }
 EXPORT_SYMBOL(st_sensors_power_enable);
 
-void st_sensors_power_disable(struct iio_dev *indio_dev)
-{
-	struct st_sensor_data *pdata = iio_priv(indio_dev);
-
-	regulator_disable(pdata->vdd);
-	regulator_disable(pdata->vdd_io);
-}
-EXPORT_SYMBOL(st_sensors_power_disable);
-
 static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 3ef86e16ee65..0bd80dfd389f 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -90,24 +90,13 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	err = st_gyro_common_probe(indio_dev);
-	if (err < 0)
-		goto st_gyro_power_off;
-
-	return 0;
-
-st_gyro_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_gyro_common_probe(indio_dev);
 }
 
 static int st_gyro_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_gyro_common_remove(indio_dev);
 
 	return 0;
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 41d835493347..f74b09fa5cde 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -94,24 +94,13 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_gyro_common_probe(indio_dev);
-	if (err < 0)
-		goto st_gyro_power_off;
-
-	return 0;
-
-st_gyro_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_gyro_common_probe(indio_dev);
 }
 
 static int st_gyro_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_gyro_common_remove(indio_dev);
 
 	return 0;
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 2dfe4ee99591..0a5117dffcf4 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -86,24 +86,13 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	err = st_magn_common_probe(indio_dev);
-	if (err < 0)
-		goto st_magn_power_off;
-
-	return 0;
-
-st_magn_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_magn_common_probe(indio_dev);
 }
 
 static int st_magn_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_magn_common_remove(indio_dev);
 
 	return 0;
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index fba978796395..1f3bf02b24e0 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -80,24 +80,13 @@ static int st_magn_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_magn_common_probe(indio_dev);
-	if (err < 0)
-		goto st_magn_power_off;
-
-	return 0;
-
-st_magn_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_magn_common_probe(indio_dev);
 }
 
 static int st_magn_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_magn_common_remove(indio_dev);
 
 	return 0;
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 52fa98f24478..afeeab485c0d 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -103,24 +103,13 @@ static int st_press_i2c_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = st_press_common_probe(indio_dev);
-	if (ret < 0)
-		goto st_press_power_off;
-
-	return 0;
-
-st_press_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return ret;
+	return st_press_common_probe(indio_dev);
 }
 
 static int st_press_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_press_common_remove(indio_dev);
 
 	return 0;
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index ee393df54cee..834ad6d40a70 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -86,24 +86,13 @@ static int st_press_spi_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	err = st_press_common_probe(indio_dev);
-	if (err < 0)
-		goto st_press_power_off;
-
-	return 0;
-
-st_press_power_off:
-	st_sensors_power_disable(indio_dev);
-
-	return err;
+	return st_press_common_probe(indio_dev);
 }
 
 static int st_press_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_press_common_remove(indio_dev);
 
 	return 0;
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index e74b55244f35..fc90c202d15e 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -293,8 +293,6 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
 
 int st_sensors_power_enable(struct iio_dev *indio_dev);
 
-void st_sensors_power_disable(struct iio_dev *indio_dev);
-
 int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
 				  unsigned reg, unsigned writeval,
 				  unsigned *readval);
-- 
2.31.1

