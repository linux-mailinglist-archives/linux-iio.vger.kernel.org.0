Return-Path: <linux-iio+bounces-7363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C592928A01
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534DD1F225F6
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D6D156F48;
	Fri,  5 Jul 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="muw90pSE"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EB154C04;
	Fri,  5 Jul 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186957; cv=none; b=X6jM0K6DGdV9l0w3M7RD/VXmdA0ttGcrCWjzc+Uzzcfx6iXbWyLTk/mFdCKtIgvQ1HnpGosKgIWTS+uUPYYoFafwQeDYzkUzaJpqn5b80I3DbO+DEJrzLjf4Zx1c5nYlvbHsVIgsYbcvmJGzNeysFCHVUHM/E/Z+L/9yuKRkTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186957; c=relaxed/simple;
	bh=z9WsL0zU3oyUVTQFrcZ7jW08510FqQYoLiYtGQsJ/lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eH7z9eDkdeaiyzD0o0qvU7x55XBJmI2xAhjH1nx9P0XrWnGrs7cvTPVVbSOCRs2tT465m+ZdCSSydTqj5YYB6vlFi42YPWiduEjT6nkpVAYNiZfGLxOK1M6o4SkSNYf1W4SeCcsabVql+fbZSFSR7YuedBwSZb36NyEBOrH30dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=muw90pSE; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DCD6240007;
	Fri,  5 Jul 2024 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720186953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hUs3AjldaPNd5g+4FRGeGWP8GUZ22OX94EKEBMYwyY=;
	b=muw90pSEWZSWnblkVz/gg/x8PI/GcoRx6QeUa/OD5umHK0FNeEL0hZsq3qKV3oA0Rmzh8v
	k8vNhdJbrymeh508A89nKxUbytN0E0nwibE+ualXZtedYSXStP0jfxciDF0c5bXIWzGshu
	4QqjbN3Y9g4A26wAvlMtDmYR25ZcbMVlH+j4PnfacPT7PIbgcY6Nyym+CoiB5dPJ7MGGFT
	z89HnEW6zDWT7//lyyMSwptODE0w/aUz1g6ZLunSaKux0z6cRpxx/EGIyRsXLBMn7ypzhr
	4fkqUz0YDUClNzT5pry/435Ke4DYl6pXIbKNm81W/Ez/yDLqXY+iN8IOtcsYTA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Fri, 05 Jul 2024 15:42:25 +0200
Subject: [PATCH v2 3/3] riscv: dts: sophgo: Add SARADC configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-sg2002-adc-v2-3-83428c20a9b2@bootlin.com>
References: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
In-Reply-To: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
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
X-Mailer: b4 0.14.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

Adds SARADC nodes for the common Successive Approximation Analog to
Digital Converter used in Sophgo CV18xx series SoC.
This patch adds two nodes for the two controllers the board, one in
the Active domain and the other in the No-Die domain.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi |  8 ++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index ec9530972ae2..73abbb6e5363 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -25,3 +25,11 @@ &clint {
 &clk {
 	compatible = "sophgo,cv1800-clk";
 };
+
+&saradc_active {
+	compatible = "sophgo,cv1800b-saradc", "sophgo,cv18xx-saradc";
+};
+
+&saradc_nodie {
+	compatible = "sophgo,cv1800b-saradc", "sophgo,cv18xx-saradc";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 891932ae470f..752e14fa3d0c 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -133,6 +133,14 @@ portd: gpio-controller@0 {
 			};
 		};
 
+		saradc_active: adc@30f0000 {
+			compatible = "sophgo,cv18xx-saradc";
+			clocks = <&clk CLK_SARADC>;
+			interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x030F0000 0x1000>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@4000000 {
 			compatible = "snps,designware-i2c";
 			reg = <0x04000000 0x10000>;
@@ -297,6 +305,12 @@ sdhci0: mmc@4310000 {
 			status = "disabled";
 		};
 
+		saradc_nodie: adc@502c000 {
+			compatible = "sophgo,cv18xx-saradc";
+			reg = <0x0502C000 0x1000>;
+			status = "disabled";
+		};
+
 		plic: interrupt-controller@70000000 {
 			reg = <0x70000000 0x4000000>;
 			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;

-- 
2.45.2


