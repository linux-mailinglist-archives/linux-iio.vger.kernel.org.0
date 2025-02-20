Return-Path: <linux-iio+bounces-15835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD58DA3D71C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE468189EFDA
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF871F4276;
	Thu, 20 Feb 2025 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuskHnj5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E51F3D58;
	Thu, 20 Feb 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048170; cv=none; b=pFvtneYi/poCAiL51TR3KmsCMRijfv16BId68F06KHHoJDiBKQvicBYt1sgoEGF9FX89nHlsi5N40Lvn7GfSKtPgv93Wivz7gw74JfGudMhFH5f2H9aSIS+Z4zqLtLrIwtPSi0Koi0URE+Fpjfdcy+gCCmI+0NJMid2bHdpVo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048170; c=relaxed/simple;
	bh=hF6T63bWml3OU/pCUTMJjxtyItj0/Ir7pAOwr1SZ1Ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCtHHY6NJYq4x8BgTqDHSCV1mtLmBAh/pPQFa/D/dqsKktND+rqfTqmQoOjE1gBnFqsPfzlVcq91P4hSe9Ki8Eo8ErxUJJ1TWkz6LBld4Ih89kfRkaHOTXvQCR9/S3h2oPeOLLqXKDx+SwZoObnT3sSBzxUwC0i1ufjvxYpcia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuskHnj5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb76cc6108so11413666b.0;
        Thu, 20 Feb 2025 02:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048167; x=1740652967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQU4UsTNREqUeJJB9UI8mNNLlTTknhjQi/yKMyyZlMg=;
        b=YuskHnj5Fi6Z4rAdbzKj6a4/n3NoqOunEacBrY2jBA5gLNLYL4CdBcoIGjVwtg3Mee
         UKzqfbLHOiUq3HAzoZ9GOPZeWz+UeNURLC/ibIDP1pzlYktgUfu8gS3qxZqNqqpeBoEM
         taYdNbPVUdx3u878vsf3bJnlb7gUaVaGMIACzbH2EBMmwgbdiHvGiYTSy5jCQzeHxbu9
         //cKk0st8JBVuCWJbzhETF84jM0+YTv7WdHi12TxpUNeqN4Fbx2iUHrC2e4NCeR23R9+
         Ws5DB1ktiqdvdXnWM+3CyIHn8zkeuFWX4Fbemj+AsZH0C9hbdtO3uuixT3G8gDK+fTgW
         ik1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048167; x=1740652967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQU4UsTNREqUeJJB9UI8mNNLlTTknhjQi/yKMyyZlMg=;
        b=VyTOmjam5QzEbNBs/o8w5r0hoz3GO0H853GhdBpcqd7I0avZnI5n/SLBYHjQJGqcfQ
         50kKuzjkd26ph2MNU0LEoMix1BCa4Gttpg7hr7fznEfq5xEaxs8EPc+5zc0U5SAok9sw
         LEXqJfC5JLm/6o+vjx9qZuf4bboQgJU6ApbNokjnLnf2E9AgkNeiwZ0Qpwou4KwnH2wt
         IYRq0o9a30+Gt2Uv+F+V/KQE1UZEu3frE1BknONQ/Uq5wFkttl9whAK5emLFJLAnqmqn
         O+7PYJWch9APDkyUzwM4t1HbLilbvqSNYdJjCuq6VguGaSHRz4dzMkAPy9MWtueRcbeW
         9o8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZwuIERiGWEQOaOhZcTgIxxFfo0g8QowYLr+A2FBcuuWiEeljeab5WcqBSNn6HsWOwxsvpM8Ix8xJEu64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EYqVtrAWzHUSfkmgNT0bgDGSBosZQvHpiEcKy1V49V1nZxbA
	Pgf4CtpnLI3heeoyRejWNkqpdK+NBrN3mfem1E97+xT/dkMU379d
X-Gm-Gg: ASbGncujeToB5wbqiZc2Vybi6epE7OJVNc7nuLLkyq1q9HoRLBfJWDSZSLiXVBC7NDP
	uR2zbcvTdOFGCQUgOuL6AR1hU5PhmjFHUYedm18+dYPhBeXOfMBwlp3hdvLrslo+aWFmb6UQkRt
	fkpKQnxxxHKX3pWDZLvEcumkX/tKNP/oIQxuZy2VCsX0MrQhjSHBKIk1kq4RADt3Opdxklb83Ip
	7bGrD2M7iK6aLnxi+woo6P/GDkamQkUk4p3S7lgutWtuFL6dvl+r0UzjXrpg/tU8TzYtURzN1eQ
	DKVMUjpxRMtYuOKcrChDzkPJPTik4Jx3WLwJT0F593vv/S6wGV9/rfMXePe/gpuy1o7JEw==
X-Google-Smtp-Source: AGHT+IG4JNx6qXLn8tEdSEb8E1OzlShIKJFW5XGwopzCf1DXZqg1UFtEzp4ih0wCaq0jiXQCMI/NiQ==
X-Received: by 2002:a17:906:af09:b0:abb:e5ac:28b2 with SMTP id a640c23a62f3a-abbe5ac2dddmr119606766b.13.1740048166487;
        Thu, 20 Feb 2025 02:42:46 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:46 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 08/15] iio: accel: adxl345: add double tap suppress bit
Date: Thu, 20 Feb 2025 10:42:27 +0000
Message-Id: <20250220104234.40958-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220104234.40958-1-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the suppress bit feature to the double tap detection, whenever
double tap is enabled.

Any tap event is defined by a rising signal edge above threshold, i.e.
duration time starts counting; and the falling edge under threshold
within duration time, i.e. then the tap event is issued. This means
duration is used individually for each tap event.

For double tap detection after a single tap, a latency time needs to be
specified. Usually tap events, i.e. spikes above and returning below
threshold will be ignored within latency. After latency, the window
time starts counting for a second tap detection which has to happen
within a duration time.

If the suppress bit is not set, spikes within latency time are ignored.
Setting the suppress bit will invalidate the double tap function. The
sensor will thus be able to save the window time for double tap
detection, and follow a more strict definition of what signal qualifies
for a double tap.

In a summary having the suppress bit set, fewer signal spikes will be
considered as double taps. This is an optional add on to double tap,
thus a separate patch.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c014bdf84e66..10cd81dd08bb 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -34,6 +34,7 @@
 #define ADXL345_INT2			1
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 
 enum adxl345_axis {
 	ADXL345_Z_EN = BIT(0),
@@ -258,6 +259,18 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
 
 static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
 {
+	int ret;
+
+	/*
+	 * generally suppress detection of spikes during the latency period as
+	 * double taps here, this is fully optional for double tap detection
+	 */
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
+				 ADXL345_REG_TAP_SUPPRESS_MSK,
+				 en ? ADXL345_TAP_SUPPRESS : 0x00);
+	if (ret)
+		return ret;
+
 	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
 }
 
-- 
2.39.5


