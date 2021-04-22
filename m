Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA8367E69
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 12:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhDVKRg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Apr 2021 06:17:36 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48824 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235782AbhDVKRg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Apr 2021 06:17:36 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MAG6MD009021;
        Thu, 22 Apr 2021 06:16:48 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3834980gbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:16:48 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 13MAGkEN039904
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Apr 2021 06:16:47 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 22 Apr 2021
 03:16:45 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 22 Apr 2021 03:16:45 -0700
Received: from nsa.sphairon.box ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13MAGffD027460;
        Thu, 22 Apr 2021 06:16:43 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v2 2/9] iio: adis16400: do not return ints in irq handlers
Date:   Thu, 22 Apr 2021 12:19:04 +0200
Message-ID: <20210422101911.135630-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422101911.135630-1-nuno.sa@analog.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Ca5-mZYvH6ZwsC0Jth5b7gUC2lnPdSns
X-Proofpoint-GUID: Ca5-mZYvH6ZwsC0Jth5b7gUC2lnPdSns
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=868
 spamscore=0 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104220086
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On an IRQ handler we should not return normal error codes as 'irqreturn_t'
is expected.

Fixes: 5eda3550a3cc1 ("staging:iio:adis16400: Preallocate transfer message")
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16400.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 768aa493a1a6..b2f92b55b910 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -645,9 +645,6 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	void *buffer;
 	int ret;
 
-	if (!adis->buffer)
-		return -ENOMEM;
-
 	if (!(st->variant->flags & ADIS16400_NO_BURST) &&
 		st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
 		st->adis.spi->max_speed_hz = ADIS16400_SPI_BURST;
-- 
2.31.1

