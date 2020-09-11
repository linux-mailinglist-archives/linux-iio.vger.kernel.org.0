Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8B2664A1
	for <lists+linux-iio@lfdr.de>; Fri, 11 Sep 2020 18:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgIKQnF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Sep 2020 12:43:05 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32606 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbgIKPJd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Sep 2020 11:09:33 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BDOenQ011180;
        Fri, 11 Sep 2020 09:25:21 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33fqxfubh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 09:25:21 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08BDPJvK017475
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 11 Sep 2020 09:25:20 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 11 Sep
 2020 06:25:18 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 11 Sep 2020 06:25:18 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08BDPFso012530;
        Fri, 11 Sep 2020 09:25:15 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [RFC PATCH v3] iio: core: Add optional symbolic label to a device channel
Date:   Fri, 11 Sep 2020 16:25:22 +0300
Message-ID: <20200911132522.22969-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_04:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 suspectscore=2 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110108
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined in the device tree for this channel add that
to the channel specific attributes. This is useful for userspace to
be able to identify an individual channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 Changes in V3:
	- Add "read_label" callback function

 drivers/iio/industrialio-core.c | 159 +++++++++++++++++++++++++-------
 include/linux/iio/iio.h         |  40 +++++++-
 2 files changed, 160 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1527f01a44f1..9398c0174820 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1,8 +1,11 @@
-// SPDX-License-Identifier: GPL-2.0-only
 /* The industrial I/O core
  *
  * Copyright (c) 2008 Jonathan Cameron
  *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
  * Based on elements of hwmon and input subsystems.
  */
 
@@ -85,7 +88,8 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_GRAVITY]  = "gravity",
 	[IIO_POSITIONRELATIVE]  = "positionrelative",
 	[IIO_PHASE] = "phase",
-	[IIO_MASSCONCENTRATION] = "massconcentration",
+	[IIO_GENERIC_DATA] = "data",
+	[IIO_FLAGS] = "flags",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -126,10 +130,6 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_Q] = "q",
 	[IIO_MOD_CO2] = "co2",
 	[IIO_MOD_VOC] = "voc",
-	[IIO_MOD_PM1] = "pm1",
-	[IIO_MOD_PM2P5] = "pm2p5",
-	[IIO_MOD_PM4] = "pm4",
-	[IIO_MOD_PM10] = "pm10",
 };
 
 /* relies on pairs of these shared then separate */
@@ -140,6 +140,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_OFFSET] = "offset",
 	[IIO_CHAN_INFO_CALIBSCALE] = "calibscale",
 	[IIO_CHAN_INFO_CALIBBIAS] = "calibbias",
+	[IIO_CHAN_INFO_CALIBPHASE] = "calibphase",
 	[IIO_CHAN_INFO_PEAK] = "peak_raw",
 	[IIO_CHAN_INFO_PEAK_SCALE] = "peak_scale",
 	[IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW] = "quadrature_correction_raw",
@@ -161,7 +162,6 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
-	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
 };
 
 /**
@@ -189,12 +189,7 @@ ssize_t iio_read_const_attr(struct device *dev,
 }
 EXPORT_SYMBOL(iio_read_const_attr);
 
-/**
- * iio_device_set_clock() - Set current timestamping clock for the device
- * @indio_dev: IIO device structure containing the device
- * @clock_id: timestamping clock posix identifier to set.
- */
-int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
+static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
 {
 	int ret;
 	const struct iio_event_interface *ev_int = indio_dev->event_interface;
@@ -212,7 +207,6 @@ int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
 
 	return 0;
 }
-EXPORT_SYMBOL(iio_device_set_clock);
 
 /**
  * iio_get_time_ns() - utility function to get a time stamp for events etc
@@ -235,9 +229,9 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 		ktime_get_coarse_ts64(&tp);
 		return timespec64_to_ns(&tp);
 	case CLOCK_BOOTTIME:
-		return ktime_get_boottime_ns();
+		return ktime_get_boot_ns();
 	case CLOCK_TAI:
-		return ktime_get_clocktai_ns();
+		return ktime_get_tai_ns();
 	default:
 		BUG();
 	}
@@ -444,8 +438,10 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
 	if (!e->num_items)
 		return 0;
 
-	for (i = 0; i < e->num_items; ++i)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
+	for (i = 0; i < e->num_items; ++i) {
+		if (e->items[i])
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
+	}
 
 	/* replace last space with a newline */
 	buf[len - 1] = '\n';
@@ -466,7 +462,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
 	i = e->get(indio_dev, chan);
 	if (i < 0)
 		return i;
