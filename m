Return-Path: <linux-iio+bounces-26977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC8CCB0C23
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 18:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B78DD3078CAF
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C1732ABF6;
	Tue,  9 Dec 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iIkUEtvX"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E1199FAB;
	Tue,  9 Dec 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765302173; cv=none; b=I+VO5dGqUh3OpU8UUaJN1ITBSV8XfQ4N4rV/32voprT+nThix0MnzdjHK9KUhgxHOpK6V8NubtHFVLlAXryXdTMZb8QNUI4SXgljCp0G4WDq8/oJjLoJMaHaCPqJcPrn8BLq1SDSbNiGhJDB5PpFCuzlisYWlwZB308/43hL22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765302173; c=relaxed/simple;
	bh=ltbEnJePxGHfiWbMRJejKVkhJ9FvXRiTBky6V8Q0BXM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=jqlbHTlWs33nZqiEKs0p/9Xyv5RwZSLva+77xPiSOv5fPqHM706CX4PkM+wXhiVVf2LhwRS88+Y7SoSwET5DCBggqDg5mDV5H5Q+HYJpPts7F0Zhjbmc73NjCWjK/q5imkMXrNKvZNYSQnRMVoj8TmTv6aML34/kIF9hB8yanPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iIkUEtvX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1765302171; x=1796838171;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ltbEnJePxGHfiWbMRJejKVkhJ9FvXRiTBky6V8Q0BXM=;
  b=iIkUEtvXJ2cto+BjKR4Heq1JsvkT73W1ebcxN0FL4Xf9p46IRTyJo7p7
   LJAYKFaJOhn1ApbwNKsqGLCRhRprbGah8loX5HM6Xb7Zn7wQGpZ4LZiGc
   UAmc3lvqKldXJ/5pfi+RzMCj8OCMJPOl8gbEJ7y0p2cHrzTmxq5Wy125n
   sCAEq7h8X4mq4MJ8i3lSvzqL2ZEe5rLPEYCFyZEh2AK+i0gq5jSTc4aBi
   Bqb8Gz1XKKbE1UnLy1367g/si01rCHUZaCd8K+SmGfahfIMFgoIxntkwv
   6vtra6yErrjDE6SWv4NmF/8P79uiEE+BjmeTSv71DiSYoY7JC3/QhwRFh
   A==;
X-CSE-ConnectionGUID: LG0HgYJJTZ+gWu6GgiIt8w==
X-CSE-MsgGUID: Y75IwKQcQeOcyOtd1erMbw==
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="50302834"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2025 10:42:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Dec 2025 10:42:33 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 9 Dec 2025 10:42:31 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v3 0/2] Adding support for Microchip MCP47FEB02
Date: Tue, 9 Dec 2025 18:06:22 +0200
Message-ID: <20251209-mcp47feb02-v3-0-bb0ba9052f4f@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP5IOGkC/13MQQ6CMBCF4auQrq1pp+CAK+9hXJShyCywpDWNh
 nB3CyZGXb6X/N8sogvsojgWswgucWR/y8PsCkGDvV2d5C5vAQoqVUMlR5pK7F2rQBpNiHWF1kE
 jcjAF1/Njw86XvAeOdx+em530+r6ZBuCbSVoqqQ7UlpasNSWeRqbgaeBpT34UK5Xgk2utzE8OO
 a/JIJa67Rq0//myLC/jGene5wAAAA==
