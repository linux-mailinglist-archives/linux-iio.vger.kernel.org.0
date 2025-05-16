Return-Path: <linux-iio+bounces-19608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C019CABA1F4
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 19:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432093AFF19
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0BB272E75;
	Fri, 16 May 2025 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW0zoTKa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653651B6D06;
	Fri, 16 May 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417177; cv=none; b=nqAX5oAhJbXj4z9kvwZyixUhi4cco6VG/U6eh0e7snj+XbVHIhBbY1AuzAckAP3jjnmTF17d16ec6nPTaf5Nq+LWsRAc+5NrMcON2AN2jGU25iPhp1bWK8u5PUiSxuRvLW13N6xq8+3UsAhybBQdNA4fjVfoor+ona9DrZlxQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417177; c=relaxed/simple;
	bh=WDdPGE1tx7zFa3oY8p0WMBEndLrGqhxdotyVFqZbT1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KljsG7qc85lR2+B9Rw00j+SLHnUsUsKK42dD8g8o5/xgtkitOYCz7JKxSFh67UeB+IxvyhmBjhFlhnI5wq2NATwRh0wjxJtjETOa1+wbBTOAqIJ3dFyh5YL5YwTgi0zpPU84XqxTLkcR6dcbzM3JWyQ7XGWFGjvz4RTzzwHkckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW0zoTKa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376e311086so3053365b3a.3;
        Fri, 16 May 2025 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747417176; x=1748021976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUyg69EOHmn6fJiFyTXvge1NaO+118fhYY4ZNlkwbEk=;
        b=MW0zoTKakArFtHr9hfMStuVYUjpj0oKQFiM0jhtl5gVrrpTQhAGHecyD/i3G89bqsw
         uNIqpijRd8QR+W3eERLo2XqZiztCgpNdSca9kGl0pcNcPlx0WLrUx3oYYY53/Yc+hTX8
         BwpYPtDpU78uohiNbpTg3xZ/QcG2yPFO1jcPytRNw8QOwRzNn/Zwh3HWiaH9izhHQI5r
         GjJJsYKIBBsMOy7evCY6qfW3eokXgERuL93v4gwqPhlZAOevW1XF0qJGRZWICe1AQM8g
         hnslSfeBc9jHTuRiyiy5rzwC9m+iwbzU8uFg1wc4sX62d16yMgSZOuL4zKBQ6G/pOJNz
         dhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417176; x=1748021976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUyg69EOHmn6fJiFyTXvge1NaO+118fhYY4ZNlkwbEk=;
        b=hmK0zYV2LFLCUXAJN5xZ7YTLWF/xzVhnft5kEej2j1FDKaWYF5uev0iYjyUzTmhydc
         jIAOakPXJ4XlKQnwiHLvNxrjIhjcTKeO7snXzMxE5tX8qrs0s0g/5vbTzSecadC4DgrK
         IsY4nIQ/C0bsk5rNOHSXVtBVrBrkrpaL1zzfYmppLerylMiWht7KmakpQzms7zDqh7MH
         2LRad+yxUe0NVpAPhBtrVIUf80uYw9Ep6nLFQukraTdGrDFJi6oGEZhvp5FDIGZqtlqR
         i+T4iB7B0Vz9QsnVAFS+Eq607JuX4tRAcH+kJy3nCmHKFKICasT2CRIBuRyslYmgY1fF
         GPhg==
X-Forwarded-Encrypted: i=1; AJvYcCUM5YgrbCmj4wT0kDCY4nt9czm5anuKQeFVZYR6kTLl/EeGFLr521exNjfG4PP7RjcfEvqCeZL/@vger.kernel.org, AJvYcCWqpu6blMjJEy6pDCbortUQyN8gAs+0SblGQqdrAtZAxS7LVq3Cvuu8F4FwJpQhrwuO97XZGe6dlzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzDqeafhulRhYn/tjRNYOuoWIWHwHTMNJBPDH/7XjZDcMj9K6Q
	DTRna6KzJrWXmK9KfZpf5cc2xOf66U8c1UBwpA6yaPxjE28DGI6FjjUjdkBhLg==
X-Gm-Gg: ASbGncvnHA9TvEVZV9FYBpyDhIEexnJxEXKIfg/8hJq+JKIGRIw0YDqJeO3FBw38mMO
	0w2/GwNsJcx19x2jx0AdVZUo1HnuMmVCcuQhVatR3Uy4X83ClaIvueiNlWkBuBHoY/O8eiZ9vY1
	YLqvVOV5R6tLketjHftG+ieP/h+uyButxOWYpyFJKeOBeDTsGvtDvOGPzZbE0vcTH1Lg+Jdw8bA
	k2WPrWUwtuLRU1bgrbovtYxgZelxMCCwSIhNeANsBvUQTt0PCMFyO0bjbwwhlavkvR0nPzXhh/7
	RA7TTxa1RFTbj6HhVj2Y+A0/+l2E9HX7t4FU7KhDiFsVUthCitFZH78HGZTe/OocOg==
