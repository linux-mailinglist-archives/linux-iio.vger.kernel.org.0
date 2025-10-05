Return-Path: <linux-iio+bounces-24734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86214BB95D7
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 13:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE563B6C45
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 11:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5AE274B51;
	Sun,  5 Oct 2025 11:14:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5692741C0;
	Sun,  5 Oct 2025 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759662894; cv=none; b=Q+YdIbXOevadvRbHeo5chjLAuRCWwmBMm6aqzLwZZw8nWgELAUNXOEEYa7GKXmAcww0Q6SAdgNkht6FtkvXQwOp/saV0w6oI+620MCbWL2IUQWh+X07KRfhcPOcClU9ZUmy3/++e9xXcGaFp80gGwUFAUXffpiQ5xMk3UMJ/yZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759662894; c=relaxed/simple;
	bh=dR60mP2Lsed0ToL1VqIUlRmPCdZNdlRI8QluLY6X1N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C73TM7NYMy0th2gONmDVbAMTQrbQllp7bOvNlJan+38ojGW+XFQs57aasa9mToYaeNN2sEphIfl2HSuMQnUIsuFFKYPNmyOE7KjZerE1xKqQ1lEostRP1rcvIK2XgnCHz0Xsvih6Sm6tikpjMc8BTcWpgqj/Hpb2Ut82bGoSaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: NAVcumTcRSGqH4BufWjlpw==
X-CSE-MsgGUID: f6lN6uW+RZyrFTI+DFoNHA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Oct 2025 20:14:50 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C674C40065C2;
	Sun,  5 Oct 2025 20:14:46 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] iio: adc: add RZ/T2H / RZ/N2H ADC driver
Date: Sun,  5 Oct 2025 14:13:18 +0300
Message-ID: <20251005111323.804638-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the A/D 12-Bit successive approximation converters found
in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.

RZ/T2H has two ADCs with 4 channels and one with 6.
RZ/N2H has two ADCs with 4 channels and one with 15.

Conversions can be performed in single or continuous mode. Result of the
conversion is stored in a 16-bit data register corresponding to each
channel.

The conversions can be started by a software trigger, a synchronous
trigger (from MTU or from ELC) or an asynchronous external trigger (from
ADTRGn# pin).

Only single mode with software trigger is supported for now.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 MAINTAINERS                 |   1 +
 drivers/iio/adc/Kconfig     |  11 ++
 drivers/iio/adc/Makefile    |   1 +
 drivers/iio/adc/rzt2h_adc.c | 304 ++++++++++++++++++++++++++++++++++++
 4 files changed, 317 insertions(+)
 create mode 100644 drivers/iio/adc/rzt2h_adc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ff2a3257a498..28f939ed03f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21841,6 +21841,7 @@ L:	linux-iio@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
+F:	drivers/iio/adc/rzt2h_adc.c
 
 RENESAS RTCA-3 RTC DRIVER
 M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 58a14e6833f6..b0580fcefef5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1403,6 +1403,17 @@ config RZG2L_ADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rzg2l_adc.
 
+config RZT2H_ADC
+	tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select IIO_ADC_HELPER
+	help
+	  Say yes here to build support for the ADC found in Renesas
+	  RZ/T2H / RZ/N2H SoCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rzt2h_adc.
+
 config SC27XX_ADC
 	tristate "Spreadtrum SC27xx series PMICs ADC"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d008f78dc010..ed647a734c51 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_ROHM_BD79112) += rohm-bd79112.o
 obj-$(CONFIG_ROHM_BD79124) += rohm-bd79124.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
+obj-$(CONFIG_RZT2H_ADC) += rzt2h_adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
 obj-$(CONFIG_SOPHGO_CV1800B_ADC) += sophgo-cv1800b-adc.o
diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
new file mode 100644
index 000000000000..33ce5cc44ff4
--- /dev/null
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/iio/adc-helpers.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+
+#define RZT2H_ADCSR_REG			0x00
+#define RZT2H_ADCSR_ADIE_MASK		BIT(12)
+#define RZT2H_ADCSR_ADCS_MASK		GENMASK(14, 13)
+#define RZT2H_ADCSR_ADCS_SINGLE		0b00
+#define RZT2H_ADCSR_ADST_MASK		BIT(15)
+
+#define RZT2H_ADANSA0_REG		0x04
+#define RZT2H_ADANSA0_CH_MASK(x)	BIT(x)
+
+#define RZT2H_ADDR_REG(x)		(0x20 + 0x2 * (x))
+
+#define RZT2H_ADCALCTL_REG		0x1f0
+#define RZT2H_ADCALCTL_CAL_MASK		BIT(0)
+#define RZT2H_ADCALCTL_CAL_RDY_MASK	BIT(1)
+#define RZT2H_ADCALCTL_CAL_ERR_MASK	BIT(2)
+
+#define RZT2H_ADC_MAX_CHANNELS		16
+
+struct rzt2h_adc {
+	void __iomem *base;
+	struct device *dev;
+
+	struct completion completion;
+	/* lock to protect against multiple access to the device */
+	struct mutex lock;
+
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+	unsigned int max_channels;
+};
+
+static void rzt2h_adc_start(struct rzt2h_adc *adc, unsigned int conversion_type)
+{
+	u16 reg;
+
+	reg = readw(adc->base + RZT2H_ADCSR_REG);
+
+	/* Set conversion type */
+	FIELD_MODIFY(RZT2H_ADCSR_ADCS_MASK, &reg, conversion_type);
+
+	/* Set end of conversion interrupt and start bit. */
+	reg |= RZT2H_ADCSR_ADIE_MASK | RZT2H_ADCSR_ADST_MASK;
+
+	writew(reg, adc->base + RZT2H_ADCSR_REG);
+}
+
+static void rzt2h_adc_stop(struct rzt2h_adc *adc)
+{
+	u16 reg;
+
+	reg = readw(adc->base + RZT2H_ADCSR_REG);
+
+	/* Clear end of conversion interrupt and start bit. */
+	reg &= ~(RZT2H_ADCSR_ADIE_MASK | RZT2H_ADCSR_ADST_MASK);
+
+	writew(reg, adc->base + RZT2H_ADCSR_REG);
+}
+
+static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch, int *val)
+{
+	int ret;
+
+	ret = pm_runtime_resume_and_get(adc->dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&adc->lock);
+
+	reinit_completion(&adc->completion);
+
+	/* Enable a single channel */
+	writew(RZT2H_ADANSA0_CH_MASK(ch), adc->base + RZT2H_ADANSA0_REG);
+
+	rzt2h_adc_start(adc, RZT2H_ADCSR_ADCS_SINGLE);
+
+	/*
+	 * Datasheet Page 2770, Table 41.1:
+	 * 0.32us per channel when sample-and-hold circuits are not in use.
+	 */
+	ret = wait_for_completion_timeout(&adc->completion, usecs_to_jiffies(1));
+	if (!ret) {
+		ret = -ETIMEDOUT;
+		goto disable;
+	}
+
+	*val = readw(adc->base + RZT2H_ADDR_REG(ch));
+	ret = IIO_VAL_INT;
+
+disable:
+	rzt2h_adc_stop(adc);
+
+	mutex_unlock(&adc->lock);
+
+	pm_runtime_put_autosuspend(adc->dev);
+
+	return ret;
+}
+
+static void rzt2h_adc_set_cal(struct rzt2h_adc *adc, bool cal)
+{
+	u16 val;
+
+	val = readw(adc->base + RZT2H_ADCALCTL_REG);
+	if (cal)
+		val |= RZT2H_ADCALCTL_CAL_MASK;
+	else
+		val &= ~RZT2H_ADCALCTL_CAL_MASK;
+
+	writew(val, adc->base + RZT2H_ADCALCTL_REG);
+}
+
+static int rzt2h_adc_calibrate(struct rzt2h_adc *adc)
+{
+	u16 val;
+	int ret;
+
+	rzt2h_adc_set_cal(adc, true);
+
+	ret = read_poll_timeout(readw, val, val & RZT2H_ADCALCTL_CAL_RDY_MASK,
+				200, 1000, true, adc->base + RZT2H_ADCALCTL_REG);
+	if (ret) {
+		dev_err(adc->dev, "Calibration timed out: %d\n", ret);
+		return ret;
+	}
+
+	rzt2h_adc_set_cal(adc, false);
+
+	if (val & RZT2H_ADCALCTL_CAL_ERR_MASK) {
+		dev_err(adc->dev, "Calibration failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2, long mask)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return rzt2h_adc_read_single(adc, chan->channel, val);
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1800;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info rzt2h_adc_iio_info = {
+	.read_raw = rzt2h_adc_read_raw,
+};
+
+static irqreturn_t rzt2h_adc_isr(int irq, void *private)
+{
+	struct rzt2h_adc *adc = private;
+
+	complete(&adc->completion);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_chan_spec rzt2h_adc_chan_template = {
+	.indexed = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE),
+	.type = IIO_VOLTAGE,
+};
+
+static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
+{
+	struct iio_chan_spec *chan_array;
+	unsigned int i;
+	int ret;
+
+	ret = devm_iio_adc_device_alloc_chaninfo_se(adc->dev,
+						    &rzt2h_adc_chan_template,
+						    RZT2H_ADC_MAX_CHANNELS - 1,
+						    &chan_array);
+	if (ret < 0)
+		return dev_err_probe(adc->dev, ret, "Failed to read channel info");
+
+	adc->num_channels = ret;
+	adc->channels = chan_array;
+
+	for (i = 0; i < adc->num_channels; i++)
+		if (chan_array[i].channel + 1 > adc->max_channels)
+			adc->max_channels = chan_array[i].channel + 1;
+
+	return 0;
+}
+
+static int rzt2h_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct rzt2h_adc *adc;
+	int ret, irq;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+	adc->dev = dev;
+	init_completion(&adc->completion);
+
+	ret = devm_mutex_init(dev, &adc->lock);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, adc);
+
+	ret = rzt2h_adc_parse_properties(adc);
+	if (ret)
+		return ret;
+
+	adc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(adc->base))
+		return PTR_ERR(adc->base);
+
+	pm_runtime_set_autosuspend_delay(dev, 300);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	irq = platform_get_irq_byname(pdev, "adi");
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, rzt2h_adc_isr, 0, dev_name(dev), adc);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "rzt2h-adc";
+	indio_dev->info = &rzt2h_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adc->channels;
+	indio_dev->num_channels = adc->num_channels;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id rzt2h_adc_match[] = {
+	{ .compatible = "renesas,r9a09g077-adc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rzt2h_adc_match);
+
+static int rzt2h_adc_pm_runtime_resume(struct device *dev)
+{
+	struct rzt2h_adc *adc = dev_get_drvdata(dev);
+
+	/*
+	 * Datasheet Page 2810, Section 41.5.6:
+	 * After release from the module-stop state, wait for at least
+	 * 0.5 µs before starting A/D conversion.
+	 */
+	fsleep(1);
+
+	return rzt2h_adc_calibrate(adc);
+}
+
+static const struct dev_pm_ops rzt2h_adc_pm_ops = {
+	RUNTIME_PM_OPS(NULL, rzt2h_adc_pm_runtime_resume, NULL)
+};
+
+static struct platform_driver rzt2h_adc_driver = {
+	.probe		= rzt2h_adc_probe,
+	.driver		= {
+		.name		= "rzt2h-adc",
+		.of_match_table = rzt2h_adc_match,
+		.pm		= pm_ptr(&rzt2h_adc_pm_ops),
+	},
+};
+
+module_platform_driver(rzt2h_adc_driver);
+
+MODULE_AUTHOR("Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/T2H / RZ/N2H ADC driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DRIVER");
-- 
2.51.0


