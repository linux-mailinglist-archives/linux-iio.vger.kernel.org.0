Return-Path: <linux-iio+bounces-24037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54353B556C6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 21:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975101CC4628
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 19:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B919335BC4;
	Fri, 12 Sep 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CbZDI5UV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8032ED2F
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704214; cv=none; b=iDaM86GxSob0zYwJS3GuvOPVmlF8dVT33zED3YCVja0ia9822iYHCympy+62ULNVTJmSn32kNe8pTxGuKgEw1Ygu8MeVWZNoUXAWqcUyQ/29h9kA4adxwIgpsOWfODSXmq/RwQEu51KMc59I9Akln3oscqwQ0yL6yTZgVQSFTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704214; c=relaxed/simple;
	bh=fidggILI+vKbI25x1Wtgqu1lihcFxBqH8ZEXbL7BQds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFytjlnKrY0QnEPK04VzRvV0TRojTz/epEMhB5U+TSFvxn+t9beKv4jp6MKf5lM6Vfcp8NDXeOx6y6WHLmAOfixRG5dgppqKxyOKVgbgST108z9AUqv4j0lBGcdXaHQglXSc7HNtAPY2wHzzEm2PxbbXNlkvxYWMyGmv+tXibhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CbZDI5UV; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-31d7119322dso819014fac.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757704210; x=1758309010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Z+FCmND8CRKA1UjGgzaxWf0DLNmbIVMdavAGandxrY=;
        b=CbZDI5UVQV93aXZEBOfimWqe29Zk6CQXd1drESPiDNoi6bSCwaMgOUNXHFrfTGfo9v
         R5zZg70vcTdsNbrHMWyDmnxsi7rnLHPByJ9A8mj7wNaBUgnjE5FJKBSOasCaObA7W4LY
         /Vs68E4qllf0oG+ou7BTZX6ysqYGvASs2OZNiANr+WPp76zF+h0F6Rxu0RXTqvMtdMb9
         /Vx89IRhmJ+gyQiCBY54oqIjz33zDeCx7zqpfpyxaccRhHH24cHP8pcAriqQXVr3pHK8
         DlutkOLGvc2XIIwgLkl0JhlgOiXjBdJaDTBqFuL7NOiI4vm69M5cm6FUgsGyUZxuVTeW
         CmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704210; x=1758309010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z+FCmND8CRKA1UjGgzaxWf0DLNmbIVMdavAGandxrY=;
        b=QT8davJ2yIAxfKOVopLVpIkwFSaZRhG8bqPl9IJIfQZ5CaESNfqc7PAr+L1fpH7gQV
         ynHzeK4PjOq6t3FZo3tbm+2HH+Xi3KluJ94Qk4FWm2hHojAh8rwJzrlcVQA6ObMd4e3I
         wXzY9GsyrwJBho8ySKiei2g7YaAFbu0p09MwnnNiKBdBwM5Mz78K4yz+TVfrYrrdMdwp
         7eSwgZSBP8jXI6BNoH5M1/IkwErtXlmN3ZMdgZq5jmrUEHrDG5gvbV3dVuatq6Ll9UEk
         ZjgyXn74rcpmtg57V/N+g9n1WOYNBtdoCMuVlHC+322lWQM/ZVj3q8i20R35G21gfS57
         XXdQ==
X-Gm-Message-State: AOJu0Yy1S6xRLg9YifnOdsHB+OwAQOZz7nI6xuhmRJCIaS3WTbYe7/9n
	SND5OCtsV/KJvOeDsngY8cCe+tI1nxS2Qes22W4KA5WHy/YBpBjC6be03wRYg6JrOt8=
