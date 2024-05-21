Return-Path: <linux-iio+bounces-5163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE348CB172
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 17:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15455B226EA
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31D3145321;
	Tue, 21 May 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk/pAqIg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D69144D02;
	Tue, 21 May 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305699; cv=none; b=AzEAqhArBKOKRqr2VCsC6IelK+HC6oa+t2AoGhqxS/p1SVl4yJRyvNd0BCMrNoqn6ALu2KxWIpfxhnl9KnP513fg9YFgIQOLxeWWcaKL1lhwwy0GgCpxGbIREcnVfBsdDcsU6mGvHXGMbMwcM4Rdd6n0Mo9Et916/S9Rhvuh5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305699; c=relaxed/simple;
	bh=FGJ+hAkNElRAqStcbX6IavZod/JCIGJCaxgAaACqtag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1eJuzivXOgbeP7feXMxIG3nic3QR7//vsXZnhcq3bLva5DuZvnd/OMs/RvkwgV4otVkuCqfJqH3rSMPqLD4+zJT3WBUOX0N43bHVES4OAznd5IcyZHNOpF7RHgwY/OLrVakc+GilRpRT0gAsTWmStzNkAL4cqgbMgMnePmo00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk/pAqIg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-420180b5838so24327965e9.2;
        Tue, 21 May 2024 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716305696; x=1716910496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rTfPVP4sEXoI/c4pdAS3vKkM5M7v+nTWcjaWAo5UlI=;
        b=Xk/pAqIgXGsIYhmz3hOCFvV6XPvmZDw1AFSTSaSUZmRmI9FI9VFb/PSO+3uE1Dk/lq
         6YpAfU74Yxb+XYN2YcAiKHFqxCYg3beTPr46oyX/5IUMSnwo83xR/R6I1Ew1m1TJpWPC
         +OycDjFimUb2hdBNDJvJRocz5lLxcJE+i5J5Qk95+iKP83ofIdK9hYm4w19ADBksoGxH
         B3HGV36bSu19Z9dL+zXA89stO34t++xV/LiUYfJj/lUcwzEkAkyIAbKboeyz3Q+YiUWt
         VPTdLEIVpfAYrLhFBOO0xuOgvw2I6JNBhfNmW6K4oB7VAsnSpyuD1QUMKUp2N29SBOPc
         11oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305696; x=1716910496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rTfPVP4sEXoI/c4pdAS3vKkM5M7v+nTWcjaWAo5UlI=;
        b=o2S3EoT7/BKP+1B89QAN8PJ7F+EC57/SJEHba2pSMF+j64Fpak5AbcZzWMIl2oGlFj
         IeSwB7pRVx4lf0L/s30dO6ZBwJtkIbMbnOeGd/oGtH5FnFUQ0Knkp+vPQOhFtCP2XfJN
         LiVfpg968QAJQ+0olyDSxz1gi8a19b5iKKlUInjS+xbyb2JKuFW3sBnRglqoB9SATyks
         Mb8ZDIICTgYcB/tcfBx4dVNL1YXVPUjTjwRanNXq3i6c7yk6994W4YhX5BptmLGncBVW
         zMcujBYzPeJJQRNsWGTYWtdigvbIiTwPrJKOeBYtkJdLWY6EmDeYGcKFjQd4HacsNIoE
         y1yw==
X-Forwarded-Encrypted: i=1; AJvYcCX8N2MqrVL4TQRsb01vSXUyIU9r5HoX9C+KUgBJa5iDKf49tMgE/DmaXRMoGruLf2oo7YJm12B5aEwIGg2qNR1bg+wHvYHuhTGeeKxq
X-Gm-Message-State: AOJu0YzqakbcOS3iKP3NnJeGaL8Nv+nuORdGoqrolTqxulcO8D/TAuDq
	57NkSRwoYb/iNaEC8STBvclqTCkI1hUp+hOfITWrufLsEOoeVWgilZEHGJwQ
X-Google-Smtp-Source: AGHT+IFxGFUbE5hlOlh1iw4kvmrRHnhBczIBwekTMTQXrOwej/fpIT3SCKOMq5BnRUO5R7kmAhG0hA==
X-Received: by 2002:a05:600c:35cd:b0:420:1508:f0b2 with SMTP id 5b1f17b1804b1-4201508f247mr247197415e9.40.1716305696434;
        Tue, 21 May 2024 08:34:56 -0700 (PDT)
Received: from [192.168.1.130] (51B6D146.unconfigured.pool.telekom.hu. [81.182.209.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013c5fa61sm368737285e9.40.2024.05.21.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:34:56 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Tue, 21 May 2024 17:34:51 +0200
Subject: [PATCH 1/3] iio: light: stk3310: relax failure to match id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240521-stk3311-v1-1-07a4966b355a@gmail.com>
References: <20240521-stk3311-v1-0-07a4966b355a@gmail.com>
In-Reply-To: <20240521-stk3311-v1-0-07a4966b355a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
X-Mailer: b4 0.13.0

Relax failure to match ID to a warning rather than probe fail.
This add abilty to use other compatible variants when chip id
is not defined in the driver.

Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
 drivers/iio/light/stk3310.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 08d471438175..7cae261541c6 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -477,8 +477,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
 	    chipid != STK3311_CHIP_ID_VAL &&
 	    chipid != STK3311X_CHIP_ID_VAL &&
 	    chipid != STK3335_CHIP_ID_VAL) {
-		dev_err(&client->dev, "invalid chip id: 0x%x\n", chipid);
-		return -ENODEV;
+		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
 	}
 
 	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;

-- 
2.45.1


