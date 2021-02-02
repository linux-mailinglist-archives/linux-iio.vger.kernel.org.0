Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A69330B7FE
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 07:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhBBGq1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 01:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhBBGq1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 01:46:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07343C061573
        for <linux-iio@vger.kernel.org>; Mon,  1 Feb 2021 22:45:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g3so11923913plp.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Feb 2021 22:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qXfT2Uo14f4OS2yltkngXZo7qq+t08sTW8QjA8AMDVo=;
        b=FWxzA4g3WEdngKa177f1ox0pl9I9LQ9oLYczFIdlSAcmGZDs8fIT1EeFsaLcXyGU7X
         8smLeA64UPUWLGtt2AVMi/TO/4rxJgcWo2mCR6y6u8lIhuKq/ZGcTTaWTEW2jZfP1ozJ
         dFAxfSAK5NzxgQu/8NV4gYIOeDxP/ARBe1iCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qXfT2Uo14f4OS2yltkngXZo7qq+t08sTW8QjA8AMDVo=;
        b=UaTIIktp+zWGEnZ6Y7z+K1yYUDmalEqwMQCwunfXElXcgMofwonWbAQKOtiiZwLkps
         zR9xLmkswu57pkBN9zu2q4ipk6GzaNzWCCrqS6V1PQXi4xsNJpytt7Gf4BfjWHRrNrqU
         MVFGMPgieUUo1ef2g48qAk/4nAVXAbjUpDIJ5n8O5xd2eW8Mu4tlj36apsonnFZCogSe
         G1G9xWNnlC3EjeUD8OK4UQ1MmeFRXF1JhfSMX7QptqH5Ao0RHkR9/B+MwgDzLVoiuqqL
         o9ejp8peQMvxYnZsYmv4hcuIaumnA51ILveSNrwTpBkbpFkD9HuAmsWNJvR1V/ZnEb9x
         Z3eQ==
X-Gm-Message-State: AOAM533wdryDKOSHmP6etK0adg9qsmX+Y/GpgTztpz2ZdtZD4+djmnKv
        A56suqIxnMOBhLFwZtCYBeZmlQ==
X-Google-Smtp-Source: ABdhPJySUwCVVtFbImg4IrRYBzUTnqmp73lOt1Kl+wtvH74vda4UG9j3vZb69QdvTbZTqGWSRgHkRg==
X-Received: by 2002:a17:90b:204d:: with SMTP id ji13mr2764303pjb.51.1612248346491;
        Mon, 01 Feb 2021 22:45:46 -0800 (PST)
Received: from localhost ([2620:15c:202:201:68ce:7e9e:a2df:f91e])
        by smtp.gmail.com with ESMTPSA id k1sm13978366pgq.87.2021.02.01.22.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 22:45:45 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: sx9310: Support ACPI property
Date:   Mon,  1 Feb 2021 22:45:41 -0800
Message-Id: <20210202064541.2335915-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
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
---
 drivers/iio/proximity/sx9310.c | 36 ++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 37fd0b65a0140..1a8a441c9774d 100644
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
@@ -1213,31 +1214,36 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
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
+		count = device_property_read_u32_array(dev,
+				"semtech,combined-sensors", NULL, 0);
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
@@ -1254,7 +1260,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 
 		break;
 	case SX9310_REG_PROX_CTRL4:
-		ret = of_property_read_string(np, "semtech,resolution", &res);
+		ret = device_property_read_string(dev, "semtech,resolution", &res);
 		if (ret)
 			break;
 
@@ -1278,7 +1284,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 
 		break;
 	case SX9310_REG_PROX_CTRL5:
-		ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
+		ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
 		if (ret) {
 			start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					  reg_def->def);
@@ -1288,7 +1294,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
 					   start);
 
-		ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
+		ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
 		if (ret) {
 			raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
 					reg_def->def);
@@ -1301,7 +1307,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 					   raw);
 		break;
 	case SX9310_REG_PROX_CTRL7:
-		ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
+		ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
 		if (ret)
 			break;
 
@@ -1337,7 +1343,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 	/* Program some sane defaults. */
 	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
-		initval = sx9310_get_default_reg(data, i, &tmp);
+		initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
 		if (ret)
 			return ret;
-- 
2.30.0.365.g02bc693789-goog

