Return-Path: <linux-iio+bounces-27038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B0CB7DAA
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 05:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51773027E1B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 04:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0DA2C0278;
	Fri, 12 Dec 2025 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD9cJOJi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A702222AC
	for <linux-iio@vger.kernel.org>; Fri, 12 Dec 2025 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765513563; cv=none; b=Wq2hisyIl5pVxqAo6oFeiT+l84zycYMf6HD53bwtR/AaWOM4eBYUqRCLkGKlv0FWPPBJVY34WPAY6j1eh/H2iVmiL3K3G8pbO8geulCkBy7Odo9d5bQUBsVx3k5O0w0Wtf1VmT0mIIUuOsEtLXwfHBKsXDva3ZuHIU9qH4wqK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765513563; c=relaxed/simple;
	bh=fU1878XGiN5vjV3WDr/Q/cKWHTKzwVBx29Diu3Ayjqo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g7dnl25cGZLcyglM9z8DrS2CFyUrNPE5qJryrL0JnlVQ2BwZ6godWMJ2cR4EUIbd5JgxF/1/oqvPapTOIu9zXhG3ppfGML041PswVeWyNRT14m4D3ib0jG1hp5WszvFPwQas8CrBeXp7eFD2znvO72sd4bRnNzxuL2Q23GpjrpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD9cJOJi; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5deb0b2f685so565042137.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 20:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765513560; x=1766118360; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqWqCX6BUjy2SxjnboQguv7wzALF+8T2YfMFe9IGwRk=;
        b=fD9cJOJiffnLZJxl9NjnNL7NF7Q4r/JdpVt0eC+pYg34CrmsDEOQ5Tit0Vl8oBYobI
         eVRIL33nAJKyuCCrNzxBDRyl7DLZ7BDHmsGSUr0oJwwfbqnP/+dfYhe7KNX/DikMJP4k
         odWZCeYXT6F9YHh4pTib3MF/JBMx07bzUw3rffGW3w2md+YbuAZWOXsQVw1sm7iW+0Dt
         UZRcQOU+n7+9Papv0uT1WzWi3yiJEQgWUEAB/Z507qOEpz48dUCiTwt/8Tgx3WjmnkoD
         On5n+n1OjOMA6JFE+LcVbd4+SIvb86nK4m6YEkjzaJLCl6rNAmes/YGP+n+rapWXbduV
         W0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765513560; x=1766118360;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqWqCX6BUjy2SxjnboQguv7wzALF+8T2YfMFe9IGwRk=;
        b=flR3nD49qG8HhDahB0hF6qCOTudNF80kAH/CwYZGkvdemqaZ3fIeCB1bbgDc7/vHts
         35YiBwAolsPuhmlP1nZCOe2PvxQQuUtdZXIPlkvyxb2DyEIFHDBMlxEr0lYKaYDN7j5T
         NRIO9AJrwlPc3yWslJxUGTlQ9I4TJio8ys8YOcTC3mr3N5n4EhydxRsaJGcxhvcyI6lU
         tVzW6tfpKOWTOPJbc9pfCUrKFjkWNOZWw5BjC8QmIi4vsiXJMvttQZ6Wnmgln5w/x2zP
         GmyywFAp7QmURgS+pCDZVxvJmh5sxYar7GijfihDwefyrDiu5+JRuzG7CdEJqKYbPP3S
         MvuA==
X-Forwarded-Encrypted: i=1; AJvYcCX6r54Hy6kCdmtHvdi+o0lR/TpaKGnKAvbJp8BUh15yIdeaj7adeDEoRE4vzxPk7VsxBLj+MG7RkUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDoVrQFo09nQQv4w1npnT8eQnVZxw8AbPME0IV+f69DyYppXm
	g/F6DW9nlOM5tAoMt3+gMWpcE5CqmmNCRRHLC+gin95NErLvXvXVqlxf
X-Gm-Gg: AY/fxX51q4Swl7bnzS5HtVLJv4fKeZRyHW4Z3Yi+EfkfRMZTJUvb+wI0gwwE/t5T+35
	RNabvzHB4Vd3hSBbTZ6oIC9F8eETMM3nYjRNv0TH9LerAF033/Ugu9fd1gpWtr40AY69CYdt3Tx
	xmUx+OL9zHbfi7yqry0Usdwr8zWIFjNLoyU85IsSRSBQVSfhtZHgTclP5fYU4PganFD2zqJ77AU
	MiJYeQG6ExdOHAjX107fjY83Jsd9VR+EQCV71buXOU8rT9NsowNpjgcISqlecG61Vh31jtuGOej
	MPfrQTunkrMPMUGlrTyoezoTlQAT71p9pjeWj4OJ+C2gJLiAD9oSavcHkFjXTOoQ0wscB/oPGCE
	LcRpYZlLEj7cjimI3WDGvTgJYvu7zhzpJFahC1HmkqlSaBTvGxWyhEVgPjkMYP1aKCQ2Z4v0MUU
	trXXY+wAN/C0b+
