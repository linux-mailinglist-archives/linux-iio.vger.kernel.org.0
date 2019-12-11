Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F43011A900
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 11:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfLKKgF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 05:36:05 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:5266 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbfLKKgF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 05:36:05 -0500
Received: from pps.filterd (m0135534.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB9uHgr010037;
        Wed, 11 Dec 2019 09:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=08102019; bh=sKv1Q+W8G0/Kap939kV8/J8YKysqithOUtf1evnTyms=;
 b=A8aPDB0dgDBcZfrbueiabNKcLXWC1wI26881c1ccjlMACpqNFBFAHClUo/jOMpQpfYai
 h6Vw7O/CP35cZWHqFMTiuJzT0XbouK1t9ZLEfxVXAzX1cUSU/Iibznzq1IDRoZjRdSd7
 kbx+L+JFh8RLPm12SLnOCSAzg3uFrF3lrUVpJ92/oTzj8sAoXyQZht2Q0Q8Fyv7RNoEx
 7rDUwWinxErsuTYkC58R1VW05vy3+bCWBRhJM6zXwM2vSHD/+hzMI+l4VX6xf+nhM7FR
 5aerJjhZOJCGyGmvPn68GlynnpU+xIUQvGFn27BpgIGtr1M5eZ8pSDXvWKFQjcXZSiDf tQ== 
Received: from atgrzso2901.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2wr2ac70bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 09:59:48 +0000
Received: from pps.filterd (atgrzso2901.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2901.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xBB7mM9v014344;
        Wed, 11 Dec 2019 10:59:48 +0100
Received: from atgrzsw3758.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2901.avl01.avlcorp.lan with ESMTP id 2wr4nq1wkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 10:59:47 +0100
Received: from atgrzsw3271.avl01.avlcorp.lan (10.12.65.157) by
 atgrzsw3758.avl01.avlcorp.lan (10.37.149.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_DHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2;
 Wed, 11 Dec 2019 10:59:47 +0100
Received: from ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) by
 atgrzsw3271.avl01.avlcorp.lan (10.12.65.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Dec 2019 10:59:47 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 11 Dec 2019 10:59:47 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v4 2/3] dt-bindings: Add asc vendor
Date:   Wed, 11 Dec 2019 10:59:45 +0100
Message-ID: <20191211095946.7904-3-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
In-Reply-To: <20191211095946.7904-1-tomislav.denis@avl.com>
References: <20191211095946.7904-1-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110062
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_02:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=1 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110086
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

All Sensors Corporation is a manufacturer of MEMS piezoresitive
ultra low pressure sensors and pressure transducers.

Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c..88247b3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -109,6 +109,8 @@ patternProperties:
     description: Artesyn Embedded Technologies Inc.
   "^asahi-kasei,.*":
     description: Asahi Kasei Corp.
+  "^asc,.*":
+    description: All Sensors Corporation
   "^aspeed,.*":
     description: ASPEED Technology Inc.
   "^asus,.*":
-- 
2.7.4

