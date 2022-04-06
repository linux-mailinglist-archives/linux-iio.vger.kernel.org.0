Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2734F61F6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 16:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiDFOeN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiDFOdx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 10:33:53 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B444D4CAB
        for <linux-iio@vger.kernel.org>; Wed,  6 Apr 2022 03:57:28 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 236A0eDn002597;
        Wed, 6 Apr 2022 06:57:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3f6gb7cub5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 06:57:09 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 236Av8mj002114
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Apr 2022 06:57:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 6 Apr 2022
 06:57:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 6 Apr 2022 06:57:07 -0400
Received: from localhost.localdomain ([10.44.3.40])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 236Aur07020920;
        Wed, 6 Apr 2022 06:56:56 -0400
From:   <michael.hennerich@analog.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: dac: ad5446: Fix read_raw not returning set value
Date:   Wed, 6 Apr 2022 12:56:20 +0200
Message-ID: <20220406105620.1171340-1-michael.hennerich@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 1eoED63KiNqKcC6Og06bzkoAKXFPFpGi
X-Proofpoint-ORIG-GUID: 1eoED63KiNqKcC6Og06bzkoAKXFPFpGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_04,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060050
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

read_raw should return the un-scaled value.

Fixes: 5e06bdfb46e8b ("staging:iio:dac:ad5446: Return cached value for 'raw' attribute")

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/dac/ad5446.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 14cfabacbea5..fdf824041497 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -178,7 +178,7 @@ static int ad5446_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		*val = st->cached_val;
+		*val = st->cached_val >> chan->scan_type.shift;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mv;
-- 
2.25.1

