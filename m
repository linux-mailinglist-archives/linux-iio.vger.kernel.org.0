Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9F73F348D
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbhHTTS5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbhHTTSq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:46 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CAFC06175F;
        Fri, 20 Aug 2021 12:18:05 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d5so8293936qtd.3;
        Fri, 20 Aug 2021 12:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+RerQlwryfsOV+KVw2IwUfRQlhiGdN9D5M7AJ5qR8M=;
        b=BDXiPenjgrU0w3oUGhluoGsjqc743snb0ZgjeOCN3Nrop6MTgDvXorU9104eTpGsjj
         1vMGbZD8kIxOFg4V1VlnDoEhoKQuJ0jY+45ftbdcV1fQ4ag/TW9j3XLkXqCQYfQ+f8n+
         zj/W4cj7gNTR7djDKjoU/PuVVpdDkQrRRNoUrG1Tbph4fu9B0WxsoGL/C/79d0t55RYb
         RdrC/q//rJ9HlshycOi67XMjNI841KzPL7uaOnsNFPaJliCmvM6xsc4t1WiqhObLZZ6b
         e+ISmQXQ4n6YSoKwXnNuBF6/TvjAbpleO8wxbuEWS9MFX4IT/58SaxmNTJ9rlCRxI6Oi
         XfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+RerQlwryfsOV+KVw2IwUfRQlhiGdN9D5M7AJ5qR8M=;
        b=j+vbbupMqXfW+vdTaUFxLDg9Gtm7OL8QEOx6Uk/hp0D6mUhI6ZKVn5YyAnCHmBQ46o
         8g5zLUEDo8YQ39v0WO+QGnH32QkUugig2Ro1V/8mmEs5iAeGhAcJqRFgJ9L/5T0+MUX4
         26bG49iZBRrt1gclVGu4m1AOvueLOUKVsq1qZq3N4J2sIGo/CR4guh+K94reYXiGrn38
         O8jArDYOMRbtBi6bwGDbgocmVphNc36qQ8FwrejdbABR5aas3M0NffMs8L6KVBX2o1vL
         2H/fZXMJIwB65BcuuFDBY3akh4WX29xKM4lfd/StbilvgPLjFgyfW8q4L34i6kTNm5DF
         6b9g==
X-Gm-Message-State: AOAM5338huqG3MY3vQp57iJtUMM/V1Whr1KNqgQxj0YqPT3MvpTUz03D
        DPVy6RCoQJqtrA4dLy5fzkEt9vziEAI=
X-Google-Smtp-Source: ABdhPJz5A0/3nZ4wMYzEUrwby4V/lUSgl1ol+y1wIJGlr9i6Sr3e7rDWWy/DqcmS5exOb5Io/bvwfQ==
X-Received: by 2002:ac8:5696:: with SMTP id h22mr9269476qta.236.1629487084510;
        Fri, 20 Aug 2021 12:18:04 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:18:04 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 12/14] iio: afe: rescale: add temperature transducers
Date:   Fri, 20 Aug 2021 15:17:12 -0400
Message-Id: <20210820191714.69898-13-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

A temperature transducer is a device that converts a thermal quantity
into any other physical quantity. This patch add support for temperature
to voltage (like the LTC2997) and temperature to current (like the
AD590) linear transducers.
In both cases these are assumed to be connected to a voltage ADC.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 8cdcb6ffb563..12de44058bea 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -427,11 +427,38 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
 	return 0;
 }
 
+static int rescale_temp_transducer_props(struct device *dev,
+					 struct rescale *rescale)
+{
+	s32 offset = 0;
+	s32 sense = 1;
+	s32 alpha;
+	s64 tmp;
+	int ret;
+
+	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
+	device_property_read_u32(dev, "sense-resistor-ohms", &sense);
+	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n", ret);
+		return ret;
+	}
+
+	rescale->numerator = 1000000;
+	rescale->denominator = alpha * sense;
+
+	tmp = (s64)offset * (s64)alpha * (s64)sense;
+	rescale->offset = div_s64(tmp, (s32)1000000);
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
 	TEMP_SENSE_RTD,
+	TEMP_TRANSDUCER,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -451,6 +478,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -462,6 +493,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
 	{ .compatible = "temperature-sense-rtd",
 	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
+	{ .compatible = "temperature-transducer",
+	  .data = &rescale_cfg[TEMP_TRANSDUCER], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.32.0.452.g940fe202adcb

