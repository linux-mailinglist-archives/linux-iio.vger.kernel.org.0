Return-Path: <linux-iio+bounces-23766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F47B45584
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 13:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33F81C822F6
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EAA341643;
	Fri,  5 Sep 2025 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="rdhKJR0Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12433CEB1;
	Fri,  5 Sep 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070092; cv=none; b=aG/Vbvdit06Gr96mtMPRtn93AgNMg0qDC4ISbSPO0gAbzBSjwszF+9ZwdPW6vT02kU/0tV0qwZL2D7bAP1YamJQqrd2SQ6PSPWZPBj8Dv/n3LbFsbj9bJUYGns5SdIeNhkwzsQtYloIhCe2tG8TXrNMy9+ZwlmUrJV8ZLdOvuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070092; c=relaxed/simple;
	bh=8lO4nr828tWQwLxmjjV752k5xLRe27/oDan4m5yXVVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KK0y7X770tz0vQPj03qf1tiq0+888m0z8dy/2QEovkCyW8Uw7oeYSpHuoXbGKRzUs9UEGysNV4MtJ+tPvpKQ323fiBVrEwxe0eBaskbMDGBdGxS3kQFZlnRblq5Aamc/c7KqCuOOqC9jNnrxEbDDUV//ed+6Q2LTkPI9Y/UDz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=rdhKJR0Z; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=NNf4fuAZROXF/tF+4WNY4vZ8skBqcJAXIMX4FqXGMYk=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1757070065; v=1; x=1757502065;
 b=rdhKJR0Zn09b5uxXZxfBfxlqaLmzyLEZl7fpK7rI7w7usJ38R4t8HBQ3Sd1vCtiaboTY/8LO
 W93jL/9Zp5lTuX9BSCxExTUL585UZUGE3Oxr8JU7yOVk928E8yHrVEhT8a5CGtvFsIqrfeWsdOp
 q/ZhGZBxBBLU5IrQ1lZL2UfMWFCdII6/0P7ardUh5RQqVvKG4s/baQliBlRRw7TEZXNnaJdDJTV
 OykD3mIGkXgBe2wb2+84yRaI5Gy88XabSzyL+9tnVFlSi5FlORahtBdyxJt1Rq6ihG/WqdQ4pYv
 oabcwFiDl0hNh/o2Mb/NEfDfx8n+hKVCrQbjdFvh07DKQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 610bc954; Fri, 05 Sep 2025 13:01:05 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Fri, 05 Sep 2025 13:00:54 +0200
Subject: [PATCH v3 1/3] dt-bindings: mfd: 88pm886: Add #io-channel-cells
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250905-88pm886-gpadc-v3-1-4601ad9ccb51@dujemihanovic.xyz>
References: <20250905-88pm886-gpadc-v3-0-4601ad9ccb51@dujemihanovic.xyz>
In-Reply-To: <20250905-88pm886-gpadc-v3-0-4601ad9ccb51@dujemihanovic.xyz>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=8lO4nr828tWQwLxmjjV752k5xLRe27/oDan4m5yXVVA=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBm7Dr2vuKGlEyV4iFspSqD90Lo5c9PztwoJGBe+vPp3y
 k1d30XJHaUsDGJcDLJiiiy5/x2v8X4W2bo9e5kBzBxWJpAhDFycAjCRq5MZ/oc8Ph7+dEFnU++E
 CSefv50T2nH3xYo6Bj5drsfqjdNNPk1g+B+2Rd5vV5AIZ/KkhCsad347TedeJ/r0AevWr7P/hj9
 MjmEDAA==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add an #io-channel-cells property to the Marvell 88PM886 PMIC binding to
allow referencing the IO channels exposed by its GPADC.

Acked-by: Karel Balej <balejk@matfyz.cz> # for the PMIC
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v3:
- Update trailers

v2:
- New patch
---
 Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
index d6a71c912b76f7d24787d346d4b4cd51919b1cf6..92a72a99fd790805e775727e39d457608fa1795d 100644
--- a/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
+++ b/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
@@ -35,6 +35,9 @@ properties:
         description: LDO or buck regulator.
         unevaluatedProperties: false
 
+  '#io-channel-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -53,6 +56,7 @@ examples:
         reg = <0x30>;
         interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-parent = <&gic>;
+        #io-channel-cells = <1>;
         wakeup-source;
 
         regulators {

-- 
2.51.0