X-Google-Smtp-Source: AGHT+IFZDZYwFZRSdLZjqfMP/kkLuxCVQkmAplhy3X6kvwKvhiHz+L/86zArnCj0gjdgwWQpt4AEDg==
X-Received: by 2002:a05:6300:218b:b0:216:1ea0:a51a with SMTP id adf61e73a8af0-216219fffedmr6033763637.38.1747417175634;
        Fri, 16 May 2025 10:39:35 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:93a1:94a9:517a:f69c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970c85dsm1842201b3a.61.2025.05.16.10.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:39:35 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: max1363: Reorder mode_list[] entries
Date: Fri, 16 May 2025 14:39:00 -0300
Message-Id: <20250516173900.677821-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516173900.677821-1-festevam@gmail.com>
References: <20250516173900.677821-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

The IIO core issues warnings when a scan mask is a subset of a previous
entry in the available_scan_masks array.

On a board using a MAX11601, the following warning is observed:

max1363 1-0064: available_scan_mask 7 subset of 6. Never used

This occurs because the entries in the max11607_mode_list[] array are not
ordered correctly. To fix this, reorder the entries so that no scan mask is
a subset of an earlier one.

While at it, reorder the mode_list[] arrays for other supported chips as
well, to prevent similar warnings on different variants.

Cc: stable@vger.kernel.org
Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Also reorder other mode_list entries. (Jonathan)

 drivers/iio/adc/max1363.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index bc44b4604ef4..9dd547e62b6c 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -532,23 +532,23 @@ static const struct iio_chan_spec max1363_channels[] =
 /* Applies to max1236, max1237 */
 static const enum max1363_modes max1236_mode_list[] = {
 	_s0, _s1, _s2, _s3,
-	s0to1, s0to2, s0to3,
+	s0to1, s0to2, s2to3, s0to3,
 	d0m1, d2m3, d1m0, d3m2,
 	d0m1to2m3, d1m0to3m2,
-	s2to3,
 };
 
 /* Applies to max1238, max1239 */
 static const enum max1363_modes max1238_mode_list[] = {
 	_s0, _s1, _s2, _s3, _s4, _s5, _s6, _s7, _s8, _s9, _s10, _s11,
 	s0to1, s0to2, s0to3, s0to4, s0to5, s0to6,
+	s6to7, s6to8, s6to9, s6to10, s6to11,
 	s0to7, s0to8, s0to9, s0to10, s0to11,
 	d0m1, d2m3, d4m5, d6m7, d8m9, d10m11,
 	d1m0, d3m2, d5m4, d7m6, d9m8, d11m10,
-	d0m1to2m3, d0m1to4m5, d0m1to6m7, d0m1to8m9, d0m1to10m11,
-	d1m0to3m2, d1m0to5m4, d1m0to7m6, d1m0to9m8, d1m0to11m10,
-	s6to7, s6to8, s6to9, s6to10, s6to11,
-	d6m7to8m9, d6m7to10m11, d7m6to9m8, d7m6to11m10,
+	d0m1to2m3, d0m1to4m5, d0m1to6m7, d6m7to8m9,
+	d0m1to8m9, d6m7to10m11, d0m1to10m11, d1m0to3m2,
+	d1m0to5m4, d1m0to7m6, d7m6to9m8, d1m0to9m8,
+	d7m6to11m10, d1m0to11m10,
 };
 
 #define MAX1363_12X_CHANS(bits) {				\
@@ -584,16 +584,15 @@ static const struct iio_chan_spec max1238_channels[] = MAX1363_12X_CHANS(12);
 
 static const enum max1363_modes max11607_mode_list[] = {
 	_s0, _s1, _s2, _s3,
-	s0to1, s0to2, s0to3,
-	s2to3,
+	s0to1, s0to2, s2to3,
+	s0to3,
 	d0m1, d2m3, d1m0, d3m2,
 	d0m1to2m3, d1m0to3m2,
 };
 
 static const enum max1363_modes max11608_mode_list[] = {
 	_s0, _s1, _s2, _s3, _s4, _s5, _s6, _s7,
-	s0to1, s0to2, s0to3, s0to4, s0to5, s0to6, s0to7,
-	s6to7,
+	s0to1, s0to2, s0to3, s0to4, s0to5, s0to6, s6to7, s0to7,
 	d0m1, d2m3, d4m5, d6m7,
 	d1m0, d3m2, d5m4, d7m6,
 	d0m1to2m3, d0m1to4m5, d0m1to6m7,
-- 
2.34.1


