Return-Path: <linux-iio+bounces-27925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F12D39903
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 084A230076B2
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBBE2D1F44;
	Sun, 18 Jan 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPzfDQPc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817922248B3
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760399; cv=none; b=dB9NHyDWKUY69eBIpEaYqoZ5MvKgNQ/vC2yHNcITiixhPuRrbQgBqOFysY6gLojdlK7Ir0hEqWpbmJrNvHCqrD/+h5oe+B/WtpFDkl1DA7TvzhsAn3RrAAmmcf7lSYAGOXVQHUtKLoUvUSrza0svYhwNKuMxSQ4ZMyt0Y7d0LnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760399; c=relaxed/simple;
	bh=T6a8BQUbWqU9GMRGIo9BhMSECj/L+r2E/Y035vRhNEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuWCiiLg3S66P+Ot2ofxhAI1Jv4sRmF5vjKMPjTguzU74Kdsta6c9mvjyK0//eYnMnUbGGCEc1q//0/LGWGd5+VHf7w6/2zKqdM5KqgNv6ZNI3fLHYXLbo1k4RK165KSTe1HjUkvOCZAQiD77b5fQ7fqWaexQIDsPA0D3dq8P+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPzfDQPc; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6ae4c2012so2632593eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760397; x=1769365197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m15yqdQHaxmYRVMpA6zrhF4sJGCIUQR0mh1h/cFJQfg=;
        b=KPzfDQPcXRDQ/fLVz/2GspHj5MVH8PoVoRRWj5ND/GdaU7K/jcLq9Wzf4WakHFizbg
         zB+nxvf91QKXirn5F9u6li1h6sLPoxUp4SVdCRcA6bPuhKXfkZL7vFMZb6jY7kYkRcYz
         mAZdZEMVciS22lcCchr0WgVFaVU1XDOoSRuLwjuQfM+AqQ5wlIub13e+0UkpBUUX9N/V
         02UmkbfmVhW+EWz8FMn12IWWZvo6jG2b0thpUchkE7myzPQ2Iu3f2XluTdVipek6X6ai
         APu+L+nYqQwoQ8M+mm1NVL6m69dhtMsGXYXIUy031llFIY8A7c3l56c6V4atDd+U8qfj
         c4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760397; x=1769365197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m15yqdQHaxmYRVMpA6zrhF4sJGCIUQR0mh1h/cFJQfg=;
        b=PG3yG7nPaqRxUIWXkgGME4+eGLJZt5OWux7+Q6hq//adOmgbKDQ1cU4ojOmh+6YBDj
         K6Kon/29rfsUlYzAgTlWUvGoi05R08jndTF9ZgJAIvxJQHwrXh+Ri+hXl+1H/2DmJR7K
         cQcmahkPh0O0Ir81cC9I96u07NopqdXUGNrav9yN6Y6os+t9Md4MmgaAUkpOFUNGA/A9
         zZGpZkM94qwRqAeRN1naqTGy2n9zZZwGFyv7TMzeAM7Q7ZeSz0SM6+pl6pSUfGKAQmFI
         TLW65PMllS8V1Wz256NJrviqo0gEerQ81EzCCjfdZ/LHnRXMBIP+t8O9evflwKBgFuB5
         btDw==
X-Gm-Message-State: AOJu0Yw0As43MWKz++Gpkf8ZLW9wvyk/cHeRpW/aMQEywiWp49IGohsL
	YmAJJgg/MiK886wfibzQtmyKccwrCBWAxPtZ+561FQgjTM1rBLzBg147QmYwmMEr
X-Gm-Gg: AY/fxX6tWIe5ZYc+FZTnsn8CPmkPtdpgn2aGXWnA6XS9kAd/ekge2+Uk0dlUDR9AdSQ
	4BtzwhHB3unQY4xQWi8IBDzGHKWf38bBkCmRmqF7uo3bzEdIsIcjm6EZ8iW9cIbNSriCebGvV3m
	9vH/na5Cg/3ZLPXL/vG0oK6Lp0xXIZbkADqJKc+43e7r/BhGatN7R4ieqmC4RO7VMsjKREq+5gr
	vQd2mY0QO1LIcnoQckG9pzKurzIVFHUzgDZtOwGFeeH2KgPThbyDttkXlI/jm5stHR6GZ+ptY1d
	RLhOECjnmTVceje9ad2aJ09bgCE62/IeJ/AyX+R3Mmv4JjrUhUnCOBT4k5onDs+KrkMYZDNMtvO
	9viIOvfJlAMG3veL5Nc1s8prIsrmGiTkkR6qb8e8dhwX6V1fk4GftESpovXGUrqkCtYiLtzlaXR
	5gJ6Jp0LzcljeXDyBkKhs=
