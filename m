Return-Path: <linux-iio+bounces-25096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24DBDF092
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8FE19C3218
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA1C27EC80;
	Wed, 15 Oct 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F4hKe/jT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AD827F19B;
	Wed, 15 Oct 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538608; cv=none; b=q8STDwLPWZv4L8BmsFvbb179tPHS2fWtDjwQBAC8dfmKQuwPJw8ocxww45TcnS++udcTSeiHtgpUGCF8jukYe6nVF8I9/UsyXj4QC4cdCsO3LsGveiHwBzvz16XdW1qOcif+Lj+0kZNKuDyVMGIRRQtwW4PuKkyB1j3sL1jmM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538608; c=relaxed/simple;
	bh=BZjxgxyDtelkmeBo4AZ89CBh376T4PKhsJsknu5tz0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S979UsKJvCt9oHscEF3WU9PefohWmBzjKHhR9KeXbBxUWRFw2v4kkJdddND0iEoDJrxAQqXzjBBiWYtdxsx9fmuXsPC2c0Rm0u6ngwJAcb4tzj9Qqh7sQRqiDxjTuGDG7opGhAUZVcuPn/3nloorlTyAlBNeVhpVFAzBnaz2wNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F4hKe/jT; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 30D35C09FBB;
	Wed, 15 Oct 2025 14:29:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 51285606F9;
	Wed, 15 Oct 2025 14:30:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDBC4102F22BC;
	Wed, 15 Oct 2025 16:30:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760538603; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=83hzTyixmKMFHx2AzSVqY3Lz5W/qXSoAWTy3xhdjKDM=;
	b=F4hKe/jT13wT85A4gsgLvbyUbKSJV49Li4urTop9NCgZI3pnke7D7IZuXOXZkWYsb4l/oz
	NQHYXug/6Ultd/zFfWyZULIh/FXj8y+8qzfrmJQGHEtbrEiucSPIBFcwTGDMvObVGHhVpd
	LGLFA6w50b/N1GksLLwKh4M4H+YiNmpg8zxwQmV6l3XJQ+1OcxSpamj/v98ix5N913YX28
	rCzFmoykW5qVYAFt7Uk/GHFVYTwGbrbaQ5iqWaAMATuQRiIPCac4AMHsDJG+fd+mXW3Pn0
	9g2wP0DMwi5y+v7IJTPSMfEp9Cw1u3LYfaRjQlieLvvfq6uPhBI2GT/x2oNvVA==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Date: Wed, 15 Oct 2025 16:28:14 +0200
Message-ID: <20251015142816.1274605-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015142816.1274605-1-herve.codina@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Renesas RZ/N1 ADC controller is the ADC controller available in the
Renesas RZ/N1 SoCs family. It can use up to two internal ACD cores (ADC1
and ADC2) those internal cores are not directly accessed but are handled
through ADC controller virtual channels.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
---
 drivers/iio/adc/Kconfig    |  10 +
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/rzn1-adc.c | 626 +++++++++++++++++++++++++++++++++++++
 3 files changed, 637 insertions(+)
 create mode 100644 drivers/iio/adc/rzn1-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 58a14e6833f6..113f6a5c9745 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1403,6 +1403,16 @@ config RZG2L_ADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rzg2l_adc.
 
+config RZN1_ADC
+	tristate "Renesas RZ/N1 ADC driver"
+	depends on ARCH_RZN1 || COMPILE_TEST
+	help
+	  Say yes here to build support for the ADC found in Renesas
+	  RZ/N1 family.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rzn1-adc.
+
 config SC27XX_ADC
 	tristate "Spreadtrum SC27xx series PMICs ADC"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d008f78dc010..ba7a8a63d070 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_ROHM_BD79112) += rohm-bd79112.o
 obj-$(CONFIG_ROHM_BD79124) += rohm-bd79124.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
+obj-$(CONFIG_RZN1_ADC) += rzn1-adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
 obj-$(CONFIG_SOPHGO_CV1800B_ADC) += sophgo-cv1800b-adc.o
