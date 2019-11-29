Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B150A10D22B
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 09:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfK2IB3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 03:01:29 -0500
Received: from mx08-002cda01.pphosted.com ([185.183.28.84]:14136 "EHLO
        mx08-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfK2IB3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Nov 2019 03:01:29 -0500
Received: from pps.filterd (m0135533.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAT7Uf2S016665;
        Fri, 29 Nov 2019 07:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=08102019; bh=K5tNEdnBxAlxUCd+/rv0lf5SXzwX97+D5pqy1mjYJDs=;
 b=IZUjiD9Eemec/cikku3TEoYWjJG982CSxz888X7hmKcsxju43iA5SYHRaLqtnQpVx2VO
 ZYoddDPbS+ZKep7K4y58DXOkCYysfywWx+7Tyqqdkd2mRHF/QzX++ty4OuohrQ6EAQp9
 zYTNKLwvY/m1w56L3FmjULtJKkCMdUaViuBnvB1KBb8TJTgUgdpxWEsdBy97lgg8LnFY
 3/e19QzHd7izOC54HCNA2xQqgYdfiRddp4IqwMQxlZcz63MwoGVmOdYi+yRV7kn8FUYC
 aYeotKPuey4h4pRTl1LgoJZav8eutxGZegSHRo89kfZMNeiyRdVRwF2sAp6XnUw9rvM7 Zg== 
Received: from atgrzso2833.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2whd0gw05c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 07:34:22 +0000
Received: from pps.filterd (atgrzso2833.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2833.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xAT7Ttxj006391;
        Fri, 29 Nov 2019 08:34:22 +0100
Received: from atgrzsw1693.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2833.avl01.avlcorp.lan with ESMTP id 2wewbpb49u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 08:34:21 +0100
Received: from ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) by
 atgrzsw1693.avl01.avlcorp.lan (10.12.64.114) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 Nov 2019 08:34:21 +0100
Received: from ATGRZWN210080.avl01.avlcorp.lan (10.12.100.12) by
 ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 29 Nov 2019 08:34:21 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v2 3/3] bindings: iio: pressure: Add dlh-i2c documentation
Date:   Fri, 29 Nov 2019 08:34:20 +0100
Message-ID: <20191129073420.9800-4-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20191129073420.9800-1-tomislav.denis@avl.com>
References: <20191114100908.11180-1-tomislav.denis@avl.com>
 <20191129073420.9800-1-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-29_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=771
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911290063
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_01:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 mlxlogscore=831 clxscore=1015 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290064
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

Add a device tree binding documentation for DLH series pressure
sensors.

Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
---
 .../bindings/iio/pressure/asc,dlh-i2c.yaml         | 51 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml b/Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
new file mode 100644
index 0000000..5de2277
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/dlh-i2c.yaml#
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
index 39d6f0f..8f0eab0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -674,6 +674,7 @@ W:	http://www.allsensors.com/
 S:	Maintained
 L:	linux-iio@vger.kernel.org
 F:	drivers/iio/pressure/dlh-i2c.c
+F:	Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml
 
 ALLEGRO DVT VIDEO IP CORE DRIVER
 M:	Michael Tretter <m.tretter@pengutronix.de>
-- 
2.7.4

