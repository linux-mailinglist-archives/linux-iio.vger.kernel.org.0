Return-Path: <linux-iio+bounces-19325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8D6AB00FA
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869B8171302
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5D28642F;
	Thu,  8 May 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="A26aCX3E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045C221294;
	Thu,  8 May 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723904; cv=none; b=T+fZwjV5u+9iaLDWUt50XtHaSAGScwZ/Ghui6oefCn0zDT3swx+b7rVawc4pOd2nHz9HfrT3EEdWMsRpcL+T/tTm3sKDdNkYdUWc6FKWOEeBxRGrZNCtNAmP3OpUkIPYTG440O9IqL2MfOvZUh4HzopMkDy5UASKoge/l1Op99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723904; c=relaxed/simple;
	bh=mnLm4h1NuX44LptWL2u5xumNR9aGw6kS0ZCb5a6T7nc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEf+4/kFyDRWbHSWeKUapk7ossrmvFC8sp1nQnnVQm8Z2X3F6gUEytClBpYIiKEsjcQCGUFPq4DD/6SDPIgFL0+TKcZjH0E4rK7Dgi2rWBkS/93hS1abwEECBEmc4Mfb8WsmLhu7WKM7h8DWGiWm5tWlcTSMkutLI6M7PWYjCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=A26aCX3E; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548DMfTA013536;
	Thu, 8 May 2025 13:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=o5Job
	2JeyPQC0+XMuUHl3+TmLceDbOT7m+Hu2nKm7qo=; b=A26aCX3Ef3CD60hA0YdPo
	ze9S+6rCJiVWBRcs7bBfLw3XA7mW7hOUa/gSx83ie7v4yOCeZUaCu7n9pUBt3X0g
	WpjCmlpLZeEaPbRcjSJ+cdMEtoYx4PoMasY6/8ophzHf0DE3mjufOd2YYHnMf5mw
	7hWbLKzXS0zE/l/rJBcptx7Ldz6MIiL48oI+m7OSQQvJ/RLnSZPH0u+aJ5DVqtGn
	fJt0HpPunlmCxYnrdnYnHj+HbQVIgtrF1oivaH1dc8ZQJhatYteYMX5Xpn7KXcHe
	4m+LCAKIvNOTrNZ1NFy8h+kANamJ6j9XgOI8hZLFy1gH1apwqo/H27XQVPlc71kR
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46gpct32hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:04:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 548H4ldt022812
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 13:04:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 8 May 2025
 13:04:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 13:04:46 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548H4UGL015893;
	Thu, 8 May 2025 13:04:32 -0400
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
Subject: [PATCH v7 07/12] iio: adc: ad7768-1: Add GPIO controller support
Date: Thu, 8 May 2025 14:04:30 -0300
Message-ID: <0ce451f62aa22a5f6261c15516695c681bff60b0.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746662899.git.Jonathan.Santos@analog.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=J/eq7BnS c=1 sm=1 tr=0 ts=681ce430 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=KKAkSRfTAAAA:8 a=ItmwtGPuVRerelARzv0A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4O3wrjHrzreQgrqNfxkznS5coj3RiI7j
X-Proofpoint-ORIG-GUID: 4O3wrjHrzreQgrqNfxkznS5coj3RiI7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfX7ZwSWJJuxq2p
 BX9w/VuDvD3Otc58qi36/IZclGfLAggOWY1spEYdsPlZiLPKhY9BnSCSGx2FEtPJ687hfhVZtJy
 QEpO5ZKQIoshNZaADq8XVakJWxJ4psYyHnlyWxB8SuLSP55CAQC1z1LaGHZmTjaTzm9OdSu2sUP
 YQJdZUchQrRVvg+fW9gXDlJkcsNpUE46Up4m6PCVH2tHk+O4g8WhB7PqW27ltLtfzkc/yUeJqGc
 kgp8sDWbnx3lAgf55Y6Rnp8LpFnkDefgQrcls3a3rz755T2/wMcHQJU55fAL9Zu9706LGV5iVyG
 0IxwzrNkUlVp5S0kq2U/7OTtQiMmlpGQObypK4cf0eRhnkfTMXvpJNYSHRe9JFXNY1srOHphFOU
 J9+sxfn2zmFhZTQLNrrooOdyY4NeDXfkEBe/mCx00+xjOnae8+JEbkmjncsRCjzRhPDou4RS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080149

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