X-Received: by 2002:a05:7301:4104:b0:2b0:59da:f799 with SMTP id 5a478bee46e88-2b6b3ed9f07mr5997350eec.5.1768760396742;
        Sun, 18 Jan 2026 10:19:56 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c122bsm9907807eec.5.2026.01.18.10.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:19:56 -0800 (PST)
Date: Sun, 18 Jan 2026 15:21:46 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [RFC PATCH v1 7/9] iio: Expand IIO event interface for real-world
 unit handling
Message-ID: <6d9baa8d553d03a41fbd97bca0377a7a4779a93e.1768759292.git.marcelo.schmitt1@gmail.com>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768759292.git.marcelo.schmitt1@gmail.com>

The IIO event ABI documentation distinguishes between interfaces that
handle values in device-specific units (_raw) and event interfaces that
handle values in real-world units (e.g. meters, Joules, lux, etc).
However, the IIO event code infrastructure had never really implemented the
bits to distinguish between those two types of interfaces and had always
presumed events to handle raw device values.

For most current use cases, assuming events to handle values in device raw
units is reasonable because it often matches the type of the associated IIO
channel. There are a few cases where drivers provide events along side
channels with both _raw and _input interfaces, though. Also, when
real-world values can be mapped back to device configurations, it enables
drivers to provide event interfaces that are arguably easier to use.

Expand the IIO events support, enabling IIO drivers to provide event
interfaces that handle values in real-world units.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/iio/industrialio-event.c | 47 +++++++++++++++++++++++---------
 include/linux/iio/iio.h          |  8 ++++--
 include/uapi/linux/iio/types.h   |  5 ++++
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 06295cfc2da8..68bba21cae14 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -258,6 +258,11 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_RUNNING_COUNT] = "runningcount",
 };
 
+static const char * const iio_ev_unit_text[] = {
+	[IIO_EV_UNIT_RAW] = "raw",
+	[IIO_EV_UNIT_PROCESSED] = "input",
+};
+
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
 {
 	return attr->c->event_spec[attr->address & 0xffff].dir;
@@ -273,6 +278,11 @@ static enum iio_event_info iio_ev_attr_info(struct iio_dev_attr *attr)
 	return (attr->address >> 16) & 0xffff;
 }
 
+static enum iio_event_unit iio_ev_attr_unit(struct iio_dev_attr *attr)
+{
+	return attr->c->event_spec[attr->address & 0xffff].unit;
+}
+
 static ssize_t iio_ev_state_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf,
@@ -332,7 +342,7 @@ static ssize_t iio_ev_value_show(struct device *dev,
 	ret = indio_dev->info->read_event_value(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
-		&val, &val2);
+		iio_ev_attr_unit(this_attr), &val, &val2);
 	if (ret < 0)
 		return ret;
 	val_arr[0] = val;
@@ -359,7 +369,7 @@ static ssize_t iio_ev_value_store(struct device *dev,
 	ret = indio_dev->info->write_event_value(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
-		val, val2);
+		iio_ev_attr_unit(this_attr), val, val2);
 	if (ret < 0)
 		return ret;
 
