Return-Path: <linux-iio+bounces-26766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D64CA4DDE
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 19:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0120E3008BF1
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13882D8DA8;
	Thu,  4 Dec 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMJjfHpE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F842F7462
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871300; cv=none; b=lGV4a+x8ZLLd+OlOZw+ZBsWlFSac94qfMKTqo6s5JGh+QQRL+PM8JHC5ss38heiiIyr0b+OwTH+N5SJ24iZHA0beld3qlXgkzogaJmMkkKNgeXnm0N8kY9/MXg12H+YnCqtZsbzY+lMy6oTpOkTfTlpMBhSk4ALfyy/IYXxym9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871300; c=relaxed/simple;
	bh=huwmMFaySx6FLSC+EMVvx59Po4kvADPWgrF96TctHFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y21zBKHBdJYXcliM3rlxMQGZ7f4uUJfnPH4wpQw67WfVqgIf8u/dkNpzRJ90MVKFToOvhaBfYWyKybCOJbzAnlpWYfKiZyWCi3IrshM1tqu+rd3CrGlRvVVxXslVeMtobq8QZDCjxei87LhsCeS09cSb+iZev9vCm9RDPEYzq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMJjfHpE; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63fc72db706so1090309d50.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 10:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764871296; x=1765476096; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ah6Lkjxt4EMKymVwkILa5q6wuP5VRhjYl7KGZvEwPZw=;
        b=lMJjfHpEci7g53OOHspc7tAEYOADMeHSIM/eTpEHd22ofOMJwzLEoOPPECNY/WdSu4
         B8YuwPHFM62ar7DNXoc/KO9GtbYGght0IbL6q/jXvFQ+EOF0SGuV8ObRIQDnMv5i+Bdb
         xzSXbWZ2eUn75IxVCexVuf8YjaY93M2NqdCdchuiiRredmCv0ejzLEluB9RYEJxJYflD
         oL2YFCWEA5mfA1Evdyv1KBnFfxKZKRn68ZJWKJEY/s0ycMURS/v5v8WmH7Re4kQbGD+G
         T4CAOgIEoSsf01IILue3pLgwKoLAWvbAzL0yLyXAOmwSWQrD0nWwjBD0iFtja93/i0CY
         R+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871296; x=1765476096;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah6Lkjxt4EMKymVwkILa5q6wuP5VRhjYl7KGZvEwPZw=;
        b=MkA6IOXOBwt+3YEyc/3NeSZkDmU2sXYwCp65Y4K1orlt1yPf1CkC8WNF10RJ2UiQfJ
         WBzhCtwqjx30orGJ7JuveyLQsWcOCszf7Wsf/QmpfGkKnGup5gCyup7N3LT1fSjjvKkK
         WbmmPj8qfUjLPvV4ZgeW5BWEaYi15/Z0uyLEQtvhWuCxjEeFTMsxH2d6UlDYHtbLFBdW
         zdxSg4gupl6HsuX81LwkrP0Nj73oX5l40jN6B0UPKGkbV32ULij9uBR/Z5Atgjm+Pi/n
         w1kEmIJm9UQg8Sia3vVGkRFHPnWy5FlzIfXqHWJuslTMEv1PvPnA7Bu/NdhL+CANY6s2
         OwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp5fRYscrGudQDuXkGBIeN4kRKqIPruIbf4tQJ4opCFtr2+zxN92tv8vMZ+NxoUOApJEna2NCUi0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDwE7sYDJk9+dsovJhKWKRJmQEcHeYW/tijswV8QvErin4VXE
	S/LUNQDYYrS7ObLZ+2UZ8SLhNkcfpNmo75tYPbwniTfYiKqVlQj+7LTO
