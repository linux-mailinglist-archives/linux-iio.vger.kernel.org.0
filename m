Return-Path: <linux-iio+bounces-20596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F9AD8CB2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 15:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A9189F5AC
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE3986328;
	Fri, 13 Jun 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S2gvxlbh"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D093F4FA;
	Fri, 13 Jun 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819767; cv=none; b=NhZGvM6wafCkcvIEkcwzlj1bbTz05+JO+EApLvZQ+beUPThVFUHE5azfes1wfN5dqGQ6jNNvyLMCg0D7j5LWCtiz49QMLnIAz55IwpR84snZJmDx3BdzwwQwV1HIbOqWduy09nxxRcki45SuF9+97eood2Yba59OWMY6ZTgR0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819767; c=relaxed/simple;
	bh=Pv3r8fNxSf7s0LT8i/zRgJXPLo+r28eiR/jm2cETKaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HeuwWyBaXIfV6Hf4JNDhp7ogm2Y2ABBAuCH5wv4xkAx8CeqP/WYmVsrD3CFgqm3mZvg9jYupEkcfhczOGGax7BgkEyzcJomJUsOuAgzDXPQ0HFv2e1EX+1rj8YTNJDYdnqbtLv1OEXQnK00aa0zLzSXKnX/93ijhhj1hSzA2ZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S2gvxlbh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1749819766; x=1781355766;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pv3r8fNxSf7s0LT8i/zRgJXPLo+r28eiR/jm2cETKaY=;
  b=S2gvxlbhPyTFQJiaY8tWgq6R5wzPANk/vAwQKc2qwqSszR7uOZTI/eqN
   51UOtQWMlIlcNOtjIX2Pl4cGQ2eY2pTVueMvApDVD56IqQ7GhxzMsvAI/
   O/miA8WuPzXY3aZ54W4L+3k7OzBtUZktTTyF0pDsgkB2aiACApqsFyMlJ
   Qth5wRFNr7O53T7lt9cPWrKf7bUSngOXcHLGbxknE4Df40Gdl+vfrOAAY
   a5xMxzArHm/x5Q0KyJr+wxvxq+nz0o3SelkgllH5f3kGVxOQFvTYafzMD
   q8o+Lod1SvpPYC9wtYqAV3dfDlYtltOLPlYnc9TJMd1x+6wyxm9pVXEZI
   A==;
X-CSE-ConnectionGUID: Q/C0oHGPR/isfC6vMelafQ==
X-CSE-MsgGUID: 8Z1q9i9vTl2vjc/fSEsedg==
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="274154974"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2025 06:02:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Jun 2025 06:02:24 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 13 Jun 2025 06:02:21 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] add support for MCP998X
Date: Fri, 13 Jun 2025 16:02:05 +0300
Message-ID: <20250613130207.8560-1-victor.duicu@microchip.com>
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

Add support for Microchip MCP998X/33 and MCP998XD/33D
Multichannel Automotive Temperature Monitor Family.

The chips in the family have different numbers of external
channels, ranging from 1 (MCP9982) to 4 channels (MCP9985).
Reading diodes in anti-parallel connection is supported
by MCP9984/85/33 and MCP9984D/85D/33D.
Dedicated hardware shutdown circuitry is present only
in MCP998XD and MCP9933D.

Current version of driver does not support interrupts, events and data
buffering.

Differences related to previous patch:
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

 .../iio/temperature/microchip,mcp9982.yaml    | 211 +++++
 MAINTAINERS                                   |   7 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/mcp9982.c             | 778 ++++++++++++++++++
 5 files changed, 1007 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
 create mode 100644 drivers/iio/temperature/mcp9982.c


base-commit: 0c86e33819785fe50616b6ee3fb35c1e4be406d5
-- 
2.48.1


