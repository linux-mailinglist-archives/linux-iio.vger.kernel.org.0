Return-Path: <linux-iio+bounces-27678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C9D1A6BF
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9318E30476A3
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340434EEF2;
	Tue, 13 Jan 2026 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwbBaG9E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBFE34E74E
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323157; cv=none; b=Z13b58ytkY66EnBbsTS76mjbjrVjhwlvZzfpNrWDob7mjR51mlEs1/07cIGe0y9wBfpajLox2V6NCE5BIaLmLtLQP10QvoZvmtMVTfCz8YxKch2tzi2tNj4VtNULSOTOxX7xGS6Gqrhu4gHlGiVnMlNshsHMRLkhhaFFePeA2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323157; c=relaxed/simple;
	bh=oJ9gKow6S8KEzSj2K6q1yw7J3LdgtVU6Q9IVbH+UGBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dh1Hb5qbP7+vAqzxB19mJau+5yiGeS8wAed8VGibBmn8sgKxL9FCizvl7MDecKE1AO1Qc61LdzWwJdcmvZTahuq10BDwfL05ux72wUjHfGwNQfNEQx34wV8ScGiQ6PMva1C1Z4vZ+0dY7bkbwvc+GKGzygIBDl8TyjQ8SxDYrmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zwbBaG9E; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso32052395e9.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768323149; x=1768927949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2y3xJj6Lny5hNArf79Fe/OIMoyByArkbsGtk/c71GuI=;
        b=zwbBaG9E9CT3bHkBVCk/NesvscQ6HCIPhHJJnDHqd0Au4gCM0t22ztbvAaBj2O98hN
         z5q8yHR++mVuIMMn7p+el8C9vdsL05inlYW57mggWhanJ/MKLWRaW3UZuqYIHl5El69r
         X4TDVJGd81U1ET7fSvVIU6E289/MN9swdP2wziDvfRnBMtJs+vavyNzEuXNduy1JFwP1
         MKwMXTx6KdNlZ5sZ4MJz37hboVLu9LLvRSQ8ICSIBQSjDfDvPRrBDSrjkFoRqVn7AXBB
         jU9tisF/eHn/S5E7+63COSmbG136NCrr/1JKgsUlZr2Zg61BBmK8W7qAF3v/DUfXXNEP
         y2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323149; x=1768927949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2y3xJj6Lny5hNArf79Fe/OIMoyByArkbsGtk/c71GuI=;
        b=xOdMhnKjfjD7eynzz/Ow5kLoIKnhCfzm4Wl43cgDz7NjQzUMQBhc72GJAd0VBWD+Xg
         PZPCX8nUFGkBomTbG9y0kW1dZkwGx8kzVb2kjfxFQL0VpvbrBrouYz4kUSj/MkawHs5v
         8uRiINASjvARxq9d0jf3SfsUQPQMPKRg/vJSjbGoeZHuHAg6C8PRNrjhZj3M8VqgXXo1
         8qH8GSHoAu6IfXaxGwOOLZ8OVFEOQypvyDNtuSicQbikYx6ZVeplt6uqw0dDb7+N3CZY
         UBwgmk6ZC6d7hDmbMpne66Hexb955zYLoTr4WWaEL3ixaNpuUN+1yLIk4t2EVoOvZ5Zn
         uNvg==
X-Forwarded-Encrypted: i=1; AJvYcCXWl5y8/QwtVRKb5CNMPeuaZ5M10kghR6rGEQEey52hiwqsvKbdQ/hEFM6hIYHtcjHP/DvnYdJhl/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTd1ppGbYGHboXVxaZ9KfcoAE9S9YxhtWAcnVPrGKsv+kAeOM
	dV4kB2OcsmSlZn1uODJkdGMuEss18mURrwBtatiIjWGF7llbC+DpWjpNZHn+mDbCmLo=
X-Gm-Gg: AY/fxX7fmU41TEVbC1YSocDSq/r61mUkM4MGDQWyNKkXM0xEjShde2CpatSVvuyHVwN
	IvKmh5LTHUbaZSRNpz+ziMODL6KcLWKZgqeFpig1Usuj8qtflBkZW/3cIflIc35N9hUjjMH0knA
	+si9UQmEte5mvuiKQ5a09j+uVJFRjkklzv3p3k5qPpRPyQazbVDhh66S5lL/F/2sK9u37ridIzD
	Ii1fX6MYSCnNEJb4XnkJ4/LDHicMEkmc2pklvvUfPz5BMaR1aonJxUNft50WfnFOVdm0ktUxkmX
	VpslTZP32oxgPdBo1+jqDvWHZneg/gc2mA9PCEomFRTkTpf+4dFAOukLnBMFAQ74g+/ZNyuAuaF
	FDLU944AXAmFu/76r9xj78uQuJdyBi+0XadIUJnidMMsMYmumN6V8Syllz0jo5UBS/J1gx0HkrM
	m/poz/VGiWAmovIUILcZjMJGW5zu0LMOQ=
