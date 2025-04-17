Return-Path: <linux-iio+bounces-18208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C949FA92321
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3942F5A70EA
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767702550C1;
	Thu, 17 Apr 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YgAR+LUx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF42550B4
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908827; cv=none; b=aIlxAWbuZ5nghiJd14zH2D/2rgs5Sjf0bff9+cyMuRbfAkxutUeYQUtJ5g2ZVSlxiKQ4fZj28JSS6wfKNYUlxe5fjLdZD+tSqN2cgp5LiOKqWK9+f07xDy6XkWaK1zBF1ZpfefC08EPNbZ8HQ4psJcSVxR3IZ9gO+/34Y7zh1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908827; c=relaxed/simple;
	bh=3yOfvG8p2c/ytiXdb5sEiM+QYDtKi9bavtlkBMDyU4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eo0Pn3pLtsElJWFmtJKKWydIgOQ9naMsLmdCwNYbWWcxJ7XIdLd+vNeaq+4k23IjCqmdOpL0rfpGLe+sV27fpYZjYGKlKVLqHBu+JpF4bAAjHOVgayjoYm2GDZ8BzIWsFF6m+/4Wf4bYWP1R7QStF09NOxuW327zezquXKoOEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YgAR+LUx; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so282387fac.2
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744908824; x=1745513624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE6SxxoVsu6bAOJzYvjRfaMyKOzoyxv/L4EKxjSDtow=;
        b=YgAR+LUx1++aj5vDZ98lgwZviGZ9EPKJRYLakg9j2oXe9liv0B9NZd5hIEqUNr+tUZ
         nwQI6tRfrdoj4hysZklobFUTh1JGKDQtITMJpjHcJIGkzSedtjzm9UVHa8re3I11QeDz
         Fsf6ib76v1izlPsOSLcujJ/3/+sG78Qt6Gx0STS0P4P4YaM+v97vfQBPsLSHkr7kpq19
         1vqYUJUVP/dKAQ/9XjWpL9hn87ZcjkX9me0ZXHFpdbKgwJSywjjKy4boAzXR2zRycsmz
         1KmsJXxA7FIsCvsZzPN23AoNP67UU1/VRr1IOqO3puN2bHFw5GMl/RohonCdTZL3jsql
         6XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908824; x=1745513624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dE6SxxoVsu6bAOJzYvjRfaMyKOzoyxv/L4EKxjSDtow=;
        b=A8C8hlj4hpOFqgO2z/TYQnegUa8QwaVGTLpl0+OJPE4F7KdSZ7OGPzV3WAkrX1kCG7
         e6QW1j8SfEQeRCcv7rPeLXrxEg8zCkAXKuHKa352YoBNMROykRn9+mor6+wPcjQiaQ5T
         U0UYq2ZhhS3yKEqjm3EU4vD47zpQcrCEAOf3GCKV3Nqv+IPzvIrrLZT38ww7pZBOh+/7
         E6qdhIzAhgtesFg0bARLFb5pLxfUPX/jinVqW3MLegopks3P9ehoeIQBMKdURR8Yi9Ju
         WPQHEiqR5E9goTZ9K9pXVuWHWWdeFCCWZZEL5hXdbw8YS0MnYx9AgNJU9DIEV1fmaWLg
         kK1g==
X-Gm-Message-State: AOJu0Yw6PIEFffHtPX8vsXSAFc3B9TfZSxNAce20q1Qu9NH2oTZo3Wzp
	8u/ahN3MQO7t/yqQ2hFp2juCmrFzkfJRqVlp1q0uUDjT+VtxrHd0XAkBE42kzP+5HtaeCyPjVEZ
	yNxo=
X-Gm-Gg: ASbGnctx6OK4qJS/JZ2hba8XBWrmy+qLp6MvWk+ietIV2dHaiKjlPlAyRYNTUx9uljY
	K3mf+xD32nlPbex++Aw+8KdV1BjMJyvXHf1fb7OfhQA8BNV7/IZ7TKuqByZpf3DjAp2nHTvI26h
	Y8Nm0IKF2ow6+ea8EolDQhG3iNOVUtbQdxb5aPMQmK1gVUZEGDY7G96ej4UDK4yfaFyT+Jvyak9
	C44oX5kCXLa4HLhxQBbnlaUip3EOzYxukdL28DvZmA7Kgiee6gxmLL8k9kZW0glxKncYwyMM//h
	xF15me3+BWaPKBu505fx7HsbWlKDtKZJi1gFthbUzMJPH4E=
X-Google-Smtp-Source: AGHT+IERyfliHqOpjlqcDa7ZrMu1+2ERYktZP0hnNbOKPHC3D9PzMn6Rl32Ql9yI8ux6efJekwkBJQ==
X-Received: by 2002:a05:6870:51c9:b0:2c2:3a7f:e702 with SMTP id 586e51a60fabf-2d4d2a698cdmr3439263fac.11.1744908824620;
        Thu, 17 Apr 2025 09:53:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5218248b7sm15812fac.47.2025.04.17.09.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:53:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:37 -0500
Subject: [PATCH 5/8] iio: chemical: sps30: use aligned_s64 for timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-iio-more-timestamp-alignment-v1-5-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Tomasz Duszynski <tduszyns@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=788; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=3yOfvG8p2c/ytiXdb5sEiM+QYDtKi9bavtlkBMDyU4A=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoATH0x2omz5kJqpY0JXJ7mnTmq6wvL7fWawMYF
 Tw/lLU9/AKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAEx9AAKCRDCzCAB/wGP
 wKMdCACE2PBpPPcevzJ6YTHViUZU0pvKAxxOAJmdKbv9y3bksVEOUfx0P2P/dY0jsWLIEXzBaDr
 5y9dHqAC7o4dmkMKsZj2Vh5HyjQUKEskgopiCeIeGcMi9Y7Q7LEwfyaSnoR9wy0UrcrESvMTHb5
 7fnFE+562x0uyC5FtFHUFXolswx8YwAwCqYXOG10SGEXfGRc3qapr13FohQ/yFIzWoRK/WCqTkk
 xT3YnJTSZ+L+6Ft/jBhKe7FA9oGDUvjJf5gBIP/yJBAuEDVk60oAwHgT2GmlAztKoFECtHnxReC
 XCzUxh/dcdtae/HvWj37osRH2cBNtm6nubyDnKWO5uRYaB7z
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure that the timestamp is correctly aligned on
all architectures.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/chemical/sps30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 6f4f2ba2c09d5e691df13bc11ca9e3a910d98dc8..a7888146188d09ddbf376b398ee24dab7f0e2611 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -108,7 +108,7 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 	int ret;
 	struct {
 		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 
 	mutex_lock(&state->lock);

-- 
2.43.0


