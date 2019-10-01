Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26437C4395
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 00:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfJAWQM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 18:16:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41321 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfJAWQM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 18:16:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so11110790lfn.8
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2019 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zi3dEHdiBcbUub61RuiSTeRaQFSW2X0IgqrXTyYVlo=;
        b=DXLGsZIwblgZehO4HWQR99DrV8X4U6lRouu9ge6fFivT/UY9G3VF24GutymfZGs0fq
         0ixF3VTCVGJmqPWHpWpSdYZPajHn9DDvgMpCSDQyUVEOiwawbsOJXthV8e/ZoYmiYUBY
         +cXqMBR1e9qng6rzDMJKnSCGpfI0lyBGBMNdSHEwXyQ/7NKwXzKRvAtO2cxdtXcPFlDY
         rRmk+rmXzLwOjQ+2w/Sg1rFkiChgWSB7QP0p2v8mkybTqTMWMDSdreoPi+hqSHknBh2t
         X/OVDDzmubkWjIXtVaFQX05TWQKPVelvuw4zmscIdex44m2fV6Im7dpXunzl0bShLrKH
         04JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zi3dEHdiBcbUub61RuiSTeRaQFSW2X0IgqrXTyYVlo=;
        b=JptR3b1dWX3qOTm4p1leAh6WaIq3PJ+IkVDnkwGxdcTPlX7oeBLsGuimGQZ72hgOfd
         0sFPxuDcTduOvK7S/Demeczu10Kncaxr4qMkn6Xd3w6wiIN4IUBrvIyKSt7rjdS2eaxQ
         3O+HeZ0ydcn1WUxFafjAQMQK8nX2efWros7SaQTSBOt2BLdqjnraXygAo53if2NjB6j6
         POXTOy6y5vwPbRMC8bBy9EpxSEVIjnIppSRrkVGYmZIu/48tAux5UVVAU7V3npI/dXef
         9ubpZjHEriiTSuOSEIGAxxDvGHa8FgGJhlPqm3qDgD7aBXZzglXe7NIz9qNbcJ7YDWNy
         5Yzg==
X-Gm-Message-State: APjAAAXroY6juE+6zAs1Tmz7cqBHYnYHnNvGcUlgkgCDWAfuMyGTP6Jx
        RFKCblkE8LSKTXpAtcD9oM0QB1+kPS6oSA==
X-Google-Smtp-Source: APXvYqwAkTT3WXU6glRprlh7se9ZyTSa2womLZHIBFN3Z1ZtRw27nthquhttqs1Y8g6xABIgAgRhRw==
X-Received: by 2002:ac2:5965:: with SMTP id h5mr16161633lfp.129.1569968167842;
        Tue, 01 Oct 2019 15:16:07 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id z14sm4287855ljz.10.2019.10.01.15.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:16:06 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/7 v3] power: supply: ab8500_btemp: convert to IIO ADC
Date:   Wed,  2 Oct 2019 00:13:50 +0200
Message-Id: <20191001221356.19317-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001221356.19317-1-linus.walleij@linaro.org>
References: <20191001221356.19317-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the AB8500 battery temperature driver to using
the standard IIO ADC channel lookup and conversion routines.

Acked-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Make Kconfig entry depend on (IIO = y) as we need it
  compiled-in.
- Rebased on v5.4-rc1
ChangeLog v1->v2:
- Collected ACKs.
- Add a Kconfig dependency on IIO
- Fixed some whitespace issues
- Rebased on v5.3-rc5

This will be applied along with the other changes in ARM
SoC and should not be applied to the power tree right now.
---
 drivers/power/supply/Kconfig        |  2 +-
 drivers/power/supply/ab8500_btemp.c | 41 ++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index c84a7b1caeb6..27164a1d3c7c 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -629,7 +629,7 @@ config BATTERY_GAUGE_LTC2941
 
 config AB8500_BM
 	bool "AB8500 Battery Management Driver"
