Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7392099767
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2019 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfHVOwu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Aug 2019 10:52:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32778 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387623AbfHVOwu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2019 10:52:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id z17so5875641ljz.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2019 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZtWECTNP0SpeKpokgS4hSv0zrDdj9vGgc/n+zSkJ5E=;
        b=TWQybw93bVP/Z8uEUgrQC4M/JcbuVYfGtWiFQ43sUXX1B5LE4JU0bUkc2DjNzov1UI
         6OWLjcvx0G/WT3b6nzVt+WX6dmW3guyljvJtWcwy1Qhbew2NSfn5Zb0frR0VTYQJsCyC
         etxF7k8vALK4LDwU3fIWv2RMNjEp0ye1+2IeSWQrYcNHbdCWoLBVDleNyJBes0ZvYihW
         SkOjFotdexJ/peUAOq398+3xBOBUMCQ7HsQ7Xol4mmTA5ZLcDI5FQSJ0s5YQ0ExemBxf
         OcY+Zzpa5B5cUN9UcQF/DRgNzuztFveQlRRJj7y4izCx3aKZSB0HW0rlr0KYAvEc98Ok
         bCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZtWECTNP0SpeKpokgS4hSv0zrDdj9vGgc/n+zSkJ5E=;
        b=E/36EeErV+gSg+q5GXHbwJWxnrldBR/H+R+1ZDhWqa4KwRwJEU/xoA9x8dHCeSwOg/
         bn94Tjik0oh8W1BXx4KgazgLPLEADOmtzpvj7afxoZnRMl0oJg0HnpvDywy4R90bLExU
         H48QcaznC70kOYtqBz+msT1at1AiUh2J2hEFqXhJuKErQB2ldmr40f+N/I0mFBqttQh5
         RAWfD4VvfvINuzPtbWLFinjLuRMMDcWW4Z2rq/fa2+AdCEMQ4FqQtXtKcazTb0mjNKn/
         4JZA2thiFY+e7Y1lY6SRRv7w06hO8cUVqOPEGsLW6guUHvpIgK/lpp3RaCKF+tLDzYKB
         KTjw==
X-Gm-Message-State: APjAAAXEgEMR5hEvew6Sp1tc7iQwvDwVlMvfkArOcD/ik4FPSxB+eD8F
        LA9BTKeKlJF2o630jsrw8sRVQg==
X-Google-Smtp-Source: APXvYqxyPXeNXnm1tYWjUdmGf+q8TSEa0cAVFoXyyeMJj+T2XO510v8aZSlVbU11A5+F+CE8jjZH/Q==
X-Received: by 2002:a2e:29cb:: with SMTP id p72mr22263992ljp.31.1566485567176;
        Thu, 22 Aug 2019 07:52:47 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id s3sm3959374ljj.85.2019.08.22.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:52:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/8 v2] hwmon: ab8500: convert to IIO ADC
Date:   Thu, 22 Aug 2019 16:52:29 +0200
Message-Id: <20190822145233.18222-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822145233.18222-1-linus.walleij@linaro.org>
References: <20190822145233.18222-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the AB8500 hardware monitor driver to using
the standard IIO ADC channel lookup and conversion routines.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Collected ACKs.
- Rebased on v5.3-rc5
- Add a Kconfig dependency on IIO
- Fix some whitespace issues

This should not be applied to the hwmon tree right now, it
will be applied along with the other changes in ARM SoC.
---
 drivers/hwmon/Kconfig  |  3 +-
 drivers/hwmon/ab8500.c | 65 ++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 650dd71f9724..2e7badf7cf17 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -40,7 +40,8 @@ comment "Native drivers"
 
 config SENSORS_AB8500
 	tristate "AB8500 thermal monitoring"
-	depends on AB8500_GPADC && AB8500_BM
+	depends on AB8500_GPADC && AB8500_BM && IIO
+	default n
 	help
 	  If you say yes here you get support for the thermal sensor part
 	  of the AB8500 chip. The driver includes thermal management for
diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
index 207f77f85a40..53f3379d799d 100644
--- a/drivers/hwmon/ab8500.c
+++ b/drivers/hwmon/ab8500.c
@@ -17,20 +17,24 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500-bm.h>
-#include <linux/mfd/abx500/ab8500-gpadc.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power/ab8500.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/iio/consumer.h>
 #include "abx500.h"
 
 #define DEFAULT_POWER_OFF_DELAY	(HZ * 10)
 #define THERMAL_VCC		1800
 #define PULL_UP_RESISTOR	47000
