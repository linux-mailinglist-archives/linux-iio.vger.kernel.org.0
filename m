Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED64166400
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2020 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgBTRIK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Feb 2020 12:08:10 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56324 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728701AbgBTRIJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2020 12:08:09 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KGxu1W015666;
        Thu, 20 Feb 2020 12:08:08 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8udumrex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 12:08:07 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01KH86vl003517
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 20 Feb 2020 12:08:06 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 20 Feb 2020 09:08:04 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 20 Feb 2020 09:08:03 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 20 Feb 2020 09:08:03 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01KH80KI001949;
        Thu, 20 Feb 2020 12:08:00 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH] iio: industrialio-core: Fix debugfs read
Date:   Thu, 20 Feb 2020 19:07:26 +0200
Message-ID: <20200220170726.9580-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_04:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=900
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200126
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
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/industrialio-core.c | 34 +++++++++++++++++++++++----------
 include/linux/iio/iio.h         |  2 ++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 65ff0d067018..637cea14afdb 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -297,26 +297,40 @@ static void __exit iio_exit(void)
 }
 
 #if defined(CONFIG_DEBUG_FS)
-static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
-			      size_t count, loff_t *ppos)
+static int iio_debugfs_get_reg_string(struct iio_dev *indio_dev)
 {
-	struct iio_dev *indio_dev = file->private_data;
-	char buf[20];
+	const struct iio_info *info = indio_dev->info;
 	unsigned val = 0;
-	ssize_t len;
 	int ret;
 
-	ret = indio_dev->info->debugfs_reg_access(indio_dev,
-						  indio_dev->cached_reg_addr,
-						  0, &val);
+	ret = info->debugfs_reg_access(indio_dev, indio_dev->cached_reg_addr,
+				       0, &val);
 	if (ret) {
 		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
 		return ret;
 	}
+	indio_dev->read_buf_len = snprintf(indio_dev->read_buf,
+					   sizeof(indio_dev->read_buf),
+					   "0x%X\n", val);
+	return 0;
+}
 
-	len = snprintf(buf, sizeof(buf), "0x%X\n", val);
+static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
+				    size_t count, loff_t *ppos)
+{
+	struct iio_dev *indio_dev = file->private_data;
+	loff_t pos = *ppos;
+	int ret;
+
+	if (pos == 0) {
+		ret = iio_debugfs_get_reg_string(indio_dev);
+		if (ret)
+			return ret;
+	}
 
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

