Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207E9197F26
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 16:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgC3O5Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 10:57:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50566 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgC3O5Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 10:57:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id t128so1851539wma.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2020 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjmPpCB11wrk+3bv1nFxoxIHs3YfgEh7NOb0adM1ejk=;
        b=qUrjRVQNP+64rojBIiYgStzfF3rwSaubPicVnRVMotW7NQlBdEzWdsirVPh/kw0R+X
         bhrr6JYCJGq/63FnDhoO5bttgfo1Yx4UEm1Io6FtdTJ6ZH44r1ifLj3au4b0Tvfm57pg
         4d7efCVDk/WiR1GUbUdEYtrI3PkAEfAFQDhXNJKujfwDPZgqsuR5gnPc7kOu/Ncv3bdN
         qwtsiHzmUyFTzfG7eP/ZH8K7i8K2AV/52DXBFmQAF4rC/38068vNnlPMbzBRfAHVQHGH
         lucZiIgIGRm5EDzVBDWSjQtWG63FS98jAQ/kyUocqnMZybZv1l0hX3MAifDLWNmK9q84
         r8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjmPpCB11wrk+3bv1nFxoxIHs3YfgEh7NOb0adM1ejk=;
        b=o7UNaAbahKqT2lgsWMh6K2ATU3boq6NJmJnnFWTUtxABj4FjtZXAxPltPUqPnsAjnz
         OyqPS78OSF0pONNRpMFBaRpVmF0dBs3elG6BoY4ncRjurHaEoWmGh1v+eZsbfLqsL1/x
         it1UT5cVkpgwlrHXmnPFjBrAP38gtSv07TwKYqrj0e7Oi1cOnZWBFYAdnlU1guK57FJ0
         XYrn0GZeY13iMkAKtS9iN9z5Tponk8h5UuUHjTmloWS177i1OOHvAaStoXjlPMnCNF3D
         sdwMs4eRnrxvh3k+qg97rzXjEPHRLBGZnodz1DvKBk45Cfn17scoBXmJeF1pETapQlT3
         qqSA==
X-Gm-Message-State: ANhLgQ1tblMOXLonPKZ2M773adDvdySEME9y5LYUnQejuEqPpQ+ndkfX
        d7zBJgFFWl7P6FspP7VBb3bWzyao
X-Google-Smtp-Source: ADFU+vtuU8HpmtcTr5xgvUbQOouCnVq6k/sti/9NU+PWO39HjosD9zIOazc7jO55EtHvvplJngQ2Bg==
X-Received: by 2002:a1c:4d16:: with SMTP id o22mr14170029wmh.56.1585580231749;
        Mon, 30 Mar 2020 07:57:11 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id y200sm21584944wmc.20.2020.03.30.07.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:57:11 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
        lars@metafoo.de, dragos.bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 3/3] iio: buffer: add output buffer support for chrdev
Date:   Mon, 30 Mar 2020 17:57:05 +0300
Message-Id: <20200330145705.29447-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330145705.29447-1-alexandru.ardelean@analog.com>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is WIP.
It hasn't been tested yet. Mostly serves as base for some discussion.

There have been some offline discussions about how to go about this.
Since I wasn't involved in any of those discussions, this kind of tries to
re-build things from various bits.

1. First approach is: we keep 1 buffer per device, and we make it either
in/out, which means that for devices that for devices that have both in/out
2 iio_dev instances are required, or an ADC needs to be connected on the in
path and a DAC on out-path. This is predominantly done in the ADI tree.

2. One discussion/proposal was to have multiple buffers per-device. But the
details are vague since they were relayed to me.
One detail was, to have indexes for devices that have more than 1
buffer:

Iio_deviceX:
        buffer
        scan_elements

Iio_deviceX:
        BufferY
        scan_elementsY
        BufferZ
        scan_elementsZ

I am not sure how feasible this is for a single chrdev, as when you look at
the fileops that get assigned to a chrdev, it looks like it can have at
most two buffers (one for input, out for output).

Multiplexing input buffers can work (from ADCs), but demultiplexing output
buffers into a DAC, not so well. Especially on a single chrdev.

Question 1: do we want to support more than 2 buffers per chrdev?

This is what ADI currently has in it's tree (and works).

