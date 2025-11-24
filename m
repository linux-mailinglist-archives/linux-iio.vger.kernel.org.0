Return-Path: <linux-iio+bounces-26408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A53C7F940
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 438C04E526C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339A62F6922;
	Mon, 24 Nov 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="e9urTALP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ECB2F5463;
	Mon, 24 Nov 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975941; cv=none; b=ZekdLrnfI7A56ZDa+hAytGWXfy7iApsVoBTJGWrdD7mcv2Xnwq+sSZsI6uFU6Z6cCL65l/Ql4lD7He667RkXjX0wqz3anR2DxShXSxZf1QtExchQhjoQZ4dHCaWfXUwoFcXtriCquCDOSV1WhWhPM6uliXI3Xx/0+NMjI2Lwf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975941; c=relaxed/simple;
	bh=hu050DO+BNHVTgfy/Aqpo0tHFJg9UZpfOA98D/AmQW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KEG1eoyoBaqKQIezEolZuXrmwBVDH1FaqKjtUscQQ/xnEnqWXHHcJutQiOv1M0t7Ja7A3LFxrP2VIlAMkdG2THrRieq00I3aeXBERauOCzdory9KtLpH4GRgXYVz/FsiDz/kEiW9nt+UTBJI3rkkwWdKtHc/wquVOeYJ8jh/k10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=e9urTALP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO7s6bW3692007;
	Mon, 24 Nov 2025 04:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XgrMl
	VOA7gDVhm1Cvl4wAdO6PwLvaB9T0L/C018bk60=; b=e9urTALPUdARg/X2OWUfn
	DmfA3GV6IxWvfKPhKKD4kL/Il7QMeb2pEt3EWM2qK/EVp/foxv7WEwdc5VordLSg
	+AFhSIg5YbZBCeVVKU4/i/kiwKhFNhGinF5uLEEb9ZHEqqXaKpr+KS8Mg8af8HXO
	O4s1uI8GgFzXLrqxSGAdf//4bmtvq78xSctCAtOksNRfdAJ0aN7oeKJeb3YfqJ93
	Ub8/zb5lVTO54i1oMM+lvUxNPcnZ5Ai/wsEKui4csIv7LDHeBTSpUVNyQprU23Wm
	07cVKVEaDYCIhmuHJpHE6hH95JuoIbFIEcRIYeEmsarqEdoGKMpRiBM16gJzoO2v
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4akvcjmw8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 04:18:35 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AO9IYUk050927
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Nov 2025 04:18:34 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 24 Nov 2025 04:18:34 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 24 Nov 2025 04:18:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 24 Nov 2025 04:18:34 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.82])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AO9I8VO024016;
	Mon, 24 Nov 2025 04:18:29 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 24 Nov 2025 10:18:04 +0100
Subject: [PATCH v2 5/9] iio: adc: ad4062: Add IIO Trigger support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251124-staging-ad4062-v2-5-a375609afbb7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763975888; l=8868;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=hu050DO+BNHVTgfy/Aqpo0tHFJg9UZpfOA98D/AmQW0=;
 b=E7PLiApZLJ6J4QAv9LFUGmcceWQhO8XwZWbwNj/3HM3Ye4LNPuU/ojJ9pZGrqqJfhelouM3ZZ
 FQb4ViPbnEXBc2/FYDRnDj5UvRdcqkrNgKyK6uCErYbDB4nCqV16C5m
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4MSBTYWx0ZWRfX1CyA/2fDwAGD
 x9bbUt3gY42lxto4rME2ybqZXnXg3jpSKrp7ZOVw1RQP8RyoLDyV1n9IjOcCmtsDbmz4wdm9g39
 RPN8ZnxvCfvWFewHscRrmzW0cplNKOTIMwJwai5pAfpupiRIUqNAEb51fgqDkdlIdeZrXWv1Xc0
 mh8lRW9p5pZdXujFbjpOFNsvB3POYPCWdtb2K5NJHJcKJVJN4nA4TkzNvmbQ20kd4l06CJ5eFoa
 Cf+9ykKUIwJMxblJ0rbFx4HS0KeRDQK6ESgjwD46sCfGhWSzwbyc3eKcxx4A8Rxb03072871ayf
 EmLwi9nxlLfRplpZOG6UMXde9EMkuic0oTMnhjpyTPdhNqtGfcvIMwkzpY7Xm3YBmQNPh1B6FL9
 lKTOvpEJT0XPuc80yyggs5yv0bProg==
