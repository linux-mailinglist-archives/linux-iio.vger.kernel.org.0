Return-Path: <linux-iio+bounces-26808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D33CA8382
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 16:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C0403256A4D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE752E8DFA;
	Fri,  5 Dec 2025 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="daJifsFO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14A32720C;
	Fri,  5 Dec 2025 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947600; cv=none; b=Vv8/Xyo7Ey4S5hThb2Ppx62hqwULcxdYGNIGg5jNE7oMKOwcTojANcYBUCQpUs6CKTNZWuHy5L2A+UA4n1R2BP5x4mbJ2Vz8vQBQ0cA0NvRH7Z4pw9Lc2j8Ey4GObBE/uS8au0QqGl3jqWZLJ3DjhGLV2nY2ZeQGEYrY9FzZ7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947600; c=relaxed/simple;
	bh=uq609zIRAOVsAf4uucshpjyCAMyR9HyUFzZbfYrcEe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mz8e2M6pIK6qzPGurHnSK1jbI9lMVBjzlY/1ABkaSYaNPqvFf7QUqzhqYX+zs/1O77t6GgxPCwe+kxI7mRiBu8nyPT2IvTll06LG321j8+TKmStAJoH4CaItgc/AWqaKSonS+ctUbtTvBBbxsF2D1F0A4aLXSEzPrfJWjGhyB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=daJifsFO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5EjxBO172678;
	Fri, 5 Dec 2025 10:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Vbtuk
	usOXD7WxI062sEQzo5CcWBmHPyhF4OcVREbmS4=; b=daJifsFO6FCttOwbkBURF
	SteXBzUgTQ5Jrdn7ealJSJvJZMi26pVIMgCj3GBACQVRkC8zZwu+U97sAs1kn2Kz
	pjEXvZeyI6e/JqKeJWIVhP40+vdmCPKq0P2JyW/QyahXh/vyAPn2x3CoopHDUZ1G
	7ReEGgjjwex1MQ110cylCHvwCm78uFjRLfyQbulYVkBuHAKh9E4ADfoNkMJmmJqC
	ol18lYE7uWX9ef1PoncVppEaodmhGbFlWSVfZCZiVlweizbowX6kZcMyKum94wpG
	M1N3n2E15pFwjKuXHCzBFhto3KSgNk8F+H4PO25ldTwO5iVJ5krPk6RbG4juhgDj
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aufyscn6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:12:51 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5FCoXq033585
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 10:12:50 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 10:12:50 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 10:12:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 10:12:50 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5FC8SJ029946;
	Fri, 5 Dec 2025 10:12:43 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Fri, 5 Dec 2025 16:12:10 +0100
Subject: [PATCH v3 9/9] iio: adc: ad4062: Add GPIO Controller support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-staging-ad4062-v3-9-8761355f9c66@analog.com>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
In-Reply-To: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764947528; l=5635;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=uq609zIRAOVsAf4uucshpjyCAMyR9HyUFzZbfYrcEe0=;
 b=EMgSPj6+FkEhY8ozHtLL8QCCDWIiDiJ+ZLQQNK6psLbPjKfBfcCF3vhhMacHzNqrcvLbhpu5B
 j4a9vCJkBCMBgOBJlrx2bPR4FjAvt8Ew5wy7djjF7tKqsDUEkpBrV3S
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=G4cR0tk5 c=1 sm=1 tr=0 ts=6932f674 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=xMyuZJbwAj7bCYiyej4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iyXUigWsP5l9yKJZiyOEghs_Dm0xCzOe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDExMCBTYWx0ZWRfXxPSX+6dzbUCR
 EHKTFjcIQHappZv2EtWoE+R1IfxOvEH1kmUJ2WvVzBtBNY7JPag+Hbh+jgUBlcM6ZkGsnOXnc5U
 sC3WQYON55GEM6vObZ7uqTSHm0d5H2neuN7KhgsM0dEIWZfDjj2CjwqmFWILCf0bttkO0yxr+iV
 BEIb3eFaEEtsOVilVtB1MkXBN3TklXYo/J+6L4vTnlTeXRGcHLm9xmbzbu2YQUv6liz5rR8jn3q
 J/DyArDogOCou99k4oc2xXZjSMOYMnIUXwXbZGXiqSegB7P3Q1joKRk2RGqhAfKf053p1m3dwv6
 AiA1Q2Y3ekfw15cwh9F/nDR7ZGe5ofOyBHQukIfKZDFfXetc6DNpXrogCU6kSiKdcW2Ee+hXLmX
 8k8kI3x/ZkSAHXVgKLZe04OtG4Mlng==
X-Proofpoint-ORIG-GUID: iyXUigWsP5l9yKJZiyOEghs_Dm0xCzOe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050110

When gp0 or gp1 is not taken as an interrupt, expose them as GPO if
gpio-contoller is set in the devicetree. gpio-regmap is not used
because the GPO static low is 'b101 and static high is 0b110; low state
requires setting bit 0, not fitting the abstraction of low=0 and
high=mask.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/ad4062.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index e432aa60a224e..e52894ed757f7 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/devm-helpers.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
 #include <linux/iio/buffer.h>
