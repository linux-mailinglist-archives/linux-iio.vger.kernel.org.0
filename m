Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE29B1CB17E
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 16:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgEHONM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 10:13:12 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24884 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbgEHONL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 10:13:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048E4pOO006835;
        Fri, 8 May 2020 10:13:11 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtef2mak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 10:13:11 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 048ED9SL044954
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 10:13:09 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 May 2020 07:13:08 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 07:13:07 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048ED5JZ031800;
        Fri, 8 May 2020 10:13:06 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] iio: core: simplify alloc alignment code
Date:   Fri, 8 May 2020 17:13:05 +0300
Message-ID: <20200508141306.17222-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508141306.17222-1-alexandru.ardelean@analog.com>
References: <20200508141306.17222-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080126
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There was a recent discussion about this code:
  https://lore.kernel.org/linux-iio/20200322165317.0b1f0674@archlinux/

This looks like a good time to rework this, since any issues about it
should pop-up under testing, because the iio_dev is having a bit of an
overhaul and stuff being moved to iio_dev_priv.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f0888dd84d3d..b924197b5984 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1521,13 +1521,9 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 	struct iio_dev *dev;
 	size_t alloc_size;
 
-	alloc_size = sizeof(struct iio_dev_priv);
-	if (sizeof_priv) {
-		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
-		alloc_size += sizeof_priv;
-	}
-	/* ensure 32-byte alignment of whole construct ? */
-	alloc_size += IIO_ALIGN - 1;
+	alloc_size = ALIGN(sizeof(struct iio_dev_priv), IIO_ALIGN);
+	if (sizeof_priv)
+		alloc_size += ALIGN(sizeof_priv, IIO_ALIGN);
 
 	iio_dev_priv = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iio_dev_priv)
-- 
2.17.1

