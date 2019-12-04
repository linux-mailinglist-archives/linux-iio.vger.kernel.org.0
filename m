Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D02112911
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 11:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfLDKNZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 05:13:25 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:38015 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbfLDKNY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 05:13:24 -0500
Received: from pps.filterd (m0135534.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4A0Eq0031335;
        Wed, 4 Dec 2019 10:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=08102019; bh=sKv1Q+W8G0/Kap939kV8/J8YKysqithOUtf1evnTyms=;
 b=COfni8lqoXcufsUSmBxdykUQbbV//xvA+rnKNTYPqcSZu2FbINvcAczT+WavbxvYHZ7q
 8IKJ2dybN09um+WvM/0ycgKGitw5500yCWkCgCPJH9cZBHxyY/2W8M/093wl+qldY6Hj
 FkR0GtRG1ziYVfsbpf2tnAvbcebkvu400/H5YkyxT4nW4v5jNThUYZ868HL0/7Q/sRbG
 38+xAOR3lz/RQDq6JYRQ7+OaSduXPzZEZbZJDigouWQ8aBt95si51PE0aH5FYD9Sywdh
 PaVw0vrF1I9o3HNNXa5N3waYQt24+VnvzR1BHGFYLtzKOIhk7Zkxcc9fzHsVq2d1Q7Ba wQ== 
Received: from atgrzso2901.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2wnjsjaeyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 10:03:56 +0000
Received: from pps.filterd (atgrzso2901.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2901.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xB49xHWi004547;
        Wed, 4 Dec 2019 11:03:55 +0100
Received: from atgrzsw1695.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2901.avl01.avlcorp.lan with ESMTP id 2wkh0p9yfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 11:03:55 +0100
Received: from atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) by
 atgrzsw1695.avl01.avlcorp.lan (10.12.64.163) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 4 Dec 2019 11:03:55 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 4 Dec 2019 11:03:55 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v3 2/3] dt-bindings: Add asc vendor
Date:   Wed, 4 Dec 2019 11:03:53 +0100
Message-ID: <20191204100354.16652-3-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
In-Reply-To: <20191204100354.16652-1-tomislav.denis@avl.com>
References: <20191204100354.16652-1-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040077
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=1 mlxscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912040076
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

