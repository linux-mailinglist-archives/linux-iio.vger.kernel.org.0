Return-Path: <linux-iio+bounces-15258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B6A2EA6F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC28F7A5DE2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC71E9B15;
	Mon, 10 Feb 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chhO50G6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AA1E7C16;
	Mon, 10 Feb 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185309; cv=none; b=K0dIj+PLbiKBQfBQqZLFGWI9Q6qbbFWUvs+LCKj258rfD6pNCTLYVznnhkBcLOwzi0P5dBW0yKRVVoeOHwasfyBIw4CXFSBgZWlpzC3uHhWvHvn52N+7nPI2Yg3Hge1LO3wvBlZLvf2kwmei58uvulwwBqKJEVHyO4/L6WBthwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185309; c=relaxed/simple;
	bh=WJ1K0MV0GPmwUg78Q9UmVFYh1d4x/rscQtOAchEHEJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YoE/o4f0YhgfzIAXKZFYF93l9O6Ki7AL5WT/bXQaITe7yIYebWzPfPJSlog1yDiFj7Qh0IQF0VaQyCQTJUWjJkZdly4D42szGnGxJ+2xnazcjiNav4ViZOTHU6MNFV3sA1ZlFdPGpYiQvlixpi7uslh70SgmiEULuUUgXKJuBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chhO50G6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7bc75e0a1so25213666b.3;
        Mon, 10 Feb 2025 03:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185306; x=1739790106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypa1a9Q0yAlaKugbBVm1+t+T3QsoJKO1Wzke7d/Id+0=;
        b=chhO50G6deLpLp/M05qe25ht30dxWxmT5v9P6EuAy0qqDpe5p6GroY3nFb0oZmg5IW
         rQaRn252C1pTgKhckadfODohprLIeDG7Gn7lFNaga8C3xGPEwf0xbyb9i7ICypPbC+NN
         hN+BIXRJLYD3WIB3Vpk+6um+3xCFrc7fFKw3Is/bLwzP3RkmufCLFXjL6ItF1+bWjDsI
         by1gWq+x9Fnwcy/+7KL1vpcS2WaFH7uVP9rM7fjoIC9yWtO9sFkUWHRylLRquvS5QXHl
         w45pLQLaHcuD2BsgFUVd3YWaydK+qARf2v0amP2Yd7PVbpXzSB4bQ7tIeq1f/EQdCDvh
         6uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185306; x=1739790106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypa1a9Q0yAlaKugbBVm1+t+T3QsoJKO1Wzke7d/Id+0=;
        b=XdQuJWWcTDjiRvvKdzwY7T0h3olTLkyYCh/Y902Cz2DybhIy/cYzHeStxxbGDpsa+X
         suX/bVHCJ5gfH9n4/niW0bWs/4ihBn+DN4BuJOhcC4raTDriBcQ8DR9uPHJZcyYhgKRJ
         wfnLgfMd4HsgD45FoE5xhPbO0OBQM9uMRbD8r8jDcBhn8xZ0YcNcoNTTU+y/6ELnj4SX
         yav7wvtbY2QdPKNY+V64gnywsu4TxQ9/8NKRd0MxuiCyPFmmfngqWpZXbCn/visUqG1c
         zBlHFjvVZtv3+Q4UHcowWhjfQPPudeKyPvWy134LsaSlnQocb2C8eAWYYBDPTAcf5k+L
         33uw==
X-Forwarded-Encrypted: i=1; AJvYcCW3NDKryCXvUGSo3GeOMn3o5JqbZYZh+xz3bSvEBGeUuEkCFTBTqBGZ/0OjDcxRv01kdlnpCUKa4PaPI04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UuP1/b6iKsc4PO171TaaaTfUcDQ7glhFKpkREDizIHlcDycY
	PKuV9nXXgBkZMphLGYYPLmGT1F+yxlEcPSHzZ8mhnK45jv4Rkqme
X-Gm-Gg: ASbGnctnAxhnGvfOZB5CVwWX9AWFjkyZk63jau+VdCr10zWy5i2cdh7l8qxH5hCFwCW
	X2TwgpK7Jm+iVJOgRpDTDSCD2NG3aKnWOROegVVJEPkreWW7G7qKVMRBzMm5cB5nA04rp5xOhUr
	v6Cnv0HoWoMMp/QLk3ZD4EjCjHQabpSDdkFRd28s1po2dDc7TkOpvB93efZlkpA+yEMT4ZvbkcX
	SpUIR6XWuDeHoj6krBt0UbH6gCClsKCdl3+2mLEr0aBXI4eikjOK4rSrUCiY1dL1r553/1FKnmj
	L++HUt7T5aBcLTv893QDq9Kd/uUzucvMD3Ik2qheeJwXgXqWMf1/P75g5o3JDW7/Whiiwg==
X-Google-Smtp-Source: AGHT+IETrOKcrKDHXefOo3dCvYE1hBgPLbS/J/hYUFWr7dcXR4kyOaMjrCekt8w17T3wG0s+8HA0Xg==
X-Received: by 2002:a17:907:7f08:b0:aae:e684:cc75 with SMTP id a640c23a62f3a-ab789c35369mr511033066b.13.1739185305417;
        Mon, 10 Feb 2025 03:01:45 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:45 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 11/14] iio: accel: adxl345: add activity event feature
Date: Mon, 10 Feb 2025 11:01:16 +0000
Message-Id: <20250210110119.260858-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210110119.260858-1-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the sensor detect and issue interrupts at activity. Activity
events are configured by a threshold.

