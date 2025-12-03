Return-Path: <linux-iio+bounces-26655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC4CC9DC68
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 05:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E17A3AA216
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 04:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E6280018;
	Wed,  3 Dec 2025 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTOd+2W7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AF2773E5
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764737802; cv=none; b=NCF4oeqc+u2XaFMM1+aFb6ThCkRkIipVkfihgd/L5RwGXxMDoQZWL3bSjvWFQC/5QwbUop04qCDOWqKHW3SjHJtThbIU1IwQUkAmiv53Q5IXITA7Dd8+iqqfPvUKGAGg8VGraIVWfxAidDFoJODFs5bKyat5LloKmIYvHviWIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764737802; c=relaxed/simple;
	bh=ejR7K3N1RTwwITTakASWOCJgJVrgW3hwfx6+5WfBvTc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nK1xHjBg/03R1hiLV3v3CBgEfcFp8zGIgzRfe8UuPYoto7DMkFkJeoY/ZDCud3IEi1o9dXnkcG37tq+Bkc4wyqLtSUzq1jHsiVrR5CyZE8JT4eKjcgz/m+ePlEkYlqPCyDr/Cb68PwMTXKeVz7l8Bn6D3oSdp7D0epVA8FKJnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTOd+2W7; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5dbdb139b5bso5444806137.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 20:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764737798; x=1765342598; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBQRiOIIR7pjLiXFMMQ02CyVzIOFN7EEY8M6gcxBZKw=;
        b=iTOd+2W7kLmorSR0fcn7gOar1GDVrq8wzq/Oy8E6p1c5E/Q5oHxl2mlyq09bWnkrH+
         t4M3k9NICEFvh2JJYHMs5wP3ScdZW3qafL/ma4LusDCkp490rc6Z1mvThrqtkqLHTt5Z
         RwXhdFsw68yxXyB0nTD7olYCgTRlvEhGYArDseL6VWJUHK4NcxeQcekG7ClDdZtqcFeU
         uGBOkY5LeHwAx7T+X0Ep0v952gF+fGWNKIUlv1wP18dtz6Fg0gapt8Zwz0Gf04jQQbkp
         PW55D0Bkt3c70COP7ksjX8Ua9RWzmlpzNqJo8yFjXHsiar7U3yGdxMw2DDu9hj2gMdca
         fj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764737798; x=1765342598;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBQRiOIIR7pjLiXFMMQ02CyVzIOFN7EEY8M6gcxBZKw=;
        b=WA6UNdIbro+M8ehRnzyAJjxeU4Hous+yEj2fty//BS7ceWF2BK8nsgwVwj7NjgTy8R
         EFpiomADQdkSGRblF00vjqbsuJEez13DXae6V0JbNGmphCEITQ9P0NMZdXYBwOky3QM7
         nRABhrTWGU+b1UNInXDwSVFLJ/bdAHi1ULVqD8LqHBxG4rlHGvZtFrNic6hccx+E5vq9
         rRw4A8PADbLVd/gI7YjhVz7BybcksCjsoxaLlP/RjIzNfo6QpB0zBG/sKd7Lm9KhGNDB
         inEcbuMamE3j+sQ6FEpvtZWPx8yJ7m/4W1BOkqL+ih6hg7k/gfW2KaL6+HrBXOuqiwM+
         LDQw==
X-Forwarded-Encrypted: i=1; AJvYcCXqpLWLRhBFWXa+NEKoQJAv1jj6UQqwhVfjcFjLMpecAJc0Qmo1SR5I2WzTKnLnS4mcdMMSj3CaeXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMx/Py6LtqcEkxFiB/6H7cCydfTzVUH3uqoREZ2nd1vldCCKa4
	OU1qkX556ot31AzN4NLjQvSO9drzSDA/WLbKw+0yQhhhQqScx8oJnnfX
X-Gm-Gg: ASbGncvbhZKnbx7tR8Jq+vpNwQkjiePfK3TTYlVfimvx5N6xADVFF1rk7Y2l7urch9X
	jorJMAnsFmdijBQNXrkA1UIOTpfyPsn2QvevJAJQBcvx+60Pd14R7B6T8oHhTX3o+3DAO8LNtb0
	i/fOmgi7RmKd9sEm9KUDlPxF/V+WfZ0GvDBDzBNp8kGsgtEceB34sZxPAXuLzGc2H+alwt3EiYH
	TI0yadVC/MB/SJ8RXYhhirfbupAweeXwsnzxi1p+Z4rmHmhALcw/KXWos2fGA5jJ6/tz1PxvZS0
	Ii9rz38lyEoe/GSIdqwpK6h3ORJhb+Jc2fGYuk8lzkdd5OE7uDjWVIyACJ5oC3P1vsJDlhALkk8
	lV574x/Khyd1WT+aMJhU5EL9U3Ua1ypniBVgWJH6b9DqbQX/pSj7D9/yo34ORJkegWPTaqKoucD
	YrCqKalvMp+UHO
X-Google-Smtp-Source: AGHT+IEe3yqUkhx/+vB4VGHX1JLrPuf0sljxym5HbzX5wIRzoVCqVeftHfjQTIC2hBwwr/LuitKNiw==
X-Received: by 2002:a05:6102:5795:b0:5de:93bb:c56a with SMTP id ada2fe7eead31-5e48e37b346mr318671137.34.1764737797959;
        Tue, 02 Dec 2025 20:56:37 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd6c6802asm7535496241.3.2025.12.02.20.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 20:56:37 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v4 0/2] iio: Add support for TI ADS1X18 ADCs
Date: Tue, 02 Dec 2025 23:56:17 -0500
Message-Id: <20251202-ads1x18-v4-0-8c3580bc273f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPHCL2kC/13MQQ6DIBCF4asY1qWZAQXsqvdougBBJanaQGNsj
 Hcv2qSaLt9kvn8m0QXvIrlkMwlu9NEPfRr5KSNVq/vGUW/TJgxYgYCMahtxQkXBgpSlBSFKIOn
 7GVztp610u6fd+vgawnsLj7hevw1k+GuMSIEqYQ0oqKtS59em0/5xroaOrI2RHZ3cHUuOOVNbq
 cAIzv8dPzq1O56cFs5oo7AwzB7dsiwf28/djw4BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4807; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=ejR7K3N1RTwwITTakASWOCJgJVrgW3hwfx6+5WfBvTc=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJn6hxn7PdPjnP/cPuFs77Pt/srl9+puXP3/Vaf5nVzWn
 KbQwoULO0pZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAilScY/nApfJijf6p/ropa
 X2e+e1P1eqUWxiPHDrHYch/8dT3T8z/D/4TAfW6GPH07mu1KJ+XvWZRQvkQh+N6xz4+efF94JuX
 cT34A
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

@ David:

I didn't move enable_irq() and spi_bus_lock() out of .set_trigger_state.
I explained some of my reasoning in v1 and I expanded patch 2 changelog
on that. If you disagree with this, let me know!

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


