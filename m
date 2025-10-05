Return-Path: <linux-iio+bounces-24732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3759ABB95BF
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D371895CFF
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 11:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1492741B6;
	Sun,  5 Oct 2025 11:14:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDEF26D4EA;
	Sun,  5 Oct 2025 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759662843; cv=none; b=ViAmNu98U2DpQJ2Ab3VNInb2efDlGRsXsmPY/lH/69ydPhryj6etYRjDGGAbItZHw1g6AKcFpPL6mmhPuVH2xvneGZmLr9hH788DnGQZ847jvAdyOoq00hts/0Fflu2WgAyBhsaZsQdNN9R2sRjoLIY0sugzqW9lRrEllAhapZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759662843; c=relaxed/simple;
	bh=ZuqlNmZNB72taXLYYYR99ChYgDT8P68Crw/8aM/Lo2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=icQDu0T/beukHCHsAWCrLR3eTTM4/DuvP67v7NfjF7zqBh4ZKtbJCvxu1H6OypZEm4j6dpa0RYPHMIvuD71k5VWhTFWRUQO4lEsmVPhDF6gxZa7aeMLqNMCCRxRgcyzhdDbWFxASxJ5H6jNrutA2OL7ViFCTPCP+zqGg13k3XKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 0yATbTy6R0a0bmstYq6miw==
X-CSE-MsgGUID: wxPWLmcTQP6eHW2ZwCoprA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Oct 2025 20:13:53 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0466640065C2;
	Sun,  5 Oct 2025 20:13:48 +0900 (JST)
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
Subject: [PATCH v4 0/6] Add ADCs support for RZ/T2H and RZ/N2H
Date: Sun,  5 Oct 2025 14:13:16 +0300
Message-ID: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

V4:
 * pick up tags
 * require r9a09g077 as fallback for r9a09g087
 * remove per-SoC restrictions
 * add depends on ARCH_RENESAS || COMPILE_TEST
 * inline RZT2H_NAME, RZT2H_ADC_VREF_MV, RZT2H_ADC_RESOLUTION values
 * remove renesas,r9a09g087-adc from of_match_table

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

Cosmin Tanislav (6):
  dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
  iio: adc: add RZ/T2H / RZ/N2H ADC driver
  arm64: dts: renesas: r9a09g077: Add ADCs support
  arm64: dts: renesas: r9a09g087: Add ADCs support
  arm64: dts: renesas: rzt2h/rzn2h-evk: enable ADCs
  arm64: defconfig: enable RZ/T2H / RZ/N2H ADC driver

 .../iio/adc/renesas,r9a09g077-adc.yaml        | 135 ++++++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  66 ++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  28 ++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  66 ++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  64 ++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  79 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rzt2h_adc.c                   | 304 ++++++++++++++++++
 11 files changed, 763 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
 create mode 100644 drivers/iio/adc/rzt2h_adc.c

-- 
2.51.0