-/* Number of monitored sensors should not greater than NUM_SENSORS */
-#define NUM_MONITORED_SENSORS	4
+
+#define AB8500_SENSOR_AUX1		0
+#define AB8500_SENSOR_AUX2		1
+#define AB8500_SENSOR_BTEMP_BALL	2
+#define AB8500_SENSOR_BAT_CTRL		3
+#define NUM_MONITORED_SENSORS		4
 
 struct ab8500_gpadc_cfg {
 	const struct abx500_res_to_temp *temp_tbl;
@@ -40,7 +44,8 @@ struct ab8500_gpadc_cfg {
 };
 
 struct ab8500_temp {
-	struct ab8500_gpadc *gpadc;
+	struct iio_channel *aux1;
+	struct iio_channel *aux2;
 	struct ab8500_btemp *btemp;
 	struct delayed_work power_off_work;
 	struct ab8500_gpadc_cfg cfg;
@@ -82,15 +87,21 @@ static int ab8500_read_sensor(struct abx500_temp *data, u8 sensor, int *temp)
 	int voltage, ret;
 	struct ab8500_temp *ab8500_data = data->plat_data;
 
-	if (sensor == BAT_CTRL) {
-		*temp = ab8500_btemp_get_batctrl_temp(ab8500_data->btemp);
-	} else if (sensor == BTEMP_BALL) {
+	if (sensor == AB8500_SENSOR_BTEMP_BALL) {
 		*temp = ab8500_btemp_get_temp(ab8500_data->btemp);
-	} else {
-		voltage = ab8500_gpadc_convert(ab8500_data->gpadc, sensor);
-		if (voltage < 0)
-			return voltage;
-
+	} else if (sensor == AB8500_SENSOR_BAT_CTRL) {
+		*temp = ab8500_btemp_get_batctrl_temp(ab8500_data->btemp);
+	} else if (sensor == AB8500_SENSOR_AUX1) {
+		ret = iio_read_channel_processed(ab8500_data->aux1, &voltage);
+		if (ret < 0)
+			return ret;
+		ret = ab8500_voltage_to_temp(&ab8500_data->cfg, voltage, temp);
+		if (ret < 0)
+			return ret;
+	} else if (sensor == AB8500_SENSOR_AUX2) {
+		ret = iio_read_channel_processed(ab8500_data->aux2, &voltage);
+		if (ret < 0)
+			return ret;
 		ret = ab8500_voltage_to_temp(&ab8500_data->cfg, voltage, temp);
 		if (ret < 0)
 			return ret;
@@ -164,10 +175,6 @@ int abx500_hwmon_init(struct abx500_temp *data)
 	if (!ab8500_data)
 		return -ENOMEM;
 
-	ab8500_data->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
-	if (IS_ERR(ab8500_data->gpadc))
-		return PTR_ERR(ab8500_data->gpadc);
-
 	ab8500_data->btemp = ab8500_btemp_get();
 	if (IS_ERR(ab8500_data->btemp))
 		return PTR_ERR(ab8500_data->btemp);
@@ -181,15 +188,25 @@ int abx500_hwmon_init(struct abx500_temp *data)
 	ab8500_data->cfg.tbl_sz = ab8500_temp_tbl_a_size;
 
 	data->plat_data = ab8500_data;
+	ab8500_data->aux1 = devm_iio_channel_get(&data->pdev->dev, "aux1");
+	if (IS_ERR(ab8500_data->aux1)) {
+		if (PTR_ERR(ab8500_data->aux1) == -ENODEV)
+			return -EPROBE_DEFER;
+		dev_err(&data->pdev->dev, "failed to get AUX1 ADC channel\n");
+		return PTR_ERR(ab8500_data->aux1);
+	}
+	ab8500_data->aux2 = devm_iio_channel_get(&data->pdev->dev, "aux2");
+	if (IS_ERR(ab8500_data->aux2)) {
+		if (PTR_ERR(ab8500_data->aux2) == -ENODEV)
+			return -EPROBE_DEFER;
+		dev_err(&data->pdev->dev, "failed to get AUX2 ADC channel\n");
+		return PTR_ERR(ab8500_data->aux2);
+	}
 
-	/*
-	 * ADC_AUX1 and ADC_AUX2, connected to external NTC
-	 * BTEMP_BALL and BAT_CTRL, fixed usage
-	 */
-	data->gpadc_addr[0] = ADC_AUX1;
-	data->gpadc_addr[1] = ADC_AUX2;
-	data->gpadc_addr[2] = BTEMP_BALL;
-	data->gpadc_addr[3] = BAT_CTRL;
+	data->gpadc_addr[0] = AB8500_SENSOR_AUX1;
+	data->gpadc_addr[1] = AB8500_SENSOR_AUX2;
+	data->gpadc_addr[2] = AB8500_SENSOR_BTEMP_BALL;
+	data->gpadc_addr[3] = AB8500_SENSOR_BAT_CTRL;
 	data->monitored_sensors = NUM_MONITORED_SENSORS;
 
 	data->ops.read_sensor = ab8500_read_sensor;
-- 
2.21.0

