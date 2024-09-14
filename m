Return-Path: <linux-iio+bounces-9595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B99049792F0
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 20:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8FB1F22585
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0191D1313;
	Sat, 14 Sep 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwaXt+Bg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED628C1F;
	Sat, 14 Sep 2024 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726338228; cv=none; b=FGjmkmW2X3FBWMggFzkah6lctZaMZId8m0ceLsqQ1jFkbWp9duOzKI3p19r3upDqH1edVonDwdwImQbjRdCQCEA4L5hNx/j/YA6ATJ7t2sCDQ1kCKpePNHm4DLnArirwe/B6DTfZf8aeJjFThfQ0X1IgCDcZgYnNZ5tI72nw/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726338228; c=relaxed/simple;
	bh=1LdPPraVBlmPnfyxTYIAL71SrMZPy7QDDEBMP91cTDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poRjLDhMmTlPu1y8NU3ZU6s97dcgaMWBEuBI76WOmdFEwZTDRlpIHaPB3UFJk+ZwvABV1wiewsEBGy6JnqnAkztXS6zgCJjkWeRMkzSrCNT0jD1ZtOV7q+0CpaLPk2w2n4WSPTB8o+ZQ1emcyXUn3wI9Pw8f+iTfMcdAXCBKZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwaXt+Bg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-207115e3056so29657965ad.2;
        Sat, 14 Sep 2024 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726338225; x=1726943025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv8HIW8PoAx/VnPMHWUI7vkjblsjYzYs0OwmchHlY8Q=;
        b=WwaXt+Bgg0i/7RZH8w44CenwT+N+MUhWAqqUX5lLfIOOcLdcuBAjOJtWmas0ybDi+Z
         0rz3IYOU0aI7GiQw+3ktuhHLrjHnNKiGQA2d21mvndhYtjwSdvVQhtTClV3hDw4FmZ2Q
         NfKtkZLzDr4gQoQ9Dltm1f5MhudPl2p0k0WtAiHuQWuQW9IVGNakWIp/ZxjTAXw9kMcn
         vRcHIDrKMZgBjI8MqpSqIp7cl8YfmLzut21Zz9bISVvsv2v1QK7P5lPEEjpi628zDTce
         Jx8i6FY9XUPHZC5bLHZ8V1pnmKA+zzZEFkHhip1s9Es+JnugnP5Cui9Y6mr4+pMutXoH
         SNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726338225; x=1726943025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vv8HIW8PoAx/VnPMHWUI7vkjblsjYzYs0OwmchHlY8Q=;
        b=EVWai0ykOZIA3RAJqnT/jxT+8jQWoY6n5sZlxlbQ1PI0+tDX72URzyo/s/kRiCz9oh
         cL8DuMmyRsw5e7EktrfS6sO0D+InE4P1nfrBwXsmh+UvATItNncFt6d9cFYYOxJQx2WA
         JWlDYnt7U0I8Vh4Jj1+4v827htUW88MxfazNPpnZjzGf6Y96/RBQpW1MItq4Y/CJxXh0
         T5XSras4kQNo1yPxt2qL3Fbj6QWYcIfEB+rdHIeAUs6+DxXp5h1yVMDaD4owe/7jUGAB
         lGZUJghWO38lSTEL/0gFtpYMIgUNr1Gy6Ur42Tw7jLKlvQFpt8CanR4SBwKr1od0aeBB
         avkg==
X-Forwarded-Encrypted: i=1; AJvYcCWF7vWo4ma0cLeiIMVwWk5UoyimloODVC8CV1VvMD2TgY6Q2URUBT4dplC0gm6QKeP5pZCR3SYp+TRKfPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaLcam9I+bwau9svTluMR+qYrAovQG0UklHjfsCUQICQ7oP5F
	eVAdsiKpAkAK68Py18Ss8KF4WU4hEqVnHNbFOCZpRgiUaP+i13Sa7JvffT9Ild4=
X-Google-Smtp-Source: AGHT+IGvRgUe9nnTwAqgGlIKyr60aM7lYFfsgI1Nq/bb9ZRPyCfRefJAaUqyCATdmtISIj6cinsp2A==
X-Received: by 2002:a17:902:ea08:b0:207:13a3:a896 with SMTP id d9443c01a7336-2076e3c43dfmr180403175ad.23.1726338225274;
        Sat, 14 Sep 2024 11:23:45 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20794601022sm12086495ad.74.2024.09.14.11.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 11:23:44 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH] iio: light: ltr390: Replaced mask values with GENMASK()
Date: Sat, 14 Sep 2024 23:52:39 +0530
Message-ID: <20240914182239.507953-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changed the hardcoded mask values for GAIN_MASK and INT_TIME_MASK to use
GENMASK() instead.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index a51ad6704..8f44453a7 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -46,9 +46,9 @@
 #define LTR390_THRESH_LOW		0x24
 
 #define LTR390_PART_NUMBER_ID		0xb
-#define LTR390_ALS_UVS_GAIN_MASK	0x07
+#define LTR390_ALS_UVS_GAIN_MASK	GENMASK(2, 0)
 #define LTR390_ALS_UVS_MEAS_RATE_MASK	GENMASK(2, 0)
-#define LTR390_ALS_UVS_INT_TIME_MASK	0x70
+#define LTR390_ALS_UVS_INT_TIME_MASK	GENMASK(6, 4)
 #define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
 #define LTR390_INT_PST_MASK		GENMASK(7, 4)
 #define LTR390_INT_PST_VAL(x)		FIELD_PREP(LTR390_INT_PST_MASK, (x))
-- 
2.43.0


