Return-Path: <linux-iio+bounces-19493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD42AB54F8
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EB23A5E9D
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107CF28DF24;
	Tue, 13 May 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dBj/nano"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B428DEEE;
	Tue, 13 May 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139818; cv=none; b=STLQkuVzECFRsZZi+GDvbVQMGRixqdtc+vr/D5TeAtho38KvQ50pBcUnBu818O4VgTDY5hHtXp39VJfFBMcGu1EdODWaU7gTpOe0GnVJVRj4h4TCskBHR+fb9LsPtJ6GMWuJMu7wsPEtcfEO7hDM8j8ZonPaT1dqy7DpKwDnnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139818; c=relaxed/simple;
	bh=Zy6Nc8fJWn313CFAV2MjHlRybOwKanE3Hr8dzuwDGIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mW+kS6wnYtLR4N5BeFzHWyLaGNTHKZ+y2XOIW3C1iQ1h/Z4qG5FVHqWvWMGDxOHcgNFhj8XivsUj+QRpkAv5y9PO8hk/mSWuFJTjnbnYSHmPe4h64tk4smrwS35C9PNvRyePERxr7+mmdGvS5aTfd6/Fvf006tkx35j5SVcXj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dBj/nano; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9mOuB024809;
	Tue, 13 May 2025 08:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gb1na
	LG4f1feCe7XMWWAUtWL1AqTwPmogvrb7lwzjnQ=; b=dBj/nano4d0Z+Jakl2wMQ
	glOCKXjS649Yd7GjILrsd5GjgIRyIpXU7sfU1yQJYosrsk3A35Du1QQGbWZYR25T
	TR9xfVmrfyTftGSPVfDpWZm41kk43sEUsKlIljDIc2Buc/EALQZdDn6FtIIx47Of
	F9yQjXaqW2hcMJelicWYGuL6G7Bg9NWPO1sJ5qqSi2AOQl2D45LoAjIEZOXpuz1x
	h2IMA/jMNg4Rig2pzrTeMlpcngxe/MqHVFTZ+cXwsgFxUH0Q12PaYjARxaiwodH8
	uHdMRxDtbPaqsQ6TAUiEZIemIgJoCXro6rjEPJsLgXQsEySwTFKkOkW0GHD6lQ4a
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46m3s98svr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:36:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54DCaOWL041215
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 08:36:24 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:36:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:36:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 May 2025 08:36:23 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54DCa8ft007539;
	Tue, 13 May 2025 08:36:11 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 08/10] iio: adc: ad4170: Add GPIO controller support
Date: Tue, 13 May 2025 09:36:07 -0300
Message-ID: <6e7dde3fa52161873c6e05891a7410bc8ef75249.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: H2KQsLV_xAu6HUDonMaZUuyQVap9yHq5
X-Authority-Analysis: v=2.4 cv=ZaUdNtVA c=1 sm=1 tr=0 ts=68233cd6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=zf3Y3FNcO-N4N2fxa9kA:9
X-Proofpoint-GUID: H2KQsLV_xAu6HUDonMaZUuyQVap9yHq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEyMCBTYWx0ZWRfX/855yPKBzoQv
 VHTkhjDbnGF8Wg+jKEWyxQOcfdjJLETEjTV8WyW9SMG+lgnvZJQM8WDF5yGcgMRtLNkLwGpPMC/
 A3n0LxY1aXgz5bcCQoRJ6DOFboNZ6vwOGPKOiWibtGafHpTQ97qMOGjpEczsDl4kO5bgrBwFFir
 n1vNs5hqJWxle/bmRGFrWNdqWXlRTC3h1YDvo/Ql+8diZ5MUG8OCXo90WayyCxPfdX13P4DXwc5
 NuoWCoqc7oM2AP8r9n25az6fFIu7RkXNddZJ1XZZibcHCqzaXTTPvHSmhJ2TAbBfXWjVmZ4E/kn
 huCGntDUlplenoYk/B7LfGUzcpAadcaooR7kf5OifnRfTSsKMvkGcR2amuFW2JLAYUpJA/DNoQv
 fVtE+AdMdN8G8gCQu+N+jz0m0HBfxg8ZVYSjgnMy6fC8jKxPDZNEYrItM5KvVVAMkmLtQGca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130120

The AD4170 has four multifunctional pins that can be used as GPIOs. The
GPIO functionality can be accessed when the AD4170 chip is not busy
performing continuous data capture or handling any other register
read/write request. Also, the AD4170 does not provide any interrupt based
on GPIO pin states so AD4170 GPIOs can't be used as interrupt sources.

Implement gpio_chip callbacks to make AD4170 GPIO pins controllable through
the gpiochip interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3
- Defined masks for updating GPIO mode register.
- Replaced regmap_clear/set_bits() by regmap_update_bits() to set GPIO direction.
- Removed GPIO direction check before setting GPIO output values.
- Made use of regmap_assign_bits() to set GPIO output reg bits.
- Made value to be set as GPIO output state be either 0 or 1.
- No longer locking on state mutex on GPIO set since GPIO output should not
  conflict with other direct mode functionality (e.g. single-shot read).

 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4170.c | 224 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6e4b14243599..a328f03eea34 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -78,6 +78,7 @@ config AD4170
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	depends on COMMON_CLK
+	select GPIOLIB
 	help
 	  Say yes here to build support for Analog Devices AD4170 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 9ab6df002e5e..31f126a0f76f 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
@@ -62,6 +63,9 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_GPIO_MODE_REG				0x191
+#define AD4170_GPIO_OUTPUT_REG				0x193
+#define AD4170_GPIO_INPUT_REG				0x195
 #define AD4170_ADC_CTRL_CONT_READ_EXIT_REG		0x200 /* virtual reg */
 
 #define AD4170_REG_READ_MASK				BIT(14)
@@ -100,6 +104,12 @@
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
@@ -140,9 +150,14 @@
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
@@ -172,6 +187,9 @@
 /* Analog pin functions  */
 #define AD4170_PIN_UNASIGNED				0x00
 
+/* GPIO pin functions  */
+#define AD4170_GPIO_UNASIGNED				0x00
+
 static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
 	[AD4170_DATA_24B_REG] = 3,
@@ -209,6 +227,9 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_GPIO_MODE_REG] = 2,
+	[AD4170_GPIO_OUTPUT_REG] = 2,
+	[AD4170_GPIO_INPUT_REG] = 2,
 	[AD4170_ADC_CTRL_CONT_READ_EXIT_REG] = 0,
 };
 
@@ -349,8 +370,10 @@ struct ad4170_state {
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
 	struct clk_hw int_clk_hw;
+	struct gpio_chip gpiochip;
 	struct clk *ext_clk;
 	unsigned int clock_ctrl;
+	int gpio_fn[AD4170_NUM_GPIO_PINS];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -1515,6 +1538,194 @@ static int ad4170_soft_reset(struct ad4170_state *st)
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
+		bool valid = st->gpio_fn[i] == AD4170_GPIO_UNASIGNED;
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
@@ -1828,7 +2039,18 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
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


