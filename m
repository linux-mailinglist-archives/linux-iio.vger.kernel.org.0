Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB041C8C1C
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgEGNZR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 09:25:17 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53638 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbgEGNZQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 May 2020 09:25:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 91A704C844;
        Thu,  7 May 2020 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588857909; x=1590672310; bh=xI7OXxUNJfQlxBqN+ExXRkqa3CSJstsGyKI
        w55C7GwU=; b=TzwoQp+YCOVHCFYQwEgvnTfWiTKp1l8RRUtJuRl3pS1krLLOqNv
        vTYolMWUlLNgC9IlXoE2p73Iqu9a2N8VE5A02KjbIN22HVvumXBU8NFwfvU7DWX2
        jwonlSFQ5KPh86bE8LxWEpWyLAIr/L9Hn50jJYYNHCpQcT5oqR6auvCw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DgCWfimcnoLq; Thu,  7 May 2020 16:25:09 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 50EA94C83E;
        Thu,  7 May 2020 16:25:07 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.0.174) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 7 May 2020 16:25:08 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v13 1/2] dt-bindings: proximity: provide vcnl3020 device tree binding document
Date:   Thu, 7 May 2020 16:25:59 +0300
Message-ID: <20200507132600.8801-2-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200507132600.8801-1-i.mikhaylov@yadro.com>
References: <20200507132600.8801-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.174]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Mostly standard i2c driver with some additional led-current option
for vcnl3020.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 .../iio/proximity/vishay,vcnl3020.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
new file mode 100644
index 000000000000..408dee17cdf5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/vishay,vcnl3020.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Integrated Proximity Sensor With Infrared Emitter
+
+maintainers:
+  - Ivan Mikhaylov <i.mikhaylov@yadro.com>
+
+description: |
+  The VCNL3020 is a fully integrated proximity sensor. Fully integrated means
+  that the infrared emitter is included in the package. It has 16-bit
+  resolution. It includes a signal processing IC and features standard I2C
+  communication interface. It features an interrupt function.
+
+  Specifications about the devices can be found at:
+  https://www.vishay.com/docs/84150/vcnl3020.pdf
+
+properties:
+  compatible:
+    enum:
+      - vishay,vcnl3020
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  vddio-supply:
+    description: Regulator that provides power to the bus
+
+  vishay,led-current-microamp:
+    description:
+      IR LED current value with valid Range = 0 to 20d. e.g. 0 = 0 mA,
+      1 = 10 mA, 20 = 200 mA. LED Current is limited to 200 mA for values
+      higher than decimal 20. The drive current for the LED used in proximity
+      sensing.
+    enum: [0, 10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000,
+          100000, 110000, 120000, 130000, 140000, 150000, 160000, 170000,
+          180000, 190000, 200000]
+    default: 20000
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@13 {
+              compatible = "vishay,vcnl3020";
+              reg = <0x13>;
+              vishay,led-current-microamp = <200000>;
+        };
+    };
-- 
2.21.1

