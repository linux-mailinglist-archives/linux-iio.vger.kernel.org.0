Return-Path: <linux-iio+bounces-7786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B502939199
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC8B1C2149E
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4816E860;
	Mon, 22 Jul 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOeDm98q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8216DC3F;
	Mon, 22 Jul 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661463; cv=none; b=SikrqM7WkYfSUfiW63Pjg57gTnCCeDmk53O5GDT1irKi7yyhah0X7hF/qPB6kaNnkxNfbr2L++LA11vHcRZ7PxFRYQ5JsUYlJCckbQ1hHgjevuL/y32OPIlRBY6/Yx0Z0Je5xtIw29BOTvKGSNGbqyvWPGZZSnQMREs5xUK4sec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661463; c=relaxed/simple;
	bh=A34RAxK6uR4xNgu+FQWy95mqTvqlpM0dhFsEQNZeWYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HzqACAbb0LQKV4RNdKgZlhHufRiIW2Tuw/xjjxjCq48ooCgMra+UmZlt8H+jIDfw41iTgEmr6VWkcslIFv+m2oYjJUy4u3mOLJXK451LsWpRLkaIlELyE9zyt4moBtUBnnxpcMV6tH6K5PEvgqvN4JQAE9G9CiAKYBvsCnskRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOeDm98q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4266fcb311cso33285575e9.1;
        Mon, 22 Jul 2024 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721661460; x=1722266260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLBZ985WV7DPYvCx8DrfSdgSJ5urh9eHcroKoUisl+w=;
        b=mOeDm98qhhPsSt8zhOrzhu/5EFckTedleoQGRKZ7P1dcRdOPi136My559o5qM26FfA
         kBXaNQmJkJ86+jUSaK2C6MKO2EyUU36JSnk03uePykuAm0s2LaI4kLO3IEhZJSfFoBcu
         CGByNqTPKwq6YFeWxEKJ7b5k+yNjjn7h5yBGR5lk2DwyM2nWrKt3Tf+hJ7MFpBkg64D5
         tO1a871hAgTNB5qG48peP/x26SjQ2RHWA0ClKX38MVp7zZzMmMWiO1wsSooXV8Oc2q6o
         MMq97SORtR7UwjVX1ZPaDUtojgzmNnsv89Eh0Rsw4QOVhN1+dah8uvQ9OrZPYUT3aLTs
         wK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721661460; x=1722266260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLBZ985WV7DPYvCx8DrfSdgSJ5urh9eHcroKoUisl+w=;
        b=GIBIXLC6YZ4ycZIvlHXB0fM+1HoIxDTfxMf5H1X5FB/ygRYfvJWbU9B4+9S8WN8duq
         vZjF/pyyc2NdYtdvEdvy4w1Dpyd5ILXXBEVAKVtAp/5XQj0WGZxvVMgrerotElLYlhVj
         O8NHWdAFk50/yUyDpPrzZZnIs3nBgIWT7ULPjgVnftdKliNMKpJjwIVCg81G8WKX5080
         w0urO1H+Z4BoP/JT7ms3L2K4tqz8piTMPmFrtouAUhaC5/T4bz7vLZGgxaZFpQiwy2RI
         cbodJ25EHi8iR8X1vQ2OJ9A+6+Bbh3Hfz9fL8wiPRLjjVD6eXh3e6TjsEtThMckFS6SQ
         /OrA==
X-Forwarded-Encrypted: i=1; AJvYcCXrksyD3D/GZtXPZFdX/H2VAzSblHE8o9uCa/gx0F/kRR1Xqjksc2ui2PcLyuJFyPqzACctL6EDbu5cjdw2Svi4fp4sVif7CleHm3cxGlT2/X6l4KGTPlQf50HiGXGPeu4AzZ49j4Jp
X-Gm-Message-State: AOJu0YwTRVT9Znd/95dNBXbEI/+mtw4+y2ZRKknDvC79VZUgUJqyqb/i
	PHrGGkufBtup1OKCsC8fllgJtOMxcvB+LetSRtvWLsCOQ52ffSF6
X-Google-Smtp-Source: AGHT+IF57zO4WUGBb8VSSalFryRuoIrf3EVdzgnnb/MgesD0eMy//ucoQk7LD4umT/CxParEm1QJEQ==
X-Received: by 2002:a05:600c:35c3:b0:426:6c7a:3a61 with SMTP id 5b1f17b1804b1-427dcf6b273mr42693135e9.3.1721661459708;
        Mon, 22 Jul 2024 08:17:39 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43034sm160317905e9.3.2024.07.22.08.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:17:39 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: pressure: bmp280-core: Make read-only const array conversion_time_max static
Date: Mon, 22 Jul 2024 16:17:38 +0100
Message-Id: <20240722151738.572913-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array conversion_time_max on the stack at
run time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 49081b729618..9ead52954de3 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1865,7 +1865,7 @@ EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
 
 static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 {
-	const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
+	static const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
 	unsigned int delay_us;
 	unsigned int ctrl;
 	int ret;
-- 
2.39.2


