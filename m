Return-Path: <linux-iio+bounces-23376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50CCB3BDF3
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 16:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678D01C26A96
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E13203BE;
	Fri, 29 Aug 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Plf10Zmr"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78818218AAB;
	Fri, 29 Aug 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478146; cv=none; b=i6JGaO7eFAbM0jtlecOtRU7ev0y8HqWOucv81TgmPg1giD9iL4sRndYuQzzXpaKeLqWx2CU8IK8R2gK3Gs9nphoUK/17rfEibgXWTx/0LK8IcbmjnVTEltI7PVGck1F6wKnDs7+pNuFBMbeaEC+k6uk7vq5JVriHlfYukCU9E88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478146; c=relaxed/simple;
	bh=8LuM2EE6lK3+Es17Kg/IX71YqYGJ37/bXjOklL70f4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VMIyN/3Cnm5zt7HaJzP29SkDs9Zjbfg7Cwd5qQDJ+DwAgqPl8DY1+tOpSwieNmhv653KEXXL1H8ilfaY273Rb+lDB7NArNAygw2xVfmFudvANB2saX0lxzqC3bfVdCjdTPPakWoZ26R5rR+8JALiFPPlvHYxh5bAD8cfjAkLY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Plf10Zmr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756478144; x=1788014144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8LuM2EE6lK3+Es17Kg/IX71YqYGJ37/bXjOklL70f4E=;
  b=Plf10ZmrMoNuwIP0DMvuQ+NF2K5oy/yG4rTbJqHHPEjssZIVjyYZJgbu
   SidLs5rXMqh9Vm2agd9nIGmf4zosZRLM64csqIUEtuODU4zRu3ovHLNf4
   PSS8yDkvsv7EeKUgCUg9ClidruixxK0+AayNTY/6vKXjIZvHl0kEeWy4N
   ABPmIl9UnRqblnr0Bq6vMR7gpgAqgu2Ry0eXqoqNNxP2tgCCuUB9Foy4c
   WQ3Y92lj62vlU35DF3EaWPbZoIFuvrAbrKb+jim/2qXhmnke1h95vpC/f
   cyEj81N3AZjmU81BiM5xb7nhd98ecDTeyAL13VioueR4bJ2MgfMTA1kQf
   w==;
X-CSE-ConnectionGUID: TCg1LSkDSOqnm38LtONLrg==
X-CSE-MsgGUID: c/Etimx2RDqYuN62iG9lUQ==
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="45813890"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2025 07:35:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 29 Aug 2025 07:35:09 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 29 Aug 2025 07:35:06 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v4 0/2] add support for MCP998X
Date: Fri, 29 Aug 2025 17:34:45 +0300
Message-ID: <20250829143447.18893-1-victor.duicu@microchip.com>
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

 .../iio/temperature/microchip,mcp9982.yaml    | 203 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/mcp9982.c             | 889 ++++++++++++++++++
 5 files changed, 1110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
 create mode 100644 drivers/iio/temperature/mcp9982.c


base-commit: 788c57f4766bd5802af9918ea350053a91488c60
-- 
2.48.1


