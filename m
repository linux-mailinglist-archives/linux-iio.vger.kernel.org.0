Return-Path: <linux-iio+bounces-27457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E69ACED272
	for <lists+linux-iio@lfdr.de>; Thu, 01 Jan 2026 17:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8235C300ACD2
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jan 2026 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395662ED85F;
	Thu,  1 Jan 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6l8kBWz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B021FF23;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767284293; cv=none; b=IZDhqBnhjUjqcCRy7COg4KAQAJCMPIyLQ5Su6e4ZR7UKiWdW3/LCj6shf1+0snjXSifXv+zAcS3ukLoAgCAOPNlQQbJvV5v5ti1fE7yUEq9NYyE+UDibmCIemltam5BMCAmn8d5Zp/XP6FBjG50KlUv4Xe7HjxNOIMMqfgIU7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767284293; c=relaxed/simple;
	bh=Mx2p707lQguqjpJp/MylxYZW2GopeXvIoHFqyoaw+1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTZCjkOXS49InLLHs8qvBR5sx6OlvgUWywPaaEGicRbW2J3LVM/v/zi1aweqPGEmADWyAP0Ed1M/Ao6B3hcImvVtcnfeq3RaI+mPKmIpmPkBt52tmqNthXh5Wr0Tu1zpyXynqaCu6jvp3l3JSvM2gK9H5tm01tI/ZJxx/U0dIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6l8kBWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F488C19421;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767284292;
	bh=Mx2p707lQguqjpJp/MylxYZW2GopeXvIoHFqyoaw+1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T6l8kBWzorv2rv249iTzQPyRDW+zq//2S4d6/VDUm0tSgjZGH/ypDAeIdKKkfuQZA
	 hev2q/0iam0+RqxY2IsOBZ4cs9yyxvVC/0ZxWYtZehSFZCrpEsEvTV+6ZoDZV13hk5
	 oUZ96AlRKeq0zkGarv1DWgaFUs3sy4LnEv9/ZXRJcO0zTqrSlKW5IUIE3H+DkoBD81
	 Ms6lOy8zmxBUJNXkh6mIP5nx6K9BRKSBm2OMmkMxF2ydL3L7sAKfGk0s/2F5oDBKo3
	 CuEH8oMDMv0I8UqwPRUUTzE4ruJWTJJKjp7di2f+42clNR/ZR7nOoGejC86Tfp542X
	 WNtqOoy/e+POQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518EEEEB579;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Thu, 01 Jan 2026 21:47:38 +0530
Subject: [PATCH v4 1/4] dt-bindings: iio: proximity: Add RF Digital
 RFD77402 ToF sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-b4-rfd77402_irq-v4-1-42cd54359e9f@gmail.com>
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
In-Reply-To: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: raskar.shree97@gmail.com, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767284290; l=2840;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=OVYVzLMgPVMO/XnImN7RwZfXGcsHmKgD/1eOSTZgZaQ=;
 b=kIZPx5FzhAN7jjdlvkZ8JEn43fuXoqi+SyBOinIPl6GRMa65POu3IIEjE5Vf8vc83Lb94d7T2
 75OjkeqXlXaCpTBAzOFattW3iO+EcD7CMA03lslwPSituzH5Ch3yJmZ
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

The RF Digital RFD77402 is a Time-of-Flight (ToF) proximity and distance
sensor that provides absolute and highly accurate distance measurements
from 100 mm up to 2000 mm over an I2C interface. It includes an optional
interrupt pin that signals when new measurement data is ready.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 .../bindings/iio/proximity/rfdigital,rfd77402.yaml | 53 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
new file mode 100644
index 000000000000..1ef6326b209e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/rfdigital,rfd77402.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RF Digital RFD77402 ToF sensor
+
+maintainers:
+  - Shrikant Raskar <raskar.shree97@gmail.com>
+
+description:
+  The RF Digital RFD77402 is a Time-of-Flight (ToF) proximity and distance
+  sensor providing up to 200 mm range measurement over an I2C interface.
+
+properties:
+  compatible:
+    const: rfdigital,rfd77402
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt asserted when a new distance measurement is available.
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor.
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@4c {
+            compatible = "rfdigital,rfd77402";
+            reg = <0x4c>;
+            vdd-supply = <&vdd_3v3>;
+            interrupt-parent = <&gpio>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c7591b2aec2a..59ac4f0756d9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1361,6 +1361,8 @@ patternProperties:
     description: Revolution Robotics, Inc. (Revotics)
   "^rex,.*":
     description: iMX6 Rex Project
+  "^rfdigital,.*":
+    description: RF Digital Corporation
   "^richtek,.*":
     description: Richtek Technology Corporation
   "^ricoh,.*":

-- 
2.43.0



