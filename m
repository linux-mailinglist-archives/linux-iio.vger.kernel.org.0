Return-Path: <linux-iio+bounces-18204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D061FA92313
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C59119E7BC5
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF102550D4;
	Thu, 17 Apr 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Vy0RwhO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F331254842
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908821; cv=none; b=ddtjikAoTtFNZn3JbFVIqMLfhQRN/3dyU4sjUxsE9ao+IqIZg3sr9KuC383gWsItDLwtuywiteOpabMsLQ63VUe1j3kbl7rxwFXksDQVx9rT8sNpzBHvH9kwEplv+m53Du+TBopdaezSZJ5SotUylXFMltELEfgLvwSbcBULvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908821; c=relaxed/simple;
	bh=3GHpd6dz9Xc3JIqdZ4xpPWZT/4sI8qxCKSwerXxcldo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crbcYTDRIYJyzlChCyI1c8cjd7EsDkRx/OipqYmSC7TDe4Hqa/a8kDADaKQDpPqL6hVHLhMO9akkBCMmqxZ9Nw+P5kYme4o5z5dijA+bZQ6YkXc68Fz1dBdrtOd6dhhRWPzwLDk74leloXTosvoFSbVBlMgdPNgjotsbItA6BdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3Vy0RwhO; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2cc44c72959so571879fac.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744908817; x=1745513617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urgZo6HtwVajmJ+VMQkmSQjRZHquFbKRUH55wzxTQsc=;
        b=3Vy0RwhOYHWvFzJuBKMb3CUvGTPKcptlE2NgUMZUNCaUpxhFY7c2kJLE1gRSDo/Kks
         VaC3t4ETLr+Je4kLDU82ap3gwBH4lqXnibfm50PqMZY9KNK6CFjLmXm4wDwN8QhKC2Lf
         S4LTJEFFQ/pfak11nvJoJBzU5++ToOklfDcWCis37dsOhTgHk0k2P26v2+ZRfjAK68Zg
         CKVL/QIV9ShF2oZreWHcQfQOoazikhqFjBqUhhaabVx4ZHeA/+w+4UwUuV5gTKQNb4oz
         ymc0Q5BNFaOpG7VAmC/5w7xovYqEfqzUpxsBgrFWALXbrvlrPMnEPxbEsf/I87TXXNNn
         N9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908817; x=1745513617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urgZo6HtwVajmJ+VMQkmSQjRZHquFbKRUH55wzxTQsc=;
        b=qBuMLavzDoeeKGfUF1V3INgFJ3THz8Ahg+tFqQ0RH9B7GAq3o9lDeG33N6O3YTlhF1
         2xfD1GLk7QT/8mYcI5IdipKRT8K5f5ENR/vxzBHcBhnRm5LI8aoPP80hQHBDuYS4jhhY
         13bnOq4f1a/6W6IAY+faiAUNZfOPN9ngrQmYFH1u1wO96ZUKA4ggpkRupAE6ORA9gCGN
         B35hfSK8hl46jdwx5vfe0js7QZjgfihh8zMM7ptKwHCDwyrq+C5p12Hqk2MCYiVCAGAZ
         kskCVAoET375aDQHGdLB2ldV9pjrvF2mwUUikV0fkOc8US5+thaT/G/54SRy9pEDvVGT
         P+Pw==
X-Gm-Message-State: AOJu0YzjJ5ImES35x7bli+dd3AUXxh/Wz93N2sm6PQC3+XkPLU77lFoe
	yNf+flbeUEkd+dIIdYuCqQv93/lDFWMu3hbfevYmT27tpQ+DDD5CtPpmUECncaSppJdMiXrD03m
	S5t0=
X-Gm-Gg: ASbGncuJUafZNmvVhyuAWM/x6+jtUHU0pvbVg6kAsJgwdEh9oxjaMMMpku6xtsC3277
	RmP2O7scWHDWfq4Yvht8DHkFszdnz1iDts2DOZL2iK8asL7vTlvo8Y7Iqp5tamFT8iE3Zek0lfm
	m5CpJhhA47uUHo9c78oECTX9+BekXOqHyvz7umzW9e37S0bzI9iX745lCVecypKtaWLWptZNCke
	CtXI/m2XaEqK9MY+aXZwS960wolhSpa8aQHLAElVqDyLaJgsNOlSYXa6MgW2Fj2oJ0yDGSTY7u3
	peQUPhvFMHDLULAs/Uh1wGQoKOfVxURyC3HyruyToZ37dyw=
X-Google-Smtp-Source: AGHT+IHBMalnX/GkmDtCv+f1x7qh5UNts/SZQEVLrZNpUXQl72Kd/ilm5X3OIBmpcIcTGM/GMMDEDA==
X-Received: by 2002:a05:6870:4f88:b0:2d0:4a2c:7be6 with SMTP id 586e51a60fabf-2d4d2d3b3c9mr4250599fac.30.1744908817353;
        Thu, 17 Apr 2025 09:53:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5218248b7sm15812fac.47.2025.04.17.09.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:53:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:33 -0500
Subject: [PATCH 1/8] iio: adc: dln2-adc: use aligned_s64 for timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-iio-more-timestamp-alignment-v1-1-eafac1e22318@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=3GHpd6dz9Xc3JIqdZ4xpPWZT/4sI8qxCKSwerXxcldo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoATHapmPoJGvzEiuALVzGsh9ToDLFxuW4TbQ5R
 7lBYAYqMbOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAEx2gAKCRDCzCAB/wGP
 wOT6CACeVDDKfDNuZTZfOKiNnIAEqMI+pxNQ8ap3qk+HKIbWt6YPw0yt3LkJQCHeOlxwqIgeHsa
 inouAIcp1tkzHBI52RUlHaYGuAjT4mOuwX1xy+jtlqm9HMdv3C6noj2PS4Bq15vHyw6a3uW0oeF
 4H+p2/XpeenenXw2Euxv2/O5lWq3DYipfml0HFQqksM1YrWKVypQyZfdvo0u3d2AlxyWycSPe4n
 RET1aMX1SB6MTVEiOjzHoiwMJZUuLU1jQuOQ2ByivQ2sgtWhZS8K5jdFoK3aKGZoHCIWj7Hc25s
 EEH/9/vc5VVzuUXZM2GyUsQdjFzpmuouco4AsTHhf8uBlBYe
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure the struct itself it also 8-byte aligned.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/dln2-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index a1e48a756a7b519105393f77c4aebde1f2f85d50..359e26e3f5bcfe16d723f621bdfc01df2dfcf6a9 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -466,7 +466,7 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct {
 		__le16 values[DLN2_ADC_MAX_CHANNELS];
-		int64_t timestamp_space;
+		aligned_s64 timestamp_space;
 	} data;
 	struct dln2_adc_get_all_vals dev_data;
 	struct dln2_adc *dln2 = iio_priv(indio_dev);

-- 
2.43.0


