Return-Path: <linux-iio+bounces-27515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 191D5CFE17E
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 14:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F3FE3082C32
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE73341666;
	Wed,  7 Jan 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mDGZtDrb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D479340A7A
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793204; cv=none; b=cIXiHUzmARxSAlMyYwiNbT8sPWWy40lRc6UM16m10jv4cQKVneSEtpQnWynXpRwgDyCHHY8cG5Cz18GGP+Zftr0mRwvYzITOZ8yvEiVMr6YnhOUMF7lgM9AzzG5FILYMeGjA/p88guPQisaTRW6eoRBIEQvyvYfnqtGgJk6oFsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793204; c=relaxed/simple;
	bh=oJ9gKow6S8KEzSj2K6q1yw7J3LdgtVU6Q9IVbH+UGBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4P/xnix+uFUNh06+rKKanL9PSr5XiIZXdInTNp3ev8uRnU/UPEntSRB/kKt/YHupXDgS5FrmwW3MJtbAfTdP1bDAwCm1ylZQFJ7Lt93gQGhZBY9XhFjaWKX6YuBEUr1ZDDLTL5roTlmRMlLzLPN+hOm6WC7leMrLRM6+nx9zNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mDGZtDrb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so371272f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 05:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767793200; x=1768398000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2y3xJj6Lny5hNArf79Fe/OIMoyByArkbsGtk/c71GuI=;
        b=mDGZtDrb0dmWZF/F4OEy19m34NBpmnh7Ke3WgPNzfJ+sDGZbZCTArygVYxoy+JmNhn
         xRvbL5jOgpFqwvjfAqK+bRikBc2wXimn6qAE0pKgAe8zDCWxZolwaC+OYCSi7ASHueRq
         575aVYAqNaDl9aoM/ImWLjUyGJAm2RpLQt1jE7o7sL14D56MASLFZQPtggY3eFB5WyJf
         cLPIqCyPavhi4p6lF3liqk9i4wG5clPgUAtZ6o5MLMsoRSFR55tog0YKsYbOJXWWBnUS
         kjlndJevwB9Si2AJf/FdfVBtjxLxr0cd+tMDPToC9yb+NWMQWM8Eaoa0PivvzOPvjHay
         MXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793200; x=1768398000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2y3xJj6Lny5hNArf79Fe/OIMoyByArkbsGtk/c71GuI=;
        b=rQekxN7jt0uXVuujMKyOGl3BZQQi8wDcF3sFUiX3g+m4s2XGQ298ZlU+TGm925evAS
         lhsCJq9PXBEH0hscehOpVvrLWSz0UFzgAXX2dOGLKC6WQRJfTPVSNS7ZAooBtBaiNdq3
         bKOVOm/AHTT1z5TYa+tk3Naq7KsDyHIkyFKlsWCp9xoMBYjjUYIJClESdDzsZ8ArKVoc
         ca0PGWTGjuTjcfAVttL4JZW4LCxXgsCfKfQPPjNy0kCdntFTux97T1k30OF1R9b34Sf1
         bOGUNRtTBd8eY45LdWi7dp0xuUg5MgJTp6q/HdsNPMvEfuld/G944V0YmX2aYovb4kWn
         G38A==
X-Forwarded-Encrypted: i=1; AJvYcCXqZS3tM8es1HwjVNyMoMR+cLj05xV3Nd5IjzmO+kQV74/Jo3gCSx4VlQ+acBkq7qKdfuxFdDkBKTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5QITq1t7p2F4zaytrnMc3hV7xRMgKVy4dXfQlc5MxV8alXwv
	ksr+pKjOHop0ll8Ym8UZJKIImt9frV6Z8tupwab6fSPy3raDukaeu3wDNEHZKaHaw38=
X-Gm-Gg: AY/fxX6GM1eCCoaITPNim6ZyyOAg+v06uoreNSOpOvArl6EsNq+wZfRiYk/UuEeYVwT
	suM8YL46ejwGar1w2scVeT9OvbqNRxk8GJ4z968fABWlUX7YMOABl+0uA/i2X8kDg0KcLG1TLyU
	91sx5o+PVr28O/mvuaeKayIdYAg5LbpLhLdT3kjqcFsoRzhrEfXnkDVvEBYl7Dx7vAudWSrzKD5
	ZKNEAgWwfgLAY6hsdd9Gh5xl4QG4WAePgta6r/9g+Xt7t1AOgY7fD4RUYAXg203g3eVjBgv2lts
	nyeGqiGnkMuEkcUeR5OUyoTuTS81mEYcRhtuum1fXGDxtAxmaK1ek97a7FW/gFxiwwefsOxgp+4
	dCzQmMsy5jxMRrUWI896HmJ5CyGx+fOiZ/Bz9QmFUd5vlGCfN09d5JI38K9RhIVP9WkkRufNLgb
	b/E7mv+smRbb07sFgEzYFG726q1YPdMHs=
X-Google-Smtp-Source: AGHT+IEmv81ZP2nMx/GBeve9qwqbgXEMVOoOo0eHP+YvxZHkXRk317akrEbP+MJ11KaLATLdGlW1fQ==
X-Received: by 2002:a05:6000:2511:b0:430:fbce:4575 with SMTP id ffacd0b85a97d-432bcfde8afmr8089849f8f.21.1767793199528;
        Wed, 07 Jan 2026 05:39:59 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:39ee:bc4c:aafe:6bd0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dade5sm10595542f8f.9.2026.01.07.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:39:59 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org
Cc: robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: counter: Add NXP System Timer Module Counter
Date: Wed,  7 Jan 2026 14:39:51 +0100
Message-ID: <20260107133953.2094015-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107133953.2094015-1-daniel.lezcano@linaro.org>
References: <20260107133953.2094015-1-daniel.lezcano@linaro.org>
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


