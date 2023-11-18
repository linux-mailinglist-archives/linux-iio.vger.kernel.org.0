Return-Path: <linux-iio+bounces-155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E581F7EFF26
	for <lists+linux-iio@lfdr.de>; Sat, 18 Nov 2023 12:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA4A1C2093D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Nov 2023 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF88A10A00;
	Sat, 18 Nov 2023 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzYfbZ0T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF471A1;
	Sat, 18 Nov 2023 03:03:05 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1ce5e65ba37so10204135ad.1;
        Sat, 18 Nov 2023 03:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700305385; x=1700910185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33F3e/iyMLXP9z/iwzkeKW7vsryEbJK7SpRBvKhRdAs=;
        b=PzYfbZ0Tj9WQ9EqcRlkW2vGLw2Cy2f1saVmLswMk20jViM7j6v+LM3ODXkagtKm2uc
         BreuXcttBEW/Dl3+IN8+MLthtAZ73EFSuB4+Uq03acj4mU6FjN3OE/eKWb6+x/g7SgYS
         Cgn394aM79SAX1vc7f8+/ys/vQuOt8SgRoRPhb/bmFSN1FRGzfmOimOS9ZKpMfsNi+mJ
         OvWARc2+r2qffX9ghnu/VwYAZ8doZsaAAAYkCxRvmZAhvUUhxDeF5bh05CHTE02SttlV
         LriV2126KaiOAVBHmqRERQ9Sxtro+uQ0z9biVtu0ZBsNe8FsUteHmbB7/tF1q9R/35Ve
         9ppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700305385; x=1700910185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33F3e/iyMLXP9z/iwzkeKW7vsryEbJK7SpRBvKhRdAs=;
        b=XlV4fTumU9S+tG2BVWw2JtxKo8AN+xM2tMikrJDWOWWvzlDsvtVR2iAU359KAOQPkg
         qiEAITypkXmJztHrPE38siemEtlEdxTl7Xql3flX0nb6SaYXghBns1Hv30TVBWg+Vrw1
         96cKJBPROFsCPuSxbUdJWy+ygAWcQg+T9UVWYh3t/nMnJ69ndAf65HBIY3cX+cVMrD8Q
         WI/vft8FuqURjg4eId4MyF/PxiVt4JO9nZtgtnedWvRECuoHKihSnT6dnTCecdCE9ymf
         QZCQWikUtRmXJTAFNbkL3aSV8DJSJHq6ciu4jzJqGo8GLqHkQjq+BEITdZz0Mlz/3kSa
         QU4g==
X-Gm-Message-State: AOJu0Yxbdm0VPmmygiv9DzW/yQiquwZZvOREADA5Vj0DVBQcMROMbOY0
	ckD4JGUOhGbadpjK0LhAweE=
X-Google-Smtp-Source: AGHT+IGWNcCR1XkzwNBZm/0EWKuZ5WVgg1zIEzj5xUQbNaO1v+mQwtwEGlEwzTIQEwgOewDcsPbutw==
X-Received: by 2002:a17:902:d346:b0:1cc:6078:52ff with SMTP id l6-20020a170902d34600b001cc607852ffmr2422430plk.26.1700305384934;
        Sat, 18 Nov 2023 03:03:04 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.110.3])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b001b9e86e05b7sm2813018plg.0.2023.11.18.03.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 03:03:04 -0800 (PST)
From: Li peiyu <579lpy@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Li peiyu <579lpy@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: humidity: Add TI HDC302x support
Date: Sat, 18 Nov 2023 19:02:32 +0800
Message-Id: <20231118110232.17261-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118105815.17171-1-579lpy@gmail.com>
References: <20231118105815.17171-1-579lpy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
temperature sensors.

changes for v2:
- change the maintainers to me.
- hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.
- change the node name to humidity-sensor.

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
 .../bindings/iio/humidity/ti,hdc3020.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
new file mode 100644
index 000000000000..775da99c19ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/ti,hdc3020.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HDC3020/HDC3021/HDC3022 humidity and temperature iio sensors
+
+maintainers:
+  - Li peiyu <579lpy@gmail.com>
+
+description:
+  https://www.ti.com/lit/ds/symlink/hdc3020.pdf
+
+  The HDC302x is an integrated capacitive based relative humidity (RH)
+  and temperature sensor.
+
+properties:
+  compatible:
+    enum:
+      - ti,hdc3020
+      - ti,hdc3021
+      - ti,hdc3022
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  reg:
+    maxItems: 1
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        humidity-sensor@47 {
+            compatible = "ti,hdc3020";
+            reg = <0x47>;
+        };
+    };
-- 
2.34.1


