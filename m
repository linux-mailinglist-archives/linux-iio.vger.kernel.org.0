Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE9027258F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 15:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgIUNa4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 09:30:56 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28820 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726749AbgIUNax (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 09:30:53 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LDUFaK022846;
        Mon, 21 Sep 2020 09:30:51 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33nbu66g9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 09:30:51 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08LDUo3X064179
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 21 Sep 2020 09:30:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 21 Sep
 2020 09:30:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 21 Sep 2020 09:30:52 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08LDUW2H021472;
        Mon, 21 Sep 2020 09:30:47 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v6 4/4] dt-bindings:iio:adc:adi,ad7768-1: Add documentation for channel label
Date:   Mon, 21 Sep 2020 16:30:20 +0300
Message-ID: <20200921133020.62978-4-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921133020.62978-1-cristian.pop@analog.com>
References: <20200921133020.62978-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_05:2020-09-21,2020-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210097
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Optional attribute for better identification of the channels.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index d3733ad8785a..0c75ce73ffe9 100644
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
@@ -61,6 +67,23 @@ required:
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
+      - rega
+
 additionalProperties: false
 
 examples:
@@ -84,6 +107,14 @@ examples:
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

