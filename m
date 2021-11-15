Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E917B44FD9B
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 04:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhKODrD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 22:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbhKODqs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 22:46:48 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4696C06120C;
        Sun, 14 Nov 2021 19:43:52 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j9so10442456qvm.10;
        Sun, 14 Nov 2021 19:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRYkqMHoPJ/CsqAgxSDIdXX+yarePPpakk34LYl1XTw=;
        b=UkUzXfzzrtAmRGzcnb0AmXtGmFe6eWA7PLFgZuz6ZE4tkDvhUirUvr4BynfrUHL8D7
         eqDst16WxtG3kbgdLX1AFtg6Mt/QoRe1cI4XB7avg2QshLMJb5aKKO+HtmOjF4kcX2cs
         +obhNnzd2iSj2AMNn8D7lvRRiZ2TMT0ZD7RG6ZG/0fmqDGro0cBxXzIp4dn9F93OcZ2h
         4CaI6o96Zx9tDkTogZVtezznIyKHHlzeSgXrppsR8QWL/753ru2I/VGGE6x6dXkkYm0F
         djpapwUXm9cmkz+r0VChFAQYi+dXcNe8aDO8/hebCsLJtD4EIysxbCLQZC93ls+kanUo
         DZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRYkqMHoPJ/CsqAgxSDIdXX+yarePPpakk34LYl1XTw=;
        b=Hv3mLbHdiQ3NzqOShWobrokM2UGqnDJBZEJfTOc7zOVnEcY++MY2ra+9D7XoUrcdYO
         hgImnUxQ0WSRNbOezMcVqIm3rLiZYTMIhF9Hlz6DfZnVbyRytjemMrHYKK9IXtd/9TRB
         yqiEVoWwFrnjRyZN3zbKGc9IvhHIT3b37+9NrO6BBy/o0IMvmsiOL34jkOqIq6XGtrOm
         aQIzjZMGUiPlHkYCZTGmtiJWoiCHaW8gLVicchOep5W059Iq5M+K9sIgZwJLXs4AiDm5
         23bXeZImPs8F05LclMBevM1XBsBl/jYV7zfGJPM+becjCMeZ10ZkSxzUcnAAWRbJH2YZ
         5jOA==
X-Gm-Message-State: AOAM533JF/4F1XNXKfhiGe/To//qToS5DNV2LToqGdiBG2LxEK1T5wd/
        t8yb/A/JYUM6JVknRNYRZ3WK9+MbaQE=
X-Google-Smtp-Source: ABdhPJy+1F4q1ev5aybd+xTKfud8FVC6wzco1Gd5I4JIXw5zlzGAM1Th+o7u97ar3Tdf25TgM+MgzQ==
X-Received: by 2002:a05:6214:f61:: with SMTP id iy1mr33797274qvb.0.1636947831903;
        Sun, 14 Nov 2021 19:43:51 -0800 (PST)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h5sm206519qkn.62.2021.11.14.19.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 19:43:51 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v9 11/14] iio: afe: rescale: add RTD temperature sensor support
Date:   Sun, 14 Nov 2021 22:43:31 -0500
Message-Id: <20211115034334.1713050-12-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20211115034334.1713050-1-liambeguin@gmail.com>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
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
index 8a2f1c0ca5a3..ea162ba2a674 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -381,10 +381,52 @@ static int rescale_voltage_divider_props(struct device *dev,
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
@@ -400,6 +442,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_RTD] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_rtd_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -409,6 +455,8 @@ static const struct of_device_id rescale_match[] = {
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

