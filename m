Return-Path: <linux-iio+bounces-10464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D706499A7FD
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 17:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045C51C236EA
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EEB199941;
	Fri, 11 Oct 2024 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="jqELNGf0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgXqxvAo"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38249198E8C;
	Fri, 11 Oct 2024 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661105; cv=none; b=QQtY0RP9jZR8g1E7vGGU9JtT7djlPqpEzM+V3uyzPb0wRsg05O+UYWmRD/dWHx/z/1yIJl1VA/0/+eQ9TIDcU/ZBmmoTL5TOaNeB9sOtddY1eugM2lts1bzK4NdUTT+fBdSYmEyqRaFA919cmexaC8CwpTwwtNffPQ76S63zGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661105; c=relaxed/simple;
	bh=/gIHlnCs+B6mRPHx5vHgZ2v5blQcCUsf23vSNA4/6hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIsQzDt52PtXEs5ibGVw3kyiT4NZS310Nt/3XFchPi6tQH334AuO2IJGx6VL8wyFLico4KIKeTHXacQlyIJ4A3GfFAgA66KBWwyhHpefJ6YQ/CcFPG0s/qpwEvH8dURFiAInY6YVv8qXgQWNX7EjzfOEjSI0P4BX8+Dtz21D4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=jqELNGf0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fgXqxvAo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F3C81140227;
	Fri, 11 Oct 2024 11:38:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 11 Oct 2024 11:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728661102; x=
	1728747502; bh=H5NaoeN4GP3Lew/+d70cuR23NQP3Zyua7iTIzyO//hk=; b=j
	qELNGf03uBzaAiwdbbDRO38MDTS1fgoYaODLaVKUm+merUyIoy4Vt8wDjQN+9MsB
	GjthXSKc9Ljfq411u+iIhQNlGai68IJARmKxhbeb4Od1Fc9GHXlgONc7nBvsGBTI
	x9UGX1JLlNI0RbGgnYG4hcK8p7E7eTJKzknsJTeYkKLgB+a3IaERxhoHm1AIj4Z+
	y1kpjz1rP8HqPtFlDLlLzQn4mMYZ3X9sLltZwhmUDvkuHuesGbpWbpJmCJ+7v5yy
	Ey1D2h9nkVszOuiSyt3r4/HcKFwfIYDlXGDnh7NiWDyQJGb7pppoJ9nwOEhFff9l
	m+SFe51AAYL8jtgiOq5fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728661102; x=
	1728747502; bh=H5NaoeN4GP3Lew/+d70cuR23NQP3Zyua7iTIzyO//hk=; b=f
	gXqxvAoVeE75mW/BDvncmFi8lGz8rkBk/0YHujGzuvHtKbtOmfqv8SCJh6R3xWdv
	roO/2jE2Y8+77/mK2Iqs9B7TMJFZmH/phtiCpGOTXsZeJsNGdufgndM8jVqzWpqb
	bXmSv3w5E288NRco2JwVfquWb9dkFyC1edid3xFpYrBXZXvDMtzDoCkhmoEaURWu
	Q46j6pUKVCELyDpFddnFVWqPBBXPmto2sNdNeCJzOIg5jM9NeXdJPEk/M7BK5AVs
	aQ/EN62ZvDN1jixsR8yd+hE/VVBq/eYz1whUXp9Mz/PewmqPcKJe6dZwFzM+nUB3
	fG77YWZVAyiwX2W2d6+JQ==
X-ME-Sender: <xms:bkYJZ-_mk0oB0VxsLixBN7mSXSWH-DExyzRn3kzPzxXe6eKAADkXVw>
    <xme:bkYJZ-spvhDwbmi25s9t8WQBZo_V0QKy96Cp2jtGV4yPFN-c1cv3-__ovbi8hUsU3
    sx2lDyr95gNWOAZlA>
X-ME-Received: <xmr:bkYJZ0BTpWDoTwiX-hp9I7rs2n5YoQ4VTrQMNZHGCao5HGt5DvY65EfV22_wcytYpp0bna0AxX8wNM7egYv9plszl1CjjAWMPmYrGPxmKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiffdtvdfgtddvieetffduhfejtdef
    teelkefgteekgeegffduiefhudeiveejkeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
    grnhiirghnohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhitgdvfees
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrrhhssehmvghtrghfohhordguvgdprh
    gtphhtthhopehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhiihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    uggvrhgvkhhjohhhnhdrtghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopehphh
    hilhhmsehmrghnjhgrrhhordhorhhg
