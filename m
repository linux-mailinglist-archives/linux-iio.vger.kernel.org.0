Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1762B5B212B
	for <lists+linux-iio@lfdr.de>; Thu,  8 Sep 2022 16:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiIHOuY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Sep 2022 10:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIHOuX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Sep 2022 10:50:23 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0C75F23F
        for <linux-iio@vger.kernel.org>; Thu,  8 Sep 2022 07:50:22 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288EKAaO030796;
        Thu, 8 Sep 2022 10:50:13 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jf8ybuw9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 10:50:13 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 288EoCog049909
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Sep 2022 10:50:12 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 Sep 2022 10:50:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 Sep 2022 10:50:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 Sep 2022 10:50:09 -0400
Received: from ibrahim-vm.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.16.132])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 288EnsW3023822;
        Thu, 8 Sep 2022 10:50:05 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jic23@kernel.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: [PATCH v4 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Date:   Thu, 8 Sep 2022 17:49:23 +0300
Message-ID: <20220908144924.205547-3-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220908144924.205547-1-Ibrahim.Tilki@analog.com>
References: <20220908144924.205547-1-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Op1CKJZ8Kfd0jUliljo0lHPebrczYV_7
X-Proofpoint-ORIG-GUID: Op1CKJZ8Kfd0jUliljo0lHPebrczYV_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding devicetree binding documentation for max11410 adc.

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
---
 .../bindings/iio/adc/adi,max11410.yaml        | 174 ++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
new file mode 100644
index 000000000..3ffab284b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
@@ -0,0 +1,174 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,max11410.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX11410 ADC device driver
+
+maintainers:
+  - Ibrahim Tilki <ibrahim.tilki@analog.com>
+
+description: |
+  Bindings for the Analog Devices MAX11410 ADC device. Datasheet can be
+  found here:
+    https://datasheets.maximintegrated.com/en/ds/MAX11410.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,max11410
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    description: Name of the gpio pin of max11410 used for IRQ
+    maxItems: 1
+    items:
+      enum:
+        - gpio0
+        - gpio1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  avdd-supply:
+    description: Necessarry avdd supply. Used as reference when no explicit reference supplied.
+
+  vref0p-supply:
+    description: vref0p supply can be used as reference for conversion.
+
+  vref1p-supply:
+    description: vref1p supply can be used as reference for conversion.
+
+  vref2p-supply:
+    description: vref2p supply can be used as reference for conversion.
+
+  vref0n-supply:
+    description: vref0n supply can be used as reference for conversion.
+
+  vref1n-supply:
+    description: vref1n supply can be used as reference for conversion.
+
+  vref2n-supply:
+    description: vref2n supply can be used as reference for conversion.
+
+  spi-max-frequency:
+    maximum: 8000000
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+
+patternProperties:
+  "^channel(@[0-9a-f]+)?$":
+    $ref: "adc.yaml"
+    type: object
+    description: Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: The channel number in single-ended mode.
+        minimum: 0
+        maximum: 9
+
+      adi,reference:
+        description: |
+          Select the reference source to use when converting on
+          the specific channel. Valid values are:
+          0: VREF0P/VREF0N
+          1: VREF1P/VREF1N
+          2: VREF2P/VREF2N
+          3: AVDD/AGND
+          4: VREF0P/AGND
+          5: VREF1P/AGND
+          6: VREF2P/AGND
+          If this field is left empty, AVDD/AGND is selected.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3, 4, 5, 6]
+        default: 3
+
+      adi,input-mode:
+        description: |
+          Select signal path of input channels. Valid values are:
+          0: Buffered, low-power, unity-gain path (default)
+          1: Bypass path
+          2: PGA path
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+        default: 0
+
+      diff-channels: true
+
+      bipolar: true
+
+      settling-time-us: true
+
+      adi,buffered-vrefp:
+        description: Enable buffered mode for positive reference.
+        type: boolean
+
+      adi,buffered-vrefn:
+        description: Enable buffered mode for negative reference.
+        type: boolean
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        reg = <0>;
+        compatible = "adi,max11410";
+        spi-max-frequency = <8000000>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <25 2>;
+        interrupt-names = "gpio1";
+
+        avdd-supply = <&adc_avdd>;
+
+        vref1p-supply = <&adc_vref1p>;
+        vref1n-supply = <&adc_vref1n>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+          reg = <0>;
+        };
+
+        channel@1 {
+          reg = <1>;
+          diff-channels = <2 3>;
+          adi,reference = <1>;
+          bipolar;
+          settling-time-us = <100000>;
+        };
+
+        channel@2 {
+          reg = <2>;
+          diff-channels = <7 9>;
+          adi,reference = <5>;
+          adi,input-mode = <2>;
+          settling-time-us = <50000>;
+        };
+      };
+    };
-- 
2.36.1

