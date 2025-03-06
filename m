Return-Path: <linux-iio+bounces-16439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B02A53EBE
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0804816A684
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BB28FF;
	Thu,  6 Mar 2025 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD776881"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C563D;
	Thu,  6 Mar 2025 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219250; cv=none; b=YrkCEAz7WFVIdb4/Kciqq4ef/2lKIPPnwp7caFyrrACsXe2gCrFraBWk81XPpCgjkVv3qTuqXUV2In/WPuTB9UFnGyfD9hKjlRdjW2B8ZHurVDyxgCdaCgpnWJGPjsmPJl1X3XfRsvp3ZsiSjFIK13HrmzgrlhS65KHvXeusWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219250; c=relaxed/simple;
	bh=39CDkvz6XO+Ri5q7s/t0liHhr7O/gnB1BvM5MuQxcsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W91Nh/LZXfIl7RuJAvTsWzvnEr4EweQwaFdRAPSd+iUe3iUz2F/kI4T9agfxDNWcm6d5x1eNE9tJ4JB9OC5lYThjEnuRMm6lzohUgk7OagC/BsTmXKwVFw97cca3Hzte0u2pMXTotkc15/pzgxQ25YRpry2bfleQPPyEzMIZnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD776881; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223594b3c6dso402405ad.2;
        Wed, 05 Mar 2025 16:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741219248; x=1741824048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfpB7be3WQ+25k2CF8K/o3LEES2vCMRSkQKM3K3lwew=;
        b=ZD776881iqACDkiSU4w/+dDrDaPNfkm4xsTvkGZLoMOZX9l67YT0egR+dxqLguTboL
         FmYDdJ8oH00bjl3rHTziuYlVjVV5o7Qy6emu2JssrJcTPGH/ku7BgaZ5FUz97M1/rSOG
         yWDE2E0J7jrlIK1ET3PxTfiXWdsnpuFkwJvR2H1GYEJ7d+9PLeeI8NXZojxMbG0BY7bG
         2nYdZubqqkzQEI/TGty18o/ga6/5Yvk68aDS0/SBKCVFo/jpy1w1C2/ZTGJy8hKlDyX7
         2UVLz16hc+/KOS18WVyThbI4Z/LB0QWinSAQP648oJBcFORDXxVPokri8Gcwj1ataiMY
         JWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741219248; x=1741824048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfpB7be3WQ+25k2CF8K/o3LEES2vCMRSkQKM3K3lwew=;
        b=q6zYuGZP65t1O5MARTuCjELy1HPtCaz9ivtWsmMNh7P3yoQ9oALEKau40hxveO+E9P
         E7WpShmSE/6mAInX4t4qbNUUylMcdFrEznD6JvX7ChjthDg57v0RIed5q6CyodFHe8l0
         VgeYkOPAapWH2FiC2QP67tLk2dCsau+56gbr/ZR5Ak/uLl9G6o2O6b53faKVCDEJcGWZ
         LfwhTuEUf0ypH5ALELRabUujOXZrZsanZjSBkjaWA4yNSXwQCunonQBWsI80i13XFklS
         pjspjb285+812Zf4GYsmhy/70STkXZh/1YhQppuHeuKrog+9dhW9bCp5cGb7gsjar8lu
         SkVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYSTRYCDtFN125qky1sJPAAjbvTUB75GQBy7rv1GcweE3aJCdJpRFS9rEosVK6Y84OiqnWcmuHEXFdhqke@vger.kernel.org, AJvYcCWzVvkJw27RuYT1DiebZkCH9/2yKm/BF+2MsGVnDPiybv7i7cU6Y9EsrIUkvVq9kv8nnUueVrstWEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiwew8otkNMlrLtps1zyTLTxQ1dVBifxSIy/I1E1nUNI7kjEXr
	gT1piQn7BVgPz2dYYABmuCVnXYk5/zZU5t4vBiysrZVmJ0A+1q4T
X-Gm-Gg: ASbGncv3OVKuOQslVscIBO+Ss6p33Xd+khiQFJQme8A96vtYpO/H/yBwAVLQTBauLzC
	DG7ymaQBfj1aIQSApFYhxCovJ/OyydBGbJk/TrVoBJd3J3e0or6Xn8QTJ5IdMBSYVNi7xLeOnmU
	wagE5kbZmRVvChq4VxjqyZWCMN+wESC9tUTJgSY8SM6cN2KO3o2m0tXj79QJYtIMKWrNSg+p4xh
	S9viJkB7A5H/ARFt7jGMdbHRwPPQedjdRjwKucltjTVU37DXdw0gLIZYAC6BejXuYC6jlRbQQAd
	fYst7Dwai9ZpH/bi8/0CrekjNQ/97Zri9iFZyb0dWHHlzz1YEpeDLE8aLS+ciW/z/zI=
X-Google-Smtp-Source: AGHT+IFxHf1uKo8PUiFp492BtjX06i1u/Qae1B6ppFKhEAKyOZPZE48UtdR1xOkhQD05jGDzH74hrg==
X-Received: by 2002:a17:903:3ba5:b0:21f:ba77:c45e with SMTP id d9443c01a7336-223f1d81964mr73730045ad.45.1741219248439;
        Wed, 05 Mar 2025 16:00:48 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:857:3077:7768:d8a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddce7sm68625ad.3.2025.03.05.16.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:00:48 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Saalim Quadri <danascape@gmail.com>
Subject: [PATCH v2] staging: iio: ad9832: Use devm_regulator_get_enable()
Date: Thu,  6 Mar 2025 05:30:40 +0530
Message-Id: <20250306000040.1550656-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regulators are only enabled at probe(),
hence replace the boilerplate code by making use of
devm_regulator_get_enable() helper.

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
V1 -> V2: Fixed indentations and commit description

 drivers/staging/iio/frequency/ad9832.c | 37 +++-----------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 140ee4f9c137..db42810c7664 100644
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
+	ret = devm_regulator_get_enable(&spi->dev, "avdd");
 	if (ret)
-		return ret;
-
-	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
-	if (IS_ERR(st->dvdd))
-		return PTR_ERR(st->dvdd);
+		return dev_err_probe(&spi->dev, ret, "failed to enable specified AVDD voltage\n");
 
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
+		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
 
 	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
-- 
2.34.1


