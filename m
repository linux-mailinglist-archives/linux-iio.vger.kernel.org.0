Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593F11ECE94
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 13:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgFCLki (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 07:40:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27216 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgFCLkh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2020 07:40:37 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053BdehX022887;
        Wed, 3 Jun 2020 07:40:36 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 31e4scs6ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 07:40:36 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 053BeZVh004329
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 3 Jun 2020 07:40:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 3 Jun 2020
 07:40:34 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 3 Jun 2020 07:40:33 -0400
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 053BeOtL017839;
        Wed, 3 Jun 2020 07:40:31 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <johan@kernel.org>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 5/6] iio: light: lm3533-als: use iio_device_set_parent() to assign parent
Date:   Wed, 3 Jun 2020 14:40:22 +0300
Message-ID: <20200603114023.175102-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603114023.175102-1-alexandru.ardelean@analog.com>
References: <20200603114023.175102-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_11:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 cotscore=-2147483648 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030093
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This assignment is the more peculiar as it assigns the parent of the
platform-device's device (i.e. pdev->dev.parent) as the IIO device's
parent.

Since the devm_iio_device_alloc() [now] assigns the device argument as the
default parent (and since this is the more common case), for cases
where the parent needs to be different, the iio_device_set_parent helper
should be used.

That makes things a bit more obvious about the new behavior of
devm_iio_device_alloc() and makes it clearer that iio_device_set_parent()
should be used.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/light/lm3533-als.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index bc196c212881..8a621244dd01 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -852,7 +852,7 @@ static int lm3533_als_probe(struct platform_device *pdev)
 	indio_dev->channels = lm3533_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
 	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->dev.parent = pdev->dev.parent;
+	iio_device_set_parent(indio_dev, pdev->dev.parent);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	als = iio_priv(indio_dev);
-- 
2.25.1

