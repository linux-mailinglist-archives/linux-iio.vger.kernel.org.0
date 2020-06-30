Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292F120ED03
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 06:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgF3EzE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 00:55:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40912 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729599AbgF3Ey4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 00:54:56 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U4qant000352;
        Tue, 30 Jun 2020 00:54:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 31x315fr9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 00:54:39 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U4sdCs003591;
        Tue, 30 Jun 2020 00:54:39 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31x315fr9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 00:54:39 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05U4scFG023150
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 30 Jun 2020 00:54:38 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 30 Jun 2020 00:54:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 30 Jun 2020 00:54:36 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 30 Jun 2020 00:54:36 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05U4sPIo018305;
        Tue, 30 Jun 2020 00:54:33 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 5/7] iio: core: move channel list & group to private iio device object
Date:   Tue, 30 Jun 2020 07:57:06 +0300
Message-ID: <20200630045708.14166-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630045708.14166-1-alexandru.ardelean@analog.com>
References: <20200630045708.14166-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=2
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300035
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change bit straightforward and simple, since the
'channel_attr_list' & 'chan_attr_group' fields are only used in
'industrialio-core.c'.

This change moves to the private IIO device object

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 46 +++++++++++++++++++--------------
 include/linux/iio/iio-opaque.h  |  5 ++++
 include/linux/iio/iio.h         |  5 ----
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 64174052641a..21fbb187ee79 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1137,6 +1137,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					 enum iio_shared_by shared_by,
 					 const long *infomask)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int i, ret, attrcount = 0;
 
 	for_each_set_bit(i, infomask, sizeof(*infomask)*8) {
@@ -1149,7 +1150,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					     i,
 					     shared_by,
 					     &indio_dev->dev,
-					     &indio_dev->channel_attr_list);
+					     &iio_dev_opaque->channel_attr_list);
 		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
 			continue;
 		else if (ret < 0)
@@ -1165,6 +1166,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
 					       enum iio_shared_by shared_by,
 					       const long *infomask)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int i, ret, attrcount = 0;
 	char *avail_postfix;
 
@@ -1184,7 +1186,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
 					     i,
 					     shared_by,
 					     &indio_dev->dev,
-					     &indio_dev->channel_attr_list);
+					     &iio_dev_opaque->channel_attr_list);
 		kfree(avail_postfix);
 		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
 			continue;
@@ -1199,6 +1201,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
 static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					struct iio_chan_spec const *chan)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int ret, attrcount = 0;
 	const struct iio_chan_spec_ext_info *ext_info;
 
@@ -1274,7 +1277,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					i,
 					ext_info->shared,
 					&indio_dev->dev,
-					&indio_dev->channel_attr_list);
+					&iio_dev_opaque->channel_attr_list);
 			i++;
 			if (ret == -EBUSY && ext_info->shared)
 				continue;
@@ -1409,6 +1412,7 @@ static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
 
 static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int i, ret = 0, attrcount, attrn, attrcount_orig = 0;
 	struct iio_dev_attr *p;
 	struct attribute **attr, *clk = NULL;
@@ -1448,47 +1452,49 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 	if (clk)
 		attrcount++;
 
