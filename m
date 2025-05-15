Return-Path: <linux-iio+bounces-19565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68163AB915A
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 23:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C092C1C005D2
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 21:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA4629B8D4;
	Thu, 15 May 2025 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="V+5cGEx6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012EB29B770;
	Thu, 15 May 2025 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343636; cv=none; b=IafIYcfJ8Br7tgs9aC84DddX8rGl/7wdTUmzsVgfd4HuN5VVAzMbHkQDR374fXtFwTg+pUQrHdY5K31HfaTsF0AGISsYRQuCvy3SYZ7jMIhBNdaX65a4SBTjrAi23NvNabrf2SDmsmcRJlrQ0tmQuyenlQga3ooagxi6ycvNWTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343636; c=relaxed/simple;
	bh=KYuPMWl8RDZhuXNeryNe9dm/RVNWsXTs8Vf/0hy328M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3tdQ56Lz6Xn7/oyQLB9LYwprHUz+DqZETu/bicU/T6ubIwAza3NtvbspVugDetY2+b6RxyI+vE57BqnC3igZ2z7B6QhDFZ7xg1FbpS5oz5mVR3JvOEcRdHUac6QUVV3SQMelVthmJR+bX+F5f73pOVMUmudG9Pb9mYiuz247Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=V+5cGEx6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FGltBm009246;
	Thu, 15 May 2025 17:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nUaF/
	Vq0dCtNNmpKnR8/E/L0K2SiLe3bRf37GX/eblQ=; b=V+5cGEx6pR/rYBioJrXV+
	Rgd2fqljQqusRwaOiSRt95dXMYZjLDjnlMmGuJb6AdOT2DvPs2PPl5+WzDzocsg4
	1txWmJLsSFCVhrx7YMn6WgSsgElSb6yWgV33mnrPBV7ZlHNJYRMDRYK4+AdsB8ju
	QgmmicvP7tGD/fwbkEH61lD2PdbV1lxw7CnAAWeD0FIE5VWsjt0ZD8fMCWusQIdq
	TxgN4cfCsboo3OGL595cXwWzrDETLZj6F0duS5sz5QM4bV3jW3KVa7TorKZnZYlj
	O4SmA+zkjxqvT25oRn1IALH8AP7vj3brCm6vVa4xVO3M2HMijAmzIe5jKM3sSLlt
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46ngknj9wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:13:48 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54FLDlIA025085
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 May 2025 17:13:47 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 15 May
 2025 17:13:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 15 May 2025 17:13:47 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54FLDV6u018860;
	Thu, 15 May 2025 17:13:33 -0400
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
Subject: [PATCH v8 06/11] iio: adc: ad7768-1: Add GPIO controller support
Date: Thu, 15 May 2025 18:13:28 -0300
Message-ID: <bbfe68dd9dfb1ed4aaa73d214423bc592b2a8817.1747175187.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747175187.git.Jonathan.Santos@analog.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDIwNyBTYWx0ZWRfXz86KrZIn41Tn
 fbtGP0Fvhj0kKyyNT4DmZduA9m3JsvzevZy2Do1QRdeomJ0Cvyhe4fD8/qJ5hJ/vVLnn3pU4nAG
 NjQsKoiWnZpSl/YGS95HWcJ+YyOkBYYBiTrzT2vuXdSvGF1gnzPD7MBuOdyviZTJn/uwDEXkrf7
 VETCEX4nxHxzkry8fWUgQ+rvVb2bJn/VORrQl2HneuqIeGmmY1nU8s81Gz31zzAYt+wtD/2N9Eq
 Sa51AxuJR/KfqaxjwZT3P8X4nys3gOE9iYKYtpnbb+XBRLPyGxDCseEctLVQ4R9TuL2f1OMBJxn
 Q17+vc9VROgA8n8S5zstvGcX9iZj7bpoFSK2szqNKU1Qj4oZKmApvaHBl75pAPrsM8ccte4+GQk
 08n9yuxumow262rSOWfbVaMKAzk7erqAOMtAF3Rl9Es2rZf2oK66JC3w+KMLOyz6rGHyegEr
X-Authority-Analysis: v=2.4 cv=B5u50PtM c=1 sm=1 tr=0 ts=6826590c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=KKAkSRfTAAAA:8 a=ItmwtGPuVRerelARzv0A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BRUi1yJgm0hzsUqA8HPG7nbBwBaK3u9n
X-Proofpoint-ORIG-GUID: BRUi1yJgm0hzsUqA8HPG7nbBwBaK3u9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_09,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150207

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
v8 Changes:
* None.

v7 Changes:
* moved gpiochip field in the ad7768_state struct.
* replaced regmap_update_bits() for regmap_assign_bits() in the gpio_set() function.
* other nits.
* removed gpio.h header.

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
 drivers/iio/adc/ad7768-1.c | 140 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index cd5ce774df72..d0366d570c14 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/minmax.h>
@@ -88,6 +89,16 @@
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
@@ -177,6 +188,7 @@ struct ad7768_state {
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
+	struct gpio_chip gpiochip;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -355,6 +367,122 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
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
+		ret = regmap_assign_bits(st->regmap, AD7768_REG_GPIO_WRITE,
+					 BIT(offset), value);
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
@@ -496,8 +624,9 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
-static int ad7768_setup(struct ad7768_state *st)
+static int ad7768_setup(struct iio_dev *indio_dev)
 {
+	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
 	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
@@ -530,6 +659,13 @@ static int ad7768_setup(struct ad7768_state *st)
 	if (IS_ERR(st->gpio_sync_in))
 		return PTR_ERR(st->gpio_sync_in);
 
+	/* Only create a Chip GPIO if flagged for it */
+	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
+		ret = ad7768_gpio_init(indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	/* Set the default sampling frequency to 32000 kSPS */
 	return ad7768_set_freq(st, 32000);
 }
@@ -869,7 +1005,7 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad7768_setup(st);
+	ret = ad7768_setup(indio_dev);
 	if (ret < 0) {
 		dev_err(&spi->dev, "AD7768 setup failed\n");
 		return ret;
-- 
2.34.1


