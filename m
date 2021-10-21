Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A2243605A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhJULfX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 07:35:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47210 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231176AbhJULfW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 07:35:22 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L8gAfr028060;
        Thu, 21 Oct 2021 07:33:06 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3btk71npvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 07:33:06 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 19LBX4Zo043070
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Oct 2021 07:33:05 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 21 Oct 2021
 04:33:03 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 21 Oct 2021 04:33:03 -0700
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.108])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 19LBWxlY015112;
        Thu, 21 Oct 2021 07:33:00 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
CC:     <antoniu.miclaus@analog.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v9 2/2] dt-bindings: iio: frequency: add adrf6780 doc
Date:   Thu, 21 Oct 2021 14:32:44 +0300
Message-ID: <20211021113244.56936-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211021113244.56936-1-antoniu.miclaus@analog.com>
References: <20211021113244.56936-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 9I2BorKqik7HM-6xCaYp_JGjmeAPgMvK
X-Proofpoint-GUID: 9I2BorKqik7HM-6xCaYp_JGjmeAPgMvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the ADRF6780 Upconverter.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v9
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
2.33.1

