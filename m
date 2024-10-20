Return-Path: <linux-iio+bounces-10834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B59A5730
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 00:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCEDB20EF8
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 22:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82672199FCD;
	Sun, 20 Oct 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="DGdEmU5T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J6+OP/Rt"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317E199E93;
	Sun, 20 Oct 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461694; cv=none; b=rJWr7HjgjQ/reqZcniVqJyurENHKRpsd2jKdSxJmRBdPBarMP9/cny/ZTQbhevgyEIOVScL77WT4HCTqRfwXuztjYn7FcrP+6lREvzgvBWehl3DinsndpLw6pmxFGfxH47NyITX6UKplTpu61mGjapva08fDFH8C//H7YjQEbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461694; c=relaxed/simple;
	bh=vF8PoZLcemoW7ocQiITA/5LyeyPnNKnsKzS6bvQdmFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6yDxtOp/rXV1GULMoC0eRdVOgEF9z5K/9puoNk8BpgW+qlrPnBlhA2XtOI8NvucbuEF+bdFA/QDKLlSdafdxQaRkUO1F45XGRrfl8IsaXGZg/cUsHp1lL8vWBPpjsyDAgy2EaiC5ixSzJRJwcwYibuFPBol1x520vqeJnYDhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=DGdEmU5T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J6+OP/Rt; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E4B3311400A8;
	Sun, 20 Oct 2024 18:01:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 20 Oct 2024 18:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729461690; x=
	1729548090; bh=p4bxuKiyW+ioXAqeVJXHXrTilmJtksg0SLU1JDE3quM=; b=D
	GdEmU5Tj0RjUAmXvcX3BVjQG58R53p3LDGkT/jD1XLehUSQo2d2W6jSbMRYJjhmN
	aPXIegFFyzpEG+QJQLJFK8Niw+LamE7XXR18K2RZVp+ZINURQZMwaScCQ9cnDUxN
	8YbZOE3Q/CZcXjaJifhxhZXCjZ30aH3jkXt22uE+vrh8puHHWaCggk/MLmP0DaW0
	gGV8/CGAKlDJJO0kDNaqf5PeZIWic4HWluxf08CKaifI0xNXeKFWzdkm8Y2bAXh/
	Wr96+Yafm3kbafK7EywXjsMmBz3y8QMuOTU7WQarvv3/FeqHIp/3mGM3H5c5qxup
	y8RV+geNmDBSO8oISYX4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729461690; x=
	1729548090; bh=p4bxuKiyW+ioXAqeVJXHXrTilmJtksg0SLU1JDE3quM=; b=J
	6+OP/RtPXYvhM3CZ1oUeOSXEptqoZpS9TznVbzwTti4lCfJYGVdz5pMf7cEgi6W8
	vODq2gYau+sg3msTgjh68OVOf9Zj/tz6Hp2SyXddnznPnewzMZGJU68HAcCdSQsx
	7Udq6zgyqzVR00qy7YaXJDDrEJht4ncjbvKD/tCcwBqGe+Fv1Cc2/ynp6SVwGPIy
	XOyY+5hBJq1fGf6+X86WSgcWAvvCvgK4pgYSnOSPm0GzDHc2NXi2J5VqS+DTcxB1
	IP+sktGh9IP+Kn61qqs/MTBHhBFoLuxKlhmGC0TpVk5uDq5cYFH3G4Srpyufcg9C
	7fwsTZJsBrhUO0A0jl23w==
X-ME-Sender: <xms:un0VZ41pqa8kyl6CNv2fZ__z_QB4FMTYqxtJ67yPXrMzYe1kCah0Bg>
    <xme:un0VZzG76NvBGqrvGzWKFbZg0NxCBw4z7w3tLTgZcHBgr_PsNXMggggSzl5c66iJp
    zK3YGBFsYY9S6sUvQ>
X-ME-Received: <xmr:un0VZw4S0sA2yQBuI7EeNSS7x6heTUVxHBJD_fnLwkEFM-tMokInSwCARspCG5yO9Y9A0H1GrQqkyuxuiCW5BHr0XwNXnp44ivlK-mQpFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedgtdeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:un0VZx2wdeMf9pmI83V4Lw7FO0An06tD4wMuTfgMDmNydTJjBXD4Ew>
    <xmx:un0VZ7HOVVKetEpl-V4qAGPXeZ1cwHZXPPVhBYjORmMXQj8DXqhg1Q>
    <xmx:un0VZ6-jTrBN0BMlRi4AiDGw3YVGFMHnv3BKXURjCPbjQt-0JHqxbw>
    <xmx:un0VZwl9fNJFenB59YNOIuGNLttZQlCyyHQ7G78271OMmBAMcaFjiQ>
    <xmx:un0VZ6fRVRnqtfPHs5dj1RAdGlnx7i6WpnepKeQhBlmwVaZJXWeM8hXN>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 18:01:29 -0400 (EDT)
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
Subject: [PATCH v3 6/6] iio: imu: bmi270: Add scale and sampling frequency to BMI270 IMU
Date: Sun, 20 Oct 2024 15:00:10 -0700
Message-ID: <20241020220011.212395-7-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241020220011.212395-1-justin@justinweiss.com>
References: <20241020220011.212395-1-justin@justinweiss.com>
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
 drivers/iio/imu/bmi270/bmi270_core.c | 340 +++++++++++++++++++++++++++
 1 file changed, 340 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 5b643afae9f7..3e1e698c4af0 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -7,6 +7,7 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
@@ -38,6 +39,9 @@
 #define BMI270_ACC_CONF_BWP_NORMAL_MODE			0x02
 #define BMI270_ACC_CONF_FILTER_PERF_MSK			BIT(7)
 
+#define BMI270_ACC_CONF_RANGE_REG			0x41
+#define BMI270_ACC_CONF_RANGE_MSK			GENMASK(1, 0)
+
 #define BMI270_GYR_CONF_REG				0x42
 #define BMI270_GYR_CONF_ODR_MSK				GENMASK(3, 0)
 #define BMI270_GYR_CONF_ODR_200HZ			0x09
@@ -46,6 +50,9 @@
 #define BMI270_GYR_CONF_NOISE_PERF_MSK			BIT(6)
 #define BMI270_GYR_CONF_FILTER_PERF_MSK			BIT(7)
 
+#define BMI270_GYR_CONF_RANGE_REG			0x43
+#define BMI270_GYR_CONF_RANGE_MSK			GENMASK(2, 0)
+
 #define BMI270_INIT_CTRL_REG				0x59
 #define BMI270_INIT_CTRL_LOAD_DONE_MSK			BIT(0)
 
@@ -99,6 +106,265 @@ const struct bmi270_chip_info bmi270_chip_info = {
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
@@ -161,6 +427,68 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
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
@@ -168,6 +496,8 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info bmi270_info = {
 	.read_raw = bmi270_read_raw,
+	.write_raw = bmi270_write_raw,
+	.read_avail = bmi270_read_avail,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -175,6 +505,11 @@ static const struct iio_info bmi270_info = {
 	.modified = 1,						\
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available =			\
+		BIT(IIO_CHAN_INFO_SCALE) |			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
 	.scan_index = BMI270_SCAN_ACCEL_##_axis,		\
 	.scan_type = {						\
 		.sign = 's',					\
@@ -189,6 +524,11 @@ static const struct iio_info bmi270_info = {
 	.modified = 1,						\
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available =			\
+		BIT(IIO_CHAN_INFO_SCALE) |			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
 	.scan_index = BMI270_SCAN_GYRO_##_axis,			\
 	.scan_type = {						\
 		.sign = 's',					\
-- 
2.47.0


