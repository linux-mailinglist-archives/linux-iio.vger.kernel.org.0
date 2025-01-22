Return-Path: <linux-iio+bounces-14538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1F5A19B1F
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 23:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 866167A26F5
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 22:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E481CBEB9;
	Wed, 22 Jan 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytnc3MpH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3581CAA66;
	Wed, 22 Jan 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737586781; cv=none; b=KkKMxdIugQpfCnbAC7EV2KQThkCdcagyXN46nTJCPcVOEZoC8jJ/qxhK0ovLCD2eBATEHF0vUmomW5sWT6uAI6O9xeMBo3YpbkAgdo4ZtMhjJJ3gP/aLnWZ17f4tCzjsuZmweB8dwAFgSXZqgYCJuvL3PixLZSLn9qTA+iamWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737586781; c=relaxed/simple;
	bh=HH+mzIWNRJ6mwaIxEqdaYZOxqHZ1ytOzSJjW0HOyCkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lazGlfDuvC+W1wbePZ5hwDIt5LjkgNcOARN+glvV9xTSKmt4QeUBBDAvE10SxLpH8ITj6tMeLQCJkFOsEn/T4NbmWj5jxzWdPlVXdQj+cy5gzGpCFMiG3xejH0yOiGexgf7PwcqO1xP/0bmXhhZsVLg8KLBYXcSlIS7lNJk7+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytnc3MpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52152C4CED2;
	Wed, 22 Jan 2025 22:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737586781;
	bh=HH+mzIWNRJ6mwaIxEqdaYZOxqHZ1ytOzSJjW0HOyCkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ytnc3MpHq2aSLyZ4kzSh/htN9nksBMV055Y+8+VK5yKfprEAyR+/gPb1adyjhyLG0
	 ghU+1H/rROM6DFW/U/JH+PPT9UjgoFnK2D3CA8T7ncByM6xr/FuxXQJMfHpx4n4WZL
	 upHNZeDd0IYxvFkKB9JR07LXNCueVDZgGYYqn7L3ysqgQW/c26JO//UnCogumc4bWk
	 YxvS6NGjae+1VxS2YVyxYkPL8CCafxx71MsEzlm20yd+RFJPD89OV4GFtF8pwv+jd4
	 7I5ddPSUG4/AsS+dsxEVjnXsI1O39ZscgKDGPwC6DpmxQyv08dFuAGAXn71D7z/qie
	 kdsN73mXCNCLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466FEC0218D;
	Wed, 22 Jan 2025 22:59:41 +0000 (UTC)
From: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Date: Wed, 22 Jan 2025 17:59:33 -0500
Subject: [PATCH v5 1/2] dt-bindings: iio: light: Add APDS9160 binding
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-apds9160-driver-v5-1-5393be10279a@dimonoff.com>
References: <20250122-apds9160-driver-v5-0-5393be10279a@dimonoff.com>
In-Reply-To: <20250122-apds9160-driver-v5-0-5393be10279a@dimonoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737586780; l=2849;
 i=mgonellabolduc@dimonoff.com; s=20241119; h=from:subject:message-id;
 bh=hKuTDSH0XmEpjVDIx28SQC5NbWNqqOrY7dOGPzuivBA=;
 b=Fq41pZdHJ4spxfLxY1i88NGOEHaoEpjQQ/622cMdXQlnIRCsHITrR7WwyfmQbtn6De/SFp7CE
 bvaottf/hJHBe2HzYngxx70A7rv1YbcjP4PO9lldmPy5p3+wK/vlCR5
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
 .../bindings/iio/light/brcm,apds9160.yaml          | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..bb1cc4404a55760d3f2ef3818d8f5c14782dc5b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
@@ -0,0 +1,78 @@
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
+    description:
+      Proximity sensor cancellation pulse duration in half clock cycles.
+      This parameter determines a cancellation pulse duration.
+      The cancellation is applied in the integration phase to cancel out
+      unwanted reflected light from very near objects such as tempered glass
+      in front of the sensor.
+    default: 0
+    maximum: 63
+
+  ps-cancellation-current-picoamp:
+    description:
+      Proximity sensor crosstalk cancellation current in picoampere.
+      This parameter adjusts the current in steps of 2400 pA up to 276000 pA.
+      The provided value must be a multiple of 2400 and in one of these ranges
+      [60000 - 96000]
+      [120000 - 156000]
+      [180000 - 216000]
+      [240000 - 276000]
+      This parameter is used in conjunction with the cancellation duration.
+    minimum: 60000
+    maximum: 276000
+    multipleOf: 2400
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
+            ps-cancellation-current-picoamp = <62400>;
+        };
+    };
+...

-- 
2.34.1



