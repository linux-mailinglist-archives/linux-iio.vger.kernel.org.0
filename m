Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B50316340
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 11:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhBJKJd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 05:09:33 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42728 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230182AbhBJKHF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 05:07:05 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AA3JCL018143;
        Wed, 10 Feb 2021 05:06:11 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hr7qc5wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:06:10 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11AA69h8025897
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Feb 2021 05:06:09 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Wed, 10 Feb 2021
 05:06:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Wed, 10 Feb 2021 05:06:08 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11AA5x09018045;
        Wed, 10 Feb 2021 05:06:05 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 03/17] iio: core-trigger: make iio_device_register_trigger_consumer() an int return
Date:   Wed, 10 Feb 2021 12:08:09 +0200
Message-ID: <20210210100823.46780-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210100823.46780-1-alexandru.ardelean@analog.com>
References: <20210210100823.46780-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_03:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100097
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Oddly enough the noop function is an int-return. This one seems to be void.
This change converts it to int, because we want to change how groups are
registered. With that change this function could error out with -ENOMEM.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core_trigger.h     | 4 +++-
 drivers/iio/industrialio-trigger.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
index 374816bc3e73..e1a56824e07f 100644
--- a/drivers/iio/iio_core_trigger.h
+++ b/drivers/iio/iio_core_trigger.h
@@ -9,8 +9,10 @@
 /**
  * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
  * @indio_dev: iio_dev associated with the device that will consume the trigger
+ *
+ * Return 0 if successful, negative otherwise
  **/
-void iio_device_register_trigger_consumer(struct iio_dev *indio_dev);
+int iio_device_register_trigger_consumer(struct iio_dev *indio_dev);
 
 /**
  * iio_device_unregister_trigger_consumer() - reverse the registration process
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ea3c9859b258..438d5012e8b8 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -692,10 +692,12 @@ int iio_trigger_validate_own_device(struct iio_trigger *trig,
 }
 EXPORT_SYMBOL(iio_trigger_validate_own_device);
 
-void iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
+int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
 {
 	indio_dev->groups[indio_dev->groupcounter++] =
 		&iio_trigger_consumer_attr_group;
+
+	return 0;
 }
 
 void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
-- 
2.17.1

