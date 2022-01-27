Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0363349E176
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jan 2022 12:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbiA0Lrt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jan 2022 06:47:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55274 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240021AbiA0Lrs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jan 2022 06:47:48 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RBBs1C007205;
        Thu, 27 Jan 2022 06:47:41 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dtr97ndk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 06:47:41 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20RBlexH054185
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jan 2022 06:47:40 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 27 Jan
 2022 06:47:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Jan 2022 06:47:17 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.119])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20RBlUdl014283;
        Thu, 27 Jan 2022 06:47:36 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 2/4] dt-bindings:iio:frequency: add admv1014 binding
Date:   Thu, 27 Jan 2022 12:55:56 +0200
Message-ID: <20220127105558.59567-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127105558.59567-1-antoniu.miclaus@analog.com>
References: <20220127105558.59567-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ckxBIeuUXfwYnsHZqTMU7PS1gzG3Pkzx
X-Proofpoint-GUID: ckxBIeuUXfwYnsHZqTMU7PS1gzG3Pkzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270070
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the ADMV1014 Upconverter.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - add all regulators in the dts example
 .../bindings/iio/frequency/adi,admv1014.yaml  | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
new file mode 100644
index 000000000000..fe352c01dd94
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,admv1014.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADMV1014 Microwave Downconverter
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+   Wideband, microwave downconverter optimized for point to point microwave
+   radio designs operating in the 24 GHz to 44 GHz frequency range.
+
+   https://www.analog.com/en/products/admv1014.html
+
+properties:
+  compatible:
+    enum:
+      - adi,admv1014
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: lo_in
+    description:
+      External clock that provides the Local Oscilator input.
+
+  vcm-supply:
+    description:
+      Common-mode voltage regulator.
+
+  vcc-if-bb-supply:
+    description:
+      BB and IF supply voltage regulator.
+
+  vcc-vga-supply:
+    description:
+      RF Amplifier supply voltage regulator.
+
+  vcc-vva-supply:
+    description:
+      VVA Control Circuit supply voltage regulator.
+
+  vcc-lna-3p3-supply:
+    description:
+      Low Noise Amplifier 3.3V supply voltage regulator.
+
+  vcc-lna-1p5-supply:
+    description:
+      Low Noise Amplifier 1.5V supply voltage regulator.
+
+  vcc-bg-supply:
+    description:
+      Band Gap Circuit supply voltage regulator.
+
+  vcc-quad-supply:
+    description:
+      Quadruple supply voltage regulator.
+
+  vcc-mixer-supply:
+    description:
+      Mixer supply voltage regulator.
+
+  adi,input-mode:
+    description:
+      Select the input mode.
+      iq - in-phase quadrature (I/Q) input
+      if - complex intermediate frequency (IF) input
+    enum: [iq, if]
+
+  adi,detector-enable:
+    description:
+      Digital Rx Detector Enable. The Square Law Detector output is
+      available at output pin VDET.
+    type: boolean
+
+  adi,p1db-compensation-enable:
+    description:
+      Turn on bits to optimize P1dB.
+    type: boolean
+
+  adi,quad-se-mode:
+    description:
+      Switch the LO path from differential to single-ended operation.
+      se-neg - Single-Ended Mode, Negative Side Disabled.
+      se-pos - Single-Ended Mode, Positive Side Disabled.
+      diff - Differential Mode.
+    enum: [se-neg, se-pos, diff]
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - vcm-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      admv1014@0{
+        compatible = "adi,admv1014";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        clocks = <&admv1014_lo>;
+        clock-names = "lo_in";
+        vcm-supply = <&vcm>;
+        vcc-if-bb-supply = <&vcc_if_bb>;
+        vcc-vga-supply = <&vcc_vga>;
+        vcc-vva-supply = <&vcc_vva>;
+        vcc-lna-3p3-supply = <&vcc_lna_3p3>;
+        vcc-lna-1p5-supply = <&vcc_lna_1p5>;
+        vcc-bg-supply = <&vcc_bg>;
+        vcc-quad-supply = <&vcc_quad>;
+        vcc-mixer-supply = <&vcc_mixer>;
+        adi,quad-se-mode = "diff";
+        adi,detector-enable;
+        adi,p1db-compensation-enable;
+      };
+    };
+...
-- 
2.35.0

