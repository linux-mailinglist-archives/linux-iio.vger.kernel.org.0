Return-Path: <linux-iio+bounces-25002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFEABD094B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 20:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0EA24E8013
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331EC2F0694;
	Sun, 12 Oct 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZZSpaYH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6582F0686
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292444; cv=none; b=AnLu8DDHY3wTOLGer90ikdv/NDo5EVwjXG5d9L5tvAHNQxjUGIoGxInfDaw2f3rACugNNw8DSrTrvMNngXYtsMdRgqDB7aRdJEyrkKx9UYmCIKgBwdJtjCkfQc2NkHf6SMLGH+evAfEFGg5TUWVXye5fv2jljzRHjVOBEiSTs2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292444; c=relaxed/simple;
	bh=Sjdc9c9cEm/3+y2OeU1XtxmvhRSamRAG9x5dwh7eQPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwaS7jh2y22hhEIJX9J9OZ0WFG49oPyArviQ0dbUuO5DPgGkuCr/sMmXDme2nMQ64NW7Ken2YF4hTlx3uxzHm6hLaTD8luCisy3Urdjd88FC7ZiSVND6fQkEtxZmlKHn0u+fQqdTXXYrFISC2OreTMD3LC/kHK3nF1azQ6Zwji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZZSpaYH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so2959746a12.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292443; x=1760897243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvFPIF9bNuZ+Y63WmDwF6cX3Q3m52XgnHpWvKqcl2nc=;
        b=TZZSpaYHV3fKUQlyXOAKvUWgWpFnoBbJTc/CFrvrihDTuCEo58ZG1uDGeMtOtFiD8T
         Fjoy7DWSfkfEmQJj2inX0XDoRZmhEd8FFJOWCqZktmMesBD/HD1iTYOo/6BQPnA6rkeF
         8V234hPV96vhJo0QU5uIAJ3mOMAUEpd0TgWvG4mw+nMQ+6OKcZsAVg2GPAeAT8oMErNZ
         15hnNEHIdWjLxnJtxUdvDDD4O4rYtx4rtIpNhU0yQ0fBbDiiFYGhPyTce0OQUk24aFfj
         1SXHZCcCm4Trhh4vFglvCLxc37oMCQE7xfs8QQ0+RZQEloDd0i9GuW2g0UlZcD/1wBqo
         GiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292443; x=1760897243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvFPIF9bNuZ+Y63WmDwF6cX3Q3m52XgnHpWvKqcl2nc=;
        b=Ex/rybpKnmRu56Sv99k3XuYjjZxV2KAX4i5yVTLwycfQKyI/pou5fRrFvfo/Hje+da
         +UKwrwMcsy2X/H58GE7g10BKTsY8z3c0dxhHaiKgtpixR09XECAN3VNoMcq/cbBGLvvj
         wGMm/ZimaeZ0B8WR919ZFIjJGhVaWC8ygBKeIEZKn/HkIIicd9t39bqMeNlyUrJqKL2r
         qTxjfb7XuAqdv0SukBHK49+3haEwtiRPamzyEn8RXibuu18Fj8eKrL9imzf3lnoAmO/a
         k1ZsyjtueNyi+C3Bektahdxh+VExvWrKX7J03fmcpoOf409zIMIN8yUiB6jGXmolO758
         UPtg==
X-Forwarded-Encrypted: i=1; AJvYcCUqpxTGE+ND3dxWRQNBnUlww0U/alHOudWenCuPaK7S2thsZYh8zhOR6hNwxDfSLRo101ymVeBNBG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+fMDS06P2UwV9HbBSeqT9WBI5aR9Xp60dSoyoWYGeWPou2fW
	/sRax63cnFgpsoCEE4sHhGm0gYnHEq8d6cFW6ZQq62fLaoA/zqBWDpbu
X-Gm-Gg: ASbGnctRxS1dxXw6sFGD6D7EPGyI5gK9zuNt0jp8kJj67sdvVCdGSA7CyNIYvUR4Y6+
	WzY2tg3xj6Zz+X0Eq43Qh32vlk6I2WzOyfJzUwzUbPgn94aZJPJJFRlTT0R9QreZP8Qju6wIrBl
	tv4iaod1JSNfz01Ho0VQm/btmf0ZOsmFFVOdVR6FAw+dKzzobIqZZsVpYOyLZ7Ye1/w5FGLdZW3
	SfPhSdRnuvazYo+MPPx1r5zyqoAM/Kl8B9rO230MXYoha/+neMESgNR4iUPGfI+SI5Uh53773+B
	7pBAS8nNl5m/AaRlnc5FxEiuEHspTtmw2yIT8vlkvlMnCoSVDUG72iXv/pGEW3DUaJjW/XlbF3N
	JpKxxXeVkFMDuIJx3Y8IXwFR5k360lJaFO/9TArlv8w7G8BDfJ0g=
X-Google-Smtp-Source: AGHT+IHjd0uV1l69LYGgNlNACP9wHZ1xyqkn0ioMIsIHN6ZahZWRdfsUZeTPCLdDDjPYzHZ1l85u/g==
X-Received: by 2002:a17:903:a90:b0:27e:f201:ec90 with SMTP id d9443c01a7336-29027264d78mr240716775ad.25.1760292442924;
        Sun, 12 Oct 2025 11:07:22 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.65.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm111734345ad.104.2025.10.12.11.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:07:22 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] iio: accel: bma400: Rename activity_event_en() to generic_event_en()
Date: Sun, 12 Oct 2025 23:36:12 +0530
Message-ID: <20251012180619.195244-6-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
References: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function activity_event_en() configures the generic interrupts
GEN1 and GEN2, which are used for activity and inactivity detection
as per the datasheet. The existing name is misleading, since the
device also provides activity change and activity recognition
interrupts. Activity change interrupt is not supported yet whereas
Activity recognition interrupt is configured in a different function.

Rename activity_event_en() to generic_event_en() to better reflect its
actual purpose.

No functional changes intended.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index cec59d409531..840c4156ba60 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1190,9 +1190,9 @@ static int bma400_steps_event_enable(struct bma400_data *data, int state)
 	return 0;
 }
 
-static int bma400_activity_event_en(struct bma400_data *data,
-				    enum iio_event_direction dir,
-				    int state)
+static int bma400_generic_event_en(struct bma400_data *data,
+				   enum iio_event_direction dir,
+				   int state)
 {
 	int ret;
 	unsigned int intrmask, regval;
@@ -1337,7 +1337,7 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 		switch (type) {
 		case IIO_EV_TYPE_MAG:
 			mutex_lock(&data->mutex);
-			ret = bma400_activity_event_en(data, dir, state);
+			ret = bma400_generic_event_en(data, dir, state);
 			mutex_unlock(&data->mutex);
 			return ret;
 		case IIO_EV_TYPE_GESTURE:
-- 
2.43.0


