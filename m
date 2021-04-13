Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5002235DD9E
	for <lists+linux-iio@lfdr.de>; Tue, 13 Apr 2021 13:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345299AbhDMLT2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Apr 2021 07:19:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24410 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345402AbhDMLTQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Apr 2021 07:19:16 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DBAwmC026698;
        Tue, 13 Apr 2021 07:18:47 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 37vwhm28c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 07:18:46 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 13DBIjaP057130
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Apr 2021 07:18:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 13 Apr 2021 07:18:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 13 Apr 2021 07:18:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 13 Apr 2021 07:18:44 -0400
Received: from nsa.sphairon.box ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13DBIbDC010275;
        Tue, 13 Apr 2021 07:18:42 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] iio: adis_buffer: check return value on page change
Date:   Tue, 13 Apr 2021 13:21:03 +0200
Message-ID: <20210413112105.69458-6-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413112105.69458-1-nuno.sa@analog.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: SPwd8orrlU8WOrwYtRcsB0Rpj_5gZtDS
X-Proofpoint-GUID: SPwd8orrlU8WOrwYtRcsB0Rpj_5gZtDS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_04:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=932 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130078
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On the trigger handler, we might need to change the device page. Hence,
we should check the return value from 'spi_write()' and act accordingly.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis_buffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index f89bce10090a..7ab15c08889f 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -137,7 +137,11 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
 		if (adis->current_page != 0) {
 			adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
 			adis->tx[1] = 0;
-			spi_write(adis->spi, adis->tx, 2);
+			ret = spi_write(adis->spi, adis->tx, 2);
+			if (ret) {
+				dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
+				goto irq_done;
+			}
 		}
 	}
 
-- 
2.31.1

