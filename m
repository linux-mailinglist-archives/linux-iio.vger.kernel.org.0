Return-Path: <linux-iio+bounces-24348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 939EBB9065B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 13:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD12A16E1E6
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 11:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD99F30AAA9;
	Mon, 22 Sep 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ibl6Sbpi"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61130506F;
	Mon, 22 Sep 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540691; cv=none; b=F+2zHaE49bBzzUJRPPxLjeycbnIJQ//9IvkPZdz228G7l2k2X7VOfnCbGoAJQpdiw3FwemzuaZJr516bolj+7nOfSBHM203C1pjSdjtmxrqyufhstGbvUy8X5FA8XmalO+2We9d7Xu+PFexzUNq3jKGQ8uFUf1JkXpHI8BF2r6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540691; c=relaxed/simple;
	bh=HrSs+EwKvaIOsKnacb9gRdXLOC2RSNtMLI5caZpumFg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=GuShj9bRBcfQCUI9BPrpGC9lEQPCEITgH8eko6sH+AXEuUeSCfmx4Ib/FFjKW4lBODflNySXg5zhRKQNd8aOnHLIcyfK2SbDOZiy8/1DPsVADBrcjHvQmg3zbmszEYoXzhz0xgEF6vYPWclv/kLWcRBb+eZ9jx/p51p5We19v4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ibl6Sbpi; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758540689; x=1790076689;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=HrSs+EwKvaIOsKnacb9gRdXLOC2RSNtMLI5caZpumFg=;
  b=Ibl6SbpiG0qzv3/rVRGy1WLpcyQ/gVtBGyh8e+zdXMrlTfVWgIVNnp0b
   RVJUTsu3J2hL17ri8i7jN+7+jxLQYYZnEf/q6FNrPnIRpN3Dghzrgftr0
   X12e+6kJhppEuShMUNtdx+MXIM3LXggMgS4pRSsUY5GjP0tuDdxSpJlW0
   LSfQ1z0W0a9ocBIDPASdosqLVbkDQdSU0/OFCIr2w58ibWGwRrmwSWYIX
   F9N/EqaYYEBwWt/V1vfO9b5zMGOOtrSoF2xsPM560L7Q2ejUmwjKYXATS
   eH2OBkfkQ61WCnEyVvE7PSCqU6o/tIonhuN9ISPv0VBphpqxcEebX22Pb
   g==;
X-CSE-ConnectionGUID: ItnTgdDQT3CQ6aHeJ/KMMA==
X-CSE-MsgGUID: iCVfDHXvTI+z3drHLz7Pcw==
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="46230241"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2025 04:31:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 22 Sep 2025 04:31:03 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 22 Sep 2025 04:31:01 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH 0/2] Adding support for Microchip MCP47FEB02
Date: Mon, 22 Sep 2025 14:30:52 +0300
Message-ID: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGwz0WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNT3dzkAhPztNQkAyNdY8Nkc3MLU/PEVCNLJaCGgqLUtMwKsGHRsbW
 1AMjHngZcAAAA
X-Change-ID: 20250825-mcp47feb02-31c77857ae29
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758540660; l=1489;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=HrSs+EwKvaIOsKnacb9gRdXLOC2RSNtMLI5caZpumFg=;
 b=8IsiKnHd6DQdHXMfiGzJ5JGQq6/qIVmK3mV0eDf7x36iizoh5nb1xE1gaRx9SBEujSFaRHj7W
 jiQ3k+j7e+6AJuvA+vwAxK/iRXtYGORqWQw+o1N/3ijbL7XJrlfGqq0
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Adding support for Microchip MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2,
MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series of buffered voltage
output Digital-to-Analog converters with an I2C Interface. This driver
covers the following part numbers:
 - With nonvolatile memory:
   - MCP47FEB01, MCP47FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12
   - MCP47FEB22, MCP47FVB01, MCP47FVB11, MCP47FVB21, MCP47FVB02
 - With volatile memory:	 
   - MCP47FVB12, MCP47FVB02, MCP47FVB12, MCP47FVB22, MCP47FVB04
   - MCP47FVB14, MCP47FVB24, MCP47FVB04, MCP47FVB08, MCP47FVB18
   - MCP47FVB28, MCP47FEB04, MCP47FEB14 and MCP47FEB24

The families support up to 8 output channels. The devices can be 8-bit,
10-bit and 12-bit resolution.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Ariana Lazar (2):
      dt-bindings: iio: dac: adding support for Microchip MCP47FEB02
      iio: dac: adding support for Microchip MCP47FEB02

 .../bindings/iio/dac/microchip,mcp47feb02.yaml     |  305 +++++
 MAINTAINERS                                        |    7 +
 drivers/iio/dac/Kconfig                            |   16 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/mcp47feb02.c                       | 1347 ++++++++++++++++++++
 5 files changed, 1676 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250825-mcp47feb02-31c77857ae29

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>


