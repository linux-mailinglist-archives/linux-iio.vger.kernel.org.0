Return-Path: <linux-iio+bounces-13555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465A99F3AF8
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 21:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FBF168C61
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 20:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE211D5CE5;
	Mon, 16 Dec 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c9VwpDWb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922B1D5175
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381476; cv=none; b=D+CyDh7zNWcss9iR+NtFFj0VszD6VwmouKANd0bqeNNtlWlStx7Kp0OFUxVZp8FX3cU4TX/ws5eFM9T5jgI6mVtdNX2Yql6mvOH4sHSThpCP5yMtx/Y9sGwRcov0E48KQsvl4JiHr/lC45Dp1t4WBKIrlkmk4OTG5w/kFYK+nys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381476; c=relaxed/simple;
	bh=HBhpT3Z8kNizKOdmkqpshRkGlYEe3CV+4avHxoYClXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iE5AXfGEjZtCVgIrM9gjLqnIJ4FJTjb/SCgE2CopVxC5PoklzZjuNuNy74X4QDqzKr3qhW6DIUa0eIemazRC3GbPWS1rlfT0gsRanuzHPRxRGqRpx4UbO5urS8Mq6eRNXootA2NAttZC9/Bwwh5XOTbHO+uEIf7dEllIxVaArm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c9VwpDWb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso2205759f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381472; x=1734986272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT+yZp7KZfeuF1pQSOvhA42qjXkxkwlrh5Rhv7qAP/A=;
        b=c9VwpDWbDJWVMuXumBtkQZzo7gBBb/ctMmi9jDEZRiBSZvjHShFVRbmBosLv0dYq0l
         6ii+C6w+GmTCb2fkyM7U7s7y/31TnQq9qyVpFenBCzNHnNl0OvjT1T33OkFujevPsbSd
         mV+KuVEZLGeR6iANnQtkLwrDPj3LLaIxaw3c3J2/uvJxcZkZKsT18BSQCLZp3QiUtDBx
         EwGUMP+mworbyzPyHKTxXKoVExJuNKkyrLIy03+3pNMUPM64TOToeTkbAS7Fs0tSdWPg
         ivjxYRdpnemTJ8D19WoA9zoIai792gzKDIWfb/1hY7Wj21U3yOBz7Ip8qkgxbra2M4Ha
         TdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381472; x=1734986272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nT+yZp7KZfeuF1pQSOvhA42qjXkxkwlrh5Rhv7qAP/A=;
        b=KEsWwvIHsNBnCnyFynun6LaYuQGeANYFGe9gR5gbLlVaf7MRLFfG1Imr8XS1R9p9ux
         R8x3ui6Dz6kdAIkm8Q932AinmNDuXtKA2pPyh0sycQDgsemLdsZjMf3SMd0rBGfDQ0zz
         xctfFJfeeu83UUczOK/MGlc2/BfryEi4nHTEwD56eG2GWWe9AxkwB6itQUR58hWTNWoA
         XoFJ5GrlMOi/+aNrpHYcVSjZhfRFqKFNJixCS/OGbZodBV55lJ8jnkFWrA/2Rk/++k+R
         66ZvP12RNVOiXzB05KGQEwmP7ifw15wp3GA6iXHtSoZxZvb9spVjzfjbpCMuPc0xFm92
         5dEw==
X-Forwarded-Encrypted: i=1; AJvYcCXpXfsAq9MqPKgn4UhdQI3n3nZUqqJipKOXn/nTxnc/xQ8yFI1F0aRZxI4eR48nYwMw1b/fNBEW41Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13+g9sxc8vWoOXDkw7XQl3EeYA3TfuMh2v6cE0ariWmVjx5U9
	2cbdRlHyhRX0fv9vwVXl+zC9eCmr0O3m1D9B+DvVR7Heexs9toRkL2OfJHterdo=
