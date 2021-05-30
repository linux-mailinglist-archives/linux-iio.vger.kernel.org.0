Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA03394ECB
	for <lists+linux-iio@lfdr.de>; Sun, 30 May 2021 02:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhE3BBR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 21:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhE3BBM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 21:01:12 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69D6C06174A;
        Sat, 29 May 2021 17:59:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q10so7994211qkc.5;
        Sat, 29 May 2021 17:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUHjbP246dWqX0f+av17blUVb8XRzL1XnP4Qjksj4tw=;
        b=TPzH9mySirtZo0UOY3fVTknLDskhUhDUaLa4TopqQbW1PEVbcZwDhghaam3HxNGJpO
         pSzGytnqE4H47WieKX+Mq0QX+mvi+NZ+JpG2RhSJokNV6xy3g7VC9Mqi5p5Dkj913Akq
         SXXpO8OWzIZaj6m2xGJ9nAMQwC/m86VgOsugPAojeXt0CfC8hvJ9qqDZzWKWl3o3QJ9U
         HcEPnb9WTrkJA+YR+Zva7EYe1zhBA7PrnLXGedEHqX7scz/4SZcrRqcGhx8Qn/yapwJE
         k0dpvLSVugxHF0v51NzevPQQRtBsFwuf0QGGNoqszofw+6Z6VrAwfrp3RvM/eSz5nfxr
         QNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUHjbP246dWqX0f+av17blUVb8XRzL1XnP4Qjksj4tw=;
        b=jZQOejDKvOdtcm9/VkaxUCoIqlSjsO9dvfcm1a6Ba/k78EJrD6QoyLBZOAr0nHbi5U
         0FHU4dxvn5s4BLhINkw7Q3hEAlKdFljMv488x4pp2LBu063bnYoImCf+90+pmmtOm8DO
         TNZWaitbHDZr381WCzu8d/vsmsOELJxReFhggnW+9ZQRdzyh+Exr61nIsQgrsPuPbAX2
         kUwJq1lZR0uW07ui/+bhbTXSy9UJjRRKOJ4mLnvG0fv79FaE3bUP3x3HIiz0cn81DKox
         sz9JIdMuTcsiWiPMmLVQFP6WXho3e3jK2sLYAEzZCW8AXHmUfImIBenbG4g93ZkVjX/h
         uU7A==
X-Gm-Message-State: AOAM530lmXJh/mOLDHjqYRSXCb7ycesTHIc3TCSYElZXgOoxgXmf0Y4y
        /jeHbfosep42IzQGL3sAsDw=
X-Google-Smtp-Source: ABdhPJwg/hQW8qohDDXP3LEPpiBEVLTGEoytjks9ZSIvF4x4FkmIHBTqJ4FC6t/2OsmDe2cLq4OweA==
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr10305729qkj.354.1622336373078;
        Sat, 29 May 2021 17:59:33 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z1sm6382601qki.47.2021.05.29.17.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:59:32 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 5/9] iio: afe: rescale: add support for temperature sensors
Date:   Sat, 29 May 2021 20:59:13 -0400
Message-Id: <20210530005917.20953-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210530005917.20953-1-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add support for various linear temperature sensors.

temperature-sense-rtd is used when the measured temperature is a
function of the sensor's resistance (like RTD sensors).

temperature-sense-current is used when the measured temperature is a
function of the sensor's output current (like the AD590)

temperature-sense-amplifier is used when the measured temperature is a
function of the sensor's voltage (like the LTC2997)

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 141 ++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 3bd1f11f21db..eb53d833bf7c 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -222,10 +222,133 @@ static int rescale_voltage_divider_props(struct device *dev,
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
+	ret = device_property_read_u32(dev, "alpha-micro-ohms-per-ohm-celsius",
+				       &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-micro-ohms-per-celsius: %d\n",
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
+	/*
+	 * The transfer function:
+	 *
+	 *	- V(T) = R(T) * iexc
+	 *	- R(T) = r0 * (1 + alpha * T)
+	 *
+	 *	T = 1 / (alpha * r0 * iexc) * (V - r0 * iexc)
+	 */
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
+static int rescale_temp_sense_current_props(struct device *dev,
+					    struct rescale *rescale)
+{
+	u32 alpha;
+	u32 sense;
+	int ret;
+
+	ret = device_property_read_u32(dev, "sense-resistor-ohms", &sense);
+	if (ret) {
+		dev_err(dev, "failed to read the sense resistance: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "alpha-micro-amps-per-degree",
+				       &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-micro-amps-per-degree: %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * The transfer function:
+	 *
+	 *	- V(K) = Rsense * Isense(K)
+	 *	- K = Isense(K) / alpha
+	 *	- C = K - 273.15
+	 *
+	 *	C = 1 / (Rsense * alpha) * (V - 273.15 * Rsense * alpha)
+	 */
+	rescale->numerator = 1000000;
+	rescale->denominator = alpha * sense;
+
+	if (device_property_read_bool(dev, "use-kelvin-scale"))
+		rescale->offset = -1 * ((27315 * alpha * sense) / 100000);
+
+	return 0;
+}
+
+static int rescale_temp_sense_amplifier_props(struct device *dev,
+					      struct rescale *rescale)
+{
+	u32 alpha;
+	int ret;
+
+	ret = device_property_read_u32(dev, "alpha-micro-volts-per-degree",
+				       &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-micro-volts-per-degree: %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * The transfer function:
+	 *
+	 *	- K = V(K) / alpha
+	 *	- C = K - 273.15
+	 *
+	 *	C = 1 / (alpha) * (V - 273.15 * alpha)
+	 */
+	rescale->numerator = 1000000;
+	rescale->denominator = alpha;
+
+	if (device_property_read_bool(dev, "use-kelvin-scale"))
+		rescale->offset = -1 * ((27315 * alpha) / 100000);
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
+	TEMP_SENSE_RTD,
+	TEMP_SENSE_CURRENT,
+	TEMP_SENSE_AMPLIFIER,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -241,6 +364,18 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
+	[TEMP_SENSE_CURRENT] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_current_props,
+	},
+	[TEMP_SENSE_AMPLIFIER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_amplifier_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -250,6 +385,12 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
 	{ .compatible = "voltage-divider",
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
+	{ .compatible = "temperature-sense-rtd",
+	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
+	{ .compatible = "temperature-sense-current",
+	  .data = &rescale_cfg[TEMP_SENSE_CURRENT], },
+	{ .compatible = "temperature-sense-amplifier",
+	  .data = &rescale_cfg[TEMP_SENSE_AMPLIFIER], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.30.1.489.g328c10930387

