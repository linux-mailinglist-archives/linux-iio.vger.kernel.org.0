Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5694242D6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Oct 2021 18:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhJFQku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Oct 2021 12:40:50 -0400
Received: from box.trvn.ru ([194.87.146.52]:58495 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231987AbhJFQkt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 Oct 2021 12:40:49 -0400
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 7954D4287D;
        Wed,  6 Oct 2021 21:31:16 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1633537876; bh=XIWa6AjmyBCN/A/Zr/I9momFkQe7nNV9FW9rvb/SFfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYZdxReH8qxqh4VITh1IOwwhEeXfucjXXpqiSzvZtQCOSHMjCvGZjHIz+8GcIPQSF
         4Bro54fuKnc7Eoirt5Iko7RVIm3eEX0nRSts0guX/lommAWTjRRCzyz7f/UqFagLMk
         CoPrLM+jFPC+LU50wEkH35kow388+AeLFp/VMsLPfWMygUT1X4ZvC8ASeLoqxOvH9d
         ahxTjofVuWTLGsdtMykx+vkeQThm2bkPVWmtWrkmlXHqYeLSGRC+F4w16ioCpcEeOq
         Egl3yRKC7zwz5pD/NnoJzWTr5BIxV2GeYKLDDODPqYKoYZ9Q8oyF35/0jFdqxdyYMG
         5yuIof5NLe0+Q==
From:   Nikita Travkin <nikita@trvn.ru>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, stephan@gerhold.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 2/4] dt-bindings: iio: light: Document ltr501 light sensor bindings
Date:   Wed,  6 Oct 2021 21:30:56 +0500
Message-Id: <20211006163058.145842-2-nikita@trvn.ru>
In-Reply-To: <20211006163058.145842-1-nikita@trvn.ru>
References: <20211006163058.145842-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree bindings for ltr501, ltr559 and ltr301.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../bindings/iio/light/liteon,ltr501.yaml     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
new file mode 100644
index 000000000000..db0407bc9209
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/liteon,ltr501.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LiteON LTR501 I2C Proximity and Light sensor
+
+maintainers:
+  - Nikita Travkin <nikita@trvn.ru>
+
+properties:
+  compatible:
+    enum:
+      - liteon,ltr501
+      - liteon,ltr559
+      - liteon,ltr301
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
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
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@23 {
+            compatible = "liteon,ltr559";
+            reg = <0x23>;
+            vdd-supply = <&pm8916_l17>;
+            vddio-supply = <&pm8916_l6>;
+
+            interrupt-parent = <&msmgpio>;
+            interrupts = <115 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
-- 
2.30.2