X-ME-Proxy: <xmx:bkYJZ2deEzPcs0KuW4mu_vh3wTUe8W2gjshbKq82IGVTlOOtqPgfYQ>
    <xmx:bkYJZzOAR7sMHL_fhDcCi7hSHEadB0ZWc021_N0PQUSae9dZZM9VBw>
    <xmx:bkYJZwkEiuR8qiq-uMMbvmIyftr6JRgbrfRYkCC0k1ps3w8tbEZ-GA>
    <xmx:bkYJZ1tfTUcOjrjM0O4A2ApeGAg85bUWEkRcpiMck6I-oVGhkqWHYQ>
    <xmx:bkYJZ8iLT8V3KionDrbeDl85CJTFDnVpM0TmipeqAmzYPMCGQfTftzKg>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 11:38:20 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH 3/3] iio: imu: Add scale and sampling frequency to BMI270 IMU
Date: Fri, 11 Oct 2024 08:37:49 -0700
Message-ID: <20241011153751.65152-4-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011153751.65152-1-justin@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read and write functions and create _available entries. Use
IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY to match
the BMI160 / BMI323 drivers.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 293 ++++++++++++++++++++++++++-
 1 file changed, 291 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index f49db5d1bffd..ce7873dc3211 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -7,6 +7,7 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
@@ -34,6 +35,9 @@
 #define BMI270_ACC_CONF_BWP_NORMAL_MODE			0x02
 #define BMI270_ACC_CONF_FILTER_PERF_MSK			BIT(7)
 
+#define BMI270_ACC_CONF_RANGE_REG			0x41
+#define BMI270_ACC_CONF_RANGE_MSK			GENMASK(1, 0)
+
 #define BMI270_GYR_CONF_REG				0x42
 #define BMI270_GYR_CONF_ODR_MSK				GENMASK(3, 0)
 #define BMI270_GYR_CONF_ODR_200HZ			0x09
@@ -42,6 +46,9 @@
 #define BMI270_GYR_CONF_NOISE_PERF_MSK			BIT(6)
 #define BMI270_GYR_CONF_FILTER_PERF_MSK			BIT(7)
 
+#define BMI270_GYR_CONF_RANGE_REG			0x43
+#define BMI270_GYR_CONF_RANGE_MSK			GENMASK(2, 0)
+
 #define BMI270_INIT_CTRL_REG				0x59
 #define BMI270_INIT_CTRL_LOAD_DONE_MSK			BIT(0)
 
@@ -85,6 +92,236 @@ const struct bmi270_chip_info bmi270_chip_info[] = {
 };
 EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
 
