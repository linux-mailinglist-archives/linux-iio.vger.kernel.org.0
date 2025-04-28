Return-Path: <linux-iio+bounces-18742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE5A9E55E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 02:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DA7178C9E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 00:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D728E0F;
	Mon, 28 Apr 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ImeJ0ruT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F320ED;
	Mon, 28 Apr 2025 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799224; cv=none; b=pACwQLjo9UAtZ/Ph2Dszuj8JPAtxXfl4UW7d71pS9GA1Izji89YFuokm6U8An2nQldEBoh6GCaCD9RL4neYDRe1QnUzqFn78I60vGUUz963pkImd28JBYx4dWCzfZMXnoQdKj9H0z9MJrQg9Y0CE7HDCuosA6q2RMrVx2Gl6Ctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799224; c=relaxed/simple;
	bh=AtMV1LZI1MezTMdmeEt1su/7u4oC5phC23XGZJBxeVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djE4a6KD3nFFiYH5MmiRBCBMRi8Y6px+gnEXpFEtthNjKt3KcnhlZUir5xfGLwOqgwlrFtp+WPth1jXtsWQIoekeNfYuRHAQfReCJaRR/W4ypwY+Qxgrmp6dP1XB6oPCRKj6TD210zySSA3jV3vy/aNxOBKfDPYwlY7vnVS7zmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ImeJ0ruT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RMAnoK020130;
	Sun, 27 Apr 2025 20:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UkRfT
	+VHzeCcwOB93NHBPjoLXyQESZKUVBgd6oRthu4=; b=ImeJ0ruT0nLRBLnRl6sZ4
	VYucUWtuB5LCdQOn6D+FeY1LQOB4V57uccqooWrWY0zU7tw1yaxM9Byleacy4GMP
	m42Vz2mPMYC+354C1YZhYITVQ/qixl8tZU08DIHKD5w+AT/17pMb3lDB4P5STUGl
	hN5kU7r96I6vAwLDMN4CrNpAG4Px9ANCSdF30zF1r7bi/TBERLP6EqtiUWM3lWDy
	ohT/TkNC0H//ckllrjGeCd6a9KOdbPTmNbuRpNTbIeCFxcPiWFAH4mENk1Nit0sg
	p/MDqAQJvSHhGI7IGXYy8qNvauo+ibfEvPiLjGoeo2zLTxdIFYDs8DX9qraHaIfJ
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 468vd6sbnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Apr 2025 20:13:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53S0DXES028947
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Apr 2025 20:13:33 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 27 Apr 2025 20:13:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 27 Apr 2025 20:13:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Apr 2025 20:13:32 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53S0DFxU014614;
	Sun, 27 Apr 2025 20:13:17 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Jonathan Santos
	<Jonathan.Santos@analog.com>
Subject: [PATCH v6 06/11] iio: adc: ad7768-1: Add GPIO controller support
Date: Sun, 27 Apr 2025 21:13:14 -0300
Message-ID: <2a8a327e589703ee53dbfb5190d20680ac3b350f.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tghbZx3_xIQCGoTt4dVI5MompNSXItYU
X-Authority-Analysis: v=2.4 cv=b+Wy4sGx c=1 sm=1 tr=0 ts=680ec82f cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=KKAkSRfTAAAA:8 a=2YwxR-89tvQ4IDrCW4oA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDIwMiBTYWx0ZWRfX5Ep61KjlteWy /vscKkGyRIv6K90v7CqqFdi8wYIqUjfYIkTQbo01UrD5R5YlCO0PX+hD4BFRPRaqjVgILmqilWO RHLASqwAr1LJg/rwKqKY5p5Ger3SVTf2K/wJ/9JvyyzRZOC6QkxJGsy8dBLsMTk9Ot5fNDxFY0Q
 O8GkmZ9JZeUOWF0pu2XHq8FwrNxuF5GxAu0Pmba/Wszg6bDqfMob1FWmD46WQe6Kskdq84ESrOs bjNWES/hQ8xlaLh/jEHVDamAHNd7Ox6xr6soDuUB2m5AXqEFS2+AVsS+LZ0sxH2Cih7CNH01hBy rBunWUC2qk0ggn77b1ySKbhqmbajG12Cs0bYtPSAU9QyymKtfJGC0sv5Wv2+GVrrRrz1kkYgL1V
 d5uuoLKhiduUc0tcoOSUvoHCMrKG+zNQYO5FF97ipFsU2ZdV96hbMV3W91wx09AKzS874StC
X-Proofpoint-ORIG-GUID: tghbZx3_xIQCGoTt4dVI5MompNSXItYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504270202

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

The AD7768-1 has the ability to control other local hardware (such as gain
stages),to power down other blocks in the signal chain, or read local
status signals over the SPI interface.

Add direct mode conditional locks in the gpio callbacks to prevent register
access when the device is in buffered mode.

This change exports the AD7768-1's four gpios and makes them accessible
at an upper layer.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v6 Changes:
* Replaced deprecated .set callback with .set_rv.

