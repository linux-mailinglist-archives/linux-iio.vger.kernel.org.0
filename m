Return-Path: <linux-iio+bounces-18855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D064AA112D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 18:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF04169C17
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4B242917;
	Tue, 29 Apr 2025 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ1aqRbG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E6217F27
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942760; cv=none; b=SwOsZjLHpWYzPK14ywK4eivb3eo3Je/FecuLaXUiPbl9foB7MRyTID2U2jO+we13xECKyMv7QaLHHI+me+JQkXAzlvYqlbAE8oJSzbjmo6c/GltyWxM6VdgYo4ianhdNk1BTGCHBkXQFWM+z0rqSZHjIw8GvBw36wRGLBUqlxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942760; c=relaxed/simple;
	bh=mDSsZhkzBx5iECMrq2VasSzgEbBXN6LSqaQOdum8DuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akOTdQl0zSk3ox0K8UrevtT+YiS0TUh6DuyEj6Q9odeKCPkK81159KULLX666O4fAqbmpSfiaH8pB/ZF3GjGkBnq2Xkbf9hQQtrmfvr5XWnjuCco3Ji3r5tY3NpTQ66Ce7EDG3WN0WKEtr6cEZmOChoBl6tc3jdY2G6/lyOCePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ1aqRbG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736bfa487c3so5140047b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745942758; x=1746547558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmgbU4/7Fem2Ff9mETq3ZfOK8VIclhfDACJqT+xfJ/o=;
        b=BZ1aqRbGqFDUYPYe82tvrIxSeRh3mMmy0h3oQoNskS5541pMWWRceN9NEJb7rRj9+n
         iUz7OQBiEIhL4h/3mYztFsj0eq2jFIMPNgmpXcR0BaLKKm1MXAdWlWJhLMS8OvEuYcDD
         RGzBeR2YyeX8/I3IEmL0D8t/L5yO15fUhTFTrBaB2tLTBFeXxo8oNph0vji1qAvp6T6v
         +IrMMoMVTk0mdg+O9yC3ESVDyWHf1x9Cg2Oag5cwvDnAB+2UsXs4O5ktiKivDOFAMHKP
         SmUsMZZr1eD60uLygnaimXTb1kTuUA7TIQjoviSUzpLoS307AYYs0d2Si7jsgBeNmWGt
         V0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745942758; x=1746547558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmgbU4/7Fem2Ff9mETq3ZfOK8VIclhfDACJqT+xfJ/o=;
        b=X/SNW2v2oHDnZzv0HSnnKjz/up6lbNEpyYFdzioEKIU6coFUs1PosTR9J7xHfA0Lh9
         6iVtrWnyOhvDb17qaM1LsAqpQ2VJAVu5ZPcZjHxRGdhToFxtC/ml8pXg0wM0hFL/fjtH
         b94ljGt2vmWFM8Uw5JEPP1spDu1lTVaJqx564MENXPOFqgghDQbMM4Y+wKDMcKyLrp1t
         S0syeo/kMogrZKAz6FoUILZ+qbx8oGrzPMfYD/8Fp5mgB/lLLrROKYNV1UaV1vBqZ2FP
         K3aYuy23n0tfoxSmvs1VTFogAIhwz/EkAzynodORqh21ZjELprGdZaNcdqyNOvuD5IT6
         VF6A==
X-Gm-Message-State: AOJu0YzbZ8nDn5D7H6EhMVd324+k89M4smN/HJiaHaNkR2SaYAmadzZc
	WHrydzjhL0zOFaTxvrTwzrTmCz81FxgxRleJR+dkegpjWoVLjTj5
X-Gm-Gg: ASbGncsxAc8RBK/erRw62KN4s/i2vpQRNs19n9XcVzGqS6+nVNePde16ZRYP4zN82Ut
	5YrjcN9HfNrr4ZUBHq003pfmh1d8906tAxf64WcYx2zEYhpjJxOEUYoumDGp7D5BH5uXVQBObuG
	8YMmxtweEu0y184bdajKH0ALpHqIsnhW8ZpxpMByU6irjKKJbbLNY/gwGMj6yVwDtxqGGcS4KNd
	kmELAI8ChSoanyD9S727IkofgGt9jDBDILSL2xEuRE6j+8FpM6SvuFNzH82xpM5nbhwifQ8ZxEB
	tPrbaZqiCXx34XhR9DkOae+x2Dw4zxK4Oyqn1d6wVi6d7XpLj2VCslKofsWxbHvv
X-Google-Smtp-Source: AGHT+IEaRmUD0KQKv98I0smqctbOYV3Lb/uD73vWzcuWu3XiBJX8k5MAXvn1J7I6zNn2eIC2il9Raw==
X-Received: by 2002:a05:6a00:14c6:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-73ff7390b87mr18801389b3a.20.1745942757830;
        Tue, 29 Apr 2025 09:05:57 -0700 (PDT)
Received: from c-sar-augusto-LOQ-15IRH8.. ([2804:14c:73:90b8:20f6:60ab:5d7f:2c50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6b18dsm10400888b3a.95.2025.04.29.09.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:05:57 -0700 (PDT)
From: Cesar Bispo <dm.cesaraugusto@gmail.com>
X-Google-Original-From: Cesar Bispo <cesar.bispo@ime.usp.br>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Cesar Bispo <cesar.bispo@ime.usp.br>,
	GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
Subject: [PATCH 1/2] iio: adc: ad7476: modernize single regulator call
Date: Tue, 29 Apr 2025 13:05:18 -0300
Message-ID: <20250429160526.5934-2-cesar.bispo@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429160526.5934-1-cesar.bispo@ime.usp.br>
References: <20250429160526.5934-1-cesar.bispo@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace a single instance of legacy regulator handling in each driver
with devm_regulator_get_enable() and devm_regulator_get_enable_optional().
This change improves code clarity and aligns with modern kernel APIs.

Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>
Co-developed-by: GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
Signed-off-by: GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
---
 drivers/iio/adc/ad7476.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 37b0515cf4fc..33155f76230e 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -314,7 +314,7 @@ static int ad7476_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	reg = devm_regulator_get(&spi->dev, "vcc");
+	reg = devm_regulator_get_enable(&spi->dev, "vcc");
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
@@ -334,11 +334,11 @@ static int ad7476_probe(struct spi_device *spi)
 
 		/* If a device has an internal reference vref is optional */
 		if (st->chip_info->int_vref_uv) {
-			reg = devm_regulator_get_optional(&spi->dev, "vref");
+			reg = devm_regulator_get_enable_optional(&spi->dev, "vref");
 			if (IS_ERR(reg) && (PTR_ERR(reg) != -ENODEV))
 				return PTR_ERR(reg);
 		} else {
-			reg = devm_regulator_get(&spi->dev, "vref");
+			reg = devm_regulator_get_enable(&spi->dev, "vref");
 			if (IS_ERR(reg))
 				return PTR_ERR(reg);
 		}
-- 
2.43.0


