Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A68381B0
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2019 01:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFFXPH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jun 2019 19:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfFFXPG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jun 2019 19:15:06 -0400
Received: from localhost.localdomain (unknown [151.66.15.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A7A820717;
        Thu,  6 Jun 2019 23:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559862905;
        bh=eN63Cxv37IQMvGAIkgiAA8HvAvDJYgGI1d0WNqRj+hA=;
        h=From:To:Cc:Subject:Date:From;
        b=td5p9gbL/5xQq9dptW5LUVk/H6NpfAonY2pzEsrKrHQpk3pgpc8gNr5uhQPd/DYiB
         UGU2xPekNwe/jBSSMhEL3/SjlZxxyoZPnFz29bsbk8S82uncrKGKzGeUzR5A7a1IIz
         MJsO03sXrGnG14rOPuO70iJ7Qh0z8boGUJyyzJ/4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Vitor.Soares@synopsys.com, boris.brezillon@collabora.com
Subject: [PATCH] iio: imu: st_lsm6dsx: get device name from st_lsm6dsx_dev_name
Date:   Fri,  7 Jun 2019 01:14:21 +0200
Message-Id: <2531966256f991d802a775d953656b92ae8216bd.1559862531.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce st_lsm6dsx_dev_name lookup table to get device name. This is
a preliminary patch to add I3C support to st_lsm6dsx since i3c_device_id
data structure does not contain a name field

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 16 +++++++++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  3 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  3 +--
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 004a8a1a0027..71627206fc30 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -302,7 +302,7 @@ struct st_lsm6dsx_hw {
 static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
 extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
 
-int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
+int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap);
 int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
 				 bool enable);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index cf82c9049945..339b75040732 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -70,6 +70,18 @@
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
+static const char st_lsm6dsx_dev_name[][32] = {
+	[ST_LSM6DS3_ID] = ST_LSM6DS3_DEV_NAME,
+	[ST_LSM6DS3H_ID] = ST_LSM6DS3H_DEV_NAME,
+	[ST_LSM6DSL_ID] = ST_LSM6DSL_DEV_NAME,
+	[ST_LSM6DSM_ID] = ST_LSM6DSM_DEV_NAME,
+	[ST_ISM330DLC_ID] = ST_ISM330DLC_DEV_NAME,
+	[ST_LSM6DSO_ID] = ST_LSM6DSO_DEV_NAME,
+	[ST_ASM330LHH_ID] = ST_ASM330LHH_DEV_NAME,
+	[ST_LSM6DSOX_ID] = ST_LSM6DSOX_DEV_NAME,
+	[ST_LSM6DSR_ID] = ST_LSM6DSR_DEV_NAME,
+};
+
 static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
 	[ST_LSM6DSX_ID_ACC] = {
 		.reg = {
@@ -1041,11 +1053,12 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	return iio_dev;
 }
 
-int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
+int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
 	const struct st_lsm6dsx_shub_settings *hub_settings;
 	struct st_lsm6dsx_hw *hw;
+	const char *name;
 	int i, err;
 
 	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
@@ -1070,6 +1083,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 	if (err < 0)
 		return err;
 
+	name = st_lsm6dsx_dev_name[hw_id];
 	for (i = 0; i < ST_LSM6DSX_ID_EXT0; i++) {
 		hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
 		if (!hw->iio_devs[i])
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index f54370196098..47581a4e456e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -36,8 +36,7 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *client,
 		return PTR_ERR(regmap);
 	}
 
-	return st_lsm6dsx_probe(&client->dev, client->irq,
-				hw_id, id->name, regmap);
+	return st_lsm6dsx_probe(&client->dev, client->irq, hw_id, regmap);
 }
 
 static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 4a4abb2935da..facf66978a4b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -36,8 +36,7 @@ static int st_lsm6dsx_spi_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return st_lsm6dsx_probe(&spi->dev, spi->irq,
-				hw_id, id->name, regmap);
+	return st_lsm6dsx_probe(&spi->dev, spi->irq, hw_id, regmap);
 }
 
 static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
-- 
2.21.0

