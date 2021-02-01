Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1B30AB33
	for <lists+linux-iio@lfdr.de>; Mon,  1 Feb 2021 16:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhBAP0G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Feb 2021 10:26:06 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53608 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhBAOt5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Feb 2021 09:49:57 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 111EljD3014655;
        Mon, 1 Feb 2021 09:48:44 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36dbucuqat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 09:48:44 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 111EmhB1030288
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Feb 2021 09:48:43 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 1 Feb 2021 09:48:42 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 1 Feb 2021 09:48:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Mon, 1 Feb 2021 09:48:42 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 111EmNuF027350;
        Mon, 1 Feb 2021 09:48:39 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 09/11] iio: core: wrap iio device & buffer into struct for character devices
Date:   Mon, 1 Feb 2021 16:51:03 +0200
Message-ID: <20210201145105.20459-10-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201145105.20459-1-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010079
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
 drivers/iio/iio_core.h            |  5 +++++
 drivers/iio/industrialio-buffer.c | 10 ++++++----
 drivers/iio/industrialio-core.c   | 18 ++++++++++++++++--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 731f5170d5b9..87868fff7d37 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -18,6 +18,11 @@ struct iio_dev;
 
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
index 49996bed5f4c..692f721588e2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -104,8 +104,9 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
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
@@ -170,8 +171,9 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
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
index c68130885d83..8af85838d1c2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1705,13 +1705,24 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
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
@@ -1725,10 +1736,12 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
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
@@ -1748,7 +1761,8 @@ void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h)
 
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

