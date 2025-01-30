Return-Path: <linux-iio+bounces-14724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92391A22C2D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 12:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928253A4DA0
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 11:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B051C5F2E;
	Thu, 30 Jan 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DK55D2wn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325781C07DD
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738235332; cv=none; b=rDqEBYU2eR43roi6+fV7x8mhH4qoTKxrc9h4RygpPOAK7bI9fvPnybV94shxqXUXAOs0hfa97jO/IYhw91RvLuU2XufHstZvHs0IJ4OYrwGvYJG9tBlxgaiWfy0EDdK45RXFpZQsKvi501wzzEvCQdI68p70VnDnn77gk3VnvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738235332; c=relaxed/simple;
	bh=wkVNEJjOFcSvs5Kqm9fm8snOG5ZGNjTotpQ4cHaX6bo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NycRs74R6uD7kMoBiaFpdqRBJ1tZ8h7EfcrLdDj/TrSnO10TLjAyRiaDnPg3ONzgXEl1lej4SJisNSdmNqIY9+FyKzieFC/xK/uI925ixTASY7p1V5btQ1snrpp9yqzvoSYBsJEZs9uomKs/s73OkRc8KsBDxZxa7bdql/p/2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DK55D2wn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385df53e559so499342f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738235328; x=1738840128; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNy5MECpC+OYXUNYisY0RC+pyKB5foHep9jH8rSUuVE=;
        b=DK55D2wno2q2ojfs27oZhQ6kcJ8FosGe5QhKo2nmQ7ykFZ6hcj439kxlmlHXhOSlvy
         L4JedTfllRcKRMbj2dx4SVtmHD5GB155eiFUTsDzpEkU1GnXfrWsp6pafoX0Iei9n+f7
         L1uK3TMYq19iE0gYO+ps1FG5559/mki9XOiZ6vQ9i/5sqXkQZ6P+ibEnXAwvErDbE4qI
         r3sj4NT+H17fKEBvJFouiAZjjjVzvr/jsUceDb7xuAfnJZCXSnfXoMhqdxBAGZjdfz+n
         ubX9g8MrnzmoLzrUu3j+rsvZrkPMtvubWVhJjEz52xLT6xBkDuvOmeuKdT9XgSuz9SU+
         0sZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738235328; x=1738840128;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNy5MECpC+OYXUNYisY0RC+pyKB5foHep9jH8rSUuVE=;
        b=F2vWkHThICI2VmKZ/mQrnF7C2VbiJkHy1AZg9SMDFNjcjuV6ODZf5OmmmKU+mhh0DQ
         w/5AKBblUpwjZvOD+zv0NAE7Iu7Dwhcw2/3MJAEIgZEBroFphn/Ci9FkvNU/mJ7TOarJ
         OWLicZBwc932LPszkY8aPi44NLYB/eNM6Aww4Y/jWYC5mmDZtnhFTHy70JCjm+MbvbI1
         QxI2dypJoIaF8GatJU/LtzNBeZhVovsPvbURsSEGhOnlyQidSVqJzSNST4q9njTHdMey
         +ayX0HiidoAgnvowh1cq++tu5ONjC1ywiAIGGmZfddxJWWEvTx1VqUVWGt62/VaSuhuh
         VT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0vhAB90p2kIfWMKvX0/ay3ToSLjhz5PkQZTkcvoIUuy1eoYBGahKVeDzxhB1bnyS+JAcoZvXZJRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+1VwK1aJRuGaZI1H46kzFNskKzWJrKsbWSD5ei6jZVOoSXeKo
	bIWWb+0+/x+Ki7Uu3fAo3e1YgR16yHqcP2vcNi9ZkFLzWJnvUs9zi/JMQvbyQYs=
X-Gm-Gg: ASbGncviuByWe7Tzqus6RHqPOmQ4zGzrKeaelroPCyLlhPAe/eDtLcezPP2J1/1jp8U
	IGPeOMTCEv6bnxQ0asly/c4VetBX3UyM0VEkcZhmFdSZvwDHrIwqlH9WBkD7pwLf1x/XOMZl9p5
	AIX8JcybbDeNImQc1K3mjDUpwhMtNSFI4ZDXznzjuwNheRcZaKcF0j1ktq6bJYiKH49mvtaW7fu
	ABCaIVnObFsE662t8zMfxNEqutrOLG8pkrs7g4k8T+1iD8polKRkyR+sElvjpb7GBMGDcjR+vhG
	RxMwfkUdFAB7GXrU
