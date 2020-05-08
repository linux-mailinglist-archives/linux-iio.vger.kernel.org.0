Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE921CB127
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 15:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgEHNzI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 09:55:08 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42472 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbgEHNyO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 09:54:14 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048Dr3v9016945;
        Fri, 8 May 2020 09:54:03 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtek2gcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:54:02 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 048Ds1Cv040822
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 09:54:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 8 May 2020
 09:54:00 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 09:54:00 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048Drpwp030263;
        Fri, 8 May 2020 09:53:58 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 05/14] iio: core: register chardev only if needed
Date:   Fri, 8 May 2020 16:53:39 +0300
Message-ID: <20200508135348.15229-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508135348.15229-1-alexandru.ardelean@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=2 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The final intent is to localize all buffer ops into the
industrialio-buffer.c file, to be able to add support for multiple buffers
per IIO device.

We only need a chardev if we need to support buffers and/or events.

With this change, a chardev will be created only if an IIO buffer is
attached OR an event_interface is configured.

Otherwise, no chardev will be created, and the IIO device will get
registered with the 'device_add()' call.

Quite a lot of IIO devices don't really need a chardev, so this is a minor
improvement to the IIO core, as the IIO device will take up (slightly)
fewer resources.

What's important to remember, is that removing a chardev also requires that
'indio_dev->dev.devt' to be initialized. If it is, a '/dev/iio:deviceX'
file will be created by the kernel, regardless of whether it has a chardev
attached to it or not.
If that field is not initialized, cdev_device_{add,del}() behave{s} like
device_{add,del}().

Also, since we plan to add more chardevs for IIO buffers, we need to
consider now a separate IDA object just for chardevs.
Currently, the only benefit is that chardev IDs will be continuous.
However, when adding a chardev per IIO buffer, the IDs for the chardev
could outpace the IDs for IIO devices, so these should be decoupled.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 58 +++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 32c489139cd2..d74279efeca4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -35,6 +35,9 @@
 /* IDA to assign each registered device a unique id */
 static DEFINE_IDA(iio_ida);
 
+/* IDA to assign each registered character device a unique id */
+static DEFINE_IDA(iio_chrdev_ida);
+
 static dev_t iio_devt;
 
 #define IIO_DEV_MAX 256
@@ -1680,8 +1683,40 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int iio_device_alloc_chrdev_id(struct device *dev)
+{
+	int id;
+
+	id = ida_simple_get(&iio_chrdev_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		/* cannot use a dev_err as the name isn't available */
+		dev_err(dev, "failed to get device id\n");
+		return id;
+	}
+
+	dev->devt = MKDEV(MAJOR(iio_devt), id);
+
+	return 0;
+}
+
+static void iio_device_free_chrdev_id(struct device *dev)
+{
+	if (!dev->devt)
+		return;
+	ida_simple_remove(&iio_chrdev_ida, MINOR(dev->devt));
+}
+
 static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
+static const struct file_operations iio_event_fileops = {
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.unlocked_ioctl = iio_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.open = iio_chrdev_open,
+	.release = iio_chrdev_release,
+};
+
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
 	int ret;
@@ -1701,9 +1736,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (ret < 0)
 		return ret;
 
-	/* configure elements for the chrdev */
-	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
-
 	iio_device_register_debugfs(indio_dev);
 
 	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
@@ -1732,16 +1764,27 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 		indio_dev->setup_ops == NULL)
 		indio_dev->setup_ops = &noop_ring_setup_ops;
 
-	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
+	if (indio_dev->buffer)
+		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
+	else if (indio_dev->event_interface)
+		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
 
-	indio_dev->chrdev.owner = this_mod;
+	if (indio_dev->buffer || indio_dev->event_interface) {
+		indio_dev->chrdev.owner = this_mod;
+
+		ret = iio_device_alloc_chrdev_id(&indio_dev->dev);
+		if (ret)
+			goto error_unreg_eventset;
+	}
 
 	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
-	if (ret < 0)
-		goto error_unreg_eventset;
+	if (ret)
+		goto error_free_chrdev_id;
 
 	return 0;
 
+error_free_chrdev_id:
+	iio_device_free_chrdev_id(&indio_dev->dev);
 error_unreg_eventset:
 	iio_device_unregister_eventset(indio_dev);
 error_free_sysfs:
@@ -1761,6 +1804,7 @@ EXPORT_SYMBOL(__iio_device_register);
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
 	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
+	iio_device_free_chrdev_id(&indio_dev->dev);
 
 	mutex_lock(&indio_dev->info_exist_lock);
 
-- 
2.17.1