X-Gm-Gg: ASbGncsiH3qkseTxDkpi0vH1p0kLEl4EV947itvQTKbn4usDdL7GaJE/o4ZWJkpIAdP
	6ht//8RQmrWrSZ3QMlY7ofDtO7T1/jLpumVa4Jp5YcX4+VCWM2FrhzK0uyTSsitP3qiJ027ZG67
	YJD/o1JRwKIYM3uWOJdUpmTpKf12GU8H/Y6rGMgUJxonjkuhzlS6AUOfc52uyN8JjWCaMs+Vypc
	QmEojqI9ho7gr5CxZtgQqOUB7oXEQAiKYKfNl4N2LwB+iXeYGOb0zTpddphSju3L007hwCYHYxL
	IPt6xsQYWdv4QBmsoTZjRu56MYEOvoZO72cDmijPya+2Al/Xp9b6O889r4xlyh2Un7g4UXCGMHJ
	YbWGw+qS+WYsSa+sTi/bDMEkrJZIB
X-Google-Smtp-Source: AGHT+IGOuWWvGWf6gTyvHtXltFZ+QHAscFYjvKQCkXsveTOCFKpsAjDDfM4iJ5nyGJSDRD7XGdM+MA==
X-Received: by 2002:a05:6870:ebce:b0:314:b6a6:68a1 with SMTP id 586e51a60fabf-32e57802a1fmr2074994fac.41.1757704210001;
        Fri, 12 Sep 2025 12:10:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986c872sm1172564a34.15.2025.09.12.12.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:10:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 14:09:30 -0500
Subject: [PATCH v2 1/4] iio: adc: ad7173: rename ad7173_chan_spec_ext_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250912-iio-adc-ad7137-add-filter-support-v2-1-bd32dfa3d761@baylibre.com>
References: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
In-Reply-To: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=fidggILI+vKbI25x1Wtgqu1lihcFxBqH8ZEXbL7BQds=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxG/1lUlrPPP8W1TAfdKeuU8DdejGrulcQ3EAT
 4szO0uy0ZmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRv9QAKCRDCzCAB/wGP
 wN2QB/9nT/LD50wLxVl1M98uEau9N5qeN438D7LcuxDPdBuQIt4/i7av1AvPqqHOgp67con+BPk
 3rgaPzvC84STUXwI6SEs82GRQSmP8ZRL6uTlC1phHaKoKzGxTWGPQa3WnVE6T4HENtp6QxYGpxJ
 HBvQ69/9/kLY1NzuvlHg0R8n3vfMelkR6tQSzBNOs5JHTNmwlr2aFk0To+lXkuKPvKj1tr3epaf
 WAT6EyBRUpXOPZBDCVT3zxzkzyGofkYiKtmzcFfGMKZXgdwwh1l+GX6Jq13p/PpXA73a5L9jako
 +eoSxFTULP9c7q9yFkJ06fWF7ChJgdL8uy2rt775JDzb6A4g
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rename ad7173_calibsys_ext_info[] to ad7173_chan_spec_ext_info[]. This
array is not limited to calibration attributes, so the name should be
more generic.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 0dbbdd7d2b9a7a8e5a3908e27d7155f002ce271b..df586cb8f09ccc6d1647c66fdb9f147c0b4694b8 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -369,7 +369,7 @@ static const struct iio_enum ad7173_syscalib_mode_enum = {
 	.get = ad7173_get_syscalib_mode
 };
 
-static const struct iio_chan_spec_ext_info ad7173_calibsys_ext_info[] = {
+static const struct iio_chan_spec_ext_info ad7173_chan_spec_ext_info[] = {
 	{
 		.name = "sys_calibration",
 		.write = ad7173_write_syscalib,
@@ -1399,7 +1399,7 @@ static const struct iio_chan_spec ad7173_channel_template = {
 		.storagebits = 32,
 		.endianness = IIO_BE,
 	},
-	.ext_info = ad7173_calibsys_ext_info,
+	.ext_info = ad7173_chan_spec_ext_info,
 };
 
 static const struct iio_chan_spec ad7173_temp_iio_channel_template = {

-- 
2.43.0


