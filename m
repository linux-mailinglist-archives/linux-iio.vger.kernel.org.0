Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC918958F
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 07:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCRGGZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 02:06:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36277 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCRGGZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 02:06:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id i13so13328897pfe.3;
        Tue, 17 Mar 2020 23:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tz/NOLbKsDEYh8ikUHMyFXA0Fv1NQbDvbW9hYYkgk0M=;
        b=vQEvsPU2aP0eurmQG4ZXT/gNnIictX9IFmG28pSoYtwt0KNd7ZFe6HLau3pTPrnHC8
         L4dc+i+6X1mJDayXHnyxAQKc97VR1DUjML/0h3oNyHBZB0DzcyxiuTN12ZpQid6KfquK
         aPqraV0XHCYhgOABPShkkMkxoSe+BSnnDm88EAV0fhgwodMY93rWs/Oa/x1353Js1ihD
         QIGkGGjnNFj++D1PIDgLzv9jhRolZPQKCnfdgIlquH+HPaGQZindARVB9yXlsLP4SCTZ
         RPAPF4wmtaDySVoohtUW32RYa/URmi4vCZDeTQ13Ok4Omh3pd3L9/4keibteNf7La9T7
         vM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tz/NOLbKsDEYh8ikUHMyFXA0Fv1NQbDvbW9hYYkgk0M=;
        b=KGcMajR7fb6fb3F4tyr9aSXt+nLhDk091aHWeAsmyDldm8Rt+0tQcY2ngUtMm6Fsp1
         BJsTLardl4Dx6cQuE9YQj5mV/UTZOJqlkRcteRCzHpJeRDhuK6zW4xDp++qGnRFFgbW6
         1qCO4EOwfzIq939GMLY90TdAW2cBWCx2UfEU42eR5/Fq+vgULaat/Ae4QnEuGWctLiOI
         qHNWKEKG+kOvttFI5Xz76iL2tYSNLrd9YY/nDuzUkmiWlr0+8VmbFuexew/vjsr3KSu2
         8MJkaf6N6DGE2Eu1tmh5bsM1K7IK9c5l0328aQBRFWMgQZJTpGwtZ2b3tcwNJ7/8+aLL
         +L9A==
X-Gm-Message-State: ANhLgQ1Zvstl5cMH2BuhQlVWHZdi/dQq1fGw06XvrEm7dlQfULelBElz
        HRcdRHgtlchV4pQhvCKbIurgwQ6MEhg=
X-Google-Smtp-Source: ADFU+vt6M8xp9+lcWaX7Q9pFQk9E13Qq3WjrZa0h7gbBBiCWun+sZwbj/zVcyPIKki3r3gcZ18jN/w==
X-Received: by 2002:a62:e306:: with SMTP id g6mr2632336pfh.312.1584511583685;
        Tue, 17 Mar 2020 23:06:23 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6086:470e:bc8d:c185:c429:a95b])
        by smtp.gmail.com with ESMTPSA id m18sm4132518pgd.39.2020.03.17.23.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 23:06:23 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, nish.malpani25@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: iio: tsl2563: convert bindings to YAML
Date:   Wed, 18 Mar 2020 11:36:07 +0530
Message-Id: <20200318060607.6061-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the TSL2563 device tree bindings to the new YAML format.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v3:
  - Include the complete diff (changes from v1).

Changes in v2:
  - Rename the dt-bindings to include manufacturer's name.
  - Synchronize the bindings with the driver.
---
 .../bindings/iio/light/amstaos,tsl2563.yaml   | 49 +++++++++++++++++++
 .../devicetree/bindings/iio/light/tsl2563.txt | 19 -------
 2 files changed, 49 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.txt

diff --git a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
new file mode 100644
index 000000000000..141c7ae1edc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/tsl2563.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS TAOS TSL2563 ambient light sensor
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  Ambient light sensor with an i2c interface.
+
+properties:
+  compatible:
+    enum:
+      - amstaos,tsl2560
+      - amstaos,tsl2561
+      - amstaos,tsl2562
+      - amstaos,tsl2563
+
+  reg:
+    maxItems: 1
+
+  amstaos,cover-comp-gain:
+    description: Multiplier for gain compensation
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [1, 16]
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      light-sensor@29 {
+        compatible = "amstaos,tsl2563";
+        reg = <0x29>;
+        amstaos,cover-comp-gain = <16>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.txt b/Documentation/devicetree/bindings/iio/light/tsl2563.txt
deleted file mode 100644
index f91e809e736e..000000000000
--- a/Documentation/devicetree/bindings/iio/light/tsl2563.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* AMS TAOS TSL2563 ambient light sensor
-
-Required properties:
-
-  - compatible : should be "amstaos,tsl2563"
-  - reg : the I2C address of the sensor
-
-Optional properties:
-
-  - amstaos,cover-comp-gain : integer used as multiplier for gain
-                              compensation (default = 1)
-
-Example:
-
-tsl2563@29 {
-	compatible = "amstaos,tsl2563";
-	reg = <0x29>;
-	amstaos,cover-comp-gain = <16>;
-};
-- 
2.20.1

