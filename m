Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F37E282F
	for <lists+linux-iio@lfdr.de>; Mon,  6 Nov 2023 16:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjKFPIQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Nov 2023 10:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjKFPIP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Nov 2023 10:08:15 -0500
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE013B3
        for <linux-iio@vger.kernel.org>; Mon,  6 Nov 2023 07:08:10 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A6AtKLR012233;
        Mon, 6 Nov 2023 10:07:55 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3u6xtfrw9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 10:07:55 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3A6F7s6x059060
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Nov 2023 10:07:54 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 6 Nov 2023
 10:07:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 6 Nov 2023 10:07:53 -0500
Received: from NSA-L02.ad.analog.com (NSA-L02.ad.analog.com [10.32.225.208])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3A6F7cKr032160;
        Mon, 6 Nov 2023 10:07:40 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] iio: imu: adis16475: use bit numbers in assign_bit()
Date:   Mon, 6 Nov 2023 16:07:30 +0100
Message-ID: <20231106150730.945-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: XjpK6qh2cyEHsBHVqWwuZo2zfA6v240k
X-Proofpoint-GUID: XjpK6qh2cyEHsBHVqWwuZo2zfA6v240k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 adultscore=0
 mlxlogscore=733 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2310240000 definitions=main-2311060122
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Nuno Sa <nuno.sa@analog.com>

assign_bit() expects a bit number and not a mask like BIT(x). Hence,
just remove the BIT() macro from the #defines.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202311060647.i9XyO4ej-lkp@intel.com/
Fixes: fff7352bf7a3ce ("iio: imu: Add support for adis16475")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index b7cbe1565aee0..eb7c74be030e2 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -70,8 +70,8 @@
 #define ADIS16475_MAX_SCAN_DATA		20
 /* spi max speed in brust mode */
 #define ADIS16475_BURST_MAX_SPEED	1000000
-#define ADIS16475_LSB_DEC_MASK		BIT(0)
-#define ADIS16475_LSB_FIR_MASK		BIT(1)
+#define ADIS16475_LSB_DEC_MASK		0
+#define ADIS16475_LSB_FIR_MASK		1
 #define ADIS16500_BURST_DATA_SEL_0_CHN_MASK	GENMASK(5, 0)
 #define ADIS16500_BURST_DATA_SEL_1_CHN_MASK	GENMASK(12, 7)
 
-- 
2.41.0

