Return-Path: <linux-iio+bounces-5277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA848CEAEB
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 22:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6691F22166
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3598A5D477;
	Fri, 24 May 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0vWAcJk+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65B7350E
	for <linux-iio@vger.kernel.org>; Fri, 24 May 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583092; cv=none; b=Q+sTH6l9Ry3zScBcTSFw7KqjlCoXz/gJWbxOnVd6a8HAh6xtkr47DWnraPiNvbN0e2ParkF4cVvaDspeaYxRhIR01jgoI+R4sB8aIp07drmvNFspZYUewwbfMuHPswQ3II6BtMQXE91lDYU57Cd+U0RjH5NGG8BaIygZXPueuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583092; c=relaxed/simple;
	bh=8j8OrljIvFu2Et9RmLk4iAykmVaiaUh+gf8m1koNlGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aHk8kis/IdXste8au/mR7OhcI6/rMPzYOg9nJz9beunxogplsGCvOrIu4h5qttm3lKs3FIekzqwSeIxQDBvv7oOwmAYq8xuLALC6x6bVjdbUypJ//3ALf/DCkBYjJIBgcSjSI97qar4ditZfQOLC0yz4kqDcWnfNcFhZ6E0Q5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0vWAcJk+; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b290669b0fso4993774eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 24 May 2024 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716583088; x=1717187888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lAb0yvkmRIH2YjR8NuuhLY/irhuLspeCDPAA3a0v6HQ=;
        b=0vWAcJk+F10usFchgUjSpXLV+xvskFn8rkrSKiMLxogM9VO8QeWEgquyyCMnMGgSCX
         IBAe5VowWqBeDyFBqrOlB0tRhfblPiM03bIK5Pi65XRJKzSp7tNtPXY0EXxqoTGoR62a
         x9p3vwe69a7Vg2ii9b6l7YVWLZwxei6UWpaRbsBVUuoQ5t1fZdmN7/BdfFzJZvYX3+1V
         Uow3AzyRGl9dm/pM5TrpAYy42CaByI3asakFgTgPOrK93uMgEcyaCq+meceASolpNqHH
         GiDewN2YpCgtYg07OB1DTZnT9AfbysTgivd56Dh+MKBZ7evUqihWnwQVLvAwKvaXEGmz
         VCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583088; x=1717187888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAb0yvkmRIH2YjR8NuuhLY/irhuLspeCDPAA3a0v6HQ=;
        b=PojjIJ0p/DxXn5M63g2kGqTJD4fJvpF8f/x5RVcCDL+UEjB3Uf7QVOgpuizHeF8Vj/
         GgVD5WgyO1hYyQ4utu7Ce0yYJ175apgA7tv4KLbMtMYbaHb5i0noFKIr5UocAQkpyOJP
         Ng7G37CJ1Uc0XzMVx2X00xmSVNHdIRzab49PVMzbsfbB3UJFMLiw8HoSkOQC6PKi+MJt
         m8NdYqcN0V1UMYCZ36uwvsD8p9yVHxTnuG1uR2ATBQdOg8Sf79o6feO98wEM9oZ7kGty
         qIZnJrBM/IEB1vWQNySZV2UnZojDdIcg/I+x1Lzjy+CWfqF1LmJouDLniiLBiEa3ObZ9
         d74g==
X-Forwarded-Encrypted: i=1; AJvYcCU2x/7uJEpYInIxjbNrZvn6Gpt0PaeFjL/e/ut04boWzKDKuz6cw7RWUN017jMsdQ4Fgr7kG4M40u/Dhg7P1nfe1B9ypYIDP9by
X-Gm-Message-State: AOJu0Ywo1SmiVrn/ClNCqkGY+hnEt3egwWJkpF5GzfsCcoAHO7rXFwEt
	21bkHNZ+UEI3jAUcn5TcDXO/84Y6JKcW781PrT9x3b62OUKxvqyQFt7UEQQDO5A=
X-Google-Smtp-Source: AGHT+IFmcO1B730qZOExe18PR3yCsMK8Mp4TMxtezp+Z3SNVkxkF/bovPBgfXhsG6dK5UxW31fHKTg==
X-Received: by 2002:a05:6820:603:b0:5b2:ff69:97c3 with SMTP id 006d021491bc7-5b95fe9c7b9mr4391373eaf.2.1716583088547;
        Fri, 24 May 2024 13:38:08 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c462871sm480285eaf.1.2024.05.24.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:38:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7944: remove unused parameter
Date: Fri, 24 May 2024 15:38:04 -0500
Message-ID: <20240524-iio-ad7944-remove-unused-parameter-v1-1-fd824d7122a0@baylibre.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

In the ad7944 driver, the ad7944_convert_and_acquire() had an unused
`chan` parameter. This patch removes the parameter.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 4602ab5ed2a6..e2cb64cef476 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -259,7 +259,6 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 /**
  * ad7944_convert_and_acquire - Perform a single conversion and acquisition
  * @adc: The ADC device structure
- * @chan: The channel specification
  * Return: 0 on success, a negative error code on failure
  *
  * Perform a conversion and acquisition of a single sample using the
@@ -268,8 +267,7 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
  * Upon successful return adc->sample.raw will contain the conversion result
  * (or adc->chain_mode_buf if the device is using chain mode).
  */
-static int ad7944_convert_and_acquire(struct ad7944_adc *adc,
-				      const struct iio_chan_spec *chan)
+static int ad7944_convert_and_acquire(struct ad7944_adc *adc)
 {
 	int ret;
 
@@ -291,7 +289,7 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 {
 	int ret;
 
-	ret = ad7944_convert_and_acquire(adc, chan);
+	ret = ad7944_convert_and_acquire(adc);
 	if (ret)
 		return ret;
 
@@ -361,7 +359,7 @@ static irqreturn_t ad7944_trigger_handler(int irq, void *p)
 	struct ad7944_adc *adc = iio_priv(indio_dev);
 	int ret;
 
-	ret = ad7944_convert_and_acquire(adc, &indio_dev->channels[0]);
+	ret = ad7944_convert_and_acquire(adc);
 	if (ret)
 		goto out;
 

---
base-commit: 6c46802cc0c4ff878f07139f7b7b8774fd43ce3d
change-id: 20240524-iio-ad7944-remove-unused-parameter-d814bb7e1a28

