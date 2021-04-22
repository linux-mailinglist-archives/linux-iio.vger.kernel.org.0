Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4D367E6E
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 12:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhDVKRi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Apr 2021 06:17:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49738 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235796AbhDVKRg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Apr 2021 06:17:36 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MAFnwr026122;
        Thu, 22 Apr 2021 06:16:51 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 382kdbuhk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:16:51 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 13MAGoDD039916
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Apr 2021 06:16:50 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 22 Apr 2021 03:16:49 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 22 Apr 2021 03:16:48 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 22 Apr 2021 03:16:48 -0700
Received: from nsa.sphairon.box ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13MAGffG027460;
        Thu, 22 Apr 2021 06:16:46 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 5/9] iio: adis_buffer: don't push data to buffers on failure
Date:   Thu, 22 Apr 2021 12:19:07 +0200
Message-ID: <20210422101911.135630-6-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422101911.135630-1-nuno.sa@analog.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: S-Rz8S1VX-mQUBrJ0_6kk-nWCakd6zZi
X-Proofpoint-ORIG-GUID: S-Rz8S1VX-mQUBrJ0_6kk-nWCakd6zZi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220086
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There's no point in pushing data to IIO buffers in case 'spi_sync()'
fails.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis_buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 0ae551a748eb..a29d22f657ce 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -144,9 +144,12 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
 	}
 
 	ret = spi_sync(adis->spi, &adis->msg);
-	if (ret)
+	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to read data: %d", ret);
-
+		if (adis->data->has_paging)
+			mutex_unlock(&adis->state_lock);
+		goto irq_done;
+	}
 
 	if (adis->data->has_paging) {
 		adis->current_page = 0;
-- 
2.31.1

