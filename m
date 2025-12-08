Return-Path: <linux-iio+bounces-26949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47314CAE13D
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 20:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D36D63095AB1
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 19:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EBA2E88A7;
	Mon,  8 Dec 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKKfZDiq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CEE2DAFA1
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221905; cv=none; b=NlIGKb4lfsWmWXrQpeBm9ja1sVv/tMLV4rldanzhkzVUCLTm9PJJrGUV2ROlIDLyuq6cIqbUdJFaOeTAzqAg4V7mBuE9y4MWtYXKorZ19ezh4HiBPvyrFBai0mNM6TsniZIyd/aOboaj81vvmF5Uz2YWPkxlNVv0AZjbdpRf1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221905; c=relaxed/simple;
	bh=zCMZDBm15cVh/x4JQEF8rBeaHpuC3U8OtLBEvmMdgwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I+hpW6MdXBb7UIeLYeYBkwOHb/FLdE/a9qMJ3PbGUDtcFTeS7bEzI4njhkSG5agPgc7N3DL/EmK40W4wLsPa6oV5Lm//9CcIvSPQO47XkV2FeVNZMeKXOWKkxbDT812HlQClxOkU0c8pIzaFw58s5QWAANJfXgSKVCos1foA9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKKfZDiq; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-559748bcf99so3701611e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Dec 2025 11:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765221902; x=1765826702; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oTDO01MWPwITXTjV2I79z1YT9l7+kYjQpFuhrPI4WXQ=;
        b=PKKfZDiqFzgzcZqG+itOHlx6A8rSmgPMCzy1iqJ6QfOYEBaHUcMtauGE3kxJlSb8/C
         wJdHTtWqiGKneNT295iONG3sDWw1xnUCv+ZZ2sApOURHE7YCMa17OSi6ZFMwL+pIw9vf
         qSDsNLxXI01FtaKeK6V8sEq+ZpFwS905uq2GhLnbXwrCE3DhpLhlM49f+kGO2dk2NAtG
         /AQ0PlrcGGobMiw70xSnvCtGT3jaA/I9WwN308GXxzqS2dUB/mU6Tic3bm6Hs/9hbT3r
         eTBMPEZM07o3t4DOJxBPLUySk5LtFsJXEp0xD0TGMtW7bzoxlSIDh66Dc/e8scl/6ZP4
         Etjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765221902; x=1765826702;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTDO01MWPwITXTjV2I79z1YT9l7+kYjQpFuhrPI4WXQ=;
        b=fPkJ/5XXfjwhmcB6xbJqPeckdt8fzuXAJ+c9CFDXo1DLHs+rlUbyJQCOfB8jJRp+/r
         B6WxoIFeYURkjfba74YeD6lMO4z5VxW4Js60p+1TF6n90WFOTulEuM6RiI7UjEBXxV4L
         qr8+MCWSyamcGgmdY9a6Gr+2KqvET+ewbc2h9I50VIgXnaR0segJD6QYNlA4lEORuNRW
         hWWG0u93zeIna5R6sbsvFxSfj7poycmozQ0QjlL0VE7/L1adtr2UpTpEuHgk5NrdFe/k
         DagK+6286uHki5+kH2PKarACBMDWqlSHjbollsddrLMJSojcJoMZjYuOUNsFI3zFC4y6
         OX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX7+32XljOsAXg3UWtJOTfb4GsnWO3l64W2AT7QrGJgRG7Quycfnfk+W/DipZ775W5BixI2MhKzvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTti+Js158cciOKwBrW2zR/OX1TBi2ck6/PSNp/Ny3ztoL5GZk
	STnJWrL7Ul3ikUyQ5tYtFekLkSd+GUj7Igx5ipU3KLM4OYI15mzPAKOkRVSgdw==
X-Gm-Gg: ASbGncsCR0NOFp9cd1JedaSp/T8Fu+rn6Hk6dJExalyRK4i/tpMiKDmQwiGRRTKF9mD
	fhSBK2RLisXIzg2FlOAMYFAC1iWo0QVQu2kWGiQlVd9FndXiGWtq0e+mqbCZT5E7AjLLDvYoht9
	DKx50qedThukBbjc1u5IMabc7hLnwjeyajMorGZfXQoO/fbL2d169z0ZOCLe6PoPLO/LkRNqLUN
	+awHuYNy7bk00hi7RW4eBAlZtaVKrSU4pKJGoTQt1hIbcusyRjGqmontlQlJo6LD1vJh2svEZNr
	FUM9CZqqe0P9P4bQ1cr7MEBG0OAHIygngJ/ee50qLg/ecF+QRnTvHPZh3+EjMjli0CaRt31l+LZ
	Q5YJ8EqXDMb+XJ2j+94wAeFVxzQHogI6/slA/zDDWTppQ6F2Z1UB/u/VlSmMMfNIwciH1iY9B3E
	tcRulq7eoudcQxDHE=
X-Google-Smtp-Source: AGHT+IFqHU+dYOKzo16y/G3coPWvFp5VJ/dE+PcuSvfXp0UMXSqsGasXJ96yfLetuPJgRmia2qwW+g==
X-Received: by 2002:a05:6122:4f81:b0:559:6b0c:1ca2 with SMTP id 71dfb90a1353d-55e847543d6mr2811517e0c.16.1765221902096;
        Mon, 08 Dec 2025 11:25:02 -0800 (PST)
Received: from [192.168.100.61] ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c9c8fafsm6480475e0c.20.2025.12.08.11.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 11:25:01 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v7 0/2] iio: Add support for TI ADS1X18 ADCs
Date: Mon, 08 Dec 2025 14:24:34 -0500
Message-Id: <20251208-ads1x18-v7-0-b1be8dfebfa2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPIlN2kC/3XPy2rDMBAF0F8JWldlZvR0V/2P0IWeiaCJi1VMQ
 vC/V06hMoZuBFfo3Bk9WE1TSZW9HR5sSnOpZby2YF4OLJzd9ZR4iS0zAlIISNzFije0HCIYM0T
 QegDWXn9NKZfbs+n40fK51O9xuj+LZ1xvfzuQ8K9jRg7c6ujBQg6Dk++niyufr2G8sLVjpq0z3
 VFzlHyOxoLXQuyd2DrbnWjO6eSdt6g8xb2T3bWjO7nuGYRq0wIZkfdObZ3sTjXnNUkRk9E64t7
 pf5xe/+eSdJRtGiBs3bIsP4sU7vq2AQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5611; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=zCMZDBm15cVh/x4JQEF8rBeaHpuC3U8OtLBEvmMdgwo=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnmapzLfzU/8HRYb/tCR+5200xBxa3uuYbLl/4+N/cD+
 x22wrmVHaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCRO1sY/hdXLbXjydZ4ZlZ5
 4r7oCynLaxt3+T048VI58yyz0qFNtQyMDJ0+AkcVNL8c+WobMDljZ96RVfEn9i2KDFuxYf6Gw5V
 nuxgA
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
Changes in v7:
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
Kurt Borja (2):
      dt-bindings: iio: adc: Add TI ADS1018/ADS1118
      iio: adc: Add ti-ads1018 driver

 .../devicetree/bindings/iio/adc/ti,ads1018.yaml    |  82 +++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads1018.c                       | 743 +++++++++++++++++++++
 5 files changed, 845 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251012-ads1x18-0d0779d06690

-- 
 ~ Kurt


