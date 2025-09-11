Return-Path: <linux-iio+bounces-23981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6FB5329D
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A9484E0F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23325322A3E;
	Thu, 11 Sep 2025 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfoK9ezO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D98322763
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594635; cv=none; b=fKV0BtftRyhX0iwSyKQewHenjz3MdWstaPGaJmyEdqanW3U4UYFDQZ64gvQyznLeXFjz91rYPyJxB4UTcf4SL3AGgGCrRuLGEOBG4/iDZpAIHoBA6SvxHe+0WEz78eSyFs7houL/aphMPJODB8tZCrAXBbkEKMU4HuNXeAKERyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594635; c=relaxed/simple;
	bh=xicKlN7T01FzFwAQgVi+LIJY9t+qAB9UvjZBPPhlc9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQCFi2wuHLeXFe5wQkc62wLL4qdOJ57RILf6pfdA1Vh5+49FpWDGxmCyGAAidGPPECFKSD8eRF1RGOCn+2Nh8ju6ltpy5A2VwaEetlYUhK2Egoly7C9fObP+ierVCFqYQa0QbdIPDoq/PrYwlsDVPjcjKrmMUQizpW3IMXbFGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfoK9ezO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so511895f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757594632; x=1758199432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxNYsQ5yPcRKxXQ8SxCGsgJHWwOT3fEp+q/uqHvkv3k=;
        b=IfoK9ezOCEkR/NhPDsFcMCVBpt86r57GUVnueUOf8so3BTNIPpE3W3sEpvaj9xNSH9
         RWuHclfyAjFGnB802X8Rbqd802uUNc6iPjJ6Bal/FJXxUudHakAW8fWxxxmRIsrrE99P
         FJaBRC+GFG1ea0eMv3X4xBxTgSdpr7mzgK4lYyZwKc8DOebssvix9W1747baKiQpvr44
         +BTGIDpPsvuJAidUOJ2rgeol43DIKefWJstcnqp5eAEImJN0Z+pTdhsHUwImc5wa/Jwy
         x57Qsw281b/n0dDhU0GDk8NapCNsHQ+skNkZDiNkoREJDWh2DjsEjJHHkc2u5kDoAigs
         +jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757594632; x=1758199432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxNYsQ5yPcRKxXQ8SxCGsgJHWwOT3fEp+q/uqHvkv3k=;
        b=r+2feYPU1t5Y8XtyNR2JYLC7kVpZWsR+g/QB+bFeoBtGltnD8DI8ggg/6x0tN2Pkc9
         Uq/930Nw/dyaAQCY2zmydn2nkrP4w7oqXeGoUzt5bZHxdvHnhQbYbGwhL14err1QGnn6
         34XeOFLCr8f5CG8Em7Q0P2uE0guNeQpZ2HWGRLQyFvFTNqwc8AIFF2b6gKurnFm9urFC
         Z1IDBXZh/MO4eJuxdRkuw57ySXbTEnuykLln3mtwCfz6sXGa74h73ndKAIzSEH7t7oaL
         Bezrm1Wy3datrSOgSRZLQ1HXEREA4JOoTJDY8A+K2LOsVkkxNtOgSz1f3ZSkH5+TQpMs
         x5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCV2Vm4+gtSOSTogFY/wcNmYP1/+wpYOleJGpgy/p5gfu5QV6kVGifJOybA0NaKdRyNCNqdn4lfrAu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHTEQYzwz6VJuSynwfYuBO+fo+08C4btaREZf1Tn5tY6nycHU
	84yYVVdrczXV32GxXIs3xG4+Cnot3HvWyo4aAeiy8cGb/2df7mzMR8nH
