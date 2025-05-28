Return-Path: <linux-iio+bounces-19992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C7AC6C58
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 16:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97DF1885CF9
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C428B4F0;
	Wed, 28 May 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvHtFyxd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D84C262A6;
	Wed, 28 May 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444231; cv=none; b=QAS7sSJg21PggXUmQrOkdqvll9b3I9LysskwqkBfJQymqcePXMJEEUc6JlWVRVdndqg3mCe3dAW1E/IxxaTPJ+VjP/8KFpjtBlmGdiTem9vWX6rVsiD2bxQwVmHdyVls2nuLjwn24eHZmMpBn2ys2uLtVRhtd/n71RFUErGM2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444231; c=relaxed/simple;
	bh=fYSEXzep9qNAW+tZfevXnbGSZNZl4/IJ+/Y03cYu2SU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rxtgpqLEbQOlRUK/BSs6vGaGW8YMJ18cG395O/oQ+vJlXdnGkkW3d2TMzTlFoEfnw2GeNDEOGFnFT1H1/RktIqO750KdK1hFbC6dB7V+lypk192oRky15lKaSMymuZcbAveyCLTNFEMmz5k+jFxJ3F3uojPSt2XY8M6RuQjENcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvHtFyxd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23461842024so31678175ad.0;
        Wed, 28 May 2025 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748444229; x=1749049029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I8US3sTh0+kBSZnby04bYDjuKnH/xXT+GECPioOoFDE=;
        b=KvHtFyxdVAMFUXBY816/sLQ6We4l9blERlGgP84jkjKKjaYVC/dqb7qbL1/rl7ets3
         WyBlqi6vkbv4tyOMspyVYCaw8sC0PtUNFvMfMlQLYjD1eOFmT6vU8yEf8Rq/r22da+rc
         eA8b5WgXUmcFR/7/4x9n37A1O4SaC09sVHfBOdtY2op5f7S16p9C/8FE03PuEc1QgrSU
         lETZtgQthVeVe0QA1gxERxl3sj577OWVB5EVqeY5sdg5rTIMxeLr6DS0EQtjne9gE6vu
         qYDl73L5pM8lX/mrxfb87BJzm4y3TP6jL1gAvQnQQqVynxCeYVGkzQNCHdRkt+vGqBbb
         3oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748444229; x=1749049029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8US3sTh0+kBSZnby04bYDjuKnH/xXT+GECPioOoFDE=;
        b=T5c2bDAYNYn9+bQPRPuwglCjDNR4J7Xw+mNfx6m0+2MxS1dT3zyK8tUbnT0u/dlocu
         0aIWvV42JYPCGvY6HpV1ITruU7+17fvfX8DAbBK038V+6GpWHUh7XfHJE2wdOmT7dhFn
         xcLt0XlkjQu+gXat8PXdsfp/O7W8NRC7BsmLvUlIIRxHYu60TtXVtR/NArpO2hjVr1+t
         haW0enKlibw+TOnTwk8a5NvQ2cKwBz/HnXqIQkpehf+/broXLF14acLuC7SLcVUOhg+z
         U6uG3N78dQWwCW29jJRmCVngX2dwV5L9GXCRbEe8mhSTLaq753Z5rB6i3iL5jhIJAzKy
         B2aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh+BxNotGeDEfO3/J6g9DzMK+2ns0HWXe3GNq7o6IRsLoVrcrx4FCNDLADW9VCltNfFkFwwq/lydRqFhg3@vger.kernel.org, AJvYcCXxwTnWe0mmUhekWyL7DwN3+pB6kELq7MNnS6i3wbY2hHKeT1HKmbV+Wc/k/S2HIc3wNNEbxz7LUGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvh6cou/jYf/3RdrS13eXlynYF6OlkFBF+XZyfqOQClK4MylCJ
	2hMmst9AEYdGnDaszxSW83glRus4UYw5chonsN5OONQvJItpAxOdAel5
X-Gm-Gg: ASbGncsBzg0iLt9bVNFT+6GA5l0AlaO0XkT6WpH8VYLhxBT01Qmt8i9s50A8NAIe5BO
	xTYr6E/Au6LtZx6yMOWQ9cailTFXhkDMiMivXkrYRk8A8c9XumdUkMnZpsII/kbPvwL3KNQrj6T
	XeXXAXvVeuiXZHo9qphh1YiEJf+qo5XMBhMEXn5Qsb5YYpHvOYmuY6h1yRqzYleCCIXLsi4ymFC
	EpultbGxsNwooOYey9D52mmKz/ikL6ywddxt1JdRQFzjXbJz7kb3PzDHBUOW2LEGwcieUej39VX
	x5DZaqC9NgAMiM+AeL6WMLHeaz+xl7jhnVoXnXshsLidiAA/7tQMmj2xRA==
X-Google-Smtp-Source: AGHT+IFYgfkU+V2x1lSb+ly5g+ffmCEfXIjRYQUFPHfcfl9PrjKsWhd8y5VfgFaSMK3nsopPkfVglw==
X-Received: by 2002:a17:902:e548:b0:234:8e78:ce8a with SMTP id d9443c01a7336-2348e78cec8mr142986915ad.48.1748444229213;
        Wed, 28 May 2025 07:57:09 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fe1ec1sm12971185ad.61.2025.05.28.07.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 07:57:08 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH v3] iio: trigger: Avoid data race
Date: Wed, 28 May 2025 23:56:48 +0900
Message-ID: <20250528080119.9380-1-gye976@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A data race could occur between `atomic_read()` and `atomic_set()`.
Use `atomic_cmpxchg_relaxed()` to group them atomically.

Previously the main logic was executed when `use_count` was 0.
Now it returns early when `use_count` was not 0.

Fixes: a1a8e1dc111d ("iio:trigger: Fix use_count race condition")
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Changelog:

v3:
 - Add Fixes tag. 
v2:
 - Edit commit message. 
 - Separate variable declaration from logic.
---
 drivers/iio/industrialio-trigger.c | 32 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..fc799910c74d 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -196,15 +196,15 @@ void iio_trigger_poll(struct iio_trigger *trig)
 {
 	int i;
 
-	if (!atomic_read(&trig->use_count)) {
-		atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+	if (atomic_cmpxchg_relaxed(&trig->use_count, 0,
+				   CONFIG_IIO_CONSUMERS_PER_TRIGGER))
+		return;
 
-		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
-			if (trig->subirqs[i].enabled)
-				generic_handle_irq(trig->subirq_base + i);
-			else
-				iio_trigger_notify_done_atomic(trig);
-		}
+	for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+		if (trig->subirqs[i].enabled)
+			generic_handle_irq(trig->subirq_base + i);
+		else
+			iio_trigger_notify_done_atomic(trig);
 	}
 }
 EXPORT_SYMBOL(iio_trigger_poll);
@@ -227,15 +227,15 @@ void iio_trigger_poll_nested(struct iio_trigger *trig)
 {
 	int i;
 
-	if (!atomic_read(&trig->use_count)) {
-		atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+	if (atomic_cmpxchg_relaxed(&trig->use_count, 0,
+				   CONFIG_IIO_CONSUMERS_PER_TRIGGER))
+		return;
 
-		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
-			if (trig->subirqs[i].enabled)
-				handle_nested_irq(trig->subirq_base + i);
-			else
-				iio_trigger_notify_done(trig);
-		}
+	for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+		if (trig->subirqs[i].enabled)
+			handle_nested_irq(trig->subirq_base + i);
+		else
+			iio_trigger_notify_done(trig);
 	}
 }
 EXPORT_SYMBOL(iio_trigger_poll_nested);
-- 
2.43.0


