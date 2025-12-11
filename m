Return-Path: <linux-iio+bounces-27010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9177FCB53C3
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E48BB305FA84
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A32F7AA8;
	Thu, 11 Dec 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RJemCfSd"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841BD2F692B;
	Thu, 11 Dec 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442850; cv=none; b=m/yZ72FJPVHRvI9nXuf4yhAbbofjOawrMSPxLIRP21bMU4diQ5gVf8oM1R5G+0Riq6ZBM1Zd+FrVZfI/K6kV+ilY40XYfK+WRukhvQF1HKcAeUl8vlmWiQ+QmD2o0Hf33ROrxGR5lDGQSpUkYL9uMCd5L9GGC3Pq9c2alVNXT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442850; c=relaxed/simple;
	bh=3kcFabu8GXEfWlrX8jwKhX5xY13q0r714TQsnUPKank=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GImy2brVn1Pb0ILZ9dtJuWA+ilyRw3Hs/sDF54vBTO9SIyI0c/3BnyYAFSh2Giru4Q8O1D7DK2nQZ3EU6bzkTC7dg6FQsPxo3jW47Jd2I+/P/+JfyTjZ1NgKAuFL0YHL/x1IUyWQRAp8B5gIuIZhmx/ymzeRgfJXxfBEgOxJhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RJemCfSd; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442846;
	bh=DfE7RBxeKysNsLYVJ2cwyFMHF548EzarJueuQZE4RQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RJemCfSdq0JXdxkb7HL2R50Lv5PpvyLoZ8fHKRLKyk8aD/UfEDsVm0BfbxMYHJ1Q7
	 UiZAw1YI0JCxH8fMqCfxXFJhqnt0SwO/YNM6bnuH2g+hHRaT86bD9nd4TuhBK5dSBA
	 uYn9mX0CnuoMj7+jtMKJl8Q10shUS6xqmz/1+ULToRO8+7GJtOIupkMCMfoU7hgrVW
	 ZjFPKIIeWlwdMtbMP7D0u6w/zWKS/AgRfVXwuAXJp6w9xF+ugiHBgm1l7at3LMNqG7
	 2o9gNHEPDJO0vII0adr4LWdlc1kI/Xwqru00aTS1k2TZfCxUizynayTdIX3YLJaJ/0
	 6pqGngsMgpuVg==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8D6A87D6B0;
	Thu, 11 Dec 2025 16:47:21 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:53 +0900
Subject: [PATCH RFC 11/16] ARM: dts: aspeed: Drop syscon compatible from
 EDAC in g6 dtsi
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-11-21b18b9ada77@codeconstruct.com.au>
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

Its presence is not required by the binding, its addition was not
discussed in commit aac82707fa45 ("ARM: dts: aspeed: Add AST2600 EDAC
into common devicetree"), and its inconsistent with the g4 and g5
dtsis.

Further, the corresponding driver instantiates its own regmap rather
than fetching the syscon regmap, in theory breaking any users of the
syscon, but of which there appear to be none in-tree.

Drop it for now, and we can add it back with the necessary rework if
it's ever required.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 1ae816087f6b..86b30e38fa25 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -74,7 +74,7 @@ timer {
 	};
 
 	edac: sdram@1e6e0000 {
-		compatible = "aspeed,ast2600-sdram-edac", "syscon";
+		compatible = "aspeed,ast2600-sdram-edac";
 		reg = <0x1e6e0000 0x174>;
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 	};

-- 
2.47.3


