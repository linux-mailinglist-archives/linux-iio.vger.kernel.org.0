Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D48343A9A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 08:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhCVHch (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 03:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhCVHcc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 03:32:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FB7C061756
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 00:32:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ay2so6078957plb.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qq6G37Un0IyK/Ds2ZxOYYiZ9/GRc+++HD4nnO0pdHlI=;
        b=OW3Ugoj10FZuLWov+b2uGZQx3WID2Cwc8L/tHufrke6GNIHYXJH9do7/VkKp89S3rD
         Lu8YTXfm2C8NXTxD/stab9dzUsmhayiCHU+d+hpFiU/tRm6SKKWfJpg6BvC+UowJ3ZXx
         JIcc3t7oE4r4Yasacxq/467Pov1pBatXiBUPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qq6G37Un0IyK/Ds2ZxOYYiZ9/GRc+++HD4nnO0pdHlI=;
        b=UZsPoG7kO2lPTwyJQ00VweFnLwvZpuYv98OMlPjUPjKiMzo4aPyRRrYdGs0I9ysV3/
         YvnkADACQzLv8atEbRvKVT7Pbq6tLJsB4Bd2aVXHBdjXKQP7MptNGDBdQF8jLYEMyPVU
         tH/o6OuES7N2E7RsW7nhmPs8idT6Oez0kZCP4p4WVidEAuUgJe/VgtH3sowXFb4XTn39
         ojedQh4VOpCG76nrz5hQG91Fh0sfSg8mLl2KkkF3Oy3khvVcR6OY+DiDDR2syL21GVuJ
         O1EeeIebrFmeNltimaEEh2eIkoR0Gt/osnQbwr7RHlo7Tu8/9dJPEAP3pqe17bFpfqEM
         xoAw==
X-Gm-Message-State: AOAM533Eb0BoeBO1LJgfpidw9mQddtpwq9WPv9Hw1hREjysX0l6zzJWl
        DdYpfee7CSXL4jxpD04LRwu/aA==
X-Google-Smtp-Source: ABdhPJxdiogCd6nnY/cKobglqXvQYq0DjjzgBVZ9zOuOfJNPsesnNOG/7HqanT0Dw+Eq5bRUpPiVYw==
X-Received: by 2002:a17:90a:ff15:: with SMTP id ce21mr11904893pjb.172.1616398350258;
        Mon, 22 Mar 2021 00:32:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:90ec:f36d:f115:8c9e])
        by smtp.gmail.com with UTF8SMTPSA id s1sm12666928pjo.36.2021.03.22.00.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 00:32:29 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 2/2] iio: sx9310: Support ACPI properties
Date:   Mon, 22 Mar 2021 00:32:20 -0700
Message-Id: <20210322073220.1637117-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210322073220.1637117-1-gwendal@chromium.org>
References: <20210322073220.1637117-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device_property_read_uXX to support both device tree and ACPI
bindings when reading the properties we need to configure the SAR
sensor.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Changes in v6:
 Use proper function to gather the number of elements in an array.

 Changes in v5:
 Split in 2 patches, one for fixing access to propery array, the other
 to support ACPI.

 drivers/iio/proximity/sx9310.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 289c76bb3b024..3817a5714aab3 100644
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
@@ -1213,10 +1214,9 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
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
@@ -1224,21 +1224,17 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
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
+		count = device_property_count_u32(dev, "semtech,combined-sensors");
 		if (count > 0 && count <= ARRAY_SIZE(combined)) {
-			ret = of_property_read_u32_array(np, "semtech,combined-sensors",
-							 combined, count);
+			ret = device_property_read_u32_array(dev, "semtech,combined-sensors",
+							     combined, count);
 			if (ret)
 				break;
 		} else {
@@ -1270,7 +1266,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
 
 		break;
 	case SX9310_REG_PROX_CTRL4:
-		ret = of_property_read_string(np, "semtech,resolution", &res);
+		ret = device_property_read_string(dev, "semtech,resolution", &res);
 		if (ret)
 			break;
 
@@ -1294,7 +1290,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
 
 		break;
 	case SX9310_REG_PROX_CTRL5:
-		ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
+		ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
 		if (ret) {
 			start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					  reg_def->def);
@@ -1304,7 +1300,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					   start);
 
-		ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
+		ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
 		if (ret) {
 			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
 					reg_def->def);
@@ -1317,7 +1313,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
 					   raw);
 		break;
 	case SX9310_REG_PROX_CTRL7:
-		ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
+		ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
 		if (ret)
 			break;
 
@@ -1353,7 +1349,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 	/* Program some sane defaults. */
 	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
-		initval = sx9310_get_default_reg(data, i, &tmp);
+		initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
 		if (ret)
 			return ret;
-- 
2.31.0.291.g576ba9dcdaf-goog

