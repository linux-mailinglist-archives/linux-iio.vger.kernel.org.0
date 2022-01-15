Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4962448F627
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 10:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiAOJ1r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 04:27:47 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58778 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231480AbiAOJ1r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 04:27:47 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20F7xFcp003429;
        Sat, 15 Jan 2022 04:27:29 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dks07rnud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jan 2022 04:27:29 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20F9RSuh015124
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Jan 2022 04:27:28 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 15 Jan 2022 04:27:27 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 15 Jan 2022 04:27:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 15 Jan 2022 04:27:27 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.71])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20F9RBL8010081;
        Sat, 15 Jan 2022 04:27:20 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v2 3/3] dt-bindings: iio: Add ltc2688 documentation
Date:   Sat, 15 Jan 2022 10:27:05 +0100
Message-ID: <20220115092705.491-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220115092705.491-1-nuno.sa@analog.com>
References: <20220115092705.491-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: q8X5JNsaKrW3ZAFAXkcXxUCpaGbI9Cv1
X-Proofpoint-ORIG-GUID: q8X5JNsaKrW3ZAFAXkcXxUCpaGbI9Cv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-15_01,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the LTC2688 devicetree properties.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../bindings/iio/dac/adi,ltc2688.yaml         | 147 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
new file mode 100644
index 000000000000..ecd0943fb813
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
@@ -0,0 +1,147 @@
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
+      range of all channels. By default, the internal reference is routed to
+      this pin.
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
+          any SPI transaction. It will result in a different ABI for the
+          channel.
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
+          clocks
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
index 16a7fd7f98ee..137d4ed992cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11188,6 +11188,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
+F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
 F:	drivers/iio/dac/ltc2688.c
 
 LTC2947 HARDWARE MONITOR DRIVER
-- 
2.33.1

