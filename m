Return-Path: <linux-iio+bounces-27007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E198CB5399
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0DE305885B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4662F5324;
	Thu, 11 Dec 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ORolPD+l"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB0A41C71;
	Thu, 11 Dec 2025 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442833; cv=none; b=RL+fDf1SVMRRt2j3Rq9qg1ta8SJJj8/qijRYiVVTU8oveyRaE+8iCMM9SDiccDs1nO0XMtWKQvyxZd0R0Uuv7UYRv6hTSD2juvrXc6FU+K2zZqnwn5X1zcwQbtZL9G08Nnn9R9Sb6fOg+gMzk0dIO3gJbAvPg7/iPc72irn43sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442833; c=relaxed/simple;
	bh=vG9hw4pzhJRjKhVwl0njoq1CA9BI/WgcTLRv+Xivpd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJp1+jZEXz+8mgSkc41qnKVERbdqaT7tmnbohQ4cGSQIawr5fcHYQ4aUr+6C9wOrLsQ1/UqAWdZdScgUStyhCosCcvsmIZwz1OmPMACZ1lh6OMC2GraIqJjC0MuVEcASU/Lkw/NtNkKjyAvd/ikoW0qE1xBOoKk6LY5wDvZbWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ORolPD+l; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442830;
	bh=QgrHDw2+1vxkomBSkN6qpychebIEg4g+gGr8/vvCI1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ORolPD+lNijN6SbxVyOiH5cJlcepdpMKA94aBXhai5xR8KzOe/a5aWs+SSlO+UGt5
	 JQnbglvjce0z3jI770cy0oO4Q+YU2ze1O9MBqJW8+6g8FPAec1Jx8Akd0feqREU0xj
	 8Yu3HJSBSh+mDPELPzwBjO2xEZrngqzCpDmiETlkVxZxAHRW+X3VFPXxicFf0GnBYX
	 zfc5NMRh7pxU+wfdrDymAVGM4OVnd6GVcJee+tqmxAW8Qlmlv/qB2YKdfH8NRpNVP4
	 1rkMu4ZfsFzZZPNl4eQvexVUNemUemdoJrIxCrBXF2f0NT7wqzf3HC/FUuZEpXMVbu
	 iyiDKfemDBe1g==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1669D7D6BB;
	Thu, 11 Dec 2025 16:47:04 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:50 +0900
Subject: [PATCH RFC 08/16] ARM: dts: aspeed: Use specified wp-inverted
 property for AST2600 EVB
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-8-21b18b9ada77@codeconstruct.com.au>
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

While sdhci-pltfm supports sdhci,wp-inverted, it also supports
the un-prefixed and specified wp-inverted property. Switch the EVB
devicetree to use the specified property to remove warnings when
checking the DTB.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index 3eba676e57f1..c51977dcb56b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -315,7 +315,7 @@ &sdhci0 {
 	bus-width = <4>;
 	max-frequency = <100000000>;
 	sdhci-caps-mask = <0x7 0x0>;
-	sdhci,wp-inverted;
+	wp-inverted;
 	vmmc-supply = <&vcc_sdhci0>;
 	vqmmc-supply = <&vccq_sdhci0>;
 	clk-phase-sd-hs = <7>, <200>;
@@ -326,7 +326,7 @@ &sdhci1 {
 	bus-width = <4>;
 	max-frequency = <100000000>;
 	sdhci-caps-mask = <0x7 0x0>;
-	sdhci,wp-inverted;
+	wp-inverted;
 	vmmc-supply = <&vcc_sdhci1>;
 	vqmmc-supply = <&vccq_sdhci1>;
 	clk-phase-sd-hs = <7>, <200>;

-- 
2.47.3


