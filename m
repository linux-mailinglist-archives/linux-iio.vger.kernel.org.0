Return-Path: <linux-iio+bounces-12669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A49D8EE0
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 00:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94D3B2854E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 23:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395BF1925AD;
	Mon, 25 Nov 2024 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmLwbmiG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1E1E480;
	Mon, 25 Nov 2024 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732575810; cv=none; b=Gvm+LQ2ShWlJ0lsq6pBn9qdIuDU+PnG6jeR5nPaIHp/6xtfDAU8BVA+sLNokfBRQ1PNWUoxUSKPFaca+F3nVdBQMuUZhwfieSdpEFcba0+Jmr1otQRtxNcjB9C435u4KK9aeRruQCZEJlfnFTAyqyIzTA1rpS0moPblTwTsF2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732575810; c=relaxed/simple;
	bh=BTgCLY4gPo5YU7+/1T0opHXi45vHwObPtguryl+EQn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pJp62v83hCw+G4RF0lprVZmKHz+CqwrY/YOkBTYj7TYw3Ebf8xuy1Yi/Yl0FvHqvbp+KT4UNt3HSpqq2Ftzlp6FfFfC7FKqqvMOB3km27cZv0U5MuoEhODVEXbxRZTV1tv/S/xlHiq2gUjoOSIa7JOLXxnOfA08efcQFr36/zlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmLwbmiG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724fc1aaa91so2040435b3a.3;
        Mon, 25 Nov 2024 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732575808; x=1733180608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuBQyBjyiv7huPo6jrNQOgiInPpnVquxsBmCx5xtbh4=;
        b=TmLwbmiGZC3A1iN9tV0HUEGBY83mEffWUuxWXXElheJwTSluPrLcrpZAHbc0yiOK+5
         GEi5xfCr0lLKNM+qj0agWNCoj3XaWwXvzaW5UTqzAhDFUxE2GT5rfTDb7gvcRZDC5jVH
         6+bpYOyOgC7U3fH1IbQ5EoA1QBmVTVPuyVFPMlgCV5sf84wRbd4eX6W1dJyJSlvQwEtE
         PhiBh1InU9uLVImX/SjWGewOoKUgAfRT6eU7S5y2bOrFYHsFoO6YxJR89bsV5gK5XYsh
         XsN+RZTnT9UWdNPzIKeyLrQp7YRwuvwDXEjyTS65zCeYnWO0BztJCIOgiGJBIrkW7sFi
         aBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732575808; x=1733180608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuBQyBjyiv7huPo6jrNQOgiInPpnVquxsBmCx5xtbh4=;
        b=lqbP7m9BQuA7eC4Rzvi7j8TxjjIq9TG6Xo6ueYXJ30xy1+NGl50G/IT7Zll8zgRkLv
         XFsp20+LyKLvkU3OavJqjFf07qDw3NgNT+GepKDYXX1+zvYlUfOLepR5WjK7RKiRXxJI
         I5F8vgSahtA9wlfoZnfGYPnjuUdeYsT2cMh8WaTyT7CMm2RxfXIhNIexD7IttlKQP+HT
         PcVIU4U4SPRnmicoVW1j4QGoIE8ZedmYb3guuTVyXJwT+PQTnkf5lp8ylgOarD3hqp3v
         27GOpkGqiYuL7eZSwg8icDS6YOrvNvewG3esfcc5D5zfbX284ffdLqv26dd4sxEbWdwi
         3hYw==
X-Forwarded-Encrypted: i=1; AJvYcCUWEvRJjAT8xMJkazsVazVTgd619gQpH1jrKHZjW3FvCDAY8mCnNmetzjcQhejd5f7pmbi15L1PNbo=@vger.kernel.org, AJvYcCXIYX6R94B0c+IolssxRYeYXDYdqR1oSTQZksAwnzA+w3Ac4EZB5V4kIEOBRjs1+f+rKf30xD30lqGJ1h78@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Zu/YynrVTYNLcO38WEb3LgLekt/kF0Pf/60q6lHQLfCiv1Gj
	1hy9AaS6UYgVnSinFJ5u2nQV4SeQPqiImZNUBCONRG7vI2vFWYsS3YjlICHA
X-Gm-Gg: ASbGnct9OY7Kq7j6jpxN0y6L4r1oOss7avPSz8ff8Y1kb8g9bviv0XKAdJVLddnKlmu
	5+hkfObdz/20f/Vg3HuJX4gDst4mGQ9nHNJZCGdY5oRhBuLtMLvp2DQaqEwh2DdDzCvmUuTdHRy
	W822xpRATIDv5A0dJMVDfQRmopXvDgcwHE5tMG7lEKkw+Yln/nIhBfuWsSAHrPka2E07UJ+PsEa
	OUlZHyDjw7W6zlw+o/Elyl3WOVwQp/e0EwFLmAAvUiAEvDlBURVAGWnQnX8dANAYeHs5g==
X-Google-Smtp-Source: AGHT+IG6AXPDCYJGJA9eS6z8KHwouPg9F8SAnH5vC/g4EXpThiKCm0nwTPWcfl5V9ZtwDkBTENhzhQ==
X-Received: by 2002:a17:90b:3889:b0:2ea:735d:91e1 with SMTP id 98e67ed59e1d1-2eb0e3314e8mr18190853a91.19.1732575807722;
        Mon, 25 Nov 2024 15:03:27 -0800 (PST)
Received: from localhost.localdomain ([177.10.12.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff70c1sm7392871a91.15.2024.11.25.15.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 15:03:27 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: wbg@kernel.org
Cc: david@lechnology.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Subject: [PATCH] counter: add COUNTER_FUNCTION_DISABLE for energy saving
Date: Mon, 25 Nov 2024 20:02:20 -0300
Message-Id: <20241125230220.9994-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add `COUNTER_FUNCTION_DISABLE` to the `counter_function` enum in the
counter API. This allows file operations to signal other drivers to
disable hardware resources, reducing energy consumption in
power-sensitive scenarios.

Previously, tests with Texas Instruments' eQEP modules revealed that
hardware resources remained active unless the driver was removed,
offering no user command to stop the count. This approach exposed the
fragility of these resources.

To address this, introduce a new enum option in the counter API to
receive commands for disabling the hardware. This ensures the hardware
enters an idle, power-saving state when not in use.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 include/uapi/linux/counter.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index 008a691c254b..6f9a6ef878cf 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -145,6 +145,7 @@ enum counter_function {
 	COUNTER_FUNCTION_QUADRATURE_X2_A,
 	COUNTER_FUNCTION_QUADRATURE_X2_B,
 	COUNTER_FUNCTION_QUADRATURE_X4,
+	COUNTER_FUNCTION_DISABLE,
 };
 
 /* Signal values */
-- 
2.25.1


