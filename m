Return-Path: <linux-iio+bounces-27132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED7CC66B1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 08:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90C073024278
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019233C19E;
	Wed, 17 Dec 2025 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXTNWBt7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C9339849
	for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765957823; cv=none; b=ai+9mw5W8+ZuGpWBv8rmDZ12FbYYRlvrFNGs4GBtj80XD1Kk4qMIVPSVH5SSTLi2tlV2OA5AwLXuoQpFcVq/NfL66Ypd+K5kS2BkE8M3qQ3roQ7/QDUUeza9LIx1mIV+5H6+GGeRLwXfDmdtTEMNrQOQMyLUwxv3g1fTpjateyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765957823; c=relaxed/simple;
	bh=rRE+Pn6uRjeIMKhh5F8RB2UlR4gSdwImg4JvNVWYId0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c60Uuk+SPyleShqOY8comIxR7hIuijWzNd16NzmjubeiPcp11JdEtk1oL+WSLzLEPGdTVuCDN9yNCOUlr/0fi/FweZ0BCh7fMvuLDQy6fsflua5V80iZz7Qe7231pk13qEcK0eQsWlE7TAeCBaztKJsXjHSYRBG07/33wJXfohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VXTNWBt7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so65618505e9.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 23:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765957820; x=1766562620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cI6o8go+UXL/S5TqQXusywCs+KEzzJC/G+A907W08g=;
        b=VXTNWBt7ds+4RtgsA2e/Xe9hkG2AUuB7OFXtmQ3k+Go8hKRJ3XJtoely6IKdVbd7Cd
         ME3Y8AEfSi20WvdfC5XqlwfQI9/m0pPvZX32Oaa7muGUZyZ4w1MzZnxXLeNbjVhf4snx
         BOE0YwXLEEraevD6d/TYDfpuQ/cft6SQ3owokz5QKt/ilm8bNFxiSHcAnmOZm0pfPIPs
         ifr9dk8geHJp2aNVI39VWXVj+tZths2MwBnt/c6f2Y5W0rqjJnJn7TplBb3eHpu/0r+/
         inOEal8INVNEBnumvrwddvEknOSuati6x3QvyflYf3qn0wjRHwpeQgHCQGidN4ACeZDT
         d1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765957820; x=1766562620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4cI6o8go+UXL/S5TqQXusywCs+KEzzJC/G+A907W08g=;
        b=s6+L7ZYBfwmfVd08nXp65IO/edRmpD2nxxdtrj4KgtazZ2Qm3baa9vIgSFF/b08/n2
         IMW5p/hfGINLnlXPn76M6SFZJU/7bSOgy8hWtZYimBEvuJaPf2KEhIx7qb4rWYhKAYhl
         BeCiQhsjPxuQggCQQLG/x+npfr0IreTPUD7YOrsy+pxCzZtDhv/oSFKcmQClXnyPXf4E
         61+zTS8ajDrvSjG/J636A+quS8s+Wl2YUXvZt05rbuWVCF8ks6A4x6f8ZPZ4CCzhefAB
         kqjk6fNH40r39bmwZ97Wr5MUAKSbnOAh9Yq9GDtrxRFlH4laeKzCxxKhNZGg2OfccE5G
         oN/A==
X-Forwarded-Encrypted: i=1; AJvYcCXwM+3KuFmdi/Gx7vEaFOWQ0E1iy7u0jeeScploSRAGdSE2AacllItseAp23wy4RORjtZlQ10Zum98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0uJT2MhnOriqDaS7T+c0GQ7hW1S/sHFJPCj0VAWuTniVT3dR
	JyYYebTXhLE8to0IIhn5kGZrjGniGQ/rmyq7Fk3wkbV/ggEbJ6pQn6SKWNlh1r54GJY=
X-Gm-Gg: AY/fxX7Ib+VFNtYVUTLJtxx1WOFWdd6G29uKmDBiC5rWW/7AgfF1dnbOpX1fDRpBmmA
	lsgvWdhAk29TfQXgmItvkiSk86q49TVRYkj2D9iiRBD/OUTj7ENZvBoWzIkLybikvCcpVw9MyYV
	trgTP/kxZRI6UzkbaJoko2uVlF+zbqm+U/bIlVd9jAiH0nXXodylRi+h1gb6o+NRkOr2E8XAimn
	VA8pD2DfCRWyGiTnJE1wzpXDSDlBIJs5wsAYDhntMB6nvae3oESlFc2ZTPhG8QLPEKokISyVgYP
	5zesYwoJJhl4pPU2B4rm0TT8DwZUW5+cbihLrxVygB8ihiKjn3BP86YYc1nI8C6pQAQQG89PQwV
	dpSlReqwqPFkvWe4ca1WNKzYinVUVSNGoCoyd265z5noQAvI1vPrzeqvvcbpmoIIPgw0g1phuH6
	Z6hnbA0evMmdHdP785a/6XcxB6priOBPo=
X-Google-Smtp-Source: AGHT+IHUt4H0d4IVMI4vL/GyjK6b+P3BJ1v53Cknxck8AjlUtvfUSe1tsqrmrYziamrC2AoPcIxuOA==
X-Received: by 2002:a05:600c:4595:b0:479:3a87:2092 with SMTP id 5b1f17b1804b1-47a8f9145edmr164663625e9.36.1765957819748;
        Tue, 16 Dec 2025 23:50:19 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1edff5sm26094315e9.14.2025.12.16.23.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 23:50:19 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)
Subject: [PATCH v3 2/3] dt-bindings: counter: Add NXP System Timer Module Counter
Date: Wed, 17 Dec 2025 08:49:56 +0100
Message-ID: <20251217075000.2592966-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217075000.2592966-1-daniel.lezcano@linaro.org>
References: <20251217075000.2592966-1-daniel.lezcano@linaro.org>
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
 1 file changed, 64 insertions(+)
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
-- 
2.43.0