diff --git a/drivers/iio/adc/rzn1-adc.c b/drivers/iio/adc/rzn1-adc.c
new file mode 100644
index 000000000000..f5e16b9cdf17
--- /dev/null
+++ b/drivers/iio/adc/rzn1-adc.c
@@ -0,0 +1,626 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/N1 ADC driver
+ *
+ * Copyright (C) 2025 Schneider-Electric
+ *
+ * Author: Herve Codina <herve.codina@bootlin.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/completion.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/machine.h>
+#include <linux/iio/driver.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/bits.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
+
+/*                  ADC1 ADC2
+ * RZ/N1D, BGA 400   y    y
+ * RZ/N1D, BGA 324   y    n
+ * RZ/N1S, BGA 324   y    n
+ * RZ/N1S, BGA 196   y    n
+ * RZ/N1L, BGA 196   y    n
+ */
+
+#define RZN1_ADC_CONTROL_REG	0x2c
+#define RZN1_ADC_CONTROL_ADC_BUSY	BIT(6)
+#define RZN1_ADC_FORCE_REG		0x30
+#define RZN1_ADC_SET_FORCE_REG		0x34
+#define RZN1_ADC_CLEAR_FORCE_REG	0x38
+#define RZN1_ADC_FORCE_VC(_n)		BIT(_n)
+
+#define RZN1_ADC_CONFIG_REG	0x40
+#define RZN1_ADC_CONFIG_ADC_POWER_DOWN	BIT(3)
+
+#define RZN1_ADC_VC_REG(_n)	(0xc0 + 0x4 * (_n))
+#define RZN1_ADC_VC_ADC2_ENABLE		BIT(16)
+#define RZN1_ADC_VC_ADC1_ENABLE		BIT(15)
+#define RZN1_ADC_VC_ADC2_CHANNEL_SEL_MASK	GENMASK(5, 3)
+#define RZN1_ADC_VC_ADC2_CHANNEL_SEL(_c)	FIELD_PREP(RZN1_ADC_VC_ADC2_CHANNEL_SEL_MASK, _c)
+#define RZN1_ADC_VC_ADC1_CHANNEL_SEL_MASK	GENMASK(2, 0)
+#define RZN1_ADC_VC_ADC1_CHANNEL_SEL(_c)	FIELD_PREP(RZN1_ADC_VC_ADC1_CHANNEL_SEL_MASK, _c)
+
+#define RZN1_ADC_ADC1_DATA_REG(_n)	(0x100 + 0x4 * (_n))
+#define RZN1_ADC_ADC2_DATA_REG(_n)	(0x140 + 0x4 * (_n))
+#define RZN1_ADC_ADCX_DATA_DATA_MASK	GENMASK(11, 0)
+#define RZN1_ADC_ADCX_GET_DATA(_reg)	FIELD_GET(RZN1_ADC_ADCX_DATA_DATA_MASK, _reg)
+
+#define RZN1_ADC_CHANNEL_SHARED_SCALE(_ch, _ds_name) {		\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = (_ch),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
+	.datasheet_name = (_ds_name),				\
+}
+
+#define RZN1_ADC_CHANNEL_SEPARATED_SCALE(_ch, _ds_name) {	\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = (_ch),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.datasheet_name = (_ds_name),				\
+}
+
+/*
+ * 8 ADC1_IN signals existed numbered 0..4, 6..8
+ * ADCx_IN5 doesn't exist in RZ/N1 datasheet
+ */
+static struct iio_chan_spec rzn1_adc1_channels[] = {
+	RZN1_ADC_CHANNEL_SHARED_SCALE(0, "ADC1_IN0"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(1, "ADC1_IN1"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(2, "ADC1_IN2"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(3, "ADC1_IN3"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(4, "ADC1_IN4"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(5, "ADC1_IN6"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(6, "ADC1_IN7"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(7, "ADC1_IN8"),
+};
+
+static struct iio_chan_spec rzn1_adc2_channels[] = {
+	RZN1_ADC_CHANNEL_SHARED_SCALE(8,  "ADC2_IN0"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(9,  "ADC2_IN1"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(10, "ADC2_IN2"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(11, "ADC2_IN3"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(12, "ADC2_IN4"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(13, "ADC2_IN6"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(14, "ADC2_IN7"),
+	RZN1_ADC_CHANNEL_SHARED_SCALE(15, "ADC2_IN8"),
+};
+
+/*
+ * If both ADCs core are used, scale cannot be common. Indeed, scale is
+ * based on Vref connected on each ADC core.
+ */
+static struct iio_chan_spec rzn1_adc1_adc2_channels[] = {
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(0, "ADC1_IN0"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(1, "ADC1_IN1"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(2, "ADC1_IN2"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(3, "ADC1_IN3"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(4, "ADC1_IN4"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(5, "ADC1_IN6"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(6, "ADC1_IN7"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(7, "ADC1_IN8"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(8,  "ADC2_IN0"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(9,  "ADC2_IN1"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(10, "ADC2_IN2"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(11, "ADC2_IN3"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(12, "ADC2_IN4"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(13, "ADC2_IN6"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(14, "ADC2_IN7"),
+	RZN1_ADC_CHANNEL_SEPARATED_SCALE(15, "ADC2_IN8"),
+};
+
+struct rzn1_adc_core {
+	int is_used;
+	struct regulator *avdd;
+	struct regulator *vref;
+};
+
+struct rzn1_adc {
+	struct device *dev;
+	void __iomem *regs;
+	struct mutex lock; /* ADC lock */
+	struct clk *pclk;
+	struct clk *adc_clk;
+	struct rzn1_adc_core adc_core[2]; /* ADC1 and ADC2 */
+};
+
+static int rzn1_adc_core_power_on(struct rzn1_adc_core *adc_core)
+{
+	int ret;
+
+	if (!adc_core->is_used)
+		return 0;
+
+	ret = regulator_enable(adc_core->avdd);
+	if (ret)
+		return ret;
+
+	ret = regulator_enable(adc_core->vref);
+	if (ret) {
+		regulator_disable(adc_core->avdd);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void rzn1_adc_core_power_off(struct rzn1_adc_core *adc_core)
+{
+	if (!adc_core->is_used)
+		return;
+
+	regulator_disable(adc_core->avdd);
+	regulator_disable(adc_core->vref);
+}
+
+static int rzn1_adc_core_get_regulators(struct rzn1_adc *rzn1_adc,
+					struct rzn1_adc_core *adc_core,
+					const char *avdd_name, const char *vref_name)
+{
+	struct device *dev = rzn1_adc->dev;
+	int ret;
+
+	adc_core->avdd = devm_regulator_get_optional(dev, avdd_name);
+	if (IS_ERR(adc_core->avdd)) {
+		ret = PTR_ERR(adc_core->avdd);
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret,
+					     "Failed to get '%s' regulator\n",
+					     avdd_name);
+		adc_core->avdd = NULL;
+	}
+
+	adc_core->vref = devm_regulator_get_optional(dev, vref_name);
+	if (IS_ERR(adc_core->vref)) {
+		ret = PTR_ERR(adc_core->vref);
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret,
+					     "Failed to get '%s' regulator\n",
+					     vref_name);
+		adc_core->vref = NULL;
+	}
+
+	/*
+	 * Both regulators (avdd and vref) need to be available to have the
+	 * related adc_core used.
+	 */
+	adc_core->is_used = adc_core->vref && adc_core->avdd;
+	return 0;
+}
+
+static int rzn1_adc_core_get_vref_mv(struct rzn1_adc_core *adc_core)
+{
+	int vref_uv;
+
+	if (!adc_core->vref)
+		return -ENODEV;
+
+	vref_uv = regulator_get_voltage(adc_core->vref);
+	if (vref_uv < 0)
+		return vref_uv;
+
+	return vref_uv / 1000;
+}
+
+static int rzn1_adc_power(struct rzn1_adc *rzn1_adc, bool power)
+{
+	u32 v;
+
+	writel(power ? 0 : RZN1_ADC_CONFIG_ADC_POWER_DOWN,
+	       rzn1_adc->regs + RZN1_ADC_CONFIG_REG);
+
+	/*
+	 * Wait for the ADC_BUSY to clear.
+	 *
+	 * On timeout, ret is -ETIMEDOUT, otherwise it will be 0.
+	 */
+	return readl_poll_timeout_atomic(rzn1_adc->regs + RZN1_ADC_CONTROL_REG,
+					 v, !(v & RZN1_ADC_CONTROL_ADC_BUSY),
+					 0, 500);
+}
+
+static void rzn1_adc_vc_setup_conversion(struct rzn1_adc *rzn1_adc, u32 ch,
+					 int adc1_ch, int adc2_ch)
+{
+	u32 vc = 0;
+
+	if (adc1_ch != -1)
+		vc |= RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNEL_SEL(adc1_ch);
+
+	if (adc2_ch != -1)
+		vc |= RZN1_ADC_VC_ADC2_ENABLE | RZN1_ADC_VC_ADC2_CHANNEL_SEL(adc2_ch);
+
+	writel(vc, rzn1_adc->regs + RZN1_ADC_VC_REG(ch));
+}
+
+static int rzn1_adc_vc_start_conversion(struct rzn1_adc *rzn1_adc, u32 ch)
+{
+	u32 val;
+
+	val = readl(rzn1_adc->regs + RZN1_ADC_FORCE_REG);
+	if (val & RZN1_ADC_FORCE_VC(ch))
+		return -EBUSY;
+
+	writel(RZN1_ADC_FORCE_VC(ch), rzn1_adc->regs + RZN1_ADC_SET_FORCE_REG);
+
+	return 0;
+}
+
+static void rzn1_adc_vc_stop_conversion(struct rzn1_adc *rzn1_adc, u32 ch)
+{
+	writel(RZN1_ADC_FORCE_VC(ch), rzn1_adc->regs + RZN1_ADC_CLEAR_FORCE_REG);
+}
+
+static int rzn1_adc_vc_wait_conversion(struct rzn1_adc *rzn1_adc, u32 ch,
+				       u32 *adc1_data, u32 *adc2_data)
+{
+	u32 data_reg;
+	int ret;
+	u32 v;
+
+	/*
+	 * When a VC is selected, it needs 20 ADC clocks to perform the
+	 * conversion.
+	 *
+	 * The worst case is when the 16 VCs need to perform a conversion and
+	 * our VC is the lowest in term of priority.
+	 *
+	 * In that case, the conversion is performed in 16 * 20 ADC clocks.
+	 *
+	 * The ADC clock can be set from 4MHz to 20MHz. This leads to a worst
+	 * case of  16 * 20 * 1/4Mhz = 80us.
+	 *
+	 * Round it up to 100us
+	 */
+
+	/*
+	 * Wait for the ADC_FORCE_VC(n) to clear.
+	 *
+	 * On timeout, ret is -ETIMEDOUT, otherwise it will be 0.
+	 */
+	ret = readl_poll_timeout_atomic(rzn1_adc->regs + RZN1_ADC_FORCE_REG,
+					v, !(v & RZN1_ADC_FORCE_VC(ch)),
+					0, 100);
+	if (ret)
+		return ret;
+
+	if (adc1_data) {
+		data_reg = readl(rzn1_adc->regs + RZN1_ADC_ADC1_DATA_REG(ch));
+		*adc1_data = RZN1_ADC_ADCX_GET_DATA(data_reg);
+	}
+
+	if (adc2_data) {
+		data_reg = readl(rzn1_adc->regs + RZN1_ADC_ADC2_DATA_REG(ch));
+		*adc2_data = RZN1_ADC_ADCX_GET_DATA(data_reg);
+	}
+
+	return 0;
+}
+
+static int rzn1_adc_read_raw_ch(struct rzn1_adc *rzn1_adc, unsigned int chan, int *val)
+{
+	u32 *adc1_data, *adc2_data;
+	int adc1_ch, adc2_ch;
+	u32 adc_data;
+	int ret;
+
+	if (chan < 8) {
+		/* chan 0..7 used to get ADC1 ch 0..7 */
+		adc1_ch = chan;
+		adc1_data = &adc_data;
+		adc2_ch = -1;
+		adc2_data = NULL;
+	} else if (chan < 16) {
+		/* chan 8..15 used to get ADC2 ch 0..7 */
+		adc1_ch = -1;
+		adc1_data = NULL;
+		adc2_ch = chan - 8;
+		adc2_data = &adc_data;
+	} else {
+		return -EINVAL;
+	}
+
+	ret = pm_runtime_resume_and_get(rzn1_adc->dev);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&rzn1_adc->lock);
+
+	rzn1_adc_vc_setup_conversion(rzn1_adc, chan, adc1_ch, adc2_ch);
+
+	ret = rzn1_adc_vc_start_conversion(rzn1_adc, chan);
+	if (ret)
+		goto end;
+
+	ret = rzn1_adc_vc_wait_conversion(rzn1_adc, chan, adc1_data, adc2_data);
+	if (ret) {
+		rzn1_adc_vc_stop_conversion(rzn1_adc, chan);
+		goto end;
+	}
+
+	*val = adc_data;
+	ret = IIO_VAL_INT;
+
+end:
+	mutex_unlock(&rzn1_adc->lock);
+
+	pm_runtime_mark_last_busy(rzn1_adc->dev);
+	pm_runtime_put_autosuspend(rzn1_adc->dev);
+
+	return ret;
+}
+
+static int rzn1_adc_get_vref_mv(struct rzn1_adc *rzn1_adc, unsigned int chan)
+{
+	struct rzn1_adc_core *adc_core;
+
+	/*
+	 * chan 0..7 use ADC1 ch 0..7. Vref related to ADC1 core
+	 * chan 8..15 use ADC2 ch 0..7. Vref related to ADC2 core
+	 */
+	if (chan < 8)
+		adc_core = &rzn1_adc->adc_core[0];
+	else if (chan < 16)
+		adc_core = &rzn1_adc->adc_core[1];
+	else
+		return -EINVAL;
+
+	return rzn1_adc_core_get_vref_mv(adc_core);
+}
+
+static int rzn1_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = rzn1_adc_read_raw_ch(rzn1_adc, chan->channel, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = rzn1_adc_get_vref_mv(rzn1_adc, chan->channel);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info rzn1_adc_info = {
+	.read_raw = &rzn1_adc_read_raw
+};
+
+static int rzn1_adc_enable(struct rzn1_adc *rzn1_adc)
+{
+	int ret;
+
+	ret = rzn1_adc_core_power_on(&rzn1_adc->adc_core[0]);
+	if (ret)
+		return ret;
+
+	ret = rzn1_adc_core_power_on(&rzn1_adc->adc_core[1]);
+	if (ret)
+		goto poweroff_adc_core0;
+
+	ret = clk_prepare_enable(rzn1_adc->pclk);
+	if (ret)
+		goto poweroff_adc_core1;
+
+	ret = clk_prepare_enable(rzn1_adc->adc_clk);
+	if (ret)
+		goto disable_pclk;
+
+	ret = rzn1_adc_power(rzn1_adc, true);
+	if (ret)
+		goto disable_adc_clk;
+
+	return 0;
+
+disable_adc_clk:
+	clk_disable_unprepare(rzn1_adc->adc_clk);
+disable_pclk:
+	clk_disable_unprepare(rzn1_adc->pclk);
+poweroff_adc_core1:
+	rzn1_adc_core_power_off(&rzn1_adc->adc_core[1]);
+poweroff_adc_core0:
+	rzn1_adc_core_power_off(&rzn1_adc->adc_core[0]);
+	return ret;
+}
+
+static void rzn1_adc_disable(struct rzn1_adc *rzn1_adc)
+{
+	rzn1_adc_power(rzn1_adc, false);
+
+	clk_disable_unprepare(rzn1_adc->adc_clk);
+	clk_disable_unprepare(rzn1_adc->pclk);
+
+	rzn1_adc_core_power_off(&rzn1_adc->adc_core[1]);
+	rzn1_adc_core_power_off(&rzn1_adc->adc_core[0]);
+}
+
+static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
+					 struct iio_dev *indio_dev)
+{
+	int adc_used;
+
+	adc_used = rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
+	adc_used |= rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;
+
+	switch (adc_used) {
+	case 0x01:
+		indio_dev->channels = rzn1_adc1_channels;
+		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_channels);
+		return 0;
+	case 0x02:
+		indio_dev->channels = rzn1_adc2_channels;
+		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc2_channels);
+		return 0;
+	case 0x03:
+		indio_dev->channels = rzn1_adc1_adc2_channels;
+		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_adc2_channels);
+		return 0;
+	default:
+		break;
+	}
+
+	dev_err(rzn1_adc->dev, "Failed to set IIO channels, no ADC core used\n");
+	return -ENODEV;
+}
+
+static int rzn1_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct rzn1_adc *rzn1_adc;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*rzn1_adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	rzn1_adc = iio_priv(indio_dev);
+	rzn1_adc->dev = dev;
+	mutex_init(&rzn1_adc->lock);
+
+	rzn1_adc->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rzn1_adc->regs))
+		return PTR_ERR(rzn1_adc->regs);
+
+	rzn1_adc->pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(rzn1_adc->pclk))
+		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk), "Failed to get pclk\n");
+
+	rzn1_adc->adc_clk = devm_clk_get(dev, "adc-clk");
+	if (IS_ERR(rzn1_adc->pclk))
+		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk), "Failed to get adc-clk\n");
+
+	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc->adc_core[0],
+					   "adc1-avdd", "adc1-vref");
+	if (ret)
+		return ret;
+
+	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc->adc_core[1],
+					   "adc2-avdd", "adc2-vref");
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->info = &rzn1_adc_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	ret = rzn1_adc_set_iio_dev_channels(rzn1_adc, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = rzn1_adc_enable(rzn1_adc);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, 500);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		goto disable;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+disable:
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
+	rzn1_adc_disable(rzn1_adc);
+	return ret;
+}
+
+static void rzn1_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
+
+	pm_runtime_disable(rzn1_adc->dev);
+	pm_runtime_set_suspended(rzn1_adc->dev);
+	pm_runtime_dont_use_autosuspend(rzn1_adc->dev);
+
+	rzn1_adc_disable(rzn1_adc);
+}
+
+static int rzn1_adc_pm_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
+
+	rzn1_adc_disable(rzn1_adc);
+
+	return 0;
+}
+
+static int rzn1_adc_pm_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
+
+	return rzn1_adc_enable(rzn1_adc);
+}
+
+static const struct dev_pm_ops rzn1_adc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(rzn1_adc_pm_runtime_suspend, rzn1_adc_pm_runtime_resume, NULL)
+};
+
+static const struct of_device_id rzn1_adc_of_match[] = {
+	{ .compatible = "renesas,rzn1-adc" },
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, rzn1_adc_of_match);
+
+static struct platform_driver rzn1_adc_driver = {
+	.probe = rzn1_adc_probe,
+	.remove = rzn1_adc_remove,
+	.driver = {
+		.name = "rzn1-adc",
+		.of_match_table = of_match_ptr(rzn1_adc_of_match),
+		.pm = pm_ptr(&rzn1_adc_pm_ops),
+	},
+};
+
+module_platform_driver(rzn1_adc_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("Renesas RZ/N1 ADC Driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0


