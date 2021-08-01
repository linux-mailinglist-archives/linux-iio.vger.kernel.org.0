Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B183DCD64
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhHATkd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhHATk3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:29 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BAFC0613D5;
        Sun,  1 Aug 2021 12:40:21 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id g6so7915401qvj.8;
        Sun, 01 Aug 2021 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdTcpTrw9RjzJaHUr2c/qhrWaB2G6iEuRUkeRd5GNB0=;
        b=Hz0G6hFteC/nQgsf1a58+ec1X8oI4x9TS60CPjUwbdpVcXgvOyen3zwju4YqInzzvp
         DpKuPh5y3JOE2+DQuHmYMGcdKImZZzhe2t9s5tgIGqZKGtrj2pnHajKVy9J8Z5GrCKD1
         GDvA9tJnjJUdvnOvzNsR+33rwM/uCH4yspV8MLBDsvQLvHApRpquTQbtesRnT6AL9NMq
         ZpPvs+HoEKRWZ32CIEDnrjcJrbsbIAfBMqHbRppnu+y7mzcrSnmC8pfCw3pC/xHFLXcq
         iAAEnIfoZh4jGX+I068mjngnfMpSolUbYJRC+G2nqSyBxXPCe2Ps1XK7RZGEuvFz2g0m
         zYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdTcpTrw9RjzJaHUr2c/qhrWaB2G6iEuRUkeRd5GNB0=;
        b=rUccITH7Nbgz+Tw7wJ4VtxlW6oalIrWGzFCARNXnsoLZ/3gtVAPVrrNCrGAG3A6Lj3
         QebL1BqPr4dTt7K3s812szFF2j0ge0tyNIj4X56IiQBtGvF0uXU8NUfOOChrTK/3m8//
         a9HEGolwwB4CVhqiEbqjWT7GdyDIwroyMKlPRRulgUghyAorcmqqaMx/zI2rBKeSR1Ks
         NNXlBsaKROgSRFBWcT6DebVThaG+zUs/bmikb86wKMFcmpCLb0+lfc4rK+Vtgbw3J3uv
         V4jsdispBTGcrhLvKXqMMbqLvso1AlMQnSna671vcmIIcDawHj2bYYsCA1wM40Cwv4XJ
         P7bQ==
X-Gm-Message-State: AOAM531NrzLL6JkkTB1StLXmGRu46gN7WeXJETRnwfct3BHqsAdpe9gB
        Fu0EA5XP61RzJTPDkvPorhSW/xwgoAlmuw==
X-Google-Smtp-Source: ABdhPJwVTqo8GXUsUwbXMD6p1SUEwcAkGbHKjQSF3+qr7aE+CB9Xdgv/RRmq14KiqmgLDsXJR4t5rg==
X-Received: by 2002:a0c:e6a4:: with SMTP id j4mr13069190qvn.16.1627846820470;
        Sun, 01 Aug 2021 12:40:20 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:20 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 10/13] iio: afe: rescale: add RTD temperature sensor support
Date:   Sun,  1 Aug 2021 15:39:57 -0400
Message-Id: <20210801194000.3646303-11-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
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
index e37a9766080c..9683380aee5e 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -380,10 +380,52 @@ static int rescale_voltage_divider_props(struct device *dev,
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
@@ -399,6 +441,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -408,6 +454,8 @@ static const struct of_device_id rescale_match[] = {
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

