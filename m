Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6338470A52
	for <lists+linux-iio@lfdr.de>; Fri, 10 Dec 2021 20:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbhLJT1T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Dec 2021 14:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343607AbhLJT1S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Dec 2021 14:27:18 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A42C0617A2
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 11:23:43 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r138so8831575pgr.13
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 11:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFfiAe0MuGYrAK/IIcq29iUImtn61nK8r1iD0HXm+Ic=;
        b=NNZZLEeq/QsANElXblIxJIzSy/GOV9MfMKIfKuD4dtTQ3yO2S9O73qUaj4r895NeKY
         jUDfGwPyb6haRmfQDyk18OZRa9qbvpH1etZZXbpEArvMRbrOngqNU5GAIke98WloFz+X
         wn7w69K/c/PIv3uTYp29GarbjCQOUBZHBM2RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFfiAe0MuGYrAK/IIcq29iUImtn61nK8r1iD0HXm+Ic=;
        b=dpTZd6eQgntPxlBxqRjTFZLDi2PqrhKGux9pWKSsBM4UYFyghldw73u7fHIurvvyBO
         C7uvk33CPNFtR8IUIosseDbYXHBhfAySftKVo5AKmTgzGovn24myABXOUwFyrBzkTptr
         Zd+B9VcSvTE1934gM/mEopSPGIwxFyIT9aB1rs2rkvoPs+lUoLHMEq7r+w7wEORW+SuK
         qIJpmk+nJVmROjVcwVOkI4cpabeb1++Z5GbdSf4lLpEAZuXL8Zq+gWV2IWgigLBvVddu
         2dmFXHL+fhU74MeN9mQ8zO7FFL6Bh+MT8pB/lastaiD4RSzSWH5NPtpdeXPvREhDhyIU
         J2Yw==
X-Gm-Message-State: AOAM532FPdSRTlfkJwtxEcdC6UijjMz+qsxVc3huE0mDcv+eoUeAmr53
        ZAQ1MVM8vL5FjukStnZTBYx7IA==
X-Google-Smtp-Source: ABdhPJxWh2UvIY1PCqNvIQ3mVye3fhphNKoE28HmeOXoy/QDSC+JjE98ILOYx+HiOOMGyz7E+cOxkw==
X-Received: by 2002:a63:710d:: with SMTP id m13mr40295295pgc.545.1639164222738;
        Fri, 10 Dec 2021 11:23:42 -0800 (PST)
Received: from localhost ([2620:15c:202:201:16de:af23:a52f:63b])
        by smtp.gmail.com with UTF8SMTPSA id h6sm4070644pfh.82.2021.12.10.11.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:23:42 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 5/5] iio: sx9324: Add dt_binding support
Date:   Fri, 10 Dec 2021 11:23:28 -0800
Message-Id: <20211210192328.2844060-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211210192328.2844060-1-gwendal@chromium.org>
References: <20211210192328.2844060-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Based on bindings/iio/proximity/semtech,sx9324.yaml, implement
retrieving sensor hardware property and alter default values.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v7
No changes in v6.
Changes in v5:
- Use prefixed binding names.
- Fix long lines.

Changes in v4:
- Fix spelling in commit title.

Changes in v3:
- Remove duplicate information.
- Use intervals instead of enum.
- Fix filter description.

Changes in v2:
- Fix interrupt documentation wording.

 drivers/iio/proximity/sx9324.c | 164 +++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index ed7ac30e1915d5..78a173aeccf5ac 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -77,6 +77,7 @@
 #define SX9324_REG_PROX_CTRL0		0x30
 #define SX9324_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
 #define SX9324_REG_PROX_CTRL0_GAIN_1		0x80
+#define SX9324_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9324_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9324_REG_PROX_CTRL1		0x31
 #define SX9324_REG_PROX_CTRL2		0x32
@@ -753,6 +754,74 @@ static int sx9324_write_raw(struct iio_dev *indio_dev,
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
+	{ SX9324_REG_PROX_CTRL4, SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 |
+		SX9324_REG_PROX_CTRL3_AVGPOS_FILT_256 },
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
@@ -777,6 +846,99 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static const struct sx_common_reg_default *
+sx9324_get_default_reg(struct device *dev, int idx,
+		       struct sx_common_reg_default *reg_def)
+{
+#define SX9324_PIN_DEF "semtech,ph0-pin"
+#define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
+#define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
+	unsigned int pin_defs[SX9324_NUM_PINS];
+	char prop[] = SX9324_PROXRAW_DEF;
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
+			strncpy(prop, "semtech,ph01-resolution",
+				ARRAY_SIZE(prop));
+		else
+			strncpy(prop, "semtech,ph23-resolution",
+				ARRAY_SIZE(prop));
+
+		ret = device_property_read_u32(dev, prop, &raw);
+		if (ret)
+			break;
+
+		raw = ilog2(raw) - 3;
+
+		reg_def->def &= ~SX9324_REG_AFE_CTRL4_RESOLUTION_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
+					   raw);
+		break;
+	case SX9324_REG_ADV_CTRL5:
+		ret = device_property_read_u32(dev, "semtech,startup-sensor",
+					       &start);
+		if (ret)
+			break;
+
+		reg_def->def &= ~SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK,
+					   start);
+		break;
+	case SX9324_REG_PROX_CTRL4:
+		ret = device_property_read_u32(dev, "semtech,avg-pos-strength",
+					       &pos);
+		if (ret)
+			break;
+
+		/* Powers of 2, except for a gap between 16 and 64 */
+		raw = clamp(ilog2(pos), 3, 11) - (pos >= 32 ? 4 : 3);
+
+		reg_def->def &= ~SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK,
+					   raw);
+		break;
+	case SX9324_REG_PROX_CTRL0:
+	case SX9324_REG_PROX_CTRL1:
+		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
+			strncpy(prop, "semtech,ph01-proxraw-strength",
+				ARRAY_SIZE(prop));
+		else
+			strncpy(prop, "semtech,ph23-proxraw-strength",
+				ARRAY_SIZE(prop));
+		ret = device_property_read_u32(dev, prop, &raw);
+		if (ret)
+			break;
+
+		reg_def->def &= ~SX9324_REG_PROX_CTRL0_RAWFILT_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_PROX_CTRL0_RAWFILT_MASK,
+					   raw);
+		break;
+	}
+	return reg_def;
+}
+
 static int sx9324_check_whoami(struct device *dev,
 			       struct iio_dev *indio_dev)
 {
@@ -797,12 +959,14 @@ static const struct sx_common_chip_info sx9324_chip_info = {
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
2.34.1.173.g76aa8bc2d0-goog

