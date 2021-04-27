Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4429B36C13C
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhD0Ixc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:53:32 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47068 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhD0Ixc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:53:32 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13R8o3cF021646;
        Tue, 27 Apr 2021 04:52:37 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3865r9hbrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 04:52:37 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 13R8qaog036602
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Apr 2021 04:52:36 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 27 Apr 2021 04:52:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 27 Apr 2021 04:52:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 27 Apr 2021 04:52:34 -0400
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13R8qNJq007577;
        Tue, 27 Apr 2021 04:52:30 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v3 6/6] iio: adis16400: do not directly change spi 'max_speed_hz'
Date:   Tue, 27 Apr 2021 10:54:54 +0200
Message-ID: <20210427085454.30616-7-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427085454.30616-1-nuno.sa@analog.com>
References: <20210427085454.30616-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: tTqj30ESYXKdU-XmcmZVZapkHSJ2DskB
X-Proofpoint-GUID: tTqj30ESYXKdU-XmcmZVZapkHSJ2DskB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_05:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270065
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With commit 3ba10e37371d ("iio: adis: add burst_max_speed_hz variable"), we
just need to define 'burst_max_speed_hz' and the adis core will take
care of setting up the spi transfers for burst mode. Hence, we fix
a potential race with the spi core where we could be left witn an
invalid 'max_speed_hz'.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Fixes: 5eda3550a3cc1 ("staging:iio:adis16400: Preallocate transfer message")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16400.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index b2f92b55b910..cb8d3ffab6fc 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -641,25 +641,13 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16400_state *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
-	u32 old_speed_hz = st->adis.spi->max_speed_hz;
 	void *buffer;
 	int ret;
 
-	if (!(st->variant->flags & ADIS16400_NO_BURST) &&
-		st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
-		st->adis.spi->max_speed_hz = ADIS16400_SPI_BURST;
-		spi_setup(st->adis.spi);
-	}
-
 	ret = spi_sync(adis->spi, &adis->msg);
 	if (ret)
 		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
 
-	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
-		st->adis.spi->max_speed_hz = old_speed_hz;
-		spi_setup(st->adis.spi);
-	}
-
 	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
 		buffer = adis->buffer + sizeof(u16);
 	else
@@ -965,7 +953,8 @@ static const char * const adis16400_status_error_msgs[] = {
 		BIT(ADIS16400_DIAG_STAT_POWER_LOW),			\
 	.timeouts = (_timeouts),					\
 	.burst_reg_cmd = ADIS16400_GLOB_CMD,				\
-	.burst_len = (_burst_len)					\
+	.burst_len = (_burst_len),					\
+	.burst_max_speed_hz = ADIS16400_SPI_BURST			\
 }
 
 static const struct adis_timeout adis16300_timeouts = {
-- 
2.31.1

