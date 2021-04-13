Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C440D35DD9A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Apr 2021 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbhDMLT1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Apr 2021 07:19:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24350 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345401AbhDMLTQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Apr 2021 07:19:16 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DBACv7002972;
        Tue, 13 Apr 2021 07:18:47 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 37vyd1swbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 07:18:47 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 13DBIjc3040716
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Apr 2021 07:18:45 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Tue, 13 Apr 2021
 04:18:44 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 13 Apr 2021 04:18:43 -0700
Received: from nsa.sphairon.box ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13DBIbDB010275;
        Tue, 13 Apr 2021 07:18:41 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] iio: adis16475: re-set max spi transfer
Date:   Tue, 13 Apr 2021 13:21:02 +0200
Message-ID: <20210413112105.69458-5-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413112105.69458-1-nuno.sa@analog.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ieoyXaPM_lfm2ba_QVGmMb6aVm7ZUTAN
X-Proofpoint-ORIG-GUID: ieoyXaPM_lfm2ba_QVGmMb6aVm7ZUTAN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_04:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130078
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In case 'spi_sync()' fails, we would be left with a max spi transfer
which is not the one the user expects it to be. Hence, we need to re-set
it also in this error path.

Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 51b76444db0b..9dca7e506200 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1067,8 +1067,10 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	adis->spi->max_speed_hz = ADIS16475_BURST_MAX_SPEED;
 
 	ret = spi_sync(adis->spi, &adis->msg);
-	if (ret)
+	if (ret) {
+		adis->spi->max_speed_hz = cached_spi_speed_hz;
 		goto check_burst32;
+	}
 
 	adis->spi->max_speed_hz = cached_spi_speed_hz;
 	buffer = adis->buffer;
-- 
2.31.1