X-Gm-Gg: ASbGncsdDfSIsUq4za/GfxKSwYTdBDBfTLg+0u/xI+MXuVJq8lGkpzf5oaAG0RZm1ap
	slXloxSa2JCYQ3xIwiu6PbTTlYhKTHNKhE1ij09WLbbMd/C9DOVRB3B5VG3I3d8pDl9gzCsyk1F
	ciGPwpXrsAProXOG8927GDG626bxhYOXAjiX2zkhTT5qyW0BHJ3eY0O+mHnqvjqJovJQk0qKdSM
	Af/qVJ5Xo3xGifRNht3k7ZiSnFHRGRShzWeO4uvLrnlX+DMl6EMhr+5HsNkyDtXmVfGmpCalcXF
	VfAmu4BMXtG3Z+A5iT3QMpRodyw7ZiZUuord+8qxFdT0jI0GuL3Trq2Vm+qmBfPHZrTT36P8MNW
	CHWIxR/m74EzhYRO7ATSEsqrwlfzw6h191DR8hTF/DhM6gdTrcDIJjbpo8yltWr7MZwLFAiB0kK
	L2I12KG4k1ympNuXU=
X-Google-Smtp-Source: AGHT+IFDxoUJ28uFphCLB3ljOkEbq6CflQRoGm5+Df1M4myRY68x4y0ARfSOJdEYFGxbgIDGqhwF8Q==
X-Received: by 2002:a05:690e:b83:b0:63f:a87b:2066 with SMTP id 956f58d0204a3-6443d91c8fcmr2745508d50.16.1764871295435;
        Thu, 04 Dec 2025 10:01:35 -0800 (PST)
Received: from [192.168.100.61] ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b78e63bsm7704417b3.42.2025.12.04.10.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:01:35 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v6 0/2] iio: Add support for TI ADS1X18 ADCs
Date: Thu, 04 Dec 2025 13:01:26 -0500
Message-Id: <20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbMMWkC/13O24rCMBAG4FeRXJtlZnKsV77H4kVO1YBaaZaiS
 N99Uxc2pTeBP8z3z7xZSWNOhR12bzamKZc83GvQ+x0LF3c/J55jzYyAFAISd7HgEy2HCMZ0EbT
 ugNXpx5j6/Pw0fZ9qvuTyM4yvT/GEy+9fBxL+d0zIgVsdPVjoQ+fk8Xxz+foVhhtbOiZaO9McV
 UfJ99FY8FqIrRNrZ5sT1TmdvPMWlae4dbK5+jQnlzuDUHVbICP6rVNrJ5tT1XlNUsRktI64dvM
 8/wKgzTGXfgEAAA==
X-Change-ID: 20251012-ads1x18-0d0779d06690
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Kurt Borja <kuurtb@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5058; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=huwmMFaySx6FLSC+EMVvx59Po4kvADPWgrF96TctHFA=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJmGZ2ofnDgfzbR82eTdBh/0fEonJ17f8oDV6947MzXBk
 tDAEI9tHaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCR5VKMDHPe6+0N9TOwX9tz
 J8Vtw+2qB8u12Xaz9x10Pr3ox7FJr3wZfrOFTQh3fN3lZHQifuWTLd++bZa8XjjVJyf38lVf/Qf
 qvxkB
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi,

This series adds a new driver for TI ADS1X18 SPI devices.

