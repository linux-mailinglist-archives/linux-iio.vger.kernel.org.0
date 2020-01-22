Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F890145445
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2020 13:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgAVMPv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jan 2020 07:15:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39556 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729188AbgAVMPv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jan 2020 07:15:51 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MCFUSE012424;
        Wed, 22 Jan 2020 07:15:30 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkvrbjpyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 07:15:29 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 00MCFSpL041152
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 22 Jan 2020 07:15:28 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 22 Jan
 2020 07:15:28 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 22 Jan 2020 04:15:27 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00MCF512031122;
        Wed, 22 Jan 2020 07:15:19 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 2/3] dt-bindings: iio: amplifiers: Add docs for HMC425A Step Attenuator
Date:   Wed, 22 Jan 2020 14:17:01 +0200
Message-ID: <20200122121702.30494-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122121702.30494-1-beniamin.bia@analog.com>
References: <20200122121702.30494-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001220112
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Document support for Analog Devices MC425A Step Attenuator.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
new file mode 100644
index 000000000000..a0afa661f4ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/amplifiers/adi,hmc425a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HMC425A 6-bit Digital Step Attenuator
+
+maintainers:
+- Michael Hennerich <michael.hennerich@analog.com>
+- Beniamin Bia <beniamin.bia@analog.com>
+
+description: |
+  Digital Step Attenuator IIO device with gpio interface.
+  HMC425A 0.5 dB LSB GaAs MMIC 6-BIT DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz
+  https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,hmc425a
+
+  vcc-supply:
+    description:
+      Digital voltage regulator (see regulator/regulator.txt)
+    maxItems: 1
+
+  ctrl-gpios:
+    description:
+      Must contain an array of 6 GPIO specifiers, referring to the GPIO pins
+      connected to the control pins V1-V6.
+    maxItems: 6
+
+required:
+  - compatible
+  - ctrl-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    gpio {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      gpio_hmc425a: hmc425a {
+        compatible = "adi,hmc425a";
+        ctrl-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>,
+          <&gpio 39 GPIO_ACTIVE_HIGH>,
+          <&gpio 38 GPIO_ACTIVE_HIGH>,
+          <&gpio 37 GPIO_ACTIVE_HIGH>,
+          <&gpio 36 GPIO_ACTIVE_HIGH>,
+          <&gpio 35 GPIO_ACTIVE_HIGH>;
+
+        vcc-supply = <&foo>;
+      };
+    };
+...
-- 
2.17.1