X-Gm-Gg: ASbGncs2HcspjrKSxOGE0z591rE6FrNcnmEse3WgiK7cSxNHyEVYgZRGmsh5loltJup
	KOuxfpxRsND/l9czjDXUONL4YhV352pp9/o+2e0hJmVqdkUKqykM/IRJ8ETUKrLCFrgFxjcNVFl
	tjZSnZ49uUUa3YvYQsK3D7a8zrmLSv/K1qhaxflnJsOLqIcblIYEI7+/OeqzNne9PgoRWiYOB6Q
	gVPbYCd2wMPmnxtJI5O7vWZnCj11cT9w3uy8ynDx3+XvfxJTrmaILV9saYkzI/4dS3F9kOO3Aab
	AANbdssZBdVZBEnYyLy6Od0b6CAlnoGLtg==
X-Google-Smtp-Source: AGHT+IFh1mJdBHrzlKMOog2KpSvIJzAt0K5JQgDX1J3pNUMf3BCekFbjJ2X7kYCo0/FSmtvehX8QUw==
X-Received: by 2002:a05:6000:144a:b0:385:f7ef:a57f with SMTP id ffacd0b85a97d-38880ad9591mr11709434f8f.27.1734381472520;
        Mon, 16 Dec 2024 12:37:52 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:51 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:24 +0100
Subject: [PATCH 4/8] iio: backend: add API for interface configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-4-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>
X-Mailer: b4 0.14.1

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

Add backend support for setting and getting the interface type
in use.

Link: https://lore.kernel.org/linux-iio/20241129153546.63584-1-antoniu.miclaus@analog.com/T/#m6d86939078d780512824f1540145aade38b0990b
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
This patch has been picked up from the Antoniu patchset
still not accepted, and extended with the interface setter,
fixing also namespace names to be between quotation marks.
---
 drivers/iio/industrialio-backend.c | 42 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        | 19 +++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 363281272035..6edc3e685f6a 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -636,6 +636,48 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_interface_type_get - get the interface type used.
+ * @back: Backend device
+ * @type: Interface type
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_interface_type_get(struct iio_backend *back,
+				   enum iio_backend_interface_type *type)
+{
+	int ret;
+
+	ret = iio_backend_op_call(back, interface_type_get, type);
+	if (ret)
+		return ret;
+
+	if (*type >= IIO_BACKEND_INTERFACE_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
+
+/**
+ * iio_backend_interface_type_set - set the interface type used.
+ * @back: Backend device
+ * @type: Interface type
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_interface_type_set(struct iio_backend *back,
+				   enum iio_backend_interface_type type)
+{
+	if (type >= IIO_BACKEND_INTERFACE_MAX)
+		return -EINVAL;
+
+	return  iio_backend_op_call(back, interface_type_set, type);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_set, "IIO_BACKEND");
+
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 10be00f3b120..2b7221099d8c 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -70,6 +70,15 @@ enum iio_backend_sample_trigger {
 	IIO_BACKEND_SAMPLE_TRIGGER_MAX
 };
 
+enum iio_backend_interface_type {
+	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
+	IIO_BACKEND_INTERFACE_SERIAL_CMOS,
+	IIO_BACKEND_INTERFACE_SERIAL_SPI,
+	IIO_BACKEND_INTERFACE_SERIAL_DSPI,
+	IIO_BACKEND_INTERFACE_SERIAL_QSPI,
+	IIO_BACKEND_INTERFACE_MAX
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -88,6 +97,8 @@ enum iio_backend_sample_trigger {
  * @extend_chan_spec: Extend an IIO channel.
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
+ * @interface_type_get: Interface type.
+ * @interface_type_set: Interface type setter.
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
@@ -128,6 +139,10 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*interface_type_get)(struct iio_backend *back,
+				  enum iio_backend_interface_type *type);
+	int (*interface_type_set)(struct iio_backend *back,
+				  enum iio_backend_interface_type type);
 	int (*read_raw)(struct iio_backend *back,
 			struct iio_chan_spec const *chan, int *val, int *val2,
 			long mask);
@@ -186,6 +201,10 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 				 const char *buf, size_t len);
 ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
+int iio_backend_interface_type_get(struct iio_backend *back,
+				   enum iio_backend_interface_type *type);
+int iio_backend_interface_type_set(struct iio_backend *back,
+				   enum iio_backend_interface_type type);
 int iio_backend_read_raw(struct iio_backend *back,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask);

-- 
2.47.0


