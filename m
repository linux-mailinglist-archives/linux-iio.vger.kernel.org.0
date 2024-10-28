Return-Path: <linux-iio+bounces-11531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D19B3D4E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 23:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E5028878F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 22:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFEA2022DE;
	Mon, 28 Oct 2024 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="NWKDl0BQ";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="hG5M6j3Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A78520127B;
	Mon, 28 Oct 2024 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.34.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152421; cv=none; b=IkfMzPZEezkh30/6L9i3GPrzo7N2o2hYptWiKf0Bz0i6XqLHGFRcwRoRJej1Ir5eYRhVb9UJ17gXkhdHdFgwAeirhNRUZgCjO1eLPJ0VF2pDx7Seoo30/FNkMugvDFCVa6kXF0rrJfCiYsn1rc9PF4UMTbWYKt4xqKzVkDVifVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152421; c=relaxed/simple;
	bh=ojKSNyD2EVe/IEDwrN7wNa8IQCtyeU4dv9gi0XQu3WA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kka2Cx8l1i+XLNEYvHdvAqFKTzz/MRqMDp4xvK/Ip49LHGBJrmU43W3F7PIpi63VTRfA1O8bapstSLzEXyZRcjZr6dPPc22eF4H+cmZO/fdnsu2RHY3eL0bxwOQUHpxHJD4GxIRPDWj3h36CnPt6vwDk3kPIkUb9EkGIi6un28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=NWKDl0BQ; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=hG5M6j3Y; arc=none smtp.client-ip=195.201.34.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
	by kernel-space.org (OpenSMTPD) with ESMTP id 02eb03c8;
	Mon, 28 Oct 2024 21:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=s1; bh=rGdPirXcfMFi3svLNfW1afxz7ZA=; b=NWKDl0BQr7clLQriRb
	XpMVO6VIPjBY/FjZfDHgSq/vIyr79isjtBjSoxkjoHM6pZQvOSxMZvAFMmzQiQxD
	YQ8F49gx0ZMPjHL1TB+bADcExvpIyUfdvJecyLxuxA/ATB6IkN0ArEE+0qt40M/0
	Ny173Zml1y8JDn6IdbRYVUDV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; q=dns; s=s1; b=e77Lds/CGnP8Ku1a/JXZPGJ6C/+9AfMbiFbzOu7zQnw7
	UWa9C2k6pZpVs5aDdQxms/pK/LrdgADrq7f7ixtGUwYAjCLaRVkkhgLisf/JEJ3g
	qr3sUKuycanbqtFfG3P1sgBv/L0IHn8KnD316gDVbtm8PS0mpbJt5ABfwAHev4o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1730151473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6D/EkgzRCNFr6KoXbaTUBYL2k31iFO9iPQDbeDyGB5w=;
	b=hG5M6j3YpReZdytRYN8Zgff+nXp8cSef+nrsRVfgxlQhDX49a1llr0X71QXmOuuGPWtMbM
	L2fijnkkvQHmd2V0IYrFDk79toa9LK58P7D3jX0spnodKdOrzXK1Z5d713ypKpOacMctJE
	szFDWr507cjYN7HLFjFT6Wzr58yAFEM=
Received: from [127.0.1.1] (host-95-245-34-85.retail.telecomitalia.it [95.245.34.85])
	by kernel-space.org (OpenSMTPD) with ESMTPSA id 2eb49e81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 21:37:53 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
Date: Mon, 28 Oct 2024 22:45:29 +0100
Subject: [PATCH v9 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r axi
 variant
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-2-f6960b4f9719@kernel-space.org>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
In-Reply-To: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
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
index a55e9bfc66d7..1adba9aceeb1 100644
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
+    items:
+      - const: s_axi_aclk
+      - const: dac_clk
+    minItems: 1
 
   '#io-backend-cells':
     const: 0
@@ -47,7 +56,29 @@ required:
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
+        clock-names:
+          minItems: 2
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
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


