Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28D444F7E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 08:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhKDHP5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 03:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhKDHPz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 03:15:55 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB6C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 00:13:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q126so720755pgq.13
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 00:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05Y5kRq2IplH4OPJXVrsOwqXK6fCQ/WRTagKPWjUmXA=;
        b=XgX5kYOHnhhODmjSweitElAlwSiHXwsovvuAx+0K4St/Btanrmng0n5qGjBOmS1zP3
         +haTJYzPVzvxYoldfcBKVX+bH4ZK2eV2kdMElgDkMlbfk7GFfbMk2PuAnRPfWRKdGAVR
         Lqa+miu8s/bOQlxovoJrNsxy3JAy3KaU9IKc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05Y5kRq2IplH4OPJXVrsOwqXK6fCQ/WRTagKPWjUmXA=;
        b=GRVNRI1+94weXTHa+7VQcNv3Pga1otKC1ik9CpH+D3eCbvitbsngxjL8ripb0+2Zfu
         d7oXp+ZzgU2RG9bowV10BFYs+QzEDe521SccPVFbqUnWW5EVy5Cjn2MqOX9U71XMSaoS
         yiBmyeQyMtj/SPp1bpwbObLIWBE3Z51tGAipd11uwcw2n/7xUeKBElNnYhrAHSGZrGGn
         HHqbWkPEvI0WfqBwsyaTKrS5ecnTVbr4myoPcwfQPGOoKAkPDnS7KU3w7WRaYqAM8unO
         2UVYod2tuEG2Y4MD99stvjy0OWZjEx3bsdUI2rs4hAuuc7diZ9JD/XYy31YUelmpswCB
         rdUg==
X-Gm-Message-State: AOAM533634db/0yg6AF0YajLHUbvrqVm49n4SSA3WOXtq+89+lKxnPyd
        LG8avyf/EXAX95OnxKzP+oXA/spzn+GpjQ==
X-Google-Smtp-Source: ABdhPJykRJPbJ4z2bvk8FZ/ZsVBMHexwg4gsqrXgHow78H2lXwAsaqI7bwxBB2ozfuTf+eTOM3ZniQ==
X-Received: by 2002:aa7:8d44:0:b0:47b:ee6c:5ca4 with SMTP id s4-20020aa78d44000000b0047bee6c5ca4mr50451629pfe.49.1636009997545;
        Thu, 04 Nov 2021 00:13:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id a8sm3447214pgd.8.2021.11.04.00.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 00:13:17 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 5/5] iio: sx9324: Add dt_bidding support
