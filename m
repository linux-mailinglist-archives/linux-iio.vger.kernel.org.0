Return-Path: <linux-iio+bounces-27119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DF4CC43AF
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 17:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB6053045F21
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A302DEA95;
	Tue, 16 Dec 2025 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wvg9qWFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA12D73BE;
	Tue, 16 Dec 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901837; cv=none; b=qFgyMA5RwVfSa1kLhJY3G0Vjl/koG3lmKZulLNT+F0d8bwZbwJ1c+7cRLYL63IqvQGYFgOJkLES0HuHRujZ+dzO1s9BHsaMxIvn6DRVRtTvwqSq33lEMAoHr6CU6VaQqRBfurJZuGDZnN/WJWGEwqfJAVoOxYFISpaXSnSmw6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901837; c=relaxed/simple;
	bh=nveQyXelJRs8xVTC+f/8zfa8S6CDB8Nm5F9nQBfWJxw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=HOicXfljUBUiu+BBCf2A6osuaS6noD5cd4wFh3cXP1hdiuD5J+mmXCqzvIBzzl8fUT6GZopqeuJ0eJMHnQPP3nWJ9wMUzALoXASoA7Z73LcDYV0RuGCKMa7dN6M1BvqN0tyXNeiw3F7GOM30qr+2f3RQit5VmWRG6cxfUutClfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wvg9qWFv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1765901835; x=1797437835;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=nveQyXelJRs8xVTC+f/8zfa8S6CDB8Nm5F9nQBfWJxw=;
  b=Wvg9qWFvQl0RS+5jw8VhnqjlMSOl8SkChfq6vUcIFyAChZwb3a3WMfkJ
   iOxl400UTJQzoX9XD20ItJtOpoEOM8SAID0Hi4WsT8lZk/4fcbTZrgDpb
   oBA9qQ43AcjS3GR2rdSeoRf0n1ZDeYAMbYkIXykI5IqdSOhr0IGPWNajJ
   Voo7jDO9IQgw9hcrMR7U4g8FRqZ0QjhzOKs9oKGX1hEP39WU3lHxPuZ88
   S4wp6Ejgb5b8BAgKVYwMBZ71fAjDs2Mv8+zzDgm+Zf1N9fVuKGQc3/Ymx
   aE+2YeoHBF4oVtfXYKsKgBtQ/BDmsuuc4fnEEgZ4tAuprXtHtUyhKNajR
   A==;
X-CSE-ConnectionGUID: FHqAzycuTxWjQG6jZvs2dw==
X-CSE-MsgGUID: P7YpDNviSE2mqaW16SPmPw==
X-IronPort-AV: E=Sophos;i="6.21,153,1763449200"; 
   d="scan'208";a="49936087"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Dec 2025 09:17:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Dec 2025 09:17:07 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Dec 2025 09:17:04 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH v4 0/2] Adding support for Microchip MCP47FEB02
Date: Tue, 16 Dec 2025 14:05:49 +0200
Message-ID: <20251216-mcp47feb02-v4-0-4b687094ff90@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB1LQWkC/23MSw6CMBSF4a2Qjq25vS2WOnIfxkF7KdIBjxRDN
 IS9WzBRMQ7PSb5/YoOPwQ/smE0s+jEMoWvTULuMUW3bq+ehTJshYA4F5ryhXunKO0AuBWld5Np
 6NCyBPvoq3NfY+ZJ2HYZbFx9rexTL+8oYxO/MKDhwOJBTlqyVSp+aQLGjOvR76hq2pEZ8cyFAb
 jgmXpDUWglXGm3/cfnhCGbDZeLOgbMGcqxU9cvneX4CQXucOCYBAAA=
X-Change-ID: 20250825-mcp47feb02-31c77857ae29
To: Ariana Lazar <ariana.lazar@microchip.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765886754; l=4952;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=nveQyXelJRs8xVTC+f/8zfa8S6CDB8Nm5F9nQBfWJxw=;
 b=o5ePsC6jFgmlQAAtCABwY23PPVXTQU2tykwOWofi423N/CsE2a03S7JX+nsIwwNBOoIpPvdep
 BMGzt3O6C+JAGPNVRSwSvXoaLhvjXCicwC2XwewG2NRBjIx2uiBHxaa
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Adding support for Microchip MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2,
MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series of buffered voltage
output Digital-to-Analog converters with an I2C Interface. This driver
covers the following part numbers:
 - With nonvolatile memory:
   - MCP47FEB01, MCP47FEB02, MCP47FEB04, MCP47FEB08,
     MCP47FEB11, MCP47FEB12, MCP47FEB14, MCP47FEB18,
     MCP47FEB21, MCP47FEB22, MCP47FEB24, MCP47FEB28
 - With volatile memory:
   - MCP47FVB01, MCP47FVB02, MCP47FVB04, MCP47FVB08,
     MCP47FVB11, MCP47FVB12, MCP47FVB14, MCP47FVB18,
     MCP47FVB21, MCP47FVB22, MCP47FVB24, MCP47FVB28

The families support up to 8 output channels. The devices can be 8-bit,
10-bit and 12-bit resolution.

---
Changes in v4:
- rename info field to chip_features in mcp47feb02_data
- reorder in alpha numeric order the features structs
- delete vdd initialization with zero
- review comments in code
- reformat Kconfig resolution bullets
- move reg declaration in device_for_each_child_node_scoped
- remove client field in data struct, use instead regmap_get_device()
- use MILLI to calculate voltages in mV
- use consistently if (ret)
- use %pfw to print fwnode name
- Link to v3: https://lore.kernel.org/r/20251209-mcp47feb02-v3-0-bb0ba9052f4f@microchip.com

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
 drivers/iio/dac/Kconfig                            |   20 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/mcp47feb02.c                       | 1251 ++++++++++++++++++++
 5 files changed, 1581 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250825-mcp47feb02-31c77857ae29

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>


