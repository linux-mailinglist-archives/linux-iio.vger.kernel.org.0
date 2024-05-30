Return-Path: <linux-iio+bounces-5509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF35B8D4EDE
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 17:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446761F25DE1
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4623C182D2A;
	Thu, 30 May 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bY+E8qT+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03C17F50D
	for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082075; cv=none; b=owcSF9IT+7bQku6vyNcSKwzgKo6if2p3igpHKmJmDpYb2sKtZfXbIixOhkeEwqOQ0PEKHKTHYPdmVCwaJIRTGhsPhWzR3KCizC6kbVCLSmvQ8hqMpCkY9e0iF7ry5o9RzbHko7mJ2xGRNL+07G2yrcL8Wwg1wx3+uZPno5Kd3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082075; c=relaxed/simple;
	bh=D6UyROuZwAs3IFuLEy0yyT2LzcvHAh4TBhmxLHlH9HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlWjgu3yxU6CpGyklW5TlpiwH7a0FfxCSz2hl0cNwCOUKMEEcFsGhzLw8i9itC+qhLTAtTvdMwxKKp5WgGDYsb+TCwcT6iIOtL+qzYAAOQthOR6WrvGz6RLduwOmV3mVwE05fySuZ4PLFONkSpW0Wx/NT2D1iSzIGsoHmAEwu30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bY+E8qT+; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f8e5115cfbso632547a34.0
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717082071; x=1717686871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARkP3gEjLJuFmKmn7+LYv5VdtcnLNuF1mAXkD5YuF4Y=;
        b=bY+E8qT+ryhrTgcpIrK2qTufRWdUL2t/fv/k9QD5jq5c4qsOUe2PcoIryi0tSyqaWL
         3NKJzro3MRtrEujaLacfP6OP9+LK9q6y8EqC3dzJ1DLUoSafpWjYELDn5enilNVJ+2ff
         vjd1f2QnOY+f2pLx7SL9nQ8Kc99r9wgCqVMhz2q4Sc9Hupb3+QxhL2lsTGyGa1FADUol
         7sc3lP/+zP9uv2fBa3ms2HZa0BJ8p8FnOz8FYiziE6I0z72MN2y+bK6d/Hoew/6qptuF
         +hFKv8opPZAaWXvWkVNmNLxjXYazW5o7xR7NUSf8DUcNTu7Fi6pBdcsyL2wjgePmyuTL
         7a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082071; x=1717686871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARkP3gEjLJuFmKmn7+LYv5VdtcnLNuF1mAXkD5YuF4Y=;
        b=RCf5ZNCajp/8ws8MnhLOiUlKqXR1O1ONIZtl8Fhd2CeJvY8V2psM+LMtwg9oSs112c
         guE9kQguFdqLl4hMqt4FD2swjmJI7NPg2Fis/h82x8tc6qCUFGWXIithBeEJ2Lo21Iyw
         4VZP/Nq23cSheAsyDyjwdKEy32AJxhZ8gRXlLo3vap1ns8swpO6ba38e2QLh+33TDLmp
         5yl76qlc0k6P1krHH3yv2EuuYwk0aeupwjI+g0AzEijgmT2vLtrzHinEc4/ULCRktzP9
         i1ahdyT9JwLYXkGhYJVuNg/UDU/a4JrUl9ErPEJKJ4d7Xmnw+ZwAzEF2GeJDGCI86U1X
         8sDw==
X-Forwarded-Encrypted: i=1; AJvYcCWXZOThYbu9I3+7DYxmhvaUG8rJM/NqKsKdKlH1VngnsLtZwwTngCxVRRYPgeKvVYLNYzDQ4gd6kVcbqGhSPUrFAyKugwCUaiYf
X-Gm-Message-State: AOJu0Yw0eIHGH56OoDvxZdONzp1pfAitTXU0V5YhaqnvmV9tg0cXAD4H
	MMwJo9RF1sS77g9LSoR1Te9JJlyywefWaqUVpbjHKhQhI4+nbTh5Wl1H8fwSMb4=
X-Google-Smtp-Source: AGHT+IH9DRwESXdM4dQ809LwnSFT5ogp09S5MU08X8hkaC+tPLhprQerdIbzSMHC3HwkZOfEGoWpJA==
X-Received: by 2002:a9d:7f11:0:b0:6f5:a8a5:be6a with SMTP id 46e09a7af769-6f90aeccf55mr2717045a34.22.1717082070956;
        Thu, 30 May 2024 08:14:30 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0de6314sm2803425a34.41.2024.05.30.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:14:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] iio: add support for multiple scan types per channel
Date: Thu, 30 May 2024 10:14:10 -0500
Message-ID: <20240530-iio-add-support-for-multiple-scan-types-v3-3-cbc4acea2cfa@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
References: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
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

