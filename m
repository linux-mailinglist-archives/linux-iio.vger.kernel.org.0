Return-Path: <linux-iio+bounces-24248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8651B84539
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 13:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C9F3A7A0F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 11:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419D1303CBE;
	Thu, 18 Sep 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WVb1TQGh"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020713C8FF;
	Thu, 18 Sep 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194504; cv=none; b=VggXu0YHpPM3EFyEPzYWbgZTHpn1Aw0HBOrrfTTjn9JaflRSnauoiu2HyNMCDXEY6Y+MgA1uCRvUj2m7QTqjcDin2sOdTVj/zLxTXO6i3OmnCSWh49ZaERf8DIo11ZivZ096gpdyaHYfccbsftcaBzejnzbf619/lPTrXNovEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194504; c=relaxed/simple;
	bh=hsuWnCI2Tw81ePkMSzBd/6aUApXDYJH5axeJjG9QiSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PW7PWxDkFIJ0W3heA4065PT7Zw4r4hv6WmxhHreSfOIgzlsHQ0/ckbDY5PPZj2+AnkmmEQo1vz8mAKUXOBAOciWp6B4MSHEBGePTX9UrV/ikMNK8Y7eg86M3FRJTiC1PZE2pCi6YCp/kP9wlB54uTlB7WVT7gB0g6VRGkUgtuEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WVb1TQGh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758194503; x=1789730503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hsuWnCI2Tw81ePkMSzBd/6aUApXDYJH5axeJjG9QiSY=;
  b=WVb1TQGhcmlpAmwOgoeHLAY02wCYGDZpy0aMhdGntsCTODTwUTxUYVQ3
   Ra+UnHCFc+6xUEIRdXOy8BFuQdrXmxUbeQVxKrpUZFVbPNBQrTbP5rGWc
   VyO8wZibW2MOiCon53fHaYoOXygfN87xkopVWW8AjFQgUHSG/3rr7rfNQ
   rbSTTDTAy9AN5iAnwdZZ3f+iLA8lyOZFOkWVmScYTWZVBmN9NurNkJKHM
   TK5S70NYtAVm8xMw5V4vi92mM7wWlS7e5rIufBQyFl56MXw/YTu8av8QL
   Of1JWqgIbuv+1+n4KGRwEY8WRFaOJBkE3cuOgESClR7XOGJTGAg6ARlje
   Q==;
X-CSE-ConnectionGUID: MK9Bjv+SSfyA+tPYDT8xQg==
X-CSE-MsgGUID: 9BExUEiDSomaq1CncY4/Rg==
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="278045452"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 04:21:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 04:21:03 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 04:21:00 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <marius.cristea@microchip.com>,
	<victor.duicu@microchip.com>
Subject: [PATCH v5 0/2] add support for MCP998X
Date: Thu, 18 Sep 2025 14:19:35 +0300
Message-ID: <20250918111937.5150-1-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

Add support for Microchip MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Family.

The chips in the family have different numbers of external channels, ranging from 1 (MCP9982) to 4 channels (MCP9985).
Reading diodes in anti-parallel connection is supported by MCP9984/85/33 and MCP9984D/85D/33D.
Dedicated hardware shutdown circuitry is present only in MCP998XD and MCP9933D.

Current version of driver does not support interrupts, events and data buffering.

Differences related to previous patch:
v5:
- in yaml edit description of interrupts.
- add min and maxItems to reg.
- remove ideality parameter.
- use pattern recognition in conditionals.
- group conditions based on the chip.
- correct microchip,parasitic-res-on-channel3-4 to true.
- in driver include bitops.h.
- change name of some variables.
- rename mcp9982_parse_of_config() to mcp9982_parse_fw_config().
- implement bulk reading of temp registers.
- lock ideality parameter to default value.
- implement bit flags.
- add compound literal to MCP9982_CHAN.
- remove hysteresis parameter.
- edit comments.
- change values from int to bool in mcp9982_features.
- remove mcp9982_calc_all_3db_values() and hardcode values.
  When filter is OFF the 3db value is equal to frequency.
- add .max_register to regmap_config.
- remove devm_kcalloc().
- in mcp9982_read_avail() add an else branch to hw_thermal_shutdown
  check.
- in mcp9982_read_raw use USEC_PER_MSEC and set regmap_read_poll_timeout
  to never timeout.
  Replace switch with bitmap_weight.
- in mcp9982_read_label() remove unnecessary if.
- in mcp9982_write_raw() remove duplicated code.
- in mcp9982_init add error messages when APDD and RECD are incorrectly
  set.
- in mcp9982_parse_fw_config() add default for reg_nr.

v4:
- lock beta parameters to default value of beta-autodetect.
  Remove beta parameters and checks from devicetree.
- lock temperature range to extended.
  This change avoids the issue of the average filter using raw values
  with different scales when changing the range.
- change driver to wait an amount of time before reading a raw value
  to ensure it is valid.
- change driver to stop calculating the physical temp when reading
  in_tempx_raw. Reading from in_tempx_raw will return the raw value.
  The physical temp will be calculated with in_tempx_raw, scale and
  offset parameters.
- add scale parameter to channel definition.
- initialise chips with "D" to work in Run state and those without
  in Standby state.
