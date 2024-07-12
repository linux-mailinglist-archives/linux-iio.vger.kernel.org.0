Return-Path: <linux-iio+bounces-7551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C5292FE12
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 18:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE481C21365
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6942175564;
	Fri, 12 Jul 2024 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BU9gJBdS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4922064
	for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800246; cv=none; b=qFmYY31p0HNivAZ1CFqpSY4tEPrAB1OR3B9LSzERou0qhX6bMb9/gvuVzTvXHQARdtkRY3I1il4UpVWF7qcHuhNIAnJjqq7gQojCibNH2XWqnrNj+418ONDseB3AdRVytOP/mfjiTuaHdi9Ps5bleNWNbZE+FGUkC5fvhIKSaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800246; c=relaxed/simple;
	bh=P4ob3DNHGvoDf+Ab09PbPElrOsQ+LfpUrw9VboiZdgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZgogK47r4SPkLouttFqvAJ9MPpur7BKNyt34VoKXSw7OVXqZAsOrz31rplODmLQRkZDjBLZsvv2RbLJy+pAmYa1GjVvjKB6e0ns4w92R94O+zAhC5H5+KiIqWhl80pAEQj0AD9Y7Yj4x26wk3oLZ6gUdqymINTUV7OGkpWsyhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BU9gJBdS; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-704494efa7cso1279383a34.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720800243; x=1721405043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hWTzHco2zA1H+Yf6KhFJuQIO6KQnCWWPpgy+Ns8Ef4=;
        b=BU9gJBdS5vx5ZMWeuJVOxMYVfpk2Q01vP2XJ28ffEDWLksewg/zq8+IaVbvrA77zZj
         DStAt4sO/zA29NikuXIhtNcGLwGp97t2vmw7KbV9Z0vPV/V+bNZNNECf7VUF0CLg3Pgw
         KjqY28/IOZeF/Dk8ENns6k2IeX1CJPHPqSMgZBxVzNMWucaDbwTLVqNtkqLRZFTOHFwj
         ahYQT2UpGVMM/flct8jcITbMT8XSLJADcOb3q86QVstErMjrVTpbJukcowLe011skLoQ
         nCUbURPvb8VeEDDU3ehCgITxeJ+AZU/rnkYoQHBwnzz+9Yc/oF2XqlTZarT0H8nPkmez
         l+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800243; x=1721405043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hWTzHco2zA1H+Yf6KhFJuQIO6KQnCWWPpgy+Ns8Ef4=;
        b=Lt8cke6Wdxsm6YmPetkkxFZLJOw7GOLJWe0XwSHM0WEbWAaft8mHe0W1HKk+KicBL4
         56YIItAABfSAQhOBmUZyGieEXCjjuBKDQBzD06m1KD6hDoTgr9KvBKLO/7hew1eNNFxn
         nnGDlVYwpQPknpEnRruJn2rbxpV+MfB4xdnJyZWLGTIhQUxg0IENGY4u7hHm7IlgRqgI
         wXDaNy1YJDwZ8myu2I5fWL+Uldstdt/OpvDBqWpKHm4B5htVre1duvPzUEuo3ntGx2aI
         rJBSph88XELaZ4YDffmeWnyHvZeZrHAu3qB2mfkKheg/tb2vt8Y3YpJB9YX6jYbTXTO+
         FKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuR4nBw2tO4QyqEDRq//LqYwXs8hwJtXqvNlEs8BqxM9Gm4zI12tJhO2yFEEkAhG5SP+cPVzyiuTlIzmpZr/QgP6eIFmz9M4Aj
X-Gm-Message-State: AOJu0YzcHCTes1kGP/PSko6rLqWj7u/sK9WA6QCi12EiBlAmlq5+WXrp
	CScuKSYJl515edzMDYRaciThevN5PoGy8NfVPZyi1u3rlmokGeQupImosEbtGlo=
X-Google-Smtp-Source: AGHT+IFCqJ3A59Ihz+Gfg/eBOf7wupFOr7aBU0qbjk65rd2ue+xLvcZZiwkaCkV4zEAnRjAPJBxsiw==
X-Received: by 2002:a05:6870:3117:b0:25e:eab:6d32 with SMTP id 586e51a60fabf-25eae783ad4mr9926652fac.5.1720800243107;
        Fri, 12 Jul 2024 09:04:03 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d35sm1615131a34.23.2024.07.12.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:04:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] iio: use devm_regulator_get_enable_read_voltage round 3
Date: Fri, 12 Jul 2024 11:03:51 -0500
Message-ID: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This is the third round of patches to convert IIO drivers to use the
new devm_regulator_get_enable_read_voltage() helper function.

This time, we are converting some Microchip drivers. These weren't as
trivial as some other drivers because of nested functions that need
to know info about the reference voltage, but for the most part, should
be fairly straightforward. And there is a bonus to remove a remove()
callback in one of the drivers.

---
David Lechner (6):
      iio: dac: mcp4728: rename err to ret in probe function
      iio: dac: mcp4728: use devm_regulator_get_enable_read_voltage()
      iio: dac: mcp4922: use devm_regulator_get_enable_read_voltage()
      iio: dac: mcp4922: drop remove() callback
      iio: adc: mcp3564: use devm_regulator_get_enable_read_voltage()
      iio: adc: mcp3911: use devm_regulator_get_enable_read_voltage()

 drivers/iio/adc/mcp3564.c | 54 +++++++++++++------------------------------
 drivers/iio/adc/mcp3911.c | 59 +++++++++++++----------------------------------
 drivers/iio/dac/mcp4728.c | 45 +++++++++++-------------------------
 drivers/iio/dac/mcp4922.c | 47 ++++++-------------------------------
 4 files changed, 52 insertions(+), 153 deletions(-)
---
base-commit: 986da024b99a72e64f6bdb3f3f0e52af024b1f50
change-id: 20240712-iio-regulator-refactor-round-3-17f2a82d2181

