Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C54C4529
	for <lists+linux-iio@lfdr.de>; Fri, 25 Feb 2022 14:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbiBYNCl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Feb 2022 08:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiBYNCk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Feb 2022 08:02:40 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C2E1903FD;
        Fri, 25 Feb 2022 05:02:07 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21P66Cd4002715;
        Fri, 25 Feb 2022 08:01:50 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3eesj39j6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 08:01:49 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 21PD1mnp013418
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Feb 2022 08:01:48 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Feb 2022 08:01:47 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Feb 2022 08:01:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Feb 2022 08:01:47 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.71])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 21PD1WL4024659;
        Fri, 25 Feb 2022 08:01:41 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v4 3/3] dt-bindings: iio: Add ltc2688 documentation
Date:   Fri, 25 Feb 2022 14:01:29 +0100
Message-ID: <20220225130129.69-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225130129.69-1-nuno.sa@analog.com>
References: <20220225130129.69-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: pqGhaVoMMejhM1bW81J9d92U9Z7wGQF7
X-Proofpoint-ORIG-GUID: pqGhaVoMMejhM1bW81J9d92U9Z7wGQF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_07,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250074
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the LTC2688 devicetree properties.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/dac/adi,ltc2688.yaml         | 146 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
new file mode 100644
index 000000000000..48f9e7d29423
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ltc2688.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2688 DAC
+
+maintainers:
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  Analog Devices LTC2688 16 channel, 16 bit, +-15V DAC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2688.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc2688
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: Analog Supply Voltage Input.
+
+  iovcc-supply:
+    description: Digital Input/Output Supply Voltage.
+
+  vref-supply:
+    description:
+      Reference Input/Output. The voltage at the REF pin sets the full-scale
+      range of all channels. If not provided the internal reference is used and
+      also provided on the VREF pin".
+
+  clr-gpios:
+    description:
+      If specified, it will be asserted during driver probe. As the line is
+      active low, it should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@([0-9]|1[0-5])$":
+    type: object
+
+    properties:
+      reg:
+        description: The channel number representing the DAC output channel.
+        maximum: 15
+
+      adi,toggle-mode:
+        description:
+          Set the channel as a toggle enabled channel. Toggle operation enables
+          fast switching of a DAC output between two different DAC codes without
+          any SPI transaction.
+        type: boolean
+
+      adi,output-range-microvolt:
+        description: Specify the channel output full scale range.
+        oneOf:
+          - items:
+              - const: 0
+              - enum: [5000000, 10000000]
+          - items:
+              - const: -5000000
+              - const: 5000000
+          - items:
+              - const: -10000000
+              - const: 10000000
+          - items:
+              - const: -15000000
+              - const: 15000000
+
+      adi,overrange:
+        description: Enable 5% overrange over the selected full scale range.
+        type: boolean
+
+      clocks:
+        maxItems: 1
+
+      adi,toggle-dither-input:
+        description:
+          Selects the TGPx pin to be associated with this channel. This setting
+          only makes sense for toggle or dither enabled channels. If
+          @adi,toggle-mode is not set and this property is given, the channel is
+          assumed to be a dither capable channel. Note that multiple channels
+          can be mapped to the same pin. If this setting is given, the
+          respective @clock must also be provided. Mappings between this and
+          input pins
+            0 - TGP1
+            1 - TGP2
+            2 - TGP3
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+
+    dependencies:
+      adi,toggle-dither-input: [ clocks ]
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+
+    spi {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          ltc2688: ltc2688@0 {
+                  compatible = "adi,ltc2688";
+                  reg = <0>;
+
+                  vcc-supply = <&vcc>;
+                  iovcc-supply = <&vcc>;
+                  vref-supply = <&vref>;
+
+                  #address-cells = <1>;
+                  #size-cells = <0>;
+                  channel@0 {
+                          reg = <0>;
+                          adi,toggle-mode;
+                          adi,overrange;
+                  };
+
+                  channel@1 {
+                          reg = <1>;
+                          adi,output-range-microvolt = <0 10000000>;
+
+                          clocks = <&clock_tgp3>;
+                          adi,toggle-dither-input = <2>;
+                  };
+          };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fd22f126dc01..cd81378f5081 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11315,6 +11315,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
+F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
 F:	drivers/iio/dac/ltc2688.c
 
 LTC2947 HARDWARE MONITOR DRIVER
-- 
2.34.1

