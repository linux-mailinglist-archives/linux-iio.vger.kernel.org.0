Return-Path: <linux-iio+bounces-10756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 320889A4A32
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 01:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E014B23DE5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 23:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A725192D86;
	Fri, 18 Oct 2024 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="aGnroQid";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z9prkcC5"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC118FC75;
	Fri, 18 Oct 2024 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294723; cv=none; b=VxxCu4a7atngLpjBxl7n7ghstoBuBFQC0TH3mdqyyYi8CvXMpwokpXH6agP20l0Y1LuT5LhwdaqZeSFTCWYHvH0NI91BbRoHYVfz9nahEcbZScja8h8CC9qnD+VvVjt30z1LteUxG4fmK91M5+U9Gs5Ur3CDEtyV5wcgyYDrxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294723; c=relaxed/simple;
	bh=H3o6ust5TtWf1YCVzQJ2oGdTQvq7q/eoAIiPmlCTtH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJzi8/hXGD0xR5SjlJ3HzIvV+GsrefjPsmqm58WuVHieXBfYjLN6TvH14w1LXKwB7Y8VbDf2eViOwdZ+JTq+oLWnwTjvyYahvtHeEoIXmdFVz7t+tQM+C8qm0TcigbXBN5okSaLFyM70mAtCsmH4CPOol8mB9zQqQXtJbpi6r0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=aGnroQid; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z9prkcC5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8626911401AA;
	Fri, 18 Oct 2024 19:38:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 18 Oct 2024 19:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729294720; x=
	1729381120; bh=kddeGIUsRBS+Tfy6+HMUhxC0WI/aqwj15PsI6K+5vZw=; b=a
	GnroQidNwmtlS8kQPWkj+y1Egu3mjbd2D11c2cjfELzbZ4F7SZhfs5hG9x6C4jUp
	0Z08cw+SyGBd2eRTxhLL09MRbtAfcMmGB8gdKf/GdLXZkbyGWUTe9XQT3i+KVUwa
	qiC9js8dJOSUnMrWc+wpRc3IAbCjb6Ohl9w7EeszVr4mZR+0UdfaZuKsAKvea0In
	oBADi3uUmbRoQhmdLz8wUaM75v66A4BgJO+ZyKzza5tteNmSy4gP7QtSau3xAgDC
	Mdg4CwKpNxYi2tAO90hcAAweNyCN0jeGLSkbBBclk25jQ9pG6Z/uKb4vHN3hMex7
	oNMNJzz89OG3AmF+ge27g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729294720; x=
	1729381120; bh=kddeGIUsRBS+Tfy6+HMUhxC0WI/aqwj15PsI6K+5vZw=; b=Z
	9prkcC5UmqbY1LQk1OVISIqOljLjWSpnxd1gNoe79skoGsoU8pQO9re/fHtt5jz1
	jcG4sW3ztocmWjvLlm0dPBwOJjPTToliy5yTQxkixeggR68Y6BbAVzL/aX/GSchv
	eG77F3C4rKsmJ5CQcrz82Gx1vAsAmTVTiz8i+c9Tca+Wz0W+P2JV86dKK4Px6KmR
	zSwOYpiXCPFzzl1Gf8629Q05HWIfQatFuGWT3fpHuU44tTj5kY4TNXvSWARZ/iep
	7Drz5cF2bgNy+me15oWl47CmzIGkpP/qrb3sWfu/yaxO2Aa4qfucXionjYh1t+cB
	paXU4s3I5/SMt2NglWfow==
X-ME-Sender: <xms:gPESZztawNsNmIWjaWtxAFzLzaCvrI9U2MJTd_XmpZ4LqAmaqyUv9w>
    <xme:gPESZ0eJUQIIuv6VEen8V9zfrC79YuHe1bvKd843DfeXLu8STg1VGjlfg1VR5b60P
    KdtH7i_SvoeWvshoQ>
