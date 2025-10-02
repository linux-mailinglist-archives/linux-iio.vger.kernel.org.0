Return-Path: <linux-iio+bounces-24676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E09BB5116
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 22:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B76934E4BFE
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 20:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8FA2882BE;
	Thu,  2 Oct 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY/HhwZP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9E287257
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435367; cv=none; b=O7roD+1jw5cbMwaSNs5+Ik+6/BjsgtDOBlsOE50qh56w0mibhNe9s0gdBZT6MZ2yPB6DFKLZkhhmaAJZtFNY2LiTvUbJRPjdzV8ZBv04/dxKJE7Zh6HfqVFAKjvBU5r8MvA2PWy6upkK1zGbuIXoCINZJ4djYh15xZb+ViERRCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435367; c=relaxed/simple;
	bh=RWsMT7+A3hOigM/6lKe9y0xp7C7c2WQ715Dnkvpx1sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjPXgscTnluziSlRp3JMq9aiMzlMIFGKkfxTAbA6PVvONx/YJEqg5IxW/y40ZkJT3WO981irpvgagU/FLq0vYR+WHMujYJaTdttVpSYI1gN94+H1d1fG0RpRQy36dbE/tMW37nyNRRbP1GUNnJpXXOoHfO05oO0ftZ5eabbmxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY/HhwZP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b48d8deafaeso237076866b.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759435364; x=1760040164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EXqlzb/n7e+U7sXee7rlDRiXcbYy1hChaEgy4phOls=;
        b=jY/HhwZPFa5Y78c7vY+N4KI/c8/3keXc/UQNq4IgK1BB3WdVofZofy3VqcEUgG7EK0
         JlB03TeWEZp8BinjqL9H1AaXPEkLguzuWuuGmRyrs7zWCPlcMqSy5cy6q+wPN4Jpo9jB
         0W8dnkTrjMX/2vx7qba6WzCtMFvDB4QO54O4WearBFBX9sB0mL4qRxReM4qUWO8r7kXS
         +ZnvOelPWI9m88fc6CeyVlHe+uNV8Kp0Fray8+qrWLv4mMXyRPE58r+StbA2APDJUMly
         38XNEyHJ4zl+dvlRNeQANsqVMGaUludRCjDVpGqQBKycrxeqjH4P1zDnce0IuQB8jf8/
         3Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435364; x=1760040164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EXqlzb/n7e+U7sXee7rlDRiXcbYy1hChaEgy4phOls=;
        b=ev5h6q9eneEdQktCRiMzl+/qHqKv9tdh9C7/j8Po2Qi4o0GR2uaWN/YDd5KRq8cXsR
         da/nlgWdtBrGhcSbAoVl/LF2cm8fEE9TjF7pyxPBGkH59KlldjXK2Lq+YKbtzl8wnaQF
         fWNOUYDRUJiS9iZvNM+cwxv8gchGe2tOhYCChC46OBuFqtj7tFwL4EaCdV6JMMQsLmZ9
         olJFGgPBxqDlZjk24Ibw2c745s+0qz5noWe07onPPCNRHqZRtjXb4HW6d8UIlV5j2ZSV
         g7PLRacANqoiid7wFFMdwnwgKgLpucNtgOV3DcBBAHyTegfsJr0BW/qw4TH0QJBqmxCu
         AS7w==
X-Forwarded-Encrypted: i=1; AJvYcCXvpdSE9+GcgiqrHUrOsshx8VoYv/Gqem25/hdiI3wB7ZHi10DmY+SMTyZZFZJ8YeUip2QztUtCbZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz29iM2aFqGRLHCy4ILmKvJntnPBVj4wcc/dpkDV7QaTydDrr5L
	+6Du3BYEx3R402HiP8x/6IUMcvkTag70IDsh5uOrzfM0MHNfoK1F40Vt
X-Gm-Gg: ASbGncs5mw9gPS7dxoDblvTQ86ivovvWvg/OMzXkBwWdgtlraC3wN3zAwSflSoxrZk1
	lqVMnZMbzp3oiuJGu3tIW0F8dcZzXJUbWn5797dkvKrd70jSLDbYPVLbhNb2FGHhQ0w5Sun4gRO
	DLvByRZv1Mm8QfQ3XwS52OcfBRvqgSUVbCBWcNFTiD8mT/KkxMNZCncxSVVhRiYV64C2gXyo78P
	WYfGCq7TO6cZM6ryhkkrzH7/z0OjCwK7sT1ammGcq2q9qOdWbouBBW+sRWvwzyUnbeSlb4YhcSN
	3C54G3LFdJLpOveFRiir1SHedU+DMGpKEsncBGRPW5qlwkAVQR1Ux6hv9LZGK91Nyw4fvFX6hgu
	mFFJIYLebU8QwmbMHaS1oCJSu9k/Cca7sPtlMfhDgAam/JLHTwHtVuy0=
X-Google-Smtp-Source: AGHT+IGDdBFIO4tfvjNMAM3xa2U/WAw5504eAo3K2h133YQZPtkoxtvH6poX5eZQ+RiUYMpg/ev5nA==
X-Received: by 2002:a17:907:3c89:b0:b3c:896:abdc with SMTP id a640c23a62f3a-b49c525eccamr75259466b.60.1759435363618;
        Thu, 02 Oct 2025 13:02:43 -0700 (PDT)
Received: from localhost.localdomain ([78.212.167.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c1f6sm270880466b.78.2025.10.02.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:02:43 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 1/5] dt-bindings: iio: pressure: add binding for mpl3115
Date: Thu,  2 Oct 2025 22:02:02 +0200
Message-Id: <20251002200206.59824-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251002200206.59824-1-apokusinski01@gmail.com>
References: <20251002200206.59824-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPL3115 is an I2C pressure and temperature sensor. It features 2
interrupt lines which can be configured to indicate events such as data
ready or pressure/temperature threshold reached.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../bindings/iio/pressure/fsl,mpl3115.yaml    | 71 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
new file mode 100644
index 000000000000..2933c2e10695
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/fsl,mpl3115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MPL3115 precision pressure sensor with altimetry
+
+maintainers:
+  - Antoni Pokusinski <apokusinski01@gmail.com>
+
+description: |
+  MPL3115 is a pressure/altitude and temperature sensor with I2C interface.
+  It features two programmable interrupt lines which indicate events such as
+  data ready or pressure/temperature threshold reached.
+  https://www.nxp.com/docs/en/data-sheet/MPL3115A2.pdf
+
+properties:
+  compatible:
+    const: fsl,mpl3115
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    type: boolean
+    description:
+      set if the specified interrupt pins should be configured as
+      open drain. If not set, defaults to push-pull.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@60 {
+            compatible = "fsl,mpl3115";
+            reg = <0x60>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT2";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6..918d4a12d61c 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -113,8 +113,6 @@ properties:
           - fsl,mma7660
             # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
           - fsl,mma8450
-            # MPL3115: Absolute Digital Pressure Sensor
-          - fsl,mpl3115
             # MPR121: Proximity Capacitive Touch Sensor Controller
           - fsl,mpr121
             # Honeywell Humidicon HIH-6130 humidity/temperature sensor
-- 
2.25.1


