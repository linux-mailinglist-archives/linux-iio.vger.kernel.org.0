Return-Path: <linux-iio+bounces-10268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9AF99272C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 10:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DC61F20FCF
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDF618C930;
	Mon,  7 Oct 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDJ9YdMp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01FF18C326;
	Mon,  7 Oct 2024 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290286; cv=none; b=A6TmDeoZRJCCd+DgB1yV3b7zs6mFqBaYHCI8Nr87K96ITTQ7UuyXScHh/gHRpRkzeWRyZVU5Riuz/XeQHojiiDxS88ZYvaTjwfhkdrj23dQh8EejUXx213W085/AGbre5K+hIaori8ks/phc2UoDaM0+P1X/gM8Ai6mHC+hB8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290286; c=relaxed/simple;
	bh=dfQ1cow3unMNifLlLnZ2v6pTkxjaTVb2Cs8MDMVYs38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHcg5W7aGIYjNRCgihcG4fxkeaL5JAMsqFmv0HKEcDq4wyKVstWXBQSepW2NkjjMw0ONYCr2gDZvtXHo3pBH4dYUKuNUqJKS98CCHTmVNxQpvip/ulcZafdztSl/UnNJEnvVWqgTpPT6zioPu5LLr3MwJY005N+oWTLl803SCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDJ9YdMp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c8952f7f95so4949851a12.0;
        Mon, 07 Oct 2024 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290283; x=1728895083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Iupx0UMz9bSEUnxJeQl9iuLZkh4H5XILO0ivcFTJMY=;
        b=ZDJ9YdMpe0mBjl1CwtzwgYGRPSzbiyUpNtwBq/LIxeNgloJTqsgcrH3EG4geBnvycO
         X6Kl27lo/MZ84lt+rJtFJkOQpWFV/CNHBkkCxCe8pTa8jccTINIvwA+dNdpJ9TvpppOR
         +m6isui38jIB9wIEKfI4tQ3QBIDP9+O3h0JRXNnKbRRz616mtR9xHKF8k0F/IjMtuZTa
         krSfoPjXrN/a/zI40DNbdio7Z81rbXZXUrWI7tJH8emFBGzVoji+tyrqEdZTx7HM7RzS
         IFU8q5Svh+thr3RUqYcrFHecmpZj5yybKxvHG+TrmXLlLv+xOG/l1Z5yEWzeuOQ15uPF
         0cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290283; x=1728895083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Iupx0UMz9bSEUnxJeQl9iuLZkh4H5XILO0ivcFTJMY=;
        b=qHkuRmwWBTpFNmz7sC+lU1hHvV0OJnnt++gUHFA6t8P8Xlx1RYD1uD6TZNCn3y/F+L
         H84GraE8aC8yTslo00W+PfObfNZzJ4ytrZhBpP3YUgIvjuFuM76mIjH0gIJDZWU/T/v1
         D58Q2HJPCJPQ14BjPqEmaA/HWeAxrWonUo3CkV051ZH9m9OyYyUQ8JxaJpCw8LCFoAQx
         YG4mbN09hTIGbmUCcjMJwRL5O/0HOFXklHUv5LYW/ft7/V+4qf3Nc5fa0IxYdvlKkfe/
         a7V4WCbFHlDunR5y0rpOn6mTbcmua33CHWOw1LO69amPCElhLf84Bo/DC3yEeNNFl7vf
         E5wg==
X-Forwarded-Encrypted: i=1; AJvYcCVS0+r8W7RVLxXhuu+BDHvBElZajv/DQDOj3dJgO230MOUm0LcxNlAyfo7vAxvfJSYhQ2IpiI3/GEs=@vger.kernel.org, AJvYcCWVrRpakMmHkxi+pwdB1vSTCAEth8I4ROgdzp3AuB5+Og1n6lfDv0tbUaMPDaDQMJFylEZN+I0Y/byY1no=@vger.kernel.org, AJvYcCWvUOH4V5Sl1BHYup1v7iiS7cyoaGn9tVLu/ePEF0gzZg6sxQOc4fJrXHjn4E4SuCzmEYLxN4F7YJ1tjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qxJMWz8fKdZLlGu1sR4IhB2NnlXAmuLmXIABHnBWAp5qup80
	fWUijgnYGVFTLL6ln306uAoWWpSMjQnbynkUG8IryIkrI7+SIh7W
X-Google-Smtp-Source: AGHT+IEO6T0vt8G1kvvCGBqXo4YiEkRYS5FqCX1sucevcI/s4sUILTJIb9ajf21mmHsJZu8JoacNeg==
X-Received: by 2002:a17:907:1b98:b0:a99:422a:dee5 with SMTP id a640c23a62f3a-a99422adfffmr406402566b.57.1728290282955;
        Mon, 07 Oct 2024 01:38:02 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99414b675esm272651666b.10.2024.10.07.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:38:02 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 07 Oct 2024 10:37:13 +0200
Subject: [PATCH v2 4/7] iio: as73211: copy/release available integration
 times to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-iio-read-avail-release-v2-4-245002d5869e@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
In-Reply-To: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
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

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/light/as73211.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index be0068081ebbbb37fdfb252b67a77b302ff725f6..27bc8cb791039944662a74fc72f09e2c3642cfa6 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -493,17 +493,32 @@ static int as73211_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec co
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
@@ -699,6 +714,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 static const struct iio_info as73211_info = {
 	.read_raw = as73211_read_raw,
 	.read_avail = as73211_read_avail,
+	.read_avail_release_resource = as73211_read_avail_release_res,
 	.write_raw = as73211_write_raw,
 };
 

-- 
2.46.2


