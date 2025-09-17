Return-Path: <linux-iio+bounces-24206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75ACB7D5A7
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFE01C22384
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B80337EAC;
	Wed, 17 Sep 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MeacBEcx"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C10337E90;
	Wed, 17 Sep 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111792; cv=none; b=DXwhTIX8gKfDBGjNg/RgryE3Uu+VELjvBPjUl82+SEz72cWMTkFi5f+4C3q78kvZ2z8BU0b8bEmGOCctKFEHQ8xbolx4eZJIJec5s4oZOsTTgy9Kd9Sm6jjYv0j5yBSUlYsaK0vfBRSIlJp2Ixvhmzotux52/oEUhYGej7QOvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111792; c=relaxed/simple;
	bh=Xca4q9i0SsPseNqNo7WFFdBKOdMMSDfvQy2AtXjlCoQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CoUkZxgai6wiYtegNnWCS67nk/i371ldCz5ZoBEj/LmOf9MVLfPtaZLtyAt4CmOIeGcsiTVTiWqyiPSUKgjxSgN5mz8S1VZTGFRq24ZCyQGiLtM+Ic9GBTMC1EEvnu5cYz74YCbVQx8GJ5Bnp3yPQ/TRAGiAjQTX11icITeCf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MeacBEcx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758111790; x=1789647790;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Xca4q9i0SsPseNqNo7WFFdBKOdMMSDfvQy2AtXjlCoQ=;
  b=MeacBEcxC+Xv7wxRDIEZ5qopXDRaw6/uesdgp1Msr2E6+ESG3DMntwzF
   W7sHHpNgvPGIW+YNX3sbHFK6ctVilBbHJYQ+XWx/WP3+LREf0x6tZVqw1
   Kcnu4Fe/DbaAD6rwFlHYtciOhAaSN3xVi44AAZXTh2KD20K7ctAdCKN1k
   v7jMS8ZPGmkyJrhXC70GavF+lSYF9b1hUjjiSiFVK4Qwdz5YRegwdslzX
   thLSlNGnQ/O0zu/Q5i79xrEqdrU6T5wUXxrlCYbzc2uIvpOYiA/FKSKkz
   bT291b8A5tNbuUQHlA5mc2xRSh+09PeVMqo4S+xR1oIhI+HG+sDsGD/jZ
   w==;
X-CSE-ConnectionGUID: 1EjJeCxgSey58B9ApuzhPA==
X-CSE-MsgGUID: oN1ZNfiNTWKfKn6Gr6lg3g==
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="46040402"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 05:23:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 17 Sep 2025 05:22:39 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 17 Sep 2025 05:22:36 -0700
From: Marius Cristea <marius.cristea@microchip.com>
Subject: [PATCH 0/2] Add support for Microchip EMC1812
Date: Wed, 17 Sep 2025 15:21:56 +0300
Message-ID: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOSnymgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwNT3czMfN3U3GRDC0Mj3VQzMzNDC+MkA/MkUyWgjoKi1LTMCrBp0bG
 1tQBwo+uIXQAAAA==
X-Change-ID: 20250805-iio-emc1812-e666183b07b5
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Marius Cristea <marius.cristea@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232;
 i=marius.cristea@microchip.com; h=from:subject:message-id;
 bh=Xca4q9i0SsPseNqNo7WFFdBKOdMMSDfvQy2AtXjlCoQ=;
 b=owGbwMvMwCW2tbSTZa7u0x2Mp9WSGDJOrWAp2/HPMinmu9hZUf7iI2q8ue18mT9O/dvXacXDx
 /o07cz5jlIWBjEuBlkxRZYVb/3UqtZ+uKwklqkDM4eVCWQIAxenAEwkwIDhn6mQVnSTga/9FZPK
 +CS9d+8W5vgduvDt8rSZ+aK7jKP2nmf4p6iV0qq6afudxZaTTs1s//qrhPG87KXX180PB5vFZp/
 axAEA
X-Developer-Key: i=marius.cristea@microchip.com; a=openpgp;
 fpr=E32F8D4396E72E463E8CCD91446DE0ABD9140C3E

This is the iio driver for EMC1812/13/14/15/33 multichannel Low-Voltage
Remote Diode Sensor Family. The chips in the family have one internal
and different numbers of external channels, ranging from 1 (EMC1812) to
4 channels (EMC1815).
Reading diodes in anti-parallel connection is supported by EMC1814, EMC1815
and EMC1833.

Current version of driver does not support interrupts, events and data
buffering.

Differences related to previous patch:

v1:
- initial version.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
Marius Cristea (2):
      dt-bindings: iio: temperature: add support for EMC1812
      iio: temperature: add support for EMC1812

 .../iio/temperature/microchip,emc1812.yaml         | 223 ++++++
 MAINTAINERS                                        |   7 +
 drivers/iio/temperature/Kconfig                    |  10 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/emc1812.c                  | 792 +++++++++++++++++++++
 5 files changed, 1033 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250805-iio-emc1812-e666183b07b5

Best regards,
-- 
Marius Cristea <marius.cristea@microchip.com>


