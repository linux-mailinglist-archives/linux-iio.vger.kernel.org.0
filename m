Return-Path: <linux-iio+bounces-10872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321EA9A6944
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504801C21EFE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92191F8F12;
	Mon, 21 Oct 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM/A38b7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1D1F8921;
	Mon, 21 Oct 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515394; cv=none; b=ou0h2TMBOaIYUtfaqq7ZfoB2go2mAzGaAm1KHY8NLPsiWseRMZdRs8EojV7VFV7zItawnP3D0yn6l1c+BLkzA7J3COb9R0ZWW/JA27MP0UJe+8DZKO2hEgFc4c5NlCUvcL5Kq+bbFfTiNmBCwdfOOsSaUURrZa79dyFK6AmiYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515394; c=relaxed/simple;
	bh=UzaA2fjWs1SIl19H07gMaVFNLQFaYamk7HcjjWTA/c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/s6QgFnYg1wvFZGLyRYiN2CvkoWcjumbPMvjs5ZMPisrQJye3yozTJ32hsulvfLI4umnO5sVOswrkwEntd9SyUVPQoocVsQA2yU2FiZxRbBpSw6OGGjx0vv+EjaAShnQAxAm/lw/u7HwnKLaQUkG6GPlpAOyM8Q105pDx6ijnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM/A38b7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d5aedd177so3744696f8f.1;
        Mon, 21 Oct 2024 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515390; x=1730120190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiiDyZUCEkhw54V+Qb4R9KaSMKdtWRNhFaEC6pW+G7o=;
        b=eM/A38b7vNsFEQz0s9vWyA8xM4evmOaWa93LyGMJMpiJ6BsI/LjJoNmOcjrQDS686U
         40it7TqiT4IE3dVEn6+jtHMbdGC5kjOjckfCXWHR/YhaVIW7NHQL4jmsdY2hisj8nN8S
         OsLPyohtnl4pgZakxh6GaMje9mwt5YJJqIWNTBQdoQ46/HmCRw68Jj6ewQIqxfCVZ8b3
         ci5TEZynyPjZEAiNb5cyjtsmwnqFmmzoRS8+vDiKT6u4SCU2Q90XHclpSL0wFFi3ilDV
         SsP2MLoL+3EB3LAaqUJrYeiA414bqay7dt2zMt0kS6QfZVQ8btQPziNZVMry9MZgoPtE
         /CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515390; x=1730120190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiiDyZUCEkhw54V+Qb4R9KaSMKdtWRNhFaEC6pW+G7o=;
        b=n6d3GlFJrz6a0UwAH4HYXNSo+9NE/OtSZDohqbPWDjJhR/gca9/7DiAZ84YgUbrLL8
         A0BvI3FC6Rv/Qq4mh7MaSx7/lNlc/oGEcTf2wr1Nc5ffYKKOwVGXavHyA19YkuLZfeTM
         q3JYqjPITBdkowxQabR38XD11IrFV1/PKtSZPLoBTmJ0UUPP2lfYOzy+dd1KmtEqUqfn
         xLd8S4eH3xih2FtYZpA/MnyGbRUgbwD308HBzxRKVwc/cyfEJ5wYYpmaO5Mt6vNESyg4
         8oNZCpI3tv5Rr8DrAPUbFxhkTzRCRkxAzgsSidNaGWWvViTz6eWvxhYh4Q61AElLP0Xw
         Rc3w==
X-Forwarded-Encrypted: i=1; AJvYcCVsiqqks2eJFfI9skDptvRfooPdgQRobeWG4Vd8jor5/TJ1+2SuVJ9yXAexAUCfkOxspQ2U+WQt5ixrOBM=@vger.kernel.org, AJvYcCX+St39mRiaauRMQnNKgK5kAEdV7O4sNWrZNZuNfwhfCbPlWMrQv3+J3OZST/rUXhtB5raLIhFS75K0VQ==@vger.kernel.org, AJvYcCXFRjHE8ICG99RkEvYxwX15kcMF6pLSSB7A2DhD38/jBVJ2R2LBSh5D1WB7hwsXMvrvjmL0lmfE7UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTU0Ydgz3TTsKx/DBnVQBjGP6YlPvxNyZKYM9kkI1forK4Yot
	kNTxJqyy8YIt861+P+Sej7p19YVoswGGVX52isZI0PE6WGIRaUoQlLKjcvfS
X-Google-Smtp-Source: AGHT+IF+Pj3QHFtGd3jCzAfHaNNFO/gXUtmbtgJxh6gwBbuJjmeaOpO9u+Xq0MtpxYE2e+EQVtkFHQ==
X-Received: by 2002:adf:b112:0:b0:37c:cd0d:3437 with SMTP id ffacd0b85a97d-37eab73cf70mr5825218f8f.58.1729515390426;
        Mon, 21 Oct 2024 05:56:30 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9cd48sm4275204f8f.111.2024.10.21.05.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:56:30 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 21 Oct 2024 14:54:18 +0200
Subject: [PATCH v5 5/5] iio: as73211: copy/release available integration
 times to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-iio-read-avail-release-v5-5-b168713fab33@gmail.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
In-Reply-To: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

While available integration times are being printed to sysfs by iio core
(iio_read_channel_info_avail), the sampling frequency might be changed.
This could cause the buffer shared with iio core to be corrupted. To
prevent it, make a copy of the integration times buffer and free it in
the read_avail_release_resource callback.

Tested-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/light/as73211.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index be0068081ebbbb37fdfb252b67a77b302ff725f6..c4c94873e6a1cc926cfb724d906b07222773c43f 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -108,7 +108,8 @@ struct as73211_spec_dev_data {
  * @creg1:  Cached Configuration Register 1.
  * @creg2:  Cached Configuration Register 2.
  * @creg3:  Cached Configuration Register 3.
- * @mutex:  Keeps cached registers in sync with the device.
+ * @mutex:  Keeps cached registers in sync with the device and protects
+ *          int_time_avail concurrent access for updating and reading.
  * @completion: Completion to wait for interrupt.
  * @int_time_avail: Available integration times (depend on sampling frequency).
  * @spec_dev: device-specific configuration.
@@ -493,17 +494,32 @@ static int as73211_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec co
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 
-	case IIO_CHAN_INFO_INT_TIME:
+	case IIO_CHAN_INFO_INT_TIME: {
 		*length = ARRAY_SIZE(data->int_time_avail);
-		*vals = data->int_time_avail;
 		*type = IIO_VAL_INT_PLUS_MICRO;
-		return IIO_AVAIL_LIST;
 
+		guard(mutex)(&data->mutex);
+
+		*vals = kmemdup_array(data->int_time_avail, *length,
+				      sizeof(int), GFP_KERNEL);
+		if (!*vals)
+			return -ENOMEM;
+
+		return IIO_AVAIL_LIST;
+	}
 	default:
 		return -EINVAL;
 	}
 }
 
+static void as73211_read_avail_release_res(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   const int *vals, long mask)
+{
+	if (mask == IIO_CHAN_INFO_INT_TIME)
+		kfree(vals);
+}
+
 static int _as73211_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan __always_unused,
 			       int val, int val2, long mask)
@@ -699,6 +715,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 static const struct iio_info as73211_info = {
 	.read_raw = as73211_read_raw,
 	.read_avail = as73211_read_avail,
+	.read_avail_release_resource = as73211_read_avail_release_res,
 	.write_raw = as73211_write_raw,
 };
 

-- 
2.47.0


