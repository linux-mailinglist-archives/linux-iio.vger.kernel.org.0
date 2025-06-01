Return-Path: <linux-iio+bounces-20107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE53AC9F9E
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570121891376
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07512212D8A;
	Sun,  1 Jun 2025 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWq2AAT3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FCA20CCE5;
	Sun,  1 Jun 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798526; cv=none; b=j4xjl9nf4hbnF/kFp3RssMZfrJgfKF8Zwe58b9yPRMiq/dgGD5wkJpL4HwNwpmS6W8tpFYs5VTVtbonjzZi2kZMjd0y85bN9MS2OVQZTBhR9zr0pPXVW5M58Ypw5m74rl7d9M/hGzJGp7cFZf9DU7YCmkK5h2KLoQIpZr5hTzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798526; c=relaxed/simple;
	bh=LsjBoe6ZyEktNfRJriTPpvCiIXrt69gIDTiNDaGWxxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bn81kUWQPfxp024KCOSKcn4ZIJJULoigHn94xWi9+Xe8nEYyPqzdq3FFr6Inw0d+xThx8p0YDPMA8Sct/WROMoIAQA+G65jjhbkkilhgrc6Gra8WAOe8zrB94QM8VsxvpNjV5NXfEBLNOWsE8HjUownM57sdhSqDod0kzhIxKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWq2AAT3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4ebbfb18fso523705f8f.3;
        Sun, 01 Jun 2025 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798522; x=1749403322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tczmAz3eJqGabRIPtrdIqxnYjMqW/41duQPDLe/7c+I=;
        b=TWq2AAT3BFU8bnAqMkitN/B34d1uHOilWSBOxU9UxhRFp9kQgCNglidBJ6XcgTp00I
         CkOb20ChqqO0IJWaDulbRK6/4GF2wjrVX3XqD/e70Itg0xz1BKqbTxGpJOIEbYOZfeIA
         UNNrvKed1X4i/0MySCs7xXu9Iz+KTl8Yogo3xYuJD87AMyMcLAhdtKbTLYquAJ5+Wzib
         /v/jui5bruCsjWXFQQ7dQY1hH8U4eV2/NcjXhG7FL1XVRiu+vqEbhlRU19yncGxKFhg5
         z6oVm3aQ63RLua+6Nxriq+/8vchCpVQ+cki3nr0dD8i+5d/KzGfnteqB1HuZzQa4Y9SS
         saFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798522; x=1749403322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tczmAz3eJqGabRIPtrdIqxnYjMqW/41duQPDLe/7c+I=;
        b=qD2wKSzlj15UsuiJpJVhK7f5Sy7xHpnIHmv9ezQ7WSpPrtaC4RL86Css4ncNSb4iPt
         iAcLYVsh+3ZFhElXL/pVisYawlp8wEnMcWs5WX74YhvSC10mTD0jNL2FHgc/ESU478Ld
         NXslOL+LGZs4/PsrhIgwrdZSUukV7MZcnRt/rda0tZ3D7ivBva2/bw13iuv3iIWlYKsa
         V7YVY3iMKOF05Bw7GfrDCw8XpL4gV6vG/sMZAx8QNUO5ReLPc9tjRYVk3ruOgakD2tFR
         aZCSSE7gj/O1NTOEZJ6Nocen+nhTJmdosHzD03kMHIKMd5aM5TYs6NaiaaDo+92z0RNz
         xjsg==