@@ -384,7 +394,8 @@ static ssize_t iio_ev_label_show(struct device *dev,
 static int iio_device_add_event(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int spec_index,
 	enum iio_event_type type, enum iio_event_direction dir,
-	enum iio_shared_by shared_by, const unsigned long *mask)
+	enum iio_event_unit unit, enum iio_shared_by shared_by,
+	const unsigned long *mask)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
@@ -399,15 +410,23 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
 	for_each_set_bit(i, mask, sizeof(*mask)*8) {
 		if (i >= ARRAY_SIZE(iio_ev_info_text))
 			return -EINVAL;
-		if (dir != IIO_EV_DIR_NONE)
-			postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
-					iio_ev_type_text[type],
-					iio_ev_dir_text[dir],
-					iio_ev_info_text[i]);
-		else
+		if (dir != IIO_EV_DIR_NONE) {
+			if (i == IIO_EV_INFO_ENABLE)
+				postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
+						iio_ev_type_text[type],
+						iio_ev_dir_text[dir],
+						iio_ev_info_text[i]);
+			else
+				postfix = kasprintf(GFP_KERNEL, "%s_%s_%s_%s",
+						iio_ev_unit_text[unit],
+						iio_ev_type_text[type],
+						iio_ev_dir_text[dir],
+						iio_ev_info_text[i]);
+		} else {
 			postfix = kasprintf(GFP_KERNEL, "%s_%s",
 					iio_ev_type_text[type],
 					iio_ev_info_text[i]);
+		}
 		if (postfix == NULL)
 			return -ENOMEM;
 
@@ -478,32 +497,34 @@ static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
 	int ret = 0, i, attrcount = 0;
 	enum iio_event_direction dir;
 	enum iio_event_type type;
+	enum iio_event_unit unit;
 
 	for (i = 0; i < chan->num_event_specs; i++) {
 		type = chan->event_spec[i].type;
 		dir = chan->event_spec[i].dir;
+		unit = chan->event_spec[i].unit;
 
-		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
+		ret = iio_device_add_event(indio_dev, chan, i, type, dir, unit,
 			IIO_SEPARATE, &chan->event_spec[i].mask_separate);
 		if (ret < 0)
 			return ret;
 		attrcount += ret;
 
-		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
+		ret = iio_device_add_event(indio_dev, chan, i, type, dir, unit,
 			IIO_SHARED_BY_TYPE,
 			&chan->event_spec[i].mask_shared_by_type);
 		if (ret < 0)
 			return ret;
 		attrcount += ret;
 
-		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
+		ret = iio_device_add_event(indio_dev, chan, i, type, dir, unit,
 			IIO_SHARED_BY_DIR,
 			&chan->event_spec[i].mask_shared_by_dir);
 		if (ret < 0)
 			return ret;
 		attrcount += ret;
 
-		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
+		ret = iio_device_add_event(indio_dev, chan, i, type, dir, unit,
 			IIO_SHARED_BY_ALL,
 			&chan->event_spec[i].mask_shared_by_all);
 		if (ret < 0)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 872ebdf0dd77..82d0a30e443f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -156,6 +156,7 @@ typedef const struct iio_mount_matrix *
  * struct iio_event_spec - specification for a channel event
  * @type:		    Type of the event
  * @dir:		    Direction of the event
+ * @unit:		    Unit of the data to be handled (raw or processed).
  * @mask_separate:	    Bit mask of enum iio_event_info values. Attributes
  *			    set in this mask will be registered per channel.
  * @mask_shared_by_type:    Bit mask of enum iio_event_info values. Attributes
@@ -169,6 +170,7 @@ typedef const struct iio_mount_matrix *
 struct iio_event_spec {
 	enum iio_event_type type;
 	enum iio_event_direction dir;
+	enum iio_event_unit unit;
 	unsigned long mask_separate;
 	unsigned long mask_shared_by_type;
 	unsigned long mask_shared_by_dir;
@@ -522,13 +524,15 @@ struct iio_info {
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir,
-				enum iio_event_info info, int *val, int *val2);
+				enum iio_event_info info,
+				enum iio_event_unit unit, int *val, int *val2);
 
 	int (*write_event_value)(struct iio_dev *indio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
 				 enum iio_event_direction dir,
-				 enum iio_event_info info, int val, int val2);
+				 enum iio_event_info info,
+				 enum iio_event_unit unit, int val, int val2);
 
 	int (*read_event_label)(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 6d269b844271..4898444deb9e 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -137,4 +137,9 @@ enum iio_event_direction {
 	IIO_EV_DIR_FAULT_OPENWIRE,
 };
 
+enum iio_event_unit {
+	IIO_EV_UNIT_RAW,
+	IIO_EV_UNIT_PROCESSED,
+};
+
 #endif /* _UAPI_IIO_TYPES_H_ */
-- 
2.51.0


