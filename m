Return-Path: <linux-iio+bounces-16503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA28A5583C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 22:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C576D3B5BBE
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 21:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D60E2780F3;
	Thu,  6 Mar 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="puPhJR7l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498512780F1;
	Thu,  6 Mar 2025 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295035; cv=none; b=JwBcNOae6m5KgUoF5VkNAytCZWg638183IypRwTulX6d9j0GcypsBMRRlg3zcJauktpoITA20WFG7wdOJv3vRgEj15g7bLI/A44j7dNKtiWDdiwPHpk7W5jDB5tkRD5Mr+5XQiyNVBGqKvxbCX4gb6hRdY0GPEADkbWOAhD7IcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295035; c=relaxed/simple;
	bh=07X8bjUfE+3at74YQ1ismn8GWXHTCV9L3aQSTdlacI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTdLMjZvrejsFg2S2OWnWkNtttsXj4jFmGbwQtuPuRUtQofQEmZvR4PNBn89wH9sd6OJkVBJy+2RWJjQvqHo1o86qbdb02MnCg49Csf7GMu7e0E9Rs63ZGLo2PZP01870NDcwpHGlxznX/ri3FDCAxWFEzMhzogUDK+e3ZANbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=puPhJR7l; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526HfeC9032609;
	Thu, 6 Mar 2025 16:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V0S1f
	UWOhMUWABmUWRUEjjHwQDCcJBJspPUcyUBunpI=; b=puPhJR7lvUGagGlaycapx
	sjCEorZd965GIF0jMZe50QtJHq12CZTFTNN0Ei+nUGDckLPFxnkkyvHjhYpmObcV
	QQm//qPW+mn3BAOP728wX63Tdpeqpd/8YzpNOUYx5mChAljDlqnoRBgVgWOgY4HZ
	L8ebBgSEQQXXXSBtNQj4dmEVhx7IADeO1m7iIlKBtuqNwolZhN9f2E2EET2YtEJq
	Lh6728YF5pa9sFmYgEjMExHHvYSYewEb+BpXum9bw/BhbdHXyVZwaQhN2N63LJ1l
	qyAZuNRM1uggQond5ghHof8dUX46XjeXbM9UloW5MmEm2CxTzZntYJ7PzlTmiOsI
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 457d6x1tam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:03:33 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 526L3WDg031379
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 16:03:32 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Mar 2025 16:03:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Mar 2025 16:03:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 16:03:32 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526L3D11011538;
	Thu, 6 Mar 2025 16:03:16 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>,
        Jonathan Santos
	<Jonathan.Santos@analog.com>
Subject: [PATCH v4 12/17] iio: adc: ad7768-1: Add GPIO controller support
Date: Thu, 6 Mar 2025 18:03:13 -0300
Message-ID: <efdbddad734021f38a43cc9d101a22424e71dcef.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Qj_U6kg5CImFBl7Pi3zwalf9w2h8_oLS
X-Proofpoint-ORIG-GUID: Qj_U6kg5CImFBl7Pi3zwalf9w2h8_oLS
X-Authority-Analysis: v=2.4 cv=E4w3pbdl c=1 sm=1 tr=0 ts=67ca0da5 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=KKAkSRfTAAAA:8 a=2YwxR-89tvQ4IDrCW4oA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_07,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060160

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

The AD7768-1 has the ability to control other local hardware (such as gain
stages),to power down other blocks in the signal chain, or read local
status signals over the SPI interface.

Add direct mode conditional locks in the gpio callbacks to prevent register
access when the device is in buffered mode.

This change exports the AD7768-1's four gpios and makes them accessible
at an upper layer.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v4 Changes:
* Mentioned in the commit message that we cannot tweak the GPIO controller
  when the device is not in direct mode.

v3 Changes:
* Fixed SoB order.
* Added mising iio_device_release_direct_mode().
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
 drivers/iio/adc/ad7768-1.c | 143 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 2a6317f5b582..d1c3bf4f0f45 100644
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
 #define AD7768_REG_ANALOG2_VCM(x)	FIELD_PREP(AD7768_REG_ANALOG2_VCM_MSK, x)
 
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
 #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
 #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
 
@@ -171,6 +183,7 @@ struct ad7768_state {
 	struct regulator_dev *vcm_rdev;
 	unsigned int vcm_output_sel;
 	struct clk *mclk;
+	struct gpio_chip gpiochip;
 	unsigned int mclk_freq;
 	unsigned int samp_freq;
 	struct completion completion;
@@ -351,6 +364,124 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 	return 0;
 }
 
+static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(chip);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
+				BIT(offset));
+	iio_device_release_direct_mode(indio_dev);
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
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
+			      BIT(offset));
+	iio_device_release_direct_mode(indio_dev);
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
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
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
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static void ad7768_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(chip);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return;
+
+	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
+	if (ret)
+		goto err_release;
+
+	if (val & BIT(offset))
+		regmap_update_bits(st->regmap, AD7768_REG_GPIO_WRITE,
+				   BIT(offset), value << offset);
+
+err_release:
+	iio_device_release_direct_mode(indio_dev);
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
+		.set = ad7768_gpio_set,
+		.owner = THIS_MODULE,
+	};
+
+	return gpiochip_add_data(&st->gpiochip, indio_dev);
+}
+
 static int ad7768_set_freq(struct ad7768_state *st,
 			   unsigned int freq)
 {
@@ -494,8 +625,9 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
-static int ad7768_setup(struct ad7768_state *st)
+static int ad7768_setup(struct iio_dev *indio_dev)
 {
+	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
 	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
@@ -528,6 +660,13 @@ static int ad7768_setup(struct ad7768_state *st)
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
@@ -889,7 +1028,7 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad7768_setup(st);
+	ret = ad7768_setup(indio_dev);
 	if (ret < 0) {
 		dev_err(&spi->dev, "AD7768 setup failed\n");
 		return ret;
-- 
2.34.1


