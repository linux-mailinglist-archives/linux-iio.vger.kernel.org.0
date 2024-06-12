Return-Path: <linux-iio+bounces-6223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4574905D62
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 23:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8A21C20D44
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E14126F1F;
	Wed, 12 Jun 2024 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GaFV0S57"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124A86AE9
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226202; cv=none; b=Jedia09T8xbl7UoB5rvkGDJA2hKyk2peZiK+kp9G1LCCAM2HQ7LbhNPRG71NUlh6xjacE3a2MNXwg18n8gKWiN4mKEm1u4AvlQhsIU/nwKRADxxiQi9nFPvCDAL8L8E018By5zE2U0o5hTcEAJN9qokak/BN8YMRwbup+jvXcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226202; c=relaxed/simple;
	bh=RNcdsu5M8J+l6BpFm2PvQc2JbQnF0jcrpMXotqoZQQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QG36uiskuRVgoCyKxw2JWpDqD1qwOW9XkLS2x+T8i0iKoXfBGw5qJ/t1tsmU1tVitd2/MSorasmvbMT8stMQ889Pp0Ygc73800O6G7RghS6OK2+kyKjUOGC8PxV+CIC4Q3GRVU7wWFMe0YRQB4P/Qrxyerax2fuvfwyz8VU2DnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GaFV0S57; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d229826727so125878b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718226199; x=1718830999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m8+AjDCwdDm/uy92ZopCZV/80gVLrKEBs5ojktWuicI=;
        b=GaFV0S57Sh8g8IRz5lRKB//ofz1ZHcv5TEPpkZ1dNUxNvTDW3KkLR70cR5S4fKJTO/
         WD6G4nrXj8DlymSIToJY95Lq4PeDMldiSMrCO2Gv6cZwPTn7fH3jKM3wz0AHOBE2qWO9
         FPFtaddIakfW2bW6+mpP+7Ew/euoWx24z1ZhYhXRnOD46XxwMsjrpi2b9SqLqimYS80Q
         oEVKKgZHnd+JBImxVf8oFukW2Pql9cginrxqylewNKnUoacstojDK7QZxTtc/nZ4LV/B
         EKwP65Js83OigMtYtTcsI/3hfMrukYC2xeuF5/0TzNnKLWTBY0nRhwRdeeVQThG3ceP/
         fYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226199; x=1718830999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8+AjDCwdDm/uy92ZopCZV/80gVLrKEBs5ojktWuicI=;
        b=BBJINaVR4jYbM1fQ5DzqT+2JkxDhgLwfy6Jokx5aH3av/cw/iXg8/wEpTOXyIgrO1c
         8/ifhzbCAUK9R/C2XUoqjyvhMhfRYsrL88cJFWnuqvUUyLV1tV4tTFQI1FWNy4tZhOe3
         93iiSw+ytE3OqRYtxxWMvuNGd9KtN2eHhj+FOp5SlmXWv8qo2GfM2oMlxuzlpT5Lxdyb
         vPCmcTxvWH3CDhNJh+o1HhU6KRuGoBFJ3VLwM5VKKk/uos+5JKEaNTG9e9Zo6B2SiTsu
         snxwM7lTIj3IcB1mvgCH7izu5Vd5IVn2nh1E49CdA1lMT2OV2kgwhsIlVPuJQj5o8mzo
         n1WA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0y0/tkx5LtnUNzCPRu76J2SRNgDtUIR7Uk5lLMdNTmoKPhZjtgQg4F0zxLMbOsuJRkWa2HCig4JLd/JJo1k4bsuG2RmdT6y8
X-Gm-Message-State: AOJu0YyEMRwCEVzQ7HCq112SkXZavxIeSBYsmoQ2yuwo25UdQDiLcUny
	GeXB3s09FE5LutsZUm6NsfLRj2L+zr1E3fMXHvVy01EwwhMDChW55xfHD/LL7P0=
X-Google-Smtp-Source: AGHT+IFG9hXHfKhhcsIEt7ahUMFRg3vhKaQFr3sQBZ2FeZGqHgEjq5jtMXoVA0Hk1E/JvmO9j9OGcg==
X-Received: by 2002:a05:6808:ecd:b0:3d2:21c8:e1d5 with SMTP id 5614622812f47-3d23e013a60mr3825908b6e.25.1718226199252;
        Wed, 12 Jun 2024 14:03:19 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b68f5a1sm2433368b6e.23.2024.06.12.14.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:03:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] iio: adc: use devm_regulator_get_enable_read_voltage round 1
Date: Wed, 12 Jun 2024 16:03:04 -0500
Message-ID: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Following up from [1], this is the first round of patches to convert the
ADC drivers to use devm_regulator_get_enable_read_voltage().

Some of these are trivial but some aren't so I'm breaking them up into
smaller series to spread out the review load (and my work load).

[1]: https://lore.kernel.org/linux-iio/20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com

---
Changes in v2:
- avoid else in return value checks
- fix unintentional changes in behavior
- use macros instead of comments for internal reference voltage
- Link to v1: https://lore.kernel.org/r/20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com

---
David Lechner (5):
      iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7266: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7292: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7793: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7944: use devm_regulator_get_enable_read_voltage

 drivers/iio/adc/ad7192.c | 100 +++++++++++++++++------------------------------
 drivers/iio/adc/ad7266.c |  33 +++-------------
 drivers/iio/adc/ad7292.c |  36 +++--------------
 drivers/iio/adc/ad7793.c |  24 ++----------
 drivers/iio/adc/ad7944.c |  54 ++++++-------------------
 5 files changed, 62 insertions(+), 185 deletions(-)
---
base-commit: cc1ce839526a65620778617da0b022bd88e8a139
change-id: 20240531-iio-adc-ref-supply-refactor-93f962d40c23

