Return-Path: <linux-iio+bounces-16938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F79CA646A0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4497A3C0B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60008221D99;
	Mon, 17 Mar 2025 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dX4kwwI8"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055D21B1A3;
	Mon, 17 Mar 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202528; cv=none; b=k1csX21BSkKp7r73ujvN4d5ceqBkSL7ItjxgDq7arDVKvy7/xMBhKkH/UZUnF/saldUm0vz8qRoEQEbyXkF7NYjN3sYraQaWXZOGzrlHkwKjMfVnd6uNpcAPMNnGPPnbZ9eyz//JKjw9fgOHroUJJ7/rH9xKZF720xnNJXciOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202528; c=relaxed/simple;
	bh=JTPXIlCvhGNW08kSL9ZQe12t3Ga0p3gZHTOp47t1/Sk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tZPhnSZILMnJFtth1okOvXaHueLtLkYuOjvQxv8l0TOXuivey8WsTIu3d50b/789w117D+mJTp7eNQ4aBmc4tomV7jK0L/LuvrPnBFgQCYzx45mKGgYKvJWO4B/8GC+cnxY27dVa8+tZ5WQr5YHOoxmMLQrBK5BqJVx2L5n5HVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dX4kwwI8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1742202526; x=1773738526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JTPXIlCvhGNW08kSL9ZQe12t3Ga0p3gZHTOp47t1/Sk=;
  b=dX4kwwI8dw8Zhn8yhRngLwo+orRPkHGr/qJllBpAFyEXPfx8IWCdpXKO
   2hjQ+Y5Gixk8b7lNmmCWgVYq9XZrphfCDxKRAQJZIRzkSmiBZZ31CawiU
   ZyS25IHTk/oGwRpxl+eKHcCFznj9+RdnzXLGQv4it/Jla9m4eZ/GEikEY
   fKhvBwXJX+V2EcVKBeysnLE41IwiJRwZHt2rL8k6e7qXPP8VSRYJ7L6Av
   Gl7Z+oSpIlE5gCLWPsKRw68zxH+cu94APsNoNbZc/WscR82ASluw/kbRi
   hEUyIlX1uuiu+mBHKq4S1g8oOv0WFYdiHnMdwM2hBOl4EiuWDcTgrCECp
   Q==;
X-CSE-ConnectionGUID: cdV/yO62T2+o2ggmCIuq7A==
X-CSE-MsgGUID: TKPR0AqgSTCkH9O884aMCw==
X-IronPort-AV: E=Sophos;i="6.14,253,1736838000"; 
   d="scan'208";a="43507978"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2025 02:08:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 02:08:10 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 17 Mar 2025 02:08:08 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>
CC: <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <oskar.andero@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v2 0/2] adding support for Microchip PAC194X Power Monitor
Date: Mon, 17 Mar 2025 11:08:01 +0200
Message-ID: <20250317090803.30003-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

Adding support for Microchip PAC194X and PAC195X series of Power Monitor with
Accumulator chip family. This driver covers the following part numbers:
 - PAC1941, PAC1941_2, PAC1942, PAC1942_2, PAC1943, PAC1944
 - PAC1951, PAC1951_2, PAC1952, PAC1952_2, PAC1953, PAC1954

The PAC194X family supports 9V Full-Scale Range and the PAC195X supports 32V
Full-Scale Range.
There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices are for
high-side current sensing and the PAC194X/5X-2 devices are for low-side current
sensing or floating VBUS applications.
The PAC194X/5X-1 is named shortly PAC194X/5X.

Differences related to previous patch:
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

 .../ABI/testing/sysfs-bus-iio-adc-pac1944     |  118 +
 .../bindings/iio/adc/microchip,pac1944.yaml   |  195 +
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1944.c                     | 3314 +++++++++++++++++
 6 files changed, 3647 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
 create mode 100644 drivers/iio/adc/pac1944.c


base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
-- 
2.45.2


