Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4A6D39E8
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 09:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfJKHSX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 03:18:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38005 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHSX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 03:18:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id b20so8758424ljj.5
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 00:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ShoW739s4Ja2AA4hkcjDaS267Az/foUrKnHnwbC+WGc=;
        b=bNTv7EuADlGwk3LD9htpKZcRCrMRT7TQ3cL2dT+FniR9j6sCSuie1B1w+qLYDgdvmz
         lKvaKjmvow9TYrr3TdAW3wH80dsOVFMgjQyOTYVbsWO0n/nZ2Pq1p4QmLBcVLKO5UaS+
         sNIRL/hCPPTBHzRLZK8k6tCPN7veSkl/FtyOojBCtyNlP6vImZr7N6Fc5LHt72te7HtC
         cFqX3VJHeqz57fhEtI1zLAi9y6oTdfH8OGejwZjWQOllKLfLmjZedP7vI15ieuD/uKhy
         nbW4hGE3tevBHIEMSa+uj8c7cAqkxxgr0Q3q0GiMf7CrCSYcA+P1YZDDuJEm81OBkqv4
         onIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ShoW739s4Ja2AA4hkcjDaS267Az/foUrKnHnwbC+WGc=;
        b=Bpi/pKZtu66w/GDqFrO7KyAYQptxzV4Q/2I8KTTvZNXANuuROYzdK9Qxx30DTmROxi
         24lyWv1IFwkyAHNLefZC293YoqRiCO3ROxiGWvtAkWAxXRXGZDBAiuEh5dTm4+VPIDDL
         MHKZCWkUvDwxIetRTYfSXGVG3LHa/pv7BgM8cl6AkpeExw/vqlN7ehSChKmqilouUkH4
         TXzaYVgK8MrMpePvzM8OJo7o7OSM7vkswK0gzngTNjXex3UcW+eE7tgjdNmx8QV/JIaH
         uNVw3qyxrJPDMt9sgu8BlEe7nW5BTw5AaC+4UTyx+9DkvtQ7kvJfY5GKbgg1nAkvcj/n
         ZgPQ==
X-Gm-Message-State: APjAAAX9eWp4+DgE5zgFNo49N5yz61vBWpjqfgqJoptq/Mpa0feJVSk5
        tK1D0gGm5ExpnEZPoFxdIMAoZQ==
X-Google-Smtp-Source: APXvYqy3IaZ8ceNrXZJMTb3du8F/A9BBp3j/JwxxdaFfT6xT1vU1zYhoY5e2xwtSOhTzzngF5n9MWw==
X-Received: by 2002:a2e:331a:: with SMTP id d26mr8334795ljc.231.1570778300935;
        Fri, 11 Oct 2019 00:18:20 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v26sm2047343lfg.27.2019.10.11.00.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:18:19 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/7 v4] hwmon: ab8500: convert to IIO ADC
Date:   Fri, 11 Oct 2019 09:18:02 +0200
Message-Id: <20191011071805.5554-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011071805.5554-1-linus.walleij@linaro.org>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- No changes just resending
ChangeLog v2->v3:
- Depend on (IIO = y) since we are bool and need it compiled
  in.
- Rebased on v5.4-rc1
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
index 13a6b4afb4b3..5308c59d7001 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -40,7 +40,8 @@ comment "Native drivers"
 
 config SENSORS_AB8500
 	tristate "AB8500 thermal monitoring"
-	depends on AB8500_GPADC && AB8500_BM
+	depends on AB8500_GPADC && AB8500_BM && (IIO = y)
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

