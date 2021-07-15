Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869433C9640
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhGODPj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhGODPi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:38 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F588C061766;
        Wed, 14 Jul 2021 20:12:44 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x24so3510271qts.11;
        Wed, 14 Jul 2021 20:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPn15m+gaHTBKq9r6+UPKjgnBs2mEAEQzXBARIvlfXI=;
        b=M3UAKvrqKAp3wOiTCFchrnnWv39BrKd4eiE//+bVyXcJ1xlHzpxGjpk2/3XW1DOWzV
         CLaUJ7SVmy7WUC5HOcMrZ22ilO/HvA9IDURGP5Kj6Zo6eY4Xq6q/sUcMTSGemzlFVvLW
         zpgSbLS5/RxsbYZUh+wGBYWTnwjgT/MJPRZtDy2l2MudvqBNEmLHc4sFNAFifS8qsh6A
         Lykh95DkHctR3WeB3HorXYEEhhdxyH6Q6gJbpXn3tC+Vr3RKD61xkQkT4dH+wabd+thz
         +8fJkWbkkMdbfvdM/PMZd4rIocz0aCLfmlnRkYRTHyatrQXN6V3OFYaO3MkG9RGYFUGO
         gHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPn15m+gaHTBKq9r6+UPKjgnBs2mEAEQzXBARIvlfXI=;
        b=Lqmd4GnF5ai5F5DfA9CBoEAVde/D0KQaD4FBy2MTFIKHEMWxUMHYVmjGSGEbovG8wo
         uVBLF14i5qL7OXrOZFl30bAIGCvrtQ5a3Vp/SYbxF+Ebluv//tQWBim8BPzL4eWBbCYz
         REGDEtuoblBHMtuwdVmjSTzxHIbsc/SxsSHjFPar4ViMc7W/0ZOkkdoHa2xjL4u/3plO
         nZDVjiHsbdpRMHgSy7nhrkDwP7ghU8u4IXTWFIYB9v+QEYo7tzIXwwIF5ZqVhVgQsSXE
         D4qNV/DJ4RAGzdoHl0RDLLkH78+c13h1YoTllaT/h1HACgCa0dzvoWUm2lj/LKJHj96/
         dLpg==
X-Gm-Message-State: AOAM533Q4VAQwogA5m+S5nU4S4Lwjy5WUsfBLlPacHhvugYX2v16xZP2
        nnFmzSt2GH/9dfZ1n6EEE3c=
X-Google-Smtp-Source: ABdhPJxgPS6mhe1oEVEwtZioipQcyrpvWhbl0O7Eqi6jPcZVBcumhlIiEzRaKzsyanSQoXvqOfdICQ==
X-Received: by 2002:a05:622a:1190:: with SMTP id m16mr1620469qtk.92.1626318763635;
        Wed, 14 Jul 2021 20:12:43 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:43 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 07/10] iio: afe: rescale: add RTD temperature sensor support
Date:   Wed, 14 Jul 2021 23:12:12 -0400
Message-Id: <20210715031215.1534938-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210715031215.1534938-1-liambeguin@gmail.com>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An RTD (Resistance Temperature Detector) is a kind of temperature
sensor used to get a linear voltage to temperature reading within a
give range (usually 0 to 100 degrees Celsius). Common types of RTDs
include PT100, PT500, and PT1000.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 4d3b44884a89..055f6b7c9869 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -356,10 +356,52 @@ static int rescale_voltage_divider_props(struct device *dev,
 	return 0;
 }
 
+static int rescale_temp_sense_rtd_props(struct device *dev,
+					struct rescale *rescale)
+{
+	u32 factor;
+	u32 alpha;
+	u32 iexc;
+	u32 tmp;
+	int ret;
+	u32 r0;
+
+	ret = device_property_read_u32(dev, "excitation-current-microamp",
+				       &iexc);
+	if (ret) {
+		dev_err(dev, "failed to read excitation-current-microamp: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "r-naught-ohms", &r0);
+	if (ret) {
+		dev_err(dev, "failed to read r-naught-ohms: %d\n", ret);
+		return ret;
+	}
+
+	tmp = r0 * iexc * alpha / 1000000;
+	factor = gcd(tmp, 1000000);
+	rescale->numerator = 1000000 / factor;
+	rescale->denominator = tmp / factor;
+
+	rescale->offset = -1 * ((r0 * iexc) / 1000);
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
+	TEMP_SENSE_RTD,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -375,6 +417,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -384,6 +430,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
 	{ .compatible = "voltage-divider",
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
+	{ .compatible = "temperature-sense-rtd",
+	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.30.1.489.g328c10930387

