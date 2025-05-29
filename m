Return-Path: <linux-iio+bounces-20004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34FAAC7B27
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 11:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A131716F0
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615D21D3D2;
	Thu, 29 May 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0YED0DOk"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA520299B;
	Thu, 29 May 2025 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511443; cv=none; b=oZdtYkvCyPDqSfdB/Qvoq/YfOcv7BSzaMPsBK3JDFSsEND6LcKAd88Wt5vplL+BtqvbtUFY8JlveLJQs7ZlSRKfJjjc5y1YI6eMh3jpzWMbwWf6qPpvgqXGgLx0/c04esgsYQwDwoSZyaKNJrBK78HgtGbzRA3SqS6vxQ72pxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511443; c=relaxed/simple;
	bh=Bo/+FJN+Orqssn2G0yGh11O0yyjchGgS4Voi5HWUos8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kavQsynnrv/1koxVg6JEynj4HwJvGt5VUStGmOZgpOVvC2Fncy3AaURjwoW8URUR2eWxFr8hwLnF1buVXx5cQ13CetjJkaGcDdOHjety3amZQk9VY3hadz1NsryHuBH7FpgqHPuFYzTtWXaWCMT9+KVxNva9Q69qMMEjDjdFZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0YED0DOk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748511442; x=1780047442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bo/+FJN+Orqssn2G0yGh11O0yyjchGgS4Voi5HWUos8=;
  b=0YED0DOkWTC07pq4jQNEZpLLgHj1E6RuncHgwBID8p6AZlG+RuNw2cGR
   Sie/QGGMYCwMVK/1yWwdhxMPzgAaaNq+ahc1M/eDo378ZNZ0c4dCUP2FD
   aAYxXhimt7TifWb+s++y4oyAfPdT/eTZX7gjMHV3LMJB3yjgRO/ugjnBj
   miJSD57LoqE/TBdlS73GioZawF3es4RumS2cahD6XNN2ARFag+BvJAArp
   Ly81JEE4gfjxC2uAW8tDLLBrlcmTiKDCoKuiRodr4a+56AKT59fvPJywI
   nIKa8HseY++B2xzSh0pqi9uZ9XJs4c2iwMbQBNu6slZYUoNqEwLTWAnDj
   A==;
X-CSE-ConnectionGUID: xzbXPh2ETCSQJkZQFVVmZQ==
X-CSE-MsgGUID: H+o7fJtLQn62qXH95yTuYQ==
X-IronPort-AV: E=Sophos;i="6.15,192,1739862000"; 
   d="scan'208";a="42753029"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2025 02:37:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 29 May 2025 02:36:43 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 29 May 2025 02:36:40 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] add support for MCP998X
Date: Thu, 29 May 2025 12:36:26 +0300
Message-ID: <20250529093628.15042-1-victor.duicu@microchip.com>
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

 .../testing/sysfs-bus-iio-temperature-mcp9982 |  27 +
 .../iio/temperature/microchip,mcp9982.yaml    | 174 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/mcp9982.c             | 866 ++++++++++++++++++
 6 files changed, 1085 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
 create mode 100644 drivers/iio/temperature/mcp9982.c


base-commit: 0c86e33819785fe50616b6ee3fb35c1e4be406d5
-- 
2.48.1


