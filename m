Return-Path: <linux-iio+bounces-11404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF509B1F5D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 18:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411441C2098A
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291AF17BB32;
	Sun, 27 Oct 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="Qx+WRquR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqW2teji"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178F175D4F;
	Sun, 27 Oct 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730049711; cv=none; b=PuTDzUDZa9YI6mTxokN4XYAiVTgAxdEOh2+s9qq1wbp90gFOZ5k3dVKAZtsN1tWqZU+bEnUmbaxkE/vFplDWJD0otna0pgb3KWYkcQzPmLcxMrk+Rdc3StwxqcYPTB0hW2sLv/JNPecYchc551WHxjZgkZEPF2THhgv1QZVy5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730049711; c=relaxed/simple;
	bh=bp983poLAcKtxPrBrfKTRuNcMz1BqZz6VM2dc/JnW7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHqtiGEIz/sZiOnCPiOzZpnKHYwIS5P970JlOOJsFI1GkBwWsoI52O05c1Gic1Tph9b9EtURk58AizL6MY8S5nx0ivLd9ecOMDnX/Wa+d/ZOnD5BN5En6CeXlcoavyvVODa3ekDPSVQbZ0F7HjIbGqGMiJgXw7Uxnw6EDsN3pHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=Qx+WRquR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fqW2teji; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E1DAA11400CF;
	Sun, 27 Oct 2024 13:21:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 27 Oct 2024 13:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730049707; x=
	1730136107; bh=CH9W/hAloaYyEdc4LPF+ff9/zId9y0OyHWzDLblVZXQ=; b=Q
	x+WRquR8pNcb7qvdpRblrkxPWTyEisIm2yM4I2KWWXnWioddcyqx3gscCC5MXWLa
	MnL80lubQGuOme4jqVJN/5rcKRbHrXdngN2Bkm9hyGP9V+0j+N+4ASko5QcvgFcI
	mmwvUK/7OAE4hejhkcLq+EnTW+4Vn6mZ89xDolq5SsPQXxwa5Sey9l4Jv1ILOppB
	6amTnsvNBwCgkjOZv9TyA5Cyz4cNxU9gRnDRiMutkwKmWQH55TsI7SZsBycQ8vo2
	gLUdbNnxZ3XpFsJqb7MO7GdWint73tS8JvauUZuwBXAsbbCt6hbNrnJV+7mpuxl+
	423UJMzIOHLkAI7MoY14Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730049707; x=
	1730136107; bh=CH9W/hAloaYyEdc4LPF+ff9/zId9y0OyHWzDLblVZXQ=; b=f
	qW2teji5dcyfKKyXIl7Oi5TOeRwbNaP1n0y4qxYPBGop6rQGublM+8ShAmDnlRRG
	MMvZYYH4kV5YMRLTy4ovQ3vmIUwI9BloMf/0kOZuVOEH6kn1FD53CkL4/4FZov4z
	C/Ckkigh63yssau+Mc/aQu53VmTMOhGSR58JVJ5kvaJrPG5yzPjk6oOKsDoW2D+6
	iX8HtF5RR/l+HlkkwSxrI1vlxp/7jYcyhEHeJS25sxFHQwnhthaHkfh8q6gYJgro
	4Pbq+hDbpJfhROzBA2gk1nRMWMw3jRkiHOZsb/+pJRQnGU44PFhex0tgVdb0FLOp
	5NBKhTnz6HvKliLnc7o3A==
X-ME-Sender: <xms:q3YeZ8gmkznx9LE6WmYp6zn3lk2zzKowdXUirn_C24pdaLJ_IcRbOw>
    <xme:q3YeZ1BP1TBtrUbI5GpxlN9EdFnzjuR7IEq5yPR6XngLWhP36FZYJ7IK9WCech65S
    UA3UV5OQBe2YHKlSw>
X-ME-Received: <xmr:q3YeZ0H9NOX3m5Ib1B-85_LEKVXYEFuYWG_cdvBC2Y89Zd0mpEKZLCTp4Esgzl8ATAJ2DiCP9zmJq2wS0cc0D8CbvN33dViToVGYHu0U0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefluhhsthhinhcuhggvihhsshcuoehjuhhsthhinhesjhhushhtihhnfi
    gvihhsshdrtghomheqnecuggftrfgrthhtvghrnhepiefftddvgfdtvdeiteffudfhjedt
    feetleekgfetkeeggeffudeihfduieevjeeknecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgt
    ohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhgrnhiirghnohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhitgdv
    feeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrrhhssehmvghtrghfohhordguvg
    dprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihk
    odgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepjhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:q3YeZ9Sm5036ynzTZ1sN1prLshkCzi4U1LS9n3rOgcOcgmayPrq5NQ>
    <xmx:q3YeZ5xEOCv7bMprzv5Ojavp86h74AHmJue4x_wwq2rfz6xJl_HLJg>
    <xmx:q3YeZ776T_0fxTK4aUq5GQ81WyR_SxMLry4ibXebeziZ_YQkdEFluw>
    <xmx:q3YeZ2wIGhRnoRxzrtqNCHNtWA1Ax9S7R5qj4YflAYfxS0S2idteIw>
    <xmx:q3YeZ5gs5DOYgia9m8HoWxRaq1zVXPGfdyTEwq9LNZuH6cSCz8BA1kaB>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 13:21:45 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v4 2/4] iio: imu: bmi270: Add scale and sampling frequency to BMI270 IMU
Date: Sun, 27 Oct 2024 10:20:23 -0700
Message-ID: <20241027172029.160134-3-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241027172029.160134-1-justin@justinweiss.com>
References: <20241027172029.160134-1-justin@justinweiss.com>
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
index 1608cb2c8fb5..27e501a15095 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -7,6 +7,7 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
@@ -33,6 +34,9 @@
 #define BMI270_ACC_CONF_BWP_NORMAL_MODE			0x02
 #define BMI270_ACC_CONF_FILTER_PERF_MSK			BIT(7)
 
+#define BMI270_ACC_CONF_RANGE_REG			0x41
+#define BMI270_ACC_CONF_RANGE_MSK			GENMASK(1, 0)
+
 #define BMI270_GYR_CONF_REG				0x42
 #define BMI270_GYR_CONF_ODR_MSK				GENMASK(3, 0)
 #define BMI270_GYR_CONF_ODR_200HZ			0x09
@@ -41,6 +45,9 @@
 #define BMI270_GYR_CONF_NOISE_PERF_MSK			BIT(6)
 #define BMI270_GYR_CONF_FILTER_PERF_MSK			BIT(7)
 
+#define BMI270_GYR_CONF_RANGE_REG			0x43
+#define BMI270_GYR_CONF_RANGE_MSK			GENMASK(2, 0)
+
 #define BMI270_INIT_CTRL_REG				0x59
 #define BMI270_INIT_CTRL_LOAD_DONE_MSK			BIT(0)
 
@@ -86,6 +93,265 @@ const struct bmi270_chip_info bmi270_chip_info = {
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
@@ -148,6 +414,68 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
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
@@ -155,6 +483,8 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info bmi270_info = {
 	.read_raw = bmi270_read_raw,
+	.write_raw = bmi270_write_raw,
+	.read_avail = bmi270_read_avail,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -162,6 +492,11 @@ static const struct iio_info bmi270_info = {
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
@@ -176,6 +511,11 @@ static const struct iio_info bmi270_info = {
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


