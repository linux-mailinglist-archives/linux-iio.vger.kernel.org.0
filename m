Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276F71DE027
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 08:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgEVGx1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 02:53:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23442 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgEVGx1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 02:53:27 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04M6l4aK026754;
        Fri, 22 May 2020 02:53:22 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 312d364vcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 02:53:22 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04M6rL3p047498
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 May 2020 02:53:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 02:53:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 02:53:20 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 May 2020 02:53:20 -0400
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04M6rIfF024722;
        Fri, 22 May 2020 02:53:18 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jeff@labundy.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: position: iqs624: remove usage of iio_priv_to_dev()
Date:   Fri, 22 May 2020 09:53:22 +0300
Message-ID: <20200522065322.9611-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_02:2020-05-21,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1011 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We may want to get rid of the iio_priv_to_dev() helper. That's a bit
uncertain at this point. The reason is that we will hide some of the
members of the iio_dev structure (to prevent drivers from accessing them
directly), and that will also mean hiding the implementation of the
iio_priv_to_dev() helper inside the IIO core.

Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
may not be fast anymore, so a general idea is to try to get rid of the
iio_priv_to_dev() altogether.

For this driver, removing iio_priv_to_dev() also means keeping a reference
on the state struct.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/position/iqs624-pos.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs624-pos.c
index 77096c31c2ba..520dafbdc48f 100644
--- a/drivers/iio/position/iqs624-pos.c
+++ b/drivers/iio/position/iqs624-pos.c
@@ -23,6 +23,7 @@
 
 struct iqs624_pos_private {
 	struct iqs62x_core *iqs62x;
+	struct iio_dev *indio_dev;
 	struct notifier_block notifier;
 	struct mutex lock;
 	bool angle_en;
@@ -59,7 +60,7 @@ static int iqs624_pos_notifier(struct notifier_block *notifier,
 
 	iqs624_pos = container_of(notifier, struct iqs624_pos_private,
 				  notifier);
-	indio_dev = iio_priv_to_dev(iqs624_pos);
+	indio_dev = iqs624_pos->indio_dev;
 	timestamp = iio_get_time_ns(indio_dev);
 
 	iqs62x = iqs624_pos->iqs62x;
@@ -98,7 +99,7 @@ static int iqs624_pos_notifier(struct notifier_block *notifier,
 static void iqs624_pos_notifier_unregister(void *context)
 {
 	struct iqs624_pos_private *iqs624_pos = context;
-	struct iio_dev *indio_dev = iio_priv_to_dev(iqs624_pos);
+	struct iio_dev *indio_dev = iqs624_pos->indio_dev;
 	int ret;
 
 	ret = blocking_notifier_chain_unregister(&iqs624_pos->iqs62x->nh,
@@ -243,6 +244,7 @@ static int iqs624_pos_probe(struct platform_device *pdev)
 
 	iqs624_pos = iio_priv(indio_dev);
 	iqs624_pos->iqs62x = iqs62x;
+	iqs624_pos->indio_dev = indio_dev;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->dev.parent = &pdev->dev;
-- 
2.25.1