X-ME-Received: <xmr:gPESZ2yV4VRprzfv12-QeR8H_-9UbDatYlzkpKxUmcPRJMpffldwDgeqyS18UJetrqbNrs8QVNe3hOr9LSPeM4BnuJrXe7DMVOF0vdVtBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiffdtvdfgtddvieetffduhfejtdef
    teelkefgteekgeegffduiefhudeiveejkeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hlrghniigrnhhordgrlhgvgiesghhmrghilhdrtghomhdprhgtphhtthhopehjihgtvdef
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghrshesmhgvthgrfhhoohdruggvpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdo
    ughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gPESZyMTv3w0kFAZg9NaaR4Bm7xMTp3lc51dih-u6Kfyxh7rIHfXvA>
    <xmx:gPESZz9cFAM-XLnCOtYeY5eO80VM8JZklVFhCV10rt4rSQk9KM7D6Q>
    <xmx:gPESZyV9hsdYZdnrfEVWuFZeV5mTbu5e44xhnmXX_K2XzsVb4d17ZA>
    <xmx:gPESZ0cYbK8k6ogJg1nzqekDG8aw1-kNffQelw1tcnFgFhBCTEALEg>
    <xmx:gPESZ2W4eqmaWdkdERYZFtHFWPi7Jyi6padZ4DbL-JAo3MnIO3aQOFNj>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 19:38:38 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v2 6/6] iio: imu: bmi270: Add scale and sampling frequency to BMI270 IMU
Date: Fri, 18 Oct 2024 16:36:12 -0700
Message-ID: <20241018233723.28757-7-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018233723.28757-1-justin@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read and write functions and create _available entries.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 338 +++++++++++++++++++++++++++
 1 file changed, 338 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 69b011f97324..bc3604e66f85 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -7,6 +7,7 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
@@ -35,6 +36,9 @@
 #define BMI270_ACC_CONF_BWP_NORMAL_MODE			0x02
 #define BMI270_ACC_CONF_FILTER_PERF_MSK			BIT(7)
 
+#define BMI270_ACC_CONF_RANGE_REG			0x41
+#define BMI270_ACC_CONF_RANGE_MSK			GENMASK(1, 0)
+
 #define BMI270_GYR_CONF_REG				0x42
 #define BMI270_GYR_CONF_ODR_MSK				GENMASK(3, 0)
 #define BMI270_GYR_CONF_ODR_200HZ			0x09
@@ -43,6 +47,9 @@
 #define BMI270_GYR_CONF_NOISE_PERF_MSK			BIT(6)
 #define BMI270_GYR_CONF_FILTER_PERF_MSK			BIT(7)
 
+#define BMI270_GYR_CONF_RANGE_REG			0x43
+#define BMI270_GYR_CONF_RANGE_MSK			GENMASK(2, 0)
+
 #define BMI270_INIT_CTRL_REG				0x59
 #define BMI270_INIT_CTRL_LOAD_DONE_MSK			BIT(0)
 
@@ -96,6 +103,265 @@ const struct bmi270_chip_info bmi270_chip_info[] = {
 };
 EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
 
