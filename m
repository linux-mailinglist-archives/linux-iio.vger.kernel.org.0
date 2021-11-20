Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5E457CE2
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 11:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbhKTK3o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 05:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhKTK3o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Nov 2021 05:29:44 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B32C061574
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:26:41 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id r130so11510113pfc.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qV7b3ZWQ+wxEdGJDbxtP8gwASUb/8zNiJoC4nwnf6pc=;
        b=h2DX772DMgBDi0bC5W7EdA3h8zwYq4K74uv+yUtK7Xf9eilv/HwsJyv82dUPHQQm+m
         bjhmQZqvZUwnhRFPM6y4e78vJGXxix4pNbscoKU05kSiHI63U84eqvnRPBXl92YJAkkA
         LjrpE1ZlfltklLrB/Q9ujrlRzUowpb8Bqsh14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qV7b3ZWQ+wxEdGJDbxtP8gwASUb/8zNiJoC4nwnf6pc=;
        b=kg8hZ1aWfyzszWnsc0ZxGCeHgidahGKCk4Fm04pQ5pp/910SxuukMLxfUaER5vCfCW
         DR9lC0DtrH2EgWYI2v0v7a+VtAxuIIbXMmnHxrClc7IDPC5+8Br7F3ZMEJYOZmJkma8T
         de5YDN02gocdVwITfeK3/nzxOXKogZ5lNu5k9caRNqcuphK+DUw3ti8QkwwZo/qW4GV4
         janGi9hUoG5RXsttEi4rh2uTnOMXRWpWu48FoTGlSPKzMv97XQBC9MYl/npF8yyolKZW
         5rKRb8OpRzOhjnquitBg7xuojpm+yLRFDeuG2KXMrzuj9Ib1Z7l547u6gx7dieG4orfW
         1ORg==
X-Gm-Message-State: AOAM530+vOh+X+XR06CD94K7BUSbcqqywDnb5gu+bj+8GrxKeXXwcx4a
        LZulM0WG+Pz+BrzBsv1mo8x8ZA==
X-Google-Smtp-Source: ABdhPJzmkaclHLTLs7vF7HbpquhyNDcJ/1OsmTTG+9AqVgnbOB7MHjIrIp331Rvbhv6FJFstxmqVOQ==
X-Received: by 2002:a05:6a00:70e:b0:480:be26:6240 with SMTP id 14-20020a056a00070e00b00480be266240mr68448394pfl.30.1637404000910;
        Sat, 20 Nov 2021 02:26:40 -0800 (PST)
Received: from localhost ([2620:15c:202:201:913f:8f64:e1fa:a751])
        by smtp.gmail.com with UTF8SMTPSA id i10sm1921922pjd.3.2021.11.20.02.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 02:26:40 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 3/3] iio: sx9360: Add dt-binding support
Date:   Sat, 20 Nov 2021 02:26:34 -0800
Message-Id: <20211120102634.1688190-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211120102634.1688190-1-gwendal@chromium.org>
References: <20211120102634.1688190-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to configure sx9360 from dt-binding, to match device
hardware setup.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v2.

 drivers/iio/proximity/sx9360.c | 85 +++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 5d909c7dfa1d75..3930a3c53b2380 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -58,7 +58,7 @@
 #define SX9360_REG_AFE_PARAM0_PHR	0x22
 #define SX9360_REG_AFE_PARAM1_PHR	0x23
 #define SX9360_REG_AFE_PARAM0_PHM	0x24
-#define SX9360_REG_AFE_PARAM0_RSVD		0x04
+#define SX9360_REG_AFE_PARAM0_RSVD		0x08
 #define SX9360_REG_AFE_PARAM0_RESOLUTION_MASK	GENMASK(2, 0)
 #define SX9360_REG_AFE_PARAM0_RESOLUTION_128	0x02
 #define SX9360_REG_AFE_PARAM1_PHM	0x25
@@ -69,6 +69,7 @@
 #define SX9360_REG_PROX_CTRL0_PHM	0x41
 #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
 #define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
+#define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9360_REG_PROX_CTRL1		0x42
 #define SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_MASK	GENMASK(5, 3)
@@ -646,6 +647,41 @@ static int sx9360_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
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
@@ -670,6 +706,51 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
 	return ret;
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
 static int sx9360_check_whoami(struct device *dev,
 			       struct iio_dev *indio_dev)
 {
@@ -690,12 +771,14 @@ static const struct sx_common_chip_info sx9360_chip_info = {
 	.mask_enable_chan = SX9360_REG_GNRL_CTRL0_PHEN_MASK,
 	.irq_msk_offset = 0,
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
2.34.0.rc2.393.gf8c9666880-goog