Date:   Thu,  4 Nov 2021 00:13:03 -0700
Message-Id: <20211104071303.3604314-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211104071303.3604314-1-gwendal@chromium.org>
References: <20211104071303.3604314-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Based on bindings/iio/proximity/semtech,sx9324.yaml, implement
retrieving sensor hardware property and alter default values.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
- Use new interface.

 drivers/iio/proximity/sx9324.c | 157 +++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 943a243a4d71c..4a12b6c8c2c3a 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -756,6 +756,74 @@ static int sx9324_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static const struct sx_common_reg_default sx9324_default_regs[] = {
+	{ SX9324_REG_IRQ_MSK, 0x00 },
+	{ SX9324_REG_IRQ_CFG0, 0x00 },
+	{ SX9324_REG_IRQ_CFG1, SX9324_REG_IRQ_CFG1_FAILCOND },
+	{ SX9324_REG_IRQ_CFG2, 0x00 },
+	{ SX9324_REG_GNRL_CTRL0, SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS },
+	/*
+	 * The lower 4 bits should not be set as it enable sensors measurements.
+	 * Turning the detection on before the configuration values are set to
+	 * good values can cause the device to return erroneous readings.
+	 */
+	{ SX9324_REG_GNRL_CTRL1, SX9324_REG_GNRL_CTRL1_PAUSECTRL },
+
+	{ SX9324_REG_AFE_CTRL0, 0x00 },
+	{ SX9324_REG_AFE_CTRL3, 0x00 },
+	{ SX9324_REG_AFE_CTRL4, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
+		SX9324_REG_AFE_CTRL4_RES_100 },
+	{ SX9324_REG_AFE_CTRL6, 0x00 },
+	{ SX9324_REG_AFE_CTRL7, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
+		SX9324_REG_AFE_CTRL4_RES_100 },
+
+	/* TODO(gwendal): PHx use chip default or all grounded? */
+	{ SX9324_REG_AFE_PH0, 0x29 },
+	{ SX9324_REG_AFE_PH1, 0x26 },
+	{ SX9324_REG_AFE_PH2, 0x1a },
+	{ SX9324_REG_AFE_PH3, 0x16 },
+
+	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM },
+	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
+
+	{ SX9324_REG_PROX_CTRL0, SX9324_REG_PROX_CTRL0_GAIN_1 |
+		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
+	{ SX9324_REG_PROX_CTRL1, SX9324_REG_PROX_CTRL0_GAIN_1 |
+		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
+	{ SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K },
+	{ SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
+		SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K },
+	{ SX9324_REG_PROX_CTRL4, SX9324_REG_PROX_CTRL4_AVGNEG_FILT_1P50 |
+		SX9324_REG_PROX_CTRL3_AVGPOS_FILT_1P256},
+	{ SX9324_REG_PROX_CTRL5, 0x00 },
+	{ SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
+	{ SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
+	{ SX9324_REG_ADV_CTRL0, 0x00 },
+	{ SX9324_REG_ADV_CTRL1, 0x00 },
+	{ SX9324_REG_ADV_CTRL2, 0x00 },
+	{ SX9324_REG_ADV_CTRL3, 0x00 },
+	{ SX9324_REG_ADV_CTRL4, 0x00 },
+	{ SX9324_REG_ADV_CTRL5, SX9324_REG_ADV_CTRL5_STARTUP_SENSOR_1 |
+		SX9324_REG_ADV_CTRL5_STARTUP_METHOD_1 },
+	{ SX9324_REG_ADV_CTRL6, 0x00 },
+	{ SX9324_REG_ADV_CTRL7, 0x00 },
+	{ SX9324_REG_ADV_CTRL8, 0x00 },
+	{ SX9324_REG_ADV_CTRL9, 0x00 },
+	/* Body/Table threshold */
+	{ SX9324_REG_ADV_CTRL10, 0x00 },
+	{ SX9324_REG_ADV_CTRL11, 0x00 },
+	{ SX9324_REG_ADV_CTRL12, 0x00 },
+	/* TODO(gwendal): SAR currenly disabled */
+	{ SX9324_REG_ADV_CTRL13, 0x00 },
+	{ SX9324_REG_ADV_CTRL14, 0x00 },
+	{ SX9324_REG_ADV_CTRL15, 0x00 },
+	{ SX9324_REG_ADV_CTRL16, 0x00 },
+	{ SX9324_REG_ADV_CTRL17, 0x00 },
+	{ SX9324_REG_ADV_CTRL18, 0x00 },
+	{ SX9324_REG_ADV_CTRL19, SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
+	{ SX9324_REG_ADV_CTRL20, SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
+};
+
 /* Activate all channels and perform an initial compensation. */
 static int sx9324_init_compensation(struct iio_dev *indio_dev)
 {
@@ -780,6 +848,93 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static const struct sx_common_reg_default *
+sx9324_get_default_reg(struct device *dev, int idx,
+		       struct sx_common_reg_default *reg_def)
+{
+#define SX9324_PIN_DEF "semtech,ph0-pin"
+#define SX9324_RESOLUTION_DEF "semtech,resolution01"
+	unsigned int pin_defs[SX9324_NUM_PINS];
+	char prop[] = SX9324_RESOLUTION_DEF;
+	u32 start = 0, raw = 0, pos = 0;
+	int ret, count, ph, pin;
+
+	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
+	switch (reg_def->reg) {
+	case SX9324_REG_AFE_PH0:
+	case SX9324_REG_AFE_PH1:
+	case SX9324_REG_AFE_PH2:
+	case SX9324_REG_AFE_PH3:
+		ph = reg_def->reg - SX9324_REG_AFE_PH0;
+		scnprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
+
+		count = device_property_count_u32(dev, prop);
+		if (count != ARRAY_SIZE(pin_defs))
+			break;
+		ret = device_property_read_u32_array(dev, prop, pin_defs,
+						     ARRAY_SIZE(pin_defs));
+		for (pin = 0; pin < SX9324_NUM_PINS; pin++)
+			raw |= (pin_defs[pin] << (2 * pin)) &
+			       SX9324_REG_AFE_PH0_PIN_MASK(pin);
+		reg_def->def = raw;
+		break;
+	case SX9324_REG_AFE_CTRL4:
+	case SX9324_REG_AFE_CTRL7:
+		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
+			strncpy(prop, "semtech,resolution01", ARRAY_SIZE(prop));
+		else
+			strncpy(prop, "semtech,resolution23", ARRAY_SIZE(prop));
+
+		ret = device_property_read_u32(dev, prop, &raw);
+		if (ret)
+			raw = FIELD_GET(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
+					reg_def->def);
+		else
+			raw = ilog2(raw);
+
+		reg_def->def &= ~SX9324_REG_AFE_CTRL4_RESOLUTION_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
+					   raw);
+		break;
+	case SX9324_REG_ADV_CTRL5:
+		ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
+		if (ret)
+			break;
+
+		reg_def->def &= ~SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK,
+					   start);
+		break;
+	case SX9324_REG_PROX_CTRL4:
+		ret = device_property_read_u32(dev, "semtech,avg-neg-strength", &pos);
+		if (ret) {
+			raw = FIELD_GET(SX9324_REG_PROX_CTRL4_AVGNEGFILT_MASK,
+					reg_def->def);
+		} else {
+			/* Powers of 2, except for a gap between 16 and 64 */
+			raw = clamp(ilog2(pos), 3, 11) - (pos >= 32 ? 4 : 3);
+		}
+		reg_def->def &= ~SX9324_REG_PROX_CTRL4_AVGNEGFILT_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_PROX_CTRL4_AVGNEGFILT_MASK,
+					   raw);
+
+		ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
+		if (ret) {
+			raw = FIELD_GET(SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK,
+					reg_def->def);
+		} else {
+			/* Powers of 2, except for a gap between 16 and 64 */
+			raw = clamp(ilog2(pos), 3, 11) - (pos >= 32 ? 4 : 3);
+		}
+		reg_def->def &= ~SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK,
+					   raw);
+		break;
+	}
+
+	return reg_def;
+}
+
 static int sx9324_check_whoami(struct device *dev,
 			       struct iio_dev *indio_dev)
 {
@@ -821,12 +976,14 @@ static const struct sx_common_chip_info sx9324_chip_info = {
 	.mask_enable_chan = SX9324_REG_GNRL_CTRL1_PHEN_MASK,
 	.irq_msk_offset = 3,
 	.num_channels = SX9324_NUM_CHANNELS,
+	.num_default_regs = ARRAY_SIZE(sx9324_default_regs),
 
 	.ops = {
 		.read_prox_data = sx9324_read_prox_data,
 		.check_whoami = sx9324_check_whoami,
 		.init_compensation = sx9324_init_compensation,
 		.wait_for_sample = sx9324_wait_for_sample,
+		.get_default_reg = sx9324_get_default_reg,
 	},
 
 	.iio_channels = sx9324_channels,
-- 
2.33.1.1089.g2158813163f-goog

