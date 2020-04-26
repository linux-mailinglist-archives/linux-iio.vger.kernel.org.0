Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541E01B8D80
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 09:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgDZHiW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 03:38:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2892 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgDZHiV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 03:38:21 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03Q7aLGX015585;
        Sun, 26 Apr 2020 03:38:03 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mn4j2724-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Apr 2020 03:38:03 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03Q7c28W028380
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 26 Apr 2020 03:38:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Sun, 26 Apr
 2020 03:38:01 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 26 Apr 2020 03:38:01 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03Q7bqdx011885;
        Sun, 26 Apr 2020 03:37:59 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>, <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v5 5/6] iio: core: add simple centralized mechanism for ioctl() handlers
Date:   Sun, 26 Apr 2020 10:38:16 +0300
Message-ID: <20200426073817.33307-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426073817.33307-1-alexandru.ardelean@analog.com>
References: <20200426073817.33307-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-25_14:2020-04-24,2020-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004260070
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
index aec585cc8453..79e8fa8ff70b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1531,6 +1531,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 	}
 	dev_set_name(&dev->dev, "iio:device%d", dev->id);
 	INIT_LIST_HEAD(&dev->buffer_list);
+	INIT_LIST_HEAD(&dev->ioctl_handlers);
 
 	return dev;
 }
@@ -1584,6 +1585,33 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
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
@@ -1695,6 +1723,8 @@ EXPORT_SYMBOL(__iio_device_register);
  **/
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
+	struct iio_ioctl_handler *h, *t;
+
 	if (indio_dev->chrdev)
 		cdev_device_del(indio_dev->chrdev, &indio_dev->dev);
 	else
@@ -1708,6 +1738,9 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
 	iio_disable_all_buffers(indio_dev);
 
+	list_for_each_entry_safe(h, t, &indio_dev->ioctl_handlers, entry)
+		list_del(&h->entry);
+
 	indio_dev->info = NULL;
 
 	iio_device_wakeup_eventset(indio_dev);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 52992be44e9e..b6ca8d85629e 100644
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

