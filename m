Return-Path: <linux-iio+bounces-5655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742378D77D0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 22:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910862814C3
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 20:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782587710E;
	Sun,  2 Jun 2024 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRnWZycA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF890762E8
	for <linux-iio@vger.kernel.org>; Sun,  2 Jun 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359514; cv=none; b=lBvNfifsPhnD8M0RN3/npWM/m71WByEB8irq6Hx1Hjm96LLr1Iuo6a8W+ODFgSz4IKd1YHPPo9z0ffhhnwcW/rKdLH6JafwHkPp+OUUqhzQB1UqANhH5DZjGbdTeNaKVfG1Rxp1pfU6jtfyRIG1EhQwf2BAv94gxTwnZqGc2L/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359514; c=relaxed/simple;
	bh=pwOqSz0RuXd4onWYQTXXrp9uoYEt+BH1tUkw692Wrwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lPKfVoDnQv7jwrRqiP8ArmNM3Fpb1iio0ww3/FURS4nc9FTAGYCHbxDpZDD/qPw7M1XREfc83np35qomGXu+DEO7Bsi5lIj9rN1EddoY8tD6Cz/C+b/cMmaqMk6KhwTvm+xaRFebXX5bX+1OP352kQk/toKtjYBcs0AOb9ooejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRnWZycA; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c9cc681e4fso2178399b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 02 Jun 2024 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717359512; x=1717964312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBi2ho4pBAP6KE9N1IyzUu+E5VqtrFKCkAHIMog26a8=;
        b=kRnWZycAdhpxgRFAgFDZE/PBQl4w8oK3cjigYmVNcNaklKLodWUD7D1VdvFRhWag3g
         9TbTj9hXYBjuuZX8NbloOno6VO4d3s9Cdj0gxn1QETxBgNk1GXXfSwdfsH7Xc1uLqB8M
         EbxgeeEbLCKECmPBWccQoa/1c5DRp59UyHSSHd0XGmjz/THAVcBZiWPy46IDgLl5Ul8W
         oNU2f3hw+bPk1KCNZGJaVuZ8eJOcK2oJXcEeR8rzDLhBw3e96y6KsC2ei+3xk/yAK283
         WfnEYoMzoH3Lm1yLNJ4mxZmy1gFpSK8GjBB3dUOIM2TrgvGhXGp76E+YQ1CHvruTA9IP
         /zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717359512; x=1717964312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBi2ho4pBAP6KE9N1IyzUu+E5VqtrFKCkAHIMog26a8=;
        b=Ck5kcz8zstPPMfgV0I+nD09NQjnRM1Xwhe+hmkkQFU3wdhs2hpvyhU/wbY4J+6kjxB
         2gh6v/jFRiaD5MZKHli7ccjcYIUYVWWSnRvOzEq3pW6tl15sBoo4CShEtrWFAjR2/00I
         xkHeRHO2l2j2QSp/z5HXFELQuEpmZZc44UnZWf/8jBVxwYSOul8Hbwp1cAfaj2u4eNXv
         GzGoaBZZyYuL6CKd9Gu3TXUsoapT2jLAzgp28FDM8CD96TXNJBf9YSbrvpyRVGosXZmS
         Qi+21cIEkDSFl1F3QE+opzbnrO2lcPWuilfJkePiOAuUHTYwQFXEc3brYH0nq9nqE839
         /pUw==
X-Forwarded-Encrypted: i=1; AJvYcCV+F/3oYttos/LIjeh/B64OpRuQ+1UrTWLuesq9aXOY34v52ftQabkHLYZmlgBojAFAVh/6wsFMX8fSvYHnwehZjtOt/naHZldJ
X-Gm-Message-State: AOJu0YwraycYSUxPo0Me81SxiUa3gJTBViF9Hc+v+ydsSEk1gayx2XWL
	zzivMTxU9HFuh9Q5KCCvw37eUVmx3GGfsArVZXTb4zd11QYVZu65NCIUrQ==
X-Google-Smtp-Source: AGHT+IG1sSKwUm6EfIXscsOrlMB3x+6N+BLIsN5n8B05MK629P4uoTaiwQc2qb8GqsYYhA5OtvrH5g==
X-Received: by 2002:a05:6808:317:b0:3c9:64de:eaa3 with SMTP id 5614622812f47-3d1e3490612mr8554619b6e.24.1717359511495;
        Sun, 02 Jun 2024 13:18:31 -0700 (PDT)
Received: from adam-asahi.lan ([2605:a601:aadc:6900:cb77:61b3:d29e:f18f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d1e19fa4cbsm1033842b6e.30.2024.06.02.13.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:18:31 -0700 (PDT)
From: Adam Rizkalla <ajarizzo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>,
	linux-iio@vger.kernel.org,
	Adam Rizkalla <ajarizzo@gmail.com>
Subject: [PATCH] iio: pressure: bmp280: fix bmp580 temp read
Date: Sun,  2 Jun 2024 15:12:01 -0500
Message-Id: <20240602201200.30418-1-ajarizzo@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix overflow when storing bmp580 temperature reading and preserve sign.

This patch re-applies the fix in [1] after the merge conflict resolution
mentioned in [2].

[1] https://lore.kernel.org/all/Zin2udkXRD0+GrML@adam-asahi.lan/
[2] https://lore.kernel.org/linux-kernel/20240531140621.264f0848@canb.auug.org.au/

Signed-off-by: Adam Rizkalla <ajarizzo@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 95c88b0e1c49..3a003843c79c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1752,6 +1752,8 @@ static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 		dev_err(data->dev, "reading temperature skipped\n");
 		return -EIO;
 	}
+	*raw_temp = sign_extend32(*raw_temp, 23);
+	*raw_temp = ((s64)*raw_temp * 1000) / (1 << 16);
 
 	return 0;
 }
@@ -2154,7 +2156,7 @@ static irqreturn_t bmp580_buffer_handler(int irq, void *p)
 
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
-static const int bmp580_temp_coeffs[] = { 1000, 16 };
+static const int bmp580_temp_coeffs[] = { 1, 0 };
 static const int bmp580_press_coeffs[] = { 1, 64000};
 
 const struct bmp280_chip_info bmp580_chip_info = {
@@ -2184,7 +2186,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.iir_filter_coeff_default = 2,
 
 	.temp_coeffs = bmp580_temp_coeffs,
-	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
+	.temp_coeffs_type = IIO_VAL_INT,
 	.press_coeffs = bmp580_press_coeffs,
 	.press_coeffs_type = IIO_VAL_FRACTIONAL,
 
-- 
2.40.1


