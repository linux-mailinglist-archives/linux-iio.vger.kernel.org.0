Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7A4A397E
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356289AbiA3UvC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40600 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347652AbiA3UvC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E50B2B829C0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC69BC340E4;
        Sun, 30 Jan 2022 20:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575859;
        bh=fBZZGWDZnXY28j2GH+qbYbXLdT2+n5b6835akUqwotQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSq42znAjVG/uf+B4JLX8CuHYa0WfjPA/LOV+Lo+tsTFjG11yPosrUjAWzzWUY4pP
         cBu0mtua5yyXsAVFIYtQF4KJm9Fn02raZArY6rbCaPM2ggNjqGmpQOiMdGmJ+skjyC
         fW1k3uwz0C1Wma3hJFqFE0o8F7b7riGsnsr/gqZf2qCeH/GJcn1BN/Yk0zV8DEp5T4
         /TLWY2C2DSamcVx9gd5DSmHfL2MdJa9dFmqktFQjMdxOZRlWeNO/hPCub6kP1jAdc/
         CTmBmfY9CQRB6+baht8kHvURM0l6tcFoAAWCBeWWWuHv+NRGooPFboofasuP4SfkQn
         eAi6WXUvUBbWA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        William Markezana <william.markezana@meas-spec.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
Subject: [PATCH 04/16] iio:common:meas-spec: Move exports into IIO_MEAS_SPEC_SENSORS
Date:   Sun, 30 Jan 2022 20:56:49 +0000
Message-Id: <20220130205701.334592-5-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130205701.334592-1-jic23@kernel.org>
References: <20220130205701.334592-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The obvious choice of ms_sensors felt rather too likely to clash with other
namespaces introduced in future, hence the longer abbreviation.

In order to avoid unnecessary pollution of the global symbol namespace
move the common/library functions into a specific namespace and import
that into the various specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: William Markezana <william.markezana@meas-spec.com>
Cc: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
---
 .../iio/common/ms_sensors/ms_sensors_i2c.c    | 24 +++++++++----------
 drivers/iio/humidity/htu21.c                  |  1 +
 drivers/iio/pressure/ms5637.c                 |  1 +
 drivers/iio/temperature/tsys01.c              |  1 +
 drivers/iio/temperature/tsys02d.c             |  1 +
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 3eb790aec4b2..6633b35a94e6 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -58,7 +58,7 @@ int ms_sensors_reset(void *cli, u8 cmd, unsigned int delay)
 
 	return 0;
 }
