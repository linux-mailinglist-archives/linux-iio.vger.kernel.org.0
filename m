Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC32031D556
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 07:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhBQGTQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 01:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhBQGTP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 01:19:15 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27354C061574
        for <linux-iio@vger.kernel.org>; Tue, 16 Feb 2021 22:18:35 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 189so7771083pfy.6
        for <linux-iio@vger.kernel.org>; Tue, 16 Feb 2021 22:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+O1y66kI1Gs7SpcPPFH8c+e4mpgsQvZbVXKRTYaQ5WI=;
        b=QxnKVM7u2Vgg0RViJ2zJPcQiUBjX5CfMDvhpoZ7Sq/Elcl1dJbhjrDfa3G2zsLQ4WE
         zVZVl91eQOKnZFYF9pqkx4I9H2fkfYVui4tS+TMTli6b+pJzmmrp35J1hTzk2FCFYoJS
         owNjrq/Dcl1PqOUKKa7+Kf4A5/DVC8C7j31pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+O1y66kI1Gs7SpcPPFH8c+e4mpgsQvZbVXKRTYaQ5WI=;
        b=kVih4mWBeajdPCIV6mFuPV5IAlP7beq33JWgRGpSTMcCGJGqwL8dnSJCOHwfB5ke15
         HEHOZgwpTAQcDWgCPP0SVr+bdWsd9brPXSzd5VCJyXp2ey1IJZyySspwQ7rjpIVrYhol
         YwsiN6XGirdanfUR/05wsEtuq9XMyzI6L0csvSm5yNgrhltgcF50uebqqqQdt5dOlFva
         StnScvzBz7MwqUhpHCIgLTSMoBqbrYX+E0COOZKHu5TcR4VUuMhFCyRHJUk0LTGXaaxe
         3D9Nu5muqs9ZbW5uWEffjJ77js6iY7KIWmVW1HCKdtotSiUME7tIEdKIVeGREVu57u0v
         eaEA==
X-Gm-Message-State: AOAM532Lna1uuVO/NXJUb0ZR2I1gKRTl7wP2plIG2coBWVBBVR2pVQsI
        SAD8yTMRhzWhFQJ7SBT/dqupsg==
X-Google-Smtp-Source: ABdhPJwFlcNZ75eP94gERDIvG3J3PWpXKszDA/F8NGIK04il0mlwW6xILTakVVu091CujnASBn1Z1g==
X-Received: by 2002:a63:e045:: with SMTP id n5mr22412202pgj.220.1613542714695;
        Tue, 16 Feb 2021 22:18:34 -0800 (PST)
Received: from localhost ([2620:15c:202:201:9849:9964:b381:7624])
        by smtp.gmail.com with UTF8SMTPSA id gk17sm853356pjb.4.2021.02.16.22.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 22:18:34 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4] iio: sx9310: Support ACPI property
Date:   Tue, 16 Feb 2021 22:18:29 -0800
Message-Id: <20210217061829.1199408-1-gwendal@chromium.org>
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

Fixes: 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
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

 drivers/iio/proximity/sx9310.c | 54 +++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 6a04959df35e5..77d2c9e102842 100644
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
@@ -1215,36 +1216,49 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 }
 
 static const struct sx9310_reg_default *
-sx9310_get_default_reg(struct sx9310_data *data, int i,
+sx9310_get_default_reg(struct device *dev, int i,
 		       struct sx9310_reg_default *reg_def)
 {
-	int ret;
-	const struct device_node *np = data->client->dev.of_node;
-	u32 combined[SX9310_NUM_CHANNELS] = { 4, 4, 4, 4 };
+	int ret, count;
+	u32 combined[SX9310_NUM_CHANNELS];
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
 
-		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
-		of_property_read_u32_array(np, "semtech,combined-sensors",
-					   combined, ARRAY_SIZE(combined));
-		for (i = 0; i < ARRAY_SIZE(combined); i++) {
-			if (combined[i] <= SX9310_NUM_CHANNELS)
-				comb_mask |= BIT(combined[i]);
+		count = device_property_count_u32(dev, "semtech,combined-sensors");
+		if (count > 0 && count <= ARRAY_SIZE(combined)) {
+			ret = device_property_read_u32_array(dev,
+					"semtech,combined-sensors", combined,
+					count);
+		} else {
+			/*
+			 * Either the property does not exist in the DT, the
+			 * number of entries is incorrect.
+			 */
+			break;
+		}
+		if (ret) {
+			/* We could not read the array (invalid DT). */
+			break;
 		}
 
-		comb_mask &= 0xf;
+		for (i = 0; i < count; i++) {
+			if (combined[i] >= SX9310_NUM_CHANNELS) {
+				/* Invalid sensor (invalid DT). */
+				break;
+			}
+			comb_mask |= BIT(combined[i]);
+		}
+
+		reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
 		if (comb_mask == (BIT(3) | BIT(2) | BIT(1) | BIT(0)))
 			reg_def->def |= SX9310_REG_PROX_CTRL2_COMBMODE_CS0_CS1_CS2_CS3;
 		else if (comb_mask == (BIT(1) | BIT(2)))
@@ -1256,7 +1270,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 
 		break;
 	case SX9310_REG_PROX_CTRL4:
-		ret = of_property_read_string(np, "semtech,resolution", &res);
+		ret = device_property_read_string(dev, "semtech,resolution", &res);
 		if (ret)
 			break;
 
@@ -1280,7 +1294,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 
 		break;
 	case SX9310_REG_PROX_CTRL5:
-		ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
+		ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
 		if (ret) {
 			start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					  reg_def->def);
@@ -1290,7 +1304,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					   start);
 
-		ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
+		ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
 		if (ret) {
 			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
 					reg_def->def);
@@ -1303,7 +1317,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 					   raw);
 		break;
 	case SX9310_REG_PROX_CTRL7:
-		ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
+		ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
 		if (ret)
 			break;
 
@@ -1339,7 +1353,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 	/* Program some sane defaults. */
 	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
-		initval = sx9310_get_default_reg(data, i, &tmp);
+		initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
 		if (ret)
 			return ret;
-- 
2.30.0.478.g8a0d178c01-goog

