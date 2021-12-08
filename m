Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F68646C987
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 01:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhLHAsw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Dec 2021 19:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbhLHAqy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Dec 2021 19:46:54 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C84FC061746
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 16:43:23 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id m15so562332pgu.11
        for <linux-iio@vger.kernel.org>; Tue, 07 Dec 2021 16:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4F4EbPUt7EtrJJvibYxN3NdN+PNF9DLnCpFTCxD5lMk=;
        b=TOb3TU7cQ7ks/8I6a4VY/xCwzY3O6iBur9qrMeefpyW0NwKWPaKUN2Iv0UzvfGf3Ax
         2LosrpgM9Wfk0tX+Csx8fBrsCBEP2onoYGyOCJ6B+6KuOHAW9wihYpxrN1z2ohRwcL+b
         N70NcNL1Muxv6NS6ALj+JnCHQVk8g7kumcAm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4F4EbPUt7EtrJJvibYxN3NdN+PNF9DLnCpFTCxD5lMk=;
        b=VTRLaJhKGOAtLRa59HaVk5QHA+J4gDZsZzxMul38SjYghjTV+AMvMUcim9Ew1l8D7L
         eIzSWSIc36MIdb6Nv/iBjO7gz13ZXWeAPZJWeoEXmgrxoac+4i5etIdE3baINb+YeF4E
         vK7z34HzkbqKdtwrUzZhRisuVGlL62bX/Xpgg+NRAOHpRBLb3BjI5+hm6l/wwrA8yhH7
         FC6LYGe22gg0SGMcTL1O7H0IDcZllPmxBvWzoEaqflYM0l5Kp6O/LeGzLE7DbjBHXATj
         XWO3TmxpbkFMU7RnZI+6BL2ehNsLIo0ydhuyZow6owO9ZDKf+pXjXjtziIgrzZzBvkMl
         HhZA==
X-Gm-Message-State: AOAM531B1TBv7puMQg837PE5klzkIWOeAzMX651Kkp//4IzvytnPw7GN
        Hwpu+XbXkV9MhjbAEwZ2gRVxXw==
X-Google-Smtp-Source: ABdhPJwGazY7VJWo2081XvR+Gz4S9zmg3+jXf+CQgckWYpuF3RlOYXpVTPIRVE8eXX20zIJBWvLvsA==
X-Received: by 2002:a63:2a8a:: with SMTP id q132mr26588624pgq.23.1638924202728;
        Tue, 07 Dec 2021 16:43:22 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e4:362a:40f4:7f9f])
        by smtp.gmail.com with UTF8SMTPSA id e4sm627490pgi.21.2021.12.07.16.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 16:43:22 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 5/5] iio: sx9324: Add dt_binding support
Date:   Tue,  7 Dec 2021 16:43:11 -0800
Message-Id: <20211208004311.3098571-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211208004311.3098571-1-gwendal@chromium.org>
References: <20211208004311.3098571-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Based on bindings/iio/proximity/semtech,sx9324.yaml, implement
retrieving sensor hardware property and alter default values.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
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
index a27aae64e6d4e1..86b7c83ea644e8 100644
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
@@ -751,6 +752,74 @@ static int sx9324_write_raw(struct iio_dev *indio_dev,
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
@@ -775,6 +844,99 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
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
@@ -795,12 +957,14 @@ static const struct sx_common_chip_info sx9324_chip_info = {
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
2.34.1.400.ga245620fadb-goog

