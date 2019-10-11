Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71ADD39E6
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 09:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfJKHSU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 03:18:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41890 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfJKHSU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 03:18:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so8758370ljg.8
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6icEk5Y6m3ew0gIhWgnLXQxQjzNNekLR3JETOEKngY=;
        b=eZdm5M2d5MlkAbTKZ5M0PJ13FdAgE5XfWuZ1KrfFyWIspTdLv/uGTCxopBNCpNFXjJ
         6w+kKJ6yV+piu7lQuQ5kFUiWRQ5Vmh3QGrWqLjNJCsa/Kap3Cl/m+LL3wHUkrIwM5rlM
         8YbUOS5mczBGZI32G5iuiSRRRjCpqDX+4p1e+cQxzLQAN6BeMEYgr9ESg08humfm5u04
         fAGqt9Cd5W1jkqxVzigwjkPUE8H+kohXu0Gjh6O1TEYJEa1N6Q9ecMnxXoVhd1wkcnSD
         giCwH5PzvYD0sjZ9yHa1mzU0DKv+TOzdlr7UQVPEPIl0ySS1u4uMtOXmc2Ren3Y8dCpK
         tRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6icEk5Y6m3ew0gIhWgnLXQxQjzNNekLR3JETOEKngY=;
        b=rvB1eRxheKyJzB5TLjJTbMkUZW0l7VB8dWZv+KueIn8TW4R6ueuyi7bUpv745SEo2F
         8sYUr8NvmwDZd/Z8b6iD2eshKIbhDYaDC27k1mEajkHsg3+J7AXOAILke0lC3Lwq9C1o
         ScE/GFDSKEkXOXmGSyoJPNg7DqWJB3mjk6dfHcYOJhQVbQ8BUZj2SkCDXCU+oN3awPbx
         vDWcgVH8yQgJQTfcfQpyKb5pvFII5QXBHbx+2Dxkq5/pFHrf2SEiI85IZnVjbciQd9V1
         71GkZKxrRKjEWaScSMMxDwn0PC/x3qRZ9dd6Rmz7wAD+FIMRqD6ODMij6ULgdzFYnbRx
         /fRA==
X-Gm-Message-State: APjAAAWsrCUQvMvsVyx85rqUv5HkKvEmcC8YcGHZ7LYbIPrWpBOIfK86
        YC6OyXB1r+IrNL+wQU+2j4EEoA==
X-Google-Smtp-Source: APXvYqwS/PQALgY+8Git/Vfdkh+QOT3Mv+Ld8bCQrdICQbSubZaX/5GPxCPbUWUEoKUyUF/0YfQD6Q==
X-Received: by 2002:a2e:b4c1:: with SMTP id r1mr7627214ljm.58.1570778296515;
        Fri, 11 Oct 2019 00:18:16 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v26sm2047343lfg.27.2019.10.11.00.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:18:15 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/7 v4] power: supply: ab8500_charger: convert to IIO ADC
Date:   Fri, 11 Oct 2019 09:18:00 +0200
Message-Id: <20191011071805.5554-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011071805.5554-1-linus.walleij@linaro.org>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the AB8500 battery charger driver to using
the standard IIO ADC channel lookup and conversion routines.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- No changes just resending
ChangeLog v2->v3:
- Rebased on v5.4-rc1
ChangeLog v1->v2:
- Collected ACKs.
- Rebased on v5.3-rc5
- Fixed some whitespace issues
This will be applied along with the other changes in ARM
SoC and should not be applied to the power tree right now.
---
 drivers/power/supply/ab8500_charger.c | 78 ++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index e51d0e72beea..c053ede47eb2 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -29,10 +29,10 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500-bm.h>
-#include <linux/mfd/abx500/ab8500-gpadc.h>
 #include <linux/mfd/abx500/ux500_chargalg.h>
 #include <linux/usb/otg.h>
 #include <linux/mutex.h>
+#include <linux/iio/consumer.h>
 
 /* Charger constants */
 #define NO_PW_CONN			0
