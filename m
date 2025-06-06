Return-Path: <linux-iio+bounces-20258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0B5ACFF79
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 11:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1C01797D5
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96B5286880;
	Fri,  6 Jun 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nsQtImAe"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28722857EE;
	Fri,  6 Jun 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202812; cv=none; b=CbJL18asvX4AhlkCVlWp7hXBQClPAQ53+nILZlU/fjhoUYF34LQ8oDKvqiOPXoXa9fUz6emDstD97QNKgM297TVWEBfAOvLDKxhven4qcGt1S92NGFuYwrWi+75b06Jc3mrTYIylK3jPx0P3dzwflcvJ4hGYpFGY9bAXinOxpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202812; c=relaxed/simple;
	bh=hx2tqVby4hICbY7arRGml2MUf2WN62USFOlRL4dU2TE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pRCDbY51dpVS5+SdQlR84wJbCQAZj3LIPlvWNGvHgfNa/1J1qTwm4PtsK5Q5zP0lCjMlzKpv+j0r1ipMkHY4m5y+1zGgi6FbY2cbXxzIOQra6U/eXri0Yi2dL/KNNvLrsjNDf9UvZ25x2XsTeZu081r66UR2aqFs0pE8SsKwStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nsQtImAe; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1749202811; x=1780738811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hx2tqVby4hICbY7arRGml2MUf2WN62USFOlRL4dU2TE=;
  b=nsQtImAeqTwIpx3lWaHlXwbYAbK8tGj28kOOxj5o/Ieepzc85ZMWCuJi
   vT/zro3a8wiaQNNJw5gs6kuG4wJPLUPX3EP1XAeIQM2a/YYdJ6pACs2n4
   82Srj14hGqRSaUsudkDdY4ZSGCuckn9niZVbrF74+rOE9DBDTE9Vwz5Tu
   wj+RC8ZaaTzQXxYcviKsUiqkd4+5WeCY5P4oKxFnHwGeHTlHLILOhu1bJ
   oDyKpwXATtmLlc1kyn4ltwVep0l0L7YUtchQG1FdJCPAuL4mK11TjYUrX
   OwCpWdYT6FnWuEb+2VluMjSCg6gsTKnA6kNnX/HdHrldV3XpmKThOJDO+
   Q==;
X-CSE-ConnectionGUID: 01hBMkXoQcS7BeTmXZ+HsA==
X-CSE-MsgGUID: IY4AG+0kQ9OfYiy2P1hX0Q==
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="42499415"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2025 02:40:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 6 Jun 2025 02:39:37 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 6 Jun 2025 02:39:35 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<broonie@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<marius.cristea@microchip.com>
Subject: [PATCH v3 0/2] adding support for Microchip PAC194X Power Monitor
Date: Fri, 6 Jun 2025 12:39:27 +0300
Message-ID: <20250606093929.100118-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

Adding support for Microchip PAC194X and PAC195X series of Power Monitor
with Accumulator chip family. This driver covers the following part
numbers:
 - PAC1941, PAC1941_2, PAC1942, PAC1942_2, PAC1943, PAC1944
 - PAC1951, PAC1951_2, PAC1952, PAC1952_2, PAC1953, PAC1954

The PAC194X family supports 9V Full-Scale Range and the PAC195X supports
32V Full-Scale Range.

There are two versions of the PAC194X/5X: the PAC194X-1/5X-1 devices are
for high-side current sensing and the PAC194X/5X-2 devices are for low-side
current sensing or floating VBUS applications. The PAC194X/5X-1 is named
shortly PAC194X/5X.

Differences related to previous patch:
v3:
- fix review comments device tree binding:
  rewrite commit message
  change the way full scale for voltage and current is set. Add a
    properties to describe if the input is bipolar or not.
  fix the "dtschema/dtc warnings/errors"
- fix review comments driver:
  simplify the driver to include just the basic functionality. More
    features will be added later.
  fix coding style issues
  change to lower case the "to_pac1944_chip_info()" to be more like
    other container_of
  remove the PAC1944_DEV_ATTR() macro
  drop the __func__ bit from error messages
  remove unneeded casts
  change the logic to reset the accumulator when is enabled
  change from {} to { }
  remove unreachable() from the code
  rewrite the code to keep the error paths out of line
  replace scoped_guard() with guard(), where was possible
  use to_delayed_work() to get from work to delayed work
  remove active_channels[] array
  print info message in case FW disagrees with what is found on the bus
  
v2:
- fix review comments device tree binding:
    remove underscore from names
    add names to the interrupts and list them
    add a better description for new properties
- fix review comments driver:
    fix coding style issues
    use bitmap for checking the active channels
    keep the "pac1944_get_unaligned_be56" here because the change wasn't acceted
      into the asm-generic.
    document new added attributes
    remove the "scan" part till we support buffered capture
    remove "unlikely" marking
    add masks up in some array of const structures to avoid some case statements
    remove pac1944_mutex_destroy function
    replace some functions with a macro (just for testing)
    replace dev_err with dev_err_probe in functions used in pac1944_probe
    
v1:
- first version committed to review

Marius Cristea (2):
  dt-bindings: iio: adc: adding support for PAC194X
  iio: adc: adding support for PAC194X

 .../ABI/testing/sysfs-bus-iio-adc-pac1944     |   17 +
 .../bindings/iio/adc/microchip,pac1944.yaml   |  204 ++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1944.c                     | 2841 +++++++++++++++++
 6 files changed, 3082 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
 create mode 100644 drivers/iio/adc/pac1944.c


base-commit: 0c86e33819785fe50616b6ee3fb35c1e4be406d5
-- 
2.48.1


