Return-Path: <linux-iio+bounces-5681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8AA8D842E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B3E1F22242
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8390C12D76D;
	Mon,  3 Jun 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKMlBeed"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0412BF3A;
	Mon,  3 Jun 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422063; cv=none; b=ln5cSgqRLHsc3NaJvEtdNxQfzpmHKKN5mAPFeQA/4QFAsJ67k3QGjO1v82r7mnUQDwm9xndlOe3jO28uL51BVp7qHXr4/gcJSmIQKZrfBXlRE9STe5/Z915JeyyHVWJ0mAf9Fjl8dGPYwoC8JUfjEWdWGlEAvpvFiMeTE3M4PG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422063; c=relaxed/simple;
	bh=CNclYiuhtxn52z+HLZMDRgEiJTcrTNaDA8O1iQjku2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z855HivDY5GiJDlUVc/OLL1npVvGHcgHniAJ9O+AeufUHe2mGtemj4Ur7ig1kmq3g9ZIzNSU97fu2tgH8osE/K0ztXSguBXaBOq02r6hVg3/AZjqQgDejdA6TsKXN0TTNvXeOpBYlVsRSjJwoo5lvgt5/hpHeMe/F6cBwSKtwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKMlBeed; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4213be171f7so9006085e9.1;
        Mon, 03 Jun 2024 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717422060; x=1718026860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ob+4f7qH6Vg5/G2utXpY3kVJwPOBg1pDjvHb44/3ang=;
        b=kKMlBeed4ASpDMcJC9Y5PqMYytW0Yi1tuc6c0jlL7N+jebxgaF6fUf+iDMSRogoJJ0
         xWI6s+/XLhid018vqD1pbagJNkhPHltAIUkJdFD6hg3676MxoI11+kiCafrgfvIxm3Ci
         OQLTuQ/tFn65Iq0f8By1caesjl7RB98pFSKU4tkmAOvcwviVdO/Q/xfRONC392Yt1Hm+
         ZhK1PHc2ZUGwwaAra3KfMB/1be/ceZdZywYNat3D3XeC5TiSIl1zy1HYZQe+5nKUtIev
         clKQMC1pvANs25z0DQ/Upnq01JRcuuNJRIGCsmSUr4kO0yElUeB67cmzKd2dUwkxIVp/
         q09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717422060; x=1718026860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ob+4f7qH6Vg5/G2utXpY3kVJwPOBg1pDjvHb44/3ang=;
        b=aPmjiboDSd5yhm3xTPmKsHYvuQ/7NyIksf/uK5LiqMFpIhEKCf7nusBDZDEzPWaMqT
         1CMZrMt+/h0OxuwL8MgiQuX3uazhb9BKywXTdstwl9rI/VmfvQQiPdyRm9jQzoVLC/XR
         DRUVXutFTuPkRPr81LknpMDs3t3Ek5sNzk6rVJKxlBJFZXfjyLS3H1hmHbI/bMU1lMYO
         LWxYppTi7Jj7Fmu8zg2viReVOpQUawmifk46iCgGdp4Ez1u9YBnR1WnxeDqOBcdXF4cF
         hqKiEkgrerLl+qfJfoVUe57xSZzvD1fguY7TeaYNEu4smhpuwDOOJauYXN6HLH4oYaE+
         awKA==
X-Forwarded-Encrypted: i=1; AJvYcCUJRbnk9hDR09XjjdbgML8qGcTDL+rf6wwrXHSScO6nZtJ2+eeJ0tjVji/u6wdS2BLtqo6y04vVIwSgVyvSQHOEEZW1kFuXgkDg4lIftD7FQKUbAH86iFAqVdrs89159atko7y6kVHSG+uYGoOTJWRlRrvcvkFST+qZf0pSsjGRx2s8mQ==
X-Gm-Message-State: AOJu0YxtR4RLSWmQhZT/p99KP9VqIQ4u1D56xLxlEtLBD0eMM3x72HuA
	Vkw1Yub/PoPNt5ggJ6w/RVkk0dBUiKSx7kjp0STyEMXgC/VCsBh/
X-Google-Smtp-Source: AGHT+IHM+3rQ8itjEyUlUaHm/XCOUbXppbJ7L9q7d2TX7lh0T9HgF+HLQgadrxRd5FQkWwyk/907bw==
X-Received: by 2002:a05:600c:3595:b0:41f:fca0:8c09 with SMTP id 5b1f17b1804b1-4212e0bddf6mr65554685e9.40.1717422059985;
        Mon, 03 Jun 2024 06:40:59 -0700 (PDT)
Received: from localhost.localdomain ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5e3d1902sm1868361f8f.32.2024.06.03.06.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:40:59 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: ivan.orlov0322@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: iio: light: ROHM BH1745
Date: Mon,  3 Jun 2024 14:40:13 +0100
Message-ID: <20240603134015.70388-1-muditsharma.info@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ROHM BH1745 - 4 channel I2C colour sensor's dt-bindings.

Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
---
 .../bindings/iio/light/rohm,bh1745.yaml       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
new file mode 100644
index 000000000000..b6abfbf609cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bh1745.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BH1745 colour sensor
+
+maintainers:
+  Mudit Sharma <muditsharma.info@gmail.com>
+
+description: |
+  BH1745 is an I2C colour sensor with red, green, blue and clear
+  channels. It has a programmable active low interrupt pin.
+  Interrupt occurs when the signal from the selected interrupt
+  source channel crosses set interrupt threshold high/low level.
+
+properties:
+  compatible:
+    const: rohm,bh1745
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        colour-sensor@38 {
+            compatible = "rohm,bh1745";
+            reg = <0x38>;
+            interrupt-parent = <&gpio>;
+            interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+
+...
-- 
2.43.0


