Return-Path: <linux-iio+bounces-4864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EE08BEC2C
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 21:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A692847EA
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E116DEC4;
	Tue,  7 May 2024 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GHvNY/NQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA516D9B7
	for <linux-iio@vger.kernel.org>; Tue,  7 May 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108542; cv=none; b=XLb+hZBO1pahcjUkX9gzL+UqiIY2Jy/XK6Bvj+CY7unNBwilPF2Pt3XDWkdsX6XBQqr0Kmwyv0VbPrp0aQkaFNW/PMLnif4cX7O9sSgBqeygHW672y1sdXS+IDAT1xLwz2JAq9e2baa5yoTokVOsds8yJ8+mY7g+bTXbMDkG9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108542; c=relaxed/simple;
	bh=Fn1xbpXsu4PAcmCL4wCw7+fLXWr43hwXXVU0yqQAbdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkuYMAhzTeg3MRG/2yf8S8GniA7HYG40SA9KCy7HqBFGvSTedHqzEkw+n/NtHRGKwpeMUg9WfzUXb2Wd0RkFm16ADZkySeiRrXnRS7kcr/jitzo4gPXfOWItHP5PqrgYSbipxftGrPMjfybpl2DSHMkj49xugGSazW6xuec4Pfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GHvNY/NQ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c86f066256so1990690b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2024 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715108539; x=1715713339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zva8gT55IALq82V9YRVJAnVfhuhJYt5YJF4Qc5Cxi6Y=;
        b=GHvNY/NQZo+CQQgda26XuIvNNy6w6ux4LR1BizIemG/ioiNlpQUMAAngs6ljWPgmIg
         oRrWbsOAB6SPA2kQJvoMIV1lTEvzd7zOjYEhYY65IjmnvrPtxAA7KgZNuTkS5+mvTQPd
         QuRMOVOJlXjMYm5bsjGkYgzqoeT3veGT2QrM++SBFUqzwJE8IbvF8jZCHRV/qud+7hbw
         ssZ9zgOlOk+7FFItAFygJ7/axZ3R4U4MnY1hDIg1LYsvUU620s0Xu7KPs9xB7JR2JvhQ
         lpb/AOYvxghbScH0MBNS8NGqNESZ2Ju7shsqccLNknyMITH3TSpzQoICpsF4nOlb5XTe
         6YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715108539; x=1715713339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zva8gT55IALq82V9YRVJAnVfhuhJYt5YJF4Qc5Cxi6Y=;
        b=Di8Zs9Y5+fU9s0QvOcfLIBPGyEbv0s2/kLuEtXMS+MnDEodLk11aFxSEZ/IOCqnhjg
         DWXaEwT/j1lplxbbOmRyuIkQ+6yOUNO8FeeM2nNN18LxTBW7CvMa6FT5iqwtaiScXaCT
         wTkNxI6UiqOdGNARkTZKHEbccikHTJ6rhuvIrGHQlccK/LCNoyoS2qHp0aa0b8QQcAm6
         dAs7/7SQT3D9KdO3975PJfWvMNUrKXpGYfO2F5+nw0lSI0zuWnbFoP4uxnImeLzLc1/R
         WszPELuuMvltNMehdoigVUjpMihj83VRTkvH247MNFn3s8bvvxSnx/x6ge1H48rp+riu
         7Hzw==
X-Forwarded-Encrypted: i=1; AJvYcCXs9o6xCSkbET+xNdO3Vr9Lo6vBMQhXNTq1seKS0btBSqvRxUOCeGuJiMfBVwNsRm1a7Y+Ld0Ce3H6pfXPEqkFQMfPNZu/S7qDw
X-Gm-Message-State: AOJu0YxzDoUE8/nGzKZeFwUj+6+g749eShtHwFi+ucU0/SlH/s8nU7Af
	3DwdzveaJh1cTT89WneXYdDLy6Wywc5G6UHopLwXpVm+yXnf+b+y+Oy++EMqrok=
X-Google-Smtp-Source: AGHT+IH9wjghj4HrhmVD/ukOy+0Q7pKFtsk6AEg9jWoiV/hwRi2mH9xji406zXVARSpFy9wOTkJbuQ==
X-Received: by 2002:aca:1e06:0:b0:3c5:f4b3:e0e3 with SMTP id 5614622812f47-3c985305afdmr446220b6e.41.1715108539681;
        Tue, 07 May 2024 12:02:19 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id j14-20020a54480e000000b003c96bbe0e79sm909652oij.13.2024.05.07.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:02:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/4] iio: add support for multiple scan types per channel
Date: Tue,  7 May 2024 14:02:07 -0500
Message-ID: <20240507-iio-add-support-for-multiple-scan-types-v1-3-95ac33ee51e9@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds new fields to the iio_channel structure to support multiple
scan types per channel. This is useful for devices that support multiple
resolution modes or other modes that require different data formats of
the raw data.

To make use of this, drivers can still use the old scan_type field for
the "default" scan type and use the new scan_type_ext field for any
additional scan types. And they must implement the new callback
get_current_scan_type() to return the current scan type based on the
current state of the device.

