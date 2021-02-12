Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559FE31A702
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 22:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhBLVlU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 16:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhBLVlT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 16:41:19 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25609C061574
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 13:40:39 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id m2so508620pgq.5
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 13:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GszGji9Je8TVhcUeOlnxB7I8C4xCjQahCX+XdyFnPeI=;
        b=Skk4BkipdH5PSbZIgp88yLyYaTa0dNTyqrAg7uwR35Y0252Ou7Yf5t7xeOcbVOhAYH
         kDeGJjPkX3SkP/Z4Hv3pp3tklRucutjxhedBIqf0XRLBY57sxPzmqXidTpsQPBkKzwrh
         kg8LPGp9fAvDDnEksaECb34cSFKAwdEYyg9Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GszGji9Je8TVhcUeOlnxB7I8C4xCjQahCX+XdyFnPeI=;
        b=Yds1a+UT91yVB++bE+2xLHV/u6yeto+mZczz5v6UK/6usxihPTon3ZcpdaN4soOuS7
         o7FGCdurt1dCosh9aytWm4KgnmdH6QmLUky7kAQpOq+Iw2ja9MaCxa9a4ig6NUDn+ABo
         vUemFWwadCohVVN30vFXSyvO7funMl8qlrn+taeDDLtwiks8YNpP5OwCn8gP0gCUpNrK
         DE3CZe9N63wIgFj5UJhQOCg9XT4K3k/UwOjrEO1PnYr8VU4ERk5yftIgMbM2uvSNY8DJ
         /+rFRlvCGuSpCCPPEi6d5YFMg/KCmdf7hGwCbbUrKLJMEH5lqAoVakq/ADnfrHat1HoG
         WQAw==
X-Gm-Message-State: AOAM532XSSFB9/aSeYCJICU5p2VArDekrNDRXKqOMWR083APnbXbk84L
        sfhZKbOkDNXKNTyM+mL1gzk/Vw==
X-Google-Smtp-Source: ABdhPJx/tZ76NJpwoP95JE9j5onXu7RUmdd1L+wfVo0VZBFLdvDpCWdlQEpA1xmYeykJ884emeaIbg==
X-Received: by 2002:aa7:8f0a:0:b029:1de:4d20:8346 with SMTP id x10-20020aa78f0a0000b02901de4d208346mr4915528pfr.15.1613166038591;
        Fri, 12 Feb 2021 13:40:38 -0800 (PST)
Received: from localhost ([2620:15c:202:201:9c9d:5bc9:a213:64c0])
        by smtp.gmail.com with UTF8SMTPSA id q188sm9824796pfb.8.2021.02.12.13.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 13:40:38 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3] iio: sx9310: Support ACPI property
Date:   Fri, 12 Feb 2021 13:40:33 -0800
Message-Id: <20210212214033.1304840-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device_property_read_... to support both device tree and ACPI
bindings.
Given |semtech,combined-sensors| is a variable array, use
device_property_count to get the length of the array first before
reading it to avoid underflow errors.

Add support for variable array per documentation
("iio/proximity/semtech,sx9310.yaml").

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 Changes since v2:
   Add comment how the default array is used.
   Add comment in commit message to indicate this CL fix an issue with
     existing use of of_property_read_u32_array() when reading a variale
     length array.
 Changes since v1:
   Use device_property_count_u32(...) instead of device_property_read_u32_array(..., NULL, 0)

 drivers/iio/proximity/sx9310.c | 42 ++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 6a04959df35e5..6440d12773c64 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -20,6 +20,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -1215,31 +1216,42 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 }
 
 static const struct sx9310_reg_default *
-sx9310_get_default_reg(struct sx9310_data *data, int i,
+sx9310_get_default_reg(struct device *dev, int i,
 		       struct sx9310_reg_default *reg_def)
 {
-	int ret;
-	const struct device_node *np = data->client->dev.of_node;
+	int ret, count;
 	u32 combined[SX9310_NUM_CHANNELS] = { 4, 4, 4, 4 };
 	unsigned long comb_mask = 0;
 	const char *res;
 	u32 start = 0, raw = 0, pos = 0;
 
 	memcpy(reg_def, &sx9310_default_regs[i], sizeof(*reg_def));
-	if (!np)
-		return reg_def;
-
 	switch (reg_def->reg) {
 	case SX9310_REG_PROX_CTRL2:
-		if (of_property_read_bool(np, "semtech,cs0-ground")) {
+		if (device_property_read_bool(dev, "semtech,cs0-ground")) {
 			reg_def->def &= ~SX9310_REG_PROX_CTRL2_SHIELDEN_MASK;
 			reg_def->def |= SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND;
 		}
 
 		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
-		of_property_read_u32_array(np, "semtech,combined-sensors",
-					   combined, ARRAY_SIZE(combined));
-		for (i = 0; i < ARRAY_SIZE(combined); i++) {
+		count = device_property_count_u32(dev, "semtech,combined-sensors");
+		if (count > 0 && count <= ARRAY_SIZE(combined))
+			ret = device_property_read_u32_array(dev,
+					"semtech,combined-sensors", combined,
+					count);
+		else
+			ret = -EINVAL;
+		if (ret) {
+			/*
+			 * Either the property does not exist in the DT, the
+			 * number of entries is incorrect, or we could not read
+			 * the array (invalid DT).
+			 * In all cases, use the default from the diver.
+			 */
+			count = ARRAY_SIZE(combined);
+		}
+
+		for (i = 0; i < count; i++) {
 			if (combined[i] <= SX9310_NUM_CHANNELS)
 				comb_mask |= BIT(combined[i]);
 		}
@@ -1256,7 +1268,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 
 		break;
 	case SX9310_REG_PROX_CTRL4:
-		ret = of_property_read_string(np, "semtech,resolution", &res);
+		ret = device_property_read_string(dev, "semtech,resolution", &res);
 		if (ret)
 			break;
 
@@ -1280,7 +1292,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 
 		break;
 	case SX9310_REG_PROX_CTRL5:
-		ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
+		ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
 		if (ret) {
 			start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					  reg_def->def);
@@ -1290,7 +1302,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					   start);
 
-		ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
+		ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
 		if (ret) {
 			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
 					reg_def->def);
@@ -1303,7 +1315,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 					   raw);
 		break;
 	case SX9310_REG_PROX_CTRL7:
-		ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
+		ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
 		if (ret)
 			break;
 
@@ -1339,7 +1351,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 	/* Program some sane defaults. */
 	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
-		initval = sx9310_get_default_reg(data, i, &tmp);
+		initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
 		if (ret)
 			return ret;
-- 
2.30.0.478.g8a0d178c01-goog

