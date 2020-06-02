Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD811EC077
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 18:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgFBQuN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 12:50:13 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:55861 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727011AbgFBQuB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 12:50:01 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.4.71])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 1BFE5550B0B6;
        Tue,  2 Jun 2020 18:49:56 +0200 (CEST)
Received: from localhost.localdomain (34.103.240.103) by DAG2EX1.emp2.local
 (172.16.2.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 2 Jun 2020
 18:49:55 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v3 4/4] dt-bindings: iio: scd30: add device binding file
Date:   Tue, 2 Jun 2020 18:47:23 +0200
Message-ID: <20200602164723.28858-5-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602164723.28858-1-tomasz.duszynski@octakon.com>
References: <20200602164723.28858-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [34.103.240.103]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 9454181519848266775
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvffekueetkefhtedufffftdduteehvddvveehhfekffegueefveetjeeitddtleenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedtrddtrddtrddtpdefgedruddtfedrvdegtddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehpmhgvvghrfiesphhmvggvrhifrdhnvght
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add SCD30 sensor binding file.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 .../iio/chemical/sensirion,scd30.yaml         | 68 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
new file mode 100644
index 000000000000..40d87346ff4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
+
+additionalProperties: false
+
+examples:
+  - |
+    # include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      co2-sensor@61 {
+        compatible = "sensirion,scd30";
+        reg = <0x61>;
+        vdd-supply = <&vdd>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
+  - |
+    # include <dt-bindings/interrupt-controller/irq.h>
+    serial {
+      co2-sensor {
+        compatible = "sensirion,scd30";
+        vdd-supply = <&vdd>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 5db4b446c8ba..0ab9cf39e051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15140,6 +15140,7 @@ F:	include/uapi/linux/phantom.h
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
 M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
 F:	drivers/iio/chemical/scd30.h
 F:	drivers/iio/chemical/scd30_core.c
 F:	drivers/iio/chemical/scd30_i2c.c
-- 
2.26.2