X-Gm-Gg: ASbGnctSLjj6XRiOdsd+axaopSt/ZJ9aaS5D/HPKSPZ4A37cs/C5wKhGuFanhlfBvXs
	v6lqBzGH8wZ2w5gnSvaoF+GZw4Vzj0eJRbY1iqlRp7Ws8Qd29WEmTxRdymZB1Mew+OaaR/vLJMK
	KtNRVbSz3Y1ifJRfZSU0b2aUmpjyksGcegUqtiN+C/fKNDhrnDWUEBbQozYR47LdF5ortjfxwwi
	moVxa86yoJ3nIob5mvg6SA/KjifEWdhRyTTvOMnpsl3H330sDD7eO+c3LxkH+xVUXizsO960JxV
	srlNFR/JgmMnPPU0xYTWmhAhPz1lYzUbp+cW7hOveuNDxBLw5cfcJ/s3ICZqEU80k/BPY5vC05L
	QhMn+aOSAA48nlcIsV7LXFhyWcfLfou3XZ98IxLwaTuz/EnWJXhgnth75PgwFJ5KIufY062jacw
	Mu46SgLvv9Hx4=
X-Google-Smtp-Source: AGHT+IH8M+tPu4NHT1O7jHhUkteo1nPDOTBBWd3Hpd20boEnWMProEatZByjxFmaKpTH8w8FO1Gyiw==
X-Received: by 2002:a05:6000:647:b0:3e7:1f63:6e81 with SMTP id ffacd0b85a97d-3e71f6373c5mr16936549f8f.16.1757594631636;
        Thu, 11 Sep 2025 05:43:51 -0700 (PDT)