X-Change-ID: 20250825-mcp47feb02-31c77857ae29
To: Ariana Lazar <ariana.lazar@microchip.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765296389; l=4389;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=ltbEnJePxGHfiWbMRJejKVkhJ9FvXRiTBky6V8Q0BXM=;
 b=UIHgkxJ7kTCiN27HHBGGyOYXhlYfdsWmZ0VjPowCewVHENYyRVOjaJVSvHBvstEgwDj6jNdXy
 NvWfY806aP2Axtew/EdNsVgbJpq27PbwMiooP5zym6RXtLt0XFZQLbl
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Adding support for Microchip MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2,
MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series of buffered voltage
output Digital-to-Analog converters with an I2C Interface. This driver
covers the following part numbers:
 - With nonvolatile memory:
   - MCP47FEB01, MCP47FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12,
   - MCP47FEB22, MCP47FEB04, MCP47FEB14, MCP47FEB24, MCP47FEB08,
     MCP47FEB18, MCP47FEB28
 - With volatile memory:
   - MCP47FVB01, MCP47FVB11, MCP47FVB21, MCP47FVB02, MCP47FVB12,
     MCP47FVB22, MCP47FVB04, MCP47FVB14, MCP47FVB24, MCP47FVB08,
     MCP47FVB18, MCP47FVB28

The families support up to 8 output channels. The devices can be 8-bit,
10-bit and 12-bit resolution.

---
Changes in v3:
- fix review comments driver:
    run pahole on mcp47feb02_features, mcp47feb02_channel_data and
      mcp47feb02_data structs
    rephase comment with datasheet links
    add missing include files
    remove shift operations from defines and provided the shifted values
      instead
    remove MCP47FEB02_DELAY_1_MS define, renamed _MV to _mV
    correct style issue in struct definition 
    remove fwnode_property_present
    protect setting active mask bits operation with mutex
    use unsigned int instead of int where possible
    use IIO_DEVICE_ATTR_WO() for store_eeprom instead of IIO_DEVICE_ATTR()
    refractor Kconfig entry for better visibility
- Link to v2: https://lore.kernel.org/r/20251103-mcp47feb02-v2-0-8c37741bd97a@microchip.com

Changes in v2:
v2:
- fix review comments device tree binding:
    corrected the use of patternProperties and enum with an array of
      channel numbers instead of minimum/maximum
    gave more specific names to the labels of the channels
    removed '|' from where it was unneccesarry
    removed unneccesarry setting of attributes to true

- fix review comments driver:
    replace custom write function with regmap_update_bits.
    add read_flag_mask field to regmap_config struct and shifted all
       register addresses with 3 bits in order to correctly apply R/W
       command mask
    change cache_type field of regmap_config structs to REGCACHE_MAPLE
    add val_format_endian field to regmap_config struct as
       REGMAP_ENDIAN_BIG
    keep in powerdown_mode last value written to register before reloading
       the driver
    create defines for magic bits used in probe function
    remove unneccesarry channel enabled checks
    add in parse_fw initialization of reg with 0, check for valid
    reg number after reading it from devicetree and nonzero num_channels
    initialize vref_mv, vref1_mv, vdd_mv
    replace CH_0, ... CH_7 masks with DAC_CTRL_BITS(ch) and  G_0, ... G_7
      with DAC_GAIN_BIT(ch)
    correct write_powerdown function to write normal operation into
      specific bit mask from power-down register when a channel exits
      power-down mode.
    add const pointer to info in data struct
    delete device_property_present checks for vref, vref1. Read vref1 only
      if have_ext_vref1 is present in features
    protect write operations with mutex using scoped_guard or guard
    refactor probe function by creating 2 setup functions,
      mcp47feb02_init_ctrl_regs and mcp47feb02_init_ch_scales.
    correct info/debug messages where it was specified
    use devm_iio_device_register and deleted remove() function
    in write_raw only update struct data if regmap write succeeds

v1:
- first version committed to review
- Link to v1: https://lore.kernel.org/r/20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

---
Ariana Lazar (2):
      dt-bindings: iio: dac: adding support for Microchip MCP47FEB02
      iio: dac: adding support for Microchip MCP47FEB02

 .../bindings/iio/dac/microchip,mcp47feb02.yaml     |  302 +++++
 MAINTAINERS                                        |    7 +
 drivers/iio/dac/Kconfig                            |   17 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/mcp47feb02.c                       | 1254 ++++++++++++++++++++
 5 files changed, 1581 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250825-mcp47feb02-31c77857ae29

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>


