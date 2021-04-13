Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2291935DD9B
	for <lists+linux-iio@lfdr.de>; Tue, 13 Apr 2021 13:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhDMLT0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Apr 2021 07:19:26 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20442 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345395AbhDMLTO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Apr 2021 07:19:14 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DBAxlb026788;
        Tue, 13 Apr 2021 07:18:42 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 37vwhm28c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 07:18:42 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 13DBIfiX057127
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Apr 2021 07:18:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 13 Apr 2021 07:18:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 13 Apr 2021 07:18:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 13 Apr 2021 07:18:40 -0400
Received: from nsa.sphairon.box ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13DBIbD9010275;
        Tue, 13 Apr 2021 07:18:39 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] iio: adis16400: do not return ints in irq handlers
Date:   Tue, 13 Apr 2021 13:21:00 +0200
Message-ID: <20210413112105.69458-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413112105.69458-1-nuno.sa@analog.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: NaWlL5eZqVIPT0DAOH87clsdasoap3pu
X-Proofpoint-GUID: NaWlL5eZqVIPT0DAOH87clsdasoap3pu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_04:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=875 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130078
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On an IRQ handler we should return normal error codes as 'irqreturn_t'
is expected.

Fixes: 5eda3550a3cc1 ("staging:iio:adis16400: Preallocate transfer message")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16400.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 768aa493a1a6..c2362a9ee3c3 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -646,7 +646,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	int ret;
 
 	if (!adis->buffer)
-		return -ENOMEM;
+		goto irq_done;
 
 	if (!(st->variant->flags & ADIS16400_NO_BURST) &&
 		st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
@@ -671,6 +671,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
 		pf->timestamp);
 
+irq_done:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.31.1

