Return-Path: <linux-iio+bounces-18774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3940CA9F0B4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E811A82B26
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5681F26982E;
	Mon, 28 Apr 2025 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z6OXAqIl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908A266F0F;
	Mon, 28 Apr 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843377; cv=none; b=pp716UaVwFewyJC3btay3a7XtoOJN+AWNJwIObitaEKA9ogDM/qi7u8PXNX46r/kNwnZwzvnKFcFhTrfAAJBm/i2jruS1LL2PBfHt1c2BXm0Jdjg0oyzeoW2BE6yI+eksFQPwBd8LSKzLssuG2pn3cXnSFDHOtajn81sRfjfZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843377; c=relaxed/simple;
	bh=6/gTxaAez4TXaVuSYkQQdWL0DGipIv10iPSjyxXbDmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhK8xvwDTkVsQYgVMltLQW2eA65u9MfS5d9WXJr9SdLOtSEUjRgD7VMAR1ESa13w1apGS7/ZtS0tTaE9peMijne4CnMA44tl8rlAzOQG0mZ5ESu6Isf9xgJRpqkAAh6yaDKxe59hmy6EEd73YvCH65j/fFXDx26tB5NHVns0Gfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z6OXAqIl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9fQFb019001;
	Mon, 28 Apr 2025 08:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=J6ccm
	vIRETeshSd70OdSsgcKrDEd44pu9mQG/sedLIM=; b=z6OXAqIlzKbfYQgDZewvD
	7e5c8aswh/i8WoCRYlJz9rScOwz9NUo6PJ97ND86p+aS3un1gAcKfV0lfeCDmXr/
	7w2/1in7+Uq7mdcJ1PNw+nGtFjzPluI5sP8qpVjhG8nJo9mw/T3oY1KHZ3wXc539
	HHPER7j9M3nN1hXrEhDivlfIT/9b/nQvX38Az+WdADPATjhsyD6KKIbq/QuykIuC
	MWCdwTskGhg+MlCspRObYNrdMWvnSsoOr+W0JK+BsNZuPhF1yUTQzZjVG7b3uaGU
	JXl4fC/C5Xc6+MEi3oWXW8pSYVmfPiVwMVyx/BiXimzUtosiCH11tx6Cvi6ME3Nc
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 468vd6wuqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 08:29:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53SCT9s3011835
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 08:29:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 28 Apr
 2025 08:29:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Apr 2025 08:29:09 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53SCSta1032545;
	Mon, 28 Apr 2025 08:28:58 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 5/7] iio: adc: ad4170: Add GPIO controller support
Date: Mon, 28 Apr 2025 09:28:55 -0300
Message-ID: <e4abdd44a28c395dd51c5a492aeda5074331e6ea.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: MROYQismPb9y6aGiw9vmdX3hJjfg5XCD
X-Authority-Analysis: v=2.4 cv=b+Wy4sGx c=1 sm=1 tr=0 ts=680f749f cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=wGyvZO2WfsqVDq8ZtuAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEwMyBTYWx0ZWRfX1A6brbyUd5un /ZEfFVHID5nGbvV3UObtF33d0jbPvnVoYmCDekSL3srEzvvtGYHNRU7JSd+YhCVqaCeZQAS0v8I FCmf38j2zYsnPlMWl0JkRA6mX6r/hrdKqEo2KlfAR6cNiJSlPNyQsPT20hQlUPXV3rdLUsZS12G
 65YN/cMOCk4nUNmM4BHTHtr/87YibuUr7ibOHZG7wGDt00kJWLenlm6SQvnHljWa291gw6G6HEx tSItA25eTsLyqAiX9KcM/WGQmhZgsLZPk3lOXCRkYSKvya4JT96fj5qz7D3+zU8c5563VMynBjJ Pbj+yj38VTh6V+J/TcU4s6F+VwzpK8pg/nFk5vXflSdCKEi1PrhQeHzzAaGCXzX9r9Ytp4DnELN
 2rLoP59Hen0ZvDTajpxbjbRkM8/gngBedN8DIRTSNDVgDUIMZDK9gMK7OLq9GOT38GLrNP0F
