Return-Path: <linux-iio+bounces-24616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90506BB0537
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 14:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98AA2A03E9
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C462E9731;
	Wed,  1 Oct 2025 12:24:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC0F2D24B8;
	Wed,  1 Oct 2025 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321451; cv=none; b=dWhP9sESgwIVDSWguK0BkigmZW+r7p3J0Vu/HSaiFDNU2qgpaCg5ciyvDw+1GbyDvtxtglNMyEkhB1bNQiH0/VjpdMj8tMsrBVPU3SDzYxsvog0HDDsn0KzUvKerPV0cvJp//MH63+zkLG85WwCV9hY+N2lLK4tKKfZaw3O0ZcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321451; c=relaxed/simple;
	bh=WSz8peSyhoJuCfVCOY427Kw+bxjeawziSH5WiCHh+YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TrfCAdS70Mye5GJIZ11vOztUpeLa+b73Mbl4Eb11CqTFT8jbrwCDqYcs1RWQi0P7r8aa2QgWJF1XEHvpoRj8Sn9GPiAflcRzC86UtH/ejJbVUfm3aGp32214X9BFbZpR4fwX/MQN1O5vJVdn+Xll7x5R3PPAKPAWtPQiIu2/amo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 4d6JDKTMRrOl5p9DC4Ic5Q==
X-CSE-MsgGUID: kAvwuS/3SNy8le/0tAc4dQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Oct 2025 21:24:01 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8539B4196E6D;
	Wed,  1 Oct 2025 21:23:57 +0900 (JST)
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
Subject: [PATCH v3 0/7] Add ADCs support for RZ/T2H and RZ/N2H
Date: Wed,  1 Oct 2025 15:23:07 +0300
Message-ID: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
12-Bit successive approximation A/D converters.

RZ/T2H has two ADCs with 4 channels and one with 6.
RZ/N2H has two ADCs with 4 channels and one with 15.

Add support for them.

V3:
 * remove leftover renesas,max-channels property from SoC dts
 * split rzt2h_adc_start_stop() into rzt2h_adc_start() and
   rzt2h_adc_stop(), getting rid of mask variable
 * use FIELD_MODIFY() to clear and set at the same time
 * switch from guard(mutex) to mutex_lock() & mutex_unlock() to keep
   pm_runtime_put_autosuspend() out of the mutex and to avoid using both
   guard() and goto in the same function
 * inline ret and irq declarations
 * use private state rather than indio_dev for platform_set_drvdata() to
   avoid extra pointer arithmetic
 * pick up Reviewed-by for the driver from Nuno
 * pick up Acked-by for the bindings from Conor
 * pick up Reviewed-by for the bindings from Geert

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
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  66 ++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  28 ++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  66 ++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  64 ++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  79 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a09g077-cpg.c           |   3 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rzt2h_adc.c                   | 309 ++++++++++++++++++
 12 files changed, 795 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
 create mode 100644 drivers/iio/adc/rzt2h_adc.c

-- 
2.51.0


