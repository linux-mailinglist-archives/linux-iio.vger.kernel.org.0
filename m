Return-Path: <linux-iio+bounces-27015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBBCB5464
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 10:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 850173012DF7
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1F22FD7C8;
	Thu, 11 Dec 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="DtLZgl/p"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D82FBE10;
	Thu, 11 Dec 2025 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442877; cv=none; b=t12FktvSTTrqwflOAH54l3VZFAr19cIehb/7Ojoc0M9qmGAoQ2QTcrTMgP4sdyNkyEvVFtXGLTdvzzQp1ZvmonMrgPmZP46v1oLa5+JxanT5VFXviYUtiw8sbhNavagxtigN9CdUidIwHmKd1Zd7aCPCi6DmMv3GqjsCrCqbK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442877; c=relaxed/simple;
	bh=3uzMfys7REjFcw5rJ8WnoE2DXjU5x0qD9qatsnWhg6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/tdSHZBMq71rgkt3kpnlgINCTSqDgLRZAqeKXvLDr/ClryiF4vL9jLPPCrAPFe13JOhsoWqBHzXBPrSifnm001X3KCMI6Qs6QC2uJjhU40b9xnd/RHYa9dY89D+frcc6U1UlTI5K1OuRQkev7aokmNRjD45Dddb2YKJW16yPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=DtLZgl/p; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442873;
	bh=4YuQt/ViTsd3OTZlMf2fjHbcSpDjnD7vrDHlgaLMC7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DtLZgl/pzLlAKfeYBIFJAGq+mv8J6I5TrFfyrELEqhyHJG09MbGTKdzaI0m92ywHx
	 2MQRN0ioXDZBYRrhbN/rfR6CIR+I47pP4z+Lkvli+gD3eYeV3xdvkokIhn6fZCYShX
	 /L6U0sF/Ht/XcG4wFFgWZVLd3Bzsuwt9SqbdM5VV1leb0cZVX+WWNd/GNHx6Y5hhTu
	 Rjp2LmxLo83y96h8HPz6nVv2bNjBzSpIZgYi48iW0I7y/eETOqkoWOBQOj2Gd2WE4j
	 11CxHJJ9ct6uQO1CIWocS6QRvCseG26HsU4KGYFGemSoCE3BLGBJpCYPr00sOiwKyy
	 R6QQN/Jr1usPA==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 05A557D6BB;
	Thu, 11 Dec 2025 16:47:48 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:58 +0900
Subject: [PATCH RFC 16/16] dt-bindings: mfd: Document smp-memram node for
 AST2600 SCU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-16-21b18b9ada77@codeconstruct.com.au>
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

The platform initialisation code for the AST2600 implements the custom
SMP bringup protocol, and searches for the relevant compatible. As a
consequence, define the requisite node and the compatible string, which
in-turn tidies up the dtb check results.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 .../devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index da1887d7a8fe..3406b98c4d0b 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -130,6 +130,24 @@ patternProperties:
           - description: silicon id information registers
           - description: unique chip id registers
 
+  '^smp-memram@[0-9a-f]+$':
+    description: Memory region used for the AST2600's custom SMP bringup protocol
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: "aspeed,ast2600-smpmem"
+
+      reg:
+        description:
+          The SMP memory region
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
 required:
   - compatible
   - reg

-- 
2.47.3


