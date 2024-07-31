Return-Path: <linux-iio+bounces-8092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F73F942E5D
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9F7289539
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 12:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491061B14F4;
	Wed, 31 Jul 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L/5jKK+P"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614C1B0126;
	Wed, 31 Jul 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428667; cv=none; b=XlQ2ly74bcyiksx9HMVCzB3ingFQKE03wFWjKyqmbxwmSWJysdoZduzaRs5+yhSZgluUruVJp8QRo6dIxXmx8QCRFJLv/w41RSV7ENvpdr1/UZnJfGQ/DyqGD1I59bLQA0R/k9WZobZaCZP1cgT5VHgCi8VimvNxpBZIN1tIaCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428667; c=relaxed/simple;
	bh=8CqeLdJ35Bw0io6EZIc3vUQEHBV++qKNQgEgHx3SCz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vx/3xhjFQeGND2K4F54fjxk/hUnCDy/TZWgJd7ICEH6yK4Vd1NvmXecSERH6wlS/7eGU0FWfHWTRYWgvcz5/JAEGfKpfqAglAa5ArBsW+j2VdKzn7ZOtlhOgrhl80LaKl+hALpKM6bfSVfmsfglbGywKfy4Nkr3MHKWsM7RaW8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L/5jKK+P; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2EDDFF80F;
	Wed, 31 Jul 2024 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722428662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzL9srRp7/ysRgKm0/IwbsiR9simdpXOOi8YCDBxwBs=;
	b=L/5jKK+PYcC2lPcfGx66Fs2gz5oO/teH8boiBpbZ/5ABbnbCkwQRBPZ29EAaOkNP132U0G
	jfNGuEFtrsDKuVltaeMFNjuUF/IId1yU0JbWpGcSYCZc/yU+zeARjguRQ/LpBvt055tLML
	aodVmC1kiTOqqwHmBPFCa5Sq16/i84RJ0I4yRvCTnlwP+YgfHYg+iLgHfzQ1OsQmfQzgf9
	WofGYhrhTGnkfgLbwngsIYyvoq0FBulJ/gx+6MaADLMTdrIkxqNz6u4o2vJsNo0xuVZd21
	6zVzdcjAjz6qOOQ/d6QxGtq6AahCS/lYnNg6AoqSRpgLf0zopkBMDy//hq4tVg==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 31 Jul 2024 14:24:16 +0200
Subject: [PATCH v3 3/3] riscv: dts: sophgo: Add SARADC description
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-sg2002-adc-v3-3-5ac40a518c0a@bootlin.com>
References: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
In-Reply-To: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@outlook.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.bonnefille@bootlin.com

Adds SARADC nodes for the common Successive Approximation Analog to
Digital Converter used in Sophgo CV18xx series SoC.
This patch adds two nodes for the two controllers the board, one in
the Active domain and the other in the No-Die domain.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 891932ae470f..e6c1a84d3e55 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -133,6 +133,14 @@ portd: gpio-controller@0 {
 			};
 		};
 
+		saradc: adc@30f0000 {
+			compatible = "sophgo,cv1800b-saradc";
+			clocks = <&clk CLK_SARADC>;
+			interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x030F0000 0x1000>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@4000000 {
 			compatible = "snps,designware-i2c";
 			reg = <0x04000000 0x10000>;

-- 
2.45.2


