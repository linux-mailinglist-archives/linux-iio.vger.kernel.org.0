Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6463F3488
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbhHTTSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbhHTTSp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:45 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E5C061575;
        Fri, 20 Aug 2021 12:18:04 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 14so11953696qkc.4;
        Fri, 20 Aug 2021 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+eLtC7JNuGxTnORcSm7E5kaYd0kc5jriuJPklML6vkM=;
        b=io06IjKIAKAV/u574Zq+DnR6x/4Cxf/C7zpEFPJEjFo6o0RhuVKBYaY+rTML5h9HfY
         UcoyrN2K5aIGIBIBcC8/c8Wrtl4Z4ggZPhtHMmz0fjmatLRAWC91FavgDLRFz4eqI8wc
         Jju53yYDf7y1NDgysa3HrnVG4KWZrriWRz+JbV44F6Zxob8/90y8quazYsSUbyW0WZ10
         meNwopX1kXJygTJHNDplPWUSprBXTeGgFOOGPtvNcOu8JsyWMoz/IbQbtYDfkMeX2ngG
         /I7qoWd6yIOAnQyF2bozwhwdNOHx7SB7MQv4uvGUQB/NUYzlZUPntyHTyTmq4TLNn7Yg
         VU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+eLtC7JNuGxTnORcSm7E5kaYd0kc5jriuJPklML6vkM=;
        b=q25iRXGJ4jQ4vRCdVU/+u7cigAMOGjR4I695uHL5bvSUxs/0JaCH6o24K8iItrHbg0
         qM/wvc38CQTlgaKx2ZRiyPxllXZohf5fZ2J4Fqsg/KppPxDPccn0d6hw6wW6PNWlk/RG
         qHKPYE/FmRfr5RyLBoaCKbGjixQq09zSSepGwKXNEtPPC0CclGWYeFXDt8nt9FuuEUnw
         qAYEfXbL/kAYZdB4PjSIUa5CfpZxZjsrKGR4RAoBdywwPKKU6rBagTYPb42/VCxrdJ6Y
         6UkDtMhV+Zt9XaifWpt62AOAujlmsdOfo9/KIjtFaWGNlIfDZ7lbFdEtBpTeaG69jwDE
         sPCQ==
X-Gm-Message-State: AOAM53306KeJm9rRbqHGrxuOTZZfGyE6ZjhSDkvJyr+nfdO80YSx/gOC
        y91plRWoitskIHbiPYtOBCXdgWL36dY=
X-Google-Smtp-Source: ABdhPJw6y7hFM/TMxDwmnM3oDGB/RhwsbLyUPbfcGi6FXH+fgA70GJaE31sPOnvAT2mgVt64KgE31g==
X-Received: by 2002:a37:a60f:: with SMTP id p15mr10120471qke.377.1629487083584;
        Fri, 20 Aug 2021 12:18:03 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:18:03 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 11/14] iio: afe: rescale: add RTD temperature sensor support
Date:   Fri, 20 Aug 2021 15:17:11 -0400
Message-Id: <20210820191714.69898-12-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
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
index 7304306c9806..8cdcb6ffb563 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -386,10 +386,52 @@ static int rescale_voltage_divider_props(struct device *dev,
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
@@ -405,6 +447,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -414,6 +460,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
 	{ .compatible = "voltage-divider",
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
+	{ .compatible = "temperature-sense-rtd",
+	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.32.0.452.g940fe202adcb

