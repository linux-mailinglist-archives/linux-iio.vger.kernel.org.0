Return-Path: <linux-iio+bounces-7127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C412923CE9
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E91C218B7
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D978166317;
	Tue,  2 Jul 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g0vqKHeG"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB5A145B09;
	Tue,  2 Jul 2024 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921200; cv=none; b=ssjVzMeOiu/SPcrLj5JzEhZ5LaP0r2xnUs9p0IZ+xcGxKme9mKI5ZVMC+y5h/lFW2rHYFDkhV0YOFcULGh8jxAiB2bCBWKUjIXyCWsGo6Ypic7vf/todYAL3pIhqB5s30wtTp3dHuBLJkOd1gIgKE7wGdhkfmYOGFIuYQoT1GTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921200; c=relaxed/simple;
	bh=4ktnlb7yvW4ussBIReyJtLp9KZJ51hpL56o2nKPHpuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OILcGnEuwEV71zfg0fKHgCRMYtWphBRLVKJCHsdUZfdGi3WMeQSdxjM953+F1UrsXWed8+/dteOsl1+lqJww8GDrMMXhPLUK93CpnC7dbCUt3Zg8IRKSHhIsvvl6bb/Ri/f9TmYy4peMluuwvsT0/djXiFuJ0jeEvKGKkgd9IQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g0vqKHeG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7D1E1BF20C;
	Tue,  2 Jul 2024 11:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719921196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HvfbFLoLElmyEB196KhuxtSYeLMdyA9ytyFqCVntKA=;
	b=g0vqKHeGUFZHTGvhJ5s1w9/pEwrBqpADrH/Kz2VFtD3suvNGRgGQNUQgXcteSVxFJL3Dtp
	nPJVcmeGHyikdyPGe74xSw29JGyCYK05/QjZc+Hw6J9CgW9c0FzgGOrlMSgNqKz/HfmnEx
	jMR16g+Q6vXvZnd0PJGoiUaSoLWzKiAvOB+ylzIUxJ2nJCHncINM3TLaAmrmCr8lwllF6O
	mIoxAimPNIA5qvwzJXe74tEUeTt+CrxyPYHy/HpaW/QCf1hl0v4iCVK5r4w4autQsUKJvB
	vR+i3/382LkbhYT4cRqWZtOk1lFzmqPGP4C/FVKE81M3mu0V9MJQ8/onJvFcuw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Tue, 02 Jul 2024 13:52:23 +0200
Subject: [PATCH 3/3] riscv: dts: sophgo: Add SARADC configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-sg2002-adc-v1-3-ac66e076a756@bootlin.com>
References: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
In-Reply-To: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
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
Digital Converter used in Sophgo SoC.
This patch adds nodes for the two SARADCs presents on the board, one in
the Active domain and the other in the No-Die domain.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 7247c7c3013c..0b996aa7fa31 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -309,5 +309,19 @@ clint: timer@74000000 {
 			reg = <0x74000000 0x10000>;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
+
+		saradc_active: adc@30f0000 {
+			compatible = "sophgo,cv18xx-saradc";
+			clocks = <&clk CLK_SARADC>;
+			interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x030F0000 0x1000>;
+			status = "disabled";
+		};
+
+		saradc_nodie: adc@502c000 {
+			compatible = "sophgo,cv18xx-saradc";
+			reg = <0x0502C000 0x1000>;
+			status = "disabled";
+		};
 	};
 };

-- 
2.45.2