-	indio_dev->chan_attr_group.attrs = kcalloc(attrcount + 1,
-						   sizeof(indio_dev->chan_attr_group.attrs[0]),
-						   GFP_KERNEL);
-	if (indio_dev->chan_attr_group.attrs == NULL) {
+	iio_dev_opaque->chan_attr_group.attrs =
+		kcalloc(attrcount + 1,
+			sizeof(iio_dev_opaque->chan_attr_group.attrs[0]),
+			GFP_KERNEL);
+	if (iio_dev_opaque->chan_attr_group.attrs == NULL) {
 		ret = -ENOMEM;
 		goto error_clear_attrs;
 	}
 	/* Copy across original attributes */
 	if (indio_dev->info->attrs)
-		memcpy(indio_dev->chan_attr_group.attrs,
+		memcpy(iio_dev_opaque->chan_attr_group.attrs,
 		       indio_dev->info->attrs->attrs,
-		       sizeof(indio_dev->chan_attr_group.attrs[0])
+		       sizeof(iio_dev_opaque->chan_attr_group.attrs[0])
 		       *attrcount_orig);
 	attrn = attrcount_orig;
 	/* Add all elements from the list. */
-	list_for_each_entry(p, &indio_dev->channel_attr_list, l)
-		indio_dev->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
+	list_for_each_entry(p, &iio_dev_opaque->channel_attr_list, l)
+		iio_dev_opaque->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
 	if (indio_dev->name)
-		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
+		iio_dev_opaque->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
 	if (indio_dev->label)
-		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_label.attr;
+		iio_dev_opaque->chan_attr_group.attrs[attrn++] = &dev_attr_label.attr;
 	if (clk)
-		indio_dev->chan_attr_group.attrs[attrn++] = clk;
+		iio_dev_opaque->chan_attr_group.attrs[attrn++] = clk;
 
 	indio_dev->groups[indio_dev->groupcounter++] =
-		&indio_dev->chan_attr_group;
+		&iio_dev_opaque->chan_attr_group;
 
 	return 0;
 
 error_clear_attrs:
-	iio_free_chan_devattr_list(&indio_dev->channel_attr_list);
+	iio_free_chan_devattr_list(&iio_dev_opaque->channel_attr_list);
 
 	return ret;
 }
 
 static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
-	iio_free_chan_devattr_list(&indio_dev->channel_attr_list);
-	kfree(indio_dev->chan_attr_group.attrs);
-	indio_dev->chan_attr_group.attrs = NULL;
+	iio_free_chan_devattr_list(&iio_dev_opaque->channel_attr_list);
+	kfree(iio_dev_opaque->chan_attr_group.attrs);
+	iio_dev_opaque->chan_attr_group.attrs = NULL;
 }
 
 static void iio_dev_release(struct device *device)
@@ -1543,7 +1549,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	dev_set_drvdata(&dev->dev, (void *)dev);
 	mutex_init(&dev->mlock);
 	mutex_init(&dev->info_exist_lock);
-	INIT_LIST_HEAD(&dev->channel_attr_list);
+	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
 
 	dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
 	if (dev->id < 0) {
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index b3f234b4c1e9..9419a05c698d 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -6,6 +6,9 @@
 /**
  * struct iio_dev_opaque - industrial I/O device opaque information
  * @indio_dev:			public industrial I/O device information
+ * @channel_attr_list:		keep track of automatically created channel
+ *				attributes
+ * @chan_attr_group:		group for all attrs in base directory
  * @debugfs_dentry:		device specific debugfs dentry
  * @cached_reg_addr:		cached register address for debugfs reads
  * @read_buf:			read buffer to be used for the initial reg read
@@ -13,6 +16,8 @@
  */
 struct iio_dev_opaque {
 	struct iio_dev			indio_dev;
+	struct list_head		channel_attr_list;
+	struct attribute_group		chan_attr_group;
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
 	unsigned			cached_reg_addr;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index bb0aae11a111..30e6fc1506ea 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -506,9 +506,6 @@ struct iio_buffer_setup_ops {
  * @pollfunc_event:	[DRIVER] function run on events trigger being received
  * @channels:		[DRIVER] channel specification structure table
  * @num_channels:	[DRIVER] number of channels specified in @channels.
- * @channel_attr_list:	[INTERN] keep track of automatically created channel
- *			attributes
- * @chan_attr_group:	[INTERN] group for all attrs in base directory
  * @name:		[DRIVER] name of the device.
  * @label:              [DRIVER] unique name to identify which device this is
  * @info:		[DRIVER] callbacks and constant info from driver
@@ -551,8 +548,6 @@ struct iio_dev {
 	struct iio_chan_spec const	*channels;
 	int				num_channels;
 
-	struct list_head		channel_attr_list;
-	struct attribute_group		chan_attr_group;
 	const char			*name;
 	const char			*label;
 	const struct iio_info		*info;
-- 
2.17.1

