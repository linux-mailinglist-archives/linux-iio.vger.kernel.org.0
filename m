Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E72442FA0
	for <lists+linux-iio@lfdr.de>; Tue,  2 Nov 2021 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhKBOC4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Nov 2021 10:02:56 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21806 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231267AbhKBOC4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Nov 2021 10:02:56 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A2BZ9q7019241;
        Tue, 2 Nov 2021 10:00:21 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c2g25nhqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 10:00:20 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1A2E0Iep063923
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Nov 2021 10:00:19 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 2 Nov 2021 07:00:18 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 2 Nov 2021 07:00:17 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Tue, 2 Nov 2021 07:00:17 -0700
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A2E0CvE031291;
        Tue, 2 Nov 2021 10:00:15 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] dt-bindings:iio:amplifiers: add ad7293 doc
Date:   Tue, 2 Nov 2021 15:59:47 +0200
Message-ID: <20211102135947.131223-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211102135947.131223-1-antoniu.miclaus@analog.com>
References: <20211102135947.131223-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: TG0gVOD6GLlg0IOZdoJbvLjZ7G23UBvN
X-Proofpoint-GUID: TG0gVOD6GLlg0IOZdoJbvLjZ7G23UBvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=882 suspectscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020083
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the AD7293 Power Amplifier.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/amplifiers/adi,ad7293.yaml   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
new file mode 100644
index 000000000000..b9cfd4621fb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/amplifiers/adi,ad7293.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AD7293 12-Bit Power Amplifier Current Controller with ADC,
+       DACs, Temperature and Current Sensors
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+   Power Amplifier drain current controller containing functionality
+   for general-purpose monitoring and control of current, voltage,
+   and temperature, integrated into a single chip solution with an
+   SPI-compatible interface.
+
+   https://www.analog.com/en/products/ad7293.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7293
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ad7293@0 {
+        compatible = "adi,ad7293";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+      };
+    };
+...
-- 
2.33.1

