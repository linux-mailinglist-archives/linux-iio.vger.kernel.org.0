Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29185D39E5
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 09:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfJKHST (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 03:18:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36756 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHST (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 03:18:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so8771985ljj.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yr+i7xKWNHEsWNK7VSK5QfEXNdgZdcKqFLiLfbsuIw8=;
        b=uG+lJWi7BT4PetAE519XHw7abxi8Q26PXll2Eioowb0VUKgYvmh9h+cUbA6zgWAnhc
         80ENs/TCpRT0F9veB5smm1KMb5YAcnuFTr5g6kBcQzPD2c0+V7blhpL4vPiaQUmyrOwJ
         sUEy2khdIOd/+3d3ydxau7MJEfrrhmtSR0rbT7bk4P/HrmlZJwMLuetSqiDbmSXzcqKR
         L5eEIGVcCMuHNc89G03kZYUdPPxml6foY5SDVks6C9GC7TVyUO+aTRmKi8846BekfuHI
         aprslo4i2mgqts8nLf7XuIGk+Fs3Hh/dYm2D8hLM1R/QOmbewg7+GO1TIH1Dij79GMlW
         bE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yr+i7xKWNHEsWNK7VSK5QfEXNdgZdcKqFLiLfbsuIw8=;
        b=g+LCa1X6Qe+PBy4vjipOjAb6mIwL9uOJc78cGj8KyuOh91KiFw7r5KeqWcAJ0CKaAq
         Ze7c3nd2aVD6ut1dcmPXOU3GEUuwIMopMyv/CNHw1UKD6zgd2+0vvTXXymUtamlDOKM+
         f+zJJiP86RhH/467MTwLG+k4ziXFqUZ70k6o7ugnQM8uVJdYsCz5XCMwLxGBSkledTjt
         rsquOlWEO+2nToHh+BU/sj5pyfIrPCND8pWq7lv9AgbnMjTcTKLZlF6EQbs8ew152Ahf
         eqNNjMLIuoNarzHXEfArrgM7Yx8qM/hnbDsXaZIeUOejUhDRMLoL0Q4xAyNrGwmgfc56
         yDEg==
X-Gm-Message-State: APjAAAUZ6/xeqJORPbZZnTBsmuo8uLys3pJdqXrQCEgoS7V5/J7H54kW
        uCLPw0J9Lkm73lJTuJgYTvJFUA==
X-Google-Smtp-Source: APXvYqxgZ5Ub+2JyasRj8MdmcYmI5SviVnvnaxpY7f/a+xYrJkra2AFBSfXw78xdZCX+AASSF1biCw==
X-Received: by 2002:a2e:8e87:: with SMTP id z7mr8434752ljk.45.1570778294554;
        Fri, 11 Oct 2019 00:18:14 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v26sm2047343lfg.27.2019.10.11.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:18:13 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/7 v4] power: supply: ab8500_btemp: convert to IIO ADC
Date:   Fri, 11 Oct 2019 09:17:59 +0200
Message-Id: <20191011071805.5554-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011071805.5554-1-linus.walleij@linaro.org>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- No changes just resending
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

