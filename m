Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B12454371
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 10:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhKQJT7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 04:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhKQJT7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Nov 2021 04:19:59 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0872C061570
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 01:17:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso2041177pjb.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 01:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoEndHIjDS5QtqSn7nsE7eg2fEa1s+n7/6Rlza0ycT8=;
        b=XuqSJRty05el1iJbLgH8rqQ3vmQE0AF49iWI5Is84X/DXS43PYzZFqGn7Jk3lVq2+m
         VJ0kuPocPLyPXT3xVczfX7RgARqFmEFDmhFe8LYHPAc0b6Yiek4VDEwTqDrWYPibojSa
         v+kNzF9vjFsfLxFYbPAUmxLsd8/6MCvZRoxsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoEndHIjDS5QtqSn7nsE7eg2fEa1s+n7/6Rlza0ycT8=;
        b=XOSh+eXgPFTtuNKBP42de5QM4aq9I+KDgI5FGA1tUDhHmJRkCaYlop9SrUx/Mhiczq
         zT4OzZdN2X85B5Befhe2BxYVZX4ygfPXYYwhPYAKvxIE2NNITGLELGgvYAR/YESvdW4F
         zEABePLMmggAZG6EIi0nVDARyGvePxWwQBgiF0MIP8hxKIGkUrY3zloZrU0ORqdqg5v0
         BURckUXQq4KBVKWt8jZygEe70gvaunQTC20C7qvgEBhMmxbiThXLt3SsbgFvyEoLuj6t
         bVhpXJFrLBdwiUP5pa4jy+GCRAMck/GwOxlVwprmUTFbWXcaJznlMQl17+EpivC40SwW
         2gxw==
X-Gm-Message-State: AOAM530EZaJmvvW+EADt1016LxZvod2s9ESgn+kon5MbVI385zUav3Zk
        LpQOPzR9+Yd5AjIDMDxfBVoJMw==
X-Google-Smtp-Source: ABdhPJwa1FmHLWiltGfNzlFKt3RnKD/br0ZUpwGiG78fnuYAEgByDLEIdIS+uZ9A8VaKIkw4yjSSJg==
X-Received: by 2002:a17:90a:cb98:: with SMTP id a24mr7646019pju.153.1637140620451;
        Wed, 17 Nov 2021 01:17:00 -0800 (PST)
Received: from localhost ([2620:15c:202:201:327f:7baa:380e:33a3])
        by smtp.gmail.com with UTF8SMTPSA id lx12sm5245417pjb.5.2021.11.17.01.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 01:17:00 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 3/3] iio: sx9360: Add dt-binding support
Date:   Wed, 17 Nov 2021 01:16:53 -0800
Message-Id: <20211117091653.2829677-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211117091653.2829677-1-gwendal@chromium.org>
References: <20211117091653.2829677-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to configure sx9360 from dt-binding, to match device
hardware setup.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9360.c | 85 +++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 28e6bb44ae49cc..0ac955036bd2bd 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -60,7 +60,7 @@
 #define SX9360_REG_AFE_PARAM0_PHR	0x22
 #define SX9360_REG_AFE_PARAM1_PHR	0x23
 #define SX9360_REG_AFE_PARAM0_PHM	0x24
-#define SX9360_REG_AFE_PARAM0_RSVD		0x04
+#define SX9360_REG_AFE_PARAM0_RSVD		0x08
 #define SX9360_REG_AFE_PARAM0_RESOLUTION_MASK	GENMASK(2, 0)
 #define SX9360_REG_AFE_PARAM0_RESOLUTION_128	0x02
 #define SX9360_REG_AFE_PARAM1_PHM	0x25
@@ -71,6 +71,7 @@
 #define SX9360_REG_PROX_CTRL0_PHM	0x41
 #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
 #define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
+#define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9360_REG_PROX_CTRL1		0x42
 #define SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_MASK	GENMASK(5, 3)
@@ -645,6 +646,41 @@ static int sx9360_write_raw(struct iio_dev *indio_dev,
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
@@ -669,6 +705,51 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
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
@@ -710,12 +791,14 @@ static const struct sx_common_chip_info sx9360_chip_info = {
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
2.34.0.rc1.387.gb447b232ab-goog

