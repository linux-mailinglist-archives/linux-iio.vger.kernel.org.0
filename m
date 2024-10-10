Return-Path: <linux-iio+bounces-10397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7CF998E0A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B0A1C245A1
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF219B5A3;
	Thu, 10 Oct 2024 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb5MxYUY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47E558B7;
	Thu, 10 Oct 2024 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580121; cv=none; b=dOgVW+BvGWQpNMJ4FHiD6B2RBUhu4ql2jdXWTmQ/zHlj/JSplnywnfbVbMmAbNP3L53aiHhgI19dcLbCGhRUHERY4gQfz1C+vMqohgBLGWwYd42+/RWgSChAsR7fS6GCVkWQDnt9nFkix9sMSUVm87Hmpy5eqiaigfWE7dvMie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580121; c=relaxed/simple;
	bh=83B4gZkVqCXDhd2KE4907JanoMHqwxtUvcT7A8gpdb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=d/qZoBqW//x39Xee+FqZQYdpdbEm/47q5L5VqW79LFSwMowL9r510YL2WHwDsOp72iNwl3ur+/jpttAaJuej812TUsyobBPC4SmaEsD0yCsJcBGp4P7qdi1hVwzH4DACgf9FvJWc91r8Odrus8vdebU59JzcQg9fjGMBsgnl7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb5MxYUY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a83562f9be9so147105666b.0;
        Thu, 10 Oct 2024 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728580117; x=1729184917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s76fMrgrCCIITG8O3wMeuaoCvQZMM5iJlgV4Fc1nwC8=;
        b=Tb5MxYUYNPm/FA9PFIJ+cu0FpzF1Pxms5Y+ZPdu/jVQpWqMssCaoqibsdObdnVWq13
         UGi3mMIJn8pboFMrUyUxiN5iyX16bB/RHfELOmsproWidi9IrlOpR+iZhWN0T3qjKocJ
         +IfNGuVESkPYTwDAVPgUc3wHwyR35bCRFQLOzUumwhYcucgmv1Vv8xUlmhtWsU6jEV7G
         c9wEzd1K7XNiWjj0HlaFwNqUcyptYOAJK5EMdZ5BBvnJSiYn6NsOo1sIYaL9AMN6OK6T
         EJdM7YY3rxGyw0OYjroT3u2+JdjBgU0zmMzxS6Gal8mhrIuIlqcztBCoo4w2Mbj4ODXH
         qJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728580117; x=1729184917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s76fMrgrCCIITG8O3wMeuaoCvQZMM5iJlgV4Fc1nwC8=;
        b=VrCmixAIvL2/HUpGEocOW43Wm0hqoM3Ocvu7lrxjzGbFj1cl2dyWD82mx7B9E2LGvt
         k95Jke5GGmzPDTqzg6JpfuuROA0hHEWks4+v+vQ3nqF1LUlpKQxCJdP7Fy3nC3l8yw7t
         3D1pRXut80MWvGamiSJB2nQ9tYKbkcOR2+RDaul9/0mzXX2lkP7SVAimshvw3ALJ8Oib
         WffUpDHNVoIluhxUJJJ8JE5smDx66AWqSZ3ed9Kj/RBk5R+2k6a2fxux2z11b9UCHKHr
         xPH7BaGJtsbjsdxG58Dlz5iHpt5v/+OYWcZ6lPoE6p6vmIukY2TnkRKII9P8R69uGQT+
         c/7A==
X-Forwarded-Encrypted: i=1; AJvYcCWcojQPazGAeWC/PnSbFt/OoldCRFHdf7er9tgxTJzdw8fnM0EuAUgELmYgNuDfp88MliTPo8Fv59U731vI@vger.kernel.org, AJvYcCX5WcUYMpf3ACjwkaE7FVCASqDOI1sX62kRYGBR2QqaD+P8kLJvfkJL3Rg6LQ1H6LtaMXxDuY8Ldr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCooSH0ECIH0yc7bHCsXVwiLzXtSeXE9FTFsOvs9XrxpmqxJB
	kP7qui8zbqY+UoR/n+aqn7aJqPRBx9xKDYDJihijs0KQh32BLoneamE+H2Ns
X-Google-Smtp-Source: AGHT+IFRAFYFiDsvs3uzupt4RvuE9SDRKJN+vCOE/lzAdDHhgG8lE7FdHSD9DckCx52z3Io+q3thFg==
X-Received: by 2002:a17:906:d555:b0:a8b:6ee7:ba28 with SMTP id a640c23a62f3a-a99b7672bacmr5533366b.1.1728580116669;
        Thu, 10 Oct 2024 10:08:36 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f35f4fsm114421966b.88.2024.10.10.10.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:08:36 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: pressure: rohm-bm1390: Remove redundant if statement
Date: Thu, 10 Oct 2024 18:08:35 +0100
Message-Id: <20241010170835.772764-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@intel.com>

There is a check on non-zero ret that is redundant because the
same check is being performed in a previous if statement and
also before that. The check is not required, remove it.

Signed-off-by: Colin Ian King <colin.i.king@intel.com>
---
 drivers/iio/pressure/rohm-bm1390.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index ccaa07a569c9..f24d9f927681 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -410,23 +410,20 @@ static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples,
 	if (ret)
 		return ret;
 
 	if (test_bit(BM1390_CHAN_TEMP, idev->active_scan_mask)) {
 		ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp,
 				       sizeof(temp));
 		if (ret)
 			return ret;
 	}
 
-	if (ret)
-		return ret;
-
 	for (i = 0; i < smp_lvl; i++) {
 		buffer[i].temp = temp;
 		iio_push_to_buffers(idev, &buffer[i]);
 	}
 
 	return smp_lvl;
 }
 
 static int bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples)
 {
-- 
2.39.5


