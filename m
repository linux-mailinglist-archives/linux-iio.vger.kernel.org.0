Return-Path: <linux-iio+bounces-137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 453A67EECF2
	for <lists+linux-iio@lfdr.de>; Fri, 17 Nov 2023 08:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82231F25ECC
	for <lists+linux-iio@lfdr.de>; Fri, 17 Nov 2023 07:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2371DF4D;
	Fri, 17 Nov 2023 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2NdKuzN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148C2D52;
	Thu, 16 Nov 2023 23:47:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso1571960b3a.1;
        Thu, 16 Nov 2023 23:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700207258; x=1700812058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XZ+bpR+GYXI1dYrwmpsx3LyIpqyeS55MKPy6ULRoi8=;
        b=l2NdKuzN7wBB10wdu8EJ3WuG4z7/BTHe+fPgDglQS1xmsb0vtBRI/QwfsCQb4yxgKS
         Ink+haTwcc2vDaR6UMYJqISKG4D2Gymy/PHGWHirIY19i78wRa+fqk+JN51ADxvWF7cx
         QcQY6uwtz4tPNe2KMHMezNdPpwCX+xjXVwSgKDEUxEvQ+dIbilGqh0X0TrOhdDZxBb14
         bzbX2+tTfYXWQ46hJe7eqWe/yREE20AfRQDDGbURkaa9xHi33iXixL8nkfgm35FhoDwv
         SIYOCI9YkT59Onjkw6S/4RbaLUniuuUdSU6fvU6bEO8TOVMEjhuxApRoiydoKg4IeqJ6
         HPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700207258; x=1700812058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XZ+bpR+GYXI1dYrwmpsx3LyIpqyeS55MKPy6ULRoi8=;
        b=thOzrSAA87+3eS91M8ZCY4z5ASqxx1ZbTLxh8fG/DgJ0Du9G+SOf3mENXMinjt8AO9
         PKqdJCYw5cObX7A30/6qKRyAB8xycyzb9YZwhKhtkMAbA3Z9HmLDAjX2UtVN0MJyhef2
         pELXELCIlThZ1PCv+rX8V2SWbxadwQxrobeYtShLF2SFRmPVjKeWr+NV52SEySAqZbLr
         OxZCyY0y9f6PILsZedny9zU02yldNclSyGf95kitn1jskRBbO2HowoGkfbIrly8xzOz6
         64lB/hlU9zD34xcUGtBR1Q/uyxy0DCHFEGdRG4hOWyib6U+suHOg9Y3G6QLbNcAUE/YB
         sykw==
X-Gm-Message-State: AOJu0Yymi9H7ub0MxQtQZvxpaBnkBT09sb6LGTCJqi0x2LnWkAqhY71L
	Hy37BiZOvMihb1jEjhszlh4mUbf02Ic5+nXN
X-Google-Smtp-Source: AGHT+IFwcIo97MOV0GGbVZAt8q3V0mlq6OF09rSEFW131Gzc0pADAo1EAFoUCE8+jHLI+4uS3hImkg==
X-Received: by 2002:a05:6a00:140e:b0:6ca:2b55:58b7 with SMTP id l14-20020a056a00140e00b006ca2b5558b7mr7574827pfu.20.1700207257927;
        Thu, 16 Nov 2023 23:47:37 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000a1000b006b5922221f4sm870110pfh.8.2023.11.16.23.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 23:47:37 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: light: add ltr390
Date: Fri, 17 Nov 2023 13:15:52 +0530
Message-ID: <20231117074554.700970-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for Lite-On LTR390 which is an Ambient/UV light sensor that
communicates over i2c with an address of 0x53.

Datasheet:
  https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v2:
- Added missing properties in the example
---
 .../bindings/iio/light/liteon,ltr390.yaml     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml
new file mode 100644
index 000000000000..5d98ef2af74d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/liteon,ltr390.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lite-On LTR390 ALS and UV Sensor
+
+description: |
+  The Lite-On LTR390 is an ALS (Ambient Light Sensor) and a UV sensor in a
+  single package with i2c address of 0x53.
+
+  Datasheet:
+    https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
+
+maintainers:
+  - Anshul Dalal <anshulusr@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - liteon,ltr390
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: |
+      Level interrupt pin with open drain output.
+      The sensor pulls this pin low when the measured reading is greater than
+      some configured threshold.
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
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
+        light-sensor@53 {
+            compatible = "liteon,ltr390";
+            reg = <0x53>;
+            interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd_regulator>;
+        };
+    };
-- 
2.42.1