-	depends on AB8500_CORE && AB8500_GPADC
+	depends on AB8500_CORE && AB8500_GPADC && (IIO = y)
 	help
 	  Say Y to include support for AB8500 battery management.
 
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 8fe81259bfd9..ad8c51ef8b8b 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -26,7 +26,7 @@
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500/ab8500-bm.h>
-#include <linux/mfd/abx500/ab8500-gpadc.h>
+#include <linux/iio/consumer.h>
 
 #define VTVOUT_V			1800
 
@@ -79,7 +79,8 @@ struct ab8500_btemp_ranges {
  * @bat_temp:		Dispatched battery temperature in degree Celsius
  * @prev_bat_temp	Last measured battery temperature in degree Celsius
  * @parent:		Pointer to the struct ab8500
- * @gpadc:		Pointer to the struct gpadc
+ * @adc_btemp_ball:	ADC channel for the battery ball temperature
+ * @adc_bat_ctrl:	ADC channel for the battery control
  * @fg:			Pointer to the struct fg
  * @bm:           	Platform specific battery management information
  * @btemp_psy:		Structure for BTEMP specific battery properties
@@ -96,7 +97,8 @@ struct ab8500_btemp {
 	int bat_temp;
 	int prev_bat_temp;
 	struct ab8500 *parent;
-	struct ab8500_gpadc *gpadc;
+	struct iio_channel *btemp_ball;
+	struct iio_channel *bat_ctrl;
 	struct ab8500_fg *fg;
 	struct abx500_bm_data *bm;
 	struct power_supply *btemp_psy;
@@ -177,13 +179,13 @@ static int ab8500_btemp_batctrl_volt_to_res(struct ab8500_btemp *di,
  */
 static int ab8500_btemp_read_batctrl_voltage(struct ab8500_btemp *di)
 {
-	int vbtemp;
+	int vbtemp, ret;
 	static int prev;
 
-	vbtemp = ab8500_gpadc_convert(di->gpadc, BAT_CTRL);
-	if (vbtemp < 0) {
+	ret = iio_read_channel_processed(di->bat_ctrl, &vbtemp);
+	if (ret < 0) {
 		dev_err(di->dev,
-			"%s gpadc conversion failed, using previous value",
+			"%s ADC conversion failed, using previous value",
 			__func__);
 		return prev;
 	}
@@ -455,7 +457,7 @@ static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
  */
 static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 {
-	int temp;
+	int temp, ret;
 	static int prev;
 	int rbat, rntc, vntc;
 	u8 id;
@@ -480,10 +482,10 @@ static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 			di->bm->bat_type[id].r_to_t_tbl,
 			di->bm->bat_type[id].n_temp_tbl_elements, rbat);
 	} else {
-		vntc = ab8500_gpadc_convert(di->gpadc, BTEMP_BALL);
-		if (vntc < 0) {
+		ret = iio_read_channel_processed(di->btemp_ball, &vntc);
+		if (ret < 0) {
 			dev_err(di->dev,
-				"%s gpadc conversion failed,"
+				"%s ADC conversion failed,"
 				" using previous value\n", __func__);
 			return prev;
 		}
@@ -1024,7 +1026,22 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	/* get parent data */
 	di->dev = &pdev->dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
-	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
+
+	/* Get ADC channels */
+	di->btemp_ball = devm_iio_channel_get(&pdev->dev, "btemp_ball");
+	if (IS_ERR(di->btemp_ball)) {
+		if (PTR_ERR(di->btemp_ball) == -ENODEV)
+			return -EPROBE_DEFER;
+		dev_err(&pdev->dev, "failed to get BTEMP BALL ADC channel\n");
+		return PTR_ERR(di->btemp_ball);
+	}
+	di->bat_ctrl = devm_iio_channel_get(&pdev->dev, "bat_ctrl");
+	if (IS_ERR(di->bat_ctrl)) {
+		if (PTR_ERR(di->bat_ctrl) == -ENODEV)
+			return -EPROBE_DEFER;
+		dev_err(&pdev->dev, "failed to get BAT CTRL ADC channel\n");
+		return PTR_ERR(di->bat_ctrl);
+	}
 
 	di->initialized = false;
 
-- 
2.21.0

