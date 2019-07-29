Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D7078AD1
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 13:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbfG2Lqb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 07:46:31 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:58560 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387638AbfG2Lqa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jul 2019 07:46:30 -0400
Received: from [46.114.3.104] (helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1hs46k-0004HW-O3; Mon, 29 Jul 2019 13:46:26 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v3 2/2] dt-bindings: iio: potentiometer: add max5432.yaml binding
Date:   Mon, 29 Jul 2019 13:45:31 +0200
Message-Id: <20190729114531.12386-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190729114531.12386-1-martin@kaiser.cx>
References: <20190721175915.27192-1-martin@kaiser.cx>
 <20190729114531.12386-1-martin@kaiser.cx>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a binding for the Maxim Integrated MAX5432-MAX5435 family of digital
potentiometers.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
changes in v3
 - split dt bindings and driver code into separate patches
 - use yaml format for dt bindings
 - fix formatting of parameter lists

changes in v2
 - use MAX5432_ prefix for all defines
 - fix indentation
 - convert void * to unsigned long, not to u32
   (warning from kbuild test robot)

 .../bindings/iio/potentiometer/max5432.yaml        | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5432.yaml

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/max5432.yaml b/Documentation/devicetree/bindings/iio/potentiometer/max5432.yaml
new file mode 100644
index 000000000000..448781b80f39
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/max5432.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/potentiometer/max5432.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX5432-MAX5435 Digital Potentiometers
+
+maintainers:
+  - Martin Kaiser <martin@kaiser.cx>
+
+description: |
+  Maxim Integrated MAX5432-MAX5435 Digital Potentiometers connected via I2C
+
+  Datasheet:
+    https://datasheets.maximintegrated.com/en/ds/MAX5432-MAX5435.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max5432
+      - maxim,max5433
+      - maxim,max5434
+      - maxim,max5435
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      max5434@28 {
+        compatible = "maxim,max5434";
+        reg = <0x28>;
+      };
+    };
-- 
2.11.0

