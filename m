Return-Path: <linux-iio+bounces-16303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0DA4CC72
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 21:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831A3174A66
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E33234988;
	Mon,  3 Mar 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHYMXSg+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A9215065;
	Mon,  3 Mar 2025 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032236; cv=none; b=rGx6R4XXo0Pr2HR+rIgpTW0oLeBduC/iIIhAPEEnqkevS5gc/yfJVYrYo+CV2QS/o7ccXgHYFX8opVyUil77XMFH2e6H33vYVzilWYO63EYoaTqBPCUX95hOQK+/t9QeYD7TbEZa5DsyR3lv2uoQwbaPd1e3yB+yQjEDliQ3Cec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032236; c=relaxed/simple;
	bh=UAbB4w7E4m1mLCo3yn77rgKxnrpnomzpIaADSNtpcM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MjZbVNR8ws/pKi7GA3h5xT8zDR0UYXnt7YobkGlDgejRsE3nrMZPenNSurQiyxcjGWyFOEajDpCtQwQHHEKs536jgTNEpdSeMhA3hb5aqtdN2wc/fEAcRGuHgjMaFNdo+FeVpHN5RP6PVCC+yzFj0gm/EMbtC84KC1Bwavww5/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHYMXSg+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22339936bbfso71433605ad.1;
        Mon, 03 Mar 2025 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741032234; x=1741637034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QrbUEFY/lf1OjHUcnLJiKmmiRtzC2NeD0FfZjZlPltM=;
        b=JHYMXSg+kZCPXQS+sy3Alaaj3RCipEOvIOD6ptP7YNTnwBZTPGcDyOfXQMsocJUXrA
         tphGbyGiYKyUOjMWXrYiRQYzQR6Mh+iTdHEUDVWX+RTHrmDHxpUbnvUmlKU6G5eeWoNN
         yxtPdf+bTXhBc4VYWdhAoLvbPdWoBz1+711u5McGeRsqX85WDeYE3H3UBGE5ll+WvDuQ
         FnPlw9OnTaNbXCNpPfVO7UZ6EDzjBZlZH5+exYn8u6H0TevAMOFmsWoSYr1u4ccRPZNo
         QFCRGqFaDxuLyOnnVVrV5c19L36BAFF2UY5JJzqOo0WLJxltC6lkS+AFP7RzrGJ+nz4A
         /7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032234; x=1741637034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrbUEFY/lf1OjHUcnLJiKmmiRtzC2NeD0FfZjZlPltM=;
        b=RFhCiWOS/UAY0gOKU31T3EL1HfUVJXarpyBmw1DVc22in9MfcgTgHmAVt4v6H8BSF8
         tynaiND4DCLdUnkNX5TP2BMY3DFHcJdFmHcY5vt4QsRuLnQBiuv+wC58F1zAprBRSRby
         UugDzsu5rJwMz0RWX428NRIRblX2nRCKEqKfqqfO4SHP9Az2ICuZKNnD5CSvzZWcJMbJ
         3bX5S3gRrRz7D5QI8gUXsOj8/Er6caN+wdTzReVA3HIs1jOB/2VSXdZTrBdXzF/QByVM
         55vq5pMNVs9Jngzm8GB+sJVamOuTBbxLAl6A6XFCTX+GTmHiKiM9zJTO4Qmh2BM9Hdg1
         VbAg==
X-Forwarded-Encrypted: i=1; AJvYcCUbwHhkxw20ai517F4+rFAoL2zz5nPWeAOQY8alKc3yPLmf5YE/sb/mCYQLXegnFhLGob/kbC+KRwufGxJn@vger.kernel.org, AJvYcCWjB9oddvO6ewUhV96pbBgMh3L+X1Ib0qanchiveeYJinXfmhAv3EnAHHcwqeZydKgTiu+EkIvsuzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCgg8sH6M+uvbSRwf/QFPsjUDAybYjRjljzB8MakZbK94LKqbX
	DoU2Iosry7LqYEqWtFdVOGco6SRRJqhcxk4Y/2L+l22D0MUWBCYe
X-Gm-Gg: ASbGncuXBUk0b9np+opgIBjCuXkSRnKRmrxfA4mYoNeec/yAz+XmuSiW6j3+w/N/nNg
	TZAgFpzFitYM27bty+mAkH4TJR7JMgVZABTYNyymkdvygm+Tnd/Zq3+1bNooK7+kdCXs6oJT4Y+
	nDiu5O8DyGbYummIv9qoGiLddFbM+bKrFc2QjX7zfNXoVdn70V6NJshB4AjbdhA38xZTkGHTs3N
	DLnQoSeyMVQsI5+P+CyRlKR5xVoo9lgkjoC0d4Lnp5qyQNzJQ41Kos3R6AmOkyNPa5lxdmlCamn
	5oq6Op/dN8IVVyZP+mDUaegzI5AEXSJHiWJywj0gyYYsKSmhUyCw5VH7txSV3hTYphNF
X-Google-Smtp-Source: AGHT+IGBy0TApsj/0F8MuCfPPS47j68Bagj1kWLrrh4wS/ICtMfKU9/DC6Sypb+Zn2+4m3XFwPu+Kg==
X-Received: by 2002:a05:6a00:b90:b0:736:61c9:f9a6 with SMTP id d2e1a72fcca58-73661ca04c0mr4127339b3a.5.1741032233820;
        Mon, 03 Mar 2025 12:03:53 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:7b03:1e42:d492:fb71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734d444a9fasm7266779b3a.60.2025.03.03.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:03:53 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Saalim Quadri <danascape@gmail.com>
Subject: [RFC] staging: iio: ad9832: Use devm_regulator_get_enable_read_voltage()
Date: Tue,  4 Mar 2025 01:33:47 +0530
Message-Id: <20250303200347.23354-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_regulator_get_enable_read_voltage() to reduce boiler plate
code.

* Here I am particularly confused about regulator_enable(), part where I should
  use devm_regulator_get_enable() to enable avdd supply?
* I can resend this as a patch if everything is alright, specifically with
  devm_regulator_get_enable() for dvdd

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 37 +++-----------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 140ee4f9c137..9e7975265454 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -74,8 +74,6 @@
 /**
  * struct ad9832_state - driver instance specific data
  * @spi:		spi_device
- * @avdd:		supply regulator for the analog section
- * @dvdd:		supply regulator for the digital section
  * @mclk:		external master clock
  * @ctrl_fp:		cached frequency/phase control word
  * @ctrl_ss:		cached sync/selsrc control word
@@ -94,8 +92,6 @@
 
 struct ad9832_state {
 	struct spi_device		*spi;
-	struct regulator		*avdd;
-	struct regulator		*dvdd;
 	struct clk			*mclk;
 	unsigned short			ctrl_fp;
 	unsigned short			ctrl_ss;
@@ -297,11 +293,6 @@ static const struct iio_info ad9832_info = {
 	.attrs = &ad9832_attribute_group,
 };
 
-static void ad9832_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad9832_probe(struct spi_device *spi)
 {
 	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
@@ -320,33 +311,13 @@ static int ad9832_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->avdd = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->avdd))
-		return PTR_ERR(st->avdd);
-
-	ret = regulator_enable(st->avdd);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->avdd);
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "avdd");
 	if (ret)
-		return ret;
-
-	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
-	if (IS_ERR(st->dvdd))
-		return PTR_ERR(st->dvdd);
+			return dev_err_probe(&spi->dev, ret, "failed to get AVDD voltage\n");
 
-	ret = regulator_enable(st->dvdd);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->dvdd);
+	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
 	if (ret)
-		return ret;
+			return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
 
 	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
-- 
2.34.1


