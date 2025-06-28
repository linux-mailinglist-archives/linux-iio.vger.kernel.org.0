Return-Path: <linux-iio+bounces-21063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2960AEC92C
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4385167FF2
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850E285CB5;
	Sat, 28 Jun 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kOSzQ18z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE5284681
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751130103; cv=none; b=Por6S7hQrX/qSy1ynGjjGyBJhFJJuxQCrihmE0sIgCa9YksZHq5l1TyXbNSCHG0ere22UQAuCJekOXz3BGA9LjxfSUk/fUwmTjraSHYON4iYsLzsiUKSYJiMFnL+adujTWl1znP1Ua17sw6DWDghM3y8Fb4Br42yIyWo4eX/bg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751130103; c=relaxed/simple;
	bh=X2KSmb4HCsHC/HeHjDlqJkqmU0XZcMUMkV1bUX/8/sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qtIxvquQh+cUTyuZHGGucYfkZmGSwL1ern/Ex1CGxQsH8RvBSGKcPnelsKTMUPSNuJLQvAmBTYmjjj2bEDU8T1N9wf45+yBErHuxyjlq3YmPoZpQM4h+ezAAdQ/rGIaGkFJoVDYYrUQN025gIhci5PtVlk2wgZP8KQxBaDq259s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kOSzQ18z; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2e9a38d2a3aso793908fac.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751130100; x=1751734900; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNEn7suD+Hd2kWZGGFYZnjdopPtytgcb/jMssPmD/3o=;
        b=kOSzQ18z5Z9Jfi/4BSfxTCFnyflQT/yAfKOBNd0Hiu0CdY2WgusLSGCfYRdW8eDKL5
         UjW5Czta8iyd4q2+v/QBR3YdBGbHWVigbViH8Vwe0dsr2K5zooOfwf4lDIG31REV1kDy
         ZbaSPLd1UaMFkoWyEyY2rxFq0RJCNslOBgnc/9RYRzMZr80H4xDeb1aQQz6mHCmwf0WJ
         GmEiu8THw5VaRfM5dVlFz2ApKrYViVubd3uOp4Q35nxDr2jyq6K/jYJ4ABKyUbGqichj
         NrtD/1p3ooKCM531iQxLf+F4buKadsIDFHV2fAV/RhbRSkgdnE4GnHxQ96KR6Hl52HNW
         /phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751130100; x=1751734900;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNEn7suD+Hd2kWZGGFYZnjdopPtytgcb/jMssPmD/3o=;
        b=QzIYUQsFp29sJRpnfCuNPfyaV1veIWLn+iE9Vvd1cg6EAuRF546TxKLQUB11ozQiJL
         a2nAOGh1mj6J8zhA/mqrLlOJgRq0lxICLEJasyYyxmPQ1wHfDXULqiFUJLiWsDVt3t1N
         80ricH6kXMC1BoLyg1Qi40KfqWEXP98awbaWZJ4vuHS1X8QfBzWgG5wiPCrES45UT8Mb
         ZEo39LelUDexNswvaVTUHIVPdaommVudq4uoep+5k019HogQVYDOFv53YwXc+/LXpryi
         GSme34QrA7qXbOOGq7kyg34VXe44IjwqTv3iW6SUqfOuLnqpn/Uo0nh0cxpTOkaBlgAh
         F5BQ==
X-Gm-Message-State: AOJu0Yz5XkqmPKRAT5JcdqtoX4Wl56dQi3kk6nO43vpunFpK/+LEktBD
	vopoUWm3rjUYsvAKtwFknTL8owJMT/Y5sepjGEjCzkhvPzR3wu4y8gohwgOHh9Ev4jE=
