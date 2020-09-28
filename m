Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5655427AA5E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Sep 2020 11:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgI1JKo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Sep 2020 05:10:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14396 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbgI1JKi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Sep 2020 05:10:38 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08S97Mpl021177;
        Mon, 28 Sep 2020 05:10:37 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4ej10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 05:10:37 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08S9AZWr065296
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 28 Sep 2020 05:10:36 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 28 Sep
 2020 02:10:29 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 28 Sep 2020 02:10:29 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08S9ANjY026287;
        Mon, 28 Sep 2020 05:10:31 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v7 4/5] dt-bindings:iio:adc:adi,ad7768-1: Add documentation for channel label
Date:   Mon, 28 Sep 2020 12:09:58 +0300
Message-ID: <20200928090959.88842-4-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928090959.88842-1-cristian.pop@analog.com>
References: <20200928090959.88842-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_07:2020-09-24,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Optional attribute for better identification of the channels.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changes in v7:
 - Add "additionalProperties: false" for channel child nodes.
 - Fix "reg" spelling.
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index d3733ad8785a..6be43bf5c1e0 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -29,6 +29,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   vref-supply:
     description:
       ADC reference voltage supply
@@ -61,6 +67,24 @@ required:
   - spi-cpha
   - adi,sync-in-gpios
 
+patternProperties:
+  "^channel@([0-9]|1[0-5])$":
+    type: object
+    description: |
+      Represents the external channels which are connected to the device.
+
+    properties:
+      reg:
+        description: |
+          The channel number.
+
+      label:
+        description: |
+          Unique name to identify which channel this is.
+    required:
+      - reg
+    additionalProperties: false
+
 additionalProperties: false
 
 examples:
@@ -84,6 +108,14 @@ examples:
             reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
             clocks = <&ad7768_mclk>;
             clock-names = "mclk";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                label = "channel_0";
+            };
         };
     };
 ...
-- 
2.17.1

