Return-Path: <linux-iio+bounces-11269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602809AFF3F
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 12:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183C01F21CFD
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D531D90A1;
	Fri, 25 Oct 2024 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d3Cw+6DM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD931D47D7
	for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850392; cv=none; b=F4vkTgid76opHjGUREVHOFmwZa8EyvygUTJaZ5UYhQ8uAYXiIhrz1irx2pvtt1h3vrwdPLJsXQ+15l3d2Wcdrd01LQaMxZmK3TWlN5HpVMscqlJlTJUaO3FXYKH5XBmaUKuBNDGjD/n/LdOSPRfS6V4nYjvc6SezgbS4igcP7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850392; c=relaxed/simple;
	bh=EOXu4RXiG/1nFkUUENz+48cVcqlUm4zIM+TQFU+MRk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HyLdogLVaReWUZZSmZQFJ5P910h+pvLyytj/SYmkwmnLYTdUHWH6XuVmzopmDGVViD77O+NeAmb7MBRgApkcbdAXhlmptoCL94qHQ+hauI3fV35qjNnwwCqw+x9Z8BLT24463ZGhOGJHgFJmzW5xqgeuomQ3ih9B4t55SfWRUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d3Cw+6DM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0cee600aso235493766b.1
        for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729850388; x=1730455188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l203ObTiAyHx4TgS5hw87uYDqdH7xPzhZxL+rMiEkDQ=;
        b=d3Cw+6DMoVh/oB86jE+F0MS3/5Xg1YqnGczwEC2Z9Zx5Za27NHZRP1H7+nHIMSGuPX
         CY3vUJq9YvMGlm6+8SmxGQzLoGreXnXn1lhJG9oF/WWFyYYRDvtp5wtO9Eu7BiEejuFQ
         c8PaqgXIcIOSeYFw773XeeoHEn4S3+bvqbgX9lCvpXG69Rm6lybYNsVvpEpbpi9V6rij
         203oeZO9X4fBRG2SXqHisUJmqxMRZtWQL7ZcWXznoMaRBmnI5zcQQ7YG/p7Isxn5F4oi
         YXEBu7FVlJClHsuuIHBE4kPJ9fqWkq5nsa9AUvSBnDOltjzNvGN2NQqSY3oLjJZbcDHx
         Cq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729850388; x=1730455188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l203ObTiAyHx4TgS5hw87uYDqdH7xPzhZxL+rMiEkDQ=;
        b=QE5OuJTWBtaa0blopWlYkHIz72HjCEfqkaM7vTOXT3nk1VTTJvQlJbBYFQiTq547gD
         DMmY8IImL08qdGb5DF0PDBjVkTfIvkZmotzvzh9xVHHUtXuUWpv329JtP+x1HuzeAx9Z
         /kjKxrmSiZOTcmbeL3GAW051AkcVQo9HVxB4KxFpXWN3MQJOMSsGU8aShQuK6bVFoanq
         HE+2FEX5EAZVLBVeVJ5d3eVNEaAsFPD7aIfuAb18UD4WM5SEGmCmk3uoroDwOEdtWaba
         QTuNRJTQhI6rxtvXzApJKqB1oEVbkiMhmHHwpsZ37gANF1WXUxtBla6VjTpyPQUlhhEa
         9Z5w==
X-Gm-Message-State: AOJu0YxEturfbNsL0pLr9n76sDoQ/h+7UQzU15Kb3UXWeMECF7PPdcqQ
	zh6ehIjk0oILx5OYYjBPo8Ie82RkeKM/3C30d+4KbjW4jJtpoANUtugVspI8Yyxvmq9iaLx0XjI
	HcCs=
X-Google-Smtp-Source: AGHT+IF5BKfv34MZ4Hk3VE7V9xDrF6KGVt5Ob9HfZVsG4aAxIrjWzlwC1BiRD7Bdpq2DWUGwA1qfBQ==
X-Received: by 2002:a17:907:7ba1:b0:a99:f77f:b489 with SMTP id a640c23a62f3a-a9abf96ebcdmr860509566b.43.1729850387707;
        Fri, 25 Oct 2024 02:59:47 -0700 (PDT)
Received: from localhost.localdomain ([188.27.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f02951esm51737266b.71.2024.10.25.02.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:59:47 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	conor.dooley@microchip.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2 0/5] iio: adc: ad7606: add support for AD760{7,8,9} parts
Date: Fri, 25 Oct 2024 12:59:34 +0300
Message-ID: <20241025095939.271811-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This change-set adds support for AD7607, AD7608 and AD7609.
These parts are simpler parts for the AD7606x family. They support only
HW-only mode like AD7605, but they support oversampling like the other
AD7606x parts.

AD7607 has a 14-bit resolution.
AD7608 and AD7609 are 18-bit resolution.
AD7607 & AD7608 supports +/-5V and +/-10V ranges.
AD7609 supports +/-10V & +/-20V ranges.

The oversampling settings are the same.
Because of AD7607, the scales had to be reworked (again), but this time
doing away with the allocation at runtime for the scale-available-show
values. This time, the full IIO_VAL_INT_PLUS_MICRO values are stored
statically. AD7607 supports a scale of 1.220703, which is the first and
only (so far) scale that is above 1.

Changelog v1 -> v2:
* https://lore.kernel.org/linux-iio/20241021130221.1469099-1-aardelean@baylibre.com/
* Dropped patch 'iio: adc: ad7606: fix issue/quirk with find_closest() for oversampling'
  - Will focus on fixing 'find_closest()' instead
* Patch 'iio: adc: ad7606: use realbits for sign-extending in scan_direct'
  - Applied David's suggestions to check only for > 16 bits
* Patch 'iio: adc: ad7606: rework scale-available to be static'
  - Applied David's sugestions
    - Rename variable to 'scale_avail_uv'
    - Use 'MICRO' definition for '1000000'
* Patch ' dt-bindings: iio: adc: adi,ad7606: document AD760{7,8,9} parts'
  - Added Connor's Acked-by tag

Alexandru Ardelean (5):
  iio: adc: ad7606: fix/persist oversampling_ratio setting
  iio: adc: ad7606: use realbits for sign-extending in scan_direct
  iio: adc: ad7606: rework scale-available to be static
  dt-bindings: iio: adc: adi,ad7606: document AD760{7,8,9} parts
  iio: adc: ad7606: add support for AD760{7,8,9} parts

 .../bindings/iio/adc/adi,ad7606.yaml          |   9 +
 drivers/iio/adc/ad7606.c                      | 221 +++++++++++++-----
 drivers/iio/adc/ad7606.h                      |   9 +-
 drivers/iio/adc/ad7606_par.c                  |   6 +
 drivers/iio/adc/ad7606_spi.c                  |  42 ++++
 5 files changed, 220 insertions(+), 67 deletions(-)

-- 
2.46.1