X-Authority-Analysis: v=2.4 cv=EqrfbCcA c=1 sm=1 tr=0 ts=692422eb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=zez8XUbOA3qj_dAOEuEA:9 a=QEXdDO2ut3YA:10
 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-ORIG-GUID: M7JYxr5dq5cjUhciy3nd7mO-RsNdoPMm
X-Proofpoint-GUID: M7JYxr5dq5cjUhciy3nd7mO-RsNdoPMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240081

Adds support for IIO Trigger. Optionally, gp1 is assigned as Data Ready
signal, if not present, fallback to an I3C IBI with the same role.
The software trigger is allocated by the device, but must be attached by
the user before enabling the buffer. The purpose is to not impede
removing the driver due to the increased reference count when
iio_trigger_set_immutable or iio_trigger_get is used.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4062.c | 164 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e506dbe83f488..ddb7820f0bdcc 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -74,6 +74,8 @@ config AD4062
 	tristate "Analog Devices AD4062 Driver"
 	depends on I3C
 	select REGMAP_I3C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4062 I3C analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index 6866393ffef8d..4e4be7358047f 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -12,8 +12,12 @@
 #include <linux/err.h>
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/math.h>
@@ -60,6 +64,7 @@
 #define     AD4062_REG_DEVICE_STATUS_DEVICE_RESET	BIT(6)
 #define AD4062_REG_IBI_STATUS				0x48
 #define AD4062_REG_CONV_READ_LSB			0x50
+#define AD4062_REG_CONV_READ				0x53
 #define AD4062_REG_CONV_TRIGGER				0x59
 #define AD4062_REG_CONV_AUTO				0x61
 #define AD4062_MAX_REG					AD4062_REG_CONV_AUTO
