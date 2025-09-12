Return-Path: <linux-iio+bounces-24026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89169B55475
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 18:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09C61D68314
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7331E0FC;
	Fri, 12 Sep 2025 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y6PZO7nO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2631A06F
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693222; cv=none; b=e0Onf2hfmYAD5vMdi9oj71lJzU7vp2k+M0iT8o3RdXSUe9IcAXI28kI7a85liUEMeCtG3LJWQPHDs3NNBZ/pp8wheg3eWPQCfx02ZMKC/B1xqL0ss0Qt8x9wiS15hvO+aJG9O2gImh7qF3PvUyXS/02GW/gIuGcDpSxGs6k7X+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693222; c=relaxed/simple;
	bh=KaHoQw0mmyST/U0aIeT4Q9rI2vx9p1nFNJx02h4APhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aP9BjkmJCGMaKwuKvSz57UAZgxgN3bTDWT2OmU/I9Elh8Xp+rxzTg+nd97ET/JJi2vGp0yHP1lHAVWGldBCnAdzgrlfZ1/EdTUSoPt4CIAWP81xkNZ29EFT1Wz6eEdftD1ou3fFxX+dzV3FneX2wQEQJLEbOu2mk/UQL8FPOsAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y6PZO7nO; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-750c5378b96so953669a34.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693220; x=1758298020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JMI9MVOYcVBfLvH8OZk7vA1oBEfGyZCnmiKgJ+DDsE=;
        b=y6PZO7nOUuIZ7APexAnSg9kAPk94gQh1ZaacpkvRvHENlAVU+MlRsqINWkhM1+/4Qm
         9x57sz5AjPGObr34fD0TBGfWM7xf5k6g0xMuXPclEwRBB73vhcPe4OGC17wXW5fZ+yBK
         22PLkLmxQB0cS7UGg4y/nIFCgWI3KA2zyq6Lmc6Sob5vQ0xw4/uNKgMfZ9mumcBtKSMS
         UQeHGHXfQe4G7gkUR4TI6FKivcfdyiykJmYFHBf2AzuqNq/ckkjhps8X+vRVMbS9Ra04
         jQYSa2mIrxio7N9Kt7Byv0BhddCs8ezKsPyJpF2PfTSkYVIkAhMJtcxOQVzP8X3HCDxI
         IPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693220; x=1758298020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JMI9MVOYcVBfLvH8OZk7vA1oBEfGyZCnmiKgJ+DDsE=;
        b=f3zw490Oyhv0qPPe8cbRgIxej57A0jB0DtK+NgB3JLn3hdlCFlb1U6Me/DSQwM9kzF
         AFbv9ZGjzUFj+iAg8VGF6Sb21VUtiVgSqCXy88cWyP3FMd4Mzwd7qLBSicZVNwTW2vAt
         5jpkcSDNvoNyHMyjxPgqpBAK/C0XRLDOymzlP6v0EYPqIn2yHMzPFK5RvR+/79mAekXF
         ecHPRF2Hvzs+W3Ttnq4KKMGiYC6fqc1s8lUtEJTRtCra9Mbvb1O8CVXyWjFVh47zr9Zk
         BAy53HJ6rXHaWNnXiagZ0kyuO+pq8N0TRckz5OjXJfVUOkv8g2gEiyzNUB8eqbTOtBav
         7sSg==
X-Gm-Message-State: AOJu0YznuWngnQAcS3SEk3o8YKm99plDkJwSDC7YY72PopE0wMz6VO2K
	Qsffgb+bte6wKEeXhxACKvhwxgPKBqr0ncv9KYYeVu0/wDxpWPIIW+V7XsgvLkZ/mqq06vQoZiV
	rvq9TRFI=
X-Gm-Gg: ASbGncvykCizb/mGbkNQBcgq6cyoERB1qPLhqipMUEeoB7rEauU349x9R3bY5UkSd8i
	MYfEMq3cX1XazDIQs67/7BMn5hl0h6D8MyJln/CoZ5C1K7MGmfdBf2UtHarfWxC8CWwsGl9n7vT
	1vQgXIWkA15Nt/R2gIC1oLmXO5D/D6nTCqStyoYYHMUj+Gx2NjwLSPhtyIAimOaiM1p1/k9H5I1
	42iu3GYPNcEDEK5BqTLPIWa83Kwg5J7BP5Z+OF7QO7FRQQ6Gagz+dM3YPInshP1HgOaYsb83/fg
	1xgge5Z3zc/uq7RK3RwC7xTYqeBf7LnPY9gzXToXOIwDPuyFhAhbNf8lGAMSJZBjqFSsArFEsmH
	C4sEwlOUVdY5sEtlDosow98ftTpb0
X-Google-Smtp-Source: AGHT+IHR83aDf55HmRumLiDPSOEZ9D55gCZKcrIqdECPELy/MTrd8ADPd5s3UvKrROq1Cu1OPbLGRA==
X-Received: by 2002:a05:6830:3913:b0:745:9ba6:d33a with SMTP id 46e09a7af769-7535be1b2a8mr2132006a34.16.1757693220185;
        Fri, 12 Sep 2025 09:07:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:06:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 11:05:56 -0500
Subject: [PATCH 5/7] iio: buffer: document iio_push_to_buffers() calling
 context
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-5-c4aad013d96e@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=935; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KaHoQw0mmyST/U0aIeT4Q9rI2vx9p1nFNJx02h4APhA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxEUF/KoNVwqQY4RveF3k/ghdB2BFsSXnRaK4I
 dsE/i6zhqOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRFBQAKCRDCzCAB/wGP
 wJtiB/9XfHhUBee9g0ZSA5bl/wLostMyQJW3Qd9xT03YVBLpzQCwQlKZuOxVxvwS2xANeqQ5rp7
 DKNUz6wS4sLIQXJ2xAzEDjpbCxs4Wq4PXmnOLN6XNCLlZjmLzOTYAWsaq9Ez2bL/bDt024RqMOL
 PRCsghwMC2Q0zcQr+dEzCMjaKRo2IjH0XQT4gAgAaybV61lsm2DxQazzsnSuCf3BnnhmY1GQGX5
 HsubO2T+8LbLV/BKdYr9YFNLqW2mmyq6ISVJsLWRnB28HKIuMEUCXu3qztRuDceutyLess3jEA5
 1FTGELCLDa+CmbMe/PKk8cDag6cNyRe75zO2V4IG1erLTclA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document that iio_push_to_buffers() can be called from any context.

Also document the Return: value while here.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5599fa37b698dda6ff126496f62939331c12f524..f1448ae1b843fc577599fc1b9cf6d859bba226f1 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2372,6 +2372,9 @@ static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
  * iio_push_to_buffers() - push to a registered buffer.
  * @indio_dev:		iio_dev structure for device.
  * @data:		Full scan.
+ *
+ * Context: Any context.
+ * Return: 0 on success, negative error code on failure.
  */
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 {

-- 
2.43.0


