Return-Path: <linux-iio+bounces-24105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA61B57114
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 09:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B63189930C
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620152D29BF;
	Mon, 15 Sep 2025 07:20:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16F2D24A4;
	Mon, 15 Sep 2025 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920802; cv=none; b=GpRkyR5azYw2rNb+0PKBwVr2Ix942shrNWwLM/Gh8Ggc1B0A2s4AfNBGdK35urmQD9n0vnLnmnIyJhqSXkKDUx0YVwsSvkpE8kw7JFfsF84BKwqmdCq+ttni+O/RRoFcGRTK2Aj6znJP8wlzPs7fsNs0Atk6QNGwL2Pk+pR2+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920802; c=relaxed/simple;
	bh=JTEsFYr8S5G4qhO0tUdYqJJv/f205UyRaKI/F+ux6Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Csm17L8RsH0/KKa2JlYUTjBfG9YoHtn5vnHB6NQ7wTIaZjr8HDDQVKtc/r3T5N9Qi/Cu/R1wa5uzKIYxbJv0UQvAIk5ZTjtsQZktQluvr7pnNTtvm9Ul5ifPncStc4XTKVrO+W+Ct9VcCBv8WaYq3vKQSujds2I5rY0e4qsIikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1AA56200DCC;
	Mon, 15 Sep 2025 09:14:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D3E6D200DC1;
	Mon, 15 Sep 2025 09:14:18 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9BF8B1800091;
	Mon, 15 Sep 2025 15:14:17 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: wbg@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH 1/2] dt-bindings: counter: Add binding for NXP PCF85263/PCF85363 stopwatch
Date: Mon, 15 Sep 2025 12:44:14 +0530
Message-Id: <20250915071415.1956219-1-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add a devicetree binding schema for the NXP PCF8263/PCF85363 devices when used in
stopwatch (counter) mode.

In this configuration, the device operates as a high resolution stopwatch over I2C,
counting in centiseconds (1/100th of a second) up to 999,999 hours.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
 .../counter/nxp,pcf85363-stopwatch.yaml       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/nxp,pcf85363-stopwatch.yaml

diff --git a/Documentation/devicetree/bindings/counter/nxp,pcf85363-stopwatch.yaml b/Documentation/devicetree/bindings/counter/nxp,pcf85363-stopwatch.yaml
new file mode 100644
index 000000000000..5fbb3f22ace4
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/nxp,pcf85363-stopwatch.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/nxp,pcf85363-stopwatch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCF85263ATL/PCF85363ATL Stopwatch (counter) mode
+
+maintainers:
+  - Lakshay Piplani <lakshay.piplani@nxp.com>
+
+description: |
+  Binding for NXP PCF82563ATL/PCF85363ATL devices when used in the
+  stopwatch mode. In this mode, the device provides a centi-seconds
+  (1/100th of a second) resolution operating over i2c.
+
+properties:
+  compatible:
+    enum:
+      - nxp,pcf85263atl
+      - nxp,pcf85363atl
+
+  reg:
+    maxItems: 1
+
+  quartz-load-femtofarads:
+    description:
+      The capacitive load of the quartz(x-tal).
+    enum: [6000, 7000, 12500]
+    default: 7000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      counter@51 {
+        compatible = "nxp,pcf85363atl";
+        reg = <0x51>;
+        quartz-load-femtofarads = <7000>;
+      };
+    };
-- 
2.25.1


