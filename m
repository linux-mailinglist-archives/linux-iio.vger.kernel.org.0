Return-Path: <linux-iio+bounces-4207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E28A2F92
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A571F22901
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADE783CD4;
	Fri, 12 Apr 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB0065Ft"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F984A45;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928971; cv=none; b=aKapT30n4QnHzJdfWW/ktgdXPgzE0/dgPibv9N9xw4mL9q6UAs8uZ1yaC41o2CBaICaOdNMrig/i2qWrYVYbWemOxfFZncT9jaFJdrof+f6/lopwqIRaDZNcYjEznMccPMEsRDe/OE0vQklV0UvJaMzMeofc6REZBVd1T7zvnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928971; c=relaxed/simple;
	bh=Hma4I5Io5O44ojPXbryzzwJt6cSmYBAiNPu96D59o+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNcGgtAJ7EtlN7ir/gQYIIxb0fX/Y0hP4mV1gWtANUUBpXUeivjnrLJzpBwbpOaBDhK99hugyEfbKfQD0n7YFk10CPPyJDmDS3Gf2rOmWSLMiFBWMdYIeikuuVl7NycCB19eMdkyvdS/FstDF84zDYiGKgzvmpJQuK/FnVcaKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB0065Ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A8E1C4AF0D;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928970;
	bh=Hma4I5Io5O44ojPXbryzzwJt6cSmYBAiNPu96D59o+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oB0065FtiYO662S9awA3weXm4yh7DdYYSbn+Jtx11KPWWHuo+QCeL2RVyfXqG3IpP
	 RWghF2EYhSbuTEW+xUpThQdf2Cl693fpq7obdYTcn+bDI+lbNkPuFZ+1cuFNGIPidP
	 CxKMLkp8e3RolBAkTKMi/pnphtQl56jKWUynu6i/qjEfXBEODTA3ceINJPey0Y5uBp
	 M58MiQgkXF5lLY14DRxR/0nILSjx7Id6Ft1KsH7uy72pdKgAb41CiLG9+Se7GSzVUy
	 ZewJvHQcTG31yOXHtQkC98ToFtFifs5M6xbsNV1bhvToqPcY1oHw4blsmDOiyTmeys
	 NNHdosVllNR9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A51C4345F;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 12 Apr 2024 15:36:13 +0200
Subject: [PATCH v3 06/10] dt-bindings: iio: dac: add docs for AXI DAC IP
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-iio-backend-axi-dac-v3-6-3e9d4c5201fb@analog.com>
References: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
In-Reply-To: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712928968; l=2630;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=FdMLzMkvL57/YP8OzEvNAFMyt7a4ot7qTYl6WFcDWew=;
 b=JVtSOyq6VBhjei69BfsSWCgcLi2HfcacKM0A5r8MfKRzlZ0lZAjudxQAKwjWhlQOObhe0pm8e
 E+YF/l2b3vDAcHzpkEjbWvyo0tknpiq2dL/3IfQJAKwXrE2BajZCzkV
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

This adds the bindings documentation for the Analog Devices AXI DAC IP
core.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 62 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 +++
 2 files changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
new file mode 100644
index 000000000000..a55e9bfc66d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,axi-dac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI DAC IP core
+
+maintainers:
+  - Nuno Sa <nuno.sa@analog.com>
+
+description: |
+  Analog Devices Generic AXI DAC IP core for interfacing a DAC device
+  with a high speed serial (JESD204B/C) or source synchronous parallel
+  interface (LVDS/CMOS).
+  Usually, some other interface type (i.e SPI) is used as a control
+  interface for the actual DAC, while this IP core will interface
+  to the data-lines of the DAC and handle the streaming of data from
+  memory via DMA into the DAC.
+
+  https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
+
+properties:
+  compatible:
+    enum:
+      - adi,axi-dac-9.1.b
+
+  reg:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: tx
+
+  clocks:
+    maxItems: 1
+
+  '#io-backend-cells':
+    const: 0
+
+required:
+  - compatible
+  - dmas
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    dac@44a00000 {
+        compatible = "adi,axi-dac-9.1.b";
+        reg = <0x44a00000 0x10000>;
+        dmas = <&tx_dma 0>;
+        dma-names = "tx";
+        #io-backend-cells = <0>;
+        clocks = <&axi_clk>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a7287cf44869..2137eb452376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1399,6 +1399,13 @@ F:	sound/soc/codecs/adav*
 F:	sound/soc/codecs/sigmadsp.*
 F:	sound/soc/codecs/ssm*
 
+ANALOG DEVICES INC AXI DAC DRIVER
+M:	Nuno Sa <nuno.sa@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
+
 ANALOG DEVICES INC DMA DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 S:	Supported

-- 
2.44.0



