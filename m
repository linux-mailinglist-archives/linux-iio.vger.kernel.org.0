Return-Path: <linux-iio+bounces-12736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC79DAA42
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078A5B219BF
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043064438B;
	Wed, 27 Nov 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M5U75/zm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F91FCFD9
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719610; cv=none; b=HZ/0+RNBVLpL1Jf664p2nsUu4TCjsoOeUq/2G3aPZduxIO042pm7gYzRmmnb10sE2BmOojrUfJCJ2zJ9yZxtUQzjcbuv1E+fCm2zVS7JBrCDkFu/OXSEGv1DXc9GaxagL6cL2YXtiUq+2+7sgXPx0oexc3L/4SvbWFLGIiBUlD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719610; c=relaxed/simple;
	bh=L9oBzFpag4prWGzd4uQqWd5IX4lGgdSB8GXSQL3FVhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OLAshv3vw3NhAmsX9aL5eXA8+9/4wxmPtM5oKYtXNN/m11lLLS9OQ7gM+upl/w10HRLfpddLV3IEKdEHSVQajnpzO5mKnfyOT3BDJMtcN2usfqMTEwAgxevJ6L2EE7nVuSNKAavCGL1visH4+9xmM531omLXaiiUnkmSnQTi+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M5U75/zm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so5546735e9.1
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732719606; x=1733324406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YBBTCidqiGEUu6OfIV/5qkyTo2Yz/eYVMHBgzPr9xmc=;
        b=M5U75/zmiUr54RftjTtdtI4uEX/7h2Pwo57MXQ7wAYNlq94LV14SE1/4qW6fZIn+8n
         wt17YNHjM9KZxQnAvU/wljUqATDdQhYCOYbE36lF2UIfPM3O37Gt6CVn5IaECZYtDfUY
         Q0Ok/bd3Xm0H55jrwVy754bmwdyNyrfVCv7h5rspEkiO0ljL7vdefpgGaHWlDmBOWLGb
         kNfdLxy/zzo/p3/ZlCGaYSM11wL12X8h3zlWw5qojeYI47+QpgE3qiLWbwSfS9J/1lsY
         bX+WwQjm6hDwc+Qb8SQFkDy/D/PDxjHhfnWPSGUOfk7h8eqLn6Y9xrkRfqe3CS/DJMBz
         jcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719606; x=1733324406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBBTCidqiGEUu6OfIV/5qkyTo2Yz/eYVMHBgzPr9xmc=;
        b=fkRm99lJD+4cfD7a7IxYU8w/XeZKWx19s1Ye96nYTKUfF30gZyGPf/P0g3RyZx63Md
         5ZaL9v8xWwcZxwX3Mv+pmWRfB0ozb238bIrCxH4j3W8pGC/NKP7LQkHjnz83BtCNGbfG
         wVvZ/FzVmIYqS0gLMLN544GUfGxd1Ls6pOrQtLVybQhzRdMc0k0Ia5AaHAp2tGPoDXmj
         l5u5pcJTOxJHsj88Tb+/5j6q943xgUVf3havWsdSec9AaRGegHKqxL2+AMJgQIse7HfI
         bjBMIHO+UbtETJXQyZ4KqRQWR0Mu//fos84raIz+wxEwlTMhF4HxRvJwnpWpsR4XcVxE
         p3OA==
X-Forwarded-Encrypted: i=1; AJvYcCX8j8dW+bq1BkG6oQYqLk4uQmE7FC98F+cyCqNDjJZrVHXEMWGR2mSe9RfGWM/myw5unPz3lRQF9/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzsv8elnntUI0XVOoPJi+CdbbNcxiHm/KTZVqIc81ewL7nwHZp
	6O6JW9u94Ca11NNk4S+nSM9Lx1+0Ta9DX7pqHkgwmkQ/Oc7lZD168FYyEw90RvA=
X-Gm-Gg: ASbGncskD4Wb7xAf9b5gNS08+U4fgqd1H4MnqzyFsq3ySIkAFLiGI1cbPPvW0kGx2vv
	JZh9lVl/FOZG64AHvr25o1SBaNfZHFLFhlcgdrtXZ+mYs5b9pa6+J/T449iOcgd233mhUP1aBIC
	/NSra9Vg1ChTtNO2dexFjy+sxlkEjQvcZGerFpzfpK8YKDZzKBl6tJm3ev0LglkqWiJxMYf7imO
	z3pXfrXxq8VF+LWfZfb2lwOEp1a1LmsgMQVsh0gX0i/fGSFmCkUFP3Fp88CpzpqvPoUXUPQcx84
	WvId
