Return-Path: <linux-iio+bounces-26410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2E6C7F937
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C986E348FD3
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6842F8BD0;
	Mon, 24 Nov 2025 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xmUru0DI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824332F5A17;
	Mon, 24 Nov 2025 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975942; cv=none; b=k14Xci5wQbzS8TvUSH+ZveEYhrX4aAAzvqlmzJci2byGjYyPQT1sYzGnpbc0Set9qtO6iPIdeqhznorcN2qsWGqijc7nlehpvqb2+nzVu3b5jyNLJ58dkbj00wGz+n+/ARnIpjIiQdoZTGLYKjNJynaZ/YMCdukqf+PoyCnmgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975942; c=relaxed/simple;
	bh=K+zt3nceOOODApou1DvNcVnqg8L6U+BAmtwiQUTSD/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X8LGjFKPWeXkji7lRYMD4RDblXH73RfYyHmE68rSkYoVZnrwNAFvq08jSm7SOLlFpY4b/nrc6N5wbGXtyjyVKsQwTidZwrrUVymOnVAZlANk8NIxySHgLbBcQDrcFX8Aq0xs0VSUMlze9zBeTKlyjWB0cuYdXOLVavHjjEYJ4Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xmUru0DI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO9FOq0420237;
	Mon, 24 Nov 2025 04:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CFxea
	+0RlEzrXndzpVbk0p5/3GjSlvBMRFAAzli0hlw=; b=xmUru0DI8Es/vIqElXdD8
	b6vajFlAD5HEAXo8ofI/reNuod3RMJKUF/rOqV2P/XvEXD8VuCDXcimTPsXWrtRQ
	ZWoZcVB7sh38JKoNo5xidIQyv8q9bNqYnzZOSrmQFREoNNvL0jGg4ywYzvs05rO5
	jE8GjRcic/OUjzfNGVfwxiHyxB0lQfOiuVBOsY4Jt8eww9ilCgouk/XsOil1N2GX
	KkllLB72pbkGqwjqOHDPg1sH0a9NYs+FmcVSqcZ2CS7p+3flntKN+w0f6eVtWqe3
	3nV9t2F58u34L3UHlegiiHb/k2Po9hWyrWXED4SfXuzeRxIflLjWLOaWl1RWFP73
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aky424gt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 04:18:45 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AO9IikJ007671
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Nov 2025 04:18:44 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 24 Nov 2025 04:18:44 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 24 Nov 2025 04:18:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 24 Nov 2025 04:18:43 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.82])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AO9I8VS024016;
	Mon, 24 Nov 2025 04:18:37 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 24 Nov 2025 10:18:08 +0100
Subject: [PATCH v2 9/9] iio: adc: ad4062: Add GPIO Controller support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251124-staging-ad4062-v2-9-a375609afbb7@analog.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
In-Reply-To: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763975888; l=5730;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=K+zt3nceOOODApou1DvNcVnqg8L6U+BAmtwiQUTSD/g=;
 b=1VAot/oOiNyakNSh6gDyBPRNszQvAcZm8xQNisXkdA/bzEsIP70eTI0VY9+l3Kb9oasJEsf9O
 CueObBm8ZDNBgVKmgjWk9wntp7ztaAUEPhpWEIeTCBsejt4IE8rxTcR
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ffGgCkQF c=1 sm=1 tr=0 ts=692422f5 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=tsAnktj4w5_xAW6w_LAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qnndZnCmPiIo8KBvd6zxKRxwrLjot_Oa
X-Proofpoint-ORIG-GUID: qnndZnCmPiIo8KBvd6zxKRxwrLjot_Oa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4MSBTYWx0ZWRfXzm1H17O3z1ka
 58Sk6AOif0vFEOksLwDwuI+DxVIxm7//yL+swNiROzxCdBTePaStLBpoVxx6ldZFdgGS6Lw1NW7
 fdwDOc5kVxPEpnF9Vm4CfGyq3TJ28ibutbmB6GeBvol46JNhyb4KIgE/ICTipduEL4dKJ9a4GbL
 KxRRYgCxgl2i8Nng1BJGN20EDPBdlQo/rDcJwOpEjsU8/erMTNQsLLPidK3ZEZHzTFDNb7iV11v
 G7AQzmRQ+r5BJkQ/5LyBzRChHK6lfVW6rx/vvnuBi2b35ke8t/JY95bnb0DY/fp6evucUcFEkK1
 s/6kjx1ZlAQJjGTAF0Y4JgiQ4jOUD74Pb7/QyiZuwd0QytTT2gqCgecR7mvkhIWcMcDS5CCqs0A
 Px0Kz/jNJMMSiFs63DwwofN0yHYm7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240081

When gp0 or gp1 is not taken as an interrupt, expose them as gpo if
gpio-contoller is set in the devicetree.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/ad4062.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index 3df7dbf29ae4a..203b06276431f 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -10,6 +10,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
 #include <linux/iio/buffer.h>
@@ -85,8 +86,11 @@
 #define AD4062_MAX_AVG		0xB
 #define AD4062_MON_VAL_MAX_GAIN		1999970
 #define AD4062_MON_VAL_MIDDLE_POINT	0x8000
+#define AD4062_GP_DISABLED	0x0
 #define AD4062_GP_INTR		0x1
 #define AD4062_GP_DRDY		0x2
+#define AD4062_GP_STATIC_LOW	0x5
+#define AD4062_GP_STATIC_HIGH	0x6
 #define AD4062_INTR_EN_NEITHER	0x0
 #define AD4062_INTR_EN_EITHER	0x3
 #define AD4062_TCONV_NS		270
@@ -635,12 +639,14 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
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
@@ -1263,6 +1269,130 @@ static int ad4062_regulators_get(struct ad4062_state *st, bool *ref_sel)
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
+	if (st->gpo_irq[offset])
+		return -ENODEV;
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
+		return 0;
+
+	if (st->gpo_irq[offset])
+		return -ENODEV;
+
+	if (offset)
+		reg_val = FIELD_GET(AD4062_REG_GP_CONF_MODE_MSK_1, reg_val);
+	else
+		reg_val = FIELD_GET(AD4062_REG_GP_CONF_MODE_MSK_0, reg_val);
+
+	return reg_val == AD4062_GP_STATIC_HIGH ? 1 : 0;
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
+	if (!st->gpo_irq[0])
+		set_bit(0, valid_mask);
+	if (!st->gpo_irq[1])
+		set_bit(1, valid_mask);
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
+	if ((st->gpo_irq[0] && st->gpo_irq[1]) ||
+	    !device_property_read_bool(dev, "gpio-controller"))
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
@@ -1351,6 +1481,10 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");
 
+	ret = ad4062_gpio_init(st);
+	if (ret)
+		return ret;
+
 	INIT_WORK(&st->trig_conv, ad4062_trigger_work);
 
 	return devm_iio_device_register(dev, indio_dev);

-- 
2.51.1


