Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A363ED04A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhHPIav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 04:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbhHPIar (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 04:30:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CFC0613CF
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:30:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w5so30289077ejq.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zwk2b+4K3DnEu81t0h2sa/3UYWtNHb7/ckQIg7vKAGA=;
        b=K40V9hr+K9eMVbkPbvFfQtdd0lUV2Uqv/V+UXACphJBLjO3L57l5C0LIqGkQRHmdf9
         +zIXVN0RvA5JjPGR1qbNIbjN9o4wUJP1mbj/G2eddJliWP69vPTe0J82AMKpxTi6kzoE
         tnfLeqXagNPJpzJW2/YRwmU7ck0lxZkKbpPfkj+L7kmcdY1xAvPo0hMo2YdvrHurC5cy
         6vBal1T6qfWFW+N8SH37dhk+LH0ecn7AdaRMn7Cd2z6RCbBwTlo1WcMCz0bNGDOQsW6O
         Q+KsZNBdxu0P7QvCrSXsA6Af7DVgSvYCdVO+tekL47CtAO30V/0mderljCxaGp4GlpQS
         gY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zwk2b+4K3DnEu81t0h2sa/3UYWtNHb7/ckQIg7vKAGA=;
        b=LTPl1WlroWXWYAHuR32eMVgqdBhxoI1RWPje78ke3wjVx7Jfj1xj+oJp1Ftk3lYUhT
         lcm9Xm7wciuofkwUItpPBhgk3X2/j/WDfDmfLZCxbIrG/k5rgZOjARGrLtU3HbuIyDLg
         Axqk0xBACudHHANtKhNZA4ljiA04Z/cIYgOydsBWFDu7CdNsJ0/leB7vDVz4tMjJTj9w
         LhSJ2R24UE5JMaP8yWG57UQgs812yhKgFmdxMjo5mtVnWEEKRHuWWsB+JTSPgyobEcw1
         XgxjDw/mWUOmYDipBJOwB1SNS2QCCPLKFzqW65xtmH6/rxClS3sHmMgqVuRD9hU6LPpn
         dHWw==
X-Gm-Message-State: AOAM533TJf+88GM757iqq0ulNyCagQUA+pR+ryvtV+kn41TE6KGPDB8C
        gL1DKxnrFT4wDRCtc5hQH9B17mDqCazQ6eQK
X-Google-Smtp-Source: ABdhPJzmj0l6865+1gSSFwIkz/EN9H7OPkNF6RdFPqDF9/QWv6QfGtg1Dghs5TprsbrpyKLCXf2VcA==
X-Received: by 2002:a17:907:35d0:: with SMTP id ap16mr14880423ejc.456.1629102614332;
        Mon, 16 Aug 2021 01:30:14 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id q30sm4516878edi.84.2021.08.16.01.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 01:30:14 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 5/5] iio: st_sensors: remove reference to parent device object on st_sensor_data
Date:   Mon, 16 Aug 2021 11:28:36 +0300
Message-Id: <20210816082836.67511-6-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816082836.67511-1-aardelean@deviqon.com>
References: <20210816082836.67511-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I'm not completely sure whether this change makes much sense.
The idea behind it, is that all devm_ calls in ST sensors are bound to the
parent device object.

However, the reference to that object is kept on both the st_sensor_data
struct and the IIO object parent (indio_dev->dev.parent).

This change only adds a bit consistency and uses the reference stored on
indio_dev->dev.parent, to enforce the assumption that all ST sensors' devm_
calls are bound to the same reference as the one store on st_sensor_data.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/st_accel_core.c                  | 7 ++++---
 drivers/iio/common/st_sensors/st_sensors_i2c.c     | 1 -
 drivers/iio/common/st_sensors/st_sensors_spi.c     | 1 -
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 8 +++++---
 drivers/iio/gyro/st_gyro_core.c                    | 2 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       | 2 --
 drivers/iio/magnetometer/st_magn_core.c            | 4 ++--
 drivers/iio/pressure/st_pressure_core.c            | 2 +-
 include/linux/iio/common/st_sensors.h              | 2 --
 9 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 01695abd9d2f..c2d2cbe0fa3b 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1186,6 +1186,7 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
  */
 static int apply_acpi_orientation(struct iio_dev *indio_dev)
 {
+	struct device *parent = indio_dev->dev.parent;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	struct acpi_device *adev;
@@ -1210,7 +1211,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 	};
 
 
-	adev = ACPI_COMPANION(adata->dev);
+	adev = ACPI_COMPANION(parent);
 	if (!adev)
 		return 0;
 
@@ -1334,8 +1335,8 @@ EXPORT_SYMBOL(st_accel_get_settings);
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
-	struct st_sensors_platform_data *pdata = dev_get_platdata(adata->dev);
 	struct device *parent = indio_dev->dev.parent;
+	struct st_sensors_platform_data *pdata = dev_get_platdata(parent);
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1355,7 +1356,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	 */
 	err = apply_acpi_orientation(indio_dev);
 	if (err) {
-		err = iio_read_mount_matrix(adata->dev, &adata->mount_matrix);
+		err = iio_read_mount_matrix(parent, &adata->mount_matrix);
 		if (err)
 			return err;
 	}
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index b3ff88700866..18bd3c3d99bc 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -57,7 +57,6 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
 
 	indio_dev->name = client->name;
 
