Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA4BFC436
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 11:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKNKav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 05:30:51 -0500
Received: from mx08-002cda01.pphosted.com ([185.183.28.84]:1718 "EHLO
        mx08-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbfKNKav (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Nov 2019 05:30:51 -0500
Received: from pps.filterd (m0135533.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEA9tJ9000751;
        Thu, 14 Nov 2019 10:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=08102019; bh=b0SHC9LPYhG2ytHcpiMCUUBwLEVunuxoQw31P9doY6s=;
 b=oI99kGKsjeu291xkEFOdEfmVWfoDrcKp8O6fwc5qjIYGODWthYJhrCG9FM9A8NecFSZB
 ayXuuJ3leJ8jtLDJu9fWsdJB241qUXN8rvENwy3lQOJshayu3UvGa9lyc0n/u8Xe+yMA
 ooJcRJ1uf74/M6xFNNBjigf5MF0MeUk2DrQLhrW34bp6b0Gd0Z9ELsqQt6wSUaLxBKjB
 nAWs3H9RCS+RwkWqQchGpNOD4NTpIFofywN21YQyMO1XhrU689WPGN47QeXw+5ByTi37
 sR6Gb5adGhIKm0z0uYCXXuGL2gFzviyURS+vchIt0qUQ3QZ1cR9hbaLOY2YACpTy04vU nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=19122018; bh=b0SHC9LPYhG2ytHcpiMCUUBwLEVunuxoQw31P9doY6s=;
 b=pUSef10PmotCBViMqV8GYwHSJMetMDE+RkdtfXgooBdBuJGY+L/kd+6LotYVFSZn5LEi
 /Hrfjm2p9uekUkL2yqYW+bswG2QF45g/5zSgdGVzBj1ZO37gc9G+Ca58iYEfuZJL4Y8g
 bh+voESaOrF1TECVLYNF4AEaWEwTDkbMqRPGJa09O3Ka5dLLN6R1c37PVKdfRX11kh51
 Q3i4QBcy3f4i7e3m63Jaq9H1Ydqv1WmDwRVENqfus8V3lebXqIYh0GEdoNgDsEHrc0RQ
 9z7tYvZRj1uNeZHbQvhZGb5sSclluR4Qat8bP1zpG1yr8KjFQl2kVztvjdyfVLQ5h3BJ kA== 
Received: from atgrzso2901.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2w5p88a26p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 10:10:25 +0000
Received: from pps.filterd (atgrzso2901.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2901.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xAEA9BJh001938;
        Thu, 14 Nov 2019 11:10:24 +0100
Received: from atgrzsw1693.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2901.avl01.avlcorp.lan with ESMTP id 2w93dg02xk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 11:10:24 +0100
Received: from atgrzsw3271.avl01.avlcorp.lan (10.12.65.157) by
 atgrzsw1693.avl01.avlcorp.lan (10.12.64.114) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 Nov 2019 11:10:23 +0100
Received: from atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) by
 atgrzsw3271.avl01.avlcorp.lan (10.12.65.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 Nov 2019 11:09:09 +0100
Received: from ATGRZWN210080.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 14 Nov 2019 11:09:09 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH 3/3] bindings: iio: pressure: Add dlh-i2c documentation
Date:   Thu, 14 Nov 2019 11:09:08 +0100
Message-ID: <20191114100908.11180-4-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20191114100908.11180-1-tomislav.denis@avl.com>
References: <20191114100908.11180-1-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140094
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_01:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=1 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911140094
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

Add a device tree binding documentation for DLH series pressure
sensors.

Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
---
 .../devicetree/bindings/iio/pressure/dlh-i2c.yaml  | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml b/Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml
new file mode 100644
index 0000000..43539ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
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
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pressure@29 {
+          compatible = "asc,dlhl60d";
+          reg = <0x29>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2a08923..b45081d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -674,6 +674,7 @@ W:	http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
 S:	Maintained
 L:	linux-iio@vger.kernel.org
 F:	drivers/iio/pressure/dlh-i2c.c
+F:	Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml
 
 ALLEGRO DVT VIDEO IP CORE DRIVER
 M:	Michael Tretter <m.tretter@pengutronix.de>
-- 
2.7.4

