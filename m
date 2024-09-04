Return-Path: <linux-iio+bounces-9116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F05996B2C7
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 09:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA160285F73
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0291465A4;
	Wed,  4 Sep 2024 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mADcoJZI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE6145FE8
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434848; cv=none; b=YPqFogwwCV5ArQmhE1otGlv3KvJpiJ7ffTsiUma8vvisBDBzk3JOaJUeM+UhWTjpelkGWSYUN6pbxSoihXo8eQBXD3ds69LLZmGMf5G8KbYQ+FDM0NGtWD1UaBj6VidEL+w59CO4UYfEBEQugd52FiOkWAox/A+nZA4ZgoXlbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434848; c=relaxed/simple;
	bh=bdClaQMyoGsCdWLYe2ixknLgtAqi8KipDXtel2rdSiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ix0BgH/jY7wwqbYRcLXWvN9ELa5abARHQLPX05M54CGLp8+NNQZbW7D6FvIMmVl+6K0EZslFE7CLAk2j8NE2AJ9rGTni3tWoYUPyP3bXohj+quq1CB8t6m+FDKoaf7MWSCemhTwvQmZA7JIK0TCEmcZNLUZXia7HxW2QFieQTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mADcoJZI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a866cea40c4so720993666b.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 00:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725434844; x=1726039644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pHc8+HPsRwaUTwqoeziGvhSwpCVJZ7q8cThJ3O3xi4=;
        b=mADcoJZIUJ8JVrVC0mnJKtuzJwL2oW9cXGX1JSdf+oFnL8UhRQzx21bmzQpwRoplRY
         2sjVepf9MyYFABRzqRuXWJlzEhzV7V0JqOoQxJ4yUbgkjUaq75jcWVjyiOvWC4+a5iOG
         NhfViMK/K/ZoPaR6cH60A2qDrwSWhkMVhXMK0+bghGR13bq3v21Qr99xvo8LvrRrKBz/
         ilcI+J7a1cayarUwBvNxlcPzAqvO6GKRDV8XWftKHZPeY6KcXfLbHJr7G7ZGLCe+19lf
         sd/R6iLFWzAXiZFWewbReMBUHPY3NQ1mYs9dRb9c/VaqYn0P4ve+Z4qFkfS7RpviABw+
         Q+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434844; x=1726039644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pHc8+HPsRwaUTwqoeziGvhSwpCVJZ7q8cThJ3O3xi4=;
        b=AZs0Yef50DfJBtkapsebDCWCdmeQu8pduC9R/2Wh/KNnGy2MDVelOUzGcrIYBx8fas
         7YoEtOaXxLm6LrN5hH75ZrZ+DdHKfaCYQ4uzqqR7bNYBitLaOY+Oy2DVIhA7CXWlbrFL
         P2mG6Utj0kLrqEVRZGk96kXIDKmHGjXclH89DlN+vZ3HDdR1XnUrPsjVzbXN6TqT1YeP
         hbKHoureZ3+HgKjLHSjXUCqLlH9t5GGVJsMnPdmNZpZ8vz+1MWNhs2OieUzE2n3iZ1rI
         M2atZelL+DrxE2xi3oSKXI+odnFuCE8t86MArWDGjJRcv+kJSyE1muSSYW6ttZebbDtL
         r5KQ==
X-Gm-Message-State: AOJu0YxPiKiY0W65yDVW/VdIxWtKv6VVri+UpMhGGTKhEehz7iiJPU+3
	GOq9/++esYJsNqnjd5/7q2eg6UhGIbsEOjSjFsdkVpr3Pik6N8pGuF41LNMcmVllowXwAlajF9d
	so4Y=
