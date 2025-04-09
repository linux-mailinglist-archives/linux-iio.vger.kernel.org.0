Return-Path: <linux-iio+bounces-17870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB47EA824BF
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624FC7A7D43
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA44263C82;
	Wed,  9 Apr 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BrANpxds"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43625F7BA;
	Wed,  9 Apr 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201573; cv=none; b=ZV453OoQbLSNonql+/S/+/ehZfFRmLgLeREMtNvvByu1Yrpwa6/Ug4bWz5RuA/LQ9g3yJVyCB1gBz/pkYzdna+bn6NUri650lf0/YhCWHMEWhE3mZYx3e3UaQWVXhPIKFOPI32kGdkwGZ5y8Auu5nVImvOLYRi6d/R/maYzmsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201573; c=relaxed/simple;
	bh=9tfM/kaooL9C4Rth+aizrQuILx26QObxp9PHSlsx2OU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLl5uLWgyMdEf8SwWbljyB/Rb5OEBFuqXptrcf7BK4jtt0I0fIsvlLtanBXTu5LH5LcddL5ZIDVnMoRhd+zoACwOan3eyiVomcj1QmIWm/O/LTRoRVVxMQXcO1nqNf33rdK8YvnWwb2dod/go+EWLvprpGMUx/UoQBZ/K9nrM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BrANpxds; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53999D10002733;
	Wed, 9 Apr 2025 08:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=u5Qxr
	F9u32dWo5z+bCbwinzVK+Nus/W8Cfj2qOJhRZk=; b=BrANpxdsEO//LVn5AXGDQ
	IQH84PQQooLzVk14i+R+OB++I1CiPG/qHNKTAjtXsV2wz17laINmxIZOIMfMpSIm
	6gLI3ibkTX9VRkaURkbqtj+JmR5gbta70bzSXJ935H+9xpdxS8kDzU6OX0H+OXuW
	PY7E3J4f1V0uLfLxg1J2Nhzs5Omosf9kG1Y9E0Sx83SewtOemIGxEembRIX6Odkz
	mI1CSALRClI0zsqs8HHY6QcM0+m9CJWNNXScsndxMY4DkjL4ABeA94jna2WvWbh6
	cgGf0A51vpTrblSN2yP0mPW80erluF91NLRyBnvMSMstXDOvDIqldacBW6+iOXEH
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6dquu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:25:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 539CPqpT041950
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Apr 2025 08:25:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 9 Apr 2025
 08:25:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 9 Apr 2025 08:25:52 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 539CPbSL016960;
	Wed, 9 Apr 2025 08:25:39 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 5/7] iio: adc: ad4170: Add GPIO controller support
Date: Wed, 9 Apr 2025 09:25:35 -0300
Message-ID: <247566f848cdf2a245a8b6da6a84c22e155beeb7.1744200264.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: VO6Yi72DCrhj3f3zFaCuobqc67y-u4z2
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f66752 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=26uHqrsnSEcdkGl8FGcA:9
X-Proofpoint-GUID: VO6Yi72DCrhj3f3zFaCuobqc67y-u4z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_04,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090073

The AD4170 has four multifunctional pins that can be used as GPIOs. The
GPIO functionality can be accessed when the AD4170 chip is not busy
performing continuous data capture or handling any other register
read/write request. Also, the AD4170 does not provide any interrupt based
on GPIO pin states so AD4170 GPIOs can't be used as interrupt sources.

Implement gpio_chip callbacks so to make AD4170 GPIO pins controllable
through the gpiochip interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4170.c | 167 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 97cf4465038f..b382e7f3dbe0 100644
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
@@ -79,6 +80,7 @@
 #define AD4170_FIR_CTRL					0x141
 #define AD4170_COEFF_DATA_REG				0x14A
 #define AD4170_COEFF_ADDR_REG				0x14C
+#define AD4170_GPIO_MODE_REG				0x191
 #define AD4170_GPIO_OUTPUT_REG				0x193
 #define AD4170_GPIO_INPUT_REG				0x195
 
@@ -189,6 +191,7 @@
 /* Device properties and auxiliary constants */
 
 #define AD4170_NUM_ANALOG_PINS				9
+#define AD4170_NUM_GPIO_PINS				4
 #define AD4170_MAX_CHANNELS				16
 #define AD4170_MAX_ANALOG_PINS				8
 #define AD4170_MAX_SETUPS				8
@@ -340,6 +343,7 @@ struct ad4170_state {
 	struct clk *ext_clk;
 	struct clk_hw int_clk_hw;
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
+	struct gpio_chip gpiochip;
 	u32 int_pin_sel;
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
 	struct completion completion;
@@ -1553,6 +1557,156 @@ static int ad4170_soft_reset(struct ad4170_state *st)
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
+	ret = regmap_read(st->regmap16, AD4170_GPIO_MODE_REG, &val);
+	if (ret)
+		goto err_release;
+
+	/*
+	 * If the GPIO is configured as an input, read the current value from
+	 * AD4170_GPIO_INPUT_REG. Otherwise, read the input value from
+	 * AD4170_GPIO_OUTPUT_REG.
+	 */
+	if (val & BIT(offset * 2))
+		ret = regmap_read(st->regmap16, AD4170_GPIO_INPUT_REG, &val);
+	else
+		ret = regmap_read(st->regmap16, AD4170_GPIO_OUTPUT_REG, &val);
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
+	ret = regmap_read(st->regmap16, AD4170_GPIO_MODE_REG, &val);
+	if (ret)
+		goto err_release;
+
+	if (val & BIT(offset * 2 + 1))
+		ret = regmap_update_bits(st->regmap16, AD4170_GPIO_OUTPUT_REG,
+					 BIT(offset), value << offset);
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
+	ret = regmap_read(st->regmap16, AD4170_GPIO_MODE_REG, &val);
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
+	ret = regmap_clear_bits(st->regmap16, AD4170_GPIO_MODE_REG,
+				BIT(offset * 2 + 1));
+	if (ret)
+		goto err_release;
+
+	ret = regmap_set_bits(st->regmap16, AD4170_GPIO_MODE_REG,
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
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = regmap_clear_bits(st->regmap16, AD4170_GPIO_MODE_REG,
+				BIT(offset * 2));
+	if (ret)
+		goto err_release;
+
+	ret = regmap_set_bits(st->regmap16, AD4170_GPIO_MODE_REG,
+			      BIT(offset * 2 + 1));
+
+err_release:
+	iio_device_release_direct(indio_dev);
+
+	ad4170_gpio_set(gc, offset, value);
+	return ret;
+}
+
+static int ad4170_gpio_init(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+
+	st->gpiochip = (struct gpio_chip) {
+		.label = "ad4170_gpios",
+		.base = -1,
+		.ngpio = 4,
+		.parent = &st->spi->dev,
+		.can_sleep = true,
+		.get_direction = ad4170_gpio_get_direction,
+		.direction_input = ad4170_gpio_direction_input,
+		.direction_output = ad4170_gpio_direction_output,
+		.get = ad4170_gpio_get,
+		.set_rv = ad4170_gpio_set,
+		.owner = THIS_MODULE,
+	};
+
+	return devm_gpiochip_add_data(&st->spi->dev, &st->gpiochip, indio_dev);
+}
+
 static int ad4170_parse_reference(struct ad4170_state *st,
 				  struct fwnode_handle *child,
 				  struct ad4170_setup *setup)
@@ -1855,7 +2009,18 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
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
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int ad4170_initial_config(struct iio_dev *indio_dev)
-- 
2.47.2