X-Proofpoint-ORIG-GUID: MROYQismPb9y6aGiw9vmdX3hJjfg5XCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504280103

The AD4170 has four multifunctional pins that can be used as GPIOs. The
GPIO functionality can be accessed when the AD4170 chip is not busy
performing continuous data capture or handling any other register
read/write request. Also, the AD4170 does not provide any interrupt based
on GPIO pin states so AD4170 GPIOs can't be used as interrupt sources.

Implement gpio_chip callbacks to make AD4170 GPIO pins controllable through
the gpiochip interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
changes since v1
- Call gpio_set() at begining of gpio_direction_output() instead of at the end of it.
- Return -EPERM if try to set a GPIO configured for input.
- Now locking on state mutex before setting output GPIO values.
- Used gpiochio init_valid_mask() to only init available GPIOs.

 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4170.c | 191 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 60eb79a7975f..ad141bf48679 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -78,6 +78,7 @@ config AD4170
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select COMMON_CLK
+	select GPIOLIB
 	help
 	  Say yes here to build support for Analog Devices AD4170 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index b0c332cb5480..612676c1c88a 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -61,6 +62,9 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_GPIO_MODE_REG				0x191
+#define AD4170_GPIO_OUTPUT_REG				0x193
+#define AD4170_GPIO_INPUT_REG				0x195
 #define AD4170_ADC_CTRL_CONT_READ_EXIT_REG		0x200 /* virtual reg */
 
 #define AD4170_REG_READ_MASK				BIT(14)
@@ -170,6 +174,7 @@
 /* Device properties and auxiliary constants */
 
 #define AD4170_NUM_ANALOG_PINS				9
+#define AD4170_NUM_GPIO_PINS				4
 #define AD4170_MAX_CHANNELS				16
 #define AD4170_MAX_ANALOG_PINS				8
 #define AD4170_MAX_SETUPS				8
@@ -239,6 +244,9 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_GPIO_MODE_REG] = 2,
+	[AD4170_GPIO_OUTPUT_REG] = 2,
+	[AD4170_GPIO_INPUT_REG] = 2,
 	[AD4170_ADC_CTRL_CONT_READ_EXIT_REG] = 0,
 };
 
@@ -370,6 +378,7 @@ struct ad4170_state {
 	struct clk *ext_clk;
 	struct clk_hw int_clk_hw;
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
+	struct gpio_chip gpiochip;
 	u32 int_pin_sel;
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
 	struct completion completion;
@@ -1525,6 +1534,175 @@ static int ad4170_soft_reset(struct ad4170_state *st)
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
+	unsigned int val;
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	guard(mutex)(&st->lock);
+	ret = regmap_read(st->regmap, AD4170_GPIO_MODE_REG, &val);
+	if (ret)
+		goto err_release;
+
+	if (val & BIT(offset * 2 + 1))
+		ret = regmap_update_bits(st->regmap, AD4170_GPIO_OUTPUT_REG,
+					 BIT(offset), value << offset);
+	else
+		ret = -EPERM;
+
+err_release:
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
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_clear_bits(st->regmap, AD4170_GPIO_MODE_REG,
+				BIT(offset * 2 + 1));
+	if (ret)
+		goto err_release;
+
+	ret = regmap_set_bits(st->regmap, AD4170_GPIO_MODE_REG,
+			      BIT(offset * 2));
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
+	int ret;
+
+	ret = ad4170_gpio_set(gc, offset, value);
+	if (ret)
+		return ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_clear_bits(st->regmap, AD4170_GPIO_MODE_REG,
+				BIT(offset * 2));
+	if (ret)
+		goto err_release;
+
+	ret = regmap_set_bits(st->regmap, AD4170_GPIO_MODE_REG,
+			      BIT(offset * 2 + 1));
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
+	for (i = 0; i < ngpios; i++)
+		__assign_bit(i, valid_mask, st->gpio_fn[i] == AD4170_PIN_UNASIGNED);
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
@@ -1833,7 +2011,18 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
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


