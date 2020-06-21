Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43350202A7E
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 14:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgFUMcC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 08:32:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7470 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730044AbgFUMcB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 08:32:01 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05LCNA0F030148;
        Sun, 21 Jun 2020 08:31:43 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 31sfc5abfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jun 2020 08:31:43 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 05LCVgCi040918
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 21 Jun 2020 08:31:42 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 21 Jun 2020 08:31:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 21 Jun 2020 08:31:41 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 21 Jun 2020 08:31:41 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05LCVWVd007980;
        Sun, 21 Jun 2020 08:31:38 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 4/7] iio: core: move debugfs data on the private iio dev info
Date:   Sun, 21 Jun 2020 15:33:42 +0300
Message-ID: <20200621123345.2469-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200621123345.2469-1-alexandru.ardelean@analog.com>
References: <20200621123345.2469-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-21_05:2020-06-19,2020-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 cotscore=-2147483648 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006210101
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change moves all iio_dev debugfs fields to the iio_dev_priv object.
It's not the biggest advantage yet (to the whole thing of abstractization)
but it's a start.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 40 ++++++++++++++++++++++-----------
 include/linux/iio/iio-opaque.h  | 10 +++++++++
 include/linux/iio/iio.h         | 13 +----------
 3 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 27005ba4d09c..05175cf80c98 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -165,6 +165,13 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
 };
 
+struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	return iio_dev_opaque->debugfs_dentry;
+}
+EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
+
 /**
  * iio_find_channel_from_si() - get channel from its scan index
  * @indio_dev:		device
@@ -308,35 +315,37 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
 {
 	struct iio_dev *indio_dev = file->private_data;
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	unsigned val = 0;
 	int ret;
 
 	if (*ppos > 0)
 		return simple_read_from_buffer(userbuf, count, ppos,
-					       indio_dev->read_buf,
-					       indio_dev->read_buf_len);
+					       iio_dev_opaque->read_buf,
+					       iio_dev_opaque->read_buf_len);
 
 	ret = indio_dev->info->debugfs_reg_access(indio_dev,
-						  indio_dev->cached_reg_addr,
+						  iio_dev_opaque->cached_reg_addr,
 						  0, &val);
 	if (ret) {
 		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
 		return ret;
 	}
 
-	indio_dev->read_buf_len = snprintf(indio_dev->read_buf,
-					   sizeof(indio_dev->read_buf),
-					   "0x%X\n", val);
+	iio_dev_opaque->read_buf_len = snprintf(iio_dev_opaque->read_buf,
+					      sizeof(iio_dev_opaque->read_buf),
+					      "0x%X\n", val);
 
 	return simple_read_from_buffer(userbuf, count, ppos,
-				       indio_dev->read_buf,
-				       indio_dev->read_buf_len);
+				       iio_dev_opaque->read_buf,
+				       iio_dev_opaque->read_buf_len);
 }
 
 static ssize_t iio_debugfs_write_reg(struct file *file,
 		     const char __user *userbuf, size_t count, loff_t *ppos)
 {
 	struct iio_dev *indio_dev = file->private_data;
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	unsigned reg, val;
 	char buf[80];
 	int ret;
@@ -351,10 +360,10 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 
 	switch (ret) {
 	case 1:
-		indio_dev->cached_reg_addr = reg;
+		iio_dev_opaque->cached_reg_addr = reg;
 		break;
 	case 2:
-		indio_dev->cached_reg_addr = reg;
+		iio_dev_opaque->cached_reg_addr = reg;
 		ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
 							  val, NULL);
 		if (ret) {
@@ -378,23 +387,28 @@ static const struct file_operations iio_debugfs_reg_fops = {
 
 static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
 {
-	debugfs_remove_recursive(indio_dev->debugfs_dentry);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
 }
 
 static void iio_device_register_debugfs(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque;
+
 	if (indio_dev->info->debugfs_reg_access == NULL)
 		return;
 
 	if (!iio_debugfs_dentry)
 		return;
 
-	indio_dev->debugfs_dentry =
+	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	iio_dev_opaque->debugfs_dentry =
 		debugfs_create_dir(dev_name(&indio_dev->dev),
 				   iio_debugfs_dentry);
 
 	debugfs_create_file("direct_reg_access", 0644,
-			    indio_dev->debugfs_dentry, indio_dev,
+			    iio_dev_opaque->debugfs_dentry, indio_dev,
 			    &iio_debugfs_reg_fops);
 }
 #else
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 1375674f14cd..b3f234b4c1e9 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -6,9 +6,19 @@
 /**
  * struct iio_dev_opaque - industrial I/O device opaque information
  * @indio_dev:			public industrial I/O device information
+ * @debugfs_dentry:		device specific debugfs dentry
+ * @cached_reg_addr:		cached register address for debugfs reads
+ * @read_buf:			read buffer to be used for the initial reg read
+ * @read_buf_len:		data length in @read_buf
  */
 struct iio_dev_opaque {
 	struct iio_dev			indio_dev;
+#if defined(CONFIG_DEBUG_FS)
+	struct dentry			*debugfs_dentry;
+	unsigned			cached_reg_addr;
+	char				read_buf[20];
+	unsigned int			read_buf_len;
+#endif
 };
 
 #define to_iio_dev_opaque(indio_dev)		\
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 86112e35ae5f..bb0aae11a111 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -520,8 +520,6 @@ struct iio_buffer_setup_ops {
  * @groups:		[INTERN] attribute groups
  * @groupcounter:	[INTERN] index of next attribute group
  * @flags:		[INTERN] file ops related flags including busy flag.
- * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
- * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
  * @priv:		[DRIVER] reference to driver's private information
  *			**MUST** be accessed **ONLY** via iio_priv() helper
  */
@@ -567,12 +565,6 @@ struct iio_dev {
 	int				groupcounter;
 
 	unsigned long			flags;
-#if defined(CONFIG_DEBUG_FS)
-	struct dentry			*debugfs_dentry;
-	unsigned			cached_reg_addr;
-	char				read_buf[20];
-	unsigned int			read_buf_len;
-#endif
 	void				*priv;
 };
 
@@ -727,10 +719,7 @@ static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
  * @indio_dev:		IIO device structure for device
  **/
 #if defined(CONFIG_DEBUG_FS)
-static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
-{
-	return indio_dev->debugfs_dentry;
-}
+struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev);
 #else
 static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 {
-- 
2.17.1

