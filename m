Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8B10D227
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 09:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfK2IAm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 03:00:42 -0500
Received: from mx08-002cda01.pphosted.com ([185.183.28.84]:13966 "EHLO
        mx08-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfK2IAm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Nov 2019 03:00:42 -0500
Received: from pps.filterd (m0135533.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAT7UgLq016668;
        Fri, 29 Nov 2019 07:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=08102019; bh=1blvfBTOpYzV5ruJbLT+DJ4E+bzOGuKbYJ4DY1IlgF8=;
 b=B9X0dQ+rD3XpeABJRjyEac94XCCscpGjpBTkYSbO+lA30zyTPoWHAlPBExvZXlBCtZ8Y
 /2QsI2bTURPXLoh0P+8b9uoNIouL+s1kcFfTITAgXOPa9k1izY1oTZdETQsMid4EzEFK
 QffErz8XsigtSxrCXQ/9zl9PJqU1uk3J/H5ra7fi9Ld7WapqEeNzbtSqQM04IIIVrgp+
 /I5Dqs8u/ogYiML1vsPT+trj1q2Qg1SHaCqZUtxJsb6EkZc4W+qJQRf4KzgK1OUKZam+
 u8oqmMcg1A0Dulpc2M3vCquBseBXV0QJ6S0gUOOTdBiXIQxMNZ83eyHGmVyhAKGuFSfA Eg== 
Received: from atgrzso8132.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2whd0gw05b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 07:34:22 +0000
Received: from pps.filterd (atgrzso8132.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso8132.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xAT7UF3a030264;
        Fri, 29 Nov 2019 08:34:21 +0100
Received: from atgrzsw1694.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso8132.avl01.avlcorp.lan with ESMTP id 2wjxv2g087-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 08:34:21 +0100
Received: from ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) by
 ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 Nov 2019 08:34:21 +0100
Received: from ATGRZWN210080.avl01.avlcorp.lan (10.12.100.12) by
 ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 29 Nov 2019 08:34:21 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v2 2/3] dt-bindings: Add asc vendor
Date:   Fri, 29 Nov 2019 08:34:19 +0100
Message-ID: <20191129073420.9800-3-tomislav.denis@avl.com>
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911290063
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_01:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290064
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

All Sensors Corporation is a manufacturer of MEMS piezoresitive
ultra low pressure sensors and pressure transducers.

Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
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

