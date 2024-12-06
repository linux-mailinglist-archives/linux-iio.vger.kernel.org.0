Return-Path: <linux-iio+bounces-13162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D592A9E752B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968A828A207
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53120DD67;
	Fri,  6 Dec 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFqiW3WG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DE20D4F1;
	Fri,  6 Dec 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501409; cv=none; b=ooJNV1oxSPtbLuZi2Sf6EtIp8e6B4pBasy9Nq85wE0/+WMzTm5+0gkZOjVAXkfT3hbxGf5knetxAxemvP4H4jOTDic9XDdCCki4Wfq15bG91FPiz8h0WVfcmrhq7Do1qZsokbRo0G7+UhWywGEMhfbKnZE2h/oVYpYyiaEoBFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501409; c=relaxed/simple;
	bh=p+mFtkdp46Bc2KSRHVMy+7O4hRcT8vHJcbfwy+ay9JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVRupEHxiYom+9sYZom32b064yXabayuuRnkPBMKH6aId3IENrkxwD0ugk1VLd2hV9WkAgHZtriAM7q+woOc9+c0+x7QF1icQAQK/JpkUiU5M1TmN2Aj2H64y4FYP1c9LNtH+d2ulP91GxsmQtHT2VE8OhN5iBP5rsEq5JgMQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFqiW3WG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5FA8C4CEDE;
	Fri,  6 Dec 2024 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733501408;
	bh=p+mFtkdp46Bc2KSRHVMy+7O4hRcT8vHJcbfwy+ay9JI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bFqiW3WGqhk+y//dResJRlcc4u72A6llMkRkLm517BL6xLa9BIltlLL7kP7haYiO6
	 AdpbZbwSgY1WNpVRBuafcdJjSmVaboWKa6Bl0CljZ1UPOynGRhvauvVcPXlu5dphpb
	 cT3jBdSIzWUIxdxSo0z67YuuXX6i9PDZRPEGGalDPWx8XEcwPeNMv8rehQGpeTzX19
	 naoAPIsxu2NNud0Kfd2OOlHAyzMkBH1MKoXeb4+WTL+epHn11PV9KDwPVJIyCA0qki
	 4sZyvc7jxoaXWZTEDIg036YFJSW8V7DuTiqxXiwXAaQ4J/DGHqOzdw8IiqZBleMS7V
	 5/Viq069wWt5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A30AE77179;
	Fri,  6 Dec 2024 16:10:08 +0000 (UTC)
From: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Date: Fri, 06 Dec 2024 11:09:56 -0500
Subject: [PATCH v2 1/2] dt-bindings: iio: light: Add APDS9160 binding
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-apds9160-driver-v2-1-be2cb72ef8f4@dimonoff.com>
References: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
In-Reply-To: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733501407; l=1706;
 i=mgonellabolduc@dimonoff.com; s=20241119; h=from:subject:message-id;
 bh=s8BOf2+xEysiHus6S5AKnEPyr04Ihf22SGgL7kxbz80=;
 b=GmZbRng+ZTh0HFgjk+jErvNjcBv38obHewDelhFeT+7Edro5UW8fXXq9qaQ/KmnWAbcmVqI/t
 u5tBhgUlr92BI4G+LK5KB35I2y9lSo0gDLXTLQB3tDeNlHwHzO9A0Y7
X-Developer-Key: i=mgonellabolduc@dimonoff.com; a=ed25519;
 pk=p4tvPfGPfXRyChsgHc6s7HwB6YBl2JqqcP3BXtoDitE=
X-Endpoint-Received: by B4 Relay for mgonellabolduc@dimonoff.com/20241119
 with auth_id=279
X-Original-From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Reply-To: mgonellabolduc@dimonoff.com

From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>

Add device tree bindings for APDS9160 driver

Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
---
 .../bindings/iio/light/brcm,apds9160.yaml          | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..525fba52f156df3b78e24d7d0d445fe9d882eaa7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/brcm,apds9160.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Combined Proximity & Ambient light sensor
+
+maintainers:
+  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
+
+description: |
+  Datasheet: https://docs.broadcom.com/docs/APDS-9160-003-DS
+
+properties:
+  compatible:
+    enum:
+      - brcm,apds9160
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@53 {
+            compatible = "brcm,apds9160";
+            reg = <0x53>;
+            vdd-supply = <&vdd_reg>;
+            interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&pinctrl>;
+        };
+    };
+...

-- 
2.34.1



