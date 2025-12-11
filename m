Return-Path: <linux-iio+bounces-27014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BADCB542C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52193302A957
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266692FC038;
	Thu, 11 Dec 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="N1eYzek2"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C842FAC12;
	Thu, 11 Dec 2025 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442871; cv=none; b=GLSj5rF2EWV+JMrQ3geRDA5jCVR+/vdYceZZhT7Le8m/BhzuUrNbSI1luXhES3WnmjRF17Q8bUXjy7M7XPLtw1ERll71lVK+HBtM961dDw/qgtOQxRt31z/CV4wYYQWscsQYIZlsVSavY9eWa1x8YqXYDKlrG+FkmBUlr1EycAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442871; c=relaxed/simple;
	bh=wgy6FrHD/mf3NNyvp14WVY6WRZF3rkBrj7Hr5S3cllQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXvTzNx5ImZldntjN02UoA+BmjjHSWy2dXH9kM5I1J4L2weUNFkug0sOuiFIhbob4CHBNCU3VKj+vyg4nJMTLbzY6cFWDtmmxn21foHn7hiVDx3s39OhfwrjluDS3HqPkaE3Jj9s6NeZTeDVSD3MQGAYaTxYcwjXMQIJpowaNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=N1eYzek2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442868;
	bh=Iu4TPpF+5DGJ5DsE0F1CuqneX0MF156KpXyPhzX8E5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N1eYzek21eihrgNsj8tfP6CntNClLcV40Yb1a51mjY7eg0yL/BrWQNrdx9pLiWhkv
	 +KxqQcpc4uO2vTRr/CDKxIwJwUjVZbciI+mbbY+fuaKUhBEiQunPivRGTgFDjHYjoz
	 bDogU7VIRPjZxrkyzdG5rS5D5rZxxK2TGpgixjqSB/a/Ku8N5+ldco7oaUunkhI54r
	 KRVQAhnFYyF7m451J7ZK4fYDvovtQiUXGyyJN74EYUbVUfaZqHFh0C0dgJUoL66Xih
	 kRsciCepHt/QvVh7vnqTDAq9u4nXM1s3XLB3cGb1OQaKIbnQA63Tez0mwQsFWmRO2I
	 Xd39AR6ftlHPg==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 60BD77D6B0;
	Thu, 11 Dec 2025 16:47:43 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:57 +0900
Subject: [PATCH RFC 15/16] ARM: dts: aspeed: g6: Drop clocks property from
 arm,armv7-timer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-15-21b18b9ada77@codeconstruct.com.au>
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

The property is not specified by the binding, nor used by the driver.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 4583c68748c2..567f8040eb8f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -68,7 +68,6 @@ timer {
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
-		clocks = <&syscon ASPEED_CLK_HPLL>;
 		arm,cpu-registers-not-fw-configured;
 		always-on;
 	};

-- 
2.47.3