This is my first time contributing to the IIO subsystem and making
dt-bindings documentation, so (don't) go easy on me :p.

As explained in Patch 2 changelog, the DRDY interrupt line is shared
with the MOSI pin. This awkward quirk is also found on some Analog
Devices sigma-delta SPI ADCs, so the interrupt and trigger design is
inspired by those.

Thank you in advance for your reviews.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v2:
  - [Patch 1]:
    - Move MAINTAINERS change here
    - Use generic node names: ads1118@0 -> adc@0
    - Rename file to ti,ads1118.yaml -> ti,ads1018.yaml
    - Drop ti,gain and ti,datarate
    - Add spi-cpha and spi-max-frecuency properties as they are fixed in
      all models
    - Add vdd-supply
    - Make interrupts and drdy-gpios optional properties

  - [Patch 2]:
    - Update probe based on dt-bindings changes
    - Rename file to ti-ads1x18.c -> ti-ads1018.c
    - Rework ads1018_oneshot(), instead of waiting for IRQ wait an
      appropriate delay before reading again
    - Only alloc and register a trigger if we have an IRQ line
    - Drop ads1x18->msg_lock in favor of IIO API locks
    - Read conver before enabling and after disabling IRQ to ensure CS
      state is correct
    - Add ads1018_read_locked() which takes an additional argument
      `hold_cs` to explicitly control CS state in trigger and buffer
    - Fix ADS1X18_CHANNELS_MAX limit 9 -> 10
    - Call iio_trigger_notify_done() in all IRQ handler paths
    - Drop unused includes
    - Drop BIT_U16 and GENMASK_U16 macros
    - Drop unnecessary named defines
    - Use u8 types in ads1018_chan_data
    - Rename some struct members for clarity
    - Move tx_buf and rx_buf to the end of struct ads1018
    - Rework channel handling to just make everything visible and add
      ADS1018_VOLT_DIFF_CHAN
    - Use .scan_index instead of .address in IIO channels
    
  - v1: https://lore.kernel.org/r/20251121-ads1x18-v1-0-86db080fc9a4@gmail.com

---
v3:
  - [Patch 1]:
    - Use unevaluatedProperties: false
    - Drop #address-cells and #size-cells

  - [Patch 2]:
    - Add kernel-doc to internal API
    - Drop bits.h and bitops.h includes
    - Add types.h include
    - Use unsigned type for data_rate_mode_to_hz
    - Rename __ads1018_read_raw() -> ads1018_read_raw_unlocked()
    - Rename __ads1018_write_raw() -> ads1018_write_raw_unlocked()
    - Rename ads1018_read_locked -> ads1018_read_unlocked() for
      consistency
    - Let ads1018_read_unlocked() take NULL cnv pointers
    - Add ads1018_set_trigger_{enable,disable}()
    - Refactor ads1018_write_raw_unlocked() loop matching
    - Invert ads1018_trigger_handler() logic to follow traditional error
      handling pattern
    - Refactor ads1018_trigger_setup() cleaner
    - Make ADS1018_FSR_TO_SCALE() calculation be 32-bit compatible
    - Some additionall minor cleanups

  - Link to v2: https://lore.kernel.org/r/20251127-ads1x18-v2-0-2ebfd780b633@gmail.com

---
v4:
  - [Patch 2]:
    - Replaced <linux/byteorder/generic.h> -> <asm/byteorder.h>
    - Dropped ADS1018_CFG_DEFAULT
    - Fixed long lines
    - Added Andy's remark on ADS1018_FSR_TO_SCALE() kernel-doc
      description.
    - Fixed wrong argument on iio_trigger_notify_done():
      ads1018->indio_trig -> indio_dev->trig
    - Renamed argument in channel macros _addr -> _index
    - Changed return type of ads1018_calc_delay() to u32
    - Mention @cnv is optional in ads1018_read_unlocked()
    - Use 16-bit transmission cycle in ads1018_oneshot()
    - Dropped spi_set_drvdata()
    - Use full resolution in ADS1018_FSR_TO_SCALE() and subtract 1
      inside macro
    - Rename ads1018_read_locked() -> ads1018_spi_read_exclusive() for
      clarity
    - Minor style changes

  - Link to v3: https://lore.kernel.org/r/20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com

---
v5:
  - [Patch 2]:
    - Fix ADS1018_FSR_TO_SCALE() long description
    - In ADS1018_FSR_TO_SCALE() subtract 6 from BIT() argument instead
      of shifting the value

  - Link to v4: https://lore.kernel.org/r/20251202-ads1x18-v4-0-8c3580bc273f@gmail.com

---
v6:
  - [Patch 2]:
    - Actually make the changes described above. Sorry for the noise :(.

  - Link to v5: https://lore.kernel.org/r/20251204-ads1x18-v5-0-b6243de766d1@gmail.com

---
Kurt Borja (2):
      dt-bindings: iio: adc: Add TI ADS1018/ADS1118
      iio: adc: Add ti-ads1018 driver

 .../devicetree/bindings/iio/adc/ti,ads1018.yaml    |  82 ++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads1018.c                       | 826 +++++++++++++++++++++
 5 files changed, 928 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251012-ads1x18-0d0779d06690

-- 
 ~ Kurt


