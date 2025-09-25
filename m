Return-Path: <linux-iio+bounces-24446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB00BA1DAB
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 00:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303A07B35DE
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 22:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161D321296;
	Thu, 25 Sep 2025 22:40:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92502882C9;
	Thu, 25 Sep 2025 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840058; cv=none; b=JzzmVGLNnRUhhkePVz5uO5xRA0HzyhrEL9rhzUmUdnC2yj6zaX1CRXTRnCvjjQvhRv6gFR7X4Wl3e2rREgvK1dWlOJv1vHa1R4N4JXf3mY3TlJ4Iz4UKtUlfiDoVW/M+8uW4LJ04GqMmHFjjdhn1YKjjjRznzfSbT0qddG+23Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840058; c=relaxed/simple;
	bh=R0ZC9HDSPtzDblgCKz4awGmG6PvRPYu/gPFIahGawM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJGFIr+OWlFvAt12diw54JC8AvpkEj654ANks7TggkGzTT4UA9N39tdXcm8Du2MN+qbimtEpTQztAyJ2xiSSGSonAAvSliT3PnE3LAZCLuASQ30O6ADrIvqrSPEywkDw8LMRUBijc4eVOVJZIBgaz51vBkMa1wHtR+mqhtZZFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: eUfWO2cDTZKZgWZwCslw0g==
X-CSE-MsgGUID: AmBBRPKRSDCldcM8ZJsiwQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Sep 2025 07:40:49 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.2])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 991F0400CF0A;
	Fri, 26 Sep 2025 07:40:44 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Add ADCs support for RZ/T2H and RZ/N2H
Date: Fri, 26 Sep 2025 01:40:02 +0300
Message-ID: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
12-Bit successive approximation A/D converters.

RZ/T2H has two ADCs with 4 channels and one with 6.
RZ/N2H has two ADCs with 4 channels and one with 15.

Add support for them.

V2:
 * pick up Reviewed-by from Geert
 * dt-bindings: move required after patternProperties
 * dt-bindings: describe 16 channels, but limit per-SoC to 6 / 15
 * dt-bindings: use uppercase for clock descriptions
 * remove max-channels property and find it from parsed channel subnodes
 * remove start/stop wrappers
 * stop calibration even on failure
 * move data reading to rzt2h_adc_read_single() instead of interrupt
 * handler

Cosmin Tanislav (7):
  clk: renesas: r9a09g077: Add ADC modules clock
  dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
  iio: adc: add RZ/T2H / RZ/N2H ADC driver
  arm64: dts: renesas: r9a09g077: Add ADCs support
  arm64: dts: renesas: r9a09g087: Add ADCs support
  arm64: dts: renesas: rzt2h/rzn2h-evk: enable ADCs
  arm64: defconfig: enable RZ/T2H / RZ/N2H ADC driver

 .../iio/adc/renesas,r9a09g077-adc.yaml        | 160 +++++++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  69 ++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  28 ++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  69 ++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  64 ++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  79 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a09g077-cpg.c           |   3 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rzt2h_adc.c                   | 306 ++++++++++++++++++
 12 files changed, 798 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
 create mode 100644 drivers/iio/adc/rzt2h_adc.c

-- 
2.51.0


