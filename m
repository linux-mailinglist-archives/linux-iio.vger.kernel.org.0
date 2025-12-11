Return-Path: <linux-iio+bounces-27008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B49CB53AE
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 09:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4C78301EFB6
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2552F616B;
	Thu, 11 Dec 2025 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="R43nVcAK"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912602F2608;
	Thu, 11 Dec 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442840; cv=none; b=nobrrgACySlqqnIB1E6s1n4HjAmktMhob+vEh58wTITgHPfv3x6Fe1lk3lCsXnD7b7JuHw9WVRcmJ/9ig1hejta7EA+VwaihTbY66kXd8Z53fgXFgzJPZDfmuURxSJ2IyepV0/wrhvPr+xKPrvOdmSVqh+MY09V1LRaYVTlJSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442840; c=relaxed/simple;
	bh=B7lVpiheo19PhrqE7VPUHtCnXxi0uZw3VPB+UVgJ90Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGug9uDFvVhAx/1sa4i18o8CRFc06I+0C+IXhQR0XR+Vbk9eEZBMMI8FoM6t8mtUQq2U4gsTt9udX1xpQkqIYO89DfVB6a0VCXS6nz+K2x6ItMQ9IVajSno3gMIuGESKP7O2Ul8NRlg/Z8CgKTLrVfZLG345awkIFPAPqFSXJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=R43nVcAK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765442835;
	bh=rj6Ys4VgfF3wMgOB5TKYV5h47MurR6kyE683c2NwUxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=R43nVcAKmIKmxxY1afGyp9269WBa1/8ZZKA+sg0CL2QCovXOLQQNNbE9YrcjlFRI8
	 B9pl3odOOTH1Uj0p5s9Xl8amMl4qDAiIdyw29hJ3y7b+G9guO5eBvwcgnhL1Xnufku
	 AYVFDK/A1c/U/b183kKSt7OiPuAs40vEX31hd+s2J5U6kIpKBnJEd0pvNL1FwGwxt0
	 Z52kjXnDZ/iYjw9OXeIDtR2It23x0ZpOxg5eXo6rUbkhybScMIxffFvF27TsmkUTEz
	 xNceCv2Q66+QhHI4Wt30EEKTQ2ly8bvqJeCtdeWZ2QXophArnQLbSX2+v0li5m/+PW
	 ujK2cRoGriX/A==
Received: from [127.0.1.1] (fs98a57d9c.tkyc007.ap.nuro.jp [152.165.125.156])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 839517D6B0;
	Thu, 11 Dec 2025 16:47:10 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Dec 2025 17:45:51 +0900
Subject: [PATCH RFC 09/16] dt-bindings: bus: aspeed: Require syscon for
 AST2600 AHB controller
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-dev-dt-warnings-all-v1-9-21b18b9ada77@codeconstruct.com.au>
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

The AST2600's ACRY (eliptic curve and RSA crypto engine) requires access
to configuration exposed by the AHB controller. The devicetree already
describes the AHB controller node as a syscon, so require this in the
binding to satisfy the ACRY relationship.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
index 2894256c976d..77e60b32d52e 100644
--- a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
+++ b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
@@ -17,8 +17,10 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - aspeed,ast2600-ahbc
+    items:
+      - enum:
+          - aspeed,ast2600-ahbc
+      - const: syscon
 
   reg:
     maxItems: 1
@@ -32,6 +34,6 @@ additionalProperties: false
 examples:
   - |
     ahbc@1e600000 {
-        compatible = "aspeed,ast2600-ahbc";
+        compatible = "aspeed,ast2600-ahbc", "syscon";
         reg = <0x1e600000 0x100>;
     };

-- 
2.47.3