- when activating the low pass filter for chips without "D",
  set the power state to RUN to ensure fresh values for the average.
- add minimum and maximum to microchip,beta1 and microchip,beta2 in yaml.
- rename microchip,resistance-comp-ch1-2-enable and
  microchip,resistance-comp-ch3-4-enable to
  microchip,parasitic-res-on-channel1-2
  and microchip,parasitic-res-on-channel3-4
  and edit description in yaml.
- add conditional logic to check if the chip supports APDD
  and force default values where necessary in yaml.
- edit comments and coding style.
- replace asm/div64.h with linux/math64.h.
- add delay.h to includes.
- redefine mcp9982_sampl_fr with new structure division.
- in mcp9982_priv remove dev_name,extended_temp_range and beta_values.
  Add run_state, wait_before_read, time_limit and pointer to chip
  structure to remove all instances of matching strings.
  Reorder parameters for memory optimization.
- in mcp9982_features add flags to know if the chip has thermal shutdown
  circuitry and supports APDD.
- in mcp9982_read_avail() rework verification of chip type in sampling
  frequency case.
- in mcp9982_read_raw() rework switch in low pass filter case.
- in mcp9982_parse_of_config() replace generic -EINVAL code
  with -E2BIG and -EOVERFLOW. 

v3:
- move beta parameters to devicetree.
- change the name of the interrupts and add
  check to match them to the device in yaml.
- remove label for device and remove "0x" from
  channel registers in example in yaml.
- edit comments in yaml and driver.
- add minItems to interrupts in yaml.
- rename microchip,recd12 and microchip,recd34 to
  microchip,resistance-comp-ch1-2-enable
  and microchip,resistance-comp-ch3-4-enable.
- rename microchip,apdd-state to microchip,enable-anti-parallel.
- add static to mcp9982_3db_values_map_tbl to fix
  kernel test robot warning.
- in mcp9982_init() add check to ensure that hardware
  shutdown feature can't be overridden.
- replace div_u64_rem with do_div and add
  asm/div64.h to includes.
- remove unused includes.
- add iio_chan_spec in the macro definition of MCP9982_CHAN.
- remove MCP9982_EXT_BETA_ENBL.
- in mcp9982_init() replace regmap_assign_bits
  with regmap_write when setting beta compensation.
- remove custom attribute enable_extended_temp_range and
  map it to IIO_CHAN_INFO_OFFSET.
- add unsigned to int variables that allow it.
- reorder parameters in mcp9982_priv, change some
  from int to bool, add const to labels and add dev_name.
- add check for chips with "D" in the name to not
  allow sampling frequencies lower than 1 to
  prevent overriding of hardware shutdown.
- remove mcp9982_attributes.
- move mcp9982_calc_all_3db_values() to before
  mcp9982_init().
- use MICRO instead of number constant.
- in mcp9982_write_raw replace ">=" with "==".
- rename index2 to idx in mcp9982_read_raw().
- remove i2c_set_clientdata() in mcp9982_probe().
- since there are no more custom ABI attributes
  the testing file was removed.

v2:
- move hysteresis, extended temperature range and beta parameters
  from devicetree into user space.
- edit comments in yaml and driver.
- remove "|" in descpriptions, remove "+" from PatternProperties in yaml.
- add default to microchip,ideality-factor, delete blank lines and wrap to
  80 chars in yaml.
- remove variables with upper case.
- add check for microchip,apdd-state and microchip,recd34 in yaml.
- improve coding style in driver code.
- add includes for all functions used.
- rename MCP9982_INT_HIGH_BYTE_ADDR to MCP9982_INT_VALUE_ADDR and
  MCP9982_INT_LOW_BYTE_ADDR to MCP9982_FRAC_VALUE_ADDR.
- remove custom attribute running_average_window and
  running_average_window_available and map them to a low pass filter.
- update sysfs-bus-iio-temperature-mcp9982 to reflect current
  driver attributes and point to next kernel version (6.17).
- use compound literal to define driver channels.
- replace device_property_read_string() with i2c_get_match_data() to read
  chip name from devicetree.
- remove MCP9982_DEV_ATTR and mcp9982_prep_custom_attributes().
- remove client, chip_name, iio_info from mcp9982_priv.
- replace sprintf() with sysfs_emit().
- remove error messages which are triggered by keyboard input.
- replace devm_kzalloc() with devm_kcalloc(), array mcp9982_chip_config[] with
  individual structures, device_property_present() with device_property_read_bool().
- reordered parameters in mcp9982_features and mcp9982_priv to optimize memory
  allocation.
- remove .endianness from channel properties.
- change name of some parameters in mcp9982_priv.
- add check for reg value 0 from devicetree (channel 0 is for internal temperature
  and can't be disabled).

v1:
- inital version.


Victor Duicu (2):
  dt-bindings: iio: temperature: add support for MCP998X
  iio: temperature: add support for MCP998X

 .../iio/temperature/microchip,mcp9982.yaml    | 186 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/mcp9982.c             | 871 ++++++++++++++++++
 5 files changed, 1075 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
 create mode 100644 drivers/iio/temperature/mcp9982.c


base-commit: 671b9b6d7f4fe17a174c410397e72253877ca64e
-- 
2.48.1


