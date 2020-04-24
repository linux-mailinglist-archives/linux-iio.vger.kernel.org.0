Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A01B6CE0
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 06:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDXE4r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 00:56:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42530 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbgDXE4q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 00:56:46 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O4qti4023387;
        Fri, 24 Apr 2020 00:56:32 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf6csgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 00:56:32 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03O4uU7N047688
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 24 Apr 2020 00:56:31 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 21:56:29 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Apr 2020 21:56:25 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 23 Apr 2020 21:56:29 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03O4uGpp017534;
        Fri, 24 Apr 2020 00:56:26 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v4 6/7] iio: core: add simple centralized mechanism for ioctl() handlers
Date:   Fri, 24 Apr 2020 07:56:41 +0300
Message-ID: <20200424045642.4903-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424045642.4903-1-alexandru.ardelean@analog.com>
References: <20200424045642.4903-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_01:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240035
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The aim of this is to reduce the organization violation of ioctl() calls in
IIO core. Currently, since the chardev is split across files, event ioctl()
calls need to be called in buffer ioctl() calls.

The 'industrialio-core.c' file will provide a 'iio_device_ioctl()' which
will iterate over a list of ioctls registered with the IIO device. These
can be event ioctl() or buffer ioctl() calls, or something else.
This is needed, since there is currently one chardev per IIO device and
that is used for both event handling and reading from the buffer.

Each ioctl() will have to return a IIO_IOCTL_UNHANDLED code (which is
positive 1), if the ioctl() did not handle the call in any. This eliminates
any potential ambiguities; if we were to have used error codes it would
have been uncertain whether they were actual errors, or whether
the registered ioctl() doesn't service the command.

If any ioctl() returns 0, it was considered that it was serviced
successfully and the loop will exit.

One assumption for all registered ioctl() handlers is that they are
statically allocated, so the iio_device_unregister() which just remove all
of them from the device's ioctl() handler list.

Also, something that is a bit hard to do [at this point] and may not be
worth the effort of doing, is to check whether registered ioctl()
calls/commands overlap. This should be unlikely to happen, and should get
caught at review time. Though, new ioctl() calls would likely not be added
too often.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h          | 14 ++++++++++++++
 drivers/iio/industrialio-core.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  2 ++
 3 files changed, 49 insertions(+)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index a527a66be9e5..34c3e19229d8 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -17,6 +17,20 @@ struct iio_dev;
 
 extern struct device_type iio_device_type;
 
+#define IIO_IOCTL_UNHANDLED	1
+struct iio_ioctl_handler {
+	struct list_head entry;
+	long (*ioctl)(struct iio_dev *indio_dev, struct file *filp,
+		      unsigned int cmd, unsigned long arg);
+};
+
+long iio_device_ioctl(struct iio_dev *indio_dev, struct file *filp,
+		      unsigned int cmd, unsigned long arg);
+
+void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
+				       struct iio_ioctl_handler *h);
+void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h);
+
 int __iio_add_chan_devattr(const char *postfix,
 			   struct iio_chan_spec const *chan,
 			   ssize_t (*func)(struct device *dev,
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 07b9aac9ffa5..af9d2686bb60 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1525,6 +1525,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 	mutex_init(&indio_dev->info_exist_lock);
 	INIT_LIST_HEAD(&indio_dev->channel_attr_list);
 	INIT_LIST_HEAD(&indio_dev->buffer_list);
+	INIT_LIST_HEAD(&indio_dev->ioctl_handlers);
 
 	return indio_dev;
 }
@@ -1578,6 +1579,33 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
 }
 EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
 
+void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
+				       struct iio_ioctl_handler *h)
+{
+	/* this assumes that all ioctl() handlers are statically allocated */
+	list_add_tail(&h->entry, &indio_dev->ioctl_handlers);
+}
+
+long iio_device_ioctl(struct iio_dev *indio_dev, struct file *filp,
+		      unsigned int cmd, unsigned long arg)
+{
+	struct iio_ioctl_handler *h;
+	int ret;
+
+	if (!indio_dev->info)
+		return -ENODEV;
+
+	list_for_each_entry(h, &indio_dev->ioctl_handlers, entry) {
+		ret = h->ioctl(indio_dev, filp, cmd, arg);
+		if (ret == 0)
+			return 0;
+		if (ret != IIO_IOCTL_UNHANDLED)
+			return ret;
+	}
+
+	return -EINVAL;
+}
+
 static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 {
 	int i, j;
@@ -1689,6 +1717,8 @@ EXPORT_SYMBOL(__iio_device_register);
  **/
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
+	struct iio_ioctl_handler *h, *t;
+
 	if (indio_dev->chrdev)
 		cdev_device_del(indio_dev->chrdev, &indio_dev->dev);
 	else
@@ -1702,6 +1732,9 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
 	iio_disable_all_buffers(indio_dev);
 
+	list_for_each_entry_safe(h, t, &indio_dev->ioctl_handlers, entry)
+		list_del(&h->entry);
+
 	indio_dev->info = NULL;
 
 	iio_device_wakeup_eventset(indio_dev);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 88b0f2100180..f0b63f4f3a8e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -488,6 +488,7 @@ struct iio_buffer_setup_ops {
  * @currentmode:	[DRIVER] current operating mode
  * @dev:		[DRIVER] device structure, should be assigned a parent
  *			and owner
+ * @ioctl_handlers:	[INTERN] list of registered ioctl handlers
  * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
  * @buffer:		[DRIVER] any buffer present
  * @buffer_list:	[INTERN] list of all buffers currently attached
@@ -529,6 +530,7 @@ struct iio_dev {
 	int				modes;
 	int				currentmode;
 	struct device			dev;
+	struct list_head		ioctl_handlers;
 
 	struct iio_event_interface	*event_interface;
 
-- 
2.17.1