X-Forwarded-Encrypted: i=1; AJvYcCU4J2yGyXWpbRYnbmsSVWCkZBzV6bB/XCJAoO6cR2PRL7Y5B/sldzE25F2OdIdsFIUXit0ACOli5Zg=@vger.kernel.org, AJvYcCUmi3vrg2OcYjCIqaJSrcLK8uFF7XHovRXKoZGtZWbY7znDC/cMyL35zezKJOcsSe+ExUROxroWlv5n@vger.kernel.org, AJvYcCVkKOt4ULfhZCZNjlEQfGbfHIQgqf0mkxbdn6YyKGumZXZGFYX/POBWWlYqe2ksxlfwbsXdz1Ai2AxQrhVM@vger.kernel.org
X-Gm-Message-State: AOJu0YzxXNbuUK/azcn8XEOgC1d7LJlbYBHCuq/3u8KJ716o8YyphluU
	TMgyNb5GCCNjML8tBpbHGNEH/v23tYL/FhDtt6dfiNJrlVBdR+dYFOi1
X-Gm-Gg: ASbGncssc6nO13vcJc+2QycNsj9tu0ippgXcQ1IpjnTfEnqOywjfb65RkJxQKRH7SAW
	Kvr3TGdfG6diuu+pHwHLtD3QV+8P9qJmHL2euu9kh1xNsjqKKwfv5W44PeJbTrRQZUwDV12fzs9
	z1ZC90Ei3LbcWKJu7XVm+pIOb9v3MhmZ4lnqz4+qjvLwrBLK5AfFaDXaQO83yT0gyCqg7dmxsbp
	/jGZ2vjKVxVLWMdQjvQGJiw9tspBmFT0oVKtxMLWWeMvSCdjqMgLyjNP6BVd1rG7smvz80cSUwp
	Ah+isaGckHXNkAWMfVrdrRM56OfcwG+iPYY7GF2v1PGWp44Ffbd+BVxKFfSt8cCbF/W8J6EOo5j
	FJp6jPOStsKpK6GPsg/bckw==
X-Google-Smtp-Source: AGHT+IEHYHrfynUs6G5oyxrFukS/SHRJlf0Q4Ln2ha327mjJG0g1OQ8KnwfgH8aHgLTvIE9JAD9F2w==
X-Received: by 2002:a05:6000:288c:b0:3a4:f7d9:9617 with SMTP id ffacd0b85a97d-3a4f89310fbmr2819949f8f.0.1748798522263;
        Sun, 01 Jun 2025 10:22:02 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:22:01 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/11] iio: accel: adxl313: add AC coupled activity/inactivity events
Date: Sun,  1 Jun 2025 17:21:38 +0000
Message-Id: <20250601172139.59156-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add AC coupling activity and inactivity as MAG_ADAPTIVE events. This adds
up an additional set of threshold and period handles, verifies matching
disabling functionality and extends setting the link bit to complementary
event configurations.

This means, e.g. either ACTIVITY or ACTIVITY_AC can be enabled. The most
recent set will remain configured. Disabling ACTIVITY where ACTIVITY_AC was
enabled is ignored, since it does not match (should be disabling
ACTIVITY_AC). When INACTIVITY or INACTIVITY_AC is also enabled, the link
bit will be set. Note, having the link bit and auto-sleep in place activity
and inactivity indicate the power save state change and thus will only be
triggered once a state transition occurs. Since there is a separate AC bit
for ACTIVITY and for INACTIVITY, events can be linked independently from
each other i.e. ACTIVITY can be linked to INACTIVITY_AC for instance.

When one of both is disabled, the link bit will be removed. Hence, the
remaining event will not indicate a plain state change anymore, but occur
as a periodically triggered inactivity event or for each activity event
above the threshold.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 414 +++++++++++++++++++++++++------
 1 file changed, 333 insertions(+), 81 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 1598562a38e2..9a0905e30de3 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -30,20 +30,38 @@
 #define ADXL313_ACT_XYZ_EN			GENMASK(6, 4)
 #define ADXL313_INACT_XYZ_EN			GENMASK(2, 0)
 
