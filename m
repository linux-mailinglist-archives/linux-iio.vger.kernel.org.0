Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D60481962
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 05:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhL3Emx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Dec 2021 23:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbhL3Emx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Dec 2021 23:42:53 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D3C061574
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 20:42:53 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u20so20371158pfi.12
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 20:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMpcS01rsEfFXxIrm7d0ZIO33jyIKSoLzH0PbNakb5Q=;
        b=SnIgqVZVEuC3ayaOa1g885M/2DPd8eBC4UpcTs5+8vxG36ll4S2c2LocfJBGFGDhaQ
         eSySIW+jjzwaCFOG81CGDBQUdwoSwuaTs5AxOX1NGRXDC5eJDVgw9qJ5fok8ccJS7M8F
         XioxvfB0xd9iQkVzwdqlJz5TAL08XQB0UIVQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMpcS01rsEfFXxIrm7d0ZIO33jyIKSoLzH0PbNakb5Q=;
        b=Be3PPGJ5v8lVxUE0ik8ejtSNxZPXrZsH7ptR1+7h8sI5wN9Jz9b1Pw4qiOj31w4WZ4
         5XMDW8y2Ju0dcM6B5LZbexEtwKWF9bEzcQjD95GG6qXtDM6UvVpazcNnGK+mKng+IqTO
         OXaAkdjj/DEbqPOY9WN6jagXVKq8BwZP90m6NznyP9yDyiS/Q0BERhXhYVNQhpKt8DGl
         Yn6gqaTNkbQ4JmGOdhGQjVuEC7zC+cbsRqVVBpQ9KWhQCJGIWOKpo1Ui1PYrMLdBOsH8
         S6wgkJWnMvtjnyhiM1Xen4siHTOCF96XQOdoA0sXklfWJ5Z+vaD1B/xr7tiNNOWkaMsQ
         0qhw==
X-Gm-Message-State: AOAM531MCY7bzS+IBCH/k+WSU3JstKjoRLUIuwVBJvHaaOUZ5mt+BCKo
        gO19u87lKNPnQasW4VrM/dIdqA==
X-Google-Smtp-Source: ABdhPJxCcmBd0EJYFfJfH4GfP6NOYs0sIjIfLUIX/kOgsjgdc+ZNX9TSoNlbpqbFzBjxfpkKpH2ISA==
X-Received: by 2002:a63:348a:: with SMTP id b132mr20353034pga.204.1640839372936;
        Wed, 29 Dec 2021 20:42:52 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f2cb:bddc:361b:5398])
        by smtp.gmail.com with UTF8SMTPSA id hk13sm25909562pjb.35.2021.12.29.20.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 20:42:52 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v9 5/5] iio: sx9324: Add dt_binding support
Date:   Wed, 29 Dec 2021 20:42:42 -0800
Message-Id: <20211230044242.1024940-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211230044242.1024940-1-gwendal@chromium.org>
References: <20211230044242.1024940-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Based on bindings/iio/proximity/semtech,sx9324.yaml, implement
retrieving sensor hardware property and alter default values.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
No changes in v9
Changes in v8:
- Fix spelling/comment.

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
index 231b2eb0b7484f..f018b67422f186 100644
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
 	}
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
@@ -772,6 +841,99 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
 					20000, 2000000);
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
@@ -792,12 +954,14 @@ static const struct sx_common_chip_info sx9324_chip_info = {
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
2.34.1.448.ga2b2bfdf31-goog

