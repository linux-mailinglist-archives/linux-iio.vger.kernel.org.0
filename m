Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126EE31B76F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 11:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBOKkR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 05:40:17 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63090 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhBOKkF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 05:40:05 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11FAZkTp028471;
        Mon, 15 Feb 2021 05:39:12 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjamak6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 05:39:12 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11FAdBKf008338
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Feb 2021 05:39:11 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 15 Feb 2021 05:39:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 15 Feb 2021 05:39:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Mon, 15 Feb 2021 05:39:10 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11FAcQUj017530;
        Mon, 15 Feb 2021 05:39:07 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 16/24] iio: core: wrap iio device & buffer into struct for character devices
Date:   Mon, 15 Feb 2021 12:40:35 +0200
Message-ID: <20210215104043.91251-17-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210215104043.91251-1-alexandru.ardelean@analog.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-15_03:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150087
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
index 8dc140f13b99..83ea15e330a4 100644
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
index 31596ae68664..1d500ea246af 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1703,13 +1703,24 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
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
@@ -1723,8 +1734,10 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
  */
 static int iio_chrdev_release(struct inode *inode, struct file *filp)
 {
+	struct iio_dev_buffer_pair *ib = filp->private_data;
 	struct iio_dev *indio_dev = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
+	kfree(ib);
 	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
 	iio_device_put(indio_dev);
 
@@ -1746,7 +1759,8 @@ void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h)
 
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

