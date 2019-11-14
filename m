Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C318EFC435
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 11:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfKNKao (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 05:30:44 -0500
Received: from mx08-002cda01.pphosted.com ([185.183.28.84]:1684 "EHLO
        mx08-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726717AbfKNKao (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Nov 2019 05:30:44 -0500
Received: from pps.filterd (m0135533.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEA9DP7032475;
        Thu, 14 Nov 2019 10:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=08102019; bh=1blvfBTOpYzV5ruJbLT+DJ4E+bzOGuKbYJ4DY1IlgF8=;
 b=qyJj1h+/MW7cqJT0e67irCa7GFkDx8Tq4LW6GGaGB6iMqxWHeXdLjVk9idHRgY+LlaqH
 FsftJL1pFjmpQ8KLNeO/9PI1jg3KXZ6dm7fU4cFJRNE5mvATLrVSI8/Um9BF0QDGVWov
 YwdL4ugeV0v1GRMFsV11MxjPNuXHUPSUWnKxa07n+AFaBAkI+h17RDUJmpwuL4FHobjq
 ma3zXqnylw1GCZK8+NS86K5gKt84ycXD+0jR7TurRuZFKdy7ProIx/MN5hhyd2EWqak8
 m6YrMjqTMX18QYNW2MMe7AtIsEAlmqGTFxCT/cVBCLUXz48eFJ56M3UA9rZWvJOBw7fL HA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=19122018; bh=1blvfBTOpYzV5ruJbLT+DJ4E+bzOGuKbYJ4DY1IlgF8=;
 b=kP/nPePALsdnPnms+xYsgAgQJDC+t864weiX2ZGb2nqUoanQ+UPDX38SGlrWP583fvFg
 EoY0vIjHOxiYnOENa5sZ/OGwq5Dn06cf6NrUICnY1ia0NdYa5ulUThTM7GcCfxqjJR7t
 oiTYSVnXDPcFctjOfkUYX8r573lQh5xXjl0Y97jWepHY/l8GvR558/oDDpG8x//LBgyD
 O2MLF5ErrHJ2+UboxbeanX7603oBuqV0FKOAhFk+abecud9T8HNbn+YZ6JTstvSFW7Vv
 BFjZFHYzdUO/4Jd1xNjWKWCBW9fjLLHHedDbKr/1bjzQ76RarJH3TYqAqpuTZONwODbM 6g== 
Received: from atgrzso2901.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2w5p88a241-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 10:09:13 +0000
Received: from pps.filterd (atgrzso2901.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2901.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xAEA9BJY001938;
        Thu, 14 Nov 2019 11:09:12 +0100
Received: from atgrzsw1696.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2901.avl01.avlcorp.lan with ESMTP id 2w93dg02wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 11:09:11 +0100
Received: from atgrzsw3272.avl01.avlcorp.lan (10.12.65.158) by
 atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 Nov 2019 11:09:09 +0100
Received: from atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) by
 atgrzsw3272.avl01.avlcorp.lan (10.12.65.158) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 Nov 2019 11:09:09 +0100
Received: from ATGRZWN210080.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 14 Nov 2019 11:09:09 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH 2/3] dt-bindings: Add asc vendor
Date:   Thu, 14 Nov 2019 11:09:07 +0100
Message-ID: <20191114100908.11180-3-tomislav.denis@avl.com>
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

