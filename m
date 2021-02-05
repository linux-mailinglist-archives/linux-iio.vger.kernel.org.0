Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870DF311931
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 03:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhBFC5k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 21:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhBFCwi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 21:52:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191BAC061756
        for <linux-iio@vger.kernel.org>; Fri,  5 Feb 2021 13:58:17 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z9so4576944pjl.5
        for <linux-iio@vger.kernel.org>; Fri, 05 Feb 2021 13:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwGnDkAwLPNFNg3dbClr9Apyxhw0sa9sADlIfBPGl84=;
        b=e3vOfoclLsO/A7ts9jMJQiKJ2DoT3ZGGYFMYPidsrc4+xaSs3wRxbJKgXTxsiszjzU
         +7+o3uUgAlvAonbolehMDUA6fzCvanJXJ9pJLuYJlsfNpnNJRcJs3LuLsQ3T526ps1rk
         221kDHhrcovViFSPzOdHWqKVrefqTfPHETKfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwGnDkAwLPNFNg3dbClr9Apyxhw0sa9sADlIfBPGl84=;
        b=PeWCQvT9anYx4iubyOTkTszR2MLcRkIfNPQaHctxf7NGjjdSxuFk0fkIBz97BOxQy6
         1VTS8pIYDHNf/OS8UHWS7mlH1R1ul2WVmMhKqJwrn7Y81M8XdovoBc6MwbyZTy8bbGgw
         q0ShG/X7SI6XJLpncbtOr/sTwUkIkXKr/rOk0howNyTzycbQcyjagz05Ch7d0pQhSTL9
         wfR7ZHpJngkLGV34SOO7xkcxoSumIhuNplnWQMnqCJky+hawmilcMep4rU+8Q4wI74H2
         llqMP1y5mMSHo5tM/6ddQU/cnmUesPJK11hPhwNoP3USh8dJSl/islOYYCrv9vS8dV1z
         AKKA==
X-Gm-Message-State: AOAM530KSlL9zdhJ6L0MtBQzHQyEWQQ4IPj0EJPaDdAJfKK6kCLb1df5
        KQBQevjSQwBeZiRA0n8u4a0ZwQ==
X-Google-Smtp-Source: ABdhPJzUEkkWlurX5b5kkN5EQMoFWb73ErhTzOULYKGavUVTKY4Tl910aC4SfioeJ43vjjwtOhXYeQ==
X-Received: by 2002:a17:902:d2c9:b029:e1:8692:aa7c with SMTP id n9-20020a170902d2c9b02900e18692aa7cmr5685001plc.21.1612562296549;
        Fri, 05 Feb 2021 13:58:16 -0800 (PST)
Received: from localhost ([2620:15c:202:201:ac48:d1a2:431e:ab86])
        by smtp.gmail.com with ESMTPSA id b23sm9202364pjh.53.2021.02.05.13.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 13:58:15 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: sx9310: Support ACPI property
Date:   Fri,  5 Feb 2021 13:58:11 -0800
Message-Id: <20210205215811.2033425-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device_property_read_... to support both device tree and ACPI
bindings.

Add support for variable array per documentation
("iio/proximity/semtech,sx9310.yaml").

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 Changes since v1:
   Use device_property_count_u32(...) instead of device_property_read_u32_array(..., NULL, 0)

 drivers/iio/proximity/sx9310.c | 35 +++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 6a04959df35e5..bba9dc6ac844d 100644
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
@@ -1215,31 +1216,35 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
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
+		if (ret)
+			count = ARRAY_SIZE(combined);
+
+		for (i = 0; i < count; i++) {
 			if (combined[i] <= SX9310_NUM_CHANNELS)
 				comb_mask |= BIT(combined[i]);
 		}
@@ -1256,7 +1261,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 
 		break;
 	case SX9310_REG_PROX_CTRL4:
-		ret = of_property_read_string(np, "semtech,resolution", &res);
+		ret = device_property_read_string(dev, "semtech,resolution", &res);
 		if (ret)
 			break;
 
@@ -1280,7 +1285,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 
 		break;
 	case SX9310_REG_PROX_CTRL5:
-		ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
+		ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
 		if (ret) {
 			start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					  reg_def->def);
@@ -1290,7 +1295,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					   start);
 
-		ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
+		ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
 		if (ret) {
 			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
 					reg_def->def);
@@ -1303,7 +1308,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 					   raw);
 		break;
 	case SX9310_REG_PROX_CTRL7:
-		ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
+		ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
 		if (ret)
 			break;
 
@@ -1339,7 +1344,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 	/* Program some sane defaults. */
 	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
-		initval = sx9310_get_default_reg(data, i, &tmp);
+		initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
 		if (ret)
 			return ret;
-- 
2.30.0.478.g8a0d178c01-goog

