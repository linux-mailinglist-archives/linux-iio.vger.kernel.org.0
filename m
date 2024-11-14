Return-Path: <linux-iio+bounces-12271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7849C95D4
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8441F22A8F
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0BA1B395F;
	Thu, 14 Nov 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILgxozwh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA831B3933;
	Thu, 14 Nov 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625821; cv=none; b=eRLMbj09nMeQDoqxyB4qWRCu5Aa5zSqw+N4GNq62S2e8hTDyejqt1RxolCDV6epnwPQ7MkxVh7XoFn0EGlKIE+/eouAu46llkb7jJ+RKbgZ/wmbOdbQGkSzEe5veLgIktdqHXHx2a9yB+E0qpAeeypPUlzHYeh2lyBtp3/6SiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625821; c=relaxed/simple;
	bh=L3andXkjRLQymvf8LjCuX+TX6xCi6V06lsEpXcccsP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EUxtAwpHfqBwuX63UXDgG0tfqZoDcW69nFA+l2x3eMq5BfsEhfipSgNinMGoh4yIXZX5jRkh5p0NERg741zuQJb+1ZNesa4ire3GSfaC+Ftzf0PUHhiFeK2UZ6mQ40LG3ObnLmekwf/Q0VfuYd3aaNDPw+Jv3JDbDQCjYmD5MVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILgxozwh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3821b30684cso78814f8f.3;
        Thu, 14 Nov 2024 15:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625818; x=1732230618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNurtUxYaSEIK0NoQH6+V7C+YpTyLjyZoXEozbLOm/g=;
        b=ILgxozwh39N23j7FPEyP5Txxg+ffSMMMfRTy4NouAxa7/t1ZYADuC2BPip6fDwwYsu
         vI4WnrAxyALTojBAfHE/V8Q8eyWgkJupuW/I+W/uvF0pcfQKEd9dDqhgRV7J5Jpy/z7l
         KcbxLMCeoiUntI5u+pe82Fus0h2yNIoq4hJUsE1vwz01GzSKqETtVDOZIFZCFlOglJcO
         bkkJcAsw59h7soxe+L7TZ+jrFiiN5an1usCgodjTRFJCYcuPIJi8f8UYfHcrnPYcXl5g
         neLYHs4+NyIydP+oDiLQVfmxr5dPSEVcWxdh5ocHEVfqr2ENJXpqp7yG6qwKOn+Yi0eA
         jZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625818; x=1732230618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNurtUxYaSEIK0NoQH6+V7C+YpTyLjyZoXEozbLOm/g=;
        b=wE7JKSdE06Sdsv+jj5IvZVSOfBzW0T4PxG5/nq1ByI3mdFRn/aQ8K8+QONEeA4NiEt
         homX3ZA210c5n/ScvxQptPf4kQ3Z5GqIkNEiQ/i2YT8YJuYqTPlzjwHBzE2gqYH8EyUL
         nhBpjDqZxu8LXWa9xICad3MYGJayCJDzipNSCBtlYjs03yVfd1gXWhhdM3uh35Dc5ciQ
         WVw5XIHYxu8yFP+MbdtNDOZ21T2pvnEBYh/dXQK1SaT3x+Vv+r95OgNadbMRrSB6F6ka
         mNGaoH0reN9SzXaYE0qlBLa6UtaLTXpnpLiLAHgA5EPRFKXZ7QVzq5CucLcymHDlc0T4
         fYEg==
X-Forwarded-Encrypted: i=1; AJvYcCUd3NQS86PkBW1krQ0ONsljL/OEz8QIg+flRlX01RfAI5RDRDvcTlNDfOJLt6bG7x0jZVBluy+IFYc=@vger.kernel.org, AJvYcCWeS/OEF/GK2/j56+aVjLOD73Esc8qXSz2B7Was/pWnQtWWQBYeCDdA3BXvzAqvVqjS1mXjDrJRlvdX9FYI@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEF8nqB8E/5E/S0wsnD0f1MusGR035eYf619VAhNNdZauekH+
	SQsELuKb8e2xLz57qBnFWe7xNAhtGlTNj5KLNNyFvb2lKTiDw2PHhuSbbnFR
X-Google-Smtp-Source: AGHT+IFlW1Qx+q9Sg148hCAMvFMzQOQbQcyYnHjdh55F2el8aja+nQrfFWYAQDwNUFM1OGIg33yfhA==
X-Received: by 2002:a05:600c:5117:b0:42c:b8da:c79b with SMTP id 5b1f17b1804b1-432df787865mr1627115e9.5.1731625818548;
        Thu, 14 Nov 2024 15:10:18 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:18 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 04/22] iio: accel: adxl345: rename to adxl34x_channels
Date: Thu, 14 Nov 2024 23:09:44 +0000
Message-Id: <20241114231002.98595-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the "adxl345_channels" to "adxl34x_channels". The driver
supports several Analog accelerometers equally, e.g. adxl346 and
adxl375.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 30896555a4..2b62e79248 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -33,7 +33,7 @@ struct adxl34x_state {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 }
 
-static const struct iio_chan_spec adxl345_channels[] = {
+static const struct iio_chan_spec adxl34x_channels[] = {
 	ADXL345_CHANNEL(0, X),
 	ADXL345_CHANNEL(1, Y),
 	ADXL345_CHANNEL(2, Z),
@@ -203,8 +203,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = adxl345_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
+	indio_dev->channels = adxl34x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl34x_channels);
 
 	if (setup) {
 		/* Perform optional initial bus specific configuration */
-- 
2.39.2


