Return-Path: <linux-iio+bounces-20380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE92AD43EA
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9C63A6333
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102502673B0;
	Tue, 10 Jun 2025 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wnilpfKo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218B26658F;
	Tue, 10 Jun 2025 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587632; cv=none; b=kpqMAfdbRveIxuQ+IW6aMf21KwTNjo5NsC/CIQgxf2QRJvXN0xD2EUI8q8250WefV5dJTTcYlR6Tj31ziywqKRNVbcb8Taoo6CgsuRJ7maj+WaMAutSel+IZVqVqOwNahVtXcE55dBhnOETODG8MkasgsgwXB9zymXCk7xLJPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587632; c=relaxed/simple;
	bh=KBHPXvWOX0tqD8WykUzpqeuYeQ2Phb5HGjO+vGukGZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRbde4zPPc/IYkc9dcb1ZkrKkBnwSBsYG5WzwaGgpWTnba6EkeO9Jas1iqNKgu8o6md6vN6f2S2bGOmPihPf5GBWWRa0OVJfgMk/aS1J6B3A2aHWtOJctXRQRy8xsOscfVQTTDTfuZYwF5cdCn3JLhIPhQhwT+KrDa5ZukM+2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wnilpfKo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIBxdM012590;
	Tue, 10 Jun 2025 16:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yIWLB
	Wn+IZyi5NXfTxudYKnSWz932he9Oeo/MCgXw3M=; b=wnilpfKoBaDOkGQETsJ3j
	Do2AyuKEqoaRJ0wHtA1LfZm+IRGjW21YX3FQA1V8OuKfa3gIUEzxDNQbgp4le+B2
	sIlniCvGr5plxqfs4M0qvL94Su/9v9UmT8L2+baixlU4+jRD/VGuwoex+us6FxxZ
	dgqfNyJYk+cYQEZgK1f2b3EzdUK9/54QZtvakJZRs5gEMZDXh3nPoUPP/DUfPrp1
	YbpB33N4Pp+Qu4uHn10yl1wQLT+ER17TQN8gyzl8zLqwidu2Jv8HPx3TvifRLX/B
	W221MN8oxLYUs5PXi0M3Ng0tFZFQtxn26wViTwZ254UCo5E0NT64hnNGd2rCHgY2
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476hwsbkj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 16:33:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55AKXXeo037696
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 16:33:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 16:33:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 16:33:33 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55AKXG6o019936;
	Tue, 10 Jun 2025 16:33:19 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 08/11] iio: adc: ad4170: Add GPIO controller support
Date: Tue, 10 Jun 2025 17:33:16 -0300
Message-ID: <834e630a45f8b3ffe93f5663b356046d6c6fdd95.1749582679.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1749582679.git.marcelo.schmitt@analog.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: SqzFWfQDafm8Rv_VTCieC7nrBBEipvH1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2NiBTYWx0ZWRfX6+lrtSO0uNGn
 C+O/NC5e1BglsXbSK9jrW+FEXHN11P3ZfvS6UWHQg4HeaE2D0gaUDpOzKB9iTIriOlsZQu/2dtX
 gul9xpG+o4PmV+amNgi0MA9xt26wgTMYS7J++r022YquzK0+8T2E1cCbhDZkWe2XRvIS7CukAXd
 vt3Uvm7xClMEJ8TPyU2f6IEWvS10+8x99i8df4r8T41bUDQ26LiCle/PVOUaEDo0BsHitjpXrmj
 Mw+Z4dOjA2HTUjPX6/gXncL7t61MOOaTTL3CQqbC116OEkI0xXVYgy7d9769bP9b2bwhX6BVzwJ
 48ltJW/xBGyKtyNGl7E5qr80dzKww2636o1mAOaqvIk1QV9jK+MGtMZ1K+OIcVyf8Qug8un1EbI
 uBffGMVGvvpeip1eN9PRVTyFruyQSWSEjPG1fkH94wdNv/Qq9Rl1tFRJyvuVMzCqcNbFxP1r
X-Authority-Analysis: v=2.4 cv=daWA3WXe c=1 sm=1 tr=0 ts=6848969e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8 a=kZiCEncQAPmOuCAweDIA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SqzFWfQDafm8Rv_VTCieC7nrBBEipvH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100166