X-Gm-Gg: ASbGncuc/EEzqNzPMtRs4TrwcdumFtPjuzkPd20xqyQ7FVDAS2weW/Cxp6S4+c+Sn/G
	5hxhNFjSroAwFvgroWu2ev2RPPTdLJTxKJahuWTK+tJyUpERuvDs0/X9ZkK2dO+O7L8xn3idj6b
	mRnBg6hosyE8NqBf1+pOKr32xrWx4H9jKI1z1nVIt4PccdMMEMVB3DpEkp5faG6skTzmIj56Mfq
	3loW1ZiaYpa8bvzmRDJ09kYQlmy0pOYFePj4MOyhYrgKqfr0AQ0HDXzXLakh9EtL1nUGjpOg53K
	FsgNpNauTbRDZVwXvcmOnEVQ5PPACi8yCg9MetYcSqkwgalAK4zETASMJDc5LDE3nN3l
X-Google-Smtp-Source: AGHT+IEbaYeotjNAcu6yS3Amk18K1Y9pBzRkOkrHYlQBIJjCg3X86HmLN22n85KsVC/LI8XaPnIEyQ==
X-Received: by 2002:a05:6871:3806:b0:2d5:ba2d:80ed with SMTP id 586e51a60fabf-2efed68536bmr4922110fac.25.1751130100185;
        Sat, 28 Jun 2025 10:01:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50f852bsm1602028fac.33.2025.06.28.10.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:01:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:01:29 -0500
Subject: [PATCH] iio: accel: adxl345: make ad8366_info const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-12-v1-1-88029e48a26b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOgfYGgC/x3MTQqAIBBA4avErBvQ6QfpKtHCcqzZaGhEEN49a
 fkt3nshcxLOMDUvJL4lSwwVum1gO2zYGcVVAyka1EgGRSJuMeQLnb0sakIyrL3Ra9+PHdTuTOz
 l+Z/zUsoH2AVrGmMAAAA=
X-Change-ID: 20250628-iio-const-data-12-28e1f81b4463
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=X2KSmb4HCsHC/HeHjDlqJkqmU0XZcMUMkV1bUX/8/sc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYB/qZu5zS+DAe4bECmTsxhAWRh9ooM0P8eWRq
 Ei43wZbnJeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAf6gAKCRDCzCAB/wGP
 wN+jB/9JVxJpqA1P4b6s0wgjvSyxzFPFRRrF//MhkCSVx8c9nhRqSn9YKDCpMjxRUVYHB+opvRG
 TBf9mQrilmGQMg2JWBWCD2slnzvyZJjWBsH47mxuZwokQ2EuvfN7x356LLRImXtIBQ4NLjbg93b
 pnVsfmIjqavJ/Fr5KvMAYypWC+GtpK/7KVJ4pTPrhX9ltcIMduWmuTIwX4fARK248oJsDPg6QNu
 V/zECi4hBURPeknDVdFkh0u/dcDwd1qRDQt7m1iWN/wsqukt3UuR9rCYx9cS0i2JoXSV3+EwXZ/
 Gbem147usgwRlvGHZrPZiPMgChJ7bh+nYd/ajaspeOuokYSa
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct ad8366_info ad8366_infos[]. This
is read-only data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
I looked into dropping use of the chip info array in this one, but
removing it isn't trivial. There are several switch statements that
are using the chip ID still. So we'll save that for another day.
---
 drivers/iio/amplifiers/ad8366.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index e73c9b9833959e498fd03b37f9bedf2226b2f42a..d06ac786501c47518493e382ec2e2ad445349dd6 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -45,7 +45,7 @@ struct ad8366_state {
 	struct gpio_desc	*reset_gpio;
 	unsigned char		ch[2];
 	enum ad8366_type	type;
-	struct ad8366_info	*info;
+	const struct ad8366_info *info;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -53,7 +53,7 @@ struct ad8366_state {
 	unsigned char		data[2] __aligned(IIO_DMA_MINALIGN);
 };
 
-static struct ad8366_info ad8366_infos[] = {
+static const struct ad8366_info ad8366_infos[] = {
 	[ID_AD8366] = {
 		.gain_min = 4500,
 		.gain_max = 20500,
@@ -163,7 +163,7 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad8366_state *st = iio_priv(indio_dev);
-	struct ad8366_info *inf = st->info;
+	const struct ad8366_info *inf = st->info;
 	int code = 0, gain;
 	int ret;
 

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-12-28e1f81b4463

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


