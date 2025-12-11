Return-Path: <linux-iio+bounces-27004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A3CB534B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E0D83014D8F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC082F549F;
	Thu, 11 Dec 2025 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="duP9PMvK"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FBA2F1FED;
	Thu, 11 Dec 2025 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442816; cv=none; b=JuY7+jNVMzGgTOAI88Jsim7L61cNFCZgputZdfdF+U0G+ZgnUSxFQdL2l4YHR9HfXPrdyuzEmfCWImv/VWZCR81x0ZZpAOFeB9Hd0IAyhfGFaTigTXEBe/jR3mLeUNTDXnixncyU50hwVM83/gpZj9qosFjnA8Bm4t/pNJQYWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442816; c=relaxed/simple;
	bh=fcgaBLB9fioj91IsjeD5fJqpuEXGdT+eruOQZdSaLGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sCS4y5pfAnbQn2oDUe8CjyQ3GqvIqBRH06sw+L+VrsWiEj2qibW8gWRpwl2y93AmyTSAmJGqA0PTkSrGzu0TpWVGDZB2skZ22QATpizbvCRK2ot886HtsJq9iFIudo1waCvqpGTK1FOj8yNJ2pKF8nbEOgF/PLKZ2KZn06/6lRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=duP9PMvK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442813;
	bh=tp+xzlgYB5DRkmyHW/VuZG10lptnHgB70xDH+2/3gdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=duP9PMvK5GwXWyss9okc3SXr+1TPANiqlHeKr1pIcDNebI76EnIRJoe1HinIal1sI
	 7qjvvNw/7Amqs0F2nXOEfHVXufshRdqFWffjz8KfKSGPPfYr6xjiLJnLxcOS/uRrWq
	 suwou0ffSYhYm+9pkLElVuzPCBcuIAmVaBO7j+vCKgTPmlBjMZYhDDHlV9GxgdK69c
	 LW+LfzvrgNnazyvAtd0vJBGxdouZj1sImF0bg0/LVRh2dlVt/wqheIZfPhwNWBD7SX
	 a3G1Z0IP1XspE4UlxZw6EBVtECvtAfCtFc5frTpqgeyZojhjYHKQjBDV+U/krni48E
	 kGJNsTsn5N3dw==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 018157D6B0;
	Thu, 11 Dec 2025 16:46:47 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:47 +0900
Subject: [PATCH RFC 05/16] ARM: dts: aspeed: Remove unspecified LPC host
 controller node
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-5-21b18b9ada77@codeconstruct.com.au>
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

For the AST2500 the node was used for pinctrl purposes, and while the
hardware capability is also present in the AST2400 and AST2600, the
their pinctrl no relationship to it. Further, there's no corresponding
binding, remove the node for now to
eliminate the warnings.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 5 -----
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 6 ------
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 5 -----
 3 files changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index c3d4d916c69b..c0a4057fa53f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -376,11 +376,6 @@ lpc_snoop: lpc-snoop@90 {
 					status = "disabled";
 				};
 
-				lhc: lhc@a0 {
-					compatible = "aspeed,ast2400-lhc";
-					reg = <0xa0 0x24 0xc8 0x8>;
-				};
-
 				lpc_reset: reset-controller@98 {
 					compatible = "aspeed,ast2400-lpc-reset";
 					reg = <0x98 0x4>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 1456f04c2139..086c40fd12b8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -504,12 +504,6 @@ uart_routing: uart-routing@9c {
 					status = "disabled";
 				};
 
-				lhc: lhc@a0 {
-					compatible = "aspeed,ast2500-lhc";
-					reg = <0xa0 0x24 0xc8 0x8>;
-				};
-
-
 				ibt: ibt@140 {
 					compatible = "aspeed,ast2500-ibt-bmc";
 					reg = <0x140 0x18>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index f8662c8ac089..1ae816087f6b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -624,11 +624,6 @@ lpc_snoop: lpc-snoop@80 {
 					status = "disabled";
 				};
 
-				lhc: lhc@a0 {
-					compatible = "aspeed,ast2600-lhc";
-					reg = <0xa0 0x24 0xc8 0x8>;
-				};
-
 				lpc_reset: reset-controller@98 {
 					compatible = "aspeed,ast2600-lpc-reset";
 					reg = <0x98 0x4>;

-- 
2.47.3


