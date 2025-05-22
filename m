Return-Path: <linux-iio+bounces-19797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585ABAC0CCA
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 15:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E83165D8C
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C9C28C2B0;
	Thu, 22 May 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pDisP2xz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6C228C2AB
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920595; cv=none; b=djFjG4ktb2gkG+IYJaWftfgpj0X/fwltEy5WCT7LwZoKGekIdXXhY2X1GfeA5sEIpzTQQ1KRWMj+19aCdfBGTnTXcqFWat4+3Xx4g1mY6IisEJN8Zvo6izV79Gp9rOIW1SQ8y3AZCMk25asl4ce2gzYwEyJ09irXoze9LIJ2QuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920595; c=relaxed/simple;
	bh=8DecWNX9a+g7ci97Vv7IU6U85+eTrGoiJDNqhMLAwD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXN3slf2NOW7VI6Yim4vOBmoWc/6WhDlRSk0vasWw33JeorcO/B5A2Dsz5ZGEB2GOBBsmeD0y8U+S3FpanVzy0XzkPy1R88/4pBTTAt2GOR5ccjwoS/btlOhI8v5yVoePyAc+8/tAJ+c+kw37NdOZEV+5UxYJk6qIX/qP4hJYjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pDisP2xz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf680d351so54921765e9.0
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747920591; x=1748525391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQIoahuutc2qqjFxwM4CJBJC7cg2fQ/5cUj9Q0XSXuA=;
        b=pDisP2xz+HijpEunsNT1wisqfHA9xTVmAWD3ip5nUzc63Etm86tAK/EbwCBIinhPTe
         Ywj2qAIAUrxr1xhImiQdCqT6gNYSWvYyEtCwTNCK97tkPYkcdVw/cdotbgxxOMQqCJdB
         //FkyPyzTzOfgjz8b9KFmyFx+8a0Awg9hewL7E3cxLt82L6GAy5xwB1ig2iOFsK6nnnS
         KJgGm6ZAQ3FX+8q5hFMXK2tYV9pmAthIRUiHuZchCCJIm6+dNqz9S9Jt/Qdq88+QtVIa
         OxZdyyB3MFRQ78TGsIYWpwgVF7RTlXyZLmcEO+pV8WwEJfQL+XtEjDY9qp6e1xq8LfDv
         tpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747920591; x=1748525391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQIoahuutc2qqjFxwM4CJBJC7cg2fQ/5cUj9Q0XSXuA=;
        b=KXDWeo7iAbD/tqJKFGtuctZHkc0fEtjkVOxJCDRR7rVYpQH3Egdtn9M43zcP/H2WJZ
         JUd9jVBKasJy7NJwXSArM4+GziBcpA5bqmDXNgi1qAGyG0nkgsM9KS9OguOWPp85Pqlr
         gb16UuU3LlNM20p7DU2qZMrMt4QpAzxdSwxm1vFN77EUri0Z8cZQLkuZ1SdBoNk2aGi3
         l8K5YynMw912AQC6eb9OXnfAUE/AqDKWLhMIrMmgQflGVcQT4uUEKElqG20d3L4woWvc
         n03GkPYMbXd7w3dWZmP1IMvj+ZjjzxTBg/tjM4giL6gSgjwFkraGqmTLEOC6vr3RLxGd
         sBrA==
X-Gm-Message-State: AOJu0Yz/9lJTVT9uVYfyP9Iz3u3dni65yq9MPnl0iO6DbI3PhJKp2A4e
	Hx79skspLE4nFICiiIY5qOG+SuDjbDs62x8o1CVGorbOcsnxyzZ+qrLhKn0cJkVIoIE=
X-Gm-Gg: ASbGncuRqI/iGqe4BsXvtiGiecvHuip3adttl7mHvBUEOsxZlDtrmZFLAY2jXa5qvWx
	yuEWBarA5D0I3csuMTNjpx89AZrshehM6mYUDpZKPkmGMpRBCo0iIa0gFGEB29Txr+8n/0uCuSd
	BznjYnsEhD//0ArmHC9vFJBjh5qCytZNCSY+YXB98z65v16co9b5FqItBSxDWF51A1jO96PzgJY
	H4KD7VfssBRxuZi6dleWiBDCYxSUALEBJ+jKVwOhzWY4bq840KiqDn6V/RaWeLJk70/uvZOoXmB
	RjMajyX7/JG4UmCWVPs1Q7Yv66/mtzcM9PCXu8npMU75x2lQY0B5Ud7UlMcjE+e8RKyqNqDCZiz
	+Lt2usXztipSwn5373gF929POBSGmxh8=
X-Google-Smtp-Source: AGHT+IHue17ZX9mw4ey3hwkVeMQ6JQCquCW3Ynl5s+S7l/UxkzY5Bqoj4I32hyU+LDWChls+robRsA==
X-Received: by 2002:a05:600c:5295:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-442f8514e9emr270779675e9.12.1747920591505;
        Thu, 22 May 2025 06:29:51 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0b20sm109837585e9.14.2025.05.22.06.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 06:29:50 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 22 May 2025 15:27:03 +0200
Subject: [PATCH v6 2/6] iio: core: add ADC delay calibration definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-wip-bl-ad7606-calibration-v6-2-487b90433da0@baylibre.com>
References: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
In-Reply-To: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=4Hb5fAw6wk9UOyjGvMGWLBgqM5yKlaYwdF7azoNoMts=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsjQV/NLN312tkCt7MRNx1XzP6tp3D0T16i1jZNjoWlp9
 6tVG2aydpSyMIhxMciKKbLUJUaYhN4OlVJewDgbZg4rE8gQBi5OAZjIfR5GhsnLHlX6eC3U3i/6
 ZEr2Hl1Oh64MH/On61Zsz1vcz3C0ez7D/9QMS9/mApnn7WJ7M5UafHeUSt5ezc0XUXt7gojfVKk
 7XAA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

ADCs as ad7606 implement a phase calibration as a delay.
Add such definition, needed for ad7606.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 178e99b111debc59a247fcc3a6037e429db3bebf..f13c3aa470d774bfe655d6a9fb00c263789db637 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -188,6 +188,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
 	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
 	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
+	[IIO_CHAN_INFO_CONVDELAY] = "convdelay",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index d89982c98368cf72c0fc30fa66ab001e48af4e8b..ad2761efcc8315e1f9907d2a7159447fb463333e 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -69,6 +69,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_CALIBAMBIENT,
 	IIO_CHAN_INFO_ZEROPOINT,
 	IIO_CHAN_INFO_TROUGH,
+	IIO_CHAN_INFO_CONVDELAY,
 };
 
 #endif /* _IIO_TYPES_H_ */

-- 
2.49.0


