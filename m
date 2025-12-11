Return-Path: <linux-iio+bounces-27011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3ACB53E7
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB3623002FCD
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB82F8BD1;
	Thu, 11 Dec 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CkaARP7q"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739F2F83B0;
	Thu, 11 Dec 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442857; cv=none; b=TaEK+dKyo7An+6MiG2Wfb56W+p8Im2MZIzvO2Khi6ShJ2fgVyi4MdBMeDmYjeLlN6643Z0hiCe1yVpaU8xD594JCnIi7NvrEXlPZmqNWlmTC6GKkHauZyFKHnlqbLoEpmxLBCGEfWk5SWP1BIKa1+n3yrNhrSB0JYGbdSPs6mpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442857; c=relaxed/simple;
	bh=78TR9hdY/Uh7eEb0DnckkNlF4+u8x8y/ed/0XSY1mik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RPZZgIjc+iNQZd6MK/3LFHsnU48HbnC0UcXogMMZDxctQAPlIEpjgfItO3sAKDWCrFKAKgJvj/oeTUdilZRE36GbE1clPBVO+uLM4dx+BgnZIWl9KAsQGRg3aF9kkGS17iRu65DQLOKwoTXbYPOObJgc21/gW7koVV40mSwnOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CkaARP7q; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442852;
	bh=8PfQPChFD52EYAoiUYy2MTDPMEeHwuPds4q02w/3Uek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CkaARP7q2FmBiS7MCWrjA+CSe0QJl56qQarhnVOQmEXNG5vcqit2PYUaIBPtvFfR6
	 ITOJR4pCktJRSIlEmgryphRbHnb2xYBJTxcTNsLb9j5fuI5deRF1y6sfSO7LGuewoq
	 L6196eAJAaLbsmoF0t7LGKbmUtfT/h7j3eS6pR0oDP61d7l4NBgKZoAfwZq/4XSrg3
	 F34Sj+1lOGUEyduANOL8lIOucie7DQJLjzjIGhGyAkdqIf12Wz+jDJQ0JFl0TVQ5fo
	 Xm5env2vkbKE0/3XTSrzBj9GckURcubpBEHdejk/F7aN6RAHt5GNJ0opZwB4ycjrzW
	 u1n1ylv7thhkA==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1AA457D6BB;
	Thu, 11 Dec 2025 16:47:26 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:54 +0900
Subject: [PATCH RFC 12/16] ARM: dts: aspeed: g6: Drop unspecified
 aspeed,ast2600-udma node
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-12-21b18b9ada77@codeconstruct.com.au>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-iio@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.3

There's neither a binding defined nor a driver that matches on the
compatible, so drop it from the devicetree until someone is motivated to
solve the problems.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                   | 9 ---------
 2 files changed, 13 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index ea1bf6f402bd..2aff21442f11 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -1293,10 +1293,6 @@ &mac3 {
 	use-ncsi;
 };
 
-&udma {
-	status = "okay";
-};
-
 &uart1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 86b30e38fa25..4583c68748c2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -861,15 +861,6 @@ fsim1: fsi@1e79b100 {
 				interrupt-controller;
 				status = "disabled";
 			};
-
-			udma: dma-controller@1e79e000 {
-				compatible = "aspeed,ast2600-udma";
-				reg = <0x1e79e000 0x1000>;
-				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-				dma-channels = <28>;
-				#dma-cells = <1>;
-				status = "disabled";
-			};
 		};
 	};
 };

-- 
2.47.3