X-Google-Smtp-Source: AGHT+IEUvILUXPWBCZLAJR4C0Geb6guuCqa6NJmJmhATsIjVr+yjHLOuGJ4mUc7lhn3MTCOXoQnDOg==
X-Received: by 2002:a17:907:6d0a:b0:a80:f358:5d55 with SMTP id a640c23a62f3a-a8a1d3271d8mr427039566b.33.1725434842698;
        Wed, 04 Sep 2024 00:27:22 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d77fasm771151766b.167.2024.09.04.00.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:27:22 -0700 (PDT)
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
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v3 0/8] iio: adc: ad7606: add support for AD7606C-{16,18} parts
Date: Wed,  4 Sep 2024 10:27:08 +0300
Message-ID: <20240904072718.1143440-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
The main difference between AD7606C-16 & AD7606C-18 is the precision in
bits (16 vs 18).
Because of that, some scales need to be defined for the 18-bit variants, as
they need to be computed against 2**18 (vs 2**16 for the 16 bit-variants).

Because the AD7606C-16,18 also supports bipolar & differential channels,
for SW-mode, the default range of 10 V or ±10V should be set at probe.
On reset, the default range (in the registers) is set to value 0x3 which
corresponds to '±10 V single-ended range', regardless of bipolar or
differential configuration.

Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.

This changeset, does a bit of rework to the existing ad7606 driver and then
adds support for the AD7606C-16 & AD7606C-18 parts.

Datasheet links:
  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf

Changelog v2 -> v3:
  - v2: https://lore.kernel.org/linux-iio/20240902103638.686039-1-aardelean@baylibre.com/
  - Applied checkpatch.pl changes
  - Managed to setup and run 'make dt_binding_check DT_SCHEMA_FILES=adi,ad7606.yaml'
    - Found the winning combination for this setup
    - David Lechner also helped
  - For patch 'iio: adc: ad7606: rework available attributes for SW channels'
    - Removed an extra space that checkpatch found
  - For patch 'dt-bindings: iio: adc: document diff-channels corner case
    for some ADCs'
    - Removed 'the the' stutter (that I did in writing)
  - For patch 'dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings'
    - Updated binding with some description for 'diff-channels' & 'bipolar'
      properties
    - Channel definitions are counted from 1 to 8 to match datasheet
    - Added more bindings rules for 'diff-channels' & 'bipolar' for AD7606C
      - Adapted some ideas from adi,ad7192.yaml
  - For patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - Updated 'diff-channels' property with channel numbers (from 1 to 8)
      handling

Changelog v1 -> v2:
  - v1: https://lore.kernel.org/linux-iio/20240819064721.91494-1-aardelean@baylibre.com/
  - Fixed description in 'iio: adc: ad7606: add 'bits' parameter to channels macros'
  - Added patch 'dt-bindings: iio: adc: document diff-channels corner case
    for some ADCs'
    - diff-channels = <reg reg> can be used to define differential channels
      with dedicated positive + negative pins
  - Re-worked patch 'dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings'
    - Using standard 'diff-channels' & 'bipolar' properties from adc.yaml
  - Re-worked patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - Reading 18-bit samples now relies on SPI controllers being able to
      pad 18-bits to 32-bits.
    - Implemented 'diff-channels = <reg reg>' setting
    - Removed some bad/left-over channel configuration code which I forgot
      during development and rebasing.

Alexandru Ardelean (8):
  iio: adc: ad7606: add 'bits' parameter to channels macros
  iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
  iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe
  iio: adc: ad7606: wrap channel ranges & scales into struct
  iio: adc: ad7606: rework available attributes for SW channels
  dt-bindings: iio: adc: document diff-channels corner case for some
    ADCs
  dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings
  iio: adc: ad7606: add support for AD7606C-{16,18} parts

 .../devicetree/bindings/iio/adc/adc.yaml      |   4 +
 .../bindings/iio/adc/adi,ad7606.yaml          | 108 +++++
 drivers/iio/adc/ad7606.c                      | 433 +++++++++++++++---
 drivers/iio/adc/ad7606.h                      |  78 +++-
 drivers/iio/adc/ad7606_spi.c                  |  71 ++-
 5 files changed, 598 insertions(+), 96 deletions(-)

-- 
2.46.0


