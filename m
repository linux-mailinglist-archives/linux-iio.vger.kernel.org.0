Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7012F34229F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 17:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCSQ6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhCSQ6R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 12:58:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DFDC06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 09:58:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so4740918pjb.4
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 09:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iogigeo27wil0UjHB2TpJicxsulnRf0A5GJ3aAzbnx0=;
        b=nmK9h8IQhmdFeEf1ncehMDDkDpXNQX1hcUAv83UNKzNz2zwpBOPlr6iv49MMztNoH6
         tZgmNG2TfRioxZXXIFF1rUyE7mb2KDsNmIodFGzJnSJDwpwCQDT4jiARMePVbdDqOaMO
         aIqQ6+1igTnnhR/rvJM/95y8cBQnOqV58X87c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iogigeo27wil0UjHB2TpJicxsulnRf0A5GJ3aAzbnx0=;
        b=uRhAYOErxmovTch0u8j0LG+Ph1+DQ7XpIO43cp9ZIlBSIQIxOgllqipux4gsiLpPUJ
         aYE92SB41+jOCRVTjK5B6eEWcIrsPMnGqggBmxcofkbq7AGamHFf3lCAGbemsIToEbzm
         MoZ0ldi8dGogSe9h6qbV5Knw3iDtDUC+9ffPEs35Kx2ZKqNwQZmDsLMhUHBgbpH9+3Rf
         mbpu0z1rEjdqj1NHMTtyiHBYJuaTc5JJ+WNQ/KsitBnCGpSXe7PemaDZ4lqumRTF7B18
         RcVHIf68aLQ1UGjau/95fAwKH6PMuiR1c6YwgdnNOyWXKuqHIttDsRcFC6iL14vQnFeg
         8PmQ==
X-Gm-Message-State: AOAM531cAexQjJvrRq+BUb7srvLLYHGNLRAJ59KCk8VbIYKGkqH+Go5s
        lRgisgVLFyWHcG42Pu+hSs7b1SisK9nLZA==
X-Google-Smtp-Source: ABdhPJx87AEHAvcN2MxHsnUtNqOruEIIAVo+aL2/0OdJu0itVsG3e7sb4ZMFMaY3KHpsaBj/XzoX6Q==
X-Received: by 2002:a17:902:da8d:b029:e5:c7d9:81f2 with SMTP id j13-20020a170902da8db02900e5c7d981f2mr14997546plx.21.1616173096574;
        Fri, 19 Mar 2021 09:58:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:a05c:c77f:8a41:973d])
        by smtp.gmail.com with UTF8SMTPSA id i7sm5289723pgq.16.2021.03.19.09.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:58:16 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 2/2] iio: sx9310: Support ACPI properties
Date:   Fri, 19 Mar 2021 09:58:07 -0700
Message-Id: <20210319165807.3639636-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210319165807.3639636-1-gwendal@chromium.org>
References: <20210319165807.3639636-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device_property_read_... to support both device tree and ACPI
bindings when reading the properties we need to configure the SAR
sensor.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index cbca965889f14..80cc8dc3f2d9c 100644
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
-							ARRAY_SIZE(combined));
+		count = device_property_read_u32_array(dev, "semtech,combined-sensors", NULL, 0);
 		if (count > 0 && count <= ARRAY_SIZE(combined)) {
-			ret = of_property_read_u32_array(np, "semtech,combined-sensors",
-							 combined, count);
+			ret = device_property_read_u32_array(dev, "semtech,combined-sensors",
+							   combined, count);
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