Example, ADC:
 # ls iio\:device3/buffer/
 data_available  enable  length  length_align_bytes  watermark
 #  ls iio\:device3/scan_elements/
 in_voltage0_en  in_voltage0_index  in_voltage0_type  in_voltage1_en  in_voltage1_index  in_voltage1_type

Example, DAC:
 #  ls iio\:device4/buffer/
 data_available  enable  length  length_align_bytes  watermark
 # ls iio\:device4/scan_elements/
 out_voltage0_en     out_voltage0_type  out_voltage1_index  out_voltage2_en     out_voltage2_type  out_voltage3_index
 out_voltage0_index  out_voltage1_en    out_voltage1_type   out_voltage2_index  out_voltage3_en    out_voltage3_type

The direction of each element is encoded into the filename of each channel.

Another question is:
 Does it make sense to have more than 1 'scan_elements' folder?
 That is, for devices that would have both in & out channels.

For 'buffer' folders I was thinking that it may make sense to have,
'buffer_in' && 'buffer_out'.

So, one idea is:

Iio_deviceX:
        buffer_in
        buffer_out
        scan_elements

Currently, this patch kind of implements 2 buffers per iio_dev/chrdev.
But the format is:

Iio_deviceX:
        buffer_in
        buffer_out
        scan_elements_in
        scan_elements_out

Obviously it shouldn't work as-is [as it wasn't tested], but at least gives
some glimpse of where this could go.

3. A side question is about the 'iio_buffer -> pollq' field. I was
wondering if it would make sense to move that on to 'iio_dev  pollq' if
adding multiple buffers are added per-device. It almost makes sense to
unify the 'pollq' on indio_dev.
But, it looks a bit difficult, and would require some more change [which is
doable] if it makes sense for whatever reason.
The only reason to do it, is because the iio_buffer_fileops has a .poll =
iio_buffer_poll() function attached to it. Adding multiple buffers for an
IIO device may require some consideration on the iio_buffer_poll() function
as well.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../buffer/industrialio-buffer-dmaengine.c    |   3 +-
 drivers/iio/industrialio-buffer.c             | 198 ++++++++++++++----
 drivers/iio/industrialio-core.c               |   3 +-
 include/linux/iio/buffer.h                    |   9 +
 include/linux/iio/buffer_impl.h               |   7 +
 include/linux/iio/iio.h                       |   8 +-
 6 files changed, 185 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 6dedf12b69a4..ae9d4c06d6b5 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -131,8 +131,9 @@ static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	/* FIXME: see about indio_dev->buffer_out */
 	struct dmaengine_buffer *dmaengine_buffer =
-		iio_buffer_to_dmaengine_buffer(indio_dev->buffer);
+		iio_buffer_to_dmaengine_buffer(indio_dev->buffer_in);
 
 	return sprintf(buf, "%zu\n", dmaengine_buffer->align);
 }
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c6af18448dd5..79adda6fcbac 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -103,7 +103,7 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
 			      size_t n, loff_t *f_ps)
 {
 	struct iio_dev *indio_dev = filp->private_data;
-	struct iio_buffer *rb = indio_dev->buffer;
+	struct iio_buffer *rb = indio_dev->buffer_in;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	size_t datum_size;
 	size_t to_wait;
@@ -156,6 +156,46 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
 	return ret;
 }
 
