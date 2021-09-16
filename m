Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9589940E9E0
	for <lists+linux-iio@lfdr.de>; Thu, 16 Sep 2021 20:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbhIPSbV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Sep 2021 14:31:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31920 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243791AbhIPSbK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Sep 2021 14:31:10 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GCxs7a013470;
        Thu, 16 Sep 2021 14:29:38 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b3v3bbjka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 14:29:38 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 18GITbFO038913
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Sep 2021 14:29:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 16 Sep 2021
 14:29:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 16 Sep 2021 14:29:36 -0400
Received: from ubuntuservermchindri.ad.analog.com ([10.32.224.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18GITO8r025646;
        Thu, 16 Sep 2021 14:29:34 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v5 5/6] Documentation:devicetree:bindings:iio:dac: Fix val
Date:   Thu, 16 Sep 2021 18:29:13 +0000
Message-ID: <20210916182914.1810-6-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210916182914.1810-1-mihail.chindris@analog.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: NgEoO4UvFBU4vBzZedWaFhZc02v2YjBG
X-Proofpoint-GUID: NgEoO4UvFBU4vBzZedWaFhZc02v2YjBG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_05,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160106
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A correct value for output-range-microvolts is -5 to 5 Volts
not -5 to 5 milivolts

Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
index d5c54813ce87..a8f7720d1e3e 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
@@ -54,7 +54,7 @@ examples:
 
           ad5766@0 {
               compatible = "adi,ad5766";
-              output-range-microvolts = <(-5000) 5000>;
+              output-range-microvolts = <(-5000000) 5000000>;
               reg = <0>;
               spi-cpol;
               spi-max-frequency = <1000000>;
-- 
2.27.0

