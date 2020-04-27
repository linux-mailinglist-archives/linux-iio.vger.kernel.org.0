Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA21BA44C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgD0NLT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 09:11:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6076 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727874AbgD0NLJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 09:11:09 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RCsxp7016897;
        Mon, 27 Apr 2020 09:10:56 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mn4j7e5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 09:10:55 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03RDAsJK010883
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Apr 2020 09:10:54 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 27 Apr 2020 09:10:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 27 Apr 2020 09:10:53 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Apr 2020 09:10:53 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03RDAfUW011495;
        Mon, 27 Apr 2020 09:10:51 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v6 6/6] iio: core: use new common ioctl() mechanism
Date:   Mon, 27 Apr 2020 16:11:00 +0300
Message-ID: <20200427131100.50845-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427131100.50845-1-alexandru.ardelean@analog.com>
References: <20200427131100.50845-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_09:2020-04-24,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004270114
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change makes use of the new centralized ioctl() mechanism. The event
interface registers it's ioctl() handler to IIO device.
Both the buffer & event interface call 'iio_device_ioctl()', which should
take care of all of indio_dev's ioctl() calls.

Later, we may add per-buffer ioctl() calls, and since each buffer will get
it's own chardev, the buffer ioctl() handler will need a bit of tweaking
for the first/legacy buffer (i.e. indio_dev->buffer).
Also, those per-buffer ioctl() calls will not be registered with this
mechanism.

The move of the comment in this patch is intentional to show that [with
this patch], the 'indio_dev->info' NULL check is still around, but it just
got moved.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h            |  3 ---
 drivers/iio/industrialio-buffer.c |  2 +-
 drivers/iio/industrialio-core.c   |  5 +++++
 drivers/iio/industrialio-event.c  | 19 ++++++++-----------
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 34c3e19229d8..f68de4af2738 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -54,9 +54,6 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 #ifdef CONFIG_IIO_BUFFER
 struct poll_table_struct;
 
-long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
-			    unsigned int cmd, unsigned long arg);
-
 void iio_device_buffer_attach_chrdev(struct iio_dev *indio_dev);
 
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 0689c100b041..c5c5b7537e28 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1179,7 +1179,7 @@ static long iio_buffer_ioctl(struct file *filep, unsigned int cmd,
 	if (!buffer || !buffer->access)
 		return -ENODEV;
 
-	return iio_device_event_ioctl(buffer->indio_dev, filep, cmd, arg);
+	return iio_device_ioctl(buffer->indio_dev, filep, cmd, arg);
 }
 
 static ssize_t iio_buffer_store_enable(struct device *dev,
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 94e7f9541e81..24c294e45502 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1600,6 +1600,11 @@ long iio_device_ioctl(struct iio_dev *indio_dev, struct file *filp,
 
 	mutex_lock(&indio_dev->info_exist_lock);
 
+	/**
+	 * The NULL check here is required to prevent crashing when a device
+	 * is being removed while userspace would still have open file handles
+	 * to try to access this device.
+	 */
 	if (!indio_dev->info)
 		goto out_unlock;
 
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index d532a689c2eb..429f1d5f3c1d 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -32,6 +32,7 @@
  * @read_lock:		lock to protect kfifo read operations
  * @chrdev:		associated chardev for this event
  * @indio_dev:		IIO device to which this event interface belongs to
+ * @ioctl_handler:	handler for event ioctl() calls
  */
 struct iio_event_interface {
 	wait_queue_head_t	wait;
@@ -44,6 +45,7 @@ struct iio_event_interface {
 
 	struct cdev		chrdev;
 	struct iio_dev		*indio_dev;
+	struct iio_ioctl_handler	ioctl_handler;
 };
 
 bool iio_event_enabled(const struct iio_event_interface *ev_int)
@@ -261,20 +263,12 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
+static long iio_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
 			    unsigned int cmd, unsigned long arg)
 {
 	int __user *ip = (int __user *)arg;
 	int fd;
 
-	/**
-	 * The NULL check here is required to prevent crashing when a device
-	 * is being removed while userspace would still have open file handles
-	 * to try to access this device.
-	 */
-	if (!indio_dev->info)
-		return -ENODEV;
-
 	if (cmd == IIO_GET_EVENT_FD_IOCTL) {
 		fd = iio_event_getfd(indio_dev);
 		if (fd < 0)
@@ -283,7 +277,7 @@ long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
 			return -EFAULT;
 		return 0;
 	}
-	return -EINVAL;
+	return IIO_IOCTL_UNHANDLED;
 }
 
 static long iio_event_ioctl_wrapper(struct file *filp, unsigned int cmd,
@@ -291,7 +285,7 @@ static long iio_event_ioctl_wrapper(struct file *filp, unsigned int cmd,
 {
 	struct iio_event_interface *ev = filp->private_data;
 
-	return iio_device_event_ioctl(ev->indio_dev, filp, cmd, arg);
+	return iio_device_ioctl(ev->indio_dev, filp, cmd, arg);
 }
 
 static const struct file_operations iio_event_fileops = {
@@ -313,7 +307,10 @@ void iio_device_event_attach_chrdev(struct iio_dev *indio_dev)
 	cdev_init(&ev->chrdev, &iio_event_fileops);
 
 	ev->indio_dev = indio_dev;
+	ev->ioctl_handler.ioctl = iio_event_ioctl;
 	indio_dev->chrdev = &ev->chrdev;
+
+	iio_device_ioctl_handler_register(indio_dev, &ev->ioctl_handler);
 }
 
 static const char * const iio_ev_type_text[] = {
-- 
2.17.1