-	sdata->dev = &client->dev;
 	sdata->irq = client->irq;
 
 	return 0;
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 0d1d66c77cd8..7c60050e90dc 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -109,7 +109,6 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
 
 	indio_dev->name = spi->modalias;
 
-	sdata->dev = &spi->dev;
 	sdata->irq = spi->irq;
 
 	return 0;
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index d022157b66a2..bb687d1bcbef 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -28,6 +28,7 @@
 static bool st_sensors_new_samples_available(struct iio_dev *indio_dev,
 					     struct st_sensor_data *sdata)
 {
+	struct device *parent = indio_dev->dev.parent;
 	int ret, status;
 
 	/* How would I know if I can't check it? */
@@ -42,7 +43,7 @@ static bool st_sensors_new_samples_available(struct iio_dev *indio_dev,
 			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
 			  &status);
 	if (ret < 0) {
-		dev_err(sdata->dev, "error checking samples available\n");
+		dev_err(parent, "error checking samples available\n");
 		return false;
 	}
 
@@ -75,6 +76,7 @@ static irqreturn_t st_sensors_irq_thread(int irq, void *p)
 	struct iio_trigger *trig = p;
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	struct device *parent = indio_dev->dev.parent;
 
 	/*
 	 * If this trigger is backed by a hardware interrupt and we have a
@@ -87,7 +89,7 @@ static irqreturn_t st_sensors_irq_thread(int irq, void *p)
 	    st_sensors_new_samples_available(indio_dev, sdata)) {
 		iio_trigger_poll_chained(p);
 	} else {
-		dev_dbg(sdata->dev, "spurious IRQ\n");
+		dev_dbg(parent, "spurious IRQ\n");
 		return IRQ_NONE;
 	}
 
@@ -107,7 +109,7 @@ static irqreturn_t st_sensors_irq_thread(int irq, void *p)
 	 */
 	while (sdata->hw_irq_trigger &&
 	       st_sensors_new_samples_available(indio_dev, sdata)) {
-		dev_dbg(sdata->dev, "more samples came in during polling\n");
+		dev_dbg(parent, "more samples came in during polling\n");
 		sdata->hw_timestamp = iio_get_time_ns(indio_dev);
 		iio_trigger_poll_chained(p);
 	}
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 3609082a6778..201050b76fe5 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -492,7 +492,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 	indio_dev->channels = gdata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
-	err = iio_read_mount_matrix(gdata->dev, &gdata->mount_matrix);
+	err = iio_read_mount_matrix(parent, &gdata->mount_matrix);
 	if (err)
 		return err;
 
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
index d276f663fe57..b3a43a3b04ff 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -90,7 +90,6 @@ static int st_lsm9ds0_probe_accel(struct st_lsm9ds0 *lsm9ds0, struct regmap *reg
 
 	data = iio_priv(lsm9ds0->accel);
 	data->sensor_settings = (struct st_sensor_settings *)settings;
-	data->dev = dev;
 	data->irq = lsm9ds0->irq;
 	data->regmap = regmap;
 	data->vdd = lsm9ds0->vdd;
@@ -119,7 +118,6 @@ static int st_lsm9ds0_probe_magn(struct st_lsm9ds0 *lsm9ds0, struct regmap *regm
 
 	data = iio_priv(lsm9ds0->magn);
 	data->sensor_settings = (struct st_sensor_settings *)settings;
-	data->dev = dev;
 	data->irq = lsm9ds0->irq;
 	data->regmap = regmap;
 	data->vdd = lsm9ds0->vdd;
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 1458906a3765..0806a1e65ce4 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -611,8 +611,8 @@ EXPORT_SYMBOL(st_magn_get_settings);
 int st_magn_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
-	struct st_sensors_platform_data *pdata = dev_get_platdata(mdata->dev);
 	struct device *parent = indio_dev->dev.parent;
+	struct st_sensors_platform_data *pdata = dev_get_platdata(parent);
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -626,7 +626,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	indio_dev->channels = mdata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
-	err = iio_read_mount_matrix(mdata->dev, &mdata->mount_matrix);
+	err = iio_read_mount_matrix(parent, &mdata->mount_matrix);
 	if (err)
 		return err;
 
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index cebcc1d93d0b..26a1ee43d56e 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -677,8 +677,8 @@ EXPORT_SYMBOL(st_press_get_settings);
 int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
-	struct st_sensors_platform_data *pdata = dev_get_platdata(press_data->dev);
 	struct device *parent = indio_dev->dev.parent;
+	struct st_sensors_platform_data *pdata = dev_get_platdata(parent);
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index d17ae1e5ca19..22f67845cdd3 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -220,7 +220,6 @@ struct st_sensor_settings {
 
 /**
  * struct st_sensor_data - ST sensor device status
- * @dev: Pointer to instance of struct device (I2C or SPI).
  * @trig: The trigger in use by the core driver.
  * @mount_matrix: The mounting matrix of the sensor.
  * @sensor_settings: Pointer to the specific sensor settings in use.
@@ -240,7 +239,6 @@ struct st_sensor_settings {
  * @buffer_data: Data used by buffer part.
  */
 struct st_sensor_data {
-	struct device *dev;
 	struct iio_trigger *trig;
 	struct iio_mount_matrix mount_matrix;
 	struct st_sensor_settings *sensor_settings;
-- 
2.31.1

