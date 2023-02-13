Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13963694B30
	for <lists+linux-iio@lfdr.de>; Mon, 13 Feb 2023 16:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBMPa5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Feb 2023 10:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBMPa4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Feb 2023 10:30:56 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015140DE
        for <linux-iio@vger.kernel.org>; Mon, 13 Feb 2023 07:30:55 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DDZa9o008844;
        Mon, 13 Feb 2023 10:30:27 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3np8ta2q99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 10:30:27 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 31DFUPpn040540
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Feb 2023 10:30:25 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 13 Feb 2023 10:30:24 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 13 Feb 2023 10:30:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 13 Feb 2023 10:30:24 -0500
Received: from nsa.sphairon.box ([10.44.3.102])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 31DFUEY8012389;
        Mon, 13 Feb 2023 10:30:16 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, "Nuno Sa" <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: imu: adis16475: correct copy paste mistake in comment block
Date:   Mon, 13 Feb 2023 16:32:08 +0100
Message-ID: <20230213153208.1027602-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 5wwINf6c_EnZfQ0bt2oiJXbnEvLMvujL
X-Proofpoint-ORIG-GUID: 5wwINf6c_EnZfQ0bt2oiJXbnEvLMvujL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_10,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130140
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The minimal advised lower rate for adis16475 compatible devices is
1900HZ and not 4000HZ. Set that right in the comments so that it does
not generate any confusion.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index aec55f7e1f26..3abffb01ba31 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -326,11 +326,11 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 
 		/*
 		 * This is not an hard requirement but it's not advised to run the IMU
-		 * with a sample rate lower than 4000Hz due to possible undersampling
+		 * with a sample rate lower than 1900Hz due to possible undersampling
 		 * issues. However, there are users that might really want to take the risk.
 		 * Hence, we provide a module parameter for them. If set, we allow sample
-		 * rates lower than 4KHz. By default, we won't allow this and we just roundup
-		 * the rate to the next multiple of the input clock bigger than 4KHz. This
+		 * rates lower than 1.9KHz. By default, we won't allow this and we just roundup
+		 * the rate to the next multiple of the input clock bigger than 1.9KHz. This
 		 * is done like this as in some cases (when DEC_RATE is 0) might give
 		 * us the closest value to the one desired by the user...
 		 */
-- 
2.39.1

