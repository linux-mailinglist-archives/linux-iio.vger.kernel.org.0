Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B5440881
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhJ3LVK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhJ3LVJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Oct 2021 07:21:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68AFC061570
        for <linux-iio@vger.kernel.org>; Sat, 30 Oct 2021 04:18:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y20so949344pfi.4
        for <linux-iio@vger.kernel.org>; Sat, 30 Oct 2021 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBJroVDNSaN+WLU1voLJAhsjyS9SiQFPr98bjLaVmNU=;
        b=jCtZc/ex8lqxSl3cy5RMius+QLBeas0ANpdEsREosQ+x+1fT1fJyg/UPVmihQOxJNn
         zmHO0LLszDuoJVKvyfJtdB6LLltENm0evaPyFGY1gKn1tr99T8ePgkvj3nmuo7z91hUT
         BH2NMiONAO4yFk2D9oUcAE9MIhJBk36OwMq6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBJroVDNSaN+WLU1voLJAhsjyS9SiQFPr98bjLaVmNU=;
        b=cSmF3NkF8AI5gpCiqmRhKzzihZtp0PHgOHz0HoGPmEtH6c4KyGrBB8CXVLAB7BP8nt
         7gfG6NO2P/tqmSEcQOR5GDgw2DHSPre3MO8nrLy4F9uHVpkHPSV5bt+HVxXVuLUBQoqX
         mOd7ccD+U9eJkEvT3n2hKtAcMisvqkWMpG7Ba1Q6tJnElq0Hl/j2mJb2wOYn4o/Edg7C
         DB9nqY2PGKzauZ0o+Rlgo+9oaITfMQ0i38ndqAyAZJuRbxEG6cBTIXQ08vjdftZv6+7u
         ECBKYFO4ZkeDmbmA3jj2FyrufSFnEgs3JDMMGFV+l7rRfRMiIuh3rtnNA8e8FP47jSCd
         lC5Q==
X-Gm-Message-State: AOAM532cTQswCWlYHEN9fBfMcGMG9EGOZPpKgHK8pS0IKtilxFzwzGL1
        oB99Wgp2AgE8+EAKlCywS/Cc0g==
X-Google-Smtp-Source: ABdhPJwmnZGrEXaPbKL03W9655F1RiLJ3xAT9F0vf9yabd7glmuO394inYEBxbhtIMhyS670R6j8bg==
X-Received: by 2002:a05:6a00:c81:b029:30e:21bf:4c15 with SMTP id a1-20020a056a000c81b029030e21bf4c15mr16538027pfv.70.1635592719181;
        Sat, 30 Oct 2021 04:18:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:71f1:234f:bb3d:6ccf])
        by smtp.gmail.com with UTF8SMTPSA id f18sm2555838pfv.74.2021.10.30.04.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 04:18:38 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 5/5] iio: sx9324: Add dt_bidding support
Date:   Sat, 30 Oct 2021 04:18:27 -0700
Message-Id: <20211030111827.1494139-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211030111827.1494139-1-gwendal@chromium.org>
References: <20211030111827.1494139-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Based on bindings/iio/proximity/semtech,sx9324.yaml, implement
retrieving sensor hardware property and alter default values.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9324.c | 159 +++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 41d9c950c5abd..5f2e10d74f058 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -780,6 +780,74 @@ static const struct iio_info sx9324_info = {
 	.write_event_config = sx_common_write_event_config,
 };
 
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
@@ -804,6 +872,93 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
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
 static int sx9324_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -825,6 +980,9 @@ static int sx9324_probe(struct i2c_client *client)
 	data->irq_msk_offset = 3;
 	data->num_channels = SX9324_NUM_CHANNELS;
 
+	/* Number of default registers to set at init */
+	data->num_default_regs = ARRAY_SIZE(sx9324_default_regs);
+
 	ret = sx_common_probe_setup(indio_dev, client, &sx9324_regmap_config);
 	if (ret)
 		return ret;
@@ -839,6 +997,7 @@ static int sx9324_probe(struct i2c_client *client)
 	data->read_prox_data = sx9324_read_prox_data;
 	data->init_compensation = sx9324_init_compensation;
 	data->wait_for_sample = sx9324_wait_for_sample;
+	data->get_default_reg = sx9324_get_default_reg;
 
 	indio_dev->channels = sx9324_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sx9324_channels);
-- 
2.33.1.1089.g2158813163f-goog

