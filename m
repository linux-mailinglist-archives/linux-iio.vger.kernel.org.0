Return-Path: <linux-iio+bounces-25622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D38C1B6EA
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 15:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CC7C346C41
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5A34AB0B;
	Wed, 29 Oct 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wnXHs2eY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77F3491D6;
	Wed, 29 Oct 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749238; cv=none; b=o+tYz0xisHXOQqYNNsxzeuGQ7F7jdovI5MfLbRJ/KYjogynvvZvzTvWqrZnfTkEYlK2MelCtjWE7BKmpVP6xhY4VYuyek2Rli36SpoATaJ+ELsFNzhhuBWxdw9X802YIpwGDJ7hcjjfSQj7d9k8cNfrAcbmF8OQO2PXdywpkSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749238; c=relaxed/simple;
	bh=w49fFevTSm1wtzSY7B4XRWOhdwa8cJqB9AMjoifpBX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oX3QvMk2MOTgnvy/P4W24Xy7hMt+saWJdCHeQOOgcKnz96X5Wt5RrLCtbWmTHvk1S24pCdBKrIxAz3Acqe6m3LD6SU825TrvZT3ESgFnAsls7M2Nj0jk3EX9/WI5tsTLBM3W/oNfmz3pBMovFuEN9HrhSmim0I6I0KUIAI8IRhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wnXHs2eY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 605A24E413CB;
	Wed, 29 Oct 2025 14:47:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2FF30606E8;
	Wed, 29 Oct 2025 14:47:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7DA9117F81D6;
	Wed, 29 Oct 2025 15:47:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761749233; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=FKy1WUWg2yt7lUZdpkEUopVRF7YA7opCiTdvb/Cn+M8=;
	b=wnXHs2eYQqZKyFc5blNo7ggMHUZK3IftZki1teZIXUAbjCDiYM0OYx2VLCAmPgEm7hRIZh
	2qg8y6jd1+SAhyj4c5UDagcnOv1vjwtwXC//tV8mgWoq5vsBKVSoy7s2kQXnaLPOieXNj+
	jQ561CnlJ5GhPoRFS5jsQItEU7pGqapJjbVtrYCxTHd/VQFzgGuTEDzltS8LhTd6DhHy8S
	HpPNVhDUEdaD7DGtj256u280jL+qQQOx5KqyqbOhNuvcO+0oOiqJsAVbJBagdd4qVRPpes
	4UV6DdWBW9PmZLDmXfHLYOUolDw1UhnwvMbSIJftLfJN/pFyZd5UskeK+7hn8A==
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
Subject: [PATCH v2 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Date: Wed, 29 Oct 2025 15:46:42 +0100
Message-ID: <20251029144644.667561-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029144644.667561-1-herve.codina@bootlin.com>
References: <20251029144644.667561-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Renesas RZ/N1 ADC controller is the ADC controller available in the
Renesas RZ/N1 SoCs family. It can use up to two internal ADC cores (ADC1
and ADC2) those internal cores are not directly accessed but are handled
through ADC controller virtual channels.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
---
 drivers/iio/adc/Kconfig    |  10 +
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/rzn1-adc.c | 493 +++++++++++++++++++++++++++++++++++++
 3 files changed, 504 insertions(+)
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
index 000000000000..52ec13adddef
--- /dev/null
+++ b/drivers/iio/adc/rzn1-adc.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/N1 ADC driver
+ *
+ * Copyright (C) 2025 Schneider-Electric
+ *
+ * Author: Herve Codina <herve.codina@bootlin.com>
+ *
+ * The RZ/N1 ADC controller can handle channels from its internal ADC1 and/or
+ * ADC2 cores. The driver use ADC1 and/or ADC2 cores depending on the presence
+ * of the related power supplies (AVDD and VREF) description in the device-tree.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/iio/iio.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+
+#define RZN1_ADC_CONTROL_REG			0x2c
+#define RZN1_ADC_CONTROL_ADC_BUSY		BIT(6)
+
+#define RZN1_ADC_FORCE_REG			0x30
+#define RZN1_ADC_SET_FORCE_REG			0x34
+#define RZN1_ADC_CLEAR_FORCE_REG		0x38
+#define RZN1_ADC_FORCE_VC(_n)			BIT(_n)
+
+#define RZN1_ADC_CONFIG_REG			0x40
+#define RZN1_ADC_CONFIG_ADC_POWER_DOWN		BIT(3)
+
+#define RZN1_ADC_VC_REG(_n)			(0xc0 + 4 * (_n))
+#define RZN1_ADC_VC_ADC2_ENABLE			BIT(16)
+#define RZN1_ADC_VC_ADC1_ENABLE			BIT(15)
+#define RZN1_ADC_VC_ADC2_CHANNEL_SEL_MASK	GENMASK(5, 3)
+#define RZN1_ADC_VC_ADC1_CHANNEL_SEL_MASK	GENMASK(2, 0)
+
+#define RZN1_ADC_ADC1_DATA_REG(_n)		(0x100 + 4 * (_n))
+#define RZN1_ADC_ADC2_DATA_REG(_n)		(0x140 + 4 * (_n))
+#define RZN1_ADC_ADCX_DATA_DATA_MASK		GENMASK(11, 0)
+
+#define RZN1_ADC_NO_CHANNEL	-1
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
+struct rzn1_adc {
+	struct device *dev;
+	void __iomem *regs;
+	struct mutex lock; /* ADC lock */
+	int adc1_vref_mv; /* ADC1 Vref in mV. Negative if ADC1 is not used */
+	int adc2_vref_mv; /* ADC2 Vref in mV. Negative if ADC2 is not used */
+};
+
+static int rzn1_adc_power(struct rzn1_adc *rzn1_adc, bool power)
+{
+	u32 v;
+
+	writel(power ? 0 : RZN1_ADC_CONFIG_ADC_POWER_DOWN,
+	       rzn1_adc->regs + RZN1_ADC_CONFIG_REG);
+
+	/* Wait for the ADC_BUSY to clear */
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
+	if (adc1_ch != RZN1_ADC_NO_CHANNEL)
+		vc |= RZN1_ADC_VC_ADC1_ENABLE |
+		      FIELD_PREP(RZN1_ADC_VC_ADC1_CHANNEL_SEL_MASK, adc1_ch);
+
+	if (adc2_ch != RZN1_ADC_NO_CHANNEL)
+		vc |= RZN1_ADC_VC_ADC2_ENABLE |
+		      FIELD_PREP(RZN1_ADC_VC_ADC2_CHANNEL_SEL_MASK, adc2_ch);
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
+	 * Round it up to 100us.
+	 */
+
+	/* Wait for the ADC_FORCE_VC(n) to clear */
+	ret = readl_poll_timeout_atomic(rzn1_adc->regs + RZN1_ADC_FORCE_REG,
+					v, !(v & RZN1_ADC_FORCE_VC(ch)),
+					0, 100);
+	if (ret)
+		return ret;
+
+	if (adc1_data) {
+		data_reg = readl(rzn1_adc->regs + RZN1_ADC_ADC1_DATA_REG(ch));
+		*adc1_data = FIELD_GET(RZN1_ADC_ADCX_DATA_DATA_MASK, data_reg);
+	}
+
+	if (adc2_data) {
+		data_reg = readl(rzn1_adc->regs + RZN1_ADC_ADC2_DATA_REG(ch));
+		*adc2_data = FIELD_GET(RZN1_ADC_ADCX_DATA_DATA_MASK, data_reg);
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
+	/*
+	 * IIO chan are decoupled from chans used in rzn1_adc_vc_*() functions.
+	 * The RZ/N1 ADC VC controller can handle on a single VC chan one
+	 * channel from the ADC1 core and one channel from the ADC2 core.
+	 *
+	 * Even if IIO chans are mapped 1:1 to ADC core chans and so uses only
+	 * a chan from ADC1 or a chan from ADC2, future improvements can define
+	 * an IIO chan that uses one chan from ADC1 and one chan from ADC2.
+	 */
+
+	if (chan < 8) {
+		/* chan 0..7 used to get ADC1 ch 0..7 */
+		adc1_ch = chan;
+		adc1_data = &adc_data;
+		adc2_ch = RZN1_ADC_NO_CHANNEL;
+		adc2_data = NULL;
+	} else if (chan < 16) {
+		/* chan 8..15 used to get ADC2 ch 0..7 */
+		adc1_ch = RZN1_ADC_NO_CHANNEL;
+		adc1_data = NULL;
+		adc2_ch = chan - 8;
+		adc2_data = &adc_data;
+	} else {
+		return -EINVAL;
+	}
+
+	ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(rzn1_adc->dev);
+	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
+	if (ret < 0)
+		return ret;
+
+	scoped_guard(mutex, &rzn1_adc->lock) {
+		rzn1_adc_vc_setup_conversion(rzn1_adc, chan, adc1_ch, adc2_ch);
+
+		ret = rzn1_adc_vc_start_conversion(rzn1_adc, chan);
+		if (ret)
+			return ret;
+
+		ret = rzn1_adc_vc_wait_conversion(rzn1_adc, chan, adc1_data, adc2_data);
+		if (ret) {
+			rzn1_adc_vc_stop_conversion(rzn1_adc, chan);
+			return ret;
+		}
+	}
+
+	*val = adc_data;
+	ret = IIO_VAL_INT;
+
+	return 0;
+}
+
+static int rzn1_adc_get_vref_mv(struct rzn1_adc *rzn1_adc, unsigned int chan)
+{
+	/*
+	 * chan 0..7 use ADC1 ch 0..7. Vref related to ADC1 core
+	 * chan 8..15 use ADC2 ch 0..7. Vref related to ADC2 core
+	 */
+	if (chan < 8)
+		return rzn1_adc->adc1_vref_mv;
+	else if (chan < 16)
+		return rzn1_adc->adc2_vref_mv;
+
+	return -EINVAL;
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
+static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
+					 struct iio_dev *indio_dev)
+{
+	/*
+	 * When an ADC core is not used, its related vref_mv is set to a
+	 * negative error code. Use the correct IIO channels table based on
+	 * those vref_mv values.
+	 */
+	if (rzn1_adc->adc1_vref_mv >= 0) {
+		if (rzn1_adc->adc2_vref_mv >= 0) {
+			indio_dev->channels = rzn1_adc1_adc2_channels;
+			indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_adc2_channels);
+		} else {
+			indio_dev->channels = rzn1_adc1_channels;
+			indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_channels);
+		}
+		return 0;
+	}
+
+	if (rzn1_adc->adc2_vref_mv >= 0) {
+		indio_dev->channels = rzn1_adc2_channels;
+		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc2_channels);
+		return 0;
+	}
+
+	return dev_err_probe(rzn1_adc->dev, -ENODEV,
+			     "Failed to set IIO channels, no ADC core used\n");
+}
+
+static int rzn1_adc_core_get_regulators(struct rzn1_adc *rzn1_adc,
+					int *adc_vref_mv,
+					const char *avdd_name, const char *vref_name)
+{
+	struct device *dev = rzn1_adc->dev;
+	int ret;
+
+	/*
+	 * For a given ADC core (ADC1 or ADC2), both regulators (AVDD and VREF)
+	 * must be available in order to have the ADC core used.
+	 *
+	 * We use the regulators presence to check the usage of the related
+	 * ADC core. If both regulators are available, the ADC core is used.
+	 * Otherwise, the ADC core is not used.
+	 *
+	 * The adc_vref_mv value is set to a negative error code (-ENODEV) when
+	 * the ADC core is not used. Otherwise it is set to the VRef mV value.
+	 */
+
+	*adc_vref_mv = -ENODEV;
+
+	ret = devm_regulator_get_enable_optional(dev, avdd_name);
+	if (ret < 0) {
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret,
+					     "Failed to get '%s' regulator\n",
+					     avdd_name);
+		return 0;
+	}
+
+	ret = devm_regulator_get_enable_read_voltage(dev, vref_name);
+	if (ret < 0) {
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret,
+					     "Failed to get '%s' regulator\n",
+					     vref_name);
+		return 0;
+	}
+
+	/*
+	 * Both regulators are available.
+	 * Set adc_vref_mv to the Vref value in mV. This, as the value set is
+	 * positive, also signals that the ADC is used.
+	 */
+	*adc_vref_mv = ret / 1000;
+
+	return 0;
+}
+
+static int rzn1_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct rzn1_adc *rzn1_adc;
+	struct clk *clk;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*rzn1_adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	rzn1_adc = iio_priv(indio_dev);
+	rzn1_adc->dev = dev;
+
+	ret = devm_mutex_init(dev, &rzn1_adc->lock);
+	if (ret)
+		return ret;
+
+	rzn1_adc->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rzn1_adc->regs))
+		return PTR_ERR(rzn1_adc->regs);
+
+	clk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get pclk\n");
+
+	clk = devm_clk_get_enabled(dev, "adc");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get adc clk\n");
+
+	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc->adc1_vref_mv,
+					   "adc1-avdd", "adc1-vref");
+	if (ret)
+		return ret;
+
+	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc->adc2_vref_mv,
+					   "adc2-avdd", "adc2-vref");
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	indio_dev->name = "rzn1-adc";
+	indio_dev->info = &rzn1_adc_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	ret = rzn1_adc_set_iio_dev_channels(rzn1_adc, indio_dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, 500);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int rzn1_adc_pm_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
+
+	return rzn1_adc_power(rzn1_adc, false);
+}
+
+static int rzn1_adc_pm_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
+
+	return rzn1_adc_power(rzn1_adc, true);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(rzn1_adc_pm_ops,
+				 rzn1_adc_pm_runtime_suspend,
+				 rzn1_adc_pm_runtime_resume, NULL);
+
+static const struct of_device_id rzn1_adc_of_match[] = {
+	{ .compatible = "renesas,rzn1-adc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rzn1_adc_of_match);
+
+static struct platform_driver rzn1_adc_driver = {
+	.probe = rzn1_adc_probe,
+	.driver = {
+		.name = "rzn1-adc",
+		.of_match_table = rzn1_adc_of_match,
+		.pm = pm_ptr(&rzn1_adc_pm_ops),
+	},
+};
+module_platform_driver(rzn1_adc_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("Renesas RZ/N1 ADC Driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0