v5 Changes:
* Use the new new iio_device_claim/release_direct() functions.
* replaced gpiochip_add_data() for devm_gpiochip_add_data().

v4 Changes:
* Mentioned in the commit message that we cannot tweak the GPIO controller
  when the device is not in direct mode.

v3 Changes:
* Fixed SoB order.
* Added missing iio_device_release_direct_mode().
* Simplified some regmap writes.
* Removed ad7768_gpio_request() callback.
* Fixed line wrapping.

v2 Changes:
* Replaced mutex for iio_device_claim_direct_mode().
* Use gpio-controller property to conditionally enable the
  GPIO support.
* OBS: when the GPIO is configured as output, we should read 
  the current state value from AD7768_REG_GPIO_WRITE.
---
 drivers/iio/adc/ad7768-1.c | 141 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 0364d73329b0..1a546a0dc654 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -9,6 +9,8 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -86,6 +88,16 @@
 #define AD7768_REG_ANALOG2_VCM_MSK	GENMASK(2, 0)
 #define AD7768_REG_ANALOG2_VCM(x)	FIELD_PREP(AD7768_REG_ANALOG2_VCM_MSK, (x))
 
+/* AD7768_REG_GPIO_CONTROL */
+#define AD7768_GPIO_UNIVERSAL_EN	BIT(7)
+#define AD7768_GPIO_CONTROL_MSK		GENMASK(3, 0)
+
+/* AD7768_REG_GPIO_WRITE */
+#define AD7768_GPIO_WRITE_MSK		GENMASK(3, 0)
+
+/* AD7768_REG_GPIO_READ */
+#define AD7768_GPIO_READ_MSK		GENMASK(3, 0)
+
 #define AD7768_VCM_OFF			0x07
 
 enum ad7768_conv_mode {
@@ -168,6 +180,7 @@ struct ad7768_state {
 	struct regulator_dev *vcm_rdev;
 	unsigned int vcm_output_sel;
 	struct clk *mclk;
+	struct gpio_chip gpiochip;
 	unsigned int mclk_freq;
 	unsigned int samp_freq;
 	struct completion completion;
@@ -353,6 +366,122 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 	return 0;
 }
 
+static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(chip);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_clear_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
+				BIT(offset));
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ad7768_gpio_direction_output(struct gpio_chip *chip,
+					unsigned int offset, int value)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(chip);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_set_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
+			      BIT(offset));
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ad7768_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(chip);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
+	if (ret)
+		goto err_release;
+
+	/*
+	 * If the GPIO is configured as an output, read the current value from
+	 * AD7768_REG_GPIO_WRITE. Otherwise, read the input value from
+	 * AD7768_REG_GPIO_READ.
+	 */
+	if (val & BIT(offset))
+		ret = regmap_read(st->regmap, AD7768_REG_GPIO_WRITE, &val);
+	else
+		ret = regmap_read(st->regmap, AD7768_REG_GPIO_READ, &val);
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
+static int ad7768_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(chip);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
+	if (ret)
+		goto err_release;
+
+	if (val & BIT(offset))
+		ret = regmap_update_bits(st->regmap, AD7768_REG_GPIO_WRITE,
+					 BIT(offset), value << offset);
+
+err_release:
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int ad7768_gpio_init(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL,
+			   AD7768_GPIO_UNIVERSAL_EN);
+	if (ret)
+		return ret;
+
+	st->gpiochip = (struct gpio_chip) {
+		.label = "ad7768_1_gpios",
+		.base = -1,
+		.ngpio = 4,
+		.parent = &st->spi->dev,
+		.can_sleep = true,
+		.direction_input = ad7768_gpio_direction_input,
+		.direction_output = ad7768_gpio_direction_output,
+		.get = ad7768_gpio_get,
+		.set_rv = ad7768_gpio_set,
+		.owner = THIS_MODULE,
+	};
+
+	return devm_gpiochip_add_data(&st->spi->dev, &st->gpiochip, indio_dev);
+}
+
 static int ad7768_set_freq(struct ad7768_state *st,
 			   unsigned int freq)
 {
@@ -494,8 +623,9 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
-static int ad7768_setup(struct ad7768_state *st)
+static int ad7768_setup(struct iio_dev *indio_dev)
 {
+	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
 	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
@@ -528,6 +658,13 @@ static int ad7768_setup(struct ad7768_state *st)
 	if (IS_ERR(st->gpio_sync_in))
 		return PTR_ERR(st->gpio_sync_in);
 
+	/* Only create a Chip GPIO if flagged for it */
+	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
+		ret = ad7768_gpio_init(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* Set the default sampling frequency to 32000 kSPS */
 	return ad7768_set_freq(st, 32000);
 }
@@ -881,7 +1018,7 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad7768_setup(st);
+	ret = ad7768_setup(indio_dev);
 	if (ret < 0) {
 		dev_err(&spi->dev, "AD7768 setup failed\n");
 		return ret;
-- 
2.34.1


