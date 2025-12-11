Return-Path: <linux-iio+bounces-27009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA7CB53B7
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5489E3024E78
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FD62F6905;
	Thu, 11 Dec 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Kbl6jMAR"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E92F6565;
	Thu, 11 Dec 2025 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442844; cv=none; b=jAwzZB9e7dNlqImV1GmyKQ+3FVHkgzrODDWvwkEUNN7R+LKF9OzG5K6s0LDl+rVPmmD+/eIxK79dlm5le1hbxt8nPCT1nLHWSZtSCDgjwfIrsknJfv3YIYHYWDyCR27kHBwqmzEJIH1+VkxgcxwW0FuTPuJkDn2SiEheNoqGPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442844; c=relaxed/simple;
	bh=+qeTkNETZAheKHqQ9CkMNA/qkCbR+xWVYuZ8Ok+UECQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NuYQVnnuplfTZ99JFJ2js4gkz1teoWk29TJrLxvQ2hLzV+jM1EY37Uf5YvY3hH74Iyp4Qb1hlnhKb/BoYEUMJ0cHupOLKFisKM5X2AmqV2mYooxOLcR+fqG2JE30Za9m3N1Nbq4gcZ1YSlpKJcdidxXZIQPzMhlagy8Q3Gw4EJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Kbl6jMAR; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442840;
	bh=scUXHBA8U36RhFOiHgBOHOnbtB8kt5qA5NvPIcX39Ts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kbl6jMARUYr9p3EhuRIx7DFr993blzu2iTSvxCBzC3fcoeeUKB+9dEEGIjvFgrC0o
	 699wvbd4O/UbmujPS7oflU1iFRhNWEToKfk+Vp1mY6yY6s5tL5XTf61LjTW49Imt0d
	 /e7f2n+Si4v0YguWCG1wYgpyRyFqcsGg5Dn/1LI1qMteB5gDQn5X9mZUpno7EACIu2
	 gd5EueGuo8iBbwcEkaEjWHim/XQb9BiSKFABt992wnwtnry/uL81BXUNwibzSeVP9s
	 jGZvAtr7yYywK4Yy+6GvHqtljVdtsLA/M/Xcd+M1mKP2OtgSBYKPCGP25M89RjZotV
	 Zz+JFpjGUR8kg==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 24FF57D6BB;
	Thu, 11 Dec 2025 16:47:15 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:52 +0900
Subject: [PATCH RFC 10/16] dt-bindings: crypto: Document aspeed,ahbc
 property for Aspeed ACRY
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-10-21b18b9ada77@codeconstruct.com.au>
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

The g6 DTSI already provides the property and the driver errors out if
the AHB controller's syscon can't be located, so define the property and
mark it as required.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml b/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
index b18f178aac06..0dac6ee5043e 100644
--- a/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
+++ b/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
@@ -30,11 +30,17 @@ properties:
   interrupts:
     maxItems: 1
 
+  aspeed,ahbc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A phandle to the AHB controller node, which must be a syscon
+
 required:
   - compatible
   - reg
   - clocks
   - interrupts
+  - aspeed,ahbc
 
 additionalProperties: false
 
@@ -46,4 +52,5 @@ examples:
         reg = <0x1e6fa000 0x400>, <0x1e710000 0x1800>;
         interrupts = <160>;
         clocks = <&syscon ASPEED_CLK_GATE_RSACLK>;
+        aspeed,ahbc = <&ahbc>;
     };

-- 
2.47.3


