Return-Path: <linux-iio+bounces-8220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE5946AC8
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 20:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E9F1F216B0
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839E01C683;
	Sat,  3 Aug 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU5F1AoH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D91CA93;
	Sat,  3 Aug 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722708616; cv=none; b=Xl5aZDvnVRbMf4R8J/62joLj8msDWzbhJu8affTRHrJKuZozXZnLTSqnt/btjk51ysLiuSZjMNSbdtMSPjNuYc/an5CmZUaczzCXBjI8VFhfA+d4k9r0jd5xjEFN6vxnyQScwxkS891UUewCAo3b7S++SMkjIjM8mLYssS9yZgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722708616; c=relaxed/simple;
	bh=vSuewzdIUu+7519qJBAfxGFGrc2KaLKBcCuXLN6LH5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eih2tEPt/6ZLn3n3vSTWUxx/ow0G/03HCpIuySZPLDhQNYVq4z/bI7M0ud+0lScaN3D4Rl4NOtXr8lLDA96ZLT7VgNVS6XybTvOPOP/OK2+MDH7/Ze+H80ThJ9IIFcxb2XYKz5rNt8wvIV9/hRvlv9LzMXTcEVFM0d08RXgJzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU5F1AoH; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81fd925287eso68138739f.3;
        Sat, 03 Aug 2024 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722708613; x=1723313413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilYHZIwKOnRvQ2z2qrooGbgYja3yrOQMh4ORr99byFI=;
        b=FU5F1AoHgnh8M+E3JP/QtFgT6SOphmh6KPOhVdQHAdl/6xdkANFfNupScieQXc5Gkn
         TqA5rvpxzcyJEY6hGMmbsSaQvrCrFfqPPFHkCS+v0rlm/FYV4igIXqJ8pquf8KBjEqIe
         9dFpJBqOO/j/J1iU/LuF4REnIESf6vXBJSqrTl97/K5lPkv2JyXok9Kzf4+2jan1LBoY
         3lSoMF6nHdV5RwVLeuOTebo3JdbWM4W8sh3jSmDUVakybj6xWLdjdAKVDpjtjCs54QTG
         7DVDuYL3ZJ4VIUwF+ivBODH5ffAsFQhHgVKGNYBK5T1bufRFr5aFl1xWSl0NmDsT7mMW
         7NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722708613; x=1723313413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilYHZIwKOnRvQ2z2qrooGbgYja3yrOQMh4ORr99byFI=;
        b=iNQoMbGWjd2CH5jkpt3yzqKxQn9gfeQli9DzHYMeGtFhzspk1O7bElBWDBZtTnnj+2
         1gBknVD0w36wnmc+0zxK4k6cLolLKp+ceVrRH1tVF8VDMKfVowISVL022JAKr3IyeucC
         paubqTbR0uJgXdcOMt4LTzY6XSUxJMZsnNihmnMLvng2bv4NZ10b9FXdZC0W6l3wUyC0
         EFG1COrZr95GnY4/Dg9D2ps/cLDns3oGics9t4dOBGO5evQgLVQz64Tr06aLkbaHWBDP
         cgSyiTolpfr+PJotxYaLPoWP3sa+f4UHPht6gCXuqQIt/2Vb8cfkm3IRB1nv+6KHV1Aa
         aLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDoVX7TSPOt+zLs8CZM8iO46j2sarTUDG14QWTcld3HtuT8dp1Nbo/fsPJFq8ghhu0QXzYGx63yt8BkkAuv7bMJtsGVODzzuWY89FI
X-Gm-Message-State: AOJu0Yxv+stkRSuIr9xElgVAkKLLX2jdF8OGGa4sa2NHAYXH/MUnJqa8
	jHbOIxlIyAfHlLTooz0dTpoxbEJmEJS97fmdBSRfPxHVxBQjXvez1aLxtvgraGM=
X-Google-Smtp-Source: AGHT+IHWEfGy/ODC5LuvM9xRj/YSrQfrkizxnX4LXllhmMC3P9783SLtr5sQfiRiP6VK6iDzKqYQhQ==
X-Received: by 2002:a05:6e02:1b0f:b0:39a:16c0:4bef with SMTP id e9e14a558f8ab-39b1fc32f14mr103595985ab.23.1722708613449;
        Sat, 03 Aug 2024 11:10:13 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm3046128a12.6.2024.08.03.11.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 11:10:12 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v6 2/2] iio: light: ltr390: Calculate 'counts_per_uvi' dynamically
Date: Sat,  3 Aug 2024 23:39:49 +0530
Message-ID: <20240803180950.32821-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240803180950.32821-1-abhashkumarjha123@gmail.com>
References: <20240803180950.32821-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

counts_per_uvi depends on the current value of gain and resolution.
Hence, we cannot use the hardcoded value 96.
The `counts_per_uvi` function gives the count based on the current gain
and resolution (integration time).

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 44ca4b04a..3a2807101 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -46,6 +46,8 @@
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
 
+#define LTR390_FRACTIONAL_PRECISION 100
+
 /*
  * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
  * the sensor are equal to 1 UV Index [Datasheet Page#8].
@@ -120,6 +122,14 @@ static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
 	return 0;
 }
 
+static int ltr390_counts_per_uvi(struct ltr390_data *data)
+{
+	const int orig_gain = 18;
+	const int orig_int_time = 400;
+
+	return DIV_ROUND_CLOSEST(23 * data->gain * data->int_time_us, 10 * orig_gain * orig_int_time);
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -159,8 +169,8 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_UVINDEX:
-			*val = LTR390_WINDOW_FACTOR;
-			*val2 = LTR390_COUNTS_PER_UVI;
+			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
+			*val2 = ltr390_counts_per_uvi(data);
 			return IIO_VAL_FRACTIONAL;
 
 		case IIO_LIGHT:
-- 
2.43.0


