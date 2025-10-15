Return-Path: <linux-iio+bounces-25105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA55BDF9EC
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E35189F9A2
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5571E3375D7;
	Wed, 15 Oct 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LJnpXDO5"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD2A2D6E72;
	Wed, 15 Oct 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545217; cv=none; b=EDYupBivLgpPo2HE39RhbbHx41Lsfff2Mwrs6OaxnAzA29iWIhhoozcyOqzCHF0F2QhSdZSylLtPJZSQnMBzL6AGqd6NPxfmmLhLyNp/FZce6k6NSQAsf/lfW2ZjD9tdf1remutJTuRRMxY59/ovrvk6KCWuOSHHAaIwtGfOWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545217; c=relaxed/simple;
	bh=QthkGZqNM0IxCOUSCpz51FL5jDeaV6sKU3ulv/hypuU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=AO3/sqQMQZvfRC6iqyzkGS6bTqAUEx7tbRROcw4rbrsBsBrPdkPXvCUDKmQoThPLPiFA3yoOzj/DERjce3L+2hk3atLaWJWJMQwV97UME+ECUwCYN3qKPpzgYXKjZf9wxzgrGPsV6LmKjw3w/YUQ57zgZiktcEUHs0ThDldz/+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LJnpXDO5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1760545215; x=1792081215;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=QthkGZqNM0IxCOUSCpz51FL5jDeaV6sKU3ulv/hypuU=;
  b=LJnpXDO5CTIXvAlbcau9SUFVhsTs1OdXsNKghCV13a7r24bjFGwWkRNh
   S96hzkIQwKeVfxrq3I78IK1DNMDBE47Bw5sBGPSEYqC5XkqsqARcPwQgF
   3CukGkljvju6GaUOj8cgCmvLCYReU7JNEU+7lEL2td/7eES4iOLr1zr53
   dI8kFmj/VGfp4rFlnr3VCu9sfe9s2TnOmOugAm+6WaRtwO5GtBZ3M5tq6
   262uTMIqZ/Qup1HCr/b+wA2BrX98+xn/hOEHitqDkAJp7hS/OTOy471hV
   +X8azMWofrNyGRqdcB5IQTEs3YX5j9VsgwA8TZ5PEFvt6vj+zAWNtIXxX
   Q==;
X-CSE-ConnectionGUID: M1xrWlSdRa+eGCjzifwSqQ==
X-CSE-MsgGUID: D642xI84QjCu+HxUVFHzdQ==
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="47204430"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 09:20:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 15 Oct 2025 09:19:46 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 15 Oct 2025 09:19:43 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH 0/2] Adding support for Microchip PAC1711
Date: Wed, 15 Oct 2025 13:12:14 +0300
Message-ID: <20251015-pac1711-v1-0-976949e36367@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH5z72gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwND3YLEZENzQ0PdFOOkxOSURBMDg7QUJaDqgqLUtMwKsEnRsbW1AHd
 BgkBZAAAA
X-Change-ID: 20250901-pac1711-d3bacda400fd
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760523137; l=1117;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=QthkGZqNM0IxCOUSCpz51FL5jDeaV6sKU3ulv/hypuU=;
 b=hR9rVHt27Hvx7WXesPNzRPjiQy1zNoCbwy6MPKTOMK3mqT2eXcaJpJpBq+iZpid2EwRsw5mWh
 lOJxVJGDylaAIS08ZDPBu9yIRIKa70/izdU57Bf2eo7Y8RfqxVL0Y5y
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

The PAC1711 product is a single-channel power monitor with accumulator.
The device uses 12-bit resolution for voltage and current measurements and
24 bits power calculations. The accumulator register (56-bit) could
accumulate power (energy), current (Coulomb counter) or voltage.

PAC1711 measures up to 42V Full-Scale Range.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Ariana Lazar (2):
      dt-bindings: iio: adc: adding support for PAC1711
      iio: adc: adding support for PAC1711

 .../ABI/testing/sysfs-bus-iio-adc-pac1711          |   57 +
 .../bindings/iio/adc/microchip,pac1711.yaml        |  195 +++
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/pac1711.c                          | 1448 ++++++++++++++++++++
 6 files changed, 1719 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250901-pac1711-d3bacda400fd

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>


