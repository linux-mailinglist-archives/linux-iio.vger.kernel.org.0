Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E2431E968
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 13:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBRLzv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 06:55:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32912 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231802AbhBRLjf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2021 06:39:35 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IBUatX029191;
        Thu, 18 Feb 2021 06:38:32 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb6ss9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 06:38:32 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11IBcVGc054481
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Feb 2021 06:38:31 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 18 Feb 2021
 06:38:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 18 Feb 2021 06:38:30 -0500
Received: from nsa.sphairon.box ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11IBcOr1013165;
        Thu, 18 Feb 2021 06:38:28 -0500
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/4] dt-bindings: adis16475: remove property
Date:   Thu, 18 Feb 2021 12:40:38 +0100
Message-ID: <20210218114039.216091-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210218114039.216091-1-nuno.sa@analog.com>
References: <20210218114039.216091-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_04:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180103
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Nuno Sá <nuno.sa@analog.com>

`adi,scaled-output-hz` is no longer used by the driver.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml       | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index 79fba1508e89..a7574210175a 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -71,15 +71,6 @@ properties:
     minimum: 0
     maximum: 3
 
-  adi,scaled-output-hz:
-    description:
-      This property must be present if the clock mode is scaled-sync through
-      clock-names property. In this mode, the input clock can have a range
-      of 1Hz to 128HZ which must be scaled to originate an allowable sample
-      rate. This property specifies that rate.
-    minimum: 1900
-    maximum: 2100
-
 required:
   - compatible
   - reg
-- 
2.30.1

