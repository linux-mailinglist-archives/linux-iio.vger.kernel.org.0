Return-Path: <linux-iio+bounces-4357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5B98AAA1A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 10:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6F51F22E7B
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 08:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1190D64CE8;
	Fri, 19 Apr 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYf3vaLs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60033EA8C;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515137; cv=none; b=PNDHuYvvZGBVa40afquNy2wbJft0vlqtVPdy2WgCZnKM1cEIDvHPSUcTq/n8WTsyEhAlr9z33sNkdnPhjEf2MG4+DuyM6sU0wEEsd3HYis/5AWHzdFUWm+1wBJStSKmDdr+PTMGthExVjbxL1VxsTKQNelc3E76AA++WEphmSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515137; c=relaxed/simple;
	bh=Hma4I5Io5O44ojPXbryzzwJt6cSmYBAiNPu96D59o+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvSkZxVp7trKWyy0pRflTykppe1aX9A09Rqo1k4CEwONoTP6OB5Pnte05wXxDY0u5Ra53MNaR/nx155824AKM8QAxpj43OmktAaXzAhx0n0X7S14ImDq5vO9ZGyUHdL51Hin+1atsoHmcaYzM6Gm9rKyBCT9MnAZtrvGssY3UbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYf3vaLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F184C4AF16;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713515137;
	bh=Hma4I5Io5O44ojPXbryzzwJt6cSmYBAiNPu96D59o+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KYf3vaLsEtfsdTN6ol/h62nlVf/Tq4QgmHB6IRD4TtmfAEWq1Yuc2S4RRQwjtxEZx
	 llWjPO7K8slsGrZMSkaOgj079cDMGJHh+OJ7SGUQ8Xi1xOz+WCr/zpYoAn2HZ91Xp5
	 kK+4Xy6KWETXbtSSqaJZKUjv7LRzNm0MG6C+NZxBixkHSkwWSpYvI11NA64I7DYNjn
	 MCBdvORh68ruiYok13p0Q/ySj1I0oDEt7g8Lud7ZUze2F+0Gt9UuyaDUAl5/M1+3pd
	 NEvd+NfNrnPEL9V4U6T+bMrJS1Vz/mAFwbN7eavpIw9Gp+xxHxjWnqtJ+gkluzf1Z3
	 CRx91fyz7Znuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588F9C04FFF;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 10:25:39 +0200
Subject: [PATCH v4 06/10] dt-bindings: iio: dac: add docs for AXI DAC IP
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-iio-backend-axi-dac-v4-6-5ca45b4de294@analog.com>
References: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
In-Reply-To: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713515134; l=2630;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=FdMLzMkvL57/YP8OzEvNAFMyt7a4ot7qTYl6WFcDWew=;
 b=FR4HIvaF9dLpdoj0W5HW5Rdz52r0V0MBKdIGSrp2pcdMyYi2qUmX2dkWEtTnJx1E95KAP+BcG
 o097zC9OsdqDtg1tNkrXAcvQ9E4+iSVU1LM7I3TrMBif4vwa6N6EBdC
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