-	else if (i >= e->num_items)
+	else if (i >= e->num_items || !e->items[i])
 		return -EINVAL;
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", e->items[i]);
@@ -478,16 +474,21 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 	size_t len)
 {
 	const struct iio_enum *e = (const struct iio_enum *)priv;
+	unsigned int i;
 	int ret;
 
 	if (!e->set)
 		return -EINVAL;
 
-	ret = __sysfs_match_string(e->items, e->num_items, buf);
-	if (ret < 0)
-		return ret;
+	for (i = 0; i < e->num_items; i++) {
+		if (e->items[i] && sysfs_streq(buf, e->items[i]))
+			break;
+	}
 
-	ret = e->set(indio_dev, chan, ret);
+	if (i == e->num_items)
+		return -EINVAL;
+
+	ret = e->set(indio_dev, chan, i);
 	return ret ? ret : len;
 }
 EXPORT_SYMBOL_GPL(iio_enum_write);
@@ -643,6 +644,21 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 }
 EXPORT_SYMBOL_GPL(iio_format_value);
 
+static ssize_t iio_read_channel_label(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	if (indio_dev->info->read_label)
+		return indio_dev->info->read_label(indio_dev,
+							this_attr->c,
+							buf);
+	else
+		return -EINVAL;
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -1111,6 +1127,25 @@ int __iio_add_chan_devattr(const char *postfix,
 	return ret;
 }
 
+static int iio_device_add_channel_label(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan)
+{
+	int ret;
+
+	ret = __iio_add_chan_devattr("label",
+					chan,
+					&iio_read_channel_label,
+					NULL,
+					0,
+					IIO_SEPARATE,
+					&indio_dev->dev,
+					&indio_dev->channel_attr_list);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					 struct iio_chan_spec const *chan,
 					 enum iio_shared_by shared_by,
@@ -1241,6 +1276,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	ret = iio_device_add_channel_label(indio_dev, chan);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
@@ -1616,6 +1656,8 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
 	struct iio_dev *indio_dev = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
 	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
+	if (indio_dev->buffer)
+		iio_buffer_free_blocks(indio_dev->buffer);
 	iio_device_put(indio_dev);
 
 	return 0;
@@ -1632,18 +1674,31 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (!indio_dev->info)
 		return -ENODEV;
 
-	if (cmd == IIO_GET_EVENT_FD_IOCTL) {
+	switch (cmd) {
+	case IIO_GET_EVENT_FD_IOCTL:
 		fd = iio_event_getfd(indio_dev);
 		if (fd < 0)
 			return fd;
 		if (copy_to_user(ip, &fd, sizeof(fd)))
 			return -EFAULT;
 		return 0;
+	default:
+		if (indio_dev->buffer)
+			return iio_buffer_ioctl(indio_dev, filp, cmd, arg);
 	}
 	return -EINVAL;
 }
 
-static const struct file_operations iio_buffer_fileops = {
+static const struct file_operations iio_buffer_none_fileops = {
+	.release = iio_chrdev_release,
+	.open = iio_chrdev_open,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.unlocked_ioctl = iio_ioctl,
+	.compat_ioctl = iio_ioctl,
+};
+
+static const struct file_operations iio_buffer_in_fileops = {
 	.read = iio_buffer_read_outer_addr,
 	.release = iio_chrdev_release,
 	.open = iio_chrdev_open,
@@ -1651,9 +1706,20 @@ static const struct file_operations iio_buffer_fileops = {
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
 	.unlocked_ioctl = iio_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
+	.compat_ioctl = iio_ioctl,
+	.mmap = iio_buffer_mmap,
 };
 
+static bool iio_chan_same_size(const struct iio_chan_spec *a,
+	const struct iio_chan_spec *b)
+{
+	if (a->scan_type.storagebits != b->scan_type.storagebits)
+		return false;
+	if (a->scan_type.repeat != b->scan_type.repeat)
+		return false;
+	return true;
+}
+
 static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 {
 	int i, j;
@@ -1665,13 +1731,16 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 	for (i = 0; i < indio_dev->num_channels - 1; i++) {
 		if (channels[i].scan_index < 0)
 			continue;
-		for (j = i + 1; j < indio_dev->num_channels; j++)
-			if (channels[i].scan_index == channels[j].scan_index) {
-				dev_err(&indio_dev->dev,
-					"Duplicate scan index %d\n",
-					channels[i].scan_index);
-				return -EINVAL;
-			}
+		for (j = i + 1; j < indio_dev->num_channels; j++) {
+			if (channels[i].scan_index != channels[j].scan_index)
+				continue;
+			if (iio_chan_same_size(&channels[i], &channels[j]))
+				continue;
+			dev_err(&indio_dev->dev,
+				"Duplicate scan index %d\n",
+				channels[i].scan_index);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -1679,8 +1748,21 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
+static const struct file_operations iio_buffer_out_fileops = {
+	.write = iio_buffer_chrdev_write,
+	.release = iio_chrdev_release,
+	.open = iio_chrdev_open,
+	.poll = iio_buffer_poll_addr,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.unlocked_ioctl = iio_ioctl,
+	.compat_ioctl = iio_ioctl,
+	.mmap = iio_buffer_mmap,
+};
+
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
+	const struct file_operations *fops;
 	int ret;
 
 	if (!indio_dev->info)
@@ -1729,7 +1811,16 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 		indio_dev->setup_ops == NULL)
 		indio_dev->setup_ops = &noop_ring_setup_ops;
 
-	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
+	if (indio_dev->buffer) {
+		if (indio_dev->direction == IIO_DEVICE_DIRECTION_IN)
+			fops = &iio_buffer_in_fileops;
+		else
+			fops = &iio_buffer_out_fileops;
+	} else {
+		fops = &iio_buffer_none_fileops;
+	}
+
+	cdev_init(&indio_dev->chrdev, fops);
 
 	indio_dev->chrdev.owner = this_mod;
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a1be82e74c93..ff0778577e57 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -1,8 +1,11 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
 
 /* The industrial I/O core
  *
  * Copyright (c) 2008 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 #ifndef _INDUSTRIAL_IO_H_
 #define _INDUSTRIAL_IO_H_
@@ -116,6 +119,23 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 	.private = (uintptr_t)(_e), \
 }
 
+/**
+ * IIO_ENUM_AVAILABLE_SHARED() - Initialize enum available extended channel attribute
+ * @_name:	Attribute name ("_available" will be appended to the name)
+ * @_shared:	Whether the attribute is shared between all channels
+ * @_e:		Pointer to an iio_enum struct
+ *
+ * Creates a read only attribute which lists all the available enum items in a
+ * space separated list. This should usually be used together with IIO_ENUM()
+ */
+#define IIO_ENUM_AVAILABLE_SHARED(_name, _shared, _e) \
+{ \
+	.name = (_name "_available"), \
+	.shared = _shared, \
+	.read = iio_enum_available_read, \
+	.private = (uintptr_t)(_e), \
+}
+
 /**
  * struct iio_mount_matrix - iio mounting matrix
  * @rotation: 3 dimensional space rotation matrix defining sensor alignment with
@@ -315,6 +335,11 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
 s64 iio_get_time_ns(const struct iio_dev *indio_dev);
 unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
 
+enum iio_device_direction {
+	IIO_DEVICE_DIRECTION_IN,
+	IIO_DEVICE_DIRECTION_OUT,
+};
+
 /* Device operating modes */
 #define INDIO_DIRECT_MODE		0x01
 #define INDIO_BUFFER_TRIGGERED		0x02
@@ -362,6 +387,8 @@ struct iio_trigger; /* forward declaration */
  *			and max. For lists, all possible values are enumerated.
  * @write_raw:		function to write a value to the device.
  *			Parameters are the same as for read_raw.
+ * @read_label:		function to request label name for a specified label,
+ *			for better channel identification.
  * @write_raw_get_fmt:	callback function to query the expected
  *			format/precision. If not set by the driver, write_raw
  *			returns IIO_VAL_INT_PLUS_MICRO.
@@ -420,6 +447,10 @@ struct iio_info {
 			 int val2,
 			 long mask);
 
+	int (*read_label)(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 char *label);
+
 	int (*write_raw_get_fmt)(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan,
 			 long mask);
@@ -492,7 +523,7 @@ struct iio_buffer_setup_ops {
  * @buffer:		[DRIVER] any buffer present
  * @buffer_list:	[INTERN] list of all buffers currently attached
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
- * @mlock:		[INTERN] lock used to prevent simultaneous device state
+ * @mlock:		[DRIVER] lock used to prevent simultaneous device state
  *			changes
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
  * @masklength:		[INTERN] the length of the mask established from
@@ -533,6 +564,7 @@ struct iio_dev {
 
 	struct iio_event_interface	*event_interface;
 
+	enum iio_device_direction	direction;
 	struct iio_buffer		*buffer;
 	struct list_head		buffer_list;
 	int				scan_bytes;
@@ -597,7 +629,7 @@ void iio_device_unregister(struct iio_dev *indio_dev);
  * 0 on success, negative error number on failure.
  */
 #define devm_iio_device_register(dev, indio_dev) \
-	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE)
+	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
@@ -625,8 +657,6 @@ static inline clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
 	return indio_dev->clock_id;
 }
 
-int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id);
-
 /**
  * dev_to_iio_dev() - Get IIO device struct from a device struct
  * @dev: 		The device embedded in the IIO device
-- 
2.17.1

