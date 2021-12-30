Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3A481990
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 06:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhL3FPQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 00:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhL3FPP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 00:15:15 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B09C061574
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 21:15:14 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso22127522pjb.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 21:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfeABbG6asfCS+TR8D2ShUJPYsYplvYbvR31K9QxU5o=;
        b=J5WRUfOlbNRrg+0nhzrRPvoiDEuBCVnIu6GXuuQ4o69dFFDLk4mADiadi/XZrPDxzN
         2JsGQuWNcSrdx2JfZ86CXq5cI3TgaF06UNAbD96BWl2RWc7W5DogkQua4h5oItdHNkIA
         UZ9jPqk3tNnD+bNPSTjKxnsweKGWojU5ZpFEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfeABbG6asfCS+TR8D2ShUJPYsYplvYbvR31K9QxU5o=;
        b=KIARGATYzn7+ZVcUc9OF/N75EU3ZTESTeL/1TqRE62a6QrIGrImiG+czn0/KcShr6k
         BI4Q86fz6D9LvOwatGyi3oNZ7KC7aoADOYL1p0YtGREx8IMfW5d+JhgtsjsATozElKly
         fNfvjPH58bEmGPvNjkmcMCmNc7rEbc0jgafWy9tqeDMZiCKgCPUYqzw1Sz7JN+GdmDiv
         QfhnXPD7+xkuh0qnMrqngtkhVq7pij4DKpYCwjRT7BQs78A/fwQLeAChGVuxLoRTGPxm
         6+v9MldJaQ250QcQJuedZEFqk5ZfoldFJPT7Sf7BF0lU/+Ooh0g2gS894oaNDLPqz5gp
         VA2Q==
X-Gm-Message-State: AOAM5331JQV2VOupp/PwRGndwIjVZ+I64voIjF85cqI0RuioxS/z0I8w
        mtrDSQfa0RhjNbzJNObrWW3jsQ==
X-Google-Smtp-Source: ABdhPJzVGGFcyqUCbI2wnItUEhpe93AEdwyFUU832owPjRzXHqZ+VFh4BW0M7324ezJGIyhfSY2hYw==
X-Received: by 2002:a17:902:8c96:b0:149:88bb:ac54 with SMTP id t22-20020a1709028c9600b0014988bbac54mr14479132plo.18.1640841314166;
        Wed, 29 Dec 2021 21:15:14 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f2cb:bddc:361b:5398])
        by smtp.gmail.com with UTF8SMTPSA id h4sm26720392pfi.79.2021.12.29.21.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 21:15:13 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v5 3/3] iio: sx9360: Add dt-binding support
Date:   Wed, 29 Dec 2021 21:15:07 -0800
Message-Id: <20211230051507.1053806-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211230051507.1053806-1-gwendal@chromium.org>
References: <20211230051507.1053806-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to configure sx9360 from dt-binding, to match device
hardware setup.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
No changes in v5.
Changes since v3:
- Concatenate 2 lines.

Changes since v2:
- Add include when needed.
- Move default register constant to main patch.

No changes in v2.

 drivers/iio/proximity/sx9360.c | 84 ++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 83d8061a4c743c..884d1e61c9e8b8 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -18,6 +18,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
@@ -64,6 +65,7 @@
 #define SX9360_REG_PROX_CTRL0_PHM	0x41
 #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
 #define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
+#define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9360_REG_PROX_CTRL1		0x42
 #define SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_MASK	GENMASK(5, 3)
