Return-Path: <linux-iio+bounces-8867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99734964483
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9931C24604
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726231A76AB;
	Thu, 29 Aug 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JoPBjs3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB9196455;
	Thu, 29 Aug 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934730; cv=none; b=X3He7AMgUUsqsJO05MfUPF8iGXvEeF9GK2UJLXzzzF8/C7zWAUOYX3ayiMAu7xAwyZLsxWMaeVLLPsG1/JyKcdX+FLsZ87nlXheuPCsgKB2v7eIKelbNyYRQZaI13t1ZQ7vFNUy/L4TNKAQrRsp8C4DAMgpGAm8qJWY0RTNop4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934730; c=relaxed/simple;
	bh=/MOkhUsH3A/wRjM+lmkJn/y7H3d54O45Pgo5nxLq4yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9t1Mccp9NyyUW0wrHW1WSaR30k4ufiqlFlQI+Z6By98grgmp52FVoUCUkQtd0A7zBwMpmBqc8r2qp+v3AbK+wF39kaIy5K28RPxf2WGjLWHmmyu8pjGA9/ahUEBAl/cPgLQ0FcGadK2uON6Fo6Xso+OCwZnlsOsXvfx0OILbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JoPBjs3C; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3C551C0009;
	Thu, 29 Aug 2024 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724934726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIJSlvc0OIIlXfPgHywJ3lvSAon8+SBKTfloWcCpukU=;
	b=JoPBjs3C2rvgrY0JEtG2cku16cDlYOIJb7X+tASwuPB9fdWwbTKGBFRw9S0DJdhp2O2smW
	tjz1hRl6Tx1WDiCNchRcIw+OqYSMn0mFgLjJJl2+kP5CqbzaCe7Qb0lHVhW5d9Ly2SABf5
	O5ToyVx9mX3MfhS0DX2l4G8r/7UDn8haspSqU4C1tmHE6UIOaEqFZag+yD4S0SYf7MpcBV
	GFp3hswGrwLe1gLNo2p4Anu7XPONxRenEmClffVV7jG3C1PCvnfeFOqPRE4/m/Su9bQo3c
	Oo8UZK8LBNOOtXyWUb+B+RQLzTsPMzfCs8SpZ6DgKd5vORfuHDl9DyWJxXxW0Q==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 29 Aug 2024 14:31:52 +0200
Subject: [PATCH v5 3/3] riscv: dts: sophgo: Add SARADC description for
 Sophgo CV1800B
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sg2002-adc-v5-3-aacb381e869b@bootlin.com>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
In-Reply-To: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
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

Add SARADC node for the Successive Approximation Analog to
Digital Converter used in Sophgo CV1800B SoC.
This patch only adds the active domain controller.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 891932ae470f..da1ac59e976f 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -133,6 +133,28 @@ portd: gpio-controller@0 {
 			};
 		};
 
+		saradc: adc@30f0000 {
+			compatible = "sophgo,cv1800b-saradc";
+			reg = <0x030f0000 0x1000>;
+			clocks = <&clk CLK_SARADC>;
+			interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			channel@0 {
+				reg = <0>;
+			};
+
+			channel@1 {
+				reg = <1>;
+			};
+
+			channel@2 {
+				reg = <2>;
+			};
+		};
+
 		i2c0: i2c@4000000 {
 			compatible = "snps,designware-i2c";
 			reg = <0x04000000 0x10000>;

-- 
2.46.0


