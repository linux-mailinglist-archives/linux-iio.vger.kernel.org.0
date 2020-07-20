Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DCE22614D
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgGTNtx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 09:49:53 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9252 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbgGTNtx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 09:49:53 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KDimtX000539;
        Mon, 20 Jul 2020 09:49:40 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32cv13vhqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 09:49:40 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06KDncjp061593
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 20 Jul 2020 09:49:38 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 20 Jul
 2020 06:49:37 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 20 Jul 2020 06:49:37 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06KDnYqS003178;
        Mon, 20 Jul 2020 09:49:34 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: trigger: make stub functions static inline
Date:   Mon, 20 Jul 2020 16:51:33 +0300
Message-ID: <20200720135133.72154-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714142456.67054-1-alexandru.ardelean@analog.com>
References: <20200714142456.67054-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_09:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200096
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Make sure that the trigger function stubs are all static inline.
Otherwise we might see compiler warnings about declared but unused
functions.

Fixes 77712e5fbe2e4: ("Staging: iio: Staticise non-exported functions")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* fix commit description & title
* added proper Fixes tag

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

