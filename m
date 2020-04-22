Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95A1B470B
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgDVOUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 10:20:12 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:37741 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727819AbgDVOUK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 10:20:10 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.1.71])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 613665A6DE74;
        Wed, 22 Apr 2020 16:13:08 +0200 (CEST)
Received: from arch.lan (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Apr
 2020 16:13:07 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 5/6] dt-bindings: iio: scd30: add device binding file
Date:   Wed, 22 Apr 2020 16:11:34 +0200
Message-ID: <20200422141135.86419-6-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 5833287420189891607
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeejgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkpheptddrtddrtddrtddpkeelrdejtddrfedurddvtdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhg
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add SCD30 sensor binding file.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 .../iio/chemical/sensirion,scd30.yaml         | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
new file mode 100644
index 000000000000..b092b2530c76
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/sensirion,scd30.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SCD30 carbon dioxide sensor
+
+maintainers:
+  - Tomasz Duszynski <tomasz.duszynski@octakon.com>
+
+description: |
+  Air quality sensor capable of measuring co2 concentration, temperature
+  and relative humidity.
+
+properties:
+  compatible:
+    enum:
+      - sensirion,scd30
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  sensirion,sel-gpios:
+    description: GPIO connected to the SEL line
+    maxItems: 1
+
+  sensirion,pwm-gpios:
+    description: GPIO connected to the PWM line
+    maxItems: 1
+
+required:
+  - compatible
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    # include <dt-bindings/gpio/gpio.h>
+    # include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      scd30@61 {
+        compatible = "sensirion,scd30";
+        reg = <0x61>;
+        vdd-supply = <&vdd>;
+        interrupt-parrent = <&gpio0>;
+        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
+  - |
+    # include <dt-bindings/gpio/gpio.h>
+    # include <dt-bindings/interrupt-controller/irq.h>
+    serial {
+      scd30 {
+        compatible = "sensirion,scd30";
+        vdd-supply = <&vdd>;
+        interrupt-parrent = <&gpio0>;
+        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
+
+...
-- 
2.26.1

