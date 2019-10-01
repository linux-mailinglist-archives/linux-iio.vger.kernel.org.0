Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5AC4396
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 00:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfJAWQN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 18:16:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37566 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfJAWQN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 18:16:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so15060334lje.4
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2019 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQ0m0QWtQdDReAFdbZosDbT4pYtAh/9chiTiPYwyaEQ=;
        b=Y/NBd2I9++wnBHM2TY0W2rqTj0afvAU2O5qK0dH5WbAVXxxTk54QX90uhzewiZvtYy
         dyvQi5B5OlqTxCE865Oc7JPvY679ymYcVxZrwqHlPbRCRZv321amzfx/kYEKDLLO3JXV
         iTUXgxRDO/OWHxcOWKgRT6srVY5cRiwA07S1UgKWr42kXNDSZpdzNzqGrfNR2p/bpbh1
         WHOO1/FUjRz35nzHJ8i+zIjuzkb5EaJXAToP+bz06FmzNNYHx4OUdGB1Frk4UtZm4lfK
         brOTxkRzCNq9WJKDGD+s4rdTDtY9GW9YRutVzLES/kdgRf6CbUQTzdnoNX6Hjbw3J/St
         P4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQ0m0QWtQdDReAFdbZosDbT4pYtAh/9chiTiPYwyaEQ=;
        b=cPQjXZ40X8Pl3TUNguO4d92G3NOdmo3Hjz9DmXNTpYivUMea6W9wOi6XzMATDjJN5e
         ksqd9do7O0M382c3fCbO9KEo/hCHGBd0XP4DPFtaeXjloRE/1ztl+XOcZjRtuHsvVout
         MtchNunO7nGU7VX/pOCqv2OGHTSHWEj6uSkkEYf7hkbJzHRIrIOZY7iOLN95F2ACvvdT
         WX8HcyW0RpiKdikQqJ8A6dN+skCNfTFdoqaa4k0mEZqXDacnnohbCB//wMqB1nXMVgcs
         Dr9PWLVn/dNCpy0Nj/aEwnMMr3EzieG5xVpOdbgp3G80kjaaS3+QvF8J/jjd3VkATrZ8
         +1mg==
X-Gm-Message-State: APjAAAUd71Spw3Su0gFlmaml208IBCzJp0IsfJFrkGoFz+VpYzuAkvBa
        ux6sE7lGY+tLSLa+qNtCYGC96g==
X-Google-Smtp-Source: APXvYqwADj0UpOYhndPKG9SODxmla8jAaxu7hRLL2vfSsIRUZ+bTgAifnHMg2JWVghhyGJ45zJxPOg==
X-Received: by 2002:a2e:3806:: with SMTP id f6mr94199lja.143.1569968170470;
        Tue, 01 Oct 2019 15:16:10 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id z14sm4287855ljz.10.2019.10.01.15.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:16:09 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/7 v3] power: supply: ab8500_charger: convert to IIO ADC
Date:   Wed,  2 Oct 2019 00:13:51 +0200
Message-Id: <20191001221356.19317-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001221356.19317-1-linus.walleij@linaro.org>
References: <20191001221356.19317-1-linus.walleij@linaro.org>
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

