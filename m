Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A06A1DE02D
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 08:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgEVGyt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 02:54:49 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8908 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgEVGyt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 02:54:49 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04M6savm030023;
        Fri, 22 May 2020 02:54:44 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 312a17dh6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 02:54:44 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04M6sgdO047627
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 22 May 2020 02:54:43 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 21 May 2020 23:54:41 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 21 May 2020 23:54:41 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 21 May 2020 23:54:41 -0700
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04M6sc1K024734;
        Fri, 22 May 2020 02:54:38 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jeff@labundy.com>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: light: iqs621: remove usage of iio_priv_to_dev()
Date:   Fri, 22 May 2020 09:54:42 +0300
Message-ID: <20200522065442.10203-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_02:2020-05-21,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220055
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

For this driver, removing iio_priv_to_dev() means keeping a reference
on the state struct.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/light/iqs621-als.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
index b2988a782bd0..1a056e2446ab 100644
--- a/drivers/iio/light/iqs621-als.c
+++ b/drivers/iio/light/iqs621-als.c
@@ -36,6 +36,7 @@
 
 struct iqs621_als_private {
 	struct iqs62x_core *iqs62x;
+	struct iio_dev *indio_dev;
 	struct notifier_block notifier;
 	struct mutex lock;
 	bool light_en;
@@ -103,7 +104,7 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
 
 	iqs621_als = container_of(notifier, struct iqs621_als_private,
 				  notifier);
-	indio_dev = iio_priv_to_dev(iqs621_als);
+	indio_dev = iqs621_als->indio_dev;
 	timestamp = iio_get_time_ns(indio_dev);
 
 	mutex_lock(&iqs621_als->lock);
@@ -191,7 +192,7 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
 static void iqs621_als_notifier_unregister(void *context)
 {
 	struct iqs621_als_private *iqs621_als = context;
-	struct iio_dev *indio_dev = iio_priv_to_dev(iqs621_als);
+	struct iio_dev *indio_dev = iqs621_als->indio_dev;
 	int ret;
 
 	ret = blocking_notifier_chain_unregister(&iqs621_als->iqs62x->nh,
@@ -551,6 +552,7 @@ static int iqs621_als_probe(struct platform_device *pdev)
 
 	iqs621_als = iio_priv(indio_dev);
 	iqs621_als->iqs62x = iqs62x;
+	iqs621_als->indio_dev = indio_dev;
 
 	if (iqs62x->dev_desc->prod_num == IQS622_PROD_NUM) {
 		ret = regmap_read(iqs62x->regmap, IQS622_IR_THRESH_TOUCH,
-- 
2.25.1

