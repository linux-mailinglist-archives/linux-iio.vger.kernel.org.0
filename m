Return-Path: <linux-iio+bounces-26926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DB0CABEB4
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 04:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A62E301876F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 03:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F682E88B7;
	Mon,  8 Dec 2025 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuXAV9Oy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D40288C24
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163145; cv=none; b=s90MzavrFgrUFf7771xBsVcF8kUQ/XdLj7ZnoX5PoL97rUssGZ+JFclYQcsVYYHc04I3fZk4RfGl4osv7TcvxfSrHXU6aLI55artP/2iwpVGG2YbcRpy4EC3IyjMzh3LBVvFUWrKSfxLlrY43gbYRifNQRfuEkk+SFuRndm8uc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163145; c=relaxed/simple;
	bh=sCRqVl7K3M0fY0HQHMfz4uoNLVMybTWLicOnAms2XpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuS434txzfVJ8T5FLsQJG7vx3voFNr+p9hZbBCoPNme4WJ/o8xF+CbDvHYrsF9mvAYtCYXLti0GbgAg6zuvF6ue5LImMNQ2VPqXFWOyRB9T97msHeJzbbezRc97f4FsGl9DXSqDrUKYp7jOs5hI1EF6QP9dS/By4rY/34+4DPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vuXAV9Oy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so52274435e9.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 19:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765163139; x=1765767939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31YJF8mMxnr+LqmRtwQssQbvEbeKZ9gZ0EQ+P+M9XPs=;
        b=vuXAV9Oyg8aU3Ig0w8zSJNedgIXqnt9PoT5FP69SGntaKDHFPWVHP4j2UvO28SLLCq
         NDxpdxqkf8zC/jiKgfBYn/VeXvNZ+X6PuE3qgiMs1NbvZVTci8Sz7j5moHshKoNZjCp9
         vlG3pKSjGvjXbgbEeJDk6FWAwizctgK0wdVU8WZFTYe2fhmTR4866Fhb24FrjdnnMoNW
         1Av2RaQeMtDYX1LM9+DAstQ+Q1S0WNUyyUU/8hQQ3yt0f3C7oOcTIg+bVRAdfKrfF17m
         Ecarge3yUfqgr8Ew/g1y4iqvFgCEgRLYzAwWGqbYutZcutXj1Ir+zogcEYvWsEebN9V2
         glbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765163139; x=1765767939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=31YJF8mMxnr+LqmRtwQssQbvEbeKZ9gZ0EQ+P+M9XPs=;
        b=mKUeJ2Wnl6ib8Ad4ErQpYEXYKdqSLNjB5G3Z3URcPSJW4DyhlRwGMwU9qm4P5l00ZZ
         jmtKkhoKU7hHUVBdT+F8bX6QACIQMrNX3af4iioStZOG+FD8w3nC06NKCBfRJz4l6oXz
         WfK+AkUyywSFDIa+L7OsScvhcIbViCWNTibmtai7Hn4/NnfvQqIB+R3Pm+vh3R4triKm
         VYnG0lBnonDIocBqnO0APQpwZn4vMRegkbUcCHTbb9ye/gSWI6tTJd+5BW6ZLUBYZsmE
         mWqHfic9bFizyMVtKayoeOrJ2IVoN/UFNsK2148pxeEz/o8ESrhJmgb1ma9VR+VfX1HN
         VGng==
X-Forwarded-Encrypted: i=1; AJvYcCUbgn5nSG5Cg81X5XOZqJwzpHVa1azdt+aL3x6YDGGaVL3mRDQW31SwAK0P1p4TyerTQLuFMeHlH6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeskg6qGBfGkiZGir25MSPg3B8o5JiLf3nV4rp2YaKPlw9IhFh
	zCkBgfjdv5csMQt/twpcm8saOwpCBowZFrVSC6nfSQEN+IyDZT92stXq9dVAzzR266Y=
X-Gm-Gg: ASbGncssleyWWK6P3ZWZID/GFY3oDFgszayAVgJjI3JQsf2HhSigCqZha00KTxwa8nU
	s5VM1m++c7nZ0hle78q4GfsSpeAHFjFoCHFVOT2CJRgddSaLRkvLh99Lqup+7C/KIJOtN9D1tf+
	iYGSwVRNLRPGI+LCUB9Mu3kdFyyWVH8GA6dfyZ4q8ivI77laoOyuvOLs032g9qy0RFRfdqlCgD/
	OftwFMiFeifaa7pO6XKC6o3oNx7zqXMpU1z/cdJ7YqrOUYc0ZSRtBg2MvNVjDgEGvRnbBYgBKQR
	Awr7Y1QR6M1CTsNC2aejUeIPEcR5/FLF5tQxq8q3mEXeCl7At9DCaYFehcKxdgoDayhFUnmTsBt
	fQO8F7EBPKWb+TnLrFVioZmQAfmi6EZ/kmW0jHWU97vdg0uB6DNsLL9W1PQO7nNU62pd/WUV78Y
	aQvlWXO6k5xPjzV3M09j+kMvC4Z88u98o=
X-Google-Smtp-Source: AGHT+IH1x7f63RvjHVJG0byImMjDmXlGrr71B/o+nkO+iw0TVwtKQXc5NIk9o91oiM8Lr9SJh4idng==
X-Received: by 2002:a05:600c:1c07:b0:477:9cc3:7971 with SMTP id 5b1f17b1804b1-47939e2464fmr68196895e9.20.1765163139118;
        Sun, 07 Dec 2025 19:05:39 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310b8e70sm220564885e9.5.2025.12.07.19.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 19:05:38 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: counter: Add NXP System Timer Module Counter
Date: Mon,  8 Dec 2025 04:04:12 +0100
Message-ID: <20251208030413.3117660-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208030413.3117660-1-daniel.lezcano@linaro.org>
References: <20251208030413.3117660-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the System Timer Module description found on the NXP s32 platform
when it is used as a counter and the compatible for the s32g2 variant.

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