X-Google-Smtp-Source: AGHT+IGgXzKQ+H9jNjy/BS0FApXTmawFQuNy153U0DUEwK7KZmSKfpK2zFK1M97GfUm0QBrunlvpmA==
X-Received: by 2002:a5d:6d09:0:b0:385:fae7:fe50 with SMTP id ffacd0b85a97d-38c5209128bmr5165809f8f.42.1738235328456;
        Thu, 30 Jan 2025 03:08:48 -0800 (PST)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:2c72:cd2d:79b2:82ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c102bb2sm1689225f8f.34.2025.01.30.03.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 03:08:48 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Subject: [PATCH v3 0/6] iio: adc: ad4030: new driver for AD4030 and similar
 ADCs
Date: Thu, 30 Jan 2025 12:08:24 +0100
Message-Id: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKhdm2cC/32P3QrCMAxGX0V6bSVNu9Z55XuISH9SLegmnQyH7
 N3tRARFhdx8gXO+5MY6yok6tprdWKY+daltSpDzGfMH2+yJp1AyQ0AFGhUnd7SN5zYoLWHXCy4
 sGAW1IVcLVrBzppiuD+VmW/IhdZc2D4+GXkzbP7IywHWw2igvpFO0dnY4Jpdp4dvTpH+y5gcbg
 wctwKN08J1dIv5gK6+XUUo0MYR3dvqjx9ftAkX9xYFTv9RUVTUYF6sPxziOd7dlv0FvAQAA
X-Change-ID: 20240624-eblanc-ad4630_v1-1a074097eb91
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Esteban Blanc <eblanc@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2

This is adding DT bindings and a new driver for AD4030, AD4630 and
AD4632 ADCs.

This work is being done in collaboration with Analog Devices Inc.,
hence they are listed as maintainers rather than me.

The code has been tested on a Zedboard with an EVAL-AD4030-24FMCZ,
an EVAL-AD4630-24FMCZ and an EVAL-AD4630-16FMCZ. As there is no eval
board for AD4632 the support can't be tested at the moment. The main
difference is the reduced throughput.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
Changes since RFC:
- Reorder IIO channels to have the common byte channel next to its differential
  channel.
- Extended names for IIO channels.
- Diffrential data channels are marked as differential channels on IIO
  side.
- Use get/put_unaligned_be24 for offset and sign extend it.
- Common byte channel now has 32 realbits. This will be the same as what the
  FPGA will return, avoiding different channel layouts.
- Fix missing newline in some error messages.
- Add comment for the use of spi_sync_transfer instead of
  spi_write_then_read in ad4030_spi_read.
- Use DMA safe buffers for regmap operations.
- Clarify calculation for number of bytes to read from the device during
  conversion.
- Formating fixes.
- Add documentation page.
- Link to RFC: https://lore.kernel.org/r/20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com

Changes since V1:

The most important change is the use of the RFC's IIO channel layout as it's
the most space efficient compared to the V1. In the event of a future DMA
enabled version using the ADI's SPI Engine, the IIO channel layout would be
different anyway. The V1 layout had a more logical ordering of the IIO
channels but since we are using labels in this version, there is no reason
to keep it.

- Use REGMAP instead of REGMAP_SPI in Kconfig
- Select IIO_TRIGGERED_BUFFER in Kconfig
- Use layout with the differential channels first then the common byte channels.
- Flatten rx_data union/struct layout
- Use get/put_unaligned_beXX
- Scale read is done without requiring direct mode
- Grade check is just a warning now
- Use label instead of extend names
- Use IIO_VAL_INT_PLUS_NANO for gain values
- Discard out of bounds values when setting oversampling ratio
- Merge AD4030_OUT_DATA_MD_(16|24)_DIFF together
- Use iio_chan_spec channel field to avoid maths in several places
- Fix typos and formating
- Link to v1: https://lore.kernel.org/r/20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com

---
Changes in v3:
- Put config mode logic into regmap read/write handlers
- Link to v2: https://lore.kernel.org/r/20241219-eblanc-ad4630_v1-v2-0-f36e55907bf5@baylibre.com

---
Esteban Blanc (6):
      dt-bindings: iio: adc: add ADI ad4030, ad4630 and ad4632
      iio: adc: ad4030: add driver for ad4030-24
      iio: adc: ad4030: add averaging support
      iio: adc: ad4030: add support for ad4630-24 and ad4630-16
      iio: adc: ad4030: add support for ad4632-16 and ad4632-24
      docs: iio: ad4030: add documentation

 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |  111 ++
 Documentation/iio/ad4030.rst                       |  181 +++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   11 +
 drivers/iio/adc/Kconfig                            |   14 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4030.c                           | 1241 ++++++++++++++++++++
 7 files changed, 1560 insertions(+)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20240624-eblanc-ad4630_v1-1a074097eb91

Best regards,
-- 
Esteban Blanc <eblanc@baylibre.com>


