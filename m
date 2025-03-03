Return-Path: <linux-iio+bounces-16271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A1A4BF36
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E0B165845
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A620B803;
	Mon,  3 Mar 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AGX6qDMP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444320B7E6
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002464; cv=none; b=G7YcNm7qWO17Gqfc3cfV9sFR2pPGDnI+dWS4DUn75cQ/Iac1aIOllnWhHuXS8Y0QUN97LwZ9vRIxEiWdQMUgl6LZJQAYZPS2Lcj3YGZpj1OwJapePFaXn0mejCkZyV9IMRY3dADGbYxF8Xr5TNfr0GtBf2z8vW+xBKhwEd5gkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002464; c=relaxed/simple;
	bh=aFcJsLIM3cdSSP2ZKtYFolUMMu1Z1B26+vDxNxrArwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LotCfkF7LRH4XoO1QxTio4/p7BEcEiLXl31kAyC/OUz6Ux/QnXTX9/6d4eWSgMtuy2FbSHZ65oPjazdK0tkQ3i6m6UOp+kYp/e3OLLuQ2WJ6a8Y6/5E1UvhG5g+pe2637ZvwytA0iOqY02MHpDF8213jxavvQE57YAJuaCIKEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AGX6qDMP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so27117635e9.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 03:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002460; x=1741607260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD2W5spHwFZMZCXHsDH3WDbcND7HpNlEPuCt+X3A6+A=;
        b=AGX6qDMPKzBrT9uAU9WUWlrmLa/+HkboYORSa73/SFeeqQ0BFjy13DC4NiQhQXKWJh
         8yUinCsNqAjGnKGUMz7AYnSXMvHq5x2q2dtiUmlvEyRH1LE9xS4LP6gAxlg1BjM2MoT9
         +S0Mk7SmkXdDg9D/qi3XIrKTDDQdcDLabvnTcEeCUXl+K9Cw7+RWvjKz/YbyNo3NjxvP
         7Ie/zqY4uZVhKQy5Qix+UIlnwK5UPT6ZXXGrEt2y3h1OLALc/K0HBrbnAm+QPK3xCNbj
         vLce8pDOz0pNrG7ezs30i/W7DYOOnIzlMaaZP6xOTxZImtlFpvbhKoqvxaKnVNHqQ08A
         SIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002460; x=1741607260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fD2W5spHwFZMZCXHsDH3WDbcND7HpNlEPuCt+X3A6+A=;
        b=O7Z7CO7eEpsTMHiyfXGE4z7K+tn8ue8pm2lmmrHE2V5jcW3cMuPznidL9Wp5IYebYn
         iDUX7mtx86VqP/SLkFQJkpXtQHlweexGPBFea9ugxjofDp99yuu57yUNh3QeiLHMgdSo
         RNigTglledrf/qzIbEmlpKfOyi/Ko2qNYlR/iCTrWathoCaH/AlnBKDJPVE0+QeBVLN2
         DUX53CkWw/lqdQ062iOTwoYOYD9rLSQze34db3jLdR6YRo+C8WefpWiUD/6wLx1gJ0du
         ghNImNIyhtq4BO8uVbsOTwjbkXpX9CMW+WJaYONlrRrhzktEUSx/kFaUtTndLc4zl+IL
         qyNw==
X-Forwarded-Encrypted: i=1; AJvYcCXMaUFh18L+7zyAj3NTty9Dw326PIEGOP4U7ib33C5ChxLuI7lmwP/qEhBC94PlK7cIzOhPM9u9Q2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIcKe1Ztp3M5V2QUhhWP9I7h/bP+IaKtN8cSbTenyM1mzc4kl
	zpTgx+vGavldxj4qdLdUsF43mHyQJNDync/7ujXM+7F9OWJ5sbpFyz7gDr7Dnfc=
X-Gm-Gg: ASbGncu1ebJd1a2ZfDV3gMG/QrYZ0Oy1lFgJHLSCmRbLmtHao1QprhKQ3dbscKJxNZP
	v1auaRGpI5lj/LqaGZzXnPQSvbz4lBE5b3gYeWAkyAr3+ZhXD0Z3M7dtBi0yGadRdWfuKZOGz3y
	DCwk7YdXLWyex5bwzH3CTfPJ6bZj/k03uzug2/N49lSN73qJKpXFZxjbDdR4buqsl7XPgsq3Oxi
	8icNkoUtwLovQ+WXEpihiQPyLWVjUDeqCk6HIzvIA2vd5sfnYF1oahHYCx51krZe5VFqTKJZHNk
	bvFZUZgICVnDRW9Y5/BRho1W3R5eRMqKDp5i7yZ4NGsPFRjtItmJuhhyeHpT1EdzbK1ZCqz5Rq4
	pon2X9zupzfZan8zmh9gmt1DlrA==
X-Google-Smtp-Source: AGHT+IElYqKKYXWK0QS+vSvd1EzRFOK/gfCXSM63txcjRymmf2gCmddJGZCNMDVgYWJ66ef9goIAiQ==
X-Received: by 2002:a05:6000:1847:b0:390:fdba:ac7 with SMTP id ffacd0b85a97d-390fdba0c01mr5447474f8f.51.1741002460636;
        Mon, 03 Mar 2025 03:47:40 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6ceesm14101702f8f.45.2025.03.03.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:40 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] iio: adc: ad_sigma_delta: Disable channel after calibration
Date: Mon,  3 Mar 2025 12:46:59 +0100
Message-ID: <20250303114659.1672695-11-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=aFcJsLIM3cdSSP2ZKtYFolUMMu1Z1B26+vDxNxrArwM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZa1Fla+gzXLCTT/KwY3Cm6Y677bJqeMMk3Jr pPPpuRIgiaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWtQAKCRCPgPtYfRL+ TuwvB/oDIs1C/+avbqlmD/ajiAhUAHnJVsoJGiLUjXEcP6OGyC8yiuj5gKTQK7rO3WhoSMr90Kv 0NjN6uyKG4p5cR/qAg+DxdArV2cGa0yThd+juLb+5+NLkYCuC47Jtsi+1BfnMEgwZ+WZt2l+lPW zNViNP+m7lR+UoOtcsllw5EJ5/0rspBxOVtXPCswhNUcQFj9IdT+O+3FMwMvhQKty2n5hyuFOI8 8x6nHDSIl/XUZIzycmnNVt2aK2CsFjeg0FQIWh7OfnwyvDn72yyzCumw9VDjiYoBgo/Mhzk9IMk cPuJejXqM1SpvQ+boXQBD1mtyT/L4nnJ2z0zGOgRA3Q/wcpm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The function ad_sd_calibrate() enables the channel to calibrate at
function entry but doesn't disable it on exit. This is problematic
because if two (or more) channels are calibrated in a row, the second
calibration isn't executed as intended as the first (still enabled)
channel is recalibrated and after the first irq (i.e. when the
calibration of the first channel completed) the calibration is aborted.

This currently affects ad7173 only, as the other drivers using
ad_sd_calibrate() never have more than one channel enabled at a time.

To fix this, disable the calibrated channel after calibration.

Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 5907c35b98e5..d91a3ba127e3 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -339,6 +339,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 out:
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
+	ad_sigma_delta_disable_one(sigma_delta, channel);
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 
-- 
2.47.1