The AD4170 has four multifunctional pins that can be used as GPIOs. The
GPIO functionality can be accessed when the AD4170 chip is not busy
performing continuous data capture or handling any other register
read/write request. Also, the AD4170 does not provide any interrupt based
on GPIO pin states so AD4170 GPIOs can't be used as interrupt sources.

Implement gpio_chip callbacks to make AD4170 GPIO pins controllable through
the gpiochip interface.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes from v4.

 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4170.c | 224 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 32e5177ceebe..0c16b2d5947d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -92,6 +92,7 @@ config AD4170
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	depends on COMMON_CLK
+	depends on GPIOLIB
 	help
 	  Say yes here to build support for Analog Devices AD4170 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 310eb32d0d1c..b3189c5f8078 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
@@ -66,6 +67,9 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_GPIO_MODE_REG				0x191
+#define AD4170_GPIO_OUTPUT_REG				0x193
+#define AD4170_GPIO_INPUT_REG				0x195
 #define AD4170_ADC_CTRL_CONT_READ_EXIT_REG		0x200 /* virtual reg */
 
 #define AD4170_REG_READ_MASK				BIT(14)
@@ -104,6 +108,12 @@
 /* AD4170_FILTER_REG */
 #define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
 
+/* AD4170_GPIO_MODE_REG */
+#define AD4170_GPIO_MODE_GPIO0_MSK			GENMASK(1, 0)
+#define AD4170_GPIO_MODE_GPIO1_MSK			GENMASK(3, 2)
+#define AD4170_GPIO_MODE_GPIO2_MSK			GENMASK(5, 4)
+#define AD4170_GPIO_MODE_GPIO3_MSK			GENMASK(7, 6)
+
 /* AD4170 register constants */
 
 /* AD4170_CLOCK_CTRL_REG constants */
@@ -144,9 +154,14 @@
 #define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
 #define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
 
+/* AD4170_GPIO_MODE_REG constants */
+#define AD4170_GPIO_MODE_GPIO_INPUT			1
+#define AD4170_GPIO_MODE_GPIO_OUTPUT			2
+
 /* Device properties and auxiliary constants */
 
 #define AD4170_NUM_ANALOG_PINS				9
+#define AD4170_NUM_GPIO_PINS				4
 #define AD4170_MAX_CHANNELS				16
 #define AD4170_MAX_ANALOG_PINS				8
 #define AD4170_MAX_SETUPS				8
@@ -173,6 +188,9 @@
 
 #define AD4170_ADC_CTRL_CONT_READ_EXIT			0xA5
 
+/* GPIO pin functions  */
+#define AD4170_GPIO_UNASSIGNED				0x00
+
 static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
 	[AD4170_DATA_24B_REG] = 3,
@@ -210,6 +228,9 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_GPIO_MODE_REG] = 2,
+	[AD4170_GPIO_OUTPUT_REG] = 2,
+	[AD4170_GPIO_INPUT_REG] = 2,
 	[AD4170_ADC_CTRL_CONT_READ_EXIT_REG] = 0,
 };
 
@@ -350,7 +371,9 @@ struct ad4170_state {
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
 	struct clk_hw int_clk_hw;
+	struct gpio_chip gpiochip;
 	unsigned int clock_ctrl;
+	int gpio_fn[AD4170_NUM_GPIO_PINS];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -1473,6 +1496,194 @@ static int ad4170_soft_reset(struct ad4170_state *st)
 	return 0;
 }
 
