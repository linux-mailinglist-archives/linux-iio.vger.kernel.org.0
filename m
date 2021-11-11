Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1D44D85F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Nov 2021 15:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhKKOhN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Nov 2021 09:37:13 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45354 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231614AbhKKOhM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Nov 2021 09:37:12 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AB96uFV001080;
        Thu, 11 Nov 2021 09:34:10 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c88pqfhg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:34:10 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1ABEY9bF016189
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Nov 2021 09:34:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 11 Nov 2021
 09:34:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Thu, 11 Nov 2021 09:34:08 -0500
Received: from nsa.ad.analog.com ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1ABEY6gP004493;
        Thu, 11 Nov 2021 09:34:07 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kister Genesis Jimenez <kister.jimenez@analog.com>
Subject: [PATCH v2] iio: adxrs290: fix data signedness
Date:   Thu, 11 Nov 2021 15:34:11 +0100
Message-ID: <20211111143411.187090-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: uzwUuKLRye_R-LOXCAgmDuCkZBtw7rfG
X-Proofpoint-GUID: uzwUuKLRye_R-LOXCAgmDuCkZBtw7rfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_04,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110082
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Kister Genesis Jimenez <kister.jimenez@analog.com>

Properly sign-extend the rate and temperature data.

Fixes: 2c8920fff1457 ("iio: gyro: Add driver support for ADXRS290")
Signed-off-by: KJimenez <kister.jimenez@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
changes in v2:
 * removed redundant temp & 0xFFF.

 drivers/iio/gyro/adxrs290.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 3e0734ddafe3..600e9725da78 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -124,7 +125,7 @@ static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd, int *
 		goto err_unlock;
 	}
 
-	*val = temp;
+	*val = sign_extend32(temp, 15);
 
 err_unlock:
 	mutex_unlock(&st->lock);
@@ -146,7 +147,7 @@ static int adxrs290_get_temp_data(struct iio_dev *indio_dev, int *val)
 	}
 
 	/* extract lower 12 bits temperature reading */
-	*val = temp & 0x0FFF;
+	*val = sign_extend32(temp, 11);
 
 err_unlock:
 	mutex_unlock(&st->lock);
-- 
2.33.1

