Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA789B286
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2019 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395437AbfHWOy2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Aug 2019 10:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731256AbfHWOy1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Aug 2019 10:54:27 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A0122CE3;
        Fri, 23 Aug 2019 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566572065;
        bh=bon1mPzQXORDinj5rD7fDb31+nUJZNIFLlixq0vhNcE=;
        h=From:To:Cc:Subject:Date:From;
        b=yTp79Xiviv4ZJbDLTwHLo9X/0TEbq1efTiC9EH6YnjRoAneY5WrRXZwOfd7wnnVrB
         z9syNrOL4n5MRlml5l++1XvUBI6uAwYAs0A7fBq78nchKhyBiM/Fm3idnZ/P/B36Cq
         OGzyFJbpym4G/bvblY3EvOSQXxp1qcHi9O7Z5Nnk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     notify@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [RFC 1/9] dt-bindings: arm: samsung: Convert Samsung board/soc bindings to json-schema
Date:   Fri, 23 Aug 2019 16:53:48 +0200
Message-Id: <20190823145356.6341-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert Samsung S5P and Exynos SoC bindings to DT schema format using
json-schema.  This is purely conversion of already documented bindings
so it does not cover all of DTS in the Linux kernel (few S5P/Exynos and
all S3C are missing).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

If the schema looks sensible, I will continue on converting other
SoC and driver bindings and later adding missing schemas (S3C
SoCs).
---
 .../bindings/arm/samsung/samsung-boards.txt   |  83 --------
 .../bindings/arm/samsung/samsung-boards.yaml  | 188 ++++++++++++++++++
 2 files changed, 188 insertions(+), 83 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