@@ -233,7 +233,10 @@ struct ab8500_charger_max_usb_in_curr {
  * @current_stepping_sessions:
  *			Counter for current stepping sessions
  * @parent:		Pointer to the struct ab8500
- * @gpadc:		Pointer to the struct gpadc
+ * @adc_main_charger_v	ADC channel for main charger voltage
+ * @adc_main_charger_c	ADC channel for main charger current
+ * @adc_vbus_v		ADC channel for USB charger voltage
+ * @adc_usb_charger_c	ADC channel for USB charger current
  * @bm:           	Platform specific battery management information
  * @flags:		Structure for information about events triggered
  * @usb_state:		Structure for usb stack information
@@ -283,7 +286,10 @@ struct ab8500_charger {
 	int is_aca_rid;
 	atomic_t current_stepping_sessions;
 	struct ab8500 *parent;
-	struct ab8500_gpadc *gpadc;
+	struct iio_channel *adc_main_charger_v;
+	struct iio_channel *adc_main_charger_c;
+	struct iio_channel *adc_vbus_v;
+	struct iio_channel *adc_usb_charger_c;
 	struct abx500_bm_data *bm;
 	struct ab8500_charger_event_flags flags;
 	struct ab8500_charger_usb_state usb_state;
@@ -459,13 +465,13 @@ static void ab8500_charger_set_usb_connected(struct ab8500_charger *di,
  */
 static int ab8500_charger_get_ac_voltage(struct ab8500_charger *di)
 {
-	int vch;
+	int vch, ret;
 
 	/* Only measure voltage if the charger is connected */
 	if (di->ac.charger_connected) {
-		vch = ab8500_gpadc_convert(di->gpadc, MAIN_CHARGER_V);
-		if (vch < 0)
-			dev_err(di->dev, "%s gpadc conv failed,\n", __func__);
+		ret = iio_read_channel_processed(di->adc_main_charger_v, &vch);
+		if (ret < 0)
+			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
 	} else {
 		vch = 0;
 	}
@@ -510,13 +516,13 @@ static int ab8500_charger_ac_cv(struct ab8500_charger *di)
  */
 static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
 {
-	int vch;
+	int vch, ret;
 
 	/* Only measure voltage if the charger is connected */
 	if (di->usb.charger_connected) {
-		vch = ab8500_gpadc_convert(di->gpadc, VBUS_V);
-		if (vch < 0)
-			dev_err(di->dev, "%s gpadc conv failed\n", __func__);
+		ret = iio_read_channel_processed(di->adc_vbus_v, &vch);
+		if (ret < 0)
+			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
 	} else {
 		vch = 0;
 	}
@@ -532,13 +538,13 @@ static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
  */
 static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
 {
-	int ich;
+	int ich, ret;
 
 	/* Only measure current if the charger is online */
 	if (di->usb.charger_online) {
-		ich = ab8500_gpadc_convert(di->gpadc, USB_CHARGER_C);
-		if (ich < 0)
-			dev_err(di->dev, "%s gpadc conv failed\n", __func__);
+		ret = iio_read_channel_processed(di->adc_usb_charger_c, &ich);
+		if (ret < 0)
+			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
 	} else {
 		ich = 0;
 	}
@@ -554,13 +560,13 @@ static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
  */
 static int ab8500_charger_get_ac_current(struct ab8500_charger *di)
 {
-	int ich;
+	int ich, ret;
 
 	/* Only measure current if the charger is online */
 	if (di->ac.charger_online) {
-		ich = ab8500_gpadc_convert(di->gpadc, MAIN_CHARGER_C);
-		if (ich < 0)
-			dev_err(di->dev, "%s gpadc conv failed\n", __func__);
+		ret = iio_read_channel_processed(di->adc_main_charger_c, &ich);
+		if (ret < 0)
+			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
 	} else {
 		ich = 0;
 	}
@@ -3371,7 +3377,39 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	/* get parent data */
 	di->dev = &pdev->dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
-	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
+
+	/* Get ADC channels */
+	di->adc_main_charger_v = devm_iio_channel_get(&pdev->dev,
+						      "main_charger_v");
+	if (IS_ERR(di->adc_main_charger_v)) {
+		if (PTR_ERR(di->adc_main_charger_v) == -ENODEV)
+			return -EPROBE_DEFER;
+		dev_err(&pdev->dev, "failed to get ADC main charger voltage\n");
+		return PTR_ERR(di->adc_main_charger_v);
+	}
+	di->adc_main_charger_c = devm_iio_channel_get(&pdev->dev,
+						      "main_charger_c");
+	if (IS_ERR(di->adc_main_charger_c)) {
+		if (PTR_ERR(di->adc_main_charger_c) == -ENODEV)
+			return -EPROBE_DEFER;
+		dev_err(&pdev->dev, "failed to get ADC main charger current\n");
+		return PTR_ERR(di->adc_main_charger_v);
+	}
+	di->adc_vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
+	if (IS_ERR(di->adc_vbus_v)) {
+		if (PTR_ERR(di->adc_vbus_v) == -ENODEV)
+			return -EPROBE_DEFER;
+		dev_err(&pdev->dev, "failed to get ADC USB charger voltage\n");
+		return PTR_ERR(di->adc_vbus_v);
+	}
+	di->adc_usb_charger_c = devm_iio_channel_get(&pdev->dev,
+						     "usb_charger_c");
+	if (IS_ERR(di->adc_usb_charger_c)) {
+		if (PTR_ERR(di->adc_usb_charger_c) == -ENODEV)
+			return -EPROBE_DEFER;
+		dev_err(&pdev->dev, "failed to get ADC USB charger current\n");
+		return PTR_ERR(di->adc_usb_charger_c);
+	}
 
 	/* initialize lock */
 	spin_lock_init(&di->usb_state.usb_lock);
-- 
2.21.0

