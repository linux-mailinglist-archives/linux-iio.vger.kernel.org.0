Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB7C2B69DF
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgKQQTN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:19:13 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34540 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbgKQQTB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:19:01 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGImW5028499;
        Tue, 17 Nov 2020 11:18:49 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td199y80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 11:18:49 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AHGIh7C044684
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Nov 2020 11:18:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 17 Nov
 2020 11:18:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 17 Nov 2020 11:18:42 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AHGIRTW032565;
        Tue, 17 Nov 2020 11:18:40 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 10/12] iio: core: wrap iio device & buffer into struct for character devices
Date:   Tue, 17 Nov 2020 18:23:38 +0200
Message-ID: <20201117162340.43924-11-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117162340.43924-1-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_06:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170117
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In order to keep backwards compatibility with the current chardev
mechanism, and in order to add support for multiple buffers per IIO device,
we need to pass both the IIO device & IIO buffer to the chardev.

This is particularly needed for the iio_buffer_read_outer() function, where
we need to pass another buffer object than 'indio_dev->buffer'.

Since we'll also open some chardevs via anon inodes, we can pass extra
buffers in that function by assigning another object to the
iio_dev_buffer_pair object.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h            |  6 ++++++
 drivers/iio/industrialio-buffer.c | 10 ++++++----
 drivers/iio/industrialio-core.c   | 18 ++++++++++++++++--
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 43d44ec92781..ad6716fe1a93 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -12,11 +12,17 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 
+struct iio_buffer;
 struct iio_chan_spec;
 struct iio_dev;
 
 extern struct device_type iio_device_type;
 
+struct iio_dev_buffer_pair {
+	struct iio_dev		*indio_dev;
+	struct iio_buffer	*buffer;
+};
+
 #define IIO_IOCTL_UNHANDLED	1
 struct iio_ioctl_handler {
 	struct list_head entry;
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 6307ea84bbc7..c83cec89eddf 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -112,8 +112,9 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
 ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
 			      size_t n, loff_t *f_ps)
 {
-	struct iio_dev *indio_dev = filp->private_data;
-	struct iio_buffer *rb = indio_dev->buffer;
+	struct iio_dev_buffer_pair *ib = filp->private_data;
+	struct iio_buffer *rb = ib->buffer;
+	struct iio_dev *indio_dev = ib->indio_dev;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	size_t datum_size;
 	size_t to_wait;
@@ -178,8 +179,9 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
 __poll_t iio_buffer_poll(struct file *filp,
 			     struct poll_table_struct *wait)
 {
-	struct iio_dev *indio_dev = filp->private_data;
-	struct iio_buffer *rb = indio_dev->buffer;
+	struct iio_dev_buffer_pair *ib = filp->private_data;
+	struct iio_buffer *rb = ib->buffer;
+	struct iio_dev *indio_dev = ib->indio_dev;
 
 	if (!indio_dev->info || rb == NULL)
 		return 0;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 28830e87e8cb..9e7a76723f00 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1668,13 +1668,24 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
 {
 	struct iio_dev *indio_dev = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
+	struct iio_dev_buffer_pair *ib;
 
 	if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
 		return -EBUSY;
 
 	iio_device_get(indio_dev);
 
-	filp->private_data = indio_dev;
+	ib = kmalloc(sizeof(*ib), GFP_KERNEL);
+	if (!ib) {
+		iio_device_put(indio_dev);
+		clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
+		return -ENOMEM;
+	}
+
+	ib->indio_dev = indio_dev;
+	ib->buffer = indio_dev->buffer;
+
+	filp->private_data = ib;
 
 	return 0;
 }
@@ -1688,10 +1699,12 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
  */
 static int iio_chrdev_release(struct inode *inode, struct file *filp)
 {
+	struct iio_dev_buffer_pair *ib = filp->private_data;
 	struct iio_dev *indio_dev = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
 	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
 	iio_device_put(indio_dev);
+	kfree(ib);
 
 	return 0;
 }
@@ -1711,7 +1724,8 @@ void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h)
 
 static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	struct iio_dev *indio_dev = filp->private_data;
+	struct iio_dev_buffer_pair *ib = filp->private_data;
+	struct iio_dev *indio_dev = ib->indio_dev;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_ioctl_handler *h;
 	int ret = -ENODEV;
-- 
2.17.1

