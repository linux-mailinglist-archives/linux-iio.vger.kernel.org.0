Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F01BF38D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 10:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD3Iwu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 04:52:50 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49670 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbgD3Iwt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 04:52:49 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U8nTxk003275;
        Thu, 30 Apr 2020 04:52:48 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30pes2gct2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 04:52:48 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03U8qkZL039832
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 30 Apr 2020 04:52:47 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Apr 2020 01:52:45 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Apr 2020 01:52:14 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 30 Apr 2020 01:52:45 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03U8qgrv001396;
        Thu, 30 Apr 2020 04:52:43 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: remove iio_get_debugfs_dentry() helper
Date:   Thu, 30 Apr 2020 11:52:59 +0300
Message-ID: <20200430085259.2829-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_03:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=995 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Not used anywhere.
Looks like it was forgotten in iio.h

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/iio.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 38c4ea505394..1a1da52c55cf 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -696,22 +696,6 @@ static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
 		   INDIO_BUFFER_SOFTWARE);
 }
 
-/**
- * iio_get_debugfs_dentry() - helper function to get the debugfs_dentry
- * @indio_dev:		IIO device structure for device
- **/
-#if defined(CONFIG_DEBUG_FS)
-static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
-{
-	return indio_dev->debugfs_dentry;
-}
-#else
-static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
-{
-	return NULL;
-}
-#endif
-
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
-- 
2.17.1

