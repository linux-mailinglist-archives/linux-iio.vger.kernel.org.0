Return-Path: <linux-iio+bounces-19873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C72AC3451
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DE83B5EB2
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978071F2C45;
	Sun, 25 May 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVTVfpgY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56451DF26B;
	Sun, 25 May 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748174164; cv=none; b=bPnu3c12W8JDGiv0SSjl7LVh6LkE/1Ytdzcb1Sx+4Cyv+cLC4EUhsyxeQWFrYTfm2eZGOMGCW+kVEeqQkyA8SK5oRXCN2m/SGmvsaUr+CqP7l0ykE/0AtLC6M8VlNMHmkQsXcoKnM3SpCrv1y/4lvoaZh9tmR3qf9O2VeMYvHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748174164; c=relaxed/simple;
	bh=E+2/fZKdPaU7ca49FSsfP9AXKnBpKjmWYrsoU/icpF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqWSlQpxdeW4K+NJWR9djfy4deVNYhdGzOx5WGFTnOtb8WGFbYzv+VWFtRw9O78xPCiHcJYFhvSXEoyLBBCRMO/NGDwqYlGRMFejMe2z0XNfFrYtnKdFmlLLRUvaBwTrCN57Q8RAwZqsi4UC2AXfivxB1pS/VHUtl1iUNn7JfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVTVfpgY; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87dfe906a87so40610241.0;
        Sun, 25 May 2025 04:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748174161; x=1748778961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVs56YPAZB6QL9nW64t7FObev9+e4WZttWHfdkbTmtc=;
        b=LVTVfpgYfxyPUVibfWrhZDwJdxO5jyiD6y2F6Tqe3Nd73/LxQRwHZ/j3tZC1ZlnPoq
         FVcuT1q6EwndV7TqaDuRP+ARlqYbeQlJnWVhP4Fg4LgU21YbbdZTWNvVKkgJ9vxOhMU5
         9KVbYvxImgdUculte0aX/Vk7fR4kX294jMcz9bMo9kuP8C+mXsFdDBUWTO+woxKaEylE
         arodDKnwzIbzkRNBnQ2EV4xo6yTW1QoIz6QePtHC1vcRRO9Uwtn7jzxO9OkYqAgOpBT8
         UxJSwPh8VGAsFwGOhbVDH9EWIaXSlknRyymjQq3nO4QHYBsiL8sWvlUP1k95EI7Rcwel
         EG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748174161; x=1748778961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVs56YPAZB6QL9nW64t7FObev9+e4WZttWHfdkbTmtc=;
        b=ip10/o8CNtUw29qP5x1W67/LP4cDsSRYRGcZwRLa+EIhBfCnwXjDsAHNjPt4x6zhXd
         LucQ1TcEfTgfAtkjay76wW7hY1uJnWrXzPIOuEHirSUsbjAGadrTRqjfgXLNc3Q/OHMJ
         CiOccS6EhUwWLr9aTOq6xkd7L1AwBKdfHZZYqO3i29vPfGKaH4RAqVsH+a18qHt+jDtg
         CPnJIqMJcxQwpXfhgcPfEl1tTdzI88zqZj++0jj1HdExrfitkVuODelMxmq4OtV9X0Fv
         2zvBQBVzhExATwyF3b1jPDgDXRDYUaIsrQER5aRmi7v72f4H3WHA49h1dtBtpXPkTEMC
         tdfw==
X-Forwarded-Encrypted: i=1; AJvYcCU/6TkLXlfrOWw3IFf1JYhr2mpX/6QEsmYrt4jKnR/P/T0BLhsEkLUZ/pa99scJwzMiI/7fjWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAgEFfGHRM7z3ED/iqxQmppoxbrhiTO/hnYAPxqscJ7WWZGVb0
	Kk3TRurbp2yOkuQZR96dLpnhfSbWQqhYCC+uUvRh/Yju5a4YHuA0+IGsQ0wsAA==
X-Gm-Gg: ASbGncv8MJtzn3JCBAHLgbvUuXLi0xr4JLWipdacmCS/NtrHEJe7pSHzf0PyC0McO+o
	2RMZ+0P++cdECLjnNQ1k6hewVKVgvk3JO4azYF33cxpWXVjThDfBNlHHXf1yQV6sP697v1cvtms
	01s8zuA+QQ4tkk6LfIlFIO6GqyxsAG4uWm1DdbihzgDsinmXXhqyADOnqKoGf/a12V8k8ZGLx4n
	uRTbN4SphnJZXZnFNqfn1wwVtqFT/S9JB6JvU5bC+wzbbmdmAG5lTI0QA/ZPGcN/mpRkatMHgV3
	G6/2Tk5Cj2cqe58rFtea3aNlsVEzR+G+1bpsTsN8MSaSJipbsE2Mfkz7hgj8JNT4TQ==
X-Google-Smtp-Source: AGHT+IGtFBZcfM4iabDS1xJZX3T6vNAXm8ytKMPiifbdERLDdpIkbafrzmpCqPCTtZYEiK/qd1MYHg==
X-Received: by 2002:a05:6102:3e91:b0:4c1:91e0:d5d6 with SMTP id ada2fe7eead31-4e4240bc2f4mr4294459137.12.1748174161654;
        Sun, 25 May 2025 04:56:01 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fe1b:24a1:48d2:8bd2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87dede7d81fsm2185872241.23.2025.05.25.04.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 04:56:01 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	mazziesaccount@gmail.com,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] iio: adc: max1363: Reorder mode_list[] entries
Date: Sun, 25 May 2025 08:55:46 -0300
Message-Id: <20250525115546.2368007-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525115546.2368007-1-festevam@gmail.com>
References: <20250525115546.2368007-1-festevam@gmail.com>
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

Cc: <stable@vger.kernel.org> #6.12
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Removed incorrect Fixes: tag (Matti)

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


