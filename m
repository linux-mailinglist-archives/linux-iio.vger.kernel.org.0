Return-Path: <linux-iio+bounces-15260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F838A2EA72
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFF916889D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DE41EA7E7;
	Mon, 10 Feb 2025 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwCd9UHS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75001E9B16;
	Mon, 10 Feb 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185311; cv=none; b=AUoLXV7o7Sz880RlI9J08IiLmbRBua/Jvd+oEZcZXs4wB1Ow7CkoXQ0hTsUN75zgm7qSyTFZnSwPdRfSR7jPut30ooRWj2hFJNuDqRTJkYdukW0k3VK+NXxjrBP70x9b6W0e3SY4cu+MUe0QoFOQ3y7PDAwgYKM+Qr1WqrOWEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185311; c=relaxed/simple;
	bh=K0sV5QSjbhEFIMidR+0tRCTJMWhpB/o+wDTXEIOQwSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O91JRh3h2DEVy3UVMv8f6tVSWDjd50rcgondSHld9eMze5ReHv7jTY8vQ1rL8t0AREv8BKCw6+smczvXsymDz7WvMZbufuL0E04M5dwYB/75hVGRuAb9Khki1TEJP1ZowS6kq2qrqKPncCPV21DaKExTmFgKJ3CeRGTlNX5EpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwCd9UHS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7bccf51e7so7562266b.2;
        Mon, 10 Feb 2025 03:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185308; x=1739790108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlPwq+dInNhuHvPpkG98tgUSzMHb+EZ1EHAvrMdmAVU=;
        b=dwCd9UHSKRudE3IsrkKxys0SbVGhmd+HEMlxXfGJ88E+Np/5uD77rLsyDNvmc302nW
         UehtwnQkR6RhjHKN9H9FHc+IY5nZoniGl6ETFxHZAxJREdnsKr7GiuO4GjXEiJFXbQmG
         Us6oLNmYNGWOuDtPOuHvapZRscBl1Leqor4wl3BgmhvzGzdCjwtDGaIvaQQ1iTGXfupr
         xSgDh9TjFCNuo4Llnt2U74clzpmH9VSYZXTmhAo33NpCIwVYlXuA5NiQwR7DdHwhjmSp
         xVDjusSJg93dOLdlVhlMhjCsD3F267ZOriQKzFFZgRjl42UI8d2S73+k6iV0nYEzUz9q
         aqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185308; x=1739790108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlPwq+dInNhuHvPpkG98tgUSzMHb+EZ1EHAvrMdmAVU=;
        b=SaIbKtllqztZalGT+TJ9EDCqK4BF44Ex9s09Kx3dw6kGVmhQPGGEyNJgeI/Gvl9sgN
         fp/vAEk7MknlLVFUJ2MSiotQIj6NO67xaXkgqZOLNKDFM+wmHNIr8DOFtTDAogUyGiu3
         1SYSYpqI3ylsXLsqeoOjvEpj3T0ifTD9hXDaWxNd3NLog33/6jjcHvNBnOWeikIdqzXh
         XiDArqL0BCkOoLiZoZv6pKxYQ0o7JGrjENMdRAkB4CieUkv1r4CTrNPM08/fAO68Cze5
         KCsr5XsVOyH23w+mOr3RiNz9f4bQm2/dCXQ0lbTvP2rB6aypuedlgND392c0r5WwwgGU
         b4HA==
X-Forwarded-Encrypted: i=1; AJvYcCW1InOKs/Gfg8ss4OiswuMKdiNinfgmMfik8XFn+or5BBXTaaHQtQSUIvfDAPnQziys8m2Wn7utz/crk/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ2OJ5uU9VVqDNF9OIEHBvTuYV2ECPLZx0rS1OLrAriqorl+Yw
	LuW8IyNehbSn/4idzV/HPRkgdO/chPQcqUnksVA0BJmQp2ai1wN/
X-Gm-Gg: ASbGncsevp0gFA/z4hYmSiW8OMvhLqQZa/4RuxXC/7gBYiYaboGQe312V6yCpaJh1kb
	yDm64n3Rwd8xP4nhBAfncw4yWHJEENARJkmW1c8MlVfISAYgSqoPhcg16+++J2Fs8CcM1DnVzDz
	6DgNRi4hBWRyBDbXRR3znUu0guYjOUgOlX2ZW/eWgrDJ+Cm5Si+WdfxEODSs0dR/hwrL/AvRB4l
	nhPGwNjxQWJIn2MvlBufRAiDRkzEdAJ2zdQGg3fx2XAiWPJ9OLzFFHnJdKnszm4BfR43sospRY8
	zuJihk+tcb7nFUcIaGQGAQ/XilLWCuiKLBTMynYlU3OTFSCtqlnN4JvXsfaB5hy6hA8TOA==
