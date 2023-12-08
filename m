Return-Path: <linux-iio+bounces-745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E980A099
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 11:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9814428193F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D889154A2;
	Fri,  8 Dec 2023 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cySM/tv5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7411C121;
	Fri,  8 Dec 2023 02:24:25 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d1e1edb10bso17413255ad.1;
        Fri, 08 Dec 2023 02:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702031065; x=1702635865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh6Ho7FMXEpXQf4LtvO8/eRoMKW6RHIURVqHusV8P5Y=;
        b=cySM/tv5ESiFGu43qChqBqeTaP/X9zz766X55vdVyRHGnZJnaKLdEyH5WFxtU12yVz
         gk3MCGBX/iU+lPAfDb7yq7NpZh8qB2uyUeGYIVr3KKpeUunVP1rFSGDVkg/Mg/TX8hsN
         vTcCiyrojhvCp25u+rjCB3XQ8WW9a8AXpqk65JW6P4MCazmTk13GJhniao6FmZM4DddF
         E5ytcQ2hPULF5UiZbr1b29xGBeE1F7EKxgsSZIdetMEkm9Xc5WVzQz4ghcetUq7uzKG1
         mNbxKjNGduZQ2IDcPiy54m5BwX4rH/9tiOnVO2JnrYShbwWHlud8+nIusfHBtnindpdG
         C1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031065; x=1702635865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qh6Ho7FMXEpXQf4LtvO8/eRoMKW6RHIURVqHusV8P5Y=;
        b=djiB9SskmqmNZL0R/wIRWixl7v7gKT6BRc87c254Warzo3u9I8OaLKJpyP4vVs5j4R
         YHvgyWR67RO3Yj0z24qJrMl107nnUG/vXXvbMPuqBanX8LOYhr+SwiULK0vOcJcrpCbq
         V2SmQPwKbT2Hkz2Tkk7BRSvBPmn1QG42EHBFx+iFTu5ZILLZjftmxA0uJPqEqXHO51+Q
         bpse5e7gkaJsw54Wbk4XfND0XpReOQfl9oaWyPkaUnD5gXJhHcpMwR/XbBDb4ixbyM3q
         xeVHOyLODMD9l8Mgm3tjgILoOkubchglvLOXDx5plS0vLqtjyZh2DSkWD8uCLb54sMyF
         4wiA==
X-Gm-Message-State: AOJu0Yzc7JGRw4ZOO+MRD4beTwI7M1noivgjR8UAvPV+qSmRfzTGJU+u
	zZ9y1WP1F54TnHjQHCHBhpIgp3+fAp4KhcNC
X-Google-Smtp-Source: AGHT+IFDRt620D36MLt/MRylsEHRaxp0S3JiiobHb5xw1MMVDzvHvtCz+7Jc58Sa7fyDaqtFeSWMaA==
X-Received: by 2002:a17:902:c950:b0:1d0:af28:4603 with SMTP id i16-20020a170902c95000b001d0af284603mr4862870pla.32.1702031064618;
        Fri, 08 Dec 2023 02:24:24 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:6277:8af4:45bc:8bc9:c94a:54d2])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902d5cd00b001d1d6f6b67dsm1337033plh.147.2023.12.08.02.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:24:24 -0800 (PST)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: add ltr390
Date: Fri,  8 Dec 2023 15:52:09 +0530
Message-ID: <20231208102211.413019-1-anshulusr@gmail.com>
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

Datasheet: https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v3:
- no updates

Changes for v2:
- Added missing properties in the example

Previous versions:
v2: https://lore.kernel.org/lkml/20231117074554.700970-1-anshulusr@gmail.com/
v1: https://lore.kernel.org/lkml/20231109090456.814230-1-anshulusr@gmail.com/
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


