Return-Path: <linux-iio+bounces-13939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E2A032A9
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 23:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CA41881462
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DFD1E0DFE;
	Mon,  6 Jan 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI1JsOon"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BC1E00A7;
	Mon,  6 Jan 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202207; cv=none; b=JVctHfhVntLUp/tYvZnAsoJEJLE9LQdx1XUw+rlsWXJkqWc3fpqv+X3HBC3V8pQOFkDD1/BTX/9/rtNNai5YfSZKpw2qRRFdKk0yiCEPiEa5IE/uI0Fcfc0eiNg4KFrgPk+n83SNHWz4KQ4IKb7TtQQ8kpn27JDmmY215zjLA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202207; c=relaxed/simple;
	bh=h25M0H3uswfaky+3y+Jmk1p5vYjzct3YzQC32EL+EfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RK+vY33k+VE4Pdpx/MNOgTKOmBdYFi1PUUH8AsZfAcmAwJCajlY6nAG42A4NbbOuZ7By6gul31CtN7ImY88/kknGZ+dWae8Hk+GwCdWWnFYX6FN7sSqs7pfIV9qT1IFPMz658BUmNMdFWTVcZFEIiuVrXpgcmk9+g91JuieSrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI1JsOon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49E4DC4CEE0;
	Mon,  6 Jan 2025 22:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736202207;
	bh=h25M0H3uswfaky+3y+Jmk1p5vYjzct3YzQC32EL+EfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fI1JsOonWpNpsI0mjxzVGoRaEi4Lx5Q3sbqfMRoA8cn/veZu1Tg5wXmGF/fCjR53F
	 EBhV4KTo85HHiynh7TKqGRb0zUeMEI3SolIDn8T7M1cFgj8ODj+xkMoOoQFRHn2x1z
	 /yvVYNSm8CktVNMAu7OFPr6RRWYepEqAlovgIQXVuUoXbYegwVo41O9biZwZLQpAvo
	 tXOmhbkVazv92XDASTG1qBxda+uEnOUJLb56cAu1ZGZqAdMB2BThNdrFv4ByjLbYAN
	 3k1uFoaEwZgLGCH2N6d7nyy2Pkey9Nn31cYBaQrrigTTGvXnO965W0DH/2AhEKIcs/
	 wJD//bo4DeDrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC86E7719A;
	Mon,  6 Jan 2025 22:23:27 +0000 (UTC)
From: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Date: Mon, 06 Jan 2025 17:23:01 -0500
Subject: [PATCH v4 1/2] dt-bindings: iio: light: Add APDS9160 binding
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-apds9160-driver-v4-1-f88d9fc45d84@dimonoff.com>
References: <20250106-apds9160-driver-v4-0-f88d9fc45d84@dimonoff.com>
In-Reply-To: <20250106-apds9160-driver-v4-0-f88d9fc45d84@dimonoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736202206; l=3144;
 i=mgonellabolduc@dimonoff.com; s=20241119; h=from:subject:message-id;
 bh=5cjoIlxIfdxZzO285dr70gowFfgQf88mZbe3zubuBNA=;
 b=XLuFgZZCjk1ljxYTZVvOTIHVpus2PKGE5d1JU+gAQo2jes9r0QjP/9B2UU+cTqAW9wAYmZCPp
 Wy8zjYVMHZBDB7rJ1noavmmkWb4ccySN86HzmoUYjKXFZjksSmoxCPc
X-Developer-Key: i=mgonellabolduc@dimonoff.com; a=ed25519;
 pk=p4tvPfGPfXRyChsgHc6s7HwB6YBl2JqqcP3BXtoDitE=
X-Endpoint-Received: by B4 Relay for mgonellabolduc@dimonoff.com/20241119
 with auth_id=279
X-Original-From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Reply-To: mgonellabolduc@dimonoff.com

From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>

Add device tree bindings for APDS9160
Note: Using alternate email for maintainer

Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
---
 .../bindings/iio/light/brcm,apds9160.yaml          | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..756d46c2edb171da840ee49a7339cb781fe84ad2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
@@ -0,0 +1,86 @@
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
+  ps-cancellation-duration:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Proximity sensor cancellation pulse duration in half clock cycles.
+      This parameter determines a cancellation pulse duration.
+      The cancellation is applied in the integration phase to cancel out
+      unwanted reflected light from very near objects such as tempered glass
+      in front of the sensor.
+    minimum: 0
+    maximum: 63
+    default: 0
+
+  ps-cancellation-current-coarse:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Proximity sensor crosstalk cancellation current coarse value.
+      This parameter adjust the current in steps of 60 nA up to 240 nA.
+      This parameter is used in conjunction with the cancellation duration.
+    minimum: 0
+    maximum: 4
+    default: 0
+
+  ps-cancellation-current-fine:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Proximity sensor crosstalk cancellation current fine value.
+      This parameter adjust the current in steps of 2.4 nA up to 36 nA.
+      This parameter is used in conjunction with the cancellation duration.
+    minimum: 0
+    maximum: 15
+    default: 0
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
+            ps-cancellation-duration = <10>;
+            ps-cancellation-current-coarse = <2>;
+            ps-cancellation-current-fine = <10>;
+        };
+    };
+...

-- 
2.34.1



