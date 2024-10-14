Return-Path: <linux-iio+bounces-10555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD8A99C6C8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 12:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49521F23A95
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D415F40B;
	Mon, 14 Oct 2024 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ww1UpAU3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A644F15B149
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900581; cv=none; b=mjZHdKcgLr4S54iNzvk1aX4ugy3nKUoUqOf4Wtu2r/HQGEm7+g68XYBIfwGPGkJ1LQif+V9mQSnmQFKBCy0kEzeo9wkz50FV8aB3LWNIk2deViyDa1hLY5xAxEg/XPrQx2K++gTy+ZFrtyIzByT3IV2rC5H2F5moA+zHLODpdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900581; c=relaxed/simple;
	bh=uoHMnV5Wh/cV9BF+m1H4xNlkd4/edJi53oHGrY5YMZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVaeYfNXEbsOYqVuIFq+VtJhSuOVv60q58spRo5UXGdT/U3EKgxZh9dlyWXgxT+bLU42/05F1slljiG05UYad5ud2rk0gPH8wfW4UssULN4QZnDcFLYp/yXYmAQPUVWQy4Or809/I5U0eGsV8oG6sOQzXm3F4nc+07vQuTWN6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ww1UpAU3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43118c9a955so33214105e9.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728900578; x=1729505378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oozEsfNKHc3ASbI+w0+td38AjwSs+TxhbfmgD2nw9DE=;
        b=Ww1UpAU3hgD++grFWSZT1KBJNH6qZb84oW7pAqNb2eoNLzRMQKfWeMoWyIVKJEX8eq
         9H9egzEYnNlOk2lpVU9llGlqqGM8F38QnCYIrbxewR56yiH6OT2S9UulZIeK3OYbzngf
         wCC3oQvzBc8LqwI7WuvC4oNPdTw1eI6TM0ZYuOh9RtkHtYAjxsnvXE3cYFe4VZFltebW
         uWM2iBR6vyISvrixHeN8uEKWrVfEZk04ZR1YN1bk4MqSIV/vdNcpWYUZVpvMYbP+4ABS
         IPEH0IdlplWxPlm42aVQ7szVPjd/vIV3mH5hboi3Db3yKWJkY6t03kGJh6AiL01qD6KB
         0Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900578; x=1729505378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oozEsfNKHc3ASbI+w0+td38AjwSs+TxhbfmgD2nw9DE=;
        b=Cif12gSOoq4sQwVBg4kzFIdbS3SFbH2JAlgwTIrXDMGR4iBvSroUcQyuIt0Ufn9XoG
         y91G5HmfKvGeHEQ041KjNN0/Chwnr3p5im++ibYIO9SnhIl5xI24S4S0jrdFihwarSBQ
         wzO7wP9HC5YNw/8I0MoWbHXIW4tGKdfkxjaI1W/IwdrhUtYDtjXWXZpueOXh7SxiMYVE
         zc0/e5Z9xZMj54YjsxyhJNxboBJyQlCxQogjjq11nVJ3SXx1wL5v7qsBOYO22ZVYNDVT
         RKos75t/2xP6pFeeYhsbHmrcEPq4kRWfjyyLVnKBs/ASyzdp1v/qe9SYcnJv9Gt2dXOu
         bNTg==
X-Gm-Message-State: AOJu0Yz18Dx4Qg71RuOSxvi9QEtXVzSuqnZ4dy2KqmwlzH5vblP4XjRN
	LVT9pfZcrq6ifTo1zbkNVaPweH/Aukg3PDHoLw9ZWIbFPlmPlrjqOKYyOaX+Rbk=
X-Google-Smtp-Source: AGHT+IEr5J2wMmbUCknyQzE7t9x2824FmvwZIIokY5xO68FSwoplQkqTc834qCmRBEewrgocOsqADA==
X-Received: by 2002:a05:600c:480f:b0:431:255f:57e5 with SMTP id 5b1f17b1804b1-431255f5820mr54981685e9.18.1728900577915;
        Mon, 14 Oct 2024 03:09:37 -0700 (PDT)
Received: from [127.0.1.1] (host-79-45-239-138.retail.telecomitalia.it. [79.45.239.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee0afsm10969352f8f.102.2024.10.14.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 03:09:37 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 14 Oct 2024 12:08:08 +0200
Subject: [PATCH v6 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r axi
 variant
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
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
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 56 ++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
index a55e9bfc66d7..2b7e16717219 100644
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
@@ -36,7 +38,14 @@ properties:
       - const: tx
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: s_axi_aclk
+      - const: dac_clk
 
   '#io-backend-cells':
     const: 0
@@ -47,7 +56,16 @@ required:
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
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -57,6 +75,38 @@ examples:
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
+            spi-max-frequency = <66000000>;
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


