Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767AA3D9524
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 20:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhG1SSG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Jul 2021 14:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG1SSG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jul 2021 14:18:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFADC061757
        for <linux-iio@vger.kernel.org>; Wed, 28 Jul 2021 11:18:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso11419589pjb.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Jul 2021 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIwbSpDwiNPP6FYqD74SQUjltuo1uMrNN8qPtMNibu8=;
        b=K4zDDmHcJwkKfBAwrJfdMkg5DM6Nwgntkh/1KucD/sgm3+Wr3B2SWeIQrKOWYGWGNb
         P6roPmsxF1n4FfryWNUCepMqje2YzJ+4UOpWqqjVBnJ9cqIy7AAXfoCsgQTyaT04QsuN
         KDk0567MOBYuFI4bQybDNA1+9FcVai6tMWM1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIwbSpDwiNPP6FYqD74SQUjltuo1uMrNN8qPtMNibu8=;
        b=BVSkamBZZlD1XTiKDgCrmGPOV3IQdC/Ik+KhiwduR9EKavEE2aOwSwkTXpOJjFJcqC
         pasf+CQvOH5rHLNGEb/zr3UeVFf1ZeKz3z/CV/NjlrrPwtAZP2Vk/zjpSzKn13ZzLAA6
         LzbpSMokligcn9ZHrOD8ryKSuQ3t/o1uqeOZJD5uAesWFgToVLF0GcN/YPFq02/HYF97
         p21KngdF2gFMnupn+jDX9FCrSzzHs/TbYLQRAE84U9Me92s5U9x7x14cOSqaJFNxLbe5
         wFDUng24XFEkb7vrFqXsC0WbSN4i7JqexFGeetzuMFSfey4UOhCrHminiok1/I5qMB4O
         fayA==
X-Gm-Message-State: AOAM530CmRPKfcIoeedPxIVkkK7ClyFTzER0+NsRL9rHGhBqw/J6gZ3Y
        3yDxCM5LHvpST5MqXk9gPbXU3A==
X-Google-Smtp-Source: ABdhPJziS9/BNQOvmBcLlO2+/yZpP5p7FFP5YaQ4KhEttKT1NRs8F4BE2Stw5FHmlShveY33AuVZ9w==
X-Received: by 2002:a65:568c:: with SMTP id v12mr203109pgs.88.1627496283867;
        Wed, 28 Jul 2021 11:18:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:770:9b9d:7e5a:62d5])
        by smtp.gmail.com with UTF8SMTPSA id fh2sm414232pjb.12.2021.07.28.11.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 11:18:02 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5] iio: sx9310: Support ACPI property
Date:   Wed, 28 Jul 2021 11:17:57 -0700
Message-Id: <20210728181757.187627-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device_property_read_... to support both device tree and ACPI
bindings.
Simplify the logic for reading "combined-sensors" array, as we assume
it has been vetted at firmware build time.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Changes since v4:
   Separate the patch in 2, the fix for 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")
   went in f0078ae704d9 ("iio: sx9310: Fix access to variable DT array")
   Simplify decoding of "combined-sensors" array, assuming it formatted
   properly when available.
 Changes since v3:
   Add "Fixes" comment in commit message
   Fix the logic set COMBMODE register: when we know the DT property is
   missing or incorrect, exit as soon as possible.
 Changes since v2:
   Add comment how the default array is used.
   Add comment in commit message to indicate this CL fix an issue with
     existing use of of_property_read_u32_array() when reading a variale
     length array.
 Changes since v1:
   Use device_property_count_u32(...) instead of device_property_read_u32_array(..., NULL, 0)

 drivers/iio/proximity/sx9310.c | 48 ++++++++++++----------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 36d34e308e873..6708c3a7886e8 100644
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
@@ -1223,10 +1224,9 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 }
 
 static const struct sx9310_reg_default *
-sx9310_get_default_reg(struct sx9310_data *data, int idx,
+sx9310_get_default_reg(struct device *dev, int idx,
 		       struct sx9310_reg_default *reg_def)
 {
-	const struct device_node *np = data->client->dev.of_node;
 	u32 combined[SX9310_NUM_CHANNELS];
 	u32 start = 0, raw = 0, pos = 0;
 	unsigned long comb_mask = 0;
@@ -1234,40 +1234,24 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
 	const char *res;
 
 	memcpy(reg_def, &sx9310_default_regs[idx], sizeof(*reg_def));
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
 
-		count = of_property_count_elems_of_size(np, "semtech,combined-sensors",
-							sizeof(u32));
-		if (count > 0 && count <= ARRAY_SIZE(combined)) {
-			ret = of_property_read_u32_array(np, "semtech,combined-sensors",
-							 combined, count);
-			if (ret)
-				break;
-		} else {
-			/*
-			 * Either the property does not exist in the DT or the
-			 * number of entries is incorrect.
-			 */
+		count = device_property_count_u32(dev, "semtech,combined-sensors");
+		if (count < 0 || count > ARRAY_SIZE(combined))
 			break;
-		}
-		for (i = 0; i < count; i++) {
-			if (combined[i] >= SX9310_NUM_CHANNELS) {
-				/* Invalid sensor (invalid DT). */
-				break;
-			}
-			comb_mask |= BIT(combined[i]);
-		}
-		if (i < count)
+		ret = device_property_read_u32_array(dev, "semtech,combined-sensors",
+				combined, count);
+		if (ret)
 			break;
 
+		for (i = 0; i < count; i++)
+			comb_mask |= BIT(combined[i]);
+
 		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
 		if (comb_mask == (BIT(3) | BIT(2) | BIT(1) | BIT(0)))
 			reg_def->def |= SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1_CS2_CS3;
@@ -1280,7 +1264,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
 
 		break;
 	case SX9310_REG_PROX_CTRL4:
-		ret = of_property_read_string(np, "semtech,resolution", &res);
+		ret = device_property_read_string(dev, "semtech,resolution", &res);
 		if (ret)
 			break;
 
@@ -1304,7 +1288,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
 
 		break;
 	case SX9310_REG_PROX_CTRL5:
-		ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
+		ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
 		if (ret) {
 			start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					  reg_def->def);
@@ -1314,7 +1298,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					   start);
 
-		ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
+		ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
 		if (ret) {
 			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
 					reg_def->def);
@@ -1327,7 +1311,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
 					   raw);
 		break;
 	case SX9310_REG_PROX_CTRL7:
-		ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
+		ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
 		if (ret)
 			break;
 
@@ -1363,7 +1347,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 	/* Program some sane defaults. */
 	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
-		initval = sx9310_get_default_reg(data, i, &tmp);
+		initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
 		if (ret)
 			return ret;
-- 
2.32.0.432.gabb21c7263-goog

