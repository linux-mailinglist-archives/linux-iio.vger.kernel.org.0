Return-Path: <linux-iio+bounces-24372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C00B96B7F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96850165345
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D7D26F291;
	Tue, 23 Sep 2025 16:06:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B083E14EC46;
	Tue, 23 Sep 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643568; cv=none; b=JMWsxWtQmjmfITDhIo5KqM5FTnVRiNMQlF5QtnHJZ76CpeYhV2NxCuncYgkyZkr9pV9Q49KX3vlSCUYuHECxQqMDKEaNyhpH+D0DbWmfbbCeF7rkvoTAh0Hwz9BM5nf0Gja7/XSEjrqyL3MMGY2apFcbgWLfJ/NqIPzth381lGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643568; c=relaxed/simple;
	bh=0GTh+0WJIPd40cypVxXRfCEqOpvywQK+YUOaM9yZ4W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nB1nMNy1fV/L1Yw/9ZcVGayPjMJ8u/ZN94ZISoxLH5F4kwT+PVcxcDxqbEU7bWFuT62m5FE/77/FVYbENwLnBL09IX+cKCX1iSCAuPclJ2rhIxsOa8G7fZw0js7kfHZqLbKcyslghBr4qjooch0n2Re0PoSAX79D80rAFy8Yngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: YGSbaGE+SJCKN1N7nn0uLw==
X-CSE-MsgGUID: EzCQqDIPQu+ubIvfaqd+YA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Sep 2025 01:05:58 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.64])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A932D400C752;
	Wed, 24 Sep 2025 01:05:52 +0900 (JST)
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 0/7] Add ADCs support for RZ/T2H and RZ/N2H
Date: Tue, 23 Sep 2025 19:05:14 +0300
Message-ID: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

Cosmin Tanislav (7):
  clk: renesas: r9a09g077: Add ADC modules clock
  dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
  iio: adc: add RZ/T2H / RZ/N2H ADC driver
  arm64: dts: renesas: r9a09g077: Add ADCs support
  arm64: dts: renesas: r9a09g087: Add ADCs support
  arm64: dts: renesas: rzt2h/rzn2h-evk: enable ADCs
  arm64: defconfig: enable RZ/T2H / RZ/N2H ADC driver

 .../iio/adc/renesas,r9a09g077-adc.yaml        | 170 +++++++++
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
 drivers/iio/adc/rzt2h_adc.c                   | 328 ++++++++++++++++++
 12 files changed, 830 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
 create mode 100644 drivers/iio/adc/rzt2h_adc.c

-- 
2.51.0