+static bool iio_buffer_space_available(struct iio_buffer *buf)
+{
+	if (buf->access->space_available)
+		return buf->access->space_available(buf);
+
+	return true;
+}
+
+ssize_t iio_buffer_chrdev_write(struct file *filp, const char __user *buf,
+				      size_t n, loff_t *f_ps)
+{
+	struct iio_dev *indio_dev = filp->private_data;
+	struct iio_buffer *wb = indio_dev->buffer_out;
+	int ret;
+
+	if (!wb || !wb->access->write)
+		return -EINVAL;
+
+	do {
+		if (!iio_buffer_space_available(wb)) {
+			if (filp->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			ret = wait_event_interruptible(wb->pollq,
+					iio_buffer_space_available(wb) ||
+					indio_dev->info == NULL);
+			if (ret)
+				return ret;
+			if (indio_dev->info == NULL)
+				return -ENODEV;
+		}
+
+		ret = wb->access->write(wb, n, buf);
+		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
+			ret = -EAGAIN;
+	} while (ret == 0);
+
+	return ret;
+}
+
 /**
  * iio_buffer_poll() - poll the buffer to find out if it has data
  * @filp:	File structure pointer for device access
@@ -169,15 +209,24 @@ __poll_t iio_buffer_poll(struct file *filp,
 			     struct poll_table_struct *wait)
 {
 	struct iio_dev *indio_dev = filp->private_data;
-	struct iio_buffer *rb = indio_dev->buffer;
+	struct iio_buffer *rb = indio_dev->buffer_in;
+	struct iio_buffer *wb = indio_dev->buffer_out;
+	__poll_t poll_flags = 0;
 
-	if (!indio_dev->info || rb == NULL)
+	if (!indio_dev->info)
 		return 0;
 
-	poll_wait(filp, &rb->pollq, wait);
-	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
-		return EPOLLIN | EPOLLRDNORM;
-	return 0;
+	if (rb && iio_buffer_ready(indio_dev, rb, rb->watermark, 0)) {
+		poll_wait(filp, &rb->pollq, wait);
+		poll_flags |= EPOLLIN | EPOLLRDNORM;
+	}
+
+	if (wb && iio_buffer_space_available(wb)) {
+		poll_wait(filp, &wb->pollq, wait);
+		poll_flags |= EPOLLOUT | EPOLLWRNORM;
+	}
+
+	return poll_flags;
 }
 
 /**
@@ -189,10 +238,11 @@ __poll_t iio_buffer_poll(struct file *filp,
  */
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
 {
-	if (!indio_dev->buffer)
-		return;
+	if (indio_dev->buffer_in)
+		wake_up(&indio_dev->buffer_in->pollq);
 
-	wake_up(&indio_dev->buffer->pollq);
+	if (indio_dev->buffer_out)
+		wake_up(&indio_dev->buffer_out->pollq);
 }
 
 void iio_buffer_init(struct iio_buffer *buffer)
@@ -256,13 +306,26 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 		       this_attr->c->scan_type.shift);
 }
 
+static struct iio_buffer *iio_scan_el_attr_get_buffer(struct iio_dev *indio_dev,
+						      struct device_attribute *attr)
+{
+	/* FIXME; which to check here? */
+	if (false /*belongs to scan_elements_out group */)
+		return indio_dev->buffer_out;
+	/* FIXME; which to check here? */
+	if (false /* strncmp(attr->name, "out_", sizeof("out_") - 1) == 0 */)
+		return indio_dev->buffer_out;
+
+	return indio_dev->buffer_in;
+}
+
 static ssize_t iio_scan_el_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_scan_el_attr_get_buffer(indio_dev, attr);
 
 	/* Ensure ret is 0 or 1. */
 	ret = !!test_bit(to_iio_dev_attr(attr)->address,
@@ -375,7 +438,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	int ret;
 	bool state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_scan_el_attr_get_buffer(indio_dev, attr);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = strtobool(buf, &state);
@@ -411,7 +474,7 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_scan_el_attr_get_buffer(indio_dev, attr);
 
 	return sprintf(buf, "%d\n", buffer->scan_timestamp);
 }
@@ -423,7 +486,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_scan_el_attr_get_buffer(indio_dev, attr);
 	bool state;
 
 	ret = strtobool(buf, &state);
@@ -495,12 +558,21 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static struct iio_buffer *iio_buffer_attr_get_buffer(struct iio_dev *indio_dev,
+						     struct device_attribute *attr)
+{
+	if (false /*belongs to buffer_out group */)
+		return indio_dev->buffer_out;
+
+	return indio_dev->buffer_in;
+}
+
 static ssize_t iio_buffer_read_length(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_buffer_attr_get_buffer(indio_dev, attr);
 
 	return sprintf(buf, "%d\n", buffer->length);
 }
@@ -510,7 +582,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_buffer_attr_get_buffer(indio_dev, attr);
 	unsigned int val;
 	int ret;
 
@@ -543,7 +615,7 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
 				      char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_buffer_attr_get_buffer(indio_dev, attr);
 
 	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
 }
