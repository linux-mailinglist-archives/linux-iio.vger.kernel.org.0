Return-Path: <linux-iio+bounces-19648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C700FABB4D3
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 08:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615023B6D22
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 06:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE32248A8;
	Mon, 19 May 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="iZQUuzBG"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369CA22422A;
	Mon, 19 May 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634965; cv=none; b=kdFtoCLzHcALohAVMbHS5enxcYXB5cygl/HxmQrz4YPkvKqiLthW9IsjExztIJNtlqZG4B+0OQ9YhFtIkZd9qogeOrfNrEfmDtIj15vc7WiPtMTUMbAizisvyffMMl9my/N3CXooIjfA01TeH59peXIN5vFPOBKS30FeeiYBEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634965; c=relaxed/simple;
	bh=JFXh0UmvB1uXyN+c4SwPO7I3Kv92fk+6q4OTM2LBtxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGCaiNOChwhGT9VY1amYWPgsxah9Woqnx7P4IauFzUqsUtCFPqDaDQelrCqodOax6Yuyl+u5JpJaHHprbG9WAb1Olq09LvIy49mP69DDxjacM0mYKkgwPgeQoMUS2YB72oIw5PRRlqRREFuyG2N/zcb4qeFqmsCcNSFt899LPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=iZQUuzBG; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Z1yjOM7mfQmYrtvU5Bojq8sDhROmKsvPzkPUXkARBXU=; b=iZQUuzBGDLbJ1mtJmmPn0Syzl4
	LYNP3BEhYiARW4fzquSPFe8mXZCeuvDi+wfJR9e6RPeEJjhnSYg61tdMjKd5p8gtPADyft0bcTsVi
	qNW57fTDwJHQQ+mSGRHMOPUfybbH6vnu0vQl99Omn7iXRVQND/juS6Afcr+uowrCbZhMOhvnqLjNB
	45s2agKKXeOwGmfq7qJHyf2uunXfwBliLv89sVc+L6Zsy6Q66dVhimUvGCgiVboGD3AEBcN5SxU8F
	kI+rddbD5p8MGlr8pDseNo7rny5E+U1hEEO5rQDngIVkwV0NEy9FzDeuE1tiIkBwvCFQVciYGuMxr
	xF2T+Eyg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uGtge-000FCn-2O;
	Mon, 19 May 2025 08:09:20 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uGtge-000Ogq-0e;
	Mon, 19 May 2025 08:09:20 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lars@metafoo.de,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	andriy.shevchenko@linux.intel.com,
	arthur.becker@sentec.com,
	perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com,
	muditsharma.info@gmail.com,
	clamor95@gmail.com,
	emil.gedenryd@axis.com,
	ak@it-klinger.de,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: iio: light: veml6046x00: add color sensor
Date: Mon, 19 May 2025 08:08:02 +0200
Message-Id: <20250519060804.80464-2-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519060804.80464-1-ak@it-klinger.de>
References: <20250519060804.80464-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27641/Sun May 18 10:31:14 2025)

Add a new compatible for Vishay high accuracy RGBIR color sensor
veml6046x00.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../iio/light/vishay,veml6046x00.yaml         | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
new file mode 100644
index 000000000000..112d448ff0bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/vishay,veml6046x00.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Vishay VEML6046X00 High accuracy RGBIR color sensor
+
+maintainers:
+  - Andreas Klinger <ak@it-klinger.de>
+
+description:
+  VEML6046X00 datasheet at https://www.vishay.com/docs/80173/veml6046x00.pdf
+
+properties:
+  compatible:
+    enum:
+      - vishay,veml6046x00
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
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
+        color-sensor@29 {
+            compatible = "vishay,veml6046x00";
+            reg = <0x29>;
+            vdd-supply = <&vdd_reg>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
-- 
2.39.5


