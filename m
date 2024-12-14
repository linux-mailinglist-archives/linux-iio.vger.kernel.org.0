Return-Path: <linux-iio+bounces-13479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FF59F2098
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 20:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C504167BD1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 19:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412EA1B4123;
	Sat, 14 Dec 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLPPLHOp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF021B2180;
	Sat, 14 Dec 2024 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203674; cv=none; b=XIMsr2++nJegviOaICcVJESeoMSaFConhRNpda6Q+2CkyUso8ato9w/+OPuYZQ+nvV6wAr3i9oMUDrOEyypP8Mty73OMi82Bvj9k26WZzEmsB0JSAKqvYWMtyfq0GVA0UjZVJC5FvDE8N6mxLLjGyrYZeuEYicdUGnj9/Eo6taI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203674; c=relaxed/simple;
	bh=hwJ7g5Qp2RYDm7YSTNB5S2KOZXblWfiTufqQlCHXLeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNzw7YrTQ9PigxhVif3pydKVaqpkmPeRU3M9+GV4UXTtYM623MFCxKTqjSeKK6g0719ZN6cH+G1GYo6Hw0UZXUuPc7uPBH6KKA2xo7+pBdR1Q4xf5mKmj3QZtLr0brYuLG6dJDdqNluhK4OWRoTZ5+hHWk9h+dU9b298zd7UnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLPPLHOp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso4516882a12.0;
        Sat, 14 Dec 2024 11:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734203671; x=1734808471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EByrdtVQZYuV+5Drqauo7ZU8zZ2F3oVsb8nD9rm3sk8=;
        b=TLPPLHOpAAJkaFCdiU5AJhIyZtBSQmpw6ztBMqjofNSgpznBj0EPuIP+832J9rlq/q
         llZJDraoYO0/V6+va45aHdzSkQPbfO7eoBLwbdW5j1JyigfxbB8QIxg5AZWRI8EX+Eyp
         NswhMg5zvxx7E7IosxH6JkkLmafirHI+442FrHomujf7KgzclUk1HynvQeuq/K6WxO8x
         EIGuVNP5PDA9MDBXrOZJ8HSDXogpAfQrH9c4rDa6QdQvYOcisgwGoRP9ska/s+03bvCY
         4uYq0spz73eP7fRsBYuoWE7TJAx/yiA8mtjyg8uc3emlcZzyY54Zt3Eoy7sbVL8lw5T/
         6A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734203671; x=1734808471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EByrdtVQZYuV+5Drqauo7ZU8zZ2F3oVsb8nD9rm3sk8=;
        b=U+/ALAxetg2sJjQV2Z+gmQ23SlJ9T4Q2T9gk5JAwuwRJS6MtUUoFyjfOZc7kAV+etR
         al5lrAqg6OJwgiig97YJVxH5JSdEvh7mkbaEW2Oc/nrjugoUvvdRGHQbJ48BQEJjxrZz
         EXgi3TKq7tasufn9iUYgjcUFMbkZwfxlNxF+rSew9MpjtPIRN8nuTUQdmku3GgBGsCEi
         g+I1eOZpKQTU7LuMaI8SguNL1UIl2L+T/+F/yqmuP+1ny7dXmRkzOzOzxqiWO+5/F90c
         +1pEspa1QsVM5yi3bXIyonreh0XKpab9myiGcH7xgoxR79doSFnZfUkXN7gOWNjYcyxL
         VtoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfcD+UzeXkXgUJR0NjtqA2NQi3sR4lpwrOByC3ShEIfDIMejA2G77Cl7MYrtiYg0wkCYh4Zp6YZj7iQMEC@vger.kernel.org, AJvYcCW8NyX5SDCGZTJNfwwFsEsfrGQhdC7rrkkctKJY22XSbh86uDH8TXhugG9BzeOr4xr4vVPfAGv7Bto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRr1VMnUsPeBsScWo6UPARdKiSFXS7uXUdHRryQUhjvD986IRB
	BPkmT730ZnvaaT7ijCn580n5Au5zqXp0umnOuhtz4n8/8FDAPOfS
X-Gm-Gg: ASbGnctxW9fMv1ORqTn3I0qMCUE0rvR1qDSjPI8uS0HfaJl+igTNv2R4CzN84FhZ8Cb
	fFdYmvppSkDZVGa7LNRtkmUFMq04zPSqYsn5mWS9gSo0DlF/uKnKP1WOJd0FlmXSZrr7JG6wBX7
	znbojRGTt17YTsdcvupBkPUp2PNSijZfi3pWyOdPGGyKqaJpkNB7vceCGZlTddA/kLa07z05m9H
	I718TQrmG03LRt08bt1XTzhdFf5V3+8ap9XuCuaE/wUHOZh539ekrnsoz/Prdj+hORYsQ==
X-Google-Smtp-Source: AGHT+IHFL+bYnOYz8jFHG0mNxTg+1Mi/aJXuva23CyBnKKVieqWxlldrLG5HeM59bEEJw5gz+++0sA==
X-Received: by 2002:a17:906:328d:b0:aa6:6e41:ea55 with SMTP id a640c23a62f3a-aab778be635mr626347666b.7.1734203670416;
        Sat, 14 Dec 2024 11:14:30 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:abde:dd08:a767:d63c])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab963c54d2sm122818766b.190.2024.12.14.11.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 11:14:30 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com,
	jstephan@baylibre.com,
	dlechner@baylibre.com,
	jackoalan@gmail.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v2 4/4] iio: core: mark scan_timestamp as __private
Date: Sat, 14 Dec 2024 20:14:21 +0100
Message-ID: <20241214191421.94172-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214191421.94172-1-vassilisamir@gmail.com>
References: <20241214191421.94172-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since there are no more direct accesses to the indio_dev->scan_timestamp
value, it can be marked as __private and use the macro ACCESS_PRIVATE()
in order to access it. Like this, static checkers will be able to inform
in case someone tries to either write to the value, or read its value
directly.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 include/linux/iio/buffer.h        | 2 +-
 include/linux/iio/iio.h           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2708f87df719..a80f7cc25a27 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1137,7 +1137,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	int ret;
 
 	indio_dev->active_scan_mask = config->scan_mask;
-	indio_dev->scan_timestamp = config->scan_timestamp;
+	ACCESS_PRIVATE(indio_dev, scan_timestamp) = config->scan_timestamp;
 	indio_dev->scan_bytes = config->scan_bytes;
 	iio_dev_opaque->currentmode = config->mode;
 
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 418b1307d3f2..3b8d618bb3df 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -37,7 +37,7 @@ int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
 static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	void *data, int64_t timestamp)
 {
-	if (indio_dev->scan_timestamp) {
+	if (ACCESS_PRIVATE(indio_dev, scan_timestamp)) {
 		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
 		((int64_t *)data)[ts_offset] = timestamp;
 	}
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index ae65890d4567..56161e02f002 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -611,7 +611,7 @@ struct iio_dev {
 	const unsigned long		*available_scan_masks;
 	unsigned int			__private masklength;
 	const unsigned long		*active_scan_mask;
-	bool				scan_timestamp;
+	bool				__private scan_timestamp;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
 	struct iio_poll_func		*pollfunc_event;
-- 
2.43.0