+#define ADXL313_REG_ACT_ACDC_MSK		BIT(7)
+#define ADXL313_REG_INACT_ACDC_MSK		BIT(3)
+#define ADXL313_COUPLING_DC			0
+#define ADXL313_COUPLING_AC			1
+
 /* activity/inactivity */
 enum adxl313_activity_type {
 	ADXL313_ACTIVITY,
 	ADXL313_INACTIVITY,
+	ADXL313_ACTIVITY_AC,
+	ADXL313_INACTIVITY_AC,
 };
 
 static const unsigned int adxl313_act_int_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_INT_ACTIVITY,
 	[ADXL313_INACTIVITY] = ADXL313_INT_INACTIVITY,
+	[ADXL313_ACTIVITY_AC] = ADXL313_INT_ACTIVITY,
+	[ADXL313_INACTIVITY_AC] = ADXL313_INT_INACTIVITY,
 };
 
 static const unsigned int adxl313_act_thresh_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_REG_THRESH_ACT,
 	[ADXL313_INACTIVITY] = ADXL313_REG_THRESH_INACT,
+	[ADXL313_ACTIVITY_AC] = ADXL313_REG_THRESH_ACT,
+	[ADXL313_INACTIVITY_AC] = ADXL313_REG_THRESH_INACT,
+};
+
+static const unsigned int adxl313_act_acdc_msk[] = {
+	[ADXL313_ACTIVITY] = ADXL313_REG_ACT_ACDC_MSK,
+	[ADXL313_INACTIVITY] = ADXL313_REG_INACT_ACDC_MSK,
+	[ADXL313_ACTIVITY_AC] = ADXL313_REG_ACT_ACDC_MSK,
+	[ADXL313_INACTIVITY_AC] = ADXL313_REG_INACT_ACDC_MSK,
 };
 
 static const struct regmap_range adxl312_readable_reg_range[] = {
@@ -255,6 +273,13 @@ static const struct iio_event_spec adxl313_activity_events[] = {
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* activity, AC bit set */
+		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
 };
 
 static const struct iio_event_spec adxl313_inactivity_events[] = {
@@ -265,6 +290,14 @@ static const struct iio_event_spec adxl313_inactivity_events[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_PERIOD),
 	},
+	{
+		/* inactivity, AC bit set */
+		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 };
 
 enum adxl313_chans {
@@ -362,11 +395,58 @@ static int adxl313_set_inact_time_s(struct adxl313_data *data,
 	return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val);
 }
 
+/**
+ * adxl313_is_act_inact_ac() - Check if AC coupling is enabled.
+ *
+ * @data: The device data.
+ * @type: The activity or inactivity type.
+ *
+ * Provide a type of activity or inactivity, combined with either AC coupling
+ * set, or default to DC coupling. This function verifies, if the combination is
+ * currently enabled or not.
+ *
+ * Return if the provided activity type has AC coupling enabled or a negative
+ * error value.
+ */
+static int adxl313_is_act_inact_ac(struct adxl313_data *data,
+				   enum adxl313_activity_type type)
+{
+	unsigned int regval;
+	bool coupling;
+	int ret;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &regval);
+	if (ret)
+		return ret;
+
+	coupling = adxl313_act_acdc_msk[type] & regval;
+
+	if (type == ADXL313_ACTIVITY || type == ADXL313_INACTIVITY)
+		return coupling == ADXL313_COUPLING_DC;
+	else
+		return coupling == ADXL313_COUPLING_AC;
+}
+
+static int adxl313_set_act_inact_ac(struct adxl313_data *data,
+				    enum adxl313_activity_type type)
+{
+	unsigned int coupling;
+
+	if (type == ADXL313_ACTIVITY_AC || type == ADXL313_INACTIVITY_AC)
+		coupling = ADXL313_COUPLING_AC;
+	else
+		coupling = ADXL313_COUPLING_DC;
+
+	return regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
+				  adxl313_act_acdc_msk[type], coupling);
+}
+
 static int adxl313_is_act_inact_en(struct adxl313_data *data,
 				   enum adxl313_activity_type type)
 {
 	unsigned int axis_ctrl;
 	unsigned int regval;
+	int coupling;
 	int axis_en, int_en, ret;
 
 	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
@@ -374,7 +454,7 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 		return ret;
 
 	/* Check if axis for activity are enabled */
-	if (type == ADXL313_ACTIVITY)
+	if (type == ADXL313_ACTIVITY || type == ADXL313_ACTIVITY_AC)
 		axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
 	else
 		axis_en = FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl);