X-Google-Smtp-Source: AGHT+IEnrYtg8V+2YptA2cMOMa8zEVX4ypXjol8HUk1zsPUibxvb9YiZPoq4Yvti/FrDghX6tnz8tw==
X-Received: by 2002:a05:600c:6058:b0:431:4a82:97f2 with SMTP id 5b1f17b1804b1-434a4e67ca0mr64060075e9.6.1732719605725;
        Wed, 27 Nov 2024 07:00:05 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad62e9sm16916010f8f.6.2024.11.27.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:00:05 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	devicetree@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v4 00/10] iio: adc: ad7124: Various fixes
Date: Wed, 27 Nov 2024 15:59:29 +0100
Message-ID: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=L9oBzFpag4prWGzd4uQqWd5IX4lGgdSB8GXSQL3FVhg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRzPRuSuBc2fZ23QK44W+lmNR3AZw4soxAczTN 2/v16zz4TiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0cz0QAKCRCPgPtYfRL+ Tko5B/48QZUTDqzbqPsSPmJKJmFLqzxbHt/adM48D5DKmq3pJ554/ykqLTv9CKcdTU/UjQE20Tu KLKEC/PzZ9OMTkex4SIh2PW7nb4YjxuzITwvfmPdqYgW/7OJC/w/PoP6DwZ80u8dWIInf8zJbUP rmEUlpFzpRCQZYX8x+Qc55BEXEVl3N3DZa9xCBLUkbQd/4l2+X5uKuCeR1bbflksyuXvDAgnN8t GrWGRzg10nnz3wdjdUfPPsgGXuZDDFEiqvbPtz0s/7vejdX0HX7YA3cRhJG1fieK/udLYtN70lr JTIz2TrrM26VH0aJX7N93mDqZYw8G2rCFm/rSP7zAP7ttcqB
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this v4 is the follow up to
https://lore.kernel.org/linux-iio/20241122113322.242875-12-u.kleine-koenig@baylibre.com
addressing the comments by Trevor Gamblin, David Lechner and Andy
Shevchenko. Thanks for your feedback.

This series still bases on top of v6.12 + 64612ec9b909 ("iio: adc:
ad7124: Disable all channels at probe time").

Changes include:
 - Expand patch #3 to also extend the dt bindings for the other chips
   making use of the ad_sigma_delta helpers
 - Various code comment and commit log improvements (partly Andy)
 - Check for errors (and other cheap conditions) earlier to reduce
   indentions (Andy)
 - Add error check for gpiod_to_irq() in ad_sd_init()
 - Forward declaration of struct gpio_desc (Andy)
 - Fix a kernel doc descripts (kbuild bot)
 - drop en passant restructuring
 - Use local variable for &st->sd.spi->dev in several functions (Andy)
 - Add a comment about the suspicious bi-polar but still unsigned value
   (David)

In another thread Jonathan asked to maybe reshuffle the series to have
the changes first that should be backported. IMHO all but the last patch
are suitable for such a backport, so no need to reshuffle. Agreed?

Best regards
Uwe

Uwe Kleine-König (10):
  iio: adc: ad7124: Don't create more channels than the driver can
    handle
  iio: adc: ad7124: Refuse invalid input specifiers
  dt-bindings: iio: adc: adi,ad7{124,173,192,780}: Allow specifications
    of a gpio for irq line
  iio: adc: ad_sigma_delta: Add support for reading irq status using a
    GPIO
  iio: adc: ad_sigma_delta: Handle CS assertion as intended in
    ad_sd_read_reg_raw()
  iio: adc: ad_sigma_delta: Fix a race condition
  iio: adc: ad_sigma_delta: Store information about reset sequence
    length
  iio: adc: ad_sigma_delta: Check for previous ready signals
  iio: adc: ad7124: Add error reporting during probe
  iio: adc: ad7124: Implement temperature measurement

 .../bindings/iio/adc/adi,ad7124.yaml          |  13 ++
 .../bindings/iio/adc/adi,ad7173.yaml          |  12 +
 .../bindings/iio/adc/adi,ad7192.yaml          |  15 ++
 .../bindings/iio/adc/adi,ad7780.yaml          |  11 +
 drivers/iio/adc/ad7124.c                      | 220 +++++++++++++-----
 drivers/iio/adc/ad7173.c                      |   1 +
 drivers/iio/adc/ad7192.c                      |   4 +-
 drivers/iio/adc/ad7791.c                      |   1 +
 drivers/iio/adc/ad7793.c                      |   3 +-
 drivers/iio/adc/ad_sigma_delta.c              | 184 ++++++++++++---
 include/linux/iio/adc/ad_sigma_delta.h        |   8 +-
 11 files changed, 384 insertions(+), 88 deletions(-)


base-commit: adc218676eef25575469234709c2d87185ca223a
prerequisite-patch-id: 617af17fc377a984762c61893b9f2a92ae62213a
-- 
2.45.2