To make use of this, drivers need to implement the new callback
get_current_scan_type() to resolve the scan type for a given channel
based on the current state of the driver. There is a new scan_type_ext
field in the iio_channel structure that should be used to store the
scan types for any channel that has more than one. There is also a new
flag has_ext_scan_type that acts as a type discriminator for the
scan_type/ext_scan_type union. A union is used so that we don't grow
the size of the iio_channel structure and also makes it clear that
scan_type and ext_scan_type are mutually exclusive.

The buffer code is the only code in the IIO core code that is using the
scan_type field. This patch updates the buffer code to use the new
iio_channel_validate_scan_type() function to ensure it is returning the
correct scan type for the current state of the device when reading the
sysfs attributes. The buffer validation code is also update to validate
any additional scan types that are set in the scan_type_ext field. Part
of that code is refactored to a new function to avoid duplication.

Some userspace tools may need to be updated to re-read the scan type
after writing any other attribute. During testing, we noticed that we
had to restart iiod to get it to re-read the scan type after enabling
oversampling on the ad7380 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* change return type of get_current_scan_type callback to int
* add error checks since iio_get_current_scan_type() can can now return
  an error

v2 changes:
* use union for scan_type and ext_scan_type/num_ext_scan_types
* add has_ext_scan_type flag for type discrimination
* add extra validation check for get_current_scan_type when
  has_ext_scan_type is set
---
 drivers/iio/industrialio-buffer.c | 101 ++++++++++++++++++++++++++++++--------
 include/linux/iio/iio.h           |  55 ++++++++++++++++++++-
 2 files changed, 133 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 08103a9e77f7..0138b21b244f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -365,9 +365,16 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	const struct iio_scan_type *scan_type = &this_attr->c->scan_type;
-	u8 type = scan_type->endianness;
+	const struct iio_scan_type *scan_type;
+	u8 type;
+
+	scan_type = iio_get_current_scan_type(indio_dev, this_attr->c);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	type = scan_type->endianness;
 
 	if (type == IIO_CPU) {
 #ifdef __LITTLE_ENDIAN
@@ -691,15 +698,18 @@ static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(buf, "%d\n", iio_buffer_is_active(buffer));
 }
 
-static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
-					     unsigned int scan_index)
+static int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
+				    unsigned int scan_index)
 {
 	const struct iio_chan_spec *ch;
 	const struct iio_scan_type *scan_type;
 	unsigned int bytes;
 
 	ch = iio_find_channel_from_si(indio_dev, scan_index);
-	scan_type = &ch->scan_type;
+	scan_type = iio_get_current_scan_type(indio_dev, ch);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
 	bytes = scan_type->storagebits / 8;
 
 	if (scan_type->repeat > 1)
@@ -708,7 +718,7 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 	return bytes;
 }
 