@@ -386,7 +466,12 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 
 	int_en = adxl313_act_int_reg[type] & regval;
 
-	return axis_en && int_en;
+	/* Return true if configured coupling matches provided type */
+	coupling = adxl313_is_act_inact_ac(data, type);
+	if (coupling < 0)
+		return coupling;
+
+	return axis_en && int_en && coupling;
 }
 
 static int adxl313_set_act_inact_en(struct adxl313_data *data,
@@ -396,15 +481,26 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	unsigned int axis_ctrl;
 	unsigned int threshold;
 	unsigned int inact_time_s;
-	int act_en, inact_en;
-	bool en;
+	int act_en, inact_en, act_ac_en, inact_ac_en;
+	bool en, act_inact_ac;
 	int ret;
 
-	if (type == ADXL313_ACTIVITY)
+	/*
+	 * In case of turning off, assure turning off a correspondent coupling
+	 * event. In case of not matching coupling, simply return.
+	 */
+	if (!cmd_en) {
+		/* Expected positive true if coupling matches coupling type */
+		if (adxl313_is_act_inact_ac(data, type) <= 0)
+			return 0;
+	}
+
+	if (type == ADXL313_ACTIVITY || type == ADXL313_ACTIVITY_AC)
 		axis_ctrl = ADXL313_ACT_XYZ_EN;
 	else
 		axis_ctrl = ADXL313_INACT_XYZ_EN;
 
+	/* Start modifying configuration registers */
 	ret = adxl313_set_measure_en(data, false);
 	if (ret)
 		return ret;
@@ -414,12 +510,16 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	if (ret)
 		return ret;
 
+	act_inact_ac = type == ADXL313_ACTIVITY_AC || ADXL313_INACTIVITY_AC;
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
+				 adxl313_act_acdc_msk[type], act_inact_ac);
+
 	ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type], &threshold);
 	if (ret)
 		return ret;
 
 	en = cmd_en && threshold;
-	if (type == ADXL313_INACTIVITY) {
+	if (type == ADXL313_INACTIVITY || type == ADXL313_INACTIVITY_AC) {
 		ret = regmap_read(data->regmap, ADXL313_REG_TIME_INACT, &inact_time_s);
 		if (ret)
 			return ret;
@@ -427,6 +527,10 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 		en = en && inact_time_s;
 	}
 
+	ret = adxl313_set_act_inact_ac(data, type);
+	if (ret)
+		return ret;
+
 	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
 				 adxl313_act_int_reg[type], en);
 	if (ret)
@@ -439,10 +543,22 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	if (act_en < 0)
 		return act_en;
 
+	act_ac_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY_AC);
+	if (act_ac_en < 0)
+		return act_ac_en;
+
+	act_en = act_en || act_ac_en;
+
 	inact_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
 	if (inact_en < 0)
 		return inact_en;
 
+	inact_ac_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY_AC);
+	if (inact_ac_en < 0)
+		return inact_ac_en;
+
+	inact_en = inact_en || inact_ac_en;
+
 	en = en && act_en && inact_en;
 
 	ret = regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
@@ -534,14 +650,25 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
 
-	if (type != IIO_EV_TYPE_MAG)
-		return -EINVAL;
-
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		return adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
-	case IIO_EV_DIR_FALLING:
-		return adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+		case IIO_EV_DIR_FALLING:
+			return adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl313_is_act_inact_en(data, ADXL313_ACTIVITY_AC);
+		case IIO_EV_DIR_FALLING:
+			return adxl313_is_act_inact_en(data, ADXL313_INACTIVITY_AC);
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -555,14 +682,33 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
 
