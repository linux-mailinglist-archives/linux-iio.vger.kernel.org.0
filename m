Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1810A1CB181
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 16:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgEHONQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 10:13:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24876 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbgEHONM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 10:13:12 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048E6vWr012108;
        Fri, 8 May 2020 10:13:11 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtek2j7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 10:13:11 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 048EDATb044959
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 10:13:10 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 8 May 2020
 10:13:08 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 10:13:08 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048ED5Ja031800;
        Fri, 8 May 2020 10:13:07 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3] iio: core: move debugfs data on the private iio dev info
Date:   Fri, 8 May 2020 17:13:06 +0300
Message-ID: <20200508141306.17222-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508141306.17222-1-alexandru.ardelean@analog.com>
References: <20200508141306.17222-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080126
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change moves all iio_dev debugfs fields to the iio_dev_priv object.
It's not the biggest advantage yet (to the whole thing of abstractization)
but it's a start.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h          | 10 +++++++++
 drivers/iio/industrialio-core.c | 40 ++++++++++++++++++++++-----------
 include/linux/iio/iio.h         | 13 +----------
 3 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 84f3b4590c05..bc9f580d2bdd 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -20,9 +20,19 @@ extern struct device_type iio_device_type;
 /**
  * struct iio_dev_priv - industrial I/O device private information
  * @indio_dev:			public IIO device object
+ * @debugfs_dentry:		device specific debugfs dentry
+ * @cached_reg_addr:		cached register address for debugfs reads
+ * @read_buf:			read buffer to be used for the initial reg read
+ * @read_buf_len:		data length in @read_buf
  */
 struct iio_dev_priv {
 	struct iio_dev			indio_dev;
+#if defined(CONFIG_DEBUG_FS)
+	struct dentry			*debugfs_dentry;
+	unsigned			cached_reg_addr;
+	char				read_buf[20];
+	unsigned int			read_buf_len;
+#endif
 };
 
 #define to_iio_dev_priv(indio_dev)	\
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b924197b5984..091ae79de751 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -181,6 +181,13 @@ struct iio_dev *iio_priv_to_dev(void *priv)
 }
 EXPORT_SYMBOL_GPL(iio_priv_to_dev);
 
+struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
+{
+	struct iio_dev_priv *iio_dev_priv = to_iio_dev_priv(indio_dev);
+	return iio_dev_priv->debugfs_dentry;
+}
+EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
+
 /**
  * iio_find_channel_from_si() - get channel from its scan index
  * @indio_dev:		device
@@ -324,35 +331,37 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
 {
 	struct iio_dev *indio_dev = file->private_data;
+	struct iio_dev_priv *iio_dev_priv = to_iio_dev_priv(indio_dev);
 	unsigned val = 0;
 	int ret;
 
 	if (*ppos > 0)
 		return simple_read_from_buffer(userbuf, count, ppos,
-					       indio_dev->read_buf,
-					       indio_dev->read_buf_len);
+					       iio_dev_priv->read_buf,
+					       iio_dev_priv->read_buf_len);
 
 	ret = indio_dev->info->debugfs_reg_access(indio_dev,
-						  indio_dev->cached_reg_addr,
+						  iio_dev_priv->cached_reg_addr,
 						  0, &val);
 	if (ret) {
 		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
 		return ret;
 	}
 
-	indio_dev->read_buf_len = snprintf(indio_dev->read_buf,
-					   sizeof(indio_dev->read_buf),
-					   "0x%X\n", val);
+	iio_dev_priv->read_buf_len = snprintf(iio_dev_priv->read_buf,
+					      sizeof(iio_dev_priv->read_buf),
+					      "0x%X\n", val);
 
 	return simple_read_from_buffer(userbuf, count, ppos,
-				       indio_dev->read_buf,
-				       indio_dev->read_buf_len);
+				       iio_dev_priv->read_buf,
+				       iio_dev_priv->read_buf_len);
 }
 
 static ssize_t iio_debugfs_write_reg(struct file *file,
 		     const char __user *userbuf, size_t count, loff_t *ppos)
 {
 	struct iio_dev *indio_dev = file->private_data;
+	struct iio_dev_priv *iio_dev_priv = to_iio_dev_priv(indio_dev);
 	unsigned reg, val;
 	char buf[80];
 	int ret;
@@ -367,10 +376,10 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 
 	switch (ret) {
 	case 1:
-		indio_dev->cached_reg_addr = reg;
+		iio_dev_priv->cached_reg_addr = reg;
 		break;
 	case 2:
-		indio_dev->cached_reg_addr = reg;
+		iio_dev_priv->cached_reg_addr = reg;
 		ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
 							  val, NULL);
 		if (ret) {
@@ -394,23 +403,28 @@ static const struct file_operations iio_debugfs_reg_fops = {
 
 static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
 {
-	debugfs_remove_recursive(indio_dev->debugfs_dentry);
+	struct iio_dev_priv *iio_dev_priv = to_iio_dev_priv(indio_dev);
+	debugfs_remove_recursive(iio_dev_priv->debugfs_dentry);
 }
 
 static void iio_device_register_debugfs(struct iio_dev *indio_dev)
 {
+	struct iio_dev_priv *iio_dev_priv;
+
 	if (indio_dev->info->debugfs_reg_access == NULL)
 		return;
 
 	if (!iio_debugfs_dentry)
 		return;
 
-	indio_dev->debugfs_dentry =
+	iio_dev_priv = to_iio_dev_priv(indio_dev);
+
+	iio_dev_priv->debugfs_dentry =
 		debugfs_create_dir(dev_name(&indio_dev->dev),
 				   iio_debugfs_dentry);
 
 	debugfs_create_file("direct_reg_access", 0644,
-			    indio_dev->debugfs_dentry, indio_dev,
+			    iio_dev_priv->debugfs_dentry, indio_dev,
 			    &iio_debugfs_reg_fops);
 }
 #else
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 38c4ea505394..6155e7aec60c 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -520,8 +520,6 @@ struct iio_buffer_setup_ops {
  * @groups:		[INTERN] attribute groups
  * @groupcounter:	[INTERN] index of next attribute group
  * @flags:		[INTERN] file ops related flags including busy flag.
- * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
- * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
  */
 struct iio_dev {
 	int				id;
@@ -565,12 +563,6 @@ struct iio_dev {
 	int				groupcounter;
 
 	unsigned long			flags;
-#if defined(CONFIG_DEBUG_FS)
-	struct dentry			*debugfs_dentry;
-	unsigned			cached_reg_addr;
-	char				read_buf[20];
-	unsigned int			read_buf_len;
-#endif
 };
 
 const struct iio_chan_spec
@@ -701,10 +693,7 @@ static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
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

