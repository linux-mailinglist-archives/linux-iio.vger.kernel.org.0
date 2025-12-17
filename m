Return-Path: <linux-iio+bounces-27144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FE3CC7926
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088B0311D05B
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4AB345CC5;
	Wed, 17 Dec 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sgeD5y49"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7593446C0;
	Wed, 17 Dec 2025 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973666; cv=none; b=FjnFOLA++RpjMDDOPcmht0Yyx3mLhgI5C7COG9Rl0PJlRhhKBxeBYDO7wUjiqWX5y5I6jItc75coo4bl+xBkdib0Uh5K0xT1EHK/1ZmgzDKfn6z7I+/afLmLLK2cdLzUkCKbCLlGzv+557641iVe2BHHtDhp7LPBGjMRITERrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973666; c=relaxed/simple;
	bh=rWhz1qhXX5cZm+GWRaQ9ciBLBk8IoCqoYZlI/GtAfiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lljBBkP4ko5LLJL/1Q+9XdeixaOgSh4vBSG4LQWsrrHVGazAhFDBILgB16X9HhwGJeVHcqcsdujaK8wtpDmu7uEDAjyFXxvcBO/04co3pnDQ0ZtJzlYMq+yGAaoEp7e/SFAez0WLzWGvBKzAeUmGe1XUtKjnwRxw2m4xlytmN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sgeD5y49; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHC7Tx23978997;
	Wed, 17 Dec 2025 07:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KHwHt
	qQuusmzdK7NM7ocl1bh8RRVDH4lMJb8lzPokRI=; b=sgeD5y490ivnBlHVayFX6
	NxU5z7mRE39VNGYf1AVEE2q2y7ZHQTQrBy+usEJTmkyy+iLiM12J4NKNU/0a0dbk
	OlLUDHDMnKkjg1gUYNWGLcFzXbWyurXUHNNZrNutRnJPiH7JxWIwYb176seDP2x6
	w4DOPBhVWHwUWfVEfMIHeZgR/CInXW9vUatvb4u8XSJePFY2TGEiyrvJltGr5MXI
	GAEcmi2hkuy3R/AR9l86+lZN02pLwtj7ZONlANTGATNNN7wCK/YF+dHduQWnozKq
	WQX9d2FLLgxS2p7yK5KORlQoKcXs0lLvSyPZlN6f/U8pBGaYVrft2iEAuBuDAWES
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b3bbevk6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:14:07 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCE6FF041126
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:14:06 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 17 Dec
 2025 07:14:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:14:06 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCDUvF014815;
	Wed, 17 Dec 2025 07:13:57 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 17 Dec 2025 13:13:32 +0100
Subject: [PATCH v4 9/9] iio: adc: ad4062: Add GPIO Controller support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-staging-ad4062-v4-9-7890a2951a8f@analog.com>
References: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
In-Reply-To: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
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
        <linux-gpio@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>,
        Linus
 Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765973610; l=5630;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=rWhz1qhXX5cZm+GWRaQ9ciBLBk8IoCqoYZlI/GtAfiU=;
 b=h16QtNehE13q2APVGRNCeEMKpMfldJrbGJvTDRVuABLEbYt7oxYkLRAKNQmg8+ALzaizen8Ym
 oTUbxYvehAQAfOzzKGbEuTXlBrnsFx/opjcwaZoxHAsuIZrsrWNLFup
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ckUSgF4LPP59bHdYNifnVx-5YPN-zhUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NSBTYWx0ZWRfX6dHUfdknNgPL
 9FVSstJkgNDxfckZxjcWQB2/JmskCToaAi252B97jS86QmiMPPZOOZUUO7pLeJnELJTFScuMOBQ
 gt5ZGmYRyIUsq/hlrSzIXyWwCko4hl9gxChnxYKNeCm2EC/t5P6ApxQbtkMP9ZF1wzdrR7Vz9Rg
 OmSiLmbGzLujoio7rGtGkzsqQ7AZKD9Ts5RlRDcjgeGHFSo1bTjMMdQ/YVIQsZWjmoLJbnDmemq
 iDcNQgvbw/IlYgB9Xj9xzhVqOKee2zw9fbptimU5YqNWcbQ+ZGmAMDV/Fsgzv3ktlpmhhkjMyO7
 0y6T4xArldYx3tBAetS4ADcVeZ/4/mp3i1/S9kd0I2+HEBoWE68w6C6PJ2mSeSm4VS2nee2dY5q
 ASsFPXI1zFvjycYpCs5DSh0VzMHs2A==
X-Authority-Analysis: v=2.4 cv=YqsChoYX c=1 sm=1 tr=0 ts=69429e8f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=xMyuZJbwAj7bCYiyej4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ckUSgF4LPP59bHdYNifnVx-5YPN-zhUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170095

When gp0 or gp1 is not taken as an interrupt, expose them as GPO if
gpio-contoller is set in the devicetree. gpio-regmap is not used
because the GPO static low is 'b101 and static high is 0b110; low state
requires setting bit 0, not fitting the abstraction of low=0 and
high=mask.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/iio/adc/ad4062.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index 2084f0058627d..a6b3ccc98acfc 100644
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
@@ -88,8 +89,11 @@
 #define AD4060_PROD_ID		0x7A
 #define AD4062_PROD_ID		0x7C
 
+#define AD4062_GP_DISABLED	0x0
 #define AD4062_GP_INTR		0x1
 #define AD4062_GP_DRDY		0x2
+#define AD4062_GP_STATIC_LOW	0x5
+#define AD4062_GP_STATIC_HIGH	0x6
 
 #define AD4062_LIMIT_BITS	12
 
@@ -687,12 +691,14 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 		return ret;
 
 	if (ret < 0) {
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
@@ -1347,6 +1353,121 @@ static int ad4062_regulators_get(struct ad4062_state *st, bool *ref_sel)
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
 	I3C_DEVICE(AD4062_I3C_VENDOR, AD4060_PROD_ID, &ad4060_chip_info),
 	I3C_DEVICE(AD4062_I3C_VENDOR, AD4062_PROD_ID, &ad4062_chip_info),
@@ -1435,6 +1556,10 @@ static int ad4062_probe(struct i3c_device *i3cdev)
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


