Return-Path: <linux-iio+bounces-25863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D4CC3023C
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 10:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A44E4629C5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86132BE7B2;
	Tue,  4 Nov 2025 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="biwWVva3"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124D29D27A;
	Tue,  4 Nov 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246591; cv=none; b=TwwCb27da/GM2JvxCzF0/kG1yLozwjkC+ZoXNhKZEdemEPiD3/FrXCElSy/OVyCFTL8XVpNqR2EsveB3XxrIxzB6t3FlZT+Y1K8s+gEB8Ce9tP9EQiwh/6bLtVMwmCWsva6pgn/vRy7rlRNa5TJAxhrwwy6DSLhbk+OCj15CYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246591; c=relaxed/simple;
	bh=RGEXb1jvx5eNAWaVzEXgdcBVuRQZ/Fof4ebyLkKZUvY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=JAWSmaDTSfY4LvyTvX28PIJCzbqNcGoPEGeH5+521Ll7r5sNUbc/eOXLjfUjZ+HB/qfLbdTMNNrhjZnGUUyfzAlaMFmHCncqDOrbZ6vbxaQWj5/Dzj8J0uhIEnnD/gUL87n4pM9umWSQmKda6MvO++usorWhES7yOrjDYd+EeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=biwWVva3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762246589; x=1793782589;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=RGEXb1jvx5eNAWaVzEXgdcBVuRQZ/Fof4ebyLkKZUvY=;
  b=biwWVva3V8zmfbnIBLEPnjJ6R/0lwS25BCP6V/lARi5cWSwZAhQ6A1qW
   +TSqloolUwAYRAmHgNIgSFITxZ1byzfLcVX7d/rGecajZMjZS1TLVmGCY
   t3vKGNJvklehUHRHzCsajhjNHjXPeXOyc4MkgJVPmAw8gBoFzGAMy6MXa
   ysDacrI4pY0RMj8aAAXcD8nurcVzpYPvs6RbIz2P+69CW8pPC/f4c6uYd
   V0MMpqBsAglNRDfbkPbubJVKBjWZpJGcWgPbKwzLkFlFijSJbGBsuUHYu
   Cmc7j3x7rUCdrqmHBcgtvLEiNSgpgR9VJOu7eS6PcjHWyaSQHWj8DXedE
   A==;
X-CSE-ConnectionGUID: ah0thdEYRoWg7Z9edIgL+Q==
X-CSE-MsgGUID: v7hDKFhWQLqfb+ojoUk0Sg==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="48018750"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:56:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 01:55:48 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Nov 2025 01:55:46 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v2 0/2] Adding support for Microchip MCP47FEB02
Date: Mon, 3 Nov 2025 17:50:28 +0200
Message-ID: <20251103-mcp47feb02-v2-0-8c37741bd97a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETPCGkC/03MQQ6CMBCF4auQWVtTBmqBlfcwLMo42FlASWuIh
 nB3K25c/i953waJo3CCrtgg8ipJwpwDTwWQd/ODldxzA2o0ukGjJlpqO/KgUVUlWdsY6xhbyIc
 l8iivA7v1ub2kZ4jvw17L7/pjWsR/Zi2VVvpCQ+3Iuaq210koBvKynClM0O/7/gHdstSWqAAAA
 A==
X-Change-ID: 20250825-mcp47feb02-31c77857ae29
To: Ariana Lazar <ariana.lazar@microchip.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762185039; l=3623;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=RGEXb1jvx5eNAWaVzEXgdcBVuRQZ/Fof4ebyLkKZUvY=;
 b=npDCpr+p/vK53/5hLovZz3M3cNY1oIGt/NJj4n8s/gkufd3bPrA3ucT38OG6GTmn7cdxmRqzl
 w3qaLmdoVPqABN2wXSIoTWmZo18uNjj5WSyqspgQJzjCNwdbSq6SxrD
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Adding support for Microchip MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2,
MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series of buffered voltage
output Digital-to-Analog converters with an I2C Interface. This driver
covers the following part numbers:
 - With nonvolatile memory:
   - MCP47FEB01, MCP47FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12
   - MCP47FEB22, MCP47FVB01, MCP47FVB11, MCP47FVB21, MCP47FVB02
 - With volatile memory:	 
   - MCP47FVB12, MCP47FVB02, MCP47FVB12, MCP47FVB22, MCP47FVB04
   - MCP47FVB14, MCP47FVB24, MCP47FVB04, MCP47FVB08, MCP47FVB18
   - MCP47FVB28, MCP47FEB04, MCP47FEB14 and MCP47FEB24

The families support up to 8 output channels. The devices can be 8-bit,
10-bit and 12-bit resolution.

---
Changes in v2:
v2:
- fix review comments device tree binding:
    corrected the use of patternProperties and enum with an array of
      channel numbers instead of minimum/maximum
    gave more specific names to the labels of the channels
    removed '|' from where it was unneccesarry
    removed unneccesarry setting of attributes to true

- fix review comments driver:
    replaced custom write function with regmap_update_bits.
    added read_flag_mask field to regmap_config struct and shifted all
       register addresses with 3 bits in order to correctly apply R/W
       command mask
    changed cache_type field of regmap_config structs to REGCACHE_MAPLE
    added val_format_endian field to regmap_config struct as
       REGMAP_ENDIAN_BIG
    kept in powerdown_mode last value written to register before reloading
       the driver
    created defines for magic bits used in probe function
    removed unneccesarry channel enabled checks
    added in parse_fw initialization of reg with 0, check for valid
    reg number after reading it from devicetree and nonzero num_channels
    initialized vref_mv, vref1_mv, vdd_mv
    replaced CH_0, ... CH_7 masks with DAC_CTRL_BITS(ch) and  G_0, ... G_7
      with DAC_GAIN_BIT(ch)
    corrected write_powerdown function to write normal operation into
      specific bit mask from power-down register when a channel exits
      power-down mode.
    added const pointer to info in data struct
    deleted device_property_present checks for vref, vref1. Read vref1 only
      if have_ext_vref1 is present in features
    protected write operations with mutex using scoped_guard or guard
    refactored probe function by creating 2 setup functions,
      mcp47feb02_init_ctrl_regs and mcp47feb02_init_ch_scales.
    corrected info/debug messages where it was specified
    used devm_iio_device_register and deleted remove() function
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
 drivers/iio/dac/Kconfig                            |   16 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/mcp47feb02.c                       | 1233 ++++++++++++++++++++
 5 files changed, 1559 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250825-mcp47feb02-31c77857ae29

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>


