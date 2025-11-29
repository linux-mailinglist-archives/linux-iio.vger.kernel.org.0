Return-Path: <linux-iio+bounces-26556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EACC93760
	for <lists+linux-iio@lfdr.de>; Sat, 29 Nov 2025 04:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 619C734A0CB
	for <lists+linux-iio@lfdr.de>; Sat, 29 Nov 2025 03:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBB1A23B6;
	Sat, 29 Nov 2025 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIOvKzlc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1B405F7
	for <linux-iio@vger.kernel.org>; Sat, 29 Nov 2025 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764388059; cv=none; b=CqByjEG7idSjKpt+NS/+X2mFh7GY2e0Mg4ou2Ka1sXX/ttsCEVAHLZfrYMiCIcyF7ch57lygFgP9l7wiBBObMCrrLtnzpG+GUGOToV3JXmrxCb8g3Mf6pgAe99i+5zHItL06uw6ZgBmhXplcrvkjNwvKL9WTgGSf32L/4CskXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764388059; c=relaxed/simple;
	bh=yvuiPhp54wO6JJ8+rqOVUCDwrN2fpqtAXT2pT5bMb+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jNkEHgSBfUtsk9ounVUPAUt52GOi2r7N1J/OEFfuJEq6/UsSrwWfIbU98JDfgcgXDNWyhmfcfsITk+X4BPOtqM+TJYl+IMcXBDvPvplzyCkS7Eh9G4vFDgQpN07rCS/RpkONfFv2t4g3xkAuYqkm7ieDdKbagMW0vqfTiu29BdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIOvKzlc; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dfc6be7df3so772050137.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 19:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764388056; x=1764992856; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o+WemKR66A2jsYlrCntI/kxVeNaQ2VT5vDEXnzsmvfI=;
        b=TIOvKzlcVgtUyU3mqVy1pWDfN3RMiNILg8/rp7Kr3HfWIGX8kkuCaZU8iFlf3l7i4K
         QoosmPeYl9BjIeDXrWy2sWCUH9r+K8u/J6vAwzkTGpQKXsiK9kmMCVUDkD35vVQ7eJGK
         bDek1kRWNvEHr2JrIAlN7pGJIyFqz4jDU+Xl9iLIld9RW2Wrzu9A+XX79l8AtXJSJcjS
         4ZZ9wFhOTGlMSUGgoXNYRdOFWqusdaP7az0syumZ4Sad+ONR3qNjPhcrZTSNmsjsSras
         s7KTQNqy9CL28R8BrKgOnyUfXopGE6T6xIdCrLxmIn5Gg7OvH6Cz4rr5El2N1WoSHc+r
         0LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764388056; x=1764992856;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+WemKR66A2jsYlrCntI/kxVeNaQ2VT5vDEXnzsmvfI=;
        b=tX533+oL5Ja80K0x7D8b2w77wOHrKgTtzkF9HV+Du09a0oBkJ0GCh1kfzgpD6TtFQS
         CQJlr2hHdB3UZ10GRl4viIIf6JQjY9R7LBaDGZF70jo0vVxSNPXYxF5bwtCbnrf/+STi
         y7dHU3ZGPKLfQW26b74n14IuraztwGyeYF1/BXUL2uqZYEEOoyPnGIz36bKYqBAsFhP0
         6ixQyk8JieZvT54uUHjQ5dfFYRdhg4JELgLMAG63JLrSNgtUJmV53u1m3msLSeG1liTN
         UbRAtg2cNXv3HuQqpf+DVirpmEuy1r2n6lnMttBW9R/xHpASq/9wvno5URE9trBg4D2p
         Lrfw==
X-Forwarded-Encrypted: i=1; AJvYcCUoDMAObvdPBMXfPCrxmhnO64fQD5aoPCangyM6gkKPrJ/R19eD9Dr8lgnRGpbuc/xWRCjLfwqRMkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeboiOfTu+TLCoVkyyO8EXrNFQuWY/fxnObaYY+L5K4kNlxraw
	kMVnI2w5FP2A9YsiGcpA9JarxVnc88IDKrAs/V3gVdaXR8+/fSEUrZDr
X-Gm-Gg: ASbGncsilwIQEByTscz0vm1XkyBtXAQ66s3gN8ZfcuasRt5f9sSSM2gssqz3HYwtjoN
	KaZ2YOiApNSe53jP49vmp2vT3wlk3UpMIoASNPRoN+tQrCphdF5TeTXaXxKI4tBSuc/CxgHwT88
	I6J9GzNtOMy/ldsue0g0rYY7rjnW4x/b4qrx6homFzrDBOenM+Abirvm4mByBgTGX4wWSUTtdyK
	/tqnRiIom7Dd/vqEkLbnyBB7qk1IOeimXnH9sYphtU2v9CI9oZNjhBcKbaH1oH8+au24nzzdcAD
	26to8FImsrV+2C/H1cA/7mfX18HXgtXGyoccn3NgEtocyss88wMKkXqgb9O5w4AB4kUNz4bopkl
	j6OsvGyNL+tdQW5THtBOw0Yv4F7jXUQBlTepQ0RABfK/UqZXbpAxS5ec4YMMNoUcOBuQGAD478k
	5SMQVpe4G0ieB4Rh/DJW4kd7I=
X-Google-Smtp-Source: AGHT+IFriGnbvZfMgscLKz2M7HYz15cqGgb8idOJzTIt6/dQmhOawxZPI7HO4ranmrj6t7PICDwHSQ==
X-Received: by 2002:a67:e707:0:b0:5db:f710:497e with SMTP id ada2fe7eead31-5e1de3444c6mr11030831137.21.1764388056399;
        Fri, 28 Nov 2025 19:47:36 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24d917860sm2562662137.2.2025.11.28.19.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 19:47:36 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v3 0/2] iio: Add support for TI ADS1X18 ADCs
Date: Fri, 28 Nov 2025 22:47:11 -0500
Message-Id: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL9sKmkC/02MwQ6CMBAFf4X0bM3uom3x5H8YD4UWaCLUtKbBE
 P7dgolynJc3M7Nog7ORXYqZBZtcdH7MUB4K1vR67Cx3JjMjoDMCEtcm4oSKgwEpKwNCVMDy+xl
 s66atdLtn7l18+fDewgnX9dtAwl8jIQeuhKlBQdtU+nTtBu0ex8YPbG0k2nvy71H2yNatkQpqU
 ZZ7b1mWDzSV8UjWAAAA
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
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3910; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=yvuiPhp54wO6JJ8+rqOVUCDwrN2fpqtAXT2pT5bMb+E=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJlaOUd+/Tv1dOMl4TVvJlr/Pnf2goFrjpjGhUCX6aHTj
 B6Ui3Zt6yhlYRDjYpAVU2RpT1j07VFU3lu/A6H3YeawMoEMYeDiFICJPJVh+MU0+3/0jQ2XPwrN
 4p27SShVfVZOxIkJD6aF8c+YvW/JmZS7DH/FQwM3Hbdj1r5S/4vtYFKI95YNxW//Ff33v5lo2vR
 DfgcPAA==
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

  - [Patch 2:]
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
Kurt Borja (2):
      dt-bindings: iio: adc: Add TI ADS1018/ADS1118
      iio: adc: Add ti-ads1018 driver

 .../devicetree/bindings/iio/adc/ti,ads1018.yaml    |  82 +++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads1018.c                       | 811 +++++++++++++++++++++
 5 files changed, 913 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251012-ads1x18-0d0779d06690

-- 
 ~ Kurt


