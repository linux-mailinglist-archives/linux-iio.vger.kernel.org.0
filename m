Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE63B8B8C
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbhGABDg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbhGABDY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:24 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57F5C0617A8;
        Wed, 30 Jun 2021 18:00:53 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q190so4485118qkd.2;
        Wed, 30 Jun 2021 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibNMgUV/9imqXNXJIDWyn8fd0s+6qTMjhrOOTvVWpVk=;
        b=lTPnhrCbhIELR5bNOTMcGyvDB1v2VcGN29BaYKPXIvrY62PdTSGoPlIHijImmBTBQT
         o1gl7svVS0UBJTHRq42zJIuYNJlZyRzJA15sUFA3+1ZXYb5ZnJ6hNUB+NYonmm3IuE1K
         xBsZtQOdH4wkf8ClHVzZqL3kMdq/RpCy1+PixiabSAf6UfZL0rDSGlEax+2bB8fBB60i
         l2qyKj52BHJ1o690lzyxjgtlcY5QYVlJfz864JEGUm7jbHv5QUFkP8XYpPrdx1SvHLi0
         hI8i4AyJAs974wEm/kLLaZS91eaj8pddkprW27/cIwz4VjZJvUFYUQ5sIk+wqDD76mPd
         pSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibNMgUV/9imqXNXJIDWyn8fd0s+6qTMjhrOOTvVWpVk=;
        b=aiCsbnmlMKaHlPuGe5uw0aOMjCqZfzTfPsVqGpYy7Nby2ZoL1g3klVbLbEsQdGib5O
         Alupjpro0ROQd6AxgvA9elBcD4SH4mBjiLcBNGaRWR9zq19+goip19gP+4SyaztfjJaf
         BMvjoKqzMePN6KNpykZojR69M2/htwwyzNsNidMoDG88a4YJY4uSZuTkyyUFmvlzCPdP
         7khumLhFKTDKWZb+PKTkt8na9wXsg9LtpzK6zifL5g5ZBmxSjFJlxO6hflF6iavoNAvU
         gHBVDpbkTBhYQxsUpe0c6vzM4VIYIpZoiL7gnGDIn0BtPrSeW+rVwvD9/5rA2AvaQUOz
         Tc8A==
X-Gm-Message-State: AOAM532JCdGwGeDBA59hx58bo8dkZxZlZqZRuM9SIYaSkuY/D8rCGJjJ
        RJuKU9Yxis0nymNOGGwjyB4=
X-Google-Smtp-Source: ABdhPJza8ZdGVml+mzk6p8ejH3yd2Ovevt0IpUaG5PWgUX3oodI2ehKKS5xj//qHoiuS4obKSqwsBw==
X-Received: by 2002:a37:438e:: with SMTP id q136mr39492390qka.382.1625101252908;
        Wed, 30 Jun 2021 18:00:52 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:52 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 07/10] iio: afe: rescale: add RTD temperature sensor support
Date:   Wed, 30 Jun 2021 21:00:31 -0400
Message-Id: <20210701010034.303088-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210701010034.303088-1-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
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
index c8750286c308..5d7fe8695b68 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -336,10 +336,52 @@ static int rescale_voltage_divider_props(struct device *dev,
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
@@ -355,6 +397,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -364,6 +410,8 @@ static const struct of_device_id rescale_match[] = {
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

