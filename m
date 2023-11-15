Return-Path: <linux-iio+bounces-77-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A467EC402
	for <lists+linux-iio@lfdr.de>; Wed, 15 Nov 2023 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E42C2813C9
	for <lists+linux-iio@lfdr.de>; Wed, 15 Nov 2023 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD41EB41;
	Wed, 15 Nov 2023 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QBT/K71t"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA85D1EB31;
	Wed, 15 Nov 2023 13:46:00 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE331FA;
	Wed, 15 Nov 2023 05:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700055958; x=1731591958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eiHhnwxmDdZ6uny+ZcBXgoWY+2o1D01iokPBwa8lAqY=;
  b=QBT/K71t52GzIeVl+byh/5EVkQl3AymLPmObR231p3lUoIDRfWcTbdZP
   OsQGxVzVFHMTOQM+XKzKz5Yj9mUHHhuudBGKOiqcfReevLWFMH1AahOsZ
   v4KF7xi85pDShePB4xySO7uoWtsSxQM3A3utWM/lc/FQbnS7Oup/58FV8
   aF/uXZJviaYhGMV9z82HMckvR3gNKONRg1qxpIQeR3dhjX5WPXuQRh+mL
   GHNrBhUHlPvMdLeCPTjOCrC7nk15q+LUM5FQzXqdExTt+VCcrRKpfR2qz
   eP5jjL50uJrkEpB3NRXGthXumqrjj2drSXkMz1eVJ5ULn0TDm552XrJHQ
   Q==;
X-CSE-ConnectionGUID: LgQt6nmvRtWORLzOkR+vzg==
X-CSE-MsgGUID: xozfofjNR0uC+f6mWO+Xjw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12423813"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2023 06:45:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Nov 2023 06:44:59 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 15 Nov 2023 06:44:55 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v3 0/2] adding support for Microchip PAC193X Power Monitor
Date: Wed, 15 Nov 2023 15:44:51 +0200
Message-ID: <20231115134453.6656-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

Adding support for Microchip PAC193X series of Power Monitor with
Accumulator chip family. This driver covers the following part numbers:
 - PAC1931, PAC1932, PAC1933 and PAC1934

  This device is at the boundary between IIO and HWMON (if you are
looking just at the "shunt resistors, vsense, power, energy"). The
device also has ADC internally that can measure voltages (up to 4
channels) and also currents (up to 4 channels). The current is measured as
voltage across the shunt_resistor.

  I have started with a simple driver (this one that is more appropriate to be a
HWMON) and willing to add more functionality later (like data buffering that is quite
important for example if someone wants to profile power consumption of the
processor itself, or a peripheral device, or a battery, this kind of functionality
was requested by our customers).


Differences related to previous patch:

v3:
- this version was sent also to HWMON list
- fix review comments:
  - drop redundant description from device tree bindings
  - reorder "patternProperties:" to follow "properties:" in device tree bindings
  - update comments to proper describe code
  - use numbers instead of defines for clarity in some part of the code
  - use the new "guard(mutex)"
  - use "clamp()" instead of duplicating code
  - remove extra layer of checking in some switch cases
  - use "i2c_get_match_data()"
  - replace while with for loops for the code to look cleaner
  - reverse the logic to reduce indent.
  - add comment related to channels numbering
  - remove memory duplicate when creating dynamic channels
  - add "devm_add_action_or_reset" to handle the "cancel_delayed_work_sync"
  - remove "pac1934_remove()" function

v2:
- fix review comments:
  - change the device tree bindings
  - use label property
  - fix coding style issues
  - remove unused headers
  - use get_unaligned_bexx instead of own functions
  - change to use a system work queue
  - use probe_new instead of old probe

v1:
- first version committed to review

Marius Cristea (2):
  dt-bindings: iio: adc: adding support for PAC193X
  iio: adc: adding support for PAC193x

 .../ABI/testing/sysfs-bus-iio-adc-pac1934     |   15 +
 .../bindings/iio/adc/microchip,pac1934.yaml   |  137 ++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1934.c                     | 1673 +++++++++++++++++
 6 files changed, 1845 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
 create mode 100644 drivers/iio/adc/pac1934.c


base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec
-- 
2.34.1