X-Google-Smtp-Source: AGHT+IF6QReY4PVnlB+PyLOTehK8C/QeLzOzXQkR0sUbOdlei2KYPT68btGmkGmatru5dU6mGINliw==
X-Received: by 2002:a05:6102:3a14:b0:5e0:d009:e4d7 with SMTP id ada2fe7eead31-5e811584811mr1673494137.1.1765513559922;
        Thu, 11 Dec 2025 20:25:59 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93f5ad0ca0asm1489016241.6.2025.12.11.20.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 20:25:59 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v8 0/2] iio: Add support for TI ADS1X18 ADCs
Date: Thu, 11 Dec 2025 23:25:42 -0500
Message-Id: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEaZO2kC/3XQzWrDMAwH8FcpPs9Dkh3b2WnvUXbwh9wa1mYkI
 7SUvPucDhYT2MUg499fkh9i4rHwJN4ODzHyXKYyXGvhXg4inv31xLKkWgsC6hCQpE8T3tBJSGB
 tn8CYHkR9/TVyLrdn0vGj1ucyfQ/j/Rk843r7m4GEfxkzSpDOpAAOcuy9fj9dfPl8jcNFrBkzt
 c5ujqojDjlZB8EotXeqdW5zqjpvOPjgsAuU9k5vrh6b0+ucUXW1WySr8t51rdOb66oLhrRKbI1
 JuHfmH2fW/TxrT9lxD3HvbOua/ezaDwO7lOvveGrdsiw/PZZrL+4BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6298; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=fU1878XGiN5vjV3WDr/Q/cKWHTKzwVBx29Diu3Ayjqo=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnWM0M1jxXIimsf1AiJ4Y9dF343YYarzomLC3vLmGTP6
 msd0L/WUcrCIMbFICumyNKesOjbo6i8t34HQu/DzGFlAhnCwMUpABOpfsPwP9ky9oExa8QUr8PL
 f8QsWXMudqHK58Y1avUpWxdNM4o7MouR4c6Nxc1zOvx2REsl7ek9rVV2Ojk35rOuqofwPa7Krl9
 WzAA=
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
v7:
  - [Patch 1]:
    - Reword description slightly

  - [Patch 2]:
    - In struct ads1018_chip_info, make pga_mode_to_gain an array
    - Drop ads1018_{get,set}_{data_rate,pga}_mode() helpers
    - Drop context remark in ads1018_calc_delay
    - Prepare device configuration in ads1018_single_shot()
    - Let ads1018_calc_delay() take sampling frequency as an argument
    - Drop *_unlocked() methods in favor of *_direct_mode()

  - Link to v6: https://lore.kernel.org/r/20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com

---
v8:
  - [Patch 2]:
    - Fix commit message (These -> This)
    - Multiply temp scale by 1000 to comply with ABI, which specifies
      final temp calculation is in millidegrees celsius
    - Drop ADS1018_FSR_TO_SCALE() because ABI specifies the final
      voltage calculation in millivolts, and the macro would overflow
      32-bit values while calculating, even after shifting 3 more times
      :(
    - Add comment about gain calculation in struct iio_chip_info
    - Manually list voltage gain in iio_chip_info
    - Use HZ_PER_MHZ instead of MICROHZ_PER_HZ in ads1018_calc_delay()

  - Link to v7: https://lore.kernel.org/r/20251208-ads1x18-v7-0-b1be8dfebfa2@gmail.com

---
Kurt Borja (2):
      dt-bindings: iio: adc: Add TI ADS1018/ADS1118
      iio: adc: Add ti-ads1018 driver

 .../devicetree/bindings/iio/adc/ti,ads1018.yaml    |  82 +++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads1018.c                       | 746 +++++++++++++++++++++
 5 files changed, 848 insertions(+)
---
base-commit: daea3a394a8b425a2dd206ab09eb37f0d1087d35
change-id: 20251012-ads1x18-0d0779d06690

-- 
 ~ Kurt


