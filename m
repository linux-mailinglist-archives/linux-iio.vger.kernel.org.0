Return-Path: <linux-iio+bounces-26803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F6CA821B
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 16:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C000230AF31D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D634FF6B;
	Fri,  5 Dec 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oWn8BoDg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEAD330D38;
	Fri,  5 Dec 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947592; cv=none; b=PE4BmNQs5+slcnEOj3bvdHnrdjPJZggdmgaCJZWj6DhbiwZ96aZ5mg/c6Ezpix+VIdkj2Wt2Xf62yx2gUx2g7a3z0VQ8l8Xv+UiZC/ZqWfqO3xzlYFpYE8NtNubY91qr+E6iHTQX6nHmkRisgIYBhKI516a5WsY32dkYqN4LqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947592; c=relaxed/simple;
	bh=3IoM3fz+WhDxsNlKH0eut9ZoIkeYuELbSxXkOMrXy/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=An5RfoO7yppmQfs6TSfjWp9qdLqQJuOlS5MDpE50IupOwARkjdGpu5PRuC/GjqRToySzmSL3n1kyOQIxcyCiQZYRySNrI+Rq3+Mo9Sm2A55P/OaYEx9fbsX7xjQi1HBPA84npGI3SCDrxNTYQbO0gUqwIiUFAFHya7lvL42MMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oWn8BoDg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5Bat6N625981;
	Fri, 5 Dec 2025 10:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KC/aT
	FOen+C+yZ6zZQnC+my/vcZ51qoNW/ctEb/Ghew=; b=oWn8BoDgmFx4hEGMKgZEm
	1G4+i50AJoUeYRlB0sv4VKfWfv8tbwx4I/setQey41/AcorNrv5nLWgbAoS3nioP
	I7gVA0OhRJbSGkEHQzqtccSVyh2cHJhoQhxgagf8LaH0xZKZ5kB+2cOmFCjJqdfr
	8ASt969uJGg5Zvro4Wni2H9UVKdNzMvvr+FSulRHvNfvQQliJ47fpk3izOzxpVc/
	xV6lmDwWHtmubakNQ5nF51581IJVP1pZec1xm4TKvjzBAGBcmz1HE83/rzr2xXVa
	ri3z/2dbVSa51bJYmIBlfDWSy6ReJGZjBqoyeg7IKslrvOWTmXua51agLTbxaJU9
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4auhwwm5w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:12:40 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5FCdvO033554
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 10:12:39 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 5 Dec
 2025 10:12:39 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 10:12:39 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5FC8SF029946;
	Fri, 5 Dec 2025 10:12:32 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Fri, 5 Dec 2025 16:12:06 +0100
Subject: [PATCH v3 5/9] iio: adc: ad4062: Add IIO Trigger support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-staging-ad4062-v3-5-8761355f9c66@analog.com>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
In-Reply-To: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
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
        <linux-gpio@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764947528; l=10010;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=3IoM3fz+WhDxsNlKH0eut9ZoIkeYuELbSxXkOMrXy/8=;
 b=akVKc2Ce1kgFrnw331HAW5oRUoO4UG/DCCgzvjHeSQSyfVeiVu2CszLTJqIGjtU5q5PNmTcZ6
 /u3RIzFXqRYA3J6ib52CWeozKZ8yZ0H23BidK4IIBJEvEIlA7KkfTkA
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Y531cxeN c=1 sm=1 tr=0 ts=6932f669 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=h4R8G6l5vMoJgOk8f3AA:9 a=QEXdDO2ut3YA:10
 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-GUID: Ik25tz9uTYRuRoHUHRiT_2lewss49ipF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDExMCBTYWx0ZWRfX28QqUJYct+Mc
 bV1GUqiXEUcTN7KgHHhR92n2ZyZd0vSpLlgGsRAn4mY3WdQFoBh5tibkzLaW4+9SUVIBOI3t8Tu
 1zbUVkeC6NUBFwNwgLFfp+K6BbIZYMSbsPlonKC9KsJEyfWB6sr8SENZ4fRedC8I1MQ91OfTGIm
 k7xHuNlD9QF0P4ZCtwXLdV6U8qUHccZdvo9kyRVUFWOM5T5cL8CmzPMk0dH1r0EIWsNooRp9KyZ
 Qwho4oND978PNfkeX85aMGu4JkLmYUdUESZPeF8I5Nf8xGA4nb57rwMwnEUtVQgmIax3DCB/KXc
 2eqBLLqkBTqmWF03rY/AF6OxYhiHj5kkSFOY+X642NcSFQbGc3hMeiROUcuYJyjFOZi4nPd8VCd
 xm4ICcaTlq9Co5oSgknxNFENZftVVw==
X-Proofpoint-ORIG-GUID: Ik25tz9uTYRuRoHUHRiT_2lewss49ipF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050110

Adds support for IIO Trigger. Optionally, gp1 is assigned as Data Ready
signal, if not present, fallback to an I3C IBI with the same role.
The software trigger is allocated by the device, but must be attached by
the user before enabling the buffer. The purpose is to not impede
removing the driver due to the increased reference count when
iio_trigger_set_immutable() or iio_trigger_get() is used.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4062.c | 188 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 175 insertions(+), 15 deletions(-)

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
index 54f7f69e40879..080dc80fd1621 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -9,11 +9,16 @@
 #include <linux/bitops.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
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
@@ -60,6 +65,7 @@
 #define     AD4062_REG_DEVICE_STATUS_DEVICE_RESET	BIT(6)
 #define AD4062_REG_IBI_STATUS				0x48
 #define AD4062_REG_CONV_READ_LSB			0x50
