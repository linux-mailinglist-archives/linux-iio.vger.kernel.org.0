Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2063631F627
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 10:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhBSJCG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 04:02:06 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37156 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhBSJCG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 04:02:06 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11J8teSP000406;
        Fri, 19 Feb 2021 04:01:13 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjb1q8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 04:01:13 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11J91C5U047822
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Feb 2021 04:01:12 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 19 Feb 2021 04:01:08 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 19 Feb 2021 04:01:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 19 Feb 2021 04:01:08 -0500
Received: from saturn.ad.analog.com ([10.48.65.120])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11J8wx49029584;
        Fri, 19 Feb 2021 03:59:01 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] iio: core: use kfree_const in iio_free_chan_devattr_list() to free names
Date:   Fri, 19 Feb 2021 10:58:25 +0200
Message-ID: <20210219085826.46622-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219085826.46622-1-alexandru.ardelean@analog.com>
References: <20210219085826.46622-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_02:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190070
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the buffer attributes were wrapped in iio_dev_attr types, I forgot to
duplicate the names, so that when iio_free_chan_devattr_list() gets called
on cleanup, these get free'd.
I stumbled over this while accidentally breaking a driver doing
iio_device_register(), and then the issue appeared.

The fix can be just
1. Just use kstrdup() during iio_buffer_wrap_attr()
2. Just use kfree_const() during iio_free_chan_devattr_list
3. Use both kstrdup_const() & kfree_const() (in the places mentioned above)

Using kfree_const() should be sufficient, as the attribute names will
either be allocated or be stored in rodata.

Fixes: a1a11142f66c ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0d8c6e88d993..cb2735d2ae4b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1358,7 +1358,7 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
 	struct iio_dev_attr *p, *n;
 
 	list_for_each_entry_safe(p, n, attr_list, l) {
-		kfree(p->dev_attr.attr.name);
+		kfree_const(p->dev_attr.attr.name);
 		list_del(&p->l);
 		kfree(p);
 	}
-- 
2.27.0

