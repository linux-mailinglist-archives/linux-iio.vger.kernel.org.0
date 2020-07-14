Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7A421F3D5
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jul 2020 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgGNOXH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jul 2020 10:23:07 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34086 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgGNOXG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jul 2020 10:23:06 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06EEMR2k018763;
        Tue, 14 Jul 2020 10:22:52 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 327ab4rv35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 10:22:52 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06EEMpOk015305
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 14 Jul 2020 10:22:51 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 14 Jul 2020 10:22:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 14 Jul 2020 10:22:49 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 14 Jul 2020 10:22:48 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06EEMjUb020477;
        Tue, 14 Jul 2020 10:22:46 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: trigger: Staticise stub functions
Date:   Tue, 14 Jul 2020 17:24:56 +0300
Message-ID: <20200714142456.67054-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_04:2020-07-14,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Make sure that the trigger function stubs are all static inline. Otherwise
we'll get linker errors due to multiple definitions of the same function.

Fixes f8c6f4e9a40d4: ("iio: trigger: Staticise stub functions")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

FWIW: we can skip the Fixes tag from my side; this has been present for
a while.
I just bumped into it while sync-ing the ADI tree with some upstream
stuff.

 drivers/iio/iio_core_trigger.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
index 9d1a92cc6480..374816bc3e73 100644
--- a/drivers/iio/iio_core_trigger.h
+++ b/drivers/iio/iio_core_trigger.h
@@ -30,7 +30,7 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
  * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
  * @indio_dev: iio_dev associated with the device that will consume the trigger
  **/
-static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
+static inline int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
 {
 	return 0;
 }
@@ -39,7 +39,7 @@ static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
  * iio_device_unregister_trigger_consumer() - reverse the registration process
  * @indio_dev: iio_dev associated with the device that consumed the trigger
  **/
-static void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
+static inline void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 {
 }
 
-- 
2.17.1

