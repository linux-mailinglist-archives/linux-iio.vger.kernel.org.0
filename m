Return-Path: <linux-iio+bounces-15436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFADA323FB
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917CA161F9B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06B209F2E;
	Wed, 12 Feb 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EoB0Qjj4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949A1FECD2
	for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357628; cv=none; b=QvUFgB/NbjLxc3Gjs6qZJ6OEvUarX4keEP1IpklDCLh4i851pX7lwawsAfetnx6VUU9YAoXvy2Oytserij0ic4nW3ISJmuwcwjhdvhznegfB3UMN5V4vxkGnCGjQTb7m0SgcC2JYpCRInTZd/NUWApCjp2wrq1IEisMayIq9NSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357628; c=relaxed/simple;
	bh=FaCcjfN7tsH4OS3ZlgvormgYVFIHIhRR3WXL4LQvN/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ra+/YVD7pTpsPjQWAc2PVlvv8h2D7Oiw1TZOIFdFcbMSJjLpQ4/JOmbKAjzXPDtFHLSjRjA8ioKl+yi2aKrdNmx8IL2X1F9D5gnvoNBlLoTSISCyM5LcrztOCHoexdaDMpGBV5DWHFjOegf7fyjnStrUaJnwincgHBvDNpO6jvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EoB0Qjj4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dd14c9a66so2012222f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 02:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739357624; x=1739962424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qua5MIP1F2+Br2o7DhnfriDyRSWtUQzguoJZmEBlsHk=;
        b=EoB0Qjj4KyePU139rDobsdabhf2rWmUSzIEN5f6A6CjrLR6cQ29OlDUraAPo4T+UQY
         4pRl9ujCbE3tKc8smyLlVgfsIA3DrfPRFOIPJ3PcZMU13Fxt6jt6ehPGP1cMgGNBsDGh
         TvFLckPsMPUc9cOUH9O3K/DW0OFRk64yWbWRNz1rQ5kd30K3Dhn0WEGwHmcj8uG0iJM/
         hARs67YI6RqI9GJzUp9jaYI9KQe6bq9h0GTKmqhCDCF/SBXooQ7+6czAlUTii+ea31QS
         a5o3FQU6kPX5lJOJmxIGMP/XHDex/xorRwbeP6IpyPP9Bf2qKl6KJd8qHHp6zehNNvCH
         Eh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357624; x=1739962424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qua5MIP1F2+Br2o7DhnfriDyRSWtUQzguoJZmEBlsHk=;
        b=VvY5mF9gsRCTLiBZBzmM2qsvGD2A5q2Oa+qU3zCXCwq8pWUlCXPIuMF5VtygaSxrlI
         IYi8aS4WsAklzKdo0/NYMUTIjoGpE39kIn4TaUsnGR0VX8QwPzS2ztH07f7FF7l0n/6Z
         gAWPDSD5JlD5fA3LW2nST4sg3s0/Pt9tYNBdDi2QooA3r9LC3mTx1fgGrPEx86anGq3c
         bR3qFTFCwzadSZuTPZr4kltUFeWuZalvgVbkbWMyUi78JKc2FArq7GCyMQ6f3EuxBfQW
         sd1lg8HQA+XrgwNIDDF5p1pO6P5ZcCthPd+2C915aDO0ReuRbcUiNPsV6+h7FSUC1DFX
         OqoQ==
X-Gm-Message-State: AOJu0Yyahi4phtZW3TdcKhsL3zqRZl5TlysDDpa1IJKr3FyzOy2eqkS9
	XGflikba0Jr8YROks8mrrk4CSbquMXrzrPjqIhdXO7UTGyyuObfs9/odj2Z4xYY=
X-Gm-Gg: ASbGncvrfNC9gIgmDrweiE3wokCoZ9G73zKsy6yYcrZBE7Znx40ITYU8LxBFCEwwTfP
	Uehz8KFNpDuZWOF2B4MekOafDaiKPlcEJ2G/Zid1ouikwUy6lFgR2MaLJIfar3bmLojGuPud4O9
	iTPOX5r3+l4821NJEHw4z3AsNEne3brEhxjYoa40+MYRQsybFbDtQvy4e/FdcKvf/UMaPZ21Sio
	RaURtWrwKGH1vIpDojjSgayI0sNb9zuZsUzucFCuKlFZD0L1+cB4KGdRgLqcwzuPrLGTl67J1pN
	rKNaVR0N6i+VggQgIrteRo0xH1zUaeoUYdj7yNImkiq8zD0yrg/iS1VD8ixvKgaGFIwQgfueNSv
	WNA==
X-Google-Smtp-Source: AGHT+IFWPugSZjah0wRf2O2mkPiV3cBZZ++fO1SA6jVTzyEaEzkOGozJBdnn/r2UERW+T2mlydaoQQ==
X-Received: by 2002:a5d:5986:0:b0:38f:2224:738e with SMTP id ffacd0b85a97d-38f22247752mr87839f8f.1.1739357624456;
        Wed, 12 Feb 2025 02:53:44 -0800 (PST)
Received: from localhost (p200300f65f083b04d1ced5eed56c82e8.dip0.t-ipconnect.de. [2003:f6:5f08:3b04:d1ce:d5ee:d56c:82e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc6c80df2sm15470586f8f.18.2025.02.12.02.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:53:44 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v1 2/3] iio: adc: ad_sigma_delta: Disable channel after calibration
Date: Wed, 12 Feb 2025 11:53:23 +0100
Message-ID: <20250212105322.10243-7-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
References: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=FaCcjfN7tsH4OS3ZlgvormgYVFIHIhRR3WXL4LQvN/g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnrH2nATxNncXDFFinO2K3f8zT+p00P7RAhUkOT 2ucwJV5w5KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6x9pwAKCRCPgPtYfRL+ TiYvB/9Q+K0ReIOfQK//Lxcs+BUrpXAd+6h7Hfy8Qus2kAtwcJC87XQez3MbgZ0acgm9seXMqIi bEziGRAlhg0VqTqGHbLn/cSi2S+2SlqP90HDCqZYrS7MVKe8lU5UeEEQvggP8H2M85Tbip2Zo8u CqnKplZUSyUkTjPXkwTGzBS5jDZTf6Uxx4cbksjtEYW41+2tqsvhS7vYKclrvjM+gU3ZXg9CmDZ N6+iDchTJLnXIbFvAAnMM+FsyRvTWPsIUs/oTbWgX09JmRV4JNDTaPkwTemnKxnnIc6P6rvTpho Bt2wpWAyVx8BTrzjqYQuIjJ6aucksV398LWCdRaZYw1z3rh3
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The function ad_sd_calibrate() enables the channel to calibrate at
function entry but doesn't disable it on exit. This is problematic
because if two (or more) channels are calibrated in a row, the second
calibration isn't executed as intended as the first (still enabled)
channel is recalibrated and after the first irq (i.e. when the
calibration of the first channel completed) the calibration is aborted.

To fix this, disable the calibrated channel after calibration.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 10e635fc4fa4..fbe241b90f37 100644
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


