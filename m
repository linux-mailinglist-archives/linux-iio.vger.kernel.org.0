Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC5336C137
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhD0IxY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:53:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37900 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhD0IxX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:53:23 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13R8ok84005202;
        Tue, 27 Apr 2021 04:52:29 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3866auh9d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 04:52:29 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 13R8qSq6033985
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Apr 2021 04:52:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Tue, 27 Apr 2021
 04:52:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 27 Apr 2021 04:52:26 -0400
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13R8qNJl007577;
        Tue, 27 Apr 2021 04:52:25 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v3 1/6] iio: adis16475: do not return ints in irq handlers
Date:   Tue, 27 Apr 2021 10:54:49 +0200
Message-ID: <20210427085454.30616-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427085454.30616-1-nuno.sa@analog.com>
References: <20210427085454.30616-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -WtUJpaE7J2xIebVYGPpQmwUiAhMzaGW
X-Proofpoint-GUID: -WtUJpaE7J2xIebVYGPpQmwUiAhMzaGW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_05:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270065
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On an IRQ handler we should not return normal error codes as 'irqreturn_t'
is expected.

This is done by jumping to the 'check_burst32' label where we return
'IRQ_HANDLED'. Note that it is fine to do the burst32 check in this
error path. If we have proper settings to apply burst32, we might just
do the setup now so that the next sample already uses it.

Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 1de62fc79e0f..51b76444db0b 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1068,7 +1068,7 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 
 	ret = spi_sync(adis->spi, &adis->msg);
 	if (ret)
-		return ret;
+		goto check_burst32;
 
 	adis->spi->max_speed_hz = cached_spi_speed_hz;
 	buffer = adis->buffer;
-- 
2.31.1

