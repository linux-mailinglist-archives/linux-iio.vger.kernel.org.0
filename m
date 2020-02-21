Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DB1167D19
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 13:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgBUMH1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 07:07:27 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4650 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbgBUMH0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 07:07:26 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LC0PKc028503;
        Fri, 21 Feb 2020 07:07:25 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8uduq0k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 07:07:24 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01LC7Nkk032415
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 21 Feb 2020 07:07:23 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 21 Feb 2020 04:07:21 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 21 Feb 2020 04:06:32 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 21 Feb 2020 04:07:21 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01LC7H1L018878;
        Fri, 21 Feb 2020 07:07:18 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: industrialio-core: Fix debugfs read
Date:   Fri, 21 Feb 2020 14:06:55 +0200
Message-ID: <20200221120655.20252-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=841
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210093
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently iio_debugfs_read_reg calls debugfs_reg_access
every time it is ran. Reading the same hardware register
multiple times during the same reading of a debugfs file
can cause unintended effects.

For example for each: cat iio:device0/direct_reg_access
the file_operations.read function will be called at least
twice. First will return the full length of the string in
bytes  and the second will return 0.

This patch makes iio_debugfs_read_reg to call debugfs_reg_access
only when the user's buffer position (*ppos) is 0. (meaning
it is the beginning of a new reading of the debugfs file).

Fixes: e553f182d55b ("staging: iio: core: Introduce debugfs support, add support for direct register access")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/industrialio-core.c | 15 +++++++++++----
 include/linux/iio/iio.h         |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 65ff0d067018..c4d5104934fc 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -301,11 +301,14 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
 {
 	struct iio_dev *indio_dev = file->private_data;
-	char buf[20];
 	unsigned val = 0;
-	ssize_t len;
 	int ret;
 
+	if (*ppos > 0)
+		return simple_read_from_buffer(userbuf, count, ppos,
+					       indio_dev->read_buf,
+					       indio_dev->read_buf_len);
+
 	ret = indio_dev->info->debugfs_reg_access(indio_dev,
 						  indio_dev->cached_reg_addr,
 						  0, &val);
@@ -314,9 +317,13 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 		return ret;
 	}
 
-	len = snprintf(buf, sizeof(buf), "0x%X\n", val);
+	indio_dev->read_buf_len = snprintf(indio_dev->read_buf,
+					   sizeof(indio_dev->read_buf),
+					   "0x%X\n", val);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_read_from_buffer(userbuf, count, ppos,
+				       indio_dev->read_buf,
+				       indio_dev->read_buf_len);
 }
 
 static ssize_t iio_debugfs_write_reg(struct file *file,
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 862ce0019eba..eed58ed2f368 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -568,6 +568,8 @@ struct iio_dev {
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
 	unsigned			cached_reg_addr;
+	char				read_buf[20];
+	unsigned int			read_buf_len;
 #endif
 };
 
-- 
2.20.1

