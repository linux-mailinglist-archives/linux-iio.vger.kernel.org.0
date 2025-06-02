Return-Path: <linux-iio+bounces-20134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81872ACAD66
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A3188EA86
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4D20E708;
	Mon,  2 Jun 2025 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ADszSxK0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3220E309;
	Mon,  2 Jun 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864405; cv=none; b=FZSU3GsV3Ugfqe31M5AmpkQJVxKOiZ1sh5VSlsuMCASt0XNG0ya7Ayq9v6w5P/+FW8whoi5kOOi4O91PkPYCha3OhQj47JJcJR22ckHK3DP61ugpzRCNEbGCbwRi16sNwDInL6RWh2P5K5IA65XdXUasAF1GvQuVTM5PWgF2tE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864405; c=relaxed/simple;
	bh=MVrYYsLS5L3dJ1NuzeYIw2FfRi/9Lkcwnuk73Xs6lWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKamZMlax0HVUiaC4VWvu0sF13Lm+CJOYCcq9OZd29bVZOPhLnd/DDoIW6GVkyE1tK5ooHiJAashG0e/4712cZuFBM+xGJ6b5lfaTHlL65MRzg3SL7gM+ec+cyQWgW6rRsmL8nKK9QK1HGRJj2jSvEC1cwGFVsZ6GwsrXIiPF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ADszSxK0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552BBvYP026424;
	Mon, 2 Jun 2025 07:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=COK3W
	s8mRRTMM7QH4alcOqZ0xQ94RoMxR4NhRAR7C+s=; b=ADszSxK0baF55msofMbU/
	C9wVkktYmyY4Kz1kNODeR+6SLbdOdEcpY0TWUjD0K9LPi3pIlZfTFjd5J7smSIUA
	CPV2ureH2dz2ec8RtuST6UpKJe8XdFf6zMYoHABCPPbI3SKmLIt0W2RcpUk2n5jF
	BeDQ3qtVMrpq03yPTIWTCECTx3dRafK4MgEAEZyKeYmjTiD+97ZvfC3O7Y/zdkNr
	vG1ZUimpOFjXhIZ6wxu2zjHnbpXIfYv8bQYf1T2qYs1pVd3DheVgl9gadD9BN5w7
	z6sHTlKN7wq4AEBRuJCJZrFy0SdpH5OmUHQLY086QIUOwDXtH12RRcINlhh93osA
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47133mj2mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 07:39:45 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 552BdiOT043366
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 07:39:44 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 07:39:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 07:39:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 07:39:44 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552BdQIK024951;
	Mon, 2 Jun 2025 07:39:28 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 08/11] iio: adc: ad4170: Add GPIO controller support
Date: Mon, 2 Jun 2025 08:39:23 -0300
Message-ID: <ac555bd20e66b09c246cea301f9132ee0d1ec9c5.1748829860.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1748829860.git.marcelo.schmitt@analog.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: _f5Rb_ppZTnzbTXbVesO_UDxK_m5QEyh
X-Proofpoint-ORIG-GUID: _f5Rb_ppZTnzbTXbVesO_UDxK_m5QEyh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMCBTYWx0ZWRfX6xUGn/MK2pal
 xkCWQCJ9gvpF4ahlX1QdMmjRWVdTkX2iPMvIoWYfOjwC4oqnwGlT4av6TYcIvuNgxY7JLNkigIv
 VzxqaSUIL1YMvYS2o9v+XbHGT47qqBF58jQ2Au0b29ii1wnEbhxRbI1IXN28Sqz8n3qIttqEZcC
 kkcTuTm/Rmlqki3UecGwt8T9Cf6MPWWT7F1XFKvshOoiTkEteI3jF3ghSVXdghYSn567BIpuyK8
 l3DapHV6bNAJJKGq995ZTrsRgYeFPmRMPtGAjpVcuEbxDCPinVO/NBlP7z0cn84fQbvMbUC/zQ4
 ziE7CSLhleAqaiXTAdH4ZNoD6ylsB4J3iAvx6bODgm4VW9toPGSdNAI4I6LNojA/u27oKk6sfUo
 15XVu/5Ex9BcDdKka/xtq2bFwf7gL/MHwkgAyyaMDRQS7M86n3vEOvIyeUL+zkgqE8hIeJq4
X-Authority-Analysis: v=2.4 cv=DY4XqutW c=1 sm=1 tr=0 ts=683d8d81 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8 a=kZiCEncQAPmOuCAweDIA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1011 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020100

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
Change log v3 -> v4
- Made AD4170 depend on GPIOLIB.

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
index 2173e79ce96c..3aa1553c0e3d 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
@@ -63,6 +64,9 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_GPIO_MODE_REG				0x191
+#define AD4170_GPIO_OUTPUT_REG				0x193
+#define AD4170_GPIO_INPUT_REG				0x195
 #define AD4170_ADC_CTRL_CONT_READ_EXIT_REG		0x200 /* virtual reg */
 
 #define AD4170_REG_READ_MASK				BIT(14)
@@ -101,6 +105,12 @@
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
@@ -141,9 +151,14 @@
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
@@ -170,6 +185,9 @@
 
 #define AD4170_ADC_CTRL_CONT_READ_EXIT			0xA5
 
+/* GPIO pin functions  */
+#define AD4170_GPIO_UNASSIGNED				0x00
+
 static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
 	[AD4170_DATA_24B_REG] = 3,
@@ -207,6 +225,9 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_GPIO_MODE_REG] = 2,
+	[AD4170_GPIO_OUTPUT_REG] = 2,
+	[AD4170_GPIO_INPUT_REG] = 2,
 	[AD4170_ADC_CTRL_CONT_READ_EXIT_REG] = 0,
 };
 
@@ -347,7 +368,9 @@ struct ad4170_state {
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
 	struct clk_hw int_clk_hw;
+	struct gpio_chip gpiochip;
 	unsigned int clock_ctrl;
+	int gpio_fn[AD4170_NUM_GPIO_PINS];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -1468,6 +1491,194 @@ static int ad4170_soft_reset(struct ad4170_state *st)
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
@@ -1781,7 +1992,18 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
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


