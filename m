Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4D6ADAEE
	for <lists+linux-iio@lfdr.de>; Tue,  7 Mar 2023 10:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCGJwJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Mar 2023 04:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCGJwG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2023 04:52:06 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6989273848
        for <linux-iio@vger.kernel.org>; Tue,  7 Mar 2023 01:51:42 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3279fHsQ016181;
        Tue, 7 Mar 2023 04:51:16 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3p43s9ftwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 04:51:16 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3279pFEB003245
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 04:51:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Mar 2023
 04:51:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Mar 2023 04:51:14 -0500
Received: from nsa.ad.analog.com ([10.44.3.102])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3279p4lk006360;
        Tue, 7 Mar 2023 04:51:07 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: adc: max11410: fix read_poll_timeout() usage
Date:   Tue, 7 Mar 2023 10:53:03 +0100
Message-ID: <20230307095303.713251-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: X4IlAU_90oChGWDAW7LZH-dR-z8c6LvC
X-Proofpoint-GUID: X4IlAU_90oChGWDAW7LZH-dR-z8c6LvC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_04,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070089
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Even though we are passing 'ret' as stop condition for
read_poll_timeout(), that return code is still being ignored. The reason
is that the poll will stop if the passed condition is true which will
happen if the passed op() returns error. However, read_poll_timeout()
returns 0 if the *complete* condition evaluates to true. Therefore, the
error code returned by op() will be ignored.

To fix this we need to check for both error codes:
 * The one returned by read_poll_timeout() which is either 0 or
ETIMEDOUT.
 * The one returned by the passed op().

Fixes: a44ef7c46097 ("iio: adc: add max11410 adc driver")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/max11410.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index 237b2ce3f264..6af829349b4e 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -414,13 +414,17 @@ static int max11410_sample(struct max11410_state *st, int *sample_raw,
 		if (!ret)
 			return -ETIMEDOUT;
 	} else {
+		int ret2;
+
 		/* Wait for status register Conversion Ready flag */
-		ret = read_poll_timeout(max11410_read_reg, ret,
-					ret || (val & MAX11410_STATUS_CONV_READY_BIT),
+		ret = read_poll_timeout(max11410_read_reg, ret2,
+					ret2 || (val & MAX11410_STATUS_CONV_READY_BIT),
 					5000, MAX11410_CONVERSION_TIMEOUT_MS * 1000,
 					true, st, MAX11410_REG_STATUS, &val);
 		if (ret)
 			return ret;
+		if (ret2)
+			return ret2;
 	}
 
 	/* Read ADC Data */
@@ -851,17 +855,21 @@ static int max11410_init_vref(struct device *dev,
 
 static int max11410_calibrate(struct max11410_state *st, u32 cal_type)
 {
-	int ret, val;
+	int ret, ret2, val;
 
 	ret = max11410_write_reg(st, MAX11410_REG_CAL_START, cal_type);
 	if (ret)
 		return ret;
 
 	/* Wait for status register Calibration Ready flag */
-	return read_poll_timeout(max11410_read_reg, ret,
-				 ret || (val & MAX11410_STATUS_CAL_READY_BIT),
-				 50000, MAX11410_CALIB_TIMEOUT_MS * 1000, true,
-				 st, MAX11410_REG_STATUS, &val);
+	ret = read_poll_timeout(max11410_read_reg, ret2,
+				ret2 || (val & MAX11410_STATUS_CAL_READY_BIT),
+				50000, MAX11410_CALIB_TIMEOUT_MS * 1000, true,
+				st, MAX11410_REG_STATUS, &val);
+	if (ret)
+		return ret;
+
+	return ret2;
 }
 
 static int max11410_self_calibrate(struct max11410_state *st)
-- 
2.39.2

