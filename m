Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71D8276B69
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgIXIFp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 04:05:45 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17058 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727253AbgIXIFo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 04:05:44 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08O84TfI026770;
        Thu, 24 Sep 2020 04:05:41 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5u9b83c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 04:05:41 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08O85d4V017018
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Sep 2020 04:05:39 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 24 Sep 2020 01:05:37 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 24 Sep 2020 01:05:37 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 24 Sep 2020 01:05:37 -0700
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08O85Sru000911;
        Thu, 24 Sep 2020 04:05:35 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 4/4] dt-bindings: iio: ad9467: add entries for for AD9434 & AD9265 ADCs
Date:   Thu, 24 Sep 2020 11:05:18 +0300
Message-ID: <20200924080518.96410-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924080518.96410-1-alexandru.ardelean@analog.com>
References: <20200924080518.96410-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_05:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240062
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add entries for the AD9434 & AD9265 high-speed ADCs which are supported by
the 'ad9467' driver.
Better describe the family of ADCs similar to AD9467 in the description.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index c4f57fa6aad1..579dbc63e3fe 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -4,21 +4,30 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ad9467.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD9467 High-Speed ADC
+title: Analog Devices AD9467 and similar High-Speed ADCs
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
   - Alexandru Ardelean <alexandru.ardelean@analog.com>
 
 description: |
-  The AD9467 is a 16-bit, monolithic, IF sampling analog-to-digital
-  converter (ADC).
+  The AD9467 and the parts similar with it, are high-speed analog-to-digital
+  converters (ADCs), operating in the range of 100 to 500 mega samples
+  per second (MSPS). Depending on the part, some support higher MSPS and some
+  lower MSPS, depending on the application each part is intended for.
 
+  All the parts support the register map described by Application Note AN-877
+   https://www.analog.com/media/en/technical-documentation/application-notes/AN-877.pdf
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9265.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9434.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
 
 properties:
   compatible:
     enum:
+      - adi,ad9265
+      - adi,ad9434
       - adi,ad9467
 
   reg:
-- 
2.25.1

