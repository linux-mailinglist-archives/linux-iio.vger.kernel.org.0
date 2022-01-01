Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BCF482875
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 21:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiAAUiJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 15:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiAAUiI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 15:38:08 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8376BC061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 12:38:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so28515544pjp.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 12:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eHJuFRK2dGwPZ/vpmEoKT26wUp+5wedwdVWQrO1IVw=;
        b=XLW7pAEDwuOLS5BfxZKJ4GAtn2utIRfQnfn3e5iW+oVv06EtWcutin2oMvbkn5lB7T
         pcgGTOxqPV77zLu1oE4c9jhG151zuxjYXWUaghDig4QrBqqYiKOcQbhctv+GodF5DAni
         6Nfrr/eZsxYxyxwfl7QG3AuK1xOtxbkiDwULY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eHJuFRK2dGwPZ/vpmEoKT26wUp+5wedwdVWQrO1IVw=;
        b=4UW/Bw0iic1tMTykoQr9ymQBdThOnax1zHzzaWQ36FNTg/G+CU7ML91xZrJVIK9GYS
         l3JVAfBv0K6xQs0ug59Iewnl2au1MuZfxnNCiDr9xnixXp5WRYp14wyehNPuYvK90rqT
         iVBwxL8Lp3/S/bqE8olpikdameWstMJrySM2Ncpomdz9nBh1Qs+9f35fwmPLoCggQGg3
         nNZn3NXUbyqG7BsrYis0ZDH1EDD8qfiFmBIp0xIG18FMK9X7W3YSm1kmaE6ASPgYMByc
         lhrhjAluue++Vfjk2y4WJ1fY/tM3UaNustiWoO2jJ8rMlIFbl6W/KyTHc5nQGXr2Vlzr
         tc8A==
X-Gm-Message-State: AOAM530Vx/OKpqqE9sbByVTqfdbyo+P1lkE+FGz/q62NwN8eud9s8+re
        EAj148jGLZPIiNEZ1P0xbZDWRg==
X-Google-Smtp-Source: ABdhPJzpo4WhHa/3R69BWo4GA1de2xjcdgmkhKIRJUFg9GxN5x3BwIeuJ0CQ0SoJoZBwHQPE7puCrw==
X-Received: by 2002:a17:902:8494:b0:149:8a72:98bb with SMTP id c20-20020a170902849400b001498a7298bbmr23476982plo.0.1641069487997;
        Sat, 01 Jan 2022 12:38:07 -0800 (PST)
Received: from localhost ([2620:15c:202:201:df49:1d3f:ae08:999])
        by smtp.gmail.com with UTF8SMTPSA id b21sm32484733pfv.74.2022.01.01.12.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 12:38:07 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v6 3/3] iio: sx9360: Add dt-binding support
Date:   Sat,  1 Jan 2022 12:38:00 -0800
Message-Id: <20220101203800.290387-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220101203800.290387-1-gwendal@chromium.org>
References: <20220101203800.290387-1-gwendal@chromium.org>
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
No changes in v6.
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
index f07d6bba07735d..ec0c4ff51bb874 100644
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