Activity, together with ODR and range setting are preparing a setup
together with inactivity coming in a follow up patch.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 172 ++++++++++++++++++++++++++++++-
 1 file changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ea7bfe193d31..16dea2a222d9 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -35,6 +35,7 @@
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
+#define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
 
 enum adxl345_axis {
 	ADXL345_Z_EN = BIT(0),
@@ -67,6 +68,23 @@ static const unsigned int adxl345_tap_time_reg[3] = {
 	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
 };
 
+/* activity/inactivity */
+enum adxl345_activity_type {
+	ADXL345_ACTIVITY,
+};
+
+static const unsigned int adxl345_act_int_reg[2] = {
+	[ADXL345_ACTIVITY] = ADXL345_INT_ACTIVITY,
+};
+
+static const unsigned int adxl345_act_thresh_reg[2] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_THRESH_ACT,
+};
+
+static const unsigned int adxl345_act_axis_msk[2] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_AXIS_MSK,
+};
+
 enum adxl345_odr {
 	ADXL345_ODR_0P10HZ = 0,
 	ADXL345_ODR_0P20HZ,
@@ -153,6 +171,9 @@ struct adxl345_state {
 	enum adxl345_odr odr;
 	enum adxl345_range range;
 
+	u32 act_axis_ctrl;
+	u8 act_threshold;
+
 	u32 tap_axis_ctrl;
 	u8 tap_threshold;
 	u32 tap_duration_us;
@@ -167,6 +188,13 @@ struct adxl345_state {
 };
 
 static struct iio_event_spec adxl345_events[] = {
+	{
+		/* activity */
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE),
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -250,6 +278,84 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
 }
 
+/* act/inact */
+
+static int adxl345_write_act_axis(struct adxl345_state *st,
+				  enum adxl345_activity_type type, bool en)
+{
+	int ret;
+
+	/*
+	 * The ADXL345 allows for individually enabling/disabling axis for
+	 * activity and inactivity detection, respectively. Here both axis are
+	 * kept in sync, i.e. an axis will be generally enabled or disabled for
+	 * both equally, activity and inactivity detection.
+	 */
+	if (type == ADXL345_ACTIVITY) {
+		st->act_axis_ctrl = en
+			? st->act_axis_ctrl | ADXL345_REG_ACT_AXIS_MSK
+			: st->act_axis_ctrl & ~ADXL345_REG_ACT_AXIS_MSK;
+
+		ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+					 adxl345_act_axis_msk[type],
+					 st->act_axis_ctrl);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int adxl345_is_act_inact_en(struct adxl345_state *st,
+				   enum adxl345_activity_type type, bool *en)
+{
+	int ret;
+	unsigned int regval;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	*en = (adxl345_act_int_reg[type] & regval) > 0;
+
+	return 0;
+}
+
+static int adxl345_set_act_inact_en(struct adxl345_state *st,
+				    enum adxl345_activity_type type, bool cmd_en)
+{
+	bool axis_en, en = false;
+	int ret;
+
+	ret = adxl345_write_act_axis(st, type, cmd_en);
+	if (ret)
+		return ret;
+
+	if (type == ADXL345_ACTIVITY) {
+		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
+		en = axis_en && st->act_threshold > 0;
+	}
+
+	en ? __set_bit(ilog2(adxl345_act_int_reg[type]), (unsigned long *)&st->int_map)
+		: __clear_bit(ilog2(adxl345_act_int_reg[type]), (unsigned long *)&st->int_map);
+
+	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
+}
+
+static int adxl345_set_act_inact_threshold(struct adxl345_state *st,
+					   enum adxl345_activity_type type, u8 val)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, adxl345_act_thresh_reg[type], val);
+	if (ret)
+		return ret;
+
+	if (type == ADXL345_ACTIVITY)
+		st->act_threshold = val;
+
+	return 0;
+}
+
 /* tap */
 
 static int adxl345_write_tap_axis(struct adxl345_state *st,
@@ -697,6 +803,16 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	int ret = -EFAULT;
 
 	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (chan->channel2) {
 		case IIO_MOD_X:
@@ -746,6 +862,13 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	enum adxl345_axis axis;
 
 	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl345_set_act_inact_en(st, ADXL345_ACTIVITY, state);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (chan->channel2) {
 		case IIO_MOD_X:
@@ -783,6 +906,19 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev, const struct iio_
 	struct adxl345_state *st = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				*val = st->act_threshold;
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -839,6 +975,21 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 		return ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = adxl345_set_act_inact_threshold(st, ADXL345_ACTIVITY, val);
+				break;
+			default:
+				ret = -EINVAL;
+			}
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1129,12 +1280,14 @@ static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat,
 {
 	unsigned int regval;
 	bool check_tap_stat;
+	bool check_act_stat;
 	int ret;
 
 	*act_tap_dir = IIO_NO_MOD;
 	check_tap_stat = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
+	check_act_stat = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
 
-	if (check_tap_stat) {
+	if (check_tap_stat || check_act_stat) {
 		/* ACT_TAP_STATUS should be read before clearing the interrupt */
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
@@ -1201,6 +1354,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_ACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							act_tap_dir,
+							IIO_EV_TYPE_THRESH,
+							IIO_EV_DIR_RISING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
 		ret = iio_push_event(indio_dev,
 				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
@@ -1311,6 +1475,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 	st->fifo_delay = fifo_delay_default;
 
+	/*
+	 * If the feature is enabled, scan all axis for activity and or
+	 * inactivity, and set activity and inactivity to the same ac / dc
+	 * setup.
+	 */
+	st->act_axis_ctrl = ADXL345_REG_ACT_AXIS_MSK;
 	st->int_map = 0x00;			/* reset interrupts */
 
 	/* Init with reasonable values */
-- 
2.39.5