@@ -657,6 +659,41 @@ static int sx9360_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static const struct sx_common_reg_default sx9360_default_regs[] = {
+	{ SX9360_REG_IRQ_MSK, 0x00 },
+	{ SX9360_REG_IRQ_CFG, 0x00 },
+	/*
+	 * The lower 2 bits should not be set as it enable sensors measurements.
+	 * Turning the detection on before the configuration values are set to
+	 * good values can cause the device to return erroneous readings.
+	 */
+	{ SX9360_REG_GNRL_CTRL0, 0x00 },
+	{ SX9360_REG_GNRL_CTRL1, 0x00 },
+	{ SX9360_REG_GNRL_CTRL2, SX9360_REG_GNRL_CTRL2_PERIOD_102MS },
+
+	{ SX9360_REG_AFE_CTRL1, 0x00 },
+	{ SX9360_REG_AFE_PARAM0_PHR, SX9360_REG_AFE_PARAM0_RSVD |
+		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
+	{ SX9360_REG_AFE_PARAM1_PHR, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
+		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
+	{ SX9360_REG_AFE_PARAM0_PHM, SX9360_REG_AFE_PARAM0_RSVD |
+		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
+	{ SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
+		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
+
+	{ SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
+		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
+	{ SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
+		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
+	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K },
+	{ SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |
+		SX9360_REG_PROX_CTRL2_AVGPOS_THRESH_16K },
+	{ SX9360_REG_PROX_CTRL3, SX9360_REG_PROX_CTRL3_AVGNEG_FILT_2 |
+		SX9360_REG_PROX_CTRL3_AVGPOS_FILT_256 },
+	{ SX9360_REG_PROX_CTRL4, 0x00 },
+	{ SX9360_REG_PROX_CTRL5, SX9360_REG_PROX_CTRL5_PROXTHRESH_32 },
+};
+
 /* Activate all channels and perform an initial compensation. */
 static int sx9360_init_compensation(struct iio_dev *indio_dev)
 {
@@ -676,6 +713,51 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
 				       20000, 2000000);
 }
 
+static const struct sx_common_reg_default *
+sx9360_get_default_reg(struct device *dev, int idx,
+		       struct sx_common_reg_default *reg_def)
+{
+	u32 raw = 0, pos = 0;
+	int ret;
+
+	memcpy(reg_def, &sx9360_default_regs[idx], sizeof(*reg_def));
+	switch (reg_def->reg) {
+	case SX9360_REG_AFE_PARAM0_PHR:
+	case SX9360_REG_AFE_PARAM0_PHM:
+		ret = device_property_read_u32(dev, "semtech,resolution", &raw);
+		if (ret)
+			break;
+
+		raw = ilog2(raw) - 3;
+
+		reg_def->def &= ~SX9360_REG_AFE_PARAM0_RESOLUTION_MASK;
+		reg_def->def |= FIELD_PREP(SX9360_REG_AFE_PARAM0_RESOLUTION_MASK, raw);
+		break;
+	case SX9360_REG_PROX_CTRL0_PHR:
+	case SX9360_REG_PROX_CTRL0_PHM:
+		ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
+		if (ret)
+			break;
+
+		reg_def->def &= ~SX9360_REG_PROX_CTRL0_RAWFILT_MASK;
+		reg_def->def |= FIELD_PREP(SX9360_REG_PROX_CTRL0_RAWFILT_MASK, raw);
+		break;
+	case SX9360_REG_PROX_CTRL3:
+		ret = device_property_read_u32(dev, "semtech,avg-pos-strength",
+					       &pos);
+		if (ret)
+			break;
+
+		/* Powers of 2, except for a gap between 16 and 64 */
+		raw = clamp(ilog2(pos), 3, 11) - (pos >= 32 ? 4 : 3);
+		reg_def->def &= ~SX9360_REG_PROX_CTRL3_AVGPOS_FILT_MASK;
+		reg_def->def |= FIELD_PREP(SX9360_REG_PROX_CTRL3_AVGPOS_FILT_MASK, raw);
+		break;
+	}
+
+	return reg_def;
+}
+
 static int sx9360_check_whoami(struct device *dev, struct iio_dev *indio_dev)
 {
 	/*
@@ -695,12 +777,14 @@ static const struct sx_common_chip_info sx9360_chip_info = {
 	.mask_enable_chan = SX9360_REG_GNRL_CTRL0_PHEN_MASK,
 	.stat_offset = 3,
 	.num_channels = SX9360_NUM_CHANNELS,
+	.num_default_regs = ARRAY_SIZE(sx9360_default_regs),
 
 	.ops = {
 		.read_prox_data = sx9360_read_prox_data,
 		.check_whoami = sx9360_check_whoami,
 		.init_compensation = sx9360_init_compensation,
 		.wait_for_sample = sx9360_wait_for_sample,
+		.get_default_reg = sx9360_get_default_reg,
 	},
 
 	.iio_channels = sx9360_channels,
-- 
2.34.1.448.ga2b2bfdf31-goog