+enum bmi270_sensor_type {
+	BMI270_ACCEL	= 0,
+	BMI270_GYRO,
+};
+
+struct bmi270_scale {
+	u8 bits;
+	int uscale;
+};
+
+struct bmi270_odr {
+	u8 bits;
+	int odr;
+	int uodr;
+};
+
+static const struct bmi270_scale bmi270_accel_scale[] = {
+	{ 0x00, 598},
+	{ 0x01, 1197},
+	{ 0x02, 2394},
+	{ 0x03, 4788},
+};
+
+static const struct bmi270_scale bmi270_gyro_scale[] = {
+	{ 0x00, 1065},
+	{ 0x01, 532},
+	{ 0x02, 266},
+	{ 0x03, 133},
+	{ 0x04, 66},
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
+	{0x01, 0, 781250},
+	{0x02, 1, 562500},
+	{0x03, 3, 125000},
+	{0x04, 6, 250000},
+	{0x05, 12, 500000},
+	{0x06, 25, 0},
+	{0x07, 50, 0},
+	{0x08, 100, 0},
+	{0x09, 200, 0},
+	{0x0A, 400, 0},
+	{0x0B, 800, 0},
+	{0x0C, 1600, 0},
+};
+
+static const struct bmi270_odr bmi270_gyro_odr[] = {
+	{0x06, 25, 0},
+	{0x07, 50, 0},
+	{0x08, 100, 0},
+	{0x09, 200, 0},
+	{0x0A, 400, 0},
+	{0x0B, 800, 0},
+	{0x0C, 1600, 0},
+	{0x0D, 3200, 0},
+};
+
+struct bmi270_odr_item {
+	const struct bmi270_odr *tbl;
+	int num;
+};
+
+static const struct  bmi270_odr_item bmi270_odr_table[] = {
+	[BMI270_ACCEL] = {
+		.tbl	= bmi270_accel_odr,
+		.num	= ARRAY_SIZE(bmi270_accel_odr),
+	},
+	[BMI270_GYRO] = {
+		.tbl	= bmi270_gyro_odr,
+		.num	= ARRAY_SIZE(bmi270_gyro_odr),
+	},
+};
+
+static int bmi270_set_scale(struct bmi270_data *data,
+			    int chan_type, int uscale)
+{
+	int i;
+	int reg;
+	struct bmi270_scale_item bmi270_scale_item;
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		reg = BMI270_ACC_CONF_RANGE_REG;
+		bmi270_scale_item = bmi270_scale_table[BMI270_ACCEL];
+		break;
+	case IIO_ANGL_VEL:
+		reg = BMI270_GYR_CONF_RANGE_REG;
+		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < bmi270_scale_item.num; i++)
+		if (bmi270_scale_item.tbl[i].uscale == uscale)
+			break;
+
+	if (i == bmi270_scale_item.num)
+		return -EINVAL;
+
+	return regmap_write(data->regmap, reg,
+			    bmi270_scale_item.tbl[i].bits);
+}
+
+static int bmi270_get_scale(struct bmi270_data *bmi270_device,
+			    int chan_type, int *uscale)
+{
+	int i, ret, val;
+	int reg;
+	struct bmi270_scale_item bmi270_scale_item;
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		reg = BMI270_ACC_CONF_RANGE_REG;
+		bmi270_scale_item = bmi270_scale_table[BMI270_ACCEL];
+		break;
+	case IIO_ANGL_VEL:
+		reg = BMI270_GYR_CONF_RANGE_REG;
+		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(bmi270_device->regmap, reg, &val);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < bmi270_scale_item.num; i++)
+		if (bmi270_scale_item.tbl[i].bits == val) {
+			*uscale = bmi270_scale_item.tbl[i].uscale;
+			return 0;
+		}
+
+	return -EINVAL;
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
+	for (i = 0; i < bmi270_odr_item.num; i++)
+		if (bmi270_odr_item.tbl[i].odr == odr &&
+		    bmi270_odr_item.tbl[i].uodr == uodr)
+			break;
+
+	if (i >= bmi270_odr_item.num)
+		return -EINVAL;
+
+	return regmap_update_bits(data->regmap,
+				  reg,
+				  mask,
+				  bmi270_odr_item.tbl[i].bits);
+}
+
+static int bmi270_get_odr(struct bmi270_data *data, int chan_type,
+			  int *odr, int *uodr)
+{
+	int i, val, ret;
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
+	ret = regmap_read(data->regmap, reg, &val);
+	if (ret)
+		return ret;
+
+	val &= mask;
+
+	for (i = 0; i < bmi270_odr_item.num; i++)
+		if (val == bmi270_odr_item.tbl[i].bits)
+			break;
+
+	if (i >= bmi270_odr_item.num)
+		return -EINVAL;
+
+	*odr = bmi270_odr_item.tbl[i].odr;
+	*uodr = bmi270_odr_item.tbl[i].uodr;
+
+	return 0;
+}
+
 static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -149,13 +386,65 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		ret = bmi270_get_scale(bmi270_device, chan->type, val2);
+		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = bmi270_get_odr(bmi270_device, chan->type, val, val2);
+		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
 }
 
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
+static
+IIO_CONST_ATTR(in_accel_sampling_frequency_available,
+	       "0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600");
+static
+IIO_CONST_ATTR(in_anglvel_sampling_frequency_available,
+	       "25 50 100 200 400 800 1600 3200");
+static
+IIO_CONST_ATTR(in_accel_scale_available,
+	       "0.000598 0.001197 0.002394 0.004788");
+static
+IIO_CONST_ATTR(in_anglvel_scale_available,
+	       "0.001065 0.000532 0.000266 0.000133 0.000066");
+
+static struct attribute *bmi270_attrs[] = {
+	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
+	&iio_const_attr_in_anglvel_sampling_frequency_available.dev_attr.attr,
+	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
+	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group bmi270_attrs_group = {
+	.attrs = bmi270_attrs,
+};
+
 static const struct iio_info bmi270_info = {
 	.read_raw = bmi270_read_raw,
+	.write_raw = bmi270_write_raw,
+	.attrs = &bmi270_attrs_group,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -164,7 +453,7 @@ static const struct iio_info bmi270_info = {
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-		BIT(IIO_CHAN_INFO_FREQUENCY),			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
 	.scan_index = BMI270_SCAN_ACCEL_##_axis,		\
 	.scan_type = {						\
 		.sign = 's',					\
@@ -180,7 +469,7 @@ static const struct iio_info bmi270_info = {
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-		BIT(IIO_CHAN_INFO_FREQUENCY),			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
 	.scan_index = BMI270_SCAN_GYRO_##_axis,		\
 	.scan_type = {						\
 		.sign = 's',					\
-- 
2.47.0


