Return-Path: <linux-iio+bounces-27976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D32D3B3D8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53EE5307AC70
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A13329369;
	Mon, 19 Jan 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjAB33Uy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBA320CCF;
	Mon, 19 Jan 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843159; cv=none; b=fsS5thjUIViSKlQVEou22CE6ZKkkzpJf6pk4L5QMPvFg2G64BVXzauFbLrq6U9iivV5AWW/Kjtd4SkFvv6yugXXw7ol3GeMlvl2UBLOmivXYoPl+T8sXs5CJkR1Yn6QMCZIpa4GZmWQpCBeaglWOGVD9AUF7TemVOxEYq/m+VMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843159; c=relaxed/simple;
	bh=vgsWMnalXEzctyb/qHwzwgoCbMWvv9mKKThKgNHGnPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5uaJJRDYjYGo5ymLz1vbgSmEzjUuNU1ezsruNiW8z7+uYL4rkd+KH+FQqe0rp6sgqdevI/5Yzg9WBGtXNzRzpXOeMmWyxJU0V1etmOvMA3PDrq7W+gu/hkY0ajMnremKFQirYo3ZV2Z3NEiO0wmnKoJ6gkJChVsqsYXWD6Jys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjAB33Uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBF59C19422;
	Mon, 19 Jan 2026 17:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843158;
	bh=vgsWMnalXEzctyb/qHwzwgoCbMWvv9mKKThKgNHGnPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sjAB33UyurdZCvW+71NpzazGJRn+w29dq+R5jDje7RMUN68KoOf3cbY08Q2s/jS6I
	 ik8+12b0/uSWeXDWed9BXoE6NdBrbKxCfoyHOc65iH0g33FIK4x7siqesFv9sfAwkL
	 ioUEQiPiM39V2/96ornZL2+jxvfhfb8jAiGNNhe1DIPOSs6vt6P4AGBFOQa0xVXe6+
	 x+YG5RHlyQDzMhSKiuUCgQE5nB7TmDlvgP80V6M21E35NJsAe3n6hwq8uveKEIKEUX
	 6JV6AjbgIL4TAWUA9yTQV3hED4rGDyDNt9VK+LbG8a3oY+t2m3QBVdZBIxaELr7sst
	 ytylfrl/+S/VQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED6DD29C4D;
	Mon, 19 Jan 2026 17:19:18 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Mon, 19 Jan 2026 18:19:06 +0100
Subject: [PATCH 1/3] doc: add Device Tree binding for AMS TCS3400 light
 sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-tsc3400-v1-1-82a65c5417aa@protonmail.com>
References: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
In-Reply-To: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768843157; l=2537;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=1LDwA54n0tkYAGyvdpUdaNISfncR1cK5nESUpKkwwc8=;
 b=xKuI+yo90AJJ5IlxvKntYTEmP+ZcSeI/7Px4HhOzYrqfHogJT4MvIE2kGre8uJcqnP0tc2evl
 0Rwcq3WXQmgALu+8yy7Jf0RVMqEoLMdrCGWQsEhne6kaSw+BwLxWCbV
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
Reply-To: petr.hodina@protonmail.com

From: Petr Hodina <petr.hodina@protonmail.com>

Adds a new YAML binding describing the AMS TCS3400 I2C light sensor,
including compatible string, registers, interrupts, power supply, and an
example node.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 .../devicetree/bindings/iio/light/ams,tcs3400.yaml | 54 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3400.yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3400.yaml
new file mode 100644
index 000000000000..2c5a9295af1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,tcs3400.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/iio/light/ams,tcs3400.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: AMS TCS3400 Color Light-to-Digital Converter
+
+maintainers:
+  - name: Petr Hodina
+    email: petr.hodina@protonmail.com
+
+description: |
+  The AMS TCS3400 is an I2C-connected color light sensor providing
+  RGBC or RGB-IR measurements with a programmable integration time
+  and gain.
+
+properties:
+  compatible:
+    const: ams,tcs3400
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt line signaling ALS data ready or threshold events.
+
+  vdd-supply:
+    description:
+      Regulator supplying the main sensor power.
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@39 {
+            compatible = "ams,tcs3400";
+            reg = <0x39>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd_3v3>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 14a06f856b81..ab5307a34180 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22866,6 +22866,12 @@ S:	Supported
 F:	drivers/iio/adc/rohm-bd79112.c
 F:	drivers/iio/adc/rohm-bd79124.c
 
+AMS TCS3400 AMBIENT LIGHT SENSOR DRIVER
+M:	Petr Hodina
+L:	Petr Hodina <petr.hodina@protonmail.com>
+S:	Petr Hodina <petr.hodina@protonmail.com>
+F:	Documentation/devicetree/bindings/iio/light/ams,tcs3400.yaml
+
 ROHM BH1745 COLOUR SENSOR
 M:	Mudit Sharma <muditsharma.info@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.52.0



