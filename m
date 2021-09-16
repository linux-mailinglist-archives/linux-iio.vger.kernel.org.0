Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA1140E9E1
	for <lists+linux-iio@lfdr.de>; Thu, 16 Sep 2021 20:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242710AbhIPSbV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Sep 2021 14:31:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32926 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244868AbhIPSbK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Sep 2021 14:31:10 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GFv7Nk008828;
        Thu, 16 Sep 2021 14:29:39 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b40gctb7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 14:29:39 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 18GITbMB038916
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Sep 2021 14:29:37 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 16 Sep 2021
 11:29:36 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 16 Sep 2021 11:29:36 -0700
Received: from ubuntuservermchindri.ad.analog.com ([10.32.224.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18GITO8q025646;
        Thu, 16 Sep 2021 14:29:32 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v5 4/6] drivers: iio: dac: ad5766: Fix dt property name
Date:   Thu, 16 Sep 2021 18:29:12 +0000
Message-ID: <20210916182914.1810-5-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210916182914.1810-1-mihail.chindris@analog.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: qZc02ulD2YvqU3dZhfymvtKLMZir0hsX
X-Proofpoint-GUID: qZc02ulD2YvqU3dZhfymvtKLMZir0hsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_05,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxlogscore=899 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160106
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the documentation the name for the property is
output-range-microvolts which is a standard name, therefore this name
must be used.

Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
---
 drivers/iio/dac/ad5766.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
index 3104ec32dfac..dafda84fdea3 100644
--- a/drivers/iio/dac/ad5766.c
+++ b/drivers/iio/dac/ad5766.c
@@ -503,13 +503,13 @@ static int ad5766_get_output_range(struct ad5766_state *st)
 	int i, ret, min, max, tmp[2];
 
 	ret = device_property_read_u32_array(&st->spi->dev,
-					     "output-range-voltage",
+					     "output-range-microvolts",
 					     tmp, 2);
 	if (ret)
 		return ret;
 
-	min = tmp[0] / 1000;
-	max = tmp[1] / 1000;
+	min = tmp[0] / 1000000;
+	max = tmp[1] / 1000000;
 	for (i = 0; i < ARRAY_SIZE(ad5766_span_tbl); i++) {
 		if (ad5766_span_tbl[i].min != min ||
 		    ad5766_span_tbl[i].max != max)
-- 
2.27.0

