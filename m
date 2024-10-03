Return-Path: <linux-iio+bounces-10078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9117598F551
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478AF1F224A1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FEF1ABEB5;
	Thu,  3 Oct 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3Xnzutd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A311A7274;
	Thu,  3 Oct 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976890; cv=none; b=T7xmFgXpUXFmXYkzv+i3wLdKUjXENXNNy/L77RbnH3350b5PGgKSR6qP5qCmhV621lu2/G9V8H7qDRlZAxZf65V+F0+ui+bflKVOnf+IBhlUQl4p1TD42/FSK9aLfSS1aqAMqJCD4Zh6AHedCM5i/eQvAjs7C3YBsW2xhOq+Pxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976890; c=relaxed/simple;
	bh=BwkwfxY7spISjUeG5NWq77uUBqX8tksgbEX8sw7i5ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d9y7AoHcRQcaf61nytpVn/TwGpHACvLkyTZcT9J+9fRdAbjGNau2EXbzHIxvcFrdJUjiiL5JwhLaq9jCoZ9G0G4klXkmOrXRrLq37fSfHj4tbAs3kmkLv9qiLjg1iYniyi6WiUnITUzbnw+1CxpTgh8CFWXUt/gsYSkhhwXRFNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3Xnzutd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so12346805e9.3;
        Thu, 03 Oct 2024 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976887; x=1728581687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIOyU8JZdm9rKnfAkxyj8k3zSsK6gIxY9/0V5bPGqQ4=;
        b=G3Xnzutdafx8jnFfvxpNu6Kh/iq1CabJYgSX4AgI+XQvMmw9FjixZbLEOCJtp+VzsH
         6hPtM3Rmkusgk1Zpxn67DpA0HPST8si4cXzPTyB1ZQlk0GMHSFSPXBTWybZk/Vf50V2i
         xihaffZ3I2RHmT8HNHcqja6ta/dk1Z2/1gRbPYt6J37x+JIGqMwQbKfuDyqJbndiWNwt
         Bx7/VZH0zCAvUgm3AL1+lmZ67hir27rEcnXFIrLKzBLx+ys6gm4R+06YIcHCFcU/Bzdb
         Ua1ByjePsgX/u7Cjy9zx0eLJivRop4iA5aWG9HLCxNrlvxJXEJ5yvfrOZX84atUb/fLr
         K/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976887; x=1728581687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIOyU8JZdm9rKnfAkxyj8k3zSsK6gIxY9/0V5bPGqQ4=;
        b=q85J05AS8ZMargzzFBrVTSwAx1rEbv1hNYONSjrZjlxRwDl4KoNWqx1qhnj6bApz1n
         pzBuC5TzzrrxQWXGK7IG2Rp5Shu+DgQrfOMk4K2/z4oNUwiFtw7DkmwtrHtAvy4SEtH+
         S/85mNftRrK1f6YI2YJJ7O2zm8E354OXl98vdzZCw74HaTmBthBrOdZXOo2peTQXCEOD
         +GROGOBEkRIMnDFDqfak5+pGbtBzNUxH/9UwhdBkUKjrQLZW0XbhoLp772QCYZzQEzBO
         7H/hygU7EcRODux6wSLUcLC0Crh7/sl+zbMFZVgEGrurbkK3nx9hK7A98XIEyU+hMIQH
         gZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCUO76Wy5kUMy/f9j7nTLn8YzQw40yAtkzAsg0gNBYDebGYCwIHGavCJRQDeEJzDtBfWyHQbstJSxOmVMQ==@vger.kernel.org, AJvYcCVG6LSmzv/00pu+iRVUA8hCYGW+V7I9XBblH/EdxAo32TB2AUlcLXgrX/zDnCX1tfUgP+i/USthwrc=@vger.kernel.org, AJvYcCVXki6X6l1yb6+BN/anHWii3XbhmCZPTVe92KtbjgQ/S6vBMHL+he+nluSkGCflUF2Onrj7DEb94/lls/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6QTMjWwB/yW4wTbm5TuIeQUf4RyH3I1vjEhUrWJTO9oAdpZ+P
	Cxf/iPp9RsY1umqemdl6561sV2gKQrWnGXyrPvtFIMaki+wu+oKR
X-Google-Smtp-Source: AGHT+IGJeDpDSVTh17SxMUmozLKr9gKLlqcvFK149kyIL1NXGR4+hoZgtndY8d1QvwOqny1rM2k8DQ==
X-Received: by 2002:a05:600c:138a:b0:42c:b9a5:ebbc with SMTP id 5b1f17b1804b1-42f777c7dd4mr65087785e9.16.1727976887054;
        Thu, 03 Oct 2024 10:34:47 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0822b878sm1713240f8f.44.2024.10.03.10.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:34:46 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Thu, 03 Oct 2024 19:34:09 +0200
Subject: [PATCH 4/7] iio: as73211: copy/release available integration times
 to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-read-avail-release-v1-4-c70cc7d9c2e0@gmail.com>
References: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
In-Reply-To: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
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
 drivers/iio/light/as73211.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index be0068081ebbbb37fdfb252b67a77b302ff725f6..520c898e0ff9c530b4fdd45589559f9014d7992c 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -493,17 +493,33 @@ static int as73211_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec co
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
2.46.2