-EXPORT_SYMBOL(ms_sensors_reset);
+EXPORT_SYMBOL_NS(ms_sensors_reset, IIO_MEAS_SPEC_SENSORS);
 
 /**
  * ms_sensors_read_prom_word() - PROM word read function
@@ -84,7 +84,7 @@ int ms_sensors_read_prom_word(void *cli, int cmd, u16 *word)
 
 	return 0;
 }
-EXPORT_SYMBOL(ms_sensors_read_prom_word);
+EXPORT_SYMBOL_NS(ms_sensors_read_prom_word, IIO_MEAS_SPEC_SENSORS);
 
 /**
  * ms_sensors_convert_and_read() - ADC conversion & read function
@@ -130,7 +130,7 @@ int ms_sensors_convert_and_read(void *cli, u8 conv, u8 rd,
 	dev_err(&client->dev, "Unable to make sensor adc conversion\n");
 	return ret;
 }
-EXPORT_SYMBOL(ms_sensors_convert_and_read);
+EXPORT_SYMBOL_NS(ms_sensors_convert_and_read, IIO_MEAS_SPEC_SENSORS);
 
 /**
  * ms_sensors_crc_valid() - CRC check function
@@ -248,7 +248,7 @@ int ms_sensors_read_serial(struct i2c_client *client, u64 *sn)
 
 	return 0;
 }
-EXPORT_SYMBOL(ms_sensors_read_serial);
+EXPORT_SYMBOL_NS(ms_sensors_read_serial, IIO_MEAS_SPEC_SENSORS);
 
 static int ms_sensors_read_config_reg(struct i2c_client *client,
 				      u8 *config_reg)
@@ -299,7 +299,7 @@ ssize_t ms_sensors_write_resolution(struct ms_ht_dev *dev_data,
 					 MS_SENSORS_CONFIG_REG_WRITE,
 					 config_reg);
 }
-EXPORT_SYMBOL(ms_sensors_write_resolution);
+EXPORT_SYMBOL_NS(ms_sensors_write_resolution, IIO_MEAS_SPEC_SENSORS);
 
 /**
  * ms_sensors_show_battery_low() - Show device battery low indicator
@@ -326,7 +326,7 @@ ssize_t ms_sensors_show_battery_low(struct ms_ht_dev *dev_data,
 
 	return sysfs_emit(buf, "%d\n", (config_reg & 0x40) >> 6);
 }
-EXPORT_SYMBOL(ms_sensors_show_battery_low);
+EXPORT_SYMBOL_NS(ms_sensors_show_battery_low, IIO_MEAS_SPEC_SENSORS);
 
 /**
  * ms_sensors_show_heater() - Show device heater
@@ -353,7 +353,7 @@ ssize_t ms_sensors_show_heater(struct ms_ht_dev *dev_data,
 
 	return sysfs_emit(buf, "%d\n", (config_reg & 0x4) >> 2);
 }
-EXPORT_SYMBOL(ms_sensors_show_heater);
+EXPORT_SYMBOL_NS(ms_sensors_show_heater, IIO_MEAS_SPEC_SENSORS);
 
 /**
  * ms_sensors_write_heater() - Write device heater
@@ -401,7 +401,7 @@ ssize_t ms_sensors_write_heater(struct ms_ht_dev *dev_data,
 
 	return len;
 }
-EXPORT_SYMBOL(ms_sensors_write_heater);
+EXPORT_SYMBOL_NS(ms_sensors_write_heater, IIO_MEAS_SPEC_SENSORS);
 
 /**
  * ms_sensors_ht_read_temperature() - Read temperature
@@ -442,7 +442,7 @@ int ms_sensors_ht_read_temperature(struct ms_ht_dev *dev_data,
 
 	return 0;
 }
-EXPORT_SYMBOL(ms_sensors_ht_read_temperature);
+EXPORT_SYMBOL_NS(ms_sensors_ht_read_temperature, IIO_MEAS_SPEC_SENSORS);
 
 /**
  * ms_sensors_ht_read_humidity() - Read humidity
@@ -485,7 +485,7 @@ int ms_sensors_ht_read_humidity(struct ms_ht_dev *dev_data,
 
 	return 0;
 }
-EXPORT_SYMBOL(ms_sensors_ht_read_humidity);
+EXPORT_SYMBOL_NS(ms_sensors_ht_read_humidity, IIO_MEAS_SPEC_SENSORS);
 
 /**
  * ms_sensors_tp_crc4() - Calculate PROM CRC for
@@ -602,7 +602,7 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
 
 	return 0;
 }
-EXPORT_SYMBOL(ms_sensors_tp_read_prom);
+EXPORT_SYMBOL_NS(ms_sensors_tp_read_prom, IIO_MEAS_SPEC_SENSORS);
 
 /**
  * ms_sensors_read_temp_and_pressure() - read temp and pressure
@@ -688,7 +688,7 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
 
 	return 0;
 }
-EXPORT_SYMBOL(ms_sensors_read_temp_and_pressure);
+EXPORT_SYMBOL_NS(ms_sensors_read_temp_and_pressure, IIO_MEAS_SPEC_SENSORS);
 
 MODULE_DESCRIPTION("Measurement-Specialties common i2c driver");
 MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index 36df2a102ca4..fd9e2565f8a2 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -258,3 +258,4 @@ MODULE_DESCRIPTION("Measurement-Specialties htu21 temperature and humidity drive
 MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
 MODULE_AUTHOR("Ludovic Tancerel <ludovic.tancerel@maplehightech.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MEAS_SPEC_SENSORS);
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 81f683321b23..70c70019142a 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -252,3 +252,4 @@ MODULE_DESCRIPTION("Measurement-Specialties ms5637 temperature & pressure driver
 MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
 MODULE_AUTHOR("Ludovic Tancerel <ludovic.tancerel@maplehightech.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MEAS_SPEC_SENSORS);
diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index bbfbad9a8767..60d58ec5b063 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -233,3 +233,4 @@ MODULE_DESCRIPTION("Measurement-Specialties tsys01 temperature driver");
 MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
 MODULE_AUTHOR("Ludovic Tancerel <ludovic.tancerel@maplehightech.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MEAS_SPEC_SENSORS);
diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index fc96e5f9d3fc..49c275e4f510 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -187,3 +187,4 @@ MODULE_DESCRIPTION("Measurement-Specialties tsys02d temperature driver");
 MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
 MODULE_AUTHOR("Ludovic Tancerel <ludovic.tancerel@maplehightech.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MEAS_SPEC_SENSORS);
-- 
2.35.1

