Return-Path: <linux-iio+bounces-22264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 599D7B19F3B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4DC189C8C3
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CAD246780;
	Mon,  4 Aug 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EQD87ILy"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3E246335;
	Mon,  4 Aug 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301787; cv=none; b=TO+kyXOIe0YIw3egj2FPB/d9FCz/eQgiBpzU0MOli4RHH9kCCvwCWYQuo5xH+7nPjW/U9wtPHCvcM1RXXXG7BtM3tWABMq+3chALcqM/wlrfUEW4aTP1hC5yPUp4SlEwFYjG8/riTNMOeTITdAUNjxf4L+jShVUb495cTvbbG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301787; c=relaxed/simple;
	bh=QiaSZaDg5pwD3xGJiJSSgLa32uZMitwv/bGano/kVtc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+GLeWDN5fL4q/4Nj3cW4XpQDegWDEJm+l4tRtskLKGcTCgRl9qtDs4Q5AcwHGksZbgIFLA+d5N0Lwzn7N7ZtGmm6Ohp1qpZvGdqy2HXFajZXUOok/B1LTThO+Tx+rsNi21SwWK056zHgkOcD6W1gfOeYmhCCHE0XgyCXzO5IEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EQD87ILy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754301786; x=1785837786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QiaSZaDg5pwD3xGJiJSSgLa32uZMitwv/bGano/kVtc=;
  b=EQD87ILyB0vglauKB1R6goVYTX/JhDDROyrJ6/uL9e2bp3EFhtr+6qKS
   7ald7OdMP0lFMCj4k+Ek6KxGNKMgm7U0kRikp/CaQfcoWZvbeg7R/QgB3
   o1hqFWKdfiRljP+Cpbd/gvqV9hF75UZLx6ke0Nja3NtdRSsAE/LtHS90/
   HtZa95YubGXVHTJZGsBxGWzSB9m762zCIn0lKHO8x38TzS1Lm/e/h6hs4
   WoMhl1qZ6cWHyPPz1J3diENaaKSXqGVngARVBXw9ium/hSx3sggUBHcjt
   OI9ym85Dki63zySG2fcrsXtYTdvBsKeUqnBeq1vb/UZQONHW2Qnmg5tWB
   A==;
X-CSE-ConnectionGUID: GJeNwV3dT46CHM5uTLCa7g==
X-CSE-MsgGUID: B4x9i4pqTW2Ob+bdOk4Cew==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="276166361"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 03:02:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 03:02:28 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 4 Aug 2025 03:02:22 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH 00/15] Add thermal management support for sama7d65
Date: Mon, 4 Aug 2025 15:32:04 +0530
Message-ID: <20250804100219.63325-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The thermal management system of sama7d65 includes

- Temperature sensor as a part of ADC channel
- Temperature calibration data retreived from the OTP memory for
  improved accuracy of the readings
- DVFS implementation
- And finally a thermal system with DVFS as cooling cell.

This patch series adds support for the following

- New and improved version of the OTP driver
- Adaptation of the above in existing DT, DT doc and ADC driver
- DVFS, OTP, ADC, Thermal system support in DT of new sama7d65

Varshini Rajendran (15):
  ARM: dts: microchip: sama7d65: add cpu opps
  nvmem: microchip-otpc: rework to access packets based on tag
  dt-bindings: microchip-otpc: update dt node example
  iio: adc: at91-sama5d2_adc: update calibration index, validation
    condition
  ARM: dts: microchip: sama7g5: add packet tag as offset for calib
  dt-bindings: nvmem: microchip-otpc: remove stride details
  iio: adc: at91-sama5d2_adc: add temp init function as callback
  dt-bindings: iio: adc: at91-sama5d2: document sama7d65
  iio: adc: at91-sama5d2_adc: adapt the driver for sama7d65
  ARM: dts: microchip: sama7d65: add node for the ADC
  dt-bindings: microchip-otpc: document sama7d65
  ARM: dts: microchip: sama7d65: add otpc node
  ARM: dts: microchip: sama7d65: add cells for temperature calibration
  ARM: dts: microchip: sama7d65: add temperature sensor
  ARM: dts: microchip: sama7d65: add thermal zones node

 .../bindings/iio/adc/atmel,sama5d2-adc.yaml   |   1 +
 .../nvmem/microchip,sama7g5-otpc.yaml         |  17 ++-
 .../dts/microchip/at91-sama7d65_curiosity.dts |  23 ++++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 128 +++++++++++++++++
 arch/arm/boot/dts/microchip/sama7g5.dtsi      |   4 +-
 drivers/iio/adc/at91-sama5d2_adc.c            | 123 ++++++++++++++++-
 drivers/nvmem/microchip-otpc.c                | 130 ++++++++++++++----
 .../nvmem/microchip,sama7g5-otpc.h            |   6 -
 8 files changed, 383 insertions(+), 49 deletions(-)

-- 
2.34.1