@@ -87,8 +88,11 @@
 #define AD4060_MAX_AVG		0x7
 #define AD4062_MAX_AVG		0xB
 
+#define AD4062_GP_DISABLED	0x0
 #define AD4062_GP_INTR		0x1
 #define AD4062_GP_DRDY		0x2
+#define AD4062_GP_STATIC_LOW	0x5
+#define AD4062_GP_STATIC_HIGH	0x6
 
 #define AD4062_LIMIT_BITS	11
 
@@ -652,12 +656,14 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 	if (ret == -EPROBE_DEFER) {
 		return ret;
 	} else if (ret < 0) {
+		st->gpo_irq[0] = false;
 		ret = regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
 					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN,
 					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN);
 		if (ret)
 			return ret;
 	} else {
+		st->gpo_irq[0] = true;
 		ret = devm_request_threaded_irq(dev, ret, NULL,
 						ad4062_irq_handler_thresh,
 						IRQF_ONESHOT, indio_dev->name,
@@ -1268,6 +1274,121 @@ static int ad4062_regulators_get(struct ad4062_state *st, bool *ref_sel)
 	return 0;
 }
 
+static int ad4062_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int ad4062_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct ad4062_state *st = gpiochip_get_data(gc);
+	unsigned int reg_val = value ? AD4062_GP_STATIC_HIGH : AD4062_GP_STATIC_LOW;
+
+	if (offset)
+		return regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
+					  AD4062_REG_GP_CONF_MODE_MSK_1,
+					  FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1, reg_val));
+	else
+		return regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
+					  AD4062_REG_GP_CONF_MODE_MSK_0,
+					  FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_0, reg_val));
+}
+
+static int ad4062_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ad4062_state *st = gpiochip_get_data(gc);
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD4062_REG_GP_CONF, &reg_val);
+	if (ret)
+		return ret;
+
+	if (offset)
+		reg_val = FIELD_GET(AD4062_REG_GP_CONF_MODE_MSK_1, reg_val);
+	else
+		reg_val = FIELD_GET(AD4062_REG_GP_CONF_MODE_MSK_0, reg_val);
+
+	return reg_val == AD4062_GP_STATIC_HIGH;
+}
+
+static void ad4062_gpio_disable(void *data)
+{
+	struct ad4062_state *st = data;
+	u8 val = FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_0, AD4062_GP_DISABLED) |
+		 FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1, AD4062_GP_DISABLED);
+
+	regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
+			   AD4062_REG_GP_CONF_MODE_MSK_1 | AD4062_REG_GP_CONF_MODE_MSK_0,
+			   val);
+}
+
+static int ad4062_gpio_init_valid_mask(struct gpio_chip *gc,
+				       unsigned long *valid_mask,
+				       unsigned int ngpios)
+{
+	struct ad4062_state *st = gpiochip_get_data(gc);
+
+	bitmap_zero(valid_mask, ngpios);
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(st->gpo_irq); i++)
+		__assign_bit(i, valid_mask, !st->gpo_irq[i]);
+
+	return 0;
+}
+
+static int ad4062_gpio_init(struct ad4062_state *st)
+{
+	struct device *dev = &st->i3cdev->dev;
+	struct gpio_chip *gc;
+	u8 val, mask;
+	int ret;
+
+	if (!device_property_read_bool(dev, "gpio-controller"))
+		return 0;
+
+	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	val = 0;
+	mask = 0;
+	if (!st->gpo_irq[0]) {
+		mask |= AD4062_REG_GP_CONF_MODE_MSK_0;
+		val |= FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_0, AD4062_GP_STATIC_LOW);
+	}
+	if (!st->gpo_irq[1]) {
+		mask |= AD4062_REG_GP_CONF_MODE_MSK_1;
+		val |= FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1, AD4062_GP_STATIC_LOW);
+	}
+
+	ret = regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, ad4062_gpio_disable, st);
+	if (ret)
+		return ret;
+
+	gc->parent = dev;
+	gc->label = st->chip->name;
+	gc->owner = THIS_MODULE;
+	gc->base = -1;
+	gc->ngpio = 2;
+	gc->init_valid_mask = ad4062_gpio_init_valid_mask;
+	gc->get_direction = ad4062_gpio_get_direction;
+	gc->set = ad4062_gpio_set;
+	gc->get = ad4062_gpio_get;
+	gc->can_sleep = true;
+
+	ret = devm_gpiochip_add_data(dev, gc, st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to register GPIO chip\n");
+
+	return 0;
+}
+
 static const struct i3c_device_id ad4062_id_table[] = {
 	I3C_DEVICE(AD4062_I3C_VENDOR, ad4060_chip_info.prod_id, &ad4060_chip_info),
 	I3C_DEVICE(AD4062_I3C_VENDOR, ad4062_chip_info.prod_id, &ad4062_chip_info),
@@ -1356,6 +1477,10 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");
 
+	ret = ad4062_gpio_init(st);
+	if (ret)
+		return ret;
+
 	ret = devm_work_autocancel(dev, &st->trig_conv, ad4062_trigger_work);
 	if (ret)
 		return ret;

-- 
2.51.1