X-Google-Smtp-Source: AGHT+IHzmlS3SbYLfzqN4CdGIBdVOXRr91akJDYrtVdYWJztPT9Cl1f1Sgrdgd2FsAF6WgudGarVkQ==
X-Received: by 2002:a17:907:1c9f:b0:ab7:6056:7a7f with SMTP id a640c23a62f3a-ab789c5d22emr524033266b.9.1739185307816;
        Mon, 10 Feb 2025 03:01:47 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:47 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 13/14] iio: accel: adxl345: add coupling detection for activity/inactivity
Date: Mon, 10 Feb 2025 11:01:18 +0000
Message-Id: <20250210110119.260858-14-l.rubusch@gmail.com>
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

Add coupling activity/inactivity detection by the AC/DC bit. This is an
addititional enhancement for the detection of activity states and
completes the activity / inactivity feature of the ADXL345.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 77 ++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7de869fac799..411ae7bf6b97 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -36,7 +36,9 @@
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
+#define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
 #define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_INACT_ACDC_MSK	BIT(3)
 #define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
 
 enum adxl345_axis {
@@ -86,6 +88,11 @@ static const unsigned int adxl345_act_thresh_reg[2] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
 };
 
+static const unsigned int adxl345_act_acdc_msk[2] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_ACDC_MSK,
+	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK,
+};
+
 static const unsigned int adxl345_act_axis_msk[2] = {
 	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_AXIS_MSK,
 	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_AXIS_MSK,
@@ -178,9 +185,11 @@ struct adxl345_state {
 	enum adxl345_range range;
 
 	u32 act_axis_ctrl;
+	bool act_ac;
 	u8 act_threshold;
 
 	u32 inact_axis_ctrl;
+	bool inact_ac;
 	u8 inact_threshold;
 	u8 inact_time_s;
 
@@ -237,6 +246,18 @@ static struct iio_event_spec adxl345_events[] = {
 			BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_PERIOD),
 	},
+	{
+		/* activity, activity - ac bit */
+		.type = IIO_EV_TYPE_MAG_REFERENCED,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		/* activity, inactivity - ac bit */
+		.type = IIO_EV_TYPE_MAG_REFERENCED,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
+	},
 };
 
 #define ADXL345_CHANNEL(index, reg, axis) {					\
@@ -334,6 +355,35 @@ static int adxl345_write_act_axis(struct adxl345_state *st,
 	return 0;
 }
 
+static int adxl345_is_act_inact_ac(struct adxl345_state *st,
+				   enum adxl345_activity_type type, bool *ac)
+{
+	if (type == ADXL345_ACTIVITY)
+		*ac = st->act_ac;
+	else
+		*ac = st->inact_ac;
+
+	return 0;
+}
+
+static int adxl345_set_act_inact_ac(struct adxl345_state *st,
+				    enum adxl345_activity_type type, bool ac)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+				 adxl345_act_acdc_msk[type], ac);
+	if (ret)
+		return ret;
+
+	if (type == ADXL345_ACTIVITY)
+		st->act_ac = ac;
+	else
+		st->inact_ac = ac;
+
+	return 0;
+}
+
 static int adxl345_is_act_inact_en(struct adxl345_state *st,
 				   enum adxl345_activity_type type, bool *en)
 {
@@ -959,6 +1009,21 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		return int_en;
+	case IIO_EV_TYPE_MAG_REFERENCED:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = adxl345_is_act_inact_ac(st, ADXL345_ACTIVITY, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		case IIO_EV_DIR_FALLING:
+			ret = adxl345_is_act_inact_ac(st, ADXL345_INACTIVITY, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1008,6 +1073,16 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		}
 	case IIO_EV_TYPE_MAG:
 		return adxl345_set_ff_en(st, state);
+	case IIO_EV_TYPE_MAG_REFERENCED:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl345_set_act_inact_ac(st, ADXL345_ACTIVITY, state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_ac(st, ADXL345_INACTIVITY, state);
+		default:
+			return -EINVAL;
+		}
+
 	default:
 		return -EINVAL;
 	}
@@ -1619,6 +1694,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	 */
 	st->act_axis_ctrl = ADXL345_REG_ACT_AXIS_MSK;
 	st->inact_axis_ctrl = ADXL345_REG_INACT_AXIS_MSK;
+	st->inact_ac = 0;			/*    0 [dc]              */
+	st->act_ac = 0;
 	st->int_map = 0x00;			/* reset interrupts */
 
 	/* Init with reasonable values */
-- 
2.39.5