@@ -1135,7 +1207,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	int ret;
 	bool requested_state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_buffer_attr_get_buffer(indio_dev, attr);
 	bool inlist;
 
 	ret = strtobool(buf, &requested_state);
@@ -1160,14 +1232,12 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	return (ret < 0) ? ret : len;
 }
 
-static const char * const iio_scan_elements_group_name = "scan_elements";
-
 static ssize_t iio_buffer_show_watermark(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_buffer_attr_get_buffer(indio_dev, attr);
 
 	return sprintf(buf, "%u\n", buffer->watermark);
 }
@@ -1178,7 +1248,7 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 					  size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_buffer_attr_get_buffer(indio_dev, attr);
 	unsigned int val;
 	int ret;
 
@@ -1212,7 +1282,7 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
 						char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *buffer = iio_buffer_attr_get_buffer(indio_dev, attr);
 
 	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
@@ -1237,23 +1307,15 @@ static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_data_available.attr,
 };
 
-int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
+static int __iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev,
+					     struct iio_buffer *buffer,
+					     enum iio_buffer_dir dir)
 {
 	struct iio_dev_attr *p;
 	struct attribute **attr;
-	struct iio_buffer *buffer = indio_dev->buffer;
 	int ret, i, attrn, attrcount, attrcount_orig = 0;
 	const struct iio_chan_spec *channels;
 
-	channels = indio_dev->channels;
-	if (channels) {
-		int ml = indio_dev->masklength;
-
-		for (i = 0; i < indio_dev->num_channels; i++)
-			ml = max(ml, channels[i].scan_index + 1);
-		indio_dev->masklength = ml;
-	}
-
 	if (!buffer)
 		return 0;
 
@@ -1281,8 +1343,12 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 
 	attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
 
-	buffer->buffer_group.name = "buffer";
+	if (dir == IIO_BUFFER_DIRECTION_OUT)
+		buffer->buffer_group.name = "buffer_out";
+	else
+		buffer->buffer_group.name = "buffer_in";
 	buffer->buffer_group.attrs = attr;
+	/* FIXME: add buffer/ symlink for backwards compat */
 
 	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
 
@@ -1319,7 +1385,11 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 		}
 	}
 
-	buffer->scan_el_group.name = iio_scan_elements_group_name;
+	if (dir == IIO_BUFFER_DIRECTION_OUT)
+		buffer->scan_el_group.name = "scan_elements_out";
+	else
+		buffer->scan_el_group.name = "scan_elements_in";
+	/* FIXME: add scan_elements/ symlink for backwards compat */
 
 	buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
 					      sizeof(buffer->scan_el_group.attrs[0]),
@@ -1348,10 +1418,33 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	return ret;
 }
 
-void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
+int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
+	const struct iio_chan_spec *channels;
+	int i, ret;
+
+	channels = indio_dev->channels;
+	if (channels) {
+		int ml = indio_dev->masklength;
+
+		for (i = 0; i < indio_dev->num_channels; i++)
+			ml = max(ml, channels[i].scan_index + 1);
+		indio_dev->masklength = ml;
+	}
+
+	ret = __iio_buffer_alloc_sysfs_and_mask(indio_dev,
+						indio_dev->buffer_in,
+						IIO_BUFFER_DIRECTION_IN);
+	if (ret)
+		return ret;
+
+	return __iio_buffer_alloc_sysfs_and_mask(indio_dev,
+						 indio_dev->buffer_out,
+						 IIO_BUFFER_DIRECTION_OUT);
+}
 
+static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
+{
 	if (!buffer)
 		return;
 
@@ -1361,6 +1454,12 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
 }
 