-	if (type != IIO_EV_TYPE_MAG)
-		return -EINVAL;
-
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		return adxl313_set_act_inact_en(data, ADXL313_ACTIVITY, state);
-	case IIO_EV_DIR_FALLING:
-		return adxl313_set_act_inact_en(data, ADXL313_INACTIVITY, state);
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl313_set_act_inact_en(data,
+							ADXL313_ACTIVITY,
+							state);
+		case IIO_EV_DIR_FALLING:
+			return adxl313_set_act_inact_en(data,
+							ADXL313_INACTIVITY,
+							state);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl313_set_act_inact_en(data,
+							ADXL313_ACTIVITY_AC,
+							state);
+		case IIO_EV_DIR_FALLING:
+			return adxl313_set_act_inact_en(data,
+							ADXL313_INACTIVITY_AC,
+							state);
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -583,41 +729,79 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 
 	/* Measurement stays enabled, reading from regmap cache */
 
-	if (type != IIO_EV_TYPE_MAG)
-		return -EINVAL;
-
-	switch (info) {
-	case IIO_EV_INFO_VALUE:
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = regmap_read(data->regmap,
+						  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+						  &act_threshold);
+				if (ret)
+					return ret;
+				*val = act_threshold * 15625;
+				*val2 = MICRO;
+				return IIO_VAL_FRACTIONAL;
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_read(data->regmap,
+						  adxl313_act_thresh_reg[ADXL313_INACTIVITY],
+						  &inact_threshold);
+				if (ret)
+					return ret;
+				*val = inact_threshold * 15625;
+				*val2 = MICRO;
+				return IIO_VAL_FRACTIONAL;
+			default:
+				return -EINVAL;
+			}
+		case IIO_EV_INFO_PERIOD:
 			ret = regmap_read(data->regmap,
-					  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
-					  &act_threshold);
+					  ADXL313_REG_TIME_INACT,
+					  &inact_time_s);
 			if (ret)
 				return ret;
-			*val = act_threshold * 15625;
-			*val2 = MICRO;
-			return IIO_VAL_FRACTIONAL;
-		case IIO_EV_DIR_FALLING:
+			*val = inact_time_s;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = regmap_read(data->regmap,
+						  adxl313_act_thresh_reg[ADXL313_ACTIVITY_AC],
+						  &act_threshold);
+				if (ret)
+					return ret;
+				*val = act_threshold * 15625;
+				*val2 = MICRO;
+				return IIO_VAL_FRACTIONAL;
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_read(data->regmap,
+						  adxl313_act_thresh_reg[ADXL313_INACTIVITY_AC],
+						  &inact_threshold);
+				if (ret)
+					return ret;
+				*val = inact_threshold * 15625;
+				*val2 = MICRO;
+				return IIO_VAL_FRACTIONAL;
+			default:
+				return -EINVAL;
+			}
+		case IIO_EV_INFO_PERIOD:
 			ret = regmap_read(data->regmap,
-					  adxl313_act_thresh_reg[ADXL313_INACTIVITY],
-					  &inact_threshold);
+					  ADXL313_REG_TIME_INACT,
+					  &inact_time_s);
 			if (ret)
 				return ret;
-			*val = inact_threshold * 15625;
-			*val2 = MICRO;
-			return IIO_VAL_FRACTIONAL;
+			*val = inact_time_s;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
-	case IIO_EV_INFO_PERIOD:
-		ret = regmap_read(data->regmap,
-				  ADXL313_REG_TIME_INACT,
-				  &inact_time_s);
-		if (ret)
-			return ret;
-		*val = inact_time_s;
-		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -638,36 +822,69 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	if (type != IIO_EV_TYPE_MAG)
-		return -EINVAL;
-
-	switch (info) {
-	case IIO_EV_INFO_VALUE:
-		/* Scale factor 15.625 mg/LSB */
-		regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			ret = regmap_write(data->regmap,
-					   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
-					   regval);
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			/* Scale factor 15.625 mg/LSB */
+			regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = regmap_write(data->regmap,
+						   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+						   regval);
+				if (ret)
+					return ret;
+				return adxl313_set_measure_en(data, true);
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_write(data->regmap,
+						   adxl313_act_thresh_reg[ADXL313_INACTIVITY],
+						   regval);
+				if (ret)
+					return ret;
+				return adxl313_set_measure_en(data, true);
+			default:
+				return -EINVAL;
+			}
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl313_set_inact_time_s(data, val);
 			if (ret)
 				return ret;
 			return adxl313_set_measure_en(data, true);
