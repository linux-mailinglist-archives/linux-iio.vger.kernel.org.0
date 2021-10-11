Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459F3428BAF
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 13:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhJKLDm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 07:03:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9904 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236017AbhJKLDl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 07:03:41 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B75POc027354;
        Mon, 11 Oct 2021 07:01:41 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bm8qfu2sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 07:01:41 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 19BB1eTO030031
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 07:01:40 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Mon, 11 Oct 2021 07:01:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Mon, 11 Oct 2021 07:01:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Mon, 11 Oct 2021 07:01:38 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.136])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 19BB1Y4u009888;
        Mon, 11 Oct 2021 07:01:36 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <antoniu.miclaus@analog.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 2/2] dt-bindings: iio: frequency: add adrf6780 doc
Date:   Mon, 11 Oct 2021 14:00:11 +0300
Message-ID: <20211011110011.104063-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011110011.104063-1-antoniu.miclaus@analog.com>
References: <20211011110011.104063-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: sAGEmhTFvJHHSPT5iVkaRpTlEOJCxlVv
X-Proofpoint-GUID: sAGEmhTFvJHHSPT5iVkaRpTlEOJCxlVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110063
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the ADRF6780 Upconverter.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v7:
 - improve description of the device properties based on the feedback
   received from the datasheet people
 .../bindings/iio/frequency/adi,adrf6780.yaml  | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
new file mode 100644
index 000000000000..3a8ea93f4e0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,adrf6780.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADRF6780 Microwave Upconverter
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+   Wideband, microwave upconverter optimized for point to point microwave
+   radio designs operating in the 5.9 GHz to 23.6 GHz frequency range.
+
+   https://www.analog.com/en/products/adrf6780.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adrf6780
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  clocks:
+    description:
+      Definition of the external clock.
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: lo_in
+
+  clock-output-names:
+    maxItems: 1
+
+  adi,vga-buff-en:
+    description:
+      RF Variable Gain Amplifier Buffer Enable. Gain is controlled by
+      the voltage on the VATT pin.
+    type: boolean
+
+  adi,lo-buff-en:
+    description:
+      Local Oscillator Amplifier Enable. Disable to put the part in
+      a power down state.
+    type: boolean
+
+  adi,if-mode-en:
+    description:
+      Intermediate Frequency Mode Enable. Either IF Mode or I/Q Mode
+      can be enabled at a time.
+    type: boolean
+
+  adi,iq-mode-en:
+    description:
+      I/Q Mode Enable. Either IF Mode or I/Q Mode can be enabled at a
+      time.
+    type: boolean
+
+  adi,lo-x2-en:
+    description:
+      Double the Local Oscillator output frequency from the Local
+      Oscillator Input Frequency. Either LOx1 or LOx2 can be enabled
+      at a time.
+    type: boolean
+
+  adi,lo-ppf-en:
+    description:
+      Local Oscillator input frequency equal to the Local Oscillator
+      output frequency (LO x1). Either LOx1 or LOx2 can be enabled
+      at a time.
+    type: boolean
+
+  adi,lo-en:
+    description:
+      Enable additional cirtuitry in the LO chain. Disable to put the
+      part in a power down state.
+    type: boolean
+
+  adi,uc-bias-en:
+    description:
+      Enable all bias circuitry thourghout the entire part.
+      Disable to put the part in a power down state.
+    type: boolean
+
+  adi,lo-sideband:
+    description:
+      Switch to the Lower LO Sideband. By default the Upper LO
+      sideband is enabled.
+    type: boolean
+
+  adi,vdet-out-en:
+    description:
+      VDET Output Select Enable. Expose the RF detector output to the
+      VDET external pin.
+    type: boolean
+
+  '#clock-cells':
+    const: 0
+
+dependencies:
+  adi,lo-x2-en: [ "adi,lo-en" ]
+  adi,lo-ppf-en: [ "adi,lo-en" ]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      adrf6780@0 {
+        compatible = "adi,adrf6780";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        clocks = <&adrf6780_lo>;
+        clock-names = "lo_in";
+      };
+    };
+...
-- 
2.33.0

