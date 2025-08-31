Return-Path: <linux-iio+bounces-23514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D87B3D221
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E66D17A89D
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B170253B66;
	Sun, 31 Aug 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="T/QTrKJY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1523956A;
	Sun, 31 Aug 2025 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756636422; cv=none; b=ICpBPup/mNZPFvvIihLE5FX7WoE0BDeqm0Jza1zsiW76mYisbHGGvh4KVf9NPnErNN2IA4C7F/d8goOYuRMs3cVPE6SUi+IoZi8CyAqe5apXtA7hDb92ZewfB0vbAGxFUdcWZsLjVuV0HjT/cPRitN+MJFmYTQI13DOE98pbhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756636422; c=relaxed/simple;
	bh=/BWt+gb17rWNwqyQ+PIFgYY2U43Z8AJLgUzQ6kNKN5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7MCVdTw0Tkb4WoIVGbiTTZlG2AhRGlFjtME9iEVAzLtrtoFiX+hbnQL+SDGL1UskhmHgMWR3j92150D3/1KfMDk6H9y/7wyaMPerJ2E8s/93khc6BYR14NyogUgoDKoPVcBns2rpLRQAAabprIFRIBXAoEIvNpRHUGxkZandbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=T/QTrKJY; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=SsSfy111NsTTMO5BFJ1Oz+QDDxhQIm8ud+geT3OT/AA=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756636409; v=1; x=1757068409;
 b=T/QTrKJYfOALdFVF6aORoM5uQOienY9Si9kEbpzngXkAGzdySQ5Hm+Isb0oLhb+a8T8vaqta
 GyxtHyyyBUEkiqOCSviY2ztXfT7JkMyxIyhXC1DJ2H/9cl/nGhKDZh23RdKmvu9nIElCC/c7uTq
 uKmrj4Qn2e6XCuzayvz7OzjlY4enEO/MNdhmKxfoRn7v2eL6U9YdsgnG+/8IzkCUieOiFEO+1Ub
 fAYXJsK9N2aRgsYx+1ym35ee+fkMotwvrcZJeRhyn1yxK29I4On+jvqTLDupD5nx2raVuI+ogH+
 xOQ00DWjQ1F9gCC2rxjkAf4egvIdFSB1npz9bHD8vCMiQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id dd0e146c; Sun, 31 Aug 2025 12:33:29 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Sun, 31 Aug 2025 12:33:04 +0200
Subject: [PATCH v2 1/3] dt-bindings: mfd: 88pm886: Add #io-channel-cells
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250831-88pm886-gpadc-v2-1-759c1e14d95f@dujemihanovic.xyz>
References: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
In-Reply-To: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
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
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=/BWt+gb17rWNwqyQ+PIFgYY2U43Z8AJLgUzQ6kNKN5o=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlbVL7bV0THvVrx+LhFd89MXUv7H0WZjv0fpx7zVuL7s
 2BXh0VpRykLgxgXg6yYIkvuf8drvJ9Ftm7PXmYAM4eVCWQIAxenAExE8BYjw5S76Sk2ga6KIi8N
 A+2dP2x4v+Lhq/naxVMEDruJS6u828PIMOPVwoKvB71yf3xcF7vHZ8nEXq6k64ZzIrWf1NWv0py
 xmBcA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add an #io-channel-cells property to the Marvell 88PM886 PMIC binding to
allow referencing the IO channels exposed by its GPADC.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
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


