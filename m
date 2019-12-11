Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7080E11A8AA
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 11:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfLKKMv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 05:12:51 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:59536 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbfLKKMu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 05:12:50 -0500
Received: from pps.filterd (m0135535.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB9opf7021472;
        Wed, 11 Dec 2019 09:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=08102019; bh=hBpav1OEI9tDoMnlQPjNCargclo6mCzP2t1pNLr4U8k=;
 b=cM365pSawBJoD1Ja8tC7Jd1TXIZRM4FAX2wE4yy7onY9oEJKcg3e1PnmIAOo8r+XF+2R
 3BOKg34YyuQTyDTpvCQUToQvX1TsZfUMAl8wEv67/0LheOWC2c7nLlD7+gu/XicVJGGM
 6GhqZqLQpJICv4k4LXyWAGwdQ/pUAmInH691Pga+NaXooMzLVksJLe0bS+zbtUAaAXOM
 QUGSJ2DTMPFaaoEe4SpddZnV67pCzGMsZ8uICfXjm12pNtuq5wmmPML8SQum+eHzR9QR
 x3l0QsLNo5AsNIa8ojJmMb+B6eVHO7XawLIjEL3F8hLaAumjs/09jjQI8h6f7A0hC/aA xw== 
Received: from atgrzso2833.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2wr59gpu5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 09:59:48 +0000
Received: from pps.filterd (atgrzso2833.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2833.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xBB7n3iC018073;
        Wed, 11 Dec 2019 10:59:48 +0100
Received: from atgrzsw1692.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2833.avl01.avlcorp.lan with ESMTP id 2wr4nrhvu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 10:59:47 +0100
Received: from ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) by
 ATGRZSW1692.avl01.avlcorp.lan (10.12.64.113) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Dec 2019 10:59:47 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 11 Dec 2019 10:59:47 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v4 3/3] bindings: iio: pressure: Add documentation for dlh driver
Date:   Wed, 11 Dec 2019 10:59:46 +0100
Message-ID: <20191211095946.7904-4-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
In-Reply-To: <20191211095946.7904-1-tomislav.denis@avl.com>
References: <20191211095946.7904-1-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=762
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110062
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_02:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=1 lowpriorityscore=0 malwarescore=0
 mlxlogscore=818 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912110086
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

Add a device tree binding documentation for DLH series pressure
sensors.

Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
---
 .../devicetree/bindings/iio/pressure/asc,dlh.yaml  | 51 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml b/Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml
new file mode 100644
index 0000000..c2c1817
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/dlh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: All Sensors DLH series low voltage digital pressure sensors
+
+maintainers:
+  - Tomislav Denis <tomislav.denis@avl.com>
+
+description: |
+  Bindings for the All Sensors DLH series pressure sensors.
+
+  Specifications about the sensors can be found at:
+    http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
+
+properties:
+  compatible:
+    enum:
+      - asc,dlhl60d
+      - asc,dlhl60g
+
+  reg:
+    description: I2C device address
+    maxItems: 1
+
+  interrupts:
+    description: interrupt mapping for EOC(data ready) pin
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pressure@29 {
+          compatible = "asc,dlhl60d";
+          reg = <0x29>;
+          interrupt-parent = <&gpio0>;
+          interrupts = <10 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 0fa24df..7e181b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -674,6 +674,7 @@ W:	http://www.allsensors.com/
 S:	Maintained
 L:	linux-iio@vger.kernel.org
 F:	drivers/iio/pressure/dlh.c
+F:	Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml
 
 ALLEGRO DVT VIDEO IP CORE DRIVER
 M:	Michael Tretter <m.tretter@pengutronix.de>
-- 
2.7.4