+enum bmi270_sensor_type {
+	BMI270_ACCEL	= 0,
+	BMI270_GYRO,
+};
+
+struct bmi270_scale {
+	int scale;
+	int uscale;
+};
+
+struct bmi270_odr {
+	int odr;
+	int uodr;
+};
+
+static const struct bmi270_scale bmi270_accel_scale[] = {
+	{ 0, 598 },
+	{ 0, 1197 },
+	{ 0, 2394 },
+	{ 0, 4788 },
+};
+
+static const struct bmi270_scale bmi270_gyro_scale[] = {
+	{ 0, 1065 },
+	{ 0, 532 },
+	{ 0, 266 },
+	{ 0, 133 },
+	{ 0, 66 },
+};
+
+struct bmi270_scale_item {
+	const struct bmi270_scale *tbl;
+	int num;
+};
+
+static const struct bmi270_scale_item bmi270_scale_table[] = {
+	[BMI270_ACCEL] = {
+		.tbl	= bmi270_accel_scale,
+		.num	= ARRAY_SIZE(bmi270_accel_scale),
+	},
+	[BMI270_GYRO] = {
+		.tbl	= bmi270_gyro_scale,
+		.num	= ARRAY_SIZE(bmi270_gyro_scale),
+	},
+};
+
+static const struct bmi270_odr bmi270_accel_odr[] = {
+	{ 0, 781250 },
+	{ 1, 562500 },
+	{ 3, 125000 },
+	{ 6, 250000 },
+	{ 12, 500000 },
+	{ 25, 0 },
+	{ 50, 0 },
+	{ 100, 0 },
+	{ 200, 0 },
+	{ 400, 0 },
+	{ 800, 0 },
+	{ 1600, 0 },
+};
+
+static const u8 bmi270_accel_odr_vals[] = {
+	0x01,
+	0x02,
+	0x03,
+	0x04,
+	0x05,
+	0x06,
+	0x07,
+	0x08,
+	0x09,
+	0x0A,
+	0x0B,
+	0x0C,
+};
+
+static const struct bmi270_odr bmi270_gyro_odr[] = {
+	{ 25, 0 },
+	{ 50, 0 },
+	{ 100, 0 },
+	{ 200, 0 },
+	{ 400, 0 },
+	{ 800, 0 },
+	{ 1600, 0 },
+	{ 3200, 0 },
+};
+
+static const u8 bmi270_gyro_odr_vals[] = {
+	0x06,
+	0x07,
+	0x08,
+	0x09,
+	0x0A,
+	0x0B,
+	0x0C,
+	0x0D,
+};
+
+struct bmi270_odr_item {
+	const struct bmi270_odr *tbl;
+	const u8 *vals;
+	int num;
+};
+
+static const struct  bmi270_odr_item bmi270_odr_table[] = {
+	[BMI270_ACCEL] = {
+		.tbl	= bmi270_accel_odr,
+		.vals   = bmi270_accel_odr_vals,
+		.num	= ARRAY_SIZE(bmi270_accel_odr),
+	},
+	[BMI270_GYRO] = {
+		.tbl	= bmi270_gyro_odr,
+		.vals   = bmi270_gyro_odr_vals,
+		.num	= ARRAY_SIZE(bmi270_gyro_odr),
+	},
+};
+
+static int bmi270_set_scale(struct bmi270_data *data,
+			    int chan_type, int uscale)
+{
+	int i;
+	int reg, mask;
+	struct bmi270_scale_item bmi270_scale_item;
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		reg = BMI270_ACC_CONF_RANGE_REG;
+		mask = BMI270_ACC_CONF_RANGE_MSK;
+		bmi270_scale_item = bmi270_scale_table[BMI270_ACCEL];
+		break;
+	case IIO_ANGL_VEL:
+		reg = BMI270_GYR_CONF_RANGE_REG;
+		mask = BMI270_GYR_CONF_RANGE_MSK;
+		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < bmi270_scale_item.num; i++) {
+		if (bmi270_scale_item.tbl[i].uscale != uscale)
+			continue;
+
+		return regmap_update_bits(data->regmap, reg, mask, i);
+	}
+
+	return -EINVAL;
+}
+
+static int bmi270_get_scale(struct bmi270_data *bmi270_device,
+			    int chan_type, int *uscale)
+{
+	int ret;
+	unsigned int val;
+	struct bmi270_scale_item bmi270_scale_item;
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		ret = regmap_read(bmi270_device->regmap,
+				  BMI270_ACC_CONF_RANGE_REG, &val);
+		if (ret)
+			return ret;
+
+		val = FIELD_GET(BMI270_ACC_CONF_RANGE_MSK, val);
+		bmi270_scale_item = bmi270_scale_table[BMI270_ACCEL];
+		break;
+	case IIO_ANGL_VEL:
+		ret = regmap_read(bmi270_device->regmap,
+				  BMI270_GYR_CONF_RANGE_REG, &val);
+		if (ret)
+			return ret;
+
+		val = FIELD_GET(BMI270_GYR_CONF_RANGE_MSK, val);
+		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (val >= bmi270_scale_item.num)
+		return -EINVAL;
+
+	*uscale = bmi270_scale_item.tbl[val].uscale;
+	return 0;
+}
+
+static int bmi270_set_odr(struct bmi270_data *data, int chan_type,
+			  int odr, int uodr)
+{
+	int i;
+	int reg, mask;
+	struct bmi270_odr_item bmi270_odr_item;
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		reg = BMI270_ACC_CONF_REG;
+		mask = BMI270_ACC_CONF_ODR_MSK;
+		bmi270_odr_item = bmi270_odr_table[BMI270_ACCEL];
+		break;
+	case IIO_ANGL_VEL:
+		reg = BMI270_GYR_CONF_REG;
+		mask = BMI270_GYR_CONF_ODR_MSK;
+		bmi270_odr_item = bmi270_odr_table[BMI270_GYRO];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < bmi270_odr_item.num; i++) {
+		if (bmi270_odr_item.tbl[i].odr != odr ||
+		    bmi270_odr_item.tbl[i].uodr != uodr)
+			continue;
+
+		return regmap_update_bits(data->regmap, reg, mask,
+					  bmi270_odr_item.vals[i]);
+	}
+
+	return -EINVAL;
+}
+
+static int bmi270_get_odr(struct bmi270_data *data, int chan_type,
+			  int *odr, int *uodr)
+{
+	int i, val, ret;
+	struct bmi270_odr_item bmi270_odr_item;
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		ret = regmap_read(data->regmap, BMI270_ACC_CONF_REG, &val);
+		if (ret)
+			return ret;
+
+		val = FIELD_GET(BMI270_ACC_CONF_ODR_MSK, val);
+		bmi270_odr_item = bmi270_odr_table[BMI270_ACCEL];
+		break;
+	case IIO_ANGL_VEL:
+		ret = regmap_read(data->regmap, BMI270_GYR_CONF_REG, &val);
+		if (ret)
+			return ret;
+
+		val = FIELD_GET(BMI270_GYR_CONF_ODR_MSK, val);
+		bmi270_odr_item = bmi270_odr_table[BMI270_GYRO];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < bmi270_odr_item.num; i++) {
+		if (val != bmi270_odr_item.vals[i])
+			continue;
+
+		*odr = bmi270_odr_item.tbl[i].odr;
+		*uodr = bmi270_odr_item.tbl[i].uodr;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -158,6 +424,70 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		ret = bmi270_get_scale(bmi270_device, chan->type, val2);
+		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = bmi270_get_odr(bmi270_device, chan->type, val, val2);
+		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi270_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct bmi270_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return bmi270_set_scale(data, chan->type, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return bmi270_set_odr(data, chan->type, val, val2);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bmi270_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			*vals = (const int *)bmi270_gyro_scale;
+			*length = ARRAY_SIZE(bmi270_gyro_scale) * 2;
+			return IIO_AVAIL_LIST;
+		case IIO_ACCEL:
+			*vals = (const int *)bmi270_accel_scale;
+			*length = ARRAY_SIZE(bmi270_accel_scale) * 2;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			*vals = (const int *)bmi270_gyro_odr;
+			*length = ARRAY_SIZE(bmi270_gyro_odr) * 2;
+			return IIO_AVAIL_LIST;
+		case IIO_ACCEL:
+			*vals = (const int *)bmi270_accel_odr;
+			*length = ARRAY_SIZE(bmi270_accel_odr) * 2;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -165,6 +495,8 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info bmi270_info = {
 	.read_raw = bmi270_read_raw,
+	.write_raw = bmi270_write_raw,
+	.read_avail = bmi270_read_avail,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -174,6 +506,9 @@ static const struct iio_info bmi270_info = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available =			\
+		BIT(IIO_CHAN_INFO_SCALE) |			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
 	.scan_index = BMI270_SCAN_ACCEL_##_axis,		\
 	.scan_type = {						\
 		.sign = 's',					\
@@ -190,6 +525,9 @@ static const struct iio_info bmi270_info = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available =			\
+		BIT(IIO_CHAN_INFO_SCALE) |			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
 	.scan_index = BMI270_SCAN_GYRO_##_axis,			\
 	.scan_type = {						\
 		.sign = 's',					\
-- 
2.47.0


