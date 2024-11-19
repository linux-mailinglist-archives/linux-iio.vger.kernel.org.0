Return-Path: <linux-iio+bounces-12417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814CA9D2F96
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 21:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479BF283A0B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 20:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE681D47BC;
	Tue, 19 Nov 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf1TptUo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440AC1D4325;
	Tue, 19 Nov 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048623; cv=none; b=MxWGr9dCWrQiJJWL3VNEFs+/FY7/Da69EceZFFxeKZDaXFg2LhbsnAI/jeiBZA8FZnW/B47dora2ZwXdZ/1JuHsaY/MIxJuTJbiHp69rpd588XFsSsssBt5mQ++SuD2LgFMbqQJbl3gV9xn/3l6I00T9SV8g0dxN/KS9/rR+zKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048623; c=relaxed/simple;
	bh=i68iW+parOS79i3ESk+0cIwlSL9iGwQ4/QtxIsSnGvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZMmi7+6n0ZeSB3HonHRnuPhk7pry7uGjM/b1sBZj3/NbLqQitG48DgfoJNfyb5GydrC1cngIfYAdzbD43+SRKXB2q5P+ikS7T+IhOe1eS3t8mZNGx6Pbgswvb7x1hjXAlJsTI18qQAk1Hw6VLQL7jAmBBRlN7ebyvitfA9rvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf1TptUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E622DC4CED6;
	Tue, 19 Nov 2024 20:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048623;
	bh=i68iW+parOS79i3ESk+0cIwlSL9iGwQ4/QtxIsSnGvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pf1TptUoQSa41NnFTw1MUMhpgu1l8WZT0amACyC4rIxTiG9sPAL4KJGacH6MbU6vC
	 UpEiy37wptiQai24BCpm7qKRhsKUrsCP8ccmfnF+fKTpc3zdLd3eGPB2TzOIhTpg8M
	 ecytBfkLvJpL1rSNk0C0sYZWHln8ktvh3vzVDHelbBE+BvvnLPio7rIoreadAnbDPY
	 e9bLXl3AfNIumgafA7lrp7bCyTnHCCnrUFHwQq3tFC029naGMq2GGn0BYPzrysHhjO
	 dqGzBS0P+uZMqI4KTbEuQWI6hlRWxI1VDFNVKW3HuGjl3YAXLdNJomdYgMsqpfFVZ6
	 yclHoiDR2zfsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB78D6C299;
	Tue, 19 Nov 2024 20:37:02 +0000 (UTC)
From: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Date: Tue, 19 Nov 2024 15:36:56 -0500
Subject: [PATCH 1/2] dt-bindings: iio: light: Add APDS9160 binding
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-apds9160-driver-v1-1-fa00675b4ea4@dimonoff.com>
References: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
In-Reply-To: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
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
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732048621; l=1677;
 i=mgonellabolduc@dimonoff.com; s=20241119; h=from:subject:message-id;
 bh=MyhZj/K793WP3q4NesJzysEVuCCKb6IcZKJIuThoJ/Y=;
 b=vjNvPdct8qXA1+JHHHHkGD75WVzMdskg5mJkJne7yODyjuOPp4cmXSFLAJ7q7oq9jfrAIYgj/
 UXBRSVznXPRAPeuyq0UnghbHSeSh/i3U1v8dDg/lWtgwu95G/+0w5hs
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
 .../bindings/iio/light/avago,apds9160.yaml         | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9160.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..12e196b297fe523e4d324156041ef9c6900676eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9160.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/avago,apds9160.yaml#
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
+      - avago,apds9160
+      - broadmobi,apds9160
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        apds9160@53 {
+          compatible = "broadmobi,apds9160";
+          reg = <0x53>;
+          interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+          interrupt-parent = <&pinctrl>;
+        };
+    };
+...

-- 
2.34.1