@@ -134,6 +139,7 @@ struct ad4062_state {
 	const struct ad4062_chip_info *chip;
 	const struct ad4062_bus_ops *ops;
 	enum ad4062_operation_mode mode;
+	struct work_struct trig_conv;
 	struct completion completion;
 	struct iio_trigger *trigger;
 	struct iio_dev *indio_dev;
@@ -143,6 +149,7 @@ struct ad4062_state {
 	int vref_uv;
 	int samp_freqs[ARRAY_SIZE(ad4062_conversion_freqs)];
 	u8 oversamp_ratio;
+	bool gpo_irq[2];
 	union {
 		__be32 be32;
 		__be16 be16;
@@ -396,7 +403,10 @@ static irqreturn_t ad4062_irq_handler_drdy(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct ad4062_state *st = iio_priv(indio_dev);
 
-	complete(&st->completion);
+	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
+		iio_trigger_poll(st->trigger);
+	else
+		complete(&st->completion);
 
 	return IRQ_HANDLED;
 }
@@ -406,7 +416,56 @@ static void ad4062_ibi_handler(struct i3c_device *i3cdev,
 {
 	struct ad4062_state *st = i3cdev_get_drvdata(i3cdev);
 
-	complete(&st->completion);
+	if (iio_buffer_enabled(st->indio_dev))
+		iio_trigger_poll_nested(st->trigger);
+	else
+		complete(&st->completion);
+}
+
+static void ad4062_trigger_work(struct work_struct *work)
+{
+	struct ad4062_state *st = container_of(work, struct ad4062_state,
+					       trig_conv);
+	int ret;
+
+	/* Read current conversion, if at reg CONV_READ, stop bit triggers
+	 * next sample and does not need writing the address.
+	 */
+	struct i3c_priv_xfer t[2] = {
+		{
+			.data.in = &st->buf.be32,
+			.len = sizeof(st->buf.be32),
+			.rnw = true,
+		},
+		{
+			.data.out = &st->reg_addr_conv,
+			.len = sizeof(st->reg_addr_conv),
+			.rnw = false,
+		},
+	};
+
+	ret = i3c_device_do_priv_xfers(st->i3cdev, &t[0], 1);
+	if (ret)
+		return;
+
+	iio_push_to_buffers_with_timestamp(st->indio_dev, &st->buf.be32,
+					   iio_get_time_ns(st->indio_dev));
+	if (st->gpo_irq[1])
+		return;
+
+	i3c_device_do_priv_xfers(st->i3cdev, &t[1], 1);
+}
+
+static irqreturn_t ad4062_poll_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4062_state *st = iio_priv(indio_dev);
+
+	iio_trigger_notify_done(indio_dev->trig);
+	schedule_work(&st->trig_conv);
+
+	return IRQ_HANDLED;
 }
 
 static void ad4062_remove_ibi(void *data)
@@ -451,10 +510,14 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 	if (ret == -EPROBE_DEFER) {
 		return ret;
 	} else if (ret < 0) {
+		st->gpo_irq[1] = false;
+		st->reg_addr_conv = AD4062_REG_CONV_TRIGGER;
 		ret = regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
 					 AD4062_REG_ADC_IBI_EN_CONV_TRIGGER,
 					 AD4062_REG_ADC_IBI_EN_CONV_TRIGGER);
 	} else {
+		st->gpo_irq[1] = true;
+		st->reg_addr_conv = AD4062_REG_CONV_READ;
 		ret = devm_request_threaded_irq(dev, ret,
 						ad4062_irq_handler_drdy,
 						NULL, IRQF_ONESHOT, indio_dev->name,
@@ -464,6 +527,34 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static const struct iio_trigger_ops ad4062_trigger_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
+};
+
+static int ad4062_request_trigger(struct iio_dev *indio_dev)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->i3cdev->dev;
+	int ret;
+
+	st->trigger = devm_iio_trigger_alloc(dev, "%s-dev%d",
+					     indio_dev->name,
+					     iio_device_id(indio_dev));
+	if (!st->trigger)
+		return -ENOMEM;
+
+	st->trigger->ops = &ad4062_trigger_ops;
+	iio_trigger_set_drvdata(st->trigger, indio_dev);
+
+	ret = devm_iio_trigger_register(dev, st->trigger);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trigger);
+
+	return 0;
+}
+
 static const int ad4062_oversampling_avail[] = {
 	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096,
 };
@@ -579,8 +670,8 @@ static int __ad4062_read_chan_raw(struct ad4062_state *st, int *val)
 	int ret;
 
 	reinit_completion(&st->completion);
-	/* Change address pointer to trigger conversion */
-	ret = i3c_device_do_priv_xfers(i3cdev, &t[0], 1);
+	/* Change address pointer (and read if CONV_READ) to trigger conversion. */
+	ret = i3c_device_do_priv_xfers(i3cdev, t, st->gpo_irq[1] ? 2 : 1);
 	if (ret)
 		return ret;
 	/*
@@ -689,6 +780,57 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
+	if (ret)
+		return ret;
+
+	ret = ad4062_set_operation_mode(st, st->mode);
+	if (ret)
+		goto out_mode_error;
+
+	/* CONV_READ requires read to trigger first sample. */
+	struct i3c_priv_xfer t[2] = {
+		{
+			.data.out = &st->reg_addr_conv,
+			.len = sizeof(st->reg_addr_conv),
+			.rnw = false,
+		},
+		{
+			.data.in = &st->buf.be32,
+			.len = sizeof(st->buf.be32),
+			.rnw = true,
+		}
+	};
+
+	ret = i3c_device_do_priv_xfers(st->i3cdev, t, st->gpo_irq[1] ? 2 : 1);
+	if (ret)
+		goto out_mode_error;
+	return 0;
+
+out_mode_error:
+	pm_runtime_put_autosuspend(&st->i3cdev->dev);
+
+	return ret;
+}
+
+static int ad4062_triggered_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+
+	pm_runtime_put_autosuspend(&st->i3cdev->dev);
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad4062_triggered_buffer_setup_ops = {
+	.postenable = &ad4062_triggered_buffer_postenable,
+	.predisable = &ad4062_triggered_buffer_predisable,
+};
+
 static int ad4062_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 				     unsigned int writeval, unsigned int *readval)
 {
@@ -801,7 +943,6 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 	st->sampling_frequency = 0;
 	st->oversamp_ratio = BIT(0);
 	st->indio_dev = indio_dev;
-	st->reg_addr_conv = AD4062_REG_CONV_TRIGGER;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = 1;
@@ -825,6 +966,17 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 	if (ret)
 		return ret;
 
+	ret = ad4062_request_trigger(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&i3cdev->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad4062_poll_handler,
+					      &ad4062_triggered_buffer_setup_ops);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
@@ -837,6 +989,8 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");
 
+	INIT_WORK(&st->trig_conv, ad4062_trigger_work);
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.51.1


