Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAFC367E68
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhDVKRe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Apr 2021 06:17:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46626 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235762AbhDVKRe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Apr 2021 06:17:34 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MAG6Mk009027;
        Thu, 22 Apr 2021 06:16:47 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3834980gbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:16:46 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 13MAGjWH039900
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Apr 2021 06:16:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 22 Apr 2021 06:16:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 22 Apr 2021 06:16:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 22 Apr 2021 06:16:44 -0400
Received: from nsa.sphairon.box ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13MAGffC027460;
        Thu, 22 Apr 2021 06:16:42 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v2 1/9] iio: adis_buffer: do not return ints in irq handlers
Date:   Thu, 22 Apr 2021 12:19:03 +0200
Message-ID: <20210422101911.135630-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422101911.135630-1-nuno.sa@analog.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 6PpN4DROCJOh2LJpzhCmeEMXAb0HI7aZ
X-Proofpoint-GUID: 6PpN4DROCJOh2LJpzhCmeEMXAb0HI7aZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=998
 spamscore=0 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104220086
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On an IRQ handler we should not return normal error codes as 'irqreturn_t'
is expected.

Fixes: ccd2b52f4ac69 ("staging:iio: Add common ADIS library")
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis_buffer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index ac354321f63a..175af154e443 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -129,9 +129,6 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	if (!adis->buffer)
-		return -ENOMEM;
-
 	if (adis->data->has_paging) {
 		mutex_lock(&adis->state_lock);
 		if (adis->current_page != 0) {
-- 
2.31.1