+static int ad4170_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ad4170_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD4170_GPIO_MODE_REG, &val);
+	if (ret)
+		goto err_release;
+
+	/*
+	 * If the GPIO is configured as an input, read the current value from
+	 * AD4170_GPIO_INPUT_REG. Otherwise, read the input value from
+	 * AD4170_GPIO_OUTPUT_REG.
+	 */
+	if (val & BIT(offset * 2))
+		ret = regmap_read(st->regmap, AD4170_GPIO_INPUT_REG, &val);
+	else
+		ret = regmap_read(st->regmap, AD4170_GPIO_OUTPUT_REG, &val);
+	if (ret)
+		goto err_release;
+
+	ret = !!(val & BIT(offset));
+err_release:
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ad4170_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ad4170_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_assign_bits(st->regmap, AD4170_GPIO_OUTPUT_REG,
+				 BIT(offset), !!value);
+
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4170_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ad4170_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD4170_GPIO_MODE_REG, &val);
+	if (ret)
+		goto err_release;
+
+	if (val & BIT(offset * 2 + 1))
+		ret = GPIO_LINE_DIRECTION_OUT;
+	else
+		ret = GPIO_LINE_DIRECTION_IN;
+
+err_release:
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ad4170_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ad4170_state *st = iio_priv(indio_dev);
+	unsigned long gpio_mask;
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	switch (offset) {
+	case 0:
+		gpio_mask = AD4170_GPIO_MODE_GPIO0_MSK;
+		break;
+	case 1:
+		gpio_mask = AD4170_GPIO_MODE_GPIO1_MSK;
+		break;
+	case 2:
+		gpio_mask = AD4170_GPIO_MODE_GPIO2_MSK;
+		break;
+	case 3:
+		gpio_mask = AD4170_GPIO_MODE_GPIO3_MSK;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_release;
+	}
+	ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG, gpio_mask,
+				 AD4170_GPIO_MODE_GPIO_INPUT << (2 * offset));
+
+err_release:
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ad4170_gpio_direction_output(struct gpio_chip *gc,
+					unsigned int offset, int value)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ad4170_state *st = iio_priv(indio_dev);
+	unsigned long gpio_mask;
+	int ret;
+
+	ret = ad4170_gpio_set(gc, offset, value);
+	if (ret)
+		return ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	switch (offset) {
+	case 0:
+		gpio_mask = AD4170_GPIO_MODE_GPIO0_MSK;
+		break;
+	case 1:
+		gpio_mask = AD4170_GPIO_MODE_GPIO1_MSK;
+		break;
+	case 2:
+		gpio_mask = AD4170_GPIO_MODE_GPIO2_MSK;
+		break;
+	case 3:
+		gpio_mask = AD4170_GPIO_MODE_GPIO3_MSK;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_release;
+	}
+	ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG, gpio_mask,
+				 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * offset));
+
+err_release:
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ad4170_gpio_init_valid_mask(struct gpio_chip *gc,
+				       unsigned long *valid_mask,
+				       unsigned int ngpios)
+{
+	struct ad4170_state *st = gpiochip_get_data(gc);
+	unsigned int i;
+
+	/* Only expose GPIOs that were not assigned any other function. */
+	for (i = 0; i < ngpios; i++) {
+		bool valid = st->gpio_fn[i] == AD4170_GPIO_UNASSIGNED;
+
+		__assign_bit(i, valid_mask, valid);
+	}
+
+	return 0;
+}
+
+static int ad4170_gpio_init(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+
+	st->gpiochip.label = "ad4170_gpios";
+	st->gpiochip.base = -1;
+	st->gpiochip.ngpio = AD4170_NUM_GPIO_PINS;
+	st->gpiochip.parent = &st->spi->dev;
+	st->gpiochip.can_sleep = true;
+	st->gpiochip.init_valid_mask = ad4170_gpio_init_valid_mask;
+	st->gpiochip.get_direction = ad4170_gpio_get_direction;
+	st->gpiochip.direction_input = ad4170_gpio_direction_input;
+	st->gpiochip.direction_output = ad4170_gpio_direction_output;
+	st->gpiochip.get = ad4170_gpio_get;
+	st->gpiochip.set_rv = ad4170_gpio_set;
+	st->gpiochip.owner = THIS_MODULE;
+
+	return devm_gpiochip_add_data(&st->spi->dev, &st->gpiochip, indio_dev);
+}
+
 static int ad4170_parse_reference(struct ad4170_state *st,
 				  struct fwnode_handle *child,
 				  struct ad4170_setup *setup)
@@ -1785,7 +1996,18 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	return ad4170_parse_channels(indio_dev);
+	ret = ad4170_parse_channels(indio_dev);
+	if (ret)
+		return ret;
+
+	/* Only create a GPIO chip if flagged for it */
+	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
+		ret = ad4170_gpio_init(indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int ad4170_initial_config(struct iio_dev *indio_dev)
-- 
2.47.2