-		case IIO_EV_DIR_FALLING:
-			ret = regmap_write(data->regmap,
-					   adxl313_act_thresh_reg[ADXL313_INACTIVITY],
-					   regval);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			/* Scale factor 15.625 mg/LSB */
+			regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = regmap_write(data->regmap,
+						   adxl313_act_thresh_reg[ADXL313_ACTIVITY_AC],
+						   regval);
+				if (ret)
+					return ret;
+				return adxl313_set_measure_en(data, true);
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_write(data->regmap,
+						   adxl313_act_thresh_reg[ADXL313_INACTIVITY_AC],
+						   regval);
+				if (ret)
+					return ret;
+				return adxl313_set_measure_en(data, true);
+			default:
+				return -EINVAL;
+			}
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl313_set_inact_time_s(data, val);
 			if (ret)
 				return ret;
 			return adxl313_set_measure_en(data, true);
 		default:
 			return -EINVAL;
 		}
-	case IIO_EV_INFO_PERIOD:
-		ret = adxl313_set_inact_time_s(data, val);
-		if (ret)
-			return ret;
-		return adxl313_set_measure_en(data, true);
 	default:
 		return -EINVAL;
 	}
@@ -807,29 +1024,64 @@ static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl313_data *data = iio_priv(indio_dev);
+	unsigned int regval;
 	int samples;
 	int ret = -ENOENT;
 
 	if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
-		ret = iio_push_event(indio_dev,
-				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
-							IIO_MOD_X_OR_Y_OR_Z,
-							IIO_EV_TYPE_MAG,
-							IIO_EV_DIR_RISING),
-				     ts);
+		ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &regval);
 		if (ret)
 			return ret;
+
+		if (FIELD_GET(ADXL313_REG_ACT_ACDC_MSK, regval)) {
+			/* AC coupled */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+								IIO_MOD_X_OR_Y_OR_Z,
+								IIO_EV_TYPE_MAG_ADAPTIVE,
+								IIO_EV_DIR_RISING),
+					     ts);
+			if (ret)
+				return ret;
+		} else {
+			/* DC coupled, relying on THRESH */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+								IIO_MOD_X_OR_Y_OR_Z,
+								IIO_EV_TYPE_MAG,
+								IIO_EV_DIR_RISING),
+					     ts);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (FIELD_GET(ADXL313_INT_INACTIVITY, int_stat)) {
-		ret = iio_push_event(indio_dev,
-				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
-							IIO_MOD_X_AND_Y_AND_Z,
-							IIO_EV_TYPE_MAG,
-							IIO_EV_DIR_FALLING),
-				     ts);
+		ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &regval);
 		if (ret)
 			return ret;
+
+		if (FIELD_GET(ADXL313_REG_INACT_ACDC_MSK, regval)) {
+			/* AC coupled */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+								IIO_MOD_X_AND_Y_AND_Z,
+								IIO_EV_TYPE_MAG_ADAPTIVE,
+								IIO_EV_DIR_FALLING),
+					     ts);
+			if (ret)
+				return ret;
+		} else {
+			/* DC coupled, relying on THRESH */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+								IIO_MOD_X_AND_Y_AND_Z,
+								IIO_EV_TYPE_MAG,
+								IIO_EV_DIR_FALLING),
+					     ts);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
-- 
2.39.5