X-Google-Smtp-Source: AGHT+IEicAP01cQZjkyG01ghspfKpykhlK3qAoBCk+2ayoqlIhLWC13pIjU/Acop8PMmfgPDXUsETw==
X-Received: by 2002:a05:600c:444c:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d84b0b303mr225376805e9.3.1768323148712;
        Tue, 13 Jan 2026 08:52:28 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:3594:70ab:9964:c5ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm431684925e9.7.2026.01.13.08.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:52:28 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org
Cc: Frank.li@nxp.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: counter: Add NXP System Timer Module Counter
Date: Tue, 13 Jan 2026 17:52:19 +0100
Message-ID: <20260113165220.1599038-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113165220.1599038-1-daniel.lezcano@linaro.org>
References: <20260113165220.1599038-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the System Timer Module description found on the NXP s32 platform
when it is used as a counter and the compatible for the s32g2 variant.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/counter/nxp,s32g2-stm-cnt.yaml   | 64 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  6 +-
 .../boot/dts/freescale/s32g274a-rdb2.dts      | 10 +--
 3 files changed, 70 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/nxp,s32g2-stm-cnt.yaml

diff --git a/Documentation/devicetree/bindings/counter/nxp,s32g2-stm-cnt.yaml b/Documentation/devicetree/bindings/counter/nxp,s32g2-stm-cnt.yaml
new file mode 100644
index 000000000000..4d42996f5ad3
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/nxp,s32g2-stm-cnt.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/nxp,s32g2-stm-cnt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP System Timer Module (STM)
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@kernel.org>
+
+description:
+  The System Timer Module supports commonly required system and application
+  software timing functions. STM includes a 32-bit count-up timer and four
+  32-bit compare channels with a separate interrupt source for each channel.
+  The counter is driven by the STM module clock divided by an 8-bit prescale
+  value.
+
+properties:
+  compatible:
+    oneOf:
+      - const: nxp,s32g2-stm-cnt
+      - items:
+          - const: nxp,s32g3-stm-cnt
+          - const: nxp,s32g2-stm-cnt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Counter clock
+      - description: Module clock
+      - description: Register clock
+
+  clock-names:
+    items:
+      - const: counter
+      - const: module
+      - const: register
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@4011c000 {
+        compatible = "nxp,s32g2-stm-cnt";
+        reg = <0x4011c000 0x3000>;
+        interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+        clock-names = "counter", "module", "register";
+    };
diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 51d00dac12de..6bc0c75b574f 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -579,7 +579,7 @@ swt6: watchdog@40208000 {
 		};
 
 		stm4: timer@4021c000 {
-			compatible = "nxp,s32g2-stm";
+			compatible = "nxp,s32g2-stm-cnt";
 			reg = <0x4021c000 0x3000>;
 			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
 			clock-names = "counter", "module", "register";
@@ -588,7 +588,7 @@ stm4: timer@4021c000 {
 		};
 
 		stm5: timer@40220000 {
-			compatible = "nxp,s32g2-stm";
+			compatible = "nxp,s32g2-stm-cnt";
 			reg = <0x40220000 0x3000>;
 			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
 			clock-names = "counter", "module", "register";
@@ -597,7 +597,7 @@ stm5: timer@40220000 {
 		};
 
 		stm6: timer@40224000 {
-			compatible = "nxp,s32g2-stm";
+			compatible = "nxp,s32g2-stm-cnt";
 			reg = <0x40224000 0x3000>;
 			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
 			clock-names = "counter", "module", "register";
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index ee3121b192e5..bde5d3726825 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -41,19 +41,15 @@ &uart1 {
 	status = "okay";
 };
 
-&stm0 {
+&stm4 {
 	status = "okay";
 };
 
-&stm1 {
+&stm5 {
 	status = "okay";
 };
 
-&stm2 {
-	status = "okay";
-};
-
-&stm3 {
+&stm6 {
 	status = "okay";
 };
 
-- 
2.43.0