+#define AD4062_REG_CONV_READ				0x53
 #define AD4062_REG_CONV_TRIGGER				0x59
 #define AD4062_REG_CONV_AUTO				0x61
 #define AD4062_MAX_REG					AD4062_REG_CONV_AUTO
@@ -137,6 +143,7 @@ struct ad4062_state {
 	const struct ad4062_chip_info *chip;
 	const struct ad4062_bus_ops *ops;
 	enum ad4062_operation_mode mode;
+	struct work_struct trig_conv;
 	struct completion completion;
 	struct iio_trigger *trigger;
 	struct iio_dev *indio_dev;
@@ -144,6 +151,7 @@ struct ad4062_state {
 	struct regmap *regmap;
 	int vref_uV;
 	unsigned int samp_freqs[ARRAY_SIZE(ad4062_conversion_freqs)];
+	bool gpo_irq[2];
 	union {
 		__be32 be32;
 		__be16 be16;
@@ -411,7 +419,10 @@ static irqreturn_t ad4062_irq_handler_drdy(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct ad4062_state *st = iio_priv(indio_dev);
 
-	complete(&st->completion);
+	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
+		iio_trigger_poll(st->trigger);
+	else
+		complete(&st->completion);
 
 	return IRQ_HANDLED;
 }
@@ -421,7 +432,57 @@ static void ad4062_ibi_handler(struct i3c_device *i3cdev,
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
+	struct ad4062_state *st =
+		container_of(work, struct ad4062_state, trig_conv);
+	int ret;
+
+	/*
+	 * Read current conversion, if at reg CONV_READ, stop bit triggers
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
@@ -466,16 +527,48 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 	if (ret == -EPROBE_DEFER) {
 		return ret;
 	} else if (ret < 0) {
+		st->gpo_irq[1] = false;
+		st->reg_addr_conv = AD4062_REG_CONV_TRIGGER;
 		return regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
 					  AD4062_REG_ADC_IBI_EN_CONV_TRIGGER,
 					  AD4062_REG_ADC_IBI_EN_CONV_TRIGGER);
 	}
+	st->gpo_irq[1] = true;
+	st->reg_addr_conv = AD4062_REG_CONV_READ;
 	return devm_request_threaded_irq(dev, ret,
 					 ad4062_irq_handler_drdy,
 					 NULL, IRQF_ONESHOT, indio_dev->name,
 					 indio_dev);
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
 	1, 2, 4, 8, 16, 32, 64, 128,		/*  0 -  7 */
 	256, 512, 1024, 2048, 4096,		/*  8 - 12 */
@@ -572,15 +665,17 @@ static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
 {
 	int ret;
 	struct i3c_device *i3cdev = st->i3cdev;
-	struct i3c_priv_xfer t0 = {
-		.data.out = &st->reg_addr_conv,
-		.len = sizeof(st->reg_addr_conv),
-		.rnw = false,
-	};
-	struct i3c_priv_xfer t1 = {
-		.data.in = &st->buf.be32,
-		.len = sizeof(st->buf.be32),
-		.rnw = true,
+	struct i3c_priv_xfer t[] = {
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
 	};
 
 	ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
@@ -593,8 +688,8 @@ static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
 		return ret;
 
 	reinit_completion(&st->completion);
-	/* Change address pointer to trigger conversion */
-	ret = i3c_device_do_priv_xfers(i3cdev, &t0, 1);
+	/* Change address pointer (and read if CONV_READ) to trigger conversion. */
+	ret = i3c_device_do_priv_xfers(i3cdev, t, st->gpo_irq[1] ? 2 : 1);
 	if (ret)
 		return ret;
 	/*
@@ -606,7 +701,7 @@ static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
 	if (!ret)
 		return -ETIMEDOUT;
 
-	ret = i3c_device_do_priv_xfers(i3cdev, &t1, 1);
+	ret = i3c_device_do_priv_xfers(i3cdev, &t[1], 1);
 	if (ret)
 		return ret;
 	*val = get_unaligned_be32(st->buf.bytes);
@@ -687,6 +782,55 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
+	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
+	if (ret)
+		return ret;
+
+	ret = ad4062_set_operation_mode(st, st->mode);
+	if (ret)
+		return ret;
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
+		return ret;
+
+	pm_runtime_get_noresume(&st->i3cdev->dev);
+	return 0;
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
@@ -798,7 +942,6 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 	st->sampling_frequency = 0;
 	st->oversamp_ratio = 0;
 	st->indio_dev = indio_dev;
-	st->reg_addr_conv = AD4062_REG_CONV_TRIGGER;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = 1;
@@ -822,6 +965,17 @@ static int ad4062_probe(struct i3c_device *i3cdev)
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
@@ -834,6 +988,10 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");
 
+	ret = devm_work_autocancel(dev, &st->trig_conv, ad4062_trigger_work);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.51.1