The buffer code is the only code in the IIO core code that is using the
scan_type field. This patch updates the buffer code to use the new
iio_channel_validate_scan_type() function to ensure it is returning the
correct scan type for the current state of the device when reading the
sysfs attributes. The buffer validation code is also update to validate
any additional scan types that are set in the scan_type_ext field. Part
of that code is refactored to a new function to avoid duplication.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 43 +++++++++++++++++++++++++++++----------
 include/linux/iio/iio.h           | 33 ++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 08103a9e77f7..ef27ce71ec25 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -365,8 +365,10 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	const struct iio_scan_type *scan_type = &this_attr->c->scan_type;
+	const struct iio_scan_type *scan_type =
+				iio_get_current_scan_type(indio_dev, this_attr->c);
 	u8 type = scan_type->endianness;
 
 	if (type == IIO_CPU) {
@@ -699,7 +701,7 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 	unsigned int bytes;
 
 	ch = iio_find_channel_from_si(indio_dev, scan_index);
-	scan_type = &ch->scan_type;
+	scan_type = iio_get_current_scan_type(indio_dev, ch);
 	bytes = scan_type->storagebits / 8;
 
 	if (scan_type->repeat > 1)
@@ -1597,6 +1599,22 @@ static long iio_device_buffer_ioctl(struct iio_dev *indio_dev, struct file *filp
 	}
 }
 
+static int iio_channel_validate_scan_type(struct device *dev, int ch,
+					  const struct iio_scan_type *scan_type)
+{
+	/* Verify that sample bits fit into storage */
+	if (scan_type->storagebits < scan_type->realbits + scan_type->shift) {
+		dev_err(dev,
+			"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
+			ch, scan_type->storagebits,
+			scan_type->realbits,
+			scan_type->shift);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 					     struct iio_dev *indio_dev,
 					     int index)
@@ -1622,22 +1640,25 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 		/* new magic */
 		for (i = 0; i < indio_dev->num_channels; i++) {
 			const struct iio_scan_type *scan_type;
+			int j;
 
 			if (channels[i].scan_index < 0)
 				continue;
 
 			scan_type = &channels[i].scan_type;
 
-			/* Verify that sample bits fit into storage */
-			if (scan_type->storagebits <
-			    scan_type->realbits + scan_type->shift) {
-				dev_err(&indio_dev->dev,
-					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
-					i, scan_type->storagebits,
-					scan_type->realbits,
-					scan_type->shift);
-				ret = -EINVAL;
+			ret = iio_channel_validate_scan_type(&indio_dev->dev,
+							     i, scan_type);
+			if (ret)
 				goto error_cleanup_dynamic;
+
+			for (j = 0; j < channels[i].num_ext_scan_type; j++) {
+				scan_type = &channels[i].ext_scan_type[j];
+
+				ret = iio_channel_validate_scan_type(
+						&indio_dev->dev, i, scan_type);
+				if (ret)
+					goto error_cleanup_dynamic;
 			}
 
 			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 19de573a944a..66f0b4c68f53 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -205,6 +205,9 @@ struct iio_scan_type {
  * @scan_index:		Monotonic index to give ordering in scans when read
  *			from a buffer.
  * @scan_type:		struct describing the scan type
+ * @ext_scan_type:	Used in rare cases where there is more than one scan
+ *			format for a channel. When this is used, omit scan_type.
+ * @num_ext_scan_type:	Number of elements in ext_scan_type.
  * @info_mask_separate: What information is to be exported that is specific to
  *			this channel.
  * @info_mask_separate_available: What availability information is to be
@@ -256,6 +259,8 @@ struct iio_chan_spec {
 	unsigned long		address;
 	int			scan_index;
 	struct iio_scan_type scan_type;
+	const struct iio_scan_type *ext_scan_type;
+	unsigned int		num_ext_scan_type;
 	long			info_mask_separate;
 	long			info_mask_separate_available;
 	long			info_mask_shared_by_type;
@@ -435,6 +440,9 @@ struct iio_trigger; /* forward declaration */
  *			for better event identification.
  * @validate_trigger:	function to validate the trigger when the
  *			current trigger gets changed.
+ * @get_current_scan_type: must be implemented by drivers that use ext_scan_type
+ *			in the channel spec to return the currently active scan
+ *			type based on the current state of the device.
  * @update_scan_mode:	function to configure device and scan buffer when
  *			channels have changed
  * @debugfs_reg_access:	function to read or write register value of device
@@ -519,6 +527,9 @@ struct iio_info {
 
 	int (*validate_trigger)(struct iio_dev *indio_dev,
 				struct iio_trigger *trig);
+	const struct iio_scan_type *(*get_current_scan_type)(
+					const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan);
 	int (*update_scan_mode)(struct iio_dev *indio_dev,
 				const unsigned long *scan_mask);
 	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
@@ -804,6 +815,28 @@ static inline bool iio_read_acpi_mount_matrix(struct device *dev,
 }
 #endif
 
+/**
+ * iio_get_current_scan_type - Get the current scan type for a channel
+ * @indio_dev:	the IIO device to get the scan type for
+ * @chan:	the channel to get the scan type for
+ *
+ * Most devices only have one scan type per channel and can just access it
+ * directly without calling this function. Core IIO code and drivers that
+ * implement ext_scan_type in the channel spec should use this function to
+ * get the current scan type for a channel.
+ *
+ * Returns: the current scan type for the channel
+ */
+static inline const struct iio_scan_type *iio_get_current_scan_type(
+					const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	if (indio_dev->info->get_current_scan_type)
+		return indio_dev->info->get_current_scan_type(indio_dev, chan);
+
+	return &chan->scan_type;
+}
+
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,

-- 
2.43.2


