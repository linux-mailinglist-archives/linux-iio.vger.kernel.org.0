Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC918DEE9
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 10:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgCUJAd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 05:00:33 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42956 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728008AbgCUJAd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 05:00:33 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L8st3n014731;
        Sat, 21 Mar 2020 05:00:19 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs5rdqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 05:00:19 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 02L90HpF049901
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 21 Mar 2020 05:00:17 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 02:00:16 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sat, 21 Mar 2020 02:00:15 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02L90CUH009329;
        Sat, 21 Mar 2020 05:00:12 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <andriy.shevchenko@linux.intel.com>,
        <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: buffer: re-introduce bitmap_zalloc() for trialmask
Date:   Sat, 21 Mar 2020 10:59:56 +0200
Message-ID: <20200321085956.11213-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317123621.27722-1-alexandru.ardelean@analog.com>
References: <20200317123621.27722-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-21_02:2020-03-20,2020-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003210051
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 3862828a903d3 ("iio: buffer: Switch to bitmap_zalloc()") introduced
bitmap_alloc(), but commit 20ea39ef9f2f9 ("iio: Fix scan mask selection")
reverted it.

This change adds it back. The only difference is that it's adding
bitmap_zalloc(). There might be some changes later that would require
initializing it to zero. In any case, now it's already zero-ing the
trialmask.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* add 'Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>' 
* re-send from an Analog server; GMail changed the author to @gmail.com

 drivers/iio/industrialio-buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4ada5592aa2b..5ff34ce8b6a2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -316,8 +316,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 	const unsigned long *mask;
 	unsigned long *trialmask;
 
-	trialmask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
-			    sizeof(*trialmask), GFP_KERNEL);
+	trialmask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
 	if (trialmask == NULL)
 		return -ENOMEM;
 	if (!indio_dev->masklength) {
-- 
2.17.1