+void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
+{
+	__iio_buffer_free_sysfs_and_mask(indio_dev->buffer_in);
+	__iio_buffer_free_sysfs_and_mask(indio_dev->buffer_out);
+}
+
 /**
  * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
  * @indio_dev: the iio device
@@ -1470,6 +1569,26 @@ void iio_buffer_put(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(iio_buffer_put);
 
+/**
+ * iio_device_attach_buffer - Attach a buffer to a IIO device for reading or writing
+ * @indio_dev: The device the buffer should be attached to
+ * @buffer: The buffer to attach to the device
+ * @dir: The direction to which to use this buffer (reading or writing)
+ *
+ * This function attaches a buffer to a IIO device. The buffer stays attached to
+ * the device until the device is freed. The function should only be called at
+ * most once per device.
+ */
+void iio_device_attach_buffer_dir(struct iio_dev *indio_dev,
+				  struct iio_buffer *buffer,
+				  enum iio_buffer_dir dir)
+{
+	if (dir == IIO_BUFFER_DIRECTION_OUT)
+		indio_dev->buffer_out = iio_buffer_get(buffer);
+	else
+		indio_dev->buffer_in = iio_buffer_get(buffer);
+}
+
 /**
  * iio_device_attach_buffer - Attach a buffer to a IIO device
  * @indio_dev: The device the buffer should be attached to
@@ -1482,6 +1601,7 @@ EXPORT_SYMBOL_GPL(iio_buffer_put);
 void iio_device_attach_buffer(struct iio_dev *indio_dev,
 			      struct iio_buffer *buffer)
 {
-	indio_dev->buffer = iio_buffer_get(buffer);
+	iio_device_attach_buffer_dir(indio_dev, buffer,
+				     IIO_BUFFER_DIRECTION_IN);
 }
 EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a13957644c1d..45add6a1087a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1475,7 +1475,8 @@ static void iio_dev_release(struct device *device)
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
 
-	iio_buffer_put(indio_dev->buffer);
+	iio_buffer_put(indio_dev->buffer_in);
+	iio_buffer_put(indio_dev->buffer_out);
 
 	ida_simple_remove(&iio_ida, indio_dev->id);
 	kfree(indio_dev);
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index fbba4093f06c..3e1717383f27 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -11,6 +11,11 @@
 
 struct iio_buffer;
 
+enum iio_buffer_dir {
+	IIO_BUFFER_DIRECTION_IN,
+	IIO_BUFFER_DIRECTION_OUT,
+};
+
 void iio_buffer_set_attrs(struct iio_buffer *buffer,
 			 const struct attribute **attrs);
 
@@ -44,6 +49,10 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 				   const unsigned long *mask);
 
+void iio_device_attach_buffer_dir(struct iio_dev *indio_dev,
+				  struct iio_buffer *buffer,
+				  enum iio_buffer_dir dir);
+
 void iio_device_attach_buffer(struct iio_dev *indio_dev,
 			      struct iio_buffer *buffer);
 
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 1e7edf6bed96..e4728a7a2ad8 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -21,6 +21,9 @@ struct iio_buffer;
  * @read:		try to get a specified number of bytes (must exist)
  * @data_available:	indicates how much data is available for reading from
  *			the buffer.
+ * @write:		try to write a specified number of bytes
+ * @space_available:	indicates how much data is available for writing to
+ *			the buffer.
  * @request_update:	if a parameter change has been marked, update underlying
  *			storage.
  * @set_bytes_per_datum:set number of bytes per datum
@@ -48,6 +51,10 @@ struct iio_buffer_access_funcs {
 	int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
 	size_t (*data_available)(struct iio_buffer *buffer);
 
+	int (*write)(struct iio_buffer *buffer, size_t n,
+		const char __user *buf);
+	size_t (*space_available)(struct iio_buffer *buffer);
+
 	int (*request_update)(struct iio_buffer *buffer);
 
 	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a123f8acb192..9460970d02af 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -489,7 +489,9 @@ struct iio_buffer_setup_ops {
  * @dev:		[DRIVER] device structure, should be assigned a parent
  *			and owner
  * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
- * @buffer:		[DRIVER] any buffer present
+ * @buffer:		[DRIVER] same as @buffer_in (for backwards compat)
+ * @buffer_in:		[DRIVER] any buffer present for reading from a device
+ * @buffer_out:		[DRIVER] any buffer present for writing to a device
  * @active_buffers:	[INTERN] list of all buffers currently enabled/active
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
@@ -533,7 +535,9 @@ struct iio_dev {
 
 	struct iio_event_interface	*event_interface;
 
-	struct iio_buffer		*buffer;
+	//struct iio_buffer		*buffer;
+	struct iio_buffer		*buffer_in;
+	struct iio_buffer		*buffer_out;
 	struct list_head		active_buffers;
 	int				scan_bytes;
 	struct mutex			mlock;
-- 
2.20.1

