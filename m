Return-Path: <linux-iio+bounces-3860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D6890017
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38171F253A8
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BD81754;
	Thu, 28 Mar 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqsmlT8z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C628063E;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632151; cv=none; b=bG31EeSDTkOjAi+iJxli1JutlF80MKdClApjsiF1LLmDpVmIsemaF5kVEJGry32ddIm3bAaz0RGjMRS5mcM3owQYA8LN7noR+A1GRvegTPne4bEbBlJiTq7Yk3YnDgUGuksQUIz6iCcUb6UEzv4fBsbA9HtCuLsMtI6dHhg2s4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632151; c=relaxed/simple;
	bh=nib2Y7Os2dV/woyZnjR3ZjQ8QPw+xJ6kxTqaC4x5Lo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VSD4cXXgjT4tFTLjkJwrinGinBvp2ivEzqVwM2YIyTuJom2Z6LrOg/utecR3vH4GGGljypnrr3xzVOV25W0kPFmxb7zW2u2y2MF1rEuuBn/D0bMPXOHpLQFLeaK/yva1Iz/+yG7B3NrvOMCXFLDkWuHQGyvJhKiihslf4hKN0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqsmlT8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EB3EC41679;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632151;
	bh=nib2Y7Os2dV/woyZnjR3ZjQ8QPw+xJ6kxTqaC4x5Lo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YqsmlT8zuty3E9xLXykGe8omgN/RIEqWp7pm15vjNjMXT+RB/0blhU8esx+WKeOHx
	 duyRJRwMegzH05wNB9gV0Yjctmq96mtCWkteX/5v5Arh37ph5qv+XmOEEcX73GkGfP
	 JU5A5IP/MnhB4SlYUhIb6Nv9RY9XPVc05x1nK1ZcrxGub/Go3UXutNU0godP29uqIq
	 NjOGTbKojc5XDxuR1m2DnqdP9Zy1EArkUOYj1wicIrwuW2gAiXp6/C4deG520WihKA
	 fMIW6YyxV91jsYKrgr+VbUHdbpGDbumDHFMGTsgYKR6QpNnMGJdP51gi1X2qWSyqEb
	 hkKBt+5hiWz6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B5CD128A;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 14:22:30 +0100
Subject: [PATCH 06/10] dt-bindings: iio: dac: add bindings doc for AXI DAC
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-iio-backend-axi-dac-v1-6-afc808b3fde3@analog.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
In-Reply-To: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711632149; l=2556;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=zVVn2JnKO8KSPJ/lC/YKERxJrRCXPzQ6KY6j3DeQTRc=;
 b=2YAmZQtCOk7TFaRM8YKsa/zmMhqJPrPnyxlQpo3NZDcZX3co7rXYlsQGP2m19xL/pWr79F1gU
 +V8ep35nOU8AQH8VTcC7Hk8GEG3E/jthvmgyUvlssCQ6mYilOkPVwCl
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

This adds the bindings documentation for the AXI DAC driver.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 62 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 +++
 2 files changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
new file mode 100644
index 000000000000..1018fd274f04
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
+  to the data-lines of the DAC and handle the streaming of data into
+  memory via DMA.
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



