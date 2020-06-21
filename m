Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737D1202C91
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 22:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgFUUAd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 16:00:33 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:47421 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730583AbgFUUA0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 16:00:26 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.16.245])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id A5A8D63E9775;
        Sun, 21 Jun 2020 22:00:23 +0200 (CEST)
Received: from arch.lan (89.70.180.118) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 21 Jun
 2020 22:00:22 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 4/4] dt-bindings: iio: scd30: add device binding file
Date:   Sun, 21 Jun 2020 21:57:01 +0200
Message-ID: <20200621195701.97227-5-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200621195701.97227-1-tomasz.duszynski@octakon.com>
References: <20200621195701.97227-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.180.118]
X-ClientProxiedBy: CAS1.emp2.local (172.16.1.1) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 13571316005272050711
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudektddgudegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvffekueetkefhtedufffftdduteehvddvveehhfekffegueefveetjeeitddtleenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedtrddtrddtrddtpdekledrjedtrddukedtrdduudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add SCD30 sensor binding file.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.27.0

