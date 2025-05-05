Return-Path: <linux-iio+bounces-19174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8A8AA9D77
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 22:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420F517EDF1
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80868258CD7;
	Mon,  5 May 2025 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="UI7wZdHs"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5EA270563;
	Mon,  5 May 2025 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477719; cv=none; b=qAWQMn8BKvPxLATZHqFkTt1TprFyPBDcKK9rnulQ/jGYC4YsvCDfZL1ST9R60KMT660H7sgdqnxF3UdLcxrR/rGlHzAdSo+pnOK3SCVOHYTIygq8ppaSIKKjO99B6oYM/X++8RBIQcGHqRLNd9HUGhxA0Vj1laR1DVelNs9q6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477719; c=relaxed/simple;
	bh=JFXh0UmvB1uXyN+c4SwPO7I3Kv92fk+6q4OTM2LBtxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeWokdmnC6cyUxIuUNCWXVcRMPBYNzjyuggSBXv8aZ/iiPjRVOwuuWItry51PRuuHWVf/KSgnI9K440KxlNnY1r+kgEL3rQZTtpa/xt5o/50h/le5pZ1GhtPf8iBGIHFHt/Ri5aTO/isLjORi1BqY33PbvInExeySALgzAhBkXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=UI7wZdHs; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Z1yjOM7mfQmYrtvU5Bojq8sDhROmKsvPzkPUXkARBXU=; b=UI7wZdHskkRPdTEgO30a9SVY+X
	+LSQvWPWgCyhT5Le9bxeQD2OIomCc8rJrJIojh4t5bns6Lf3dfnsGJlo9C4x+AgyS4k2Sbly9IP7Y
	wyOfn3QfHB66QgLvVRH4KhIVxwuEPUX3J74uyF7/APDb9NaXmUCk3MnC368Q1+dbyQD2VC0ubiZgC
	WQ5p4nRc/HGyZFRVWdVKqfK5njvvyXQdEPnveOh1yJHjE4YzYxnShFv2kaVBQYHhn0K2o0lg0DGHI
	KBzLLnY6ecXwXf5ACfTghUbijppotql54oDKOmnbDFSfnH9Vvp5c6IWR0qUJDt6YlFiyuzSucmdWA
	VU6V6cVg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uC2MT-000Dod-1k;
	Mon, 05 May 2025 22:24:25 +0200
Received: from [31.220.118.240] (helo=anderl.fritz.box)
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uC2MS-0007So-0p;
	Mon, 05 May 2025 22:24:25 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Andreas Klinger <ak@it-klinger.de>,
	lars@metafoo.de,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	andriy.shevchenko@linux.intel.com,
	muditsharma.info@gmail.com,
	perdaniel.olsson@axis.com,
	emil.gedenryd@axis.com,
	mgonellabolduc@dimonoff.com,
	arthur.becker@sentec.com,
	clamor95@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: iio: light: veml6046x00: add color sensor
Date: Mon,  5 May 2025 22:23:11 +0200
Message-Id: <20250505202313.205522-2-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505202313.205522-1-ak@it-klinger.de>
References: <20250505202313.205522-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27629/Mon May  5 10:35:28 2025)

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


