Return-Path: <linux-iio+bounces-10859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61619A691E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD892B292D6
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63B91F708F;
	Mon, 21 Oct 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DyNcZWJb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368541F4FAA
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514501; cv=none; b=Ut98AA6bL4HOXnDGlhHrH9yOImJdO62x5QjM7UPB+dnm2txEPhI5ioTbrIhxkSoaMDzsZrCA7FrvrWC4P+DsdCXDStNz1V220ymRnmfQR/990GPGHb+W57Hw87J4XnJHutSqGV8gNco8koP/i54nOI0lGu9Cah81q4kDkeeBkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514501; c=relaxed/simple;
	bh=817NpBhsFo0YO53ztE+JzVAnUTKLGkw9f/63H82CZCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5ISms9MC1M9dSNuKiOYn+N0Sqkhw4GdWd0K2naIsSqpjR3GSPsns39Ucv6Re2t6WZNncIxo7Pu3yB3KYtUNk9rbuPU2CguOqeI81RUXzMmpj3gi4sfxLR4SeYjbeEL/qy/hTSf34q0qkqW9et3PSVcb0Exb0vUpVeaDShIcRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DyNcZWJb; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4315eac969aso25550955e9.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729514496; x=1730119296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF/r/TVgTeqXnk6myjMpZwlua4wzhd0TmK63kcaDYtM=;
        b=DyNcZWJbFD2T8bSrN7tWGMXzDPOUINLi4fgnlzl3cb8p+aQZjlBmECM4MDXP6v4JPi
         ckMmnY95G8xvs5UQeJGWDiFHFl+uN+JS+40BaD+Yv93yDXA4a4Ge0gP7j5Myy6sOPZJZ
         FKjZ8CAGZfNCjv4DKs3KAZ+efdhulJrs8IRI0cS6jJeGK92wgk5GU8xC/0mwX/rCGILY
         VcetdDnAvuQojw6yIpwNXhgGcF0lOCRGJtBl23iKpFNVZAsm4V6aem90kHgXnBAxsYK8
         ocf9ZQariqI+Sgj/AGYY8FnDz5I2p4MPq+7uH2tf4I8cCFdkDOgbkkY7kqj4CwihZDmV
         /BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514496; x=1730119296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OF/r/TVgTeqXnk6myjMpZwlua4wzhd0TmK63kcaDYtM=;
        b=V+KsJsmhjO9+SsPwf60D2tMwp7WFq88k477f/Wf/zGn1A0epsHY1mkmTfrOCQvZQfW
         O189W2NXERcAYMt925RD096W/OR7OXW6b2BDc7wtepIr6foDkcOwFkbTW431xSvREEcp
         DNx1EG8Y49APcsqRtxy+KKZmpIN//x6GK2fz7YmOZZtS5y4kceKV77bZiNSgKQ9IJPKB
         JbzzCFS9bOTlmwbkN9c28Chdp9H3dQSb7Np+hutVEa7CNQFZIKsPZftvzx4q9feFxLMK
         wf6qJjQJrAcV+X8R0x5Dr2cq73sTmIKbbIh7mVQnd/hWgYQFXPZy+J+wFx2/jke0k0Re
         hNJA==
X-Gm-Message-State: AOJu0YzMgDbETOPAGLJ+nbl0vA/1EGrvMcyervzuHQRynJzKKA79nsSt
	stpLXh32aCXoyOSxEc/fMOy5ihAamm4s138d1++4TodbTSiP8QtBxba6KqFD6/U=
X-Google-Smtp-Source: AGHT+IEMkFGQDUO6rCKtdIXPp9bv0uuyQ5w3XqgBV6SjsYDRwmMNFrntGTMMxswg7d3SpT+bbCIN/g==
X-Received: by 2002:a05:600c:4ed2:b0:431:57cf:f13d with SMTP id 5b1f17b1804b1-4316161dcc1mr69586315e9.3.1729514496272;
        Mon, 21 Oct 2024 05:41:36 -0700 (PDT)
Received: from [127.0.1.1] (host-82-61-199-210.retail.telecomitalia.it. [82.61.199.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc88esm55996075e9.46.2024.10.21.05.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:41:35 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 21 Oct 2024 14:40:12 +0200
Subject: [PATCH v7 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r axi
 variant
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-2-969694f53c5d@baylibre.com>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
In-Reply-To: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Add a new compatible and related bindigns for the fpga-based
"ad3552r" AXI IP core, a variant of the generic AXI DAC IP.

The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
generic AXI "DAC" IP, intended to control ad3552r and similar chips,
mainly to reach high speed transfer rates using a QSPI DDR
(dobule-data-rate) interface.

The ad3552r device is defined as a child of the AXI DAC, that in
this case is acting as an SPI controller.

Note, #io-backend is present because it is possible (in theory anyway)
to use a separate controller for the control path than that used
for the datapath.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 69 +++++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
index a55e9bfc66d7..0aabb210f26d 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
@@ -19,11 +19,13 @@ description: |
   memory via DMA into the DAC.
 
   https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
+  https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
 
 properties:
   compatible:
     enum:
       - adi,axi-dac-9.1.b
+      - adi,axi-ad3552r
 
   reg:
     maxItems: 1
@@ -36,7 +38,12 @@ properties:
       - const: tx
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
 
   '#io-backend-cells':
     const: 0
@@ -47,7 +54,31 @@ required:
   - reg
   - clocks
 
-additionalProperties: false
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,axi-ad3552r
+    then:
+      $ref: /schemas/spi/spi-controller.yaml#
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: s_axi_aclk
+            - const: dac_clk
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: s_axi_aclk
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -57,6 +88,38 @@ examples:
         dmas = <&tx_dma 0>;
         dma-names = "tx";
         #io-backend-cells = <0>;
-        clocks = <&axi_clk>;
+        clocks = <&clkc 15>;
+        clock-names = "s_axi_aclk";
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    axi_dac: spi@44a70000 {
+        compatible = "adi,axi-ad3552r";
+        reg = <0x44a70000 0x1000>;
+        dmas = <&dac_tx_dma 0>;
+        dma-names = "tx";
+        #io-backend-cells = <0>;
+        clocks = <&clkc 15>, <&ref_clk>;
+        clock-names = "s_axi_aclk", "dac_clk";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad3552r";
+            reg = <0>;
+            reset-gpios = <&gpio0 92 GPIO_ACTIVE_HIGH>;
+            io-backends = <&axi_dac>;
+            spi-max-frequency = <20000000>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,output-range-microvolt = <(-10000000) (10000000)>;
+            };
+        };
     };
 ...

-- 
2.45.0.rc1