Received: from Radijator.localdomain (93-143-13-188.adsl.net.t-com.hr. [93.143.13.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e03729c76sm22591495e9.6.2025.09.11.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:43:50 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Thu, 11 Sep 2025 14:43:45 +0200
Subject: [PATCH v4 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-88pm886-gpadc-v4-2-60452710d3a0@dujemihanovic.xyz>
References: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
In-Reply-To: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17398;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=0LQF9vrI/sTMRpnoRYb2UWoaVl7IGUrBBrscrObtRLQ=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmHjjAa8FVOeBZ+p2XOubUbeeoPvrvjLrSmLOCXfOPpy
 7o2Cfp/O0pZGMS4GGTFFFly/zte4/0ssnV79jIDmDmsTCBDGLg4BWAiqq8ZGfpucqnWlnUGGC9R
 aleQT43eUH+jxcrmwhzLU6vzJ4eFSjL8lSiS5JzHuqX2u+JtRrG/7yon1h4w9lfbllXUf/69vGc
 BDwA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
monitoring various system voltages and temperatures. Add the relevant
register definitions to the MFD header and a driver for the ADC.

Acked-by: Karel Balej <balejk@matfyz.cz> # for the PMIC
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v4:
- Add some missing headers
- Fix unit symbols

v3:
- Add indices to pm886_gpadc_regs[] table
- Tidy up macro definitions
- Define MAX_REGISTER
- Drop some ternary operators
- raw_u{v,a} -> raw_u{V,A}
- Reorder gpadc_get_resistance_ohm()
- Split pm886_gpadc_setup() into hw_{en,dis}able()
- Set firmware node the right way

v2:
- default MFD_88PM886_PMIC
- u8[2] -> __be16
- Drop kernel.h include
- Add pm886_gpadc struct
- Reorder channel enum
- Drop GPADC voltage channels
- Drop unnecessary masking in gpadc_get_raw()
- Extend gpadc_enable_bias() to allow disabling bias
- usleep_range() -> fsleep()
- PM wrapper for pm886_gpadc_read_raw()
- Proper channel info: voltage is RAW | SCALE, temperature is RAW |
  OFFSET | SCALE, resistance is PROCESSED
- Explicitly define channels to en/disable in pm886_gpadc_setup()
- Don't explicitly set iio->dev.parent
- Miscellaneous style changes
---
 MAINTAINERS                     |   5 +
 drivers/iio/adc/88pm886-gpadc.c | 393 ++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/Kconfig         |  13 ++
 drivers/iio/adc/Makefile        |   1 +
 include/linux/mfd/88pm886.h     |  58 ++++++
 5 files changed, 470 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d321752ac44c91d2d7e74de28e08960..9d94eb3761d492ff7ba4da3238aa195dfb43e70f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14711,6 +14711,11 @@ F:	drivers/regulator/88pm886-regulator.c
 F:	drivers/rtc/rtc-88pm886.c
 F:	include/linux/mfd/88pm886.h
 
+MARVELL 88PM886 PMIC GPADC DRIVER
+M:	Duje Mihanović <duje@dujemihanovic.xyz>
+S:	Maintained
+F:	drivers/iio/adc/88pm886-gpadc.c
+
 MARVELL ARMADA 3700 PHY DRIVERS
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 S:	Maintained
diff --git a/drivers/iio/adc/88pm886-gpadc.c b/drivers/iio/adc/88pm886-gpadc.c
new file mode 100644
index 0000000000000000000000000000000000000000..cffe35136685e1814b5b74d1c6fcfe743125b82c
--- /dev/null
+++ b/drivers/iio/adc/88pm886-gpadc.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025, Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+#include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#include <linux/mfd/88pm886.h>
+
+struct pm886_gpadc {
+	struct regmap *map;
+};
+
+enum pm886_gpadc_channel {
+	VSC_CHAN,
+	VCHG_PWR_CHAN,
+	VCF_OUT_CHAN,
+	VBAT_CHAN,
+	VBAT_SLP_CHAN,
+	VBUS_CHAN,
+
+	GPADC0_CHAN,
+	GPADC1_CHAN,
+	GPADC2_CHAN,
+	GPADC3_CHAN,
+
+	GND_DET1_CHAN,
+	GND_DET2_CHAN,
+	MIC_DET_CHAN,
+
+	TINT_CHAN,
+};
+
+static const int pm886_gpadc_regs[] = {
+	[VSC_CHAN] = PM886_REG_GPADC_VSC,
+	[VCHG_PWR_CHAN] = PM886_REG_GPADC_VCHG_PWR,
+	[VCF_OUT_CHAN] = PM886_REG_GPADC_VCF_OUT,
+	[VBAT_CHAN] = PM886_REG_GPADC_VBAT,
+	[VBAT_SLP_CHAN] = PM886_REG_GPADC_VBAT_SLP,
+	[VBUS_CHAN] = PM886_REG_GPADC_VBUS,
+
+	[GPADC0_CHAN] = PM886_REG_GPADC_GPADC0,
+	[GPADC1_CHAN] = PM886_REG_GPADC_GPADC1,
+	[GPADC2_CHAN] = PM886_REG_GPADC_GPADC2,
+	[GPADC3_CHAN] = PM886_REG_GPADC_GPADC3,
+
+	[GND_DET1_CHAN] = PM886_REG_GPADC_GND_DET1,
+	[GND_DET2_CHAN] = PM886_REG_GPADC_GND_DET2,
+	[MIC_DET_CHAN] = PM886_REG_GPADC_MIC_DET,
+
+	[TINT_CHAN] = PM886_REG_GPADC_TINT,
+};
+
+#define ADC_CHANNEL_VOLTAGE(index, lsb, name)		\
+{							\
+	.type = IIO_VOLTAGE,				\
+	.indexed = 1,					\
+	.channel = index,				\
+	.address = lsb,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+			      BIT(IIO_CHAN_INFO_SCALE),	\
+	.datasheet_name = name,				\
+}
+
+#define ADC_CHANNEL_RESISTANCE(index, lsb, name)		\
+{								\
+	.type = IIO_RESISTANCE,					\
+	.indexed = 1,						\
+	.channel = index,					\
+	.address = lsb,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
+	.datasheet_name = name,					\
+}
+
+#define ADC_CHANNEL_TEMPERATURE(index, lsb, name)		\
+{								\
+	.type = IIO_TEMP,					\
+	.indexed = 1,						\
+	.channel = index,					\
+	.address = lsb,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE) |	\
+			      BIT(IIO_CHAN_INFO_OFFSET),	\
+	.datasheet_name = name,					\
+}
+
+static const struct iio_chan_spec pm886_gpadc_channels[] = {
+	ADC_CHANNEL_VOLTAGE(VSC_CHAN, 1367, "vsc"),
+	ADC_CHANNEL_VOLTAGE(VCHG_PWR_CHAN, 1709, "vchg_pwr"),
+	ADC_CHANNEL_VOLTAGE(VCF_OUT_CHAN, 1367, "vcf_out"),
+	ADC_CHANNEL_VOLTAGE(VBAT_CHAN, 1367, "vbat"),
+	ADC_CHANNEL_VOLTAGE(VBAT_SLP_CHAN, 1367, "vbat_slp"),
+	ADC_CHANNEL_VOLTAGE(VBUS_CHAN, 1709, "vbus"),
+
+	ADC_CHANNEL_RESISTANCE(GPADC0_CHAN, 342, "gpadc0"),
+	ADC_CHANNEL_RESISTANCE(GPADC1_CHAN, 342, "gpadc1"),
+	ADC_CHANNEL_RESISTANCE(GPADC2_CHAN, 342, "gpadc2"),
+	ADC_CHANNEL_RESISTANCE(GPADC3_CHAN, 342, "gpadc3"),
+
+	ADC_CHANNEL_VOLTAGE(GND_DET1_CHAN, 342, "gnddet1"),
+	ADC_CHANNEL_VOLTAGE(GND_DET2_CHAN, 342, "gnddet2"),
+	ADC_CHANNEL_VOLTAGE(MIC_DET_CHAN, 1367, "mic_det"),
+
+	ADC_CHANNEL_TEMPERATURE(TINT_CHAN, 104, "tint"),
+};
+
+static const struct regmap_config pm886_gpadc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PM886_GPADC_MAX_REGISTER,
+};
+
+static int gpadc_get_raw(struct iio_dev *iio, enum pm886_gpadc_channel chan)
+{
+	struct pm886_gpadc *gpadc = iio_priv(iio);
+	__be16 buf;
+	int ret;
+
+	ret = regmap_bulk_read(gpadc->map, pm886_gpadc_regs[chan], &buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	return be16_to_cpu(buf) >> 4;
+}
+
+static int
+gpadc_set_bias(struct pm886_gpadc *gpadc, enum pm886_gpadc_channel chan, bool on)
+{
+	unsigned int gpadc_num = chan - GPADC0_CHAN;
+	unsigned int bits = BIT(gpadc_num + 4) | BIT(gpadc_num);
+
+	return regmap_assign_bits(gpadc->map, PM886_REG_GPADC_CONFIG(0x14), bits, on);
+}
+
+static int
+gpadc_find_bias_current(struct iio_dev *iio, struct iio_chan_spec const *chan,
+			unsigned int *raw_uV, unsigned int *raw_uA)
+{
+	struct pm886_gpadc *gpadc = iio_priv(iio);
+	unsigned int gpadc_num = chan->channel - GPADC0_CHAN;
+	unsigned int reg = PM886_REG_GPADC_CONFIG(0xb + gpadc_num);
+	unsigned long lsb = chan->address;
+	int ret;
+
+	for (unsigned int i = 0; i < PM886_GPADC_BIAS_LEVELS; i++) {
+		ret = regmap_update_bits(gpadc->map, reg, GENMASK(3, 0), i);
+		if (ret)
+			return ret;
+
+		/* Wait for the new bias level to apply. */
+		fsleep(5 * USEC_PER_MSEC);
+
+		*raw_uA = PM886_GPADC_INDEX_TO_BIAS_uA(i);
+		*raw_uV = gpadc_get_raw(iio, chan->channel) * lsb;
+
+		/*
+		 * Vendor kernel errors out above 1.25 V, but testing shows
+		 * that the resistance of the battery detection channel (GPADC2
+		 * on coreprimevelte) reaches about 1.4 MΩ when the battery is
+		 * removed, which can't be measured with such a low upper
+		 * limit. Therefore, to be able to detect the battery without
+		 * ugly externs as used in the vendor fuel gauge driver,
+		 * increase this limit a bit.
+		 */
+		if (WARN_ON(*raw_uV > 1500 * (MICRO / MILLI)))
+			return -EIO;
+
+		/*
+		 * Vendor kernel errors out under 300 mV, but for the same
+		 * reason as above (except the channel hovers around 3.5 kΩ
+		 * with battery present) reduce this limit.
+		 */
+		if (*raw_uV < 200 * (MICRO / MILLI)) {
+			dev_dbg(&iio->dev, "bad bias for chan %d: %d uA @ %d uV\n",
+				chan->channel, *raw_uA, *raw_uV);
+			continue;
+		}
+
+		dev_dbg(&iio->dev, "good bias for chan %d: %d uA @ %d uV\n",
+			chan->channel, *raw_uA, *raw_uV);
+		return 0;
+	}
+
+	dev_err(&iio->dev, "failed to find good bias for chan %d\n", chan->channel);
+	return -EINVAL;
+}
+
+static int
+gpadc_get_resistance_ohm(struct iio_dev *iio, struct iio_chan_spec const *chan)
+{
+	struct pm886_gpadc *gpadc = iio_priv(iio);
+	unsigned int raw_uV, raw_uA;
+	int ret;
+
+	ret = gpadc_set_bias(gpadc, chan->channel, true);
+	if (ret)
+		goto out;
+
+	ret = gpadc_find_bias_current(iio, chan, &raw_uV, &raw_uA);
+	if (ret)
+		goto out;
+
+	ret = DIV_ROUND_CLOSEST(raw_uV, raw_uA);
+out:
+	gpadc_set_bias(gpadc, chan->channel, false);
+	return ret;
+}
+
+static int
+__pm886_gpadc_read_raw(struct iio_dev *iio, struct iio_chan_spec const *chan,
+		       int *val, int *val2, long mask)
+{
+	unsigned long lsb = chan->address;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = gpadc_get_raw(iio, chan->channel);
+		if (*val < 0)
+			return *val;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = lsb;
+
+		if (chan->type == IIO_VOLTAGE) {
+			*val2 = MILLI;
+			return IIO_VAL_FRACTIONAL;
+		} else {
+			return IIO_VAL_INT;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		/* Raw value is 104 millikelvin/LSB, convert it to 104 millicelsius/LSB */
+		*val = ABSOLUTE_ZERO_MILLICELSIUS;
+		*val2 = lsb;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_PROCESSED:
+		*val = gpadc_get_resistance_ohm(iio, chan);
+		if (*val < 0)
+			return *val;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pm886_gpadc_read_raw(struct iio_dev *iio, struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct device *dev = iio->dev.parent;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = __pm886_gpadc_read_raw(iio, chan, val, val2, mask);
+
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int pm886_gpadc_hw_enable(struct regmap *map)
+{
+	const u8 config[] = {
+		PM886_GPADC_CONFIG1_EN_ALL,
+		PM886_GPADC_CONFIG2_EN_ALL,
+		PM886_GPADC_GND_DET2_EN,
+	};
+	int ret;
+
+	/* Enable the ADC block. */
+	ret = regmap_set_bits(map, PM886_REG_GPADC_CONFIG(0x6), BIT(0));
+	if (ret)
+		return ret;
+
+	/* Enable all channels. */
+	return regmap_bulk_write(map, PM886_REG_GPADC_CONFIG(0x1), config, ARRAY_SIZE(config));
+}
+
+static int pm886_gpadc_hw_disable(struct regmap *map)
+{
+	return regmap_clear_bits(map, PM886_REG_GPADC_CONFIG(0x6), BIT(0));
+}
+
+static const struct iio_info pm886_gpadc_iio_info = {
+	.read_raw = pm886_gpadc_read_raw,
+};
+
+static int pm886_gpadc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pm886_chip *chip = dev_get_drvdata(dev->parent);
+	struct i2c_client *client = chip->client;
+	struct pm886_gpadc *gpadc;
+	struct i2c_client *page;
+	struct iio_dev *iio;
+	int ret;
+
+	iio = devm_iio_device_alloc(dev, sizeof(*gpadc));
+	if (!iio)
+		return -ENOMEM;
+
+	gpadc = iio_priv(iio);
+	dev_set_drvdata(dev, iio);
+
+	page = devm_i2c_new_dummy_device(dev, client->adapter,
+					 client->addr + PM886_PAGE_OFFSET_GPADC);
+	if (IS_ERR(page))
+		return dev_err_probe(dev, PTR_ERR(page), "Failed to initialize GPADC page\n");
+
+	gpadc->map = devm_regmap_init_i2c(page, &pm886_gpadc_regmap_config);
+	if (IS_ERR(gpadc->map))
+		return dev_err_probe(dev, PTR_ERR(gpadc->map),
+				     "Failed to initialize GPADC regmap\n");
+
+	iio->name = "88pm886-gpadc";
+	iio->modes = INDIO_DIRECT_MODE;
+	iio->info = &pm886_gpadc_iio_info;
+	iio->channels = pm886_gpadc_channels;
+	iio->num_channels = ARRAY_SIZE(pm886_gpadc_channels);
+	device_set_node(&iio->dev, dev_fwnode(dev->parent));
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_iio_device_register(dev, iio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register ADC\n");
+
+	return 0;
+}
+
+static int pm886_gpadc_runtime_resume(struct device *dev)
+{
+	struct iio_dev *iio = dev_get_drvdata(dev);
+	struct pm886_gpadc *gpadc = iio_priv(iio);
+
+	return pm886_gpadc_hw_enable(gpadc->map);
+}
+
+static int pm886_gpadc_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *iio = dev_get_drvdata(dev);
+	struct pm886_gpadc *gpadc = iio_priv(iio);
+
+	return pm886_gpadc_hw_disable(gpadc->map);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(pm886_gpadc_pm_ops,
+				 pm886_gpadc_runtime_suspend,
+				 pm886_gpadc_runtime_resume, NULL);
+
+static const struct platform_device_id pm886_gpadc_id[] = {
+	{ "88pm886-gpadc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, pm886_gpadc_id);
+
+static struct platform_driver pm886_gpadc_driver = {
+	.driver = {
+		.name = "88pm886-gpadc",
+		.pm = pm_ptr(&pm886_gpadc_pm_ops),
+	},
+	.probe = pm886_gpadc_probe,
+	.id_table = pm886_gpadc_id,
+};
+module_platform_driver(pm886_gpadc_driver);
+
+MODULE_AUTHOR("Duje Mihanović <duje@dujemihanovic.xyz>");
+MODULE_DESCRIPTION("Marvell 88PM886 GPADC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 24f2572c487ea3db2abec3283ebd93357c08baab..04c8478ff707dd16ec943674ac7f01f33249acf1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -9,6 +9,19 @@ menu "Analog to digital converters"
 config IIO_ADC_HELPER
 	tristate
 
+config 88PM886_GPADC
+	tristate "Marvell 88PM886 GPADC driver"
+	depends on MFD_88PM886_PMIC
+	default MFD_88PM886_PMIC
+	help
+	  Say Y here to enable support for the GPADC (General Purpose ADC)
+	  found on the Marvell 88PM886 PMIC. The GPADC measures various
+	  internal voltages and temperatures, including (but not limited to)
+	  system, battery and USB Vbus.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called 88pm886-gpadc.
+
 config AB8500_GPADC
 	bool "ST-Ericsson AB8500 GPADC driver"
 	depends on AB8500_CORE && REGULATOR_AB8500
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1c6ca5fd4b6db8c4c40a351b231ba0892e8cd70e..64854907bf3bef7da39f95247e4e502d01232af3 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_88PM886_GPADC) += 88pm886-gpadc.o
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4000) += ad4000.o
diff --git a/include/linux/mfd/88pm886.h b/include/linux/mfd/88pm886.h
index 85eca44f39ab58ba4cb9ec4216118ee9604d021f..38892ba7b8a42bbecb53621a891a52a2fd70fd43 100644
--- a/include/linux/mfd/88pm886.h
+++ b/include/linux/mfd/88pm886.h
@@ -10,6 +10,7 @@
 #define PM886_IRQ_ONKEY			0
 
 #define PM886_PAGE_OFFSET_REGULATORS	1
+#define PM886_PAGE_OFFSET_GPADC		2
 
 #define PM886_REG_ID			0x00
 
@@ -70,6 +71,63 @@
 #define PM886_LDO_VSEL_MASK		0x0f
 #define PM886_BUCK_VSEL_MASK		0x7f
 
+/* GPADC enable/disable registers */
+#define PM886_REG_GPADC_CONFIG(n)	(n)
+
+#define PM886_GPADC_VSC_EN		BIT(0)
+#define PM886_GPADC_VBAT_EN		BIT(1)
+#define PM886_GPADC_GNDDET1_EN		BIT(3)
+#define PM886_GPADC_VBUS_EN		BIT(4)
+#define PM886_GPADC_VCHG_PWR_EN		BIT(5)
+#define PM886_GPADC_VCF_OUT_EN		BIT(6)
+#define PM886_GPADC_CONFIG1_EN_ALL	\
+	(PM886_GPADC_VSC_EN |		\
+	 PM886_GPADC_VBAT_EN |		\
+	 PM886_GPADC_GNDDET1_EN |	\
+	 PM886_GPADC_VBUS_EN |		\
+	 PM886_GPADC_VCHG_PWR_EN |	\
+	 PM886_GPADC_VCF_OUT_EN)
+
+#define PM886_GPADC_TINT_EN		BIT(0)
+#define PM886_GPADC_PMODE_EN		BIT(1)
+#define PM886_GPADC_GPADC0_EN		BIT(2)
+#define PM886_GPADC_GPADC1_EN		BIT(3)
+#define PM886_GPADC_GPADC2_EN		BIT(4)
+#define PM886_GPADC_GPADC3_EN		BIT(5)
+#define PM886_GPADC_MIC_DET_EN		BIT(6)
+#define PM886_GPADC_CONFIG2_EN_ALL	\
+	(PM886_GPADC_TINT_EN |		\
+	 PM886_GPADC_GPADC0_EN |	\
+	 PM886_GPADC_GPADC1_EN |	\
+	 PM886_GPADC_GPADC2_EN |	\
+	 PM886_GPADC_GPADC3_EN |	\
+	 PM886_GPADC_MIC_DET_EN)
+
+/* No CONFIG3_EN_ALL because this is the only bit there. */
+#define PM886_GPADC_GND_DET2_EN		BIT(0)
+
+/* GPADC channel registers */
+#define PM886_REG_GPADC_VSC		0x40
+#define PM886_REG_GPADC_VCHG_PWR	0x4c
+#define PM886_REG_GPADC_VCF_OUT		0x4e
+#define PM886_REG_GPADC_TINT		0x50
+#define PM886_REG_GPADC_GPADC0		0x54
+#define PM886_REG_GPADC_GPADC1		0x56
+#define PM886_REG_GPADC_GPADC2		0x58
+#define PM886_REG_GPADC_VBAT		0xa0
+#define PM886_REG_GPADC_GND_DET1	0xa4
+#define PM886_REG_GPADC_GND_DET2	0xa6
+#define PM886_REG_GPADC_VBUS		0xa8
+#define PM886_REG_GPADC_GPADC3		0xaa
+#define PM886_REG_GPADC_MIC_DET		0xac
+#define PM886_REG_GPADC_VBAT_SLP	0xb0
+
+/* VBAT_SLP is the last register and is 2 bytes wide like other channels. */
+#define PM886_GPADC_MAX_REGISTER	(PM886_REG_GPADC_VBAT_SLP + 1)
+
+#define PM886_GPADC_BIAS_LEVELS		16
+#define PM886_GPADC_INDEX_TO_BIAS_uA(i)	(1 + (i) * 5)
+
 struct pm886_chip {
 	struct i2c_client *client;
 	unsigned int chip_id;

-- 
2.51.0


