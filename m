Return-Path: <linux-iio+bounces-23936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A0BB518FA
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 16:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021EF5E71D4
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0C7324B11;
	Wed, 10 Sep 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGSfUruM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7532275B;
	Wed, 10 Sep 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513236; cv=none; b=HGycaqbZgpfuRV7iHUBjJZRBZA2PQrRiFqViK+EJoQ+11b/XQONa60DkKwKY3vq0qZh56WMsfl2FQpxphxI6TNzDTLcXLw4Hv/PAXZzkuPy7yZa78eKuJHNOf6hLgGCtuymwsmIb6JPSUlXfLLnGKRCPMlZg5q+ncX0pmZYSVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513236; c=relaxed/simple;
	bh=lvmaiQFLr0ABd5g7S89o8m1cf37Eo0Q5EImIIZQ3zoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ffRTvmDllm7/u34VqcdE/TF7wGZPmAFIHWCoUHDwbsIjmiLNbzZ9RgSyhymgoI7d2zL2cJUbGF8WqnJ9tHvuENzqVArMiQrYGhn66CDl1qxpwbdhxNVBsKS6+iEnZUwMcp1jcPza/8qpAGCzH2ZDykRkrxSODM3YnWlAZyVEDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGSfUruM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-329e1c8e079so6031829a91.2;
        Wed, 10 Sep 2025 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513234; x=1758118034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxX+BuvEDHXlE5TrNWMu3laSkgsysarR5RDUud+sKTQ=;
        b=nGSfUruMJm83i4WKcIZL4CuRLkcHuK7HnrOWmHib6dTzGxOP9rH7DkXUvX+KcqJZhx
         J7oT+ONSTUq2wusRXGtY05vW6pG1J202UlzDGGRU49yRxid+F11zdbUp11xdp7taWHkg
         +0FOdJ4EkaMH9F/GQapXU1pmv5xJzQuLzhmsl6VAIrPXuOoWYPnuM6EBhqiQDiW+2pdM
         Nn5aUKfJwGy8ih/Jn0F1rYR8OySppdVLvnE772KJt6btWR9//S/g/4c9V6paBHeNeGQ9
         svtiNUDZvjMYSQganh32zmLRdDAZEBYnT0Qsh1Wqd4pxQH1AA69QECTTnsbuumjlSnAs
         aMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513234; x=1758118034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxX+BuvEDHXlE5TrNWMu3laSkgsysarR5RDUud+sKTQ=;
        b=LzSdC6PKXftfbU5DPBoEahdab8KcU+waIMG3woOj/ZhkQeSTlfZbKbcyCBvSjXEM8f
         xfa1WwexUj0qu22ge9jBrsJ6roKJRcVw7qCrazY7BshWYip3QuESjCSQVjGkMpdgQhc9
         BxJEkGKeXpoXEh9WdkXhAyF8KZ1+8Bb+e2p3icLH/2ZuR6oZed22sS82djl9H2fXpKPF
         vNjvgLWWo7J7rNUnNGBz1uaDjR9B8bIUJp8XMrqzB1uN6mLXa4bSqLpB5nwloWk8JpZJ
         Muv1dE5gGXs1APtUsbfO3irf27UA66XzrHcr3mo2d8KbA7wUV+2JA8Krxb4vx9QGawUo
         lciA==
X-Forwarded-Encrypted: i=1; AJvYcCVt6r+WHivrQHXVe9kehuo/eAVs3uGksbgRhhIuuMNwidQNzrIs/15tVbOw32FSwfhxCdFO4PLJJT7jgB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybvdRd4sTuX55s31N1fBuuQlbMJT6ErB3E74BxsBYLM2+/yZzC
	2ynjU8dVpb5kdFR8uONmGwg3eIMTAsFqA5n1Om9lybQ6Nu5GQtKSELbYV+d+kyQY
X-Gm-Gg: ASbGncu0+9ymTW7t8YK+r3sxb3CE8LQNHAjmXzY+/fXNyw7kLx+snmdPoqvUYbHlKhD
	4VNWRPMAwEh5MQk5bu+TkL4RwHR5H30v9DCg42S3jOcH+W00Ap5+x/hyJJLP+vH5Dw/74lSLJ6c
	EVWNbqFSjTwesvOKKqs0ZDcJ9oAzrU5BuR1csY6Yhj0N9iD8GiDsRMBimM7fRjTwFWQf4S5x3eG
	5Xa1oKIbVGQKvWlh3388+m2YiqEcsRSz9kyxH/Ndn8loYURUqOS3X3QixZiJApnCZHrcnI+YWCx
	+SXBq8syMYbkptaMYby2QTAriI6EP+zPB/o6U5rBDPm1sRbC6m797wRzxBnAR3g/2sU10+6Bspt
	5UtZFqNYZWB8WNLDq+0BGgqj96F9KCG8uDd96zUU=
X-Google-Smtp-Source: AGHT+IHIqEESzD6/k5v3FeDlDYiTFI7f9ozWJB1i5x7UWTRXVCMLGqD5DvABMWNMo5iC1ZJYqMkG1Q==
X-Received: by 2002:a17:90b:1343:b0:32b:58d4:e9d0 with SMTP id 98e67ed59e1d1-32d43f98ca9mr20568132a91.23.1757513234192;
        Wed, 10 Sep 2025 07:07:14 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:73ce:c1b3:ae9:98ce:970])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb2f54acsm2760204a91.2.2025.09.10.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:07:13 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Wed, 10 Sep 2025 19:36:49 +0530
Subject: [PATCH 1/2] iio: magnetometer: als31300: remove unused
 IIO_CHAN_INFO_PROCESSED handling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-iio_chan_617_rc5-v1-1-924091d374be@gmail.com>
References: <20250910-iio_chan_617_rc5-v1-0-924091d374be@gmail.com>
In-Reply-To: <20250910-iio_chan_617_rc5-v1-0-924091d374be@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Gerald Loacker <gerald.loacker@wolfvision.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757513227; l=827;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=lvmaiQFLr0ABd5g7S89o8m1cf37Eo0Q5EImIIZQ3zoM=;
 b=QeeBKawh/ZDBx5Osyy7yryc5HeS9OR5zrhFDFsCk4/eWQBXo5RJb7oqKDBJvAwgy6viufx02A
 aYN0zPzfVSkASGFMntJegf0SyAhwE4O4zfKf8+JzB15FATsmWSo26Fh
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The als31300 driver does not advertise IIO_CHAN_INFO_PROCESSED in its
info_mask_* fields, so the corresponding case in read_raw() is never used.
Drop the dead code to reduce unnecessary branches and improve clarity.

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/magnetometer/als31300.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/als31300.c b/drivers/iio/magnetometer/als31300.c
index f72af829715f..6edc84378ff3 100644
--- a/drivers/iio/magnetometer/als31300.c
+++ b/drivers/iio/magnetometer/als31300.c
@@ -156,7 +156,6 @@ static int als31300_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW:
 		ret = als31300_get_measure(data, &t, &x, &y, &z);
 		if (ret)

-- 
2.43.0


