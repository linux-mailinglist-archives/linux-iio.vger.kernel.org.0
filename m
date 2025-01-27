Return-Path: <linux-iio+bounces-14626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D854A1D93E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC433A76F4
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A6D143759;
	Mon, 27 Jan 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZT8YR8lF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D513D897;
	Mon, 27 Jan 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990853; cv=none; b=FE6kdFfpGsubkFs4+njBgbaaHjze2+wfDcbEtKOAKoP4Ur0iAszkakHmqwfIlSOd9uOn/FIGMAfko9L4pFXm4EgZqar6poaVQWA9Becm/84TBeJie8RoSSYpDHnB10Xk0rudGSpT1rY6mlmKmq5l85FK2VS4JUXHBOAT2zbLen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990853; c=relaxed/simple;
	bh=XTwMKt8PvV4u4K2Xl9MdqP4Ef14TN7HdLJUaYqWm+EU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foHbdjlJd+7JIyqu5/dwyRob6Nr+VddFdZSvLWZLmyfpQ94KQobL5Ub1GTgZVF7+2ZkRXOnGS91hzmk8sXxDohuS+tJ8jWVJcLIiMiaD1dbSOlGbqAoeUf9ZpiwmDRja7aslOZHEUBTbpRPiznBDpkgvKsuLt3+kwhwU1xRC7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZT8YR8lF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDWCOV005775;
	Mon, 27 Jan 2025 10:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+1XaK
	1dqc5UvH57TRpnuIN6JLV/J1snIKjrY48qo1mM=; b=ZT8YR8lF3PrJ0h4pIDO8u
	3VUUrpxrL/dhUNT8vQVp9mcuCqj95vFFsjMOGe/3CqH0bNQSE10mF1jKwmjobmX0
	5qEZeAHJ9H1RHQjQ0wTlnQpz/xX5Tc/4yFhTALaAL+Pr+o5Z8cJjZ+ruzjMedFDa
	h43P5lFtM58/ipkdb7FTQQWXCkIneubpEztAqFvf6edISBx1OqZMgiK9JZYexegg
	56Kkc4ngtoERVeZ6oHKn2nDUyCQSr7oygrsMdhYfbSIQ36uytIZi8Vc2WtR86zy8
	oU4uNKKdswTQEeqVIr0lLS49DSSpJ+4rGIZNvEtD8fvEJrh5J6+K1lEPrrr+SED6
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44eb44gdmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:13:59 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RFDviV011097
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:13:57 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 10:13:57 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:13:57 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFDjUS008452;
	Mon, 27 Jan 2025 10:13:48 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>
Subject: [PATCH v2 12/16] iio: adc: ad7768-1: Add GPIO controller support
Date: Mon, 27 Jan 2025 12:13:45 -0300
Message-ID: <4067fc67ef617edbaea0de21241d59d6ff8eaf98.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 1O3MApAxgVl2xwP2PzVkwLOiGX9P2M6X
X-Proofpoint-GUID: 1O3MApAxgVl2xwP2PzVkwLOiGX9P2M6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

The AD7768-1 has the ability to control other local hardware (such as gain
stages),to power down other blocks in the signal chain, or read local
status signals over the SPI interface.

This change exports the AD7768-1's four gpios and makes them accessible
at an upper layer.

Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
v2 Changes:
* Replaced mutex for iio_device_claim_direct_mode().
* Use gpio-controller property to conditionally enable the
  GPIO support.
* OBS: when the GPIO is configured as output, we should read 
  the current state value from AD7768_REG_GPIO_WRITE.
---
 drivers/iio/adc/ad7768-1.c | 148 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index c540583808c2..e3ea078e6ec4 100644
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
@@ -79,6 +81,19 @@
 #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
 #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
 
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
+#define AD7768_GPIO_INPUT(x)		0x00
+#define AD7768_GPIO_OUTPUT(x)		BIT(x)
+
 #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
 #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
 
@@ -160,6 +175,8 @@ struct ad7768_state {
 	struct regulator *vref;
 	struct mutex lock;
 	struct clk *mclk;
+	struct gpio_chip gpiochip;
+	unsigned int gpio_avail_map;
 	unsigned int mclk_freq;
 	unsigned int samp_freq;
 	struct completion completion;
@@ -309,6 +326,125 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
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
+	return regmap_update_bits(st->regmap,
+				  AD7768_REG_GPIO_CONTROL,
+				  BIT(offset),
+				  AD7768_GPIO_INPUT(offset));
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
+	return regmap_update_bits(st->regmap,
+				  AD7768_REG_GPIO_CONTROL,
+				  BIT(offset),
+				  AD7768_GPIO_OUTPUT(offset));
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
+	if (ret < 0)
+		return ret;
+
+	if (val & BIT(offset))
+		ret = regmap_read(st->regmap, AD7768_REG_GPIO_WRITE, &val);
+	else
+		ret = regmap_read(st->regmap, AD7768_REG_GPIO_READ, &val);
+	if (ret < 0)
+		return ret;
+
+	return !!(val & BIT(offset));
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
+	if (ret < 0)
+		return;
+
+	if (val & BIT(offset))
+		regmap_update_bits(st->regmap,
+				   AD7768_REG_GPIO_WRITE,
+				   BIT(offset),
+				   (value << offset));
+}
+
+static int ad7768_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(chip);
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	if (!(st->gpio_avail_map & BIT(offset)))
+		return -ENODEV;
+
+	st->gpio_avail_map &= ~BIT(offset);
+
+	return 0;
+}
+
+static int ad7768_gpio_init(struct iio_dev *indio_dev)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL,
+			   AD7768_GPIO_UNIVERSAL_EN);
+	if (ret < 0)
+		return ret;
+
+	st->gpio_avail_map = AD7768_GPIO_CONTROL_MSK;
+	st->gpiochip.label = "ad7768_1_gpios";
+	st->gpiochip.base = -1;
+	st->gpiochip.ngpio = 4;
+	st->gpiochip.parent = &st->spi->dev;
+	st->gpiochip.can_sleep = true;
+	st->gpiochip.direction_input = ad7768_gpio_direction_input;
+	st->gpiochip.direction_output = ad7768_gpio_direction_output;
+	st->gpiochip.get = ad7768_gpio_get;
+	st->gpiochip.set = ad7768_gpio_set;
+	st->gpiochip.request = ad7768_gpio_request;
+	st->gpiochip.owner = THIS_MODULE;
+
+	return gpiochip_add_data(&st->gpiochip, indio_dev);
+}
+
 static int ad7768_set_freq(struct ad7768_state *st,
 			   unsigned int freq)
 {
@@ -457,8 +593,9 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
-static int ad7768_setup(struct ad7768_state *st)
+static int ad7768_setup(struct iio_dev *indio_dev)
 {
+	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
 	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
@@ -491,6 +628,13 @@ static int ad7768_setup(struct ad7768_state *st)
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
@@ -708,7 +852,7 @@ static int ad7768_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	ret = ad7768_setup(st);
+	ret = ad7768_setup(indio_dev);
 	if (ret < 0) {
 		dev_err(&spi->dev, "AD7768 setup failed\n");
 		return ret;
-- 
2.34.1


