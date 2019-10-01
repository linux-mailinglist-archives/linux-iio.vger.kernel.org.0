Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB15C4398
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 00:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfJAWQS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 18:16:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40631 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfJAWQS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 18:16:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so15028382ljw.7
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2019 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iq2C2Kg/YxTaK1oYyWa1ym3YQFEhtCXtlroz9RaZMys=;
        b=l/UPYYkNnon6JyVAfo7BxA+GPk86IPMtjwJLQsmD6cZhgRn45BvBeYQFJTgE/x3VW6
         g52e70KuxfPxTi0qWososrw/r6xgx3U7qcZZ4yWqn5C7TuPEI0dbh5AGjUt3zSareeH8
         TurO0AMGHx9fETk1nNIXTHPPjdcvI3TZOxYDVRHvTUk0BBPobbwgtrIx99GH6d5LOcUp
         q/POkDx3Hy57RQmOmH84s54eQPA3oX2AOvR49HUYr9kAeIzhISIrHk2MHQ/+OG3ccc+2
         2YJW7Jao/9aPtq+9TH39MDkMh94XNtxE0gc6qcdSakjso3+YjnH7ah3tI/gt7A6pgZ6u
         zl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iq2C2Kg/YxTaK1oYyWa1ym3YQFEhtCXtlroz9RaZMys=;
        b=YOKvJaR53xhU6IKoNB1enD4E8pt1lkfnUPDgK7Y8ngLTp1OYiYvGKM5o4jKmroUhhm
         RHgEn4LH2jXsdK67kkMD4dHLj7ETdtyg72Vd3/5rOMx8DIrbrqgJP8yYIz7Fmw/TS1j4
         kUb0ZISHG1Kqu72Lnm5ZHJMMzUsFgeEL68XZccE5XlBz59PE09lsmLqh+WTQ+HVPwRXn
         hyXrtcX2iZ4j9UkLj8XEkyxHSsLGGh1KwdApiNaK6aaGjVYRWtf5ItTLGx/Yz+W/h0pu
         iO+BnlTLWeXgsEBn0cbe4IeMSYHw9/PK9Dx6Y08AhtTr979DhOi/GtZaHYDWvZ1QgX5t
         s8ZA==
X-Gm-Message-State: APjAAAVIGCAc/duK7XW3N0AwIGj7ezD/nedTEQA+6n/JsrisgMpwQP0g
        kWnnKoAiomBmBY/7H0/5jgGJfg==
X-Google-Smtp-Source: APXvYqyMCheOyHQ7Q/cRWNX/TY82sJ2uzTRSPqLLJ+avuj9QOa5m69hxZzYwEVebqTREVR3RazOQXw==
X-Received: by 2002:a2e:3201:: with SMTP id y1mr106625ljy.5.1569968175268;
        Tue, 01 Oct 2019 15:16:15 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id z14sm4287855ljz.10.2019.10.01.15.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:16:14 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/7 v3] hwmon: ab8500: convert to IIO ADC
Date:   Wed,  2 Oct 2019 00:13:53 +0200
Message-Id: <20191001221356.19317-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001221356.19317-1-linus.walleij@linaro.org>
References: <20191001221356.19317-1-linus.walleij@linaro.org>
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

