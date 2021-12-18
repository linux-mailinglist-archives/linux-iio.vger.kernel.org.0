Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEF54797D0
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 01:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhLRA1N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 19:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhLRA1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 19:27:13 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039DAC061574
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:27:13 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t123so2158813pfc.13
        for <linux-iio@vger.kernel.org>; Fri, 17 Dec 2021 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1LGY/xDgTcqgObOTwijoNFoTvk2W32LPPNam9v22UE=;
        b=E6NKh1WjKWICQoNctCX4I6agAtL1TD6dZV1toGNzZABXTpGvrlIvsx21UTJVOKDEo6
         2ZKJU9B+eNaY+sMUi8jr/1TsPTjehfwZZe3ubBkDvKW8Zn1mptTc9kMGrWA+WIm1e/38
         6xN6BJIOgsZzir1yANdGkjF6vWEglC6vPWLrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1LGY/xDgTcqgObOTwijoNFoTvk2W32LPPNam9v22UE=;
        b=3gNiFzcfRECa8U5z9TEbl2GhJY0CxhfGFUlkOY8qek5zg5SHyqHztM+iYWEABvGDfq
         j1M1iE5SR/sepZU1qd8S6s9IYzlMBnNb900ZVLMZIsyZVxMwWaj/f+9xNY6ZDswbsF72
         TX2nDKGmHmTDbnBxmEPNgmHbOFk4Da1BYvLhSzhzRAE9E8iQG60HWLvCWdu6xbqCagDU
         U9mUwNu4JU3vTZYjfaw1y9dHLmw/W8ZhKq/4OrWRr1YyqYbNc/K1zsJvYDMUobTQvz/w
         gOYA/LRQ/vMPGX67GnNVuWvbP1hHdcHEjMbcF307gzCf8UQUp18mDYZuOIZ+P1j6TBNY
         PeBw==
X-Gm-Message-State: AOAM532b1dWWe9KnIoVQrwnfwfh0YcCXqAWuBvlfGJ/JYd8hosmC+k40
        Db2lCP3WJ5KmfBYGz+SlwMTmZiBzkboDzw==
X-Google-Smtp-Source: ABdhPJw/GCCZHS43mfZPJv6i/LsdEdu10v34n3oAc5kAH1Rg+tCMd5cqUcAbpZejbUF3b4aU/pnhnQ==
X-Received: by 2002:a05:6a00:1903:b0:4b1:3b26:25c4 with SMTP id y3-20020a056a00190300b004b13b2625c4mr5414647pfi.9.1639787232487;
        Fri, 17 Dec 2021 16:27:12 -0800 (PST)
Received: from localhost ([2620:15c:202:201:2bc8:cefc:f407:829])
        by smtp.gmail.com with UTF8SMTPSA id 16sm10478091pfw.194.2021.12.17.16.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 16:27:12 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 3/3] iio: sx9360: Add dt-binding support
Date:   Fri, 17 Dec 2021 16:27:05 -0800
Message-Id: <20211218002705.3099096-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211218002705.3099096-1-gwendal@chromium.org>
References: <20211218002705.3099096-1-gwendal@chromium.org>
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
Changes since v3:
- Concatenate 2 lines.

Changes since v2:
- Add include when needed.
- Move default register constant to main patch.

No changes in v2.

 drivers/iio/proximity/sx9360.c | 84 ++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 75788bbf70efac..c32d4f8b162fd4 100644
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
@@ -658,6 +660,41 @@ static int sx9360_write_raw(struct iio_dev *indio_dev,
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
@@ -682,6 +719,51 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
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
 static int sx9360_check_whoami(struct device *dev, struct iio_dev *indio_dev)
 {
 	/*
@@ -701,12 +783,14 @@ static const struct sx_common_chip_info sx9360_chip_info = {
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
2.34.1.173.g76aa8bc2d0-goog

