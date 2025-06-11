Return-Path: <linux-iio+bounces-20490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5463AD616D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 23:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29293ABB0F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 21:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE2D24A064;
	Wed, 11 Jun 2025 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i0HX7Xye"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAC24888F
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677635; cv=none; b=uKneQUsirq9cWcqXJnUyqqgONqsEB5DKUhOOG0E2jc6J9pMEUX6g6d/m2cmOdwH+gGDhki1mhTZUAag+E7ocAee8Tv3jLfhk8RyXUtLQFd60B+lTucQt0CpwGM2oq+oIrNOmEjnkrf0rcfgiD1j5bsDoL2Ufotb0irWfGA9Lj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677635; c=relaxed/simple;
	bh=+UrdvpKib6PZ15hVhO/T6ICol7iFeKJg7nNENfElKdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEh75jaZ8E/Wy03hpj/9R3Xhyq/jb6Nfh1hz6Ez42xTJ7sIQP1CB1Kz+GiBdF+ZHSVK+MpUIYR2t4IplTDRQmq3k7OhtHJabH5DLGxqaU4dhMy35hPgSqtQ4DlPhUSfZcNH3nnSORqCqduyNBDTgEsSr1tRuCDlxkOHV1QS2yxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i0HX7Xye; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40a4bf1eb0dso148117b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749677632; x=1750282432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OTSXfEM4NzvQUr9h5Q4lURNoh1I+2//AZVGJRIuPek=;
        b=i0HX7Xyeq3GOLWAIAqB2C9YDN5SoksCfwsYpgrMJuvhXyooi0O5LkpKrqZVdxGjKqD
         K5siStGPAvRu6akKaxLbusA/PCEqB2ibFIO6Wzvm6LMCBqpe3tzX36ia7OlWE/fZsdQy
         Df3Gpy2iHQ3zOXi3W2RAFfc7l47eIe9wUpXmh3hiu7gpM2fnb7QgtD+cIUU26BmGo27X
         d6AzvQdtHSlD/jNRrZrWmODwmTSw9o88f30LwSOGxTDAYuIAnEF2Wj36NZD8LIarCStN
         4VFPKAk7gv9LMkJcvHuBxT7/RFQW9wjcFMP0DlhHsK25aYqAFwjnI0NTf37Wx3S0em2i
         ZTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749677632; x=1750282432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OTSXfEM4NzvQUr9h5Q4lURNoh1I+2//AZVGJRIuPek=;
        b=eJsDR+m28l3KzyocenpychslMSu6l272A9Urp+oMeeUSzfJkTAmCB+2sF+bDEwMXt/
         uLJGveohBArnDEHCAjAucYb8YbmzXjsTYl6cG0KPfYEbsAMHEvpM54Hu5xaybeuXSkYZ
         U7a/UR137hr/FamAEZmlUtaOahVz9dEuNpbRpETGNxXOoYPG5ge+pGYYL5FKVYpZ3zQA
         t8YcY5c0cR8auYZ/8BM7D0OhUP9ObkY274BuB9in0R74qQd9Rp3zCE7oE+FMyzf3kQnv
         4BtxhXW21QMciU/F931RjjDBR+mpxiXXOs226mpZ7Cm9irMybsEFYOMVTEaH95+jxQJp
         JyWA==
X-Gm-Message-State: AOJu0YxzVMwqfHT3iz57Js+4+IorhIwmJ+GnLPGROB1fXUwwX0FFIcWB
	+jJKTMaNvrdGmAJaA8BwDciLH5xXRaDEF5PA/2wbj22C4GfkHlkXmdSwTMK6pVHnYvcK0+k2WNd
	i6MKX
X-Gm-Gg: ASbGncuECSUS2Fd45+phHR2DkxVCmIp7zt3wBPLKaIWPB78A/LYfVsUq6AqriLnG9w+
	cucyODhBxSezx9sipyE6ZxhyC334RjDIjbTbImqDcFgcMPZrdqubvVlEI1/JINIQ2VFeSoH7Euf
	DfusPZh4v1PK50yZVBRIOmKe90UHq3bxub5c6DfaL0UWAiLu10Sp4U032qUc2/CchF/4259p7fs
	3b+eTn5J88iz/ds0yzkQRXhjLkk6lx4UuO4Ude0OHIw9wXGSX6gkrWvFzaxyvWmsjjQcSi//9Ui
	tc7U1duayQdgJ2+Zc3dnMU4xIYQ+wa1Hc4HbgjqykvPzLXVy6gxUlA5bcuVVcq6Bn9jF
X-Google-Smtp-Source: AGHT+IHHvkHFsG56i79uH3ZJj0ZX2FQ7Uce2eVoVKngIj1ZD4gf1DWEsuu9YbaODZNdOFjLj6X/oSw==
X-Received: by 2002:a05:6808:3510:b0:3fe:af0b:22f7 with SMTP id 5614622812f47-40a66a70dffmr413438b6e.11.1749677632567;
        Wed, 11 Jun 2025 14:33:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fb0bdsm2262b6e.23.2025.06.11.14.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:33:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 16:33:05 -0500
Subject: [PATCH v3 5/5] iio: amplifiers: ada4250: use dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-5-bf85ddea79f2@baylibre.com>
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
In-Reply-To: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=+UrdvpKib6PZ15hVhO/T6ICol7iFeKJg7nNENfElKdg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSfYwMFTQ8L5z5An13XpNpztYa/Fsr66xfTjAO
 aTNC8++IIaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEn2MAAKCRDCzCAB/wGP
 wMYCCACFpuIYSrVhrd9L04vPaIBden76mfr11q1AdvBFTtXXtj4AJawZ9JNmpDY+PjEqr2pdgP2
 8HFjGcGdpEhu0C9femdF5pHA447DPZSo3DaVwB9Trmcxpe7AMvkwIu1JAt38FUwNGqTtfWclV1o
 XJIKiVnOLc1Dw33HdOC/BWUL0/z1epeigIVUTk6X7VkaGcwRUiIBHtkicx5uK3E6Zuqa5ZSNIWU
 52C8AxvgCS7jcGO6ZgoPWw7mXBLBsGLWC6SO3cROfhu32SU0I6oaMKJGoNf8dFld5fwGawlWRue
 L1AjDSHH+p5SozGvPlfUUpsBlzdI2FQyh3KRNVUyX52ZyxXv
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use dev_err_probe() when returning an error in the probe function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/amplifiers/ada4250.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
index d20ca410c506226fce7f172632d46b2ebb140a12..40f396ea906950ab79bf72cdb162794e95f76094 100644
--- a/drivers/iio/amplifiers/ada4250.c
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -351,10 +351,8 @@ static int ada4250_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 
 	ret = ada4250_init(st);
-	if (ret) {
-		dev_err(&spi->dev, "ADA4250 init failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "ADA4250 init failed\n");
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }

-- 
2.43.0