deleted file mode 100644
index 56021bf2a916..000000000000
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-* Samsung's Exynos and S5P SoC based boards
-
-Required root node properties:
-    - compatible = should be one or more of the following.
-	- "samsung,aries"	- for S5PV210-based Samsung Aries board.
-	- "samsung,fascinate4g"	- for S5PV210-based Samsung Galaxy S Fascinate 4G (SGH-T959P) board.
-	- "samsung,galaxys"	- for S5PV210-based Samsung Galaxy S (i9000)  board.
-	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
-	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
-	- "samsung,monk"	- for Exynos3250-based Samsung Simband board.
-	- "samsung,rinato"	- for Exynos3250-based Samsung Gear2 board.
-	- "samsung,smdkv310"	- for Exynos4210-based Samsung SMDKV310 eval board.
-	- "samsung,trats"	- for Exynos4210-based Tizen Reference board.
-	- "samsung,universal_c210" - for Exynos4210-based Samsung board.
-	- "samsung,i9300"          - for Exynos4412-based Samsung GT-I9300 board.
-	- "samsung,i9305"          - for Exynos4412-based Samsung GT-I9305 board.
-	- "samsung,midas"       - for Exynos4412-based Samsung Midas board.
-	- "samsung,smdk4412",	- for Exynos4412-based Samsung SMDK4412 eval board.
-	- "samsung,n710x"          - for Exynos4412-based Samsung GT-N7100/GT-N7105 board.
-	- "samsung,trats2"	- for Exynos4412-based Tizen Reference board.
-	- "samsung,smdk5250"	- for Exynos5250-based Samsung SMDK5250 eval board.
-	- "samsung,xyref5260"	- for Exynos5260-based Samsung board.
-	- "samsung,smdk5410"	- for Exynos5410-based Samsung SMDK5410 eval board.
-	- "samsung,smdk5420"	- for Exynos5420-based Samsung SMDK5420 eval board.
-	- "samsung,tm2"		- for Exynos5433-based Samsung TM2 board.
-	- "samsung,tm2e"	- for Exynos5433-based Samsung TM2E board.
-
-* Other companies Exynos SoC based
-  * FriendlyARM
-	- "friendlyarm,tiny4412"  - for Exynos4412-based FriendlyARM
-				    TINY4412 board.
-  * TOPEET
-	- "topeet,itop4412-elite" - for Exynos4412-based TOPEET
-                                    Elite base board.
-
-  * Google
-	- "google,pi"		- for Exynos5800-based Google Peach Pi
-				  Rev 10+ board,
-	  also: "google,pi-rev16", "google,pi-rev15", "google,pi-rev14",
-		"google,pi-rev13", "google,pi-rev12", "google,pi-rev11",
-		"google,pi-rev10", "google,peach".
-
-	- "google,pit"		- for Exynos5420-based Google Peach Pit
-				  Rev 6+ (Exynos5420),
-	  also: "google,pit-rev16", "google,pit-rev15", "google,pit-rev14",
-		"google,pit-rev13", "google,pit-rev12", "google,pit-rev11",
-		"google,pit-rev10", "google,pit-rev9", "google,pit-rev8",
-		"google,pit-rev7", "google,pit-rev6", "google,peach".
-
-	- "google,snow-rev4"	- for Exynos5250-based Google Snow board,
-	  also: "google,snow"
-	- "google,snow-rev5"	- for Exynos5250-based Google Snow
-				  Rev 5+ board.
-	- "google,spring"	- for Exynos5250-based Google Spring board.
-
-  * Hardkernel
-	- "hardkernel,odroid-u3"  - for Exynos4412-based Hardkernel Odroid U3.
-	- "hardkernel,odroid-x"   - for Exynos4412-based Hardkernel Odroid X.
-	- "hardkernel,odroid-x2"  - for Exynos4412-based Hardkernel Odroid X2.
-	- "hardkernel,odroid-xu"  - for Exynos5410-based Hardkernel Odroid XU.
-	- "hardkernel,odroid-xu3" - for Exynos5422-based Hardkernel Odroid XU3.
-	- "hardkernel,odroid-xu3-lite" - for Exynos5422-based Hardkernel
-					 Odroid XU3 Lite board.
-	- "hardkernel,odroid-xu4" - for Exynos5422-based Hardkernel Odroid XU4.
-	- "hardkernel,odroid-hc1" - for Exynos5422-based Hardkernel Odroid HC1.
-
-  * Insignal
-	- "insignal,arndale"      - for Exynos5250-based Insignal Arndale board.
-	- "insignal,arndale-octa" - for Exynos5420-based Insignal Arndale
-				    Octa board.
-	- "insignal,origen"       - for Exynos4210-based Insignal Origen board.
-	- "insignal,origen4412"   - for Exynos4412-based Insignal Origen board.
-
-
-Optional nodes:
-    - firmware node, specifying presence and type of secure firmware:
-        - compatible: only "samsung,secure-firmware" is currently supported
-        - reg: address of non-secure SYSRAM used for communication with firmware
-
-	firmware@203f000 {
-		compatible = "samsung,secure-firmware";
-		reg = <0x0203F000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
new file mode 100644
index 000000000000..e963fd70c436
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -0,0 +1,188 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/samsung/samsung-boards.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos and S5P SoC based boards
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: S5PV210 based Aries boards
+        items:
+          - enum:
+              - samsung,fascinate4g             # Samsung Galaxy S Fascinate 4G (SGH-T959P)
+              - samsung,galaxys                 # Samsung Galaxy S (i9000)
+          - const: samsung,aries
+          - const: samsung,s5pv210
+
+      - description: Exynos3250 based boards
+        items:
+          - enum:
+              - samsung,monk                    # Samsung Simband
+              - samsung,rinato                  # Samsung Gear2
+          - const: samsung,exynos3250
+          - const: samsung,exynos3
+
+      - description: Samsung ARTIK5 boards
+        items:
+          - enum:
+              - samsung,artik5-eval             # Samsung ARTIK5 eval board
+          - const: samsung,artik5               # Samsung ARTIK5 module
+          - const: samsung,exynos3250
+          - const: samsung,exynos3
+
+      - description: Exynos4210 based boards
+        items:
+          - enum:
+              - insignal,origen                 # Insignal Origen
+              - samsung,smdkv310                # Samsung SMDKV310 eval
+              - samsung,trats                   # Samsung Tizen Reference
+              - samsung,universal_c210          # Samsung C210
+          - const: samsung,exynos4210
+          - const: samsung,exynos4
+
+      - description: Exynos4412 based boards
+        items:
+          - enum:
+              - friendlyarm,tiny4412            # FriendlyARM TINY4412
+              - hardkernel,odroid-u3            # Hardkernel Odroid U3
+              - hardkernel,odroid-x             # Hardkernel Odroid X
+              - hardkernel,odroid-x2            # Hardkernel Odroid X2
+              - insignal,origen4412             # Insignal Origen
+              - samsung,smdk4412                # Samsung SMDK4412 eval
+              - topeet,itop4412-elite           # TOPEET Elite base
+          - const: samsung,exynos4412
+          - const: samsung,exynos4
+
+      - description: Samsung Midas family boards
+        items:
+          - enum:
+              - samsung,i9300                   # Samsung GT-I9300
+              - samsung,i9305                   # Samsung GT-I9305
+              - samsung,n710x                   # Samsung GT-N7100/GT-N7105
+              - samsung,trats2                  # Samsung Tizen Reference
+          - const: samsung,midas
+          - const: samsung,exynos4412
+          - const: samsung,exynos4
+
+      - description: Exynos5250 based boards
+        items:
+          - enum:
+              - google,snow-rev5                # Google Snow Rev 5+
+              - google,spring                   # Google Spring
+              - insignal,arndale                # Insignal Arndale
+              - samsung,smdk5250                # Samsung SMDK5250 eval
+          - const: samsung,exynos5250
+          - const: samsung,exynos5
+
+      - description: Google Snow Boards (Rev 4+)
+        items:
+          - enum:
+              - google,snow-rev4
+          - const: google,snow
+          - const: samsung,exynos5250
+          - const: samsung,exynos5
+
+      - description: Exynos5260 based boards
+        items:
+          - enum:
+              - samsung,xyref5260               # Samsung Xyref5260 eval
+          - const: samsung,exynos5260
+          - const: samsung,exynos5
+
+      - description: Exynos5410 based boards
+        items:
+          - enum:
+              - hardkernel,odroid-xu            # Hardkernel Odroid XU
+              - samsung,smdk5410                # Samsung SMDK5410 eval
+          - const: samsung,exynos5410
+          - const: samsung,exynos5
+
+      - description: Exynos5420 based boards
+        items:
+          - enum:
+              - insignal,arndale-octa           # Insignal Arndale Octa
+              - samsung,smdk5420                # Samsung SMDK5420 eval
+          - const: samsung,exynos5420
+          - const: samsung,exynos5
+
+      - description: Google Peach Pit Boards (Rev 6+)
+        items:
+          - enum:
+              - google,pit-rev16
+          - const: google,pit-rev15
+          - const: google,pit-rev14
+          - const: google,pit-rev13
+          - const: google,pit-rev12
+          - const: google,pit-rev11
+          - const: google,pit-rev10
+          - const: google,pit-rev9
+          - const: google,pit-rev8
+          - const: google,pit-rev7
+          - const: google,pit-rev6
+          - const: google,pit
+          - const: google,peach
+          - const: samsung,exynos5420
+          - const: samsung,exynos5
+
+      - description: Exynos5800 based boards
+        items:
+          - enum:
+              - hardkernel,odroid-xu3           # Hardkernel Odroid XU3
+              - hardkernel,odroid-xu3-lite      # Hardkernel Odroid XU3 Lite
+              - hardkernel,odroid-xu4           # Hardkernel Odroid XU4
+              - hardkernel,odroid-hc1           # Hardkernel Odroid HC1
+          - const: samsung,exynos5800
+          - const: samsung,exynos5
+
+      - description: Google Peach Pi Boards (Rev 10+)
+        items:
+          - enum:
+              - google,pi-rev16
+          - const: google,pi-rev15
+          - const: google,pi-rev14
+          - const: google,pi-rev13
+          - const: google,pi-rev12
+          - const: google,pi-rev11
+          - const: google,pi-rev10
+          - const: google,pi
+          - const: google,peach
+          - const: samsung,exynos5800
+          - const: samsung,exynos5
+
+      - description: Exynos5433 based boards
+        items:
+          - enum:
+              - samsung,tm2                     # Samsung TM2
+              - samsung,tm2e                    # Samsung TM2E
+          - const: samsung,exynos5433
+
+  firmware:
+    type: object
+    description:
+      node specifying presence and type of secure firmware
+    properties:
+      compatible:
+        enum:
+         - samsung,secure-firmware
+      reg:
+        description:
+          address of non-secure SYSRAM used for communication with firmware
+        maxItems: 1
+
+required:
+  - compatible
+
+examples:
+  - |
+    firmware@203f000 {
+      compatible = "samsung,secure-firmware";
+      reg = <0x0203F000 0x1000>;
+    };
-- 
2.17.1