-static unsigned int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
+static int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
@@ -726,6 +736,9 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 	for_each_set_bit(i, mask,
 			 indio_dev->masklength) {
 		length = iio_storage_bytes_for_si(indio_dev, i);
+		if (length < 0)
+			return length;
+
 		bytes = ALIGN(bytes, length);
 		bytes += length;
 		largest = max(largest, length);
@@ -733,6 +746,9 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 
 	if (timestamp) {
 		length = iio_storage_bytes_for_timestamp(indio_dev);
+		if (length < 0)
+			return length;
+
 		bytes = ALIGN(bytes, length);
 		bytes += length;
 		largest = max(largest, length);
@@ -1012,14 +1028,22 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 				       indio_dev->masklength,
 				       in_ind + 1);
 		while (in_ind != out_ind) {
-			length = iio_storage_bytes_for_si(indio_dev, in_ind);
+			ret = iio_storage_bytes_for_si(indio_dev, in_ind);
+			if (ret < 0)
+				goto error_clear_mux_table;
+
+			length = ret;
 			/* Make sure we are aligned */
 			in_loc = roundup(in_loc, length) + length;
 			in_ind = find_next_bit(indio_dev->active_scan_mask,
 					       indio_dev->masklength,
 					       in_ind + 1);
 		}
-		length = iio_storage_bytes_for_si(indio_dev, in_ind);
+		ret = iio_storage_bytes_for_si(indio_dev, in_ind);
+		if (ret < 0)
+			goto error_clear_mux_table;
+
+		length = ret;
 		out_loc = roundup(out_loc, length);
 		in_loc = roundup(in_loc, length);
 		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
@@ -1030,7 +1054,11 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 	}
 	/* Relies on scan_timestamp being last */
 	if (buffer->scan_timestamp) {
-		length = iio_storage_bytes_for_timestamp(indio_dev);
+		ret = iio_storage_bytes_for_timestamp(indio_dev);
+		if (ret < 0)
+			goto error_clear_mux_table;
+
+		length = ret;
 		out_loc = roundup(out_loc, length);
 		in_loc = roundup(in_loc, length);
 		ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
@@ -1597,6 +1625,22 @@ static long iio_device_buffer_ioctl(struct iio_dev *indio_dev, struct file *filp
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
@@ -1626,18 +1670,33 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 			if (channels[i].scan_index < 0)
 				continue;
 
-			scan_type = &channels[i].scan_type;
-
-			/* Verify that sample bits fit into storage */
-			if (scan_type->storagebits <
-			    scan_type->realbits + scan_type->shift) {
-				dev_err(&indio_dev->dev,
-					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
-					i, scan_type->storagebits,
-					scan_type->realbits,
-					scan_type->shift);
-				ret = -EINVAL;
-				goto error_cleanup_dynamic;
+			if (channels[i].has_ext_scan_type) {
+				int j;
+
+				/*
+				 * get_current_scan_type is required when using
+				 * extended scan types.
+				 */
+				if (!indio_dev->info->get_current_scan_type) {
+					ret = -EINVAL;
+					goto error_cleanup_dynamic;
+				}
+
+				for (j = 0; j < channels[i].num_ext_scan_type; j++) {
+					scan_type = &channels[i].ext_scan_type[j];
+
+					ret = iio_channel_validate_scan_type(
+						&indio_dev->dev, i, scan_type);
+					if (ret)
+						goto error_cleanup_dynamic;
+				}
+			} else {
+				scan_type = &channels[i].scan_type;
+
+				ret = iio_channel_validate_scan_type(
+						&indio_dev->dev, i, scan_type);
+				if (ret)
+					goto error_cleanup_dynamic;
 			}
 
 			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 19de573a944a..894309294182 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -204,7 +204,13 @@ struct iio_scan_type {
  * @address:		Driver specific identifier.
  * @scan_index:		Monotonic index to give ordering in scans when read
  *			from a buffer.
- * @scan_type:		struct describing the scan type
+ * @scan_type:		struct describing the scan type - mutually exclusive
+ *			with ext_scan_type.
+ * @ext_scan_type:	Used in rare cases where there is more than one scan
+ *			format for a channel. When this is used, the flag
+ *			has_ext_scan_type must be set and the driver must
+ *			implement get_current_scan_type in struct iio_info.
+ * @num_ext_scan_type:	Number of elements in ext_scan_type.
  * @info_mask_separate: What information is to be exported that is specific to
  *			this channel.
  * @info_mask_separate_available: What availability information is to be
@@ -248,6 +254,7 @@ struct iio_scan_type {
  *			attributes but not for event codes.
  * @output:		Channel is output.
  * @differential:	Channel is differential.
+ * @has_ext_scan_type:	True if ext_scan_type is used instead of scan_type.
  */
 struct iio_chan_spec {
 	enum iio_chan_type	type;
@@ -255,7 +262,13 @@ struct iio_chan_spec {
 	int			channel2;
 	unsigned long		address;
 	int			scan_index;
-	struct iio_scan_type scan_type;
+	union {
+		struct iio_scan_type scan_type;
+		struct {
+			const struct iio_scan_type *ext_scan_type;
+			unsigned int num_ext_scan_type;
+		};
+	};
 	long			info_mask_separate;
 	long			info_mask_separate_available;
 	long			info_mask_shared_by_type;
@@ -273,6 +286,7 @@ struct iio_chan_spec {
 	unsigned		indexed:1;
 	unsigned		output:1;
 	unsigned		differential:1;
+	unsigned		has_ext_scan_type:1;
 };
 
 
@@ -435,6 +449,9 @@ struct iio_trigger; /* forward declaration */
  *			for better event identification.
  * @validate_trigger:	function to validate the trigger when the
  *			current trigger gets changed.
+ * @get_current_scan_type: must be implemented by drivers that use ext_scan_type
+ *			in the channel spec to return the index of the currently
+ *			active ext_scan type for a channel.
  * @update_scan_mode:	function to configure device and scan buffer when
  *			channels have changed
  * @debugfs_reg_access:	function to read or write register value of device
@@ -519,6 +536,8 @@ struct iio_info {
 
 	int (*validate_trigger)(struct iio_dev *indio_dev,
 				struct iio_trigger *trig);
+	int (*get_current_scan_type)(const struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan);
 	int (*update_scan_mode)(struct iio_dev *indio_dev,
 				const unsigned long *scan_mask);
 	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
@@ -804,6 +823,38 @@ static inline bool iio_read_acpi_mount_matrix(struct device *dev,
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
+ * Returns: the current scan type for the channel or error.
+ */
+static inline const struct iio_scan_type
+*iio_get_current_scan_type(const struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan)
+{
+	int ret;
+
+	if (chan->has_ext_scan_type) {
+		ret = indio_dev->info->get_current_scan_type(indio_dev, chan);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
+		if (ret >= chan->num_ext_scan_type)
+			return ERR_PTR(-EINVAL);
+
+		return &chan->ext_scan_type[ret];
+	}
+
+	return &chan->scan_type;
+}
+
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,

-- 
2.45.1


