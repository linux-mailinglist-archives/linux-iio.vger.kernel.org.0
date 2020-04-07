Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51601A0FDF
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 17:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgDGPGv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 11:06:51 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22528 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728917AbgDGPGv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 11:06:51 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037Esnkf031914;
        Tue, 7 Apr 2020 11:06:50 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 306m36b23f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 11:06:49 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 037F6mIF004900
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 7 Apr 2020 11:06:48 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 7 Apr 2020 08:06:47 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 7 Apr 2020 08:06:47 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 7 Apr 2020 08:06:46 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 037F6i2a022691;
        Tue, 7 Apr 2020 11:06:44 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3] iio: move 'indio_dev->info' null check first in __iio_device_register()
Date:   Tue, 7 Apr 2020 18:07:43 +0300
Message-ID: <20200407150743.8144-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406123246.57684-1-alexandru.ardelean@analog.com>
References: <20200406123246.57684-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_07:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070128
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Moves this to be the first check, as it's very simple and fails the
registration earlier, instead of potentially initializing the
'indio_dev->label' and checking for duplicate indexes, and then failing
with this simple-check.

This is a minor optimization, since '__iio_device_register()' will waste
fewer validation cycles in case 'indio_dev->info' is NULL.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* fixed typo 'regitration' -> 'registration'

Changelog v2 -> v3:
* title update to include __iio_device_register()
* dropped 'Doesn't fix anything.' 
* added sentence about the minor optimization

 drivers/iio/industrialio-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 157d95a24faa..56ff24d7a174 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1711,6 +1711,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
 	int ret;
 
+	if (!indio_dev->info)
+		return -EINVAL;
+
 	indio_dev->driver_module = this_mod;
 	/* If the calling driver did not initialize of_node, do it here */
 	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
@@ -1723,9 +1726,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (ret < 0)
 		return ret;
 
-	if (!indio_dev->info)
-		return -EINVAL;
-
 	/* configure elements for the chrdev */
 	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
 
-- 
2.17.1

