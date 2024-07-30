Return-Path: <linux-iio+bounces-8045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEC6940908
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1286EB25489
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 06:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F5A190070;
	Tue, 30 Jul 2024 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAHJbkvi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56818F2F5;
	Tue, 30 Jul 2024 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322735; cv=none; b=EtAdkBEMdIgXDnX149rdrVRWqTwlAu4A4x5J5i/ZRnVy+5p061ikxOLMEs3gKvOJ+EmEv3kozcJQlS69p3/j0qXNZ39v1+el7/MIARvcCuwKt3I/tAeaN8yeqdUpwlBJe9Tb42MAxRH3oCQ4jK1dj0gG6EAbUitMEFvUUUjBkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322735; c=relaxed/simple;
	bh=RJRTCMhlH7Fc9vbEkQUaF70v2Eh9DbASAQCpiVqvqAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aS0H3jyBJfkFyaTdRwpuNAjiX8yOfJPsoyeFYDvDk9iWu4AFiVkz+Culjljnuk/muVSNRyIiYshRn00RNyQjJEBzEjxOUAltePcxBmgaEscNjqjQ3B5sybXNM0gER7PsYLbkPC7gvcGTYh6SKj8g+uVt07BKlV10bzjnL8lOa0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAHJbkvi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd6ed7688cso28262375ad.3;
        Mon, 29 Jul 2024 23:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722322733; x=1722927533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fxvk9Af0s6iPTi/YQ9TeTPKr8vJhK9Sz/kM7gcjsmlk=;
        b=BAHJbkviIIPNhlQF+BcbcsBKXN20ib7RV1CpMQtqDyiI6Uo9wVE9J58hx2UGjg1m9R
         9crirDPOozYpfprUZAM8bn9ODRZevNSml+8Hd3Q8kfAgc7ntHYl0vFfIjmIBud92Uips
         7sErkhqZP/MPdi2LCQ7NdKD+TQL/mg2pOLyAWD8il2x5efTTWVUkjvyyFyReFl0onP5q
         k0srz1cAx+53u6+JiRNqXZRLuhG5xno+8yg26TZZqRg+71395H1CihSoWBmsf9s68gEm
         HL0HcYlHyPs18hxZXuv2NaI4AeepGqsFxCdSJx0y+gtrEZp+xCLv7dAuoeIalP23y7qm
         dRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722322733; x=1722927533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fxvk9Af0s6iPTi/YQ9TeTPKr8vJhK9Sz/kM7gcjsmlk=;
        b=g6h+nIH4+xZkqB+tRBvqwvOHoK+3so/GAuZRnJrJWoeAk0gOdsKQTwrJV92+AO1VJo
         D8L2ke09ULaZ6mWL/74p5bxhUM0wjsxsKQUcBTsZBymxqtIfdXNFbpJV47pgBgF8cz5M
         ss21foGmwEKkXuBB5tp9Pa2l05FpVPjhQlWeJPMu3htr6n8lFfdFRbTLJU+nB0YgqHJu
         8Jr1A4c97A7J6KAmsuF2cbcbU5q+sMbhAhcl7NFjCGajYkQQloraErWewE5bq4YusSlS
         fwx88INPQ7ilDpdBww/4uUhF+7imFO7+h3GIK4qkxR6ZXjhyDBv95T4zmLQL1R4h0WNR
         TZkw==
X-Forwarded-Encrypted: i=1; AJvYcCWaWv1PK4a1NNZnpKrVf9lFMihr0D2G8ZtOuXp6nzQ6M4VJjm12gxiL5tAkMdG37IWt/lzPaNqo0SiIpPAzBoR1r8gkfnFJPO0MAYSf
X-Gm-Message-State: AOJu0YyRlIszegYD6aEY5J7AOqIG7dwXv1APQRPBlH1kaHMWXgyi16Pa
	ydoFnfkRZJdCtqIuDnELcHnd2147IeOQ9VSFbD94dzZ8A6DRLRfYRrpCv3H3zxLoER2W
X-Google-Smtp-Source: AGHT+IGxH2f42Il+6H/TfeYNaAkdVMluK6Pe5GBG8nT+HgFIgKIgSX19icEZr3lw4QG5nX+N89atfw==
X-Received: by 2002:a17:902:ea01:b0:1fd:d4c2:a2ef with SMTP id d9443c01a7336-1ff04839437mr88328275ad.21.1722322732787;
        Mon, 29 Jul 2024 23:58:52 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7d378a7sm94337605ad.109.2024.07.29.23.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:58:52 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v4 3/3] iio: light: ltr390: Calculate 'counts_per_uvi' dynamically
Date: Tue, 30 Jul 2024 12:28:19 +0530
Message-ID: <20240730065822.5707-4-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730065822.5707-1-abhashkumarjha123@gmail.com>
References: <20240730065822.5707-1-abhashkumarjha123@gmail.com>
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
 drivers/iio/light/ltr390.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 953c1ed3d..37a017843 100644
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
@@ -120,6 +122,16 @@ static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
 	return 0;
 }
 
+static int ltr390_counts_per_uvi(struct ltr390_data *data)
+{
+	int orig_gain = 18;
+	int orig_int_time = 400;
+	int divisor = orig_gain * orig_int_time;
+	int gain = data->gain;
+
+	return DIV_ROUND_CLOSEST(23 * gain * data->int_time_us, 10 * divisor);
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -164,8 +176,8 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 			if (ret < 0)
 				return ret;
 
-			*val = LTR390_WINDOW_FACTOR;
-			*val2 = LTR390_COUNTS_PER_UVI;
+			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
+			*val2 = ltr390_counts_per_uvi(data);
 			return IIO_VAL_FRACTIONAL;
 
 		case IIO_INTENSITY:
-- 
2.43.0


