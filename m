Return-Path: <linux-iio+bounces-13978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F2DA0445F
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A451887DEB
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB311F4703;
	Tue,  7 Jan 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AwQhvpRc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650F1F3D5E;
	Tue,  7 Jan 2025 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263633; cv=none; b=uJD1MZ3D+9CmsKISyBVfHYo43C7GDksDOvOlsfeH4nMr1WWgstfTD8XgO5qKlGj/JG67kPKskDTMfn/e6zzVcSZ2LvJKmbKTI4HtU7SW32gVbm8c9IEaZe1aedRMnKI5jKzaJd+sg0fKmusSQz3Haw3w+CILVbNm+xbol7tAHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263633; c=relaxed/simple;
	bh=YVG9iVktMrgekCYSVNh+ipNlqvJ+Fgq3ovy1mhcQWLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShyKwNsN9hi/tQ+DKs/62ViBaRyigCMiYoHY9rFOL0ydAEpHXwD+cSfDlrvkIobm/F5SfRPGvCcSaKEaBRNmm1DRJ+qyqXRf49irYARjIGSxHVCELIZpmwXdbj9w24e6JCnnSATkRCqmSp0SjQpF/Ia/DhEBzScylB/nX5lOSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AwQhvpRc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507FM9ua006101;
	Tue, 7 Jan 2025 10:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=F2he/
	p1cDktAWRDFo0/Z5UxvhBAbeAN0wEi31gfLMTs=; b=AwQhvpRc3Iqa6lZ6pa/3/
	pLw4K/koKp6F5rEon4yyGryxj6Bn5dLTNRoPlTotynLJIdHlWaDlnsDE6lplM2iy
	rnCWg8GaPZyh62V/CxAfCm1u8426p3GB+ev5PhIHUL/HGCvxLJ1Z6iep/GD/DykJ
	e4s8WHZBLdsVprIwVQO71kJiYIUNEjWed8oUzQhQSz8XKy79Iv39TAtublCDRAcd
	5UWwNL9GaEj7UMAFKzDyEpqXbY5wbJaImr+ykyY+dizoK+ZfDObZiGLPfX2JnNCS
	6BLJvI1fJjCoUc9jmTsLv9DhaPV2bY3zSzRv9G9jix8R5W/3ZBntjX386paty+Ta
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4416uq00ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:26:56 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FQtXO034177
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:26:55 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:26:55 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:26:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:26:55 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FQgmT030343;
	Tue, 7 Jan 2025 10:26:44 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 12/15] iio: adc: ad7768-1: Add GPIO controller support
Date: Tue, 7 Jan 2025 12:26:41 -0300
Message-ID: <e09454c98accd763d6d5e67f9f7262aabec91acd.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yQTgyGMnjppiQwz-ID8p22OaOqKOU_I6
X-Proofpoint-GUID: yQTgyGMnjppiQwz-ID8p22OaOqKOU_I6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070130

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

The AD7768-1 has the ability to control other local hardware (such as gain
stages),to power down other blocks in the signal chain, or read local
status signals over the SPI interface.

This change exports the AD7768-1's four gpios and makes them accessible
at an upper layer.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 121 +++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 675af9ea856d..9741a6d47942 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -10,6 +10,8 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -77,6 +79,19 @@
 #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
 #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
 
+/* AD7768_REG_GPIO_CONTROL */
+#define AD7768_GPIO_CONTROL_MSK		GENMASK(3, 0)
+#define AD7768_GPIO_UNIVERSAL_EN	BIT(7)
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
 
@@ -190,6 +205,8 @@ struct ad7768_state {
 	struct regulator *vref;
 	struct mutex lock;
 	struct clk *mclk;
+	struct gpio_chip gpiochip;
+	unsigned int gpio_avail_map;
 	unsigned int mclk_freq;
 	unsigned int samp_freq;
 	unsigned int common_mode_voltage;
@@ -338,6 +355,106 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 	return 0;
 }
 
+static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ad7768_state *st = gpiochip_get_data(chip);
+
+	guard(mutex)(&st->lock);
+	return ad7768_spi_reg_write_masked(st,
+					  AD7768_REG_GPIO_CONTROL,
+					  BIT(offset),
+					  AD7768_GPIO_INPUT(offset));
+}
+
+static int ad7768_gpio_direction_output(struct gpio_chip *chip,
+					unsigned int offset, int value)
+{
+	struct ad7768_state *st = gpiochip_get_data(chip);
+
+	guard(mutex)(&st->lock);
+	return ad7768_spi_reg_write_masked(st,
+					  AD7768_REG_GPIO_CONTROL,
+					  BIT(offset),
+					  AD7768_GPIO_OUTPUT(offset));
+}
+
+static int ad7768_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ad7768_state *st = gpiochip_get_data(chip);
+	unsigned int val;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	ret = ad7768_spi_reg_read(st, AD7768_REG_GPIO_CONTROL, &val, 1);
+	if (ret < 0)
+		return ret;
+
+	if (val & BIT(offset))
+		ret = ad7768_spi_reg_read(st, AD7768_REG_GPIO_WRITE, &val, 1);
+	else
+		ret = ad7768_spi_reg_read(st, AD7768_REG_GPIO_READ, &val, 1);
+	if (ret < 0)
+		return ret;
+
+	return !!(val & BIT(offset));
+}
+
+static void ad7768_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct ad7768_state *st = gpiochip_get_data(chip);
+	unsigned int val;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	ret = ad7768_spi_reg_read(st, AD7768_REG_GPIO_CONTROL, &val, 1);
+	if (ret < 0)
+		return;
+
+	if (val & BIT(offset))
+		ad7768_spi_reg_write_masked(st,
+					    AD7768_REG_GPIO_WRITE,
+					    BIT(offset),
+					    (value << offset));
+}
+
+static int ad7768_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ad7768_state *st = gpiochip_get_data(chip);
+
+	if (!(st->gpio_avail_map & BIT(offset)))
+		return -ENODEV;
+
+	st->gpio_avail_map &= ~BIT(offset);
+
+	return 0;
+}
+
+static int ad7768_gpio_init(struct ad7768_state *st)
+{
+	int ret;
+
+	ret = ad7768_spi_reg_write(st,
+				   AD7768_REG_GPIO_CONTROL,
+				   AD7768_GPIO_UNIVERSAL_EN);
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
+	return gpiochip_add_data(&st->gpiochip, st);
+}
+
 static int ad7768_set_freq(struct ad7768_state *st,
 			   unsigned int freq)
 {
@@ -538,6 +655,10 @@ static int ad7768_setup(struct ad7768_state *st)
 	if (IS_ERR(st->gpio_sync_in))
 		return PTR_ERR(st->gpio_sync_in);
 
+	ret = ad7768_gpio_init(st);
+	if (ret < 0)
+		return ret;
+
 	/* Set the default sampling frequency to 32000 kSPS */
 	return ad7768_set_freq(st, 32000);
 }
-- 
2.34.1


