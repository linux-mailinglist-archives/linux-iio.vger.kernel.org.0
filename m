Return-Path: <linux-iio+bounces-22086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D08B135EF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 09:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F011898850
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2F224B0C;
	Mon, 28 Jul 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="kaBoDKRj"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246A54769;
	Mon, 28 Jul 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689325; cv=none; b=T+6sZ2PqD4BMVFZ07ByMjOuiWaGBftFNxGZ6KM9mbfDPP06Ex/IysCpvd1HoOcpdil//a5Sqbf3N/tFbIFTl41DcT4Ggf8YWFZKQXmwdkQ9vljO57EcReD7XMA6asacWogFekkwBSOZvon1bOIKsL7dNu09Zga4HPIJlw0W6Afg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689325; c=relaxed/simple;
	bh=JFXh0UmvB1uXyN+c4SwPO7I3Kv92fk+6q4OTM2LBtxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNr80uNxtR+1hEhFvODrwaBVRe1GkI2mFzseiqth7hUdh3nAt9KGnUDzVUUDMfmAay0yYVfv9qTIrabl8ASejwQCO8VXORTEWZSNcpmaevBoCydZv3yz4iBseq0tK7FSKCEwPE7jRchullItzfA2tgO1BvrxMmTZfnKcJEUQNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=kaBoDKRj; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Z1yjOM7mfQmYrtvU5Bojq8sDhROmKsvPzkPUXkARBXU=; b=kaBoDKRje1hCLRdcqikGsuOy9K
	m547VjfXAFPajEcYNSRNvvvsduEnma1kAlKXRzQxP3Un2Emjlv3PD/Vm8/o1u1y6p+llMGDPaB6OE
	oQpfJGwswe6u/1J862FAXLBjD5Un0flh/i6+A1qul2F3Ybfdd6gCUWogleH3hgEm+ablhE1axLagr
	5YgmTME4zqIvZGzCN1sdg7aBdJsRvXhklYyqm+a93ha71QZG+quVT1c2ybeCwVivxcsqiiy6UlHfD
	4U9tKaUHGhq+pYVPfejquRa3Znoj0eHm9cRlfn9ZUf4i2AUnjt4x9iErj+ZF3OsxpYB7NsJ4RoBUD
	+axktGJg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ugIhY-0004XV-39;
	Mon, 28 Jul 2025 09:55:17 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ugIhY-0006b7-1Q;
	Mon, 28 Jul 2025 09:55:16 +0200
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
Subject: [PATCH v7 1/3] dt-bindings: iio: light: veml6046x00: add color sensor
Date: Mon, 28 Jul 2025 09:54:44 +0200
Message-Id: <20250728075447.338725-2-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728075447.338725-1-ak@it-klinger.de>
References: <20250728075447.338725-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27712/Sun Jul 27 10:35:17 2025)

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


