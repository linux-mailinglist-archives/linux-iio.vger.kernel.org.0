Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC8227CD8
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGUKYX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 06:24:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51376 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727907AbgGUKYX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 06:24:23 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LAF6q8004345;
        Tue, 21 Jul 2020 06:24:21 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32cv13yhn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 06:24:21 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06LAOJWs039876
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 21 Jul 2020 06:24:20 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 21 Jul 2020 03:24:18 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 21 Jul 2020 03:24:18 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 21 Jul 2020 03:24:18 -0700
Received: from saturn.ad.analog.com ([10.48.65.113])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06LAOGww012784;
        Tue, 21 Jul 2020 06:24:16 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <dbaryshkov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: core: fix/re-introduce back parent assignment
Date:   Tue, 21 Jul 2020 13:24:07 +0300
Message-ID: <20200721102407.134402-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_03:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1011 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This was introduced initially via commit 78289b4a58b58 ("iio: core: pass
parent device as parameter during allocation"), but was accidentally
removed via commit 6d4ebd565d15f ("iio: core: wrap IIO device into an
iio_dev_opaque object").

This looks like a rebase gone wrong, and ends up breaking devicetree
bindings of IIO clients.

This change adds back the parent assignment.

Fixes 6d4ebd565d15f: ("iio: core: wrap IIO device into an iio_dev_opaque object")
Reported-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 30fc96952681..59003dc44e60 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1546,6 +1546,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	dev->priv = (char *)iio_dev_opaque +
 		ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
 
+	dev->dev.parent = parent;
 	dev->dev.groups = dev->groups;
 	dev->dev.type = &iio_device_type;
 	dev->dev.bus = &iio_bus_type;
-- 
2.25.1

