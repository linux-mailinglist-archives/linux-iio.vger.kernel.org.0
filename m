Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5481141117B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 10:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhITI7r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 04:59:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15138 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236080AbhITI73 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 04:59:29 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18K5d8CN006281;
        Mon, 20 Sep 2021 04:57:51 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b6bv8a5dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 04:57:51 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 18K8vnRL048543
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 04:57:49 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Mon, 20 Sep 2021 01:57:48 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Mon, 20 Sep 2021 01:57:48 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Mon, 20 Sep 2021 01:57:48 -0700
Received: from nsa.ad.analog.com ([10.44.3.61])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18K8vjmh028187;
        Mon, 20 Sep 2021 04:57:45 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: adis16475: fix deadlock on frequency set
Date:   Mon, 20 Sep 2021 11:00:47 +0200
Message-ID: <20210920090047.74903-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: _G10pHk9aMTbYVVvl0HictawfRWfym25
X-Proofpoint-ORIG-GUID: _G10pHk9aMTbYVVvl0HictawfRWfym25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_05,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With commit 39c024b51b560
("iio: adis16475: improve sync scale mode handling"), two deadlocks were
introduced:
 1) The call to 'adis_write_reg_16()' was not changed to it's unlocked
    version.
 2) The lock was not being released on the success path of the function.

This change fixes both these issues.

Fixes: 39c024b51b560 ("iio: adis16475: improve sync scale mode handling")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index eb48102f9424..287fff39a927 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -353,10 +353,11 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 	if (dec > st->info->max_dec)
 		dec = st->info->max_dec;
 
-	ret = adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
+	ret = __adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
 	if (ret)
 		goto error;
 
+	adis_dev_unlock(&st->adis);
 	/*
 	 * If decimation is used, then gyro and accel data will have meaningful
 	 * bits on the LSB registers. This info is used on the trigger handler.
-- 
2.33.0

