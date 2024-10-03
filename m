Return-Path: <linux-iio+bounces-10068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C87098F52A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A564B1C2145E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5441AAE00;
	Thu,  3 Oct 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pxBtbn5+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB01AC428
	for <linux-iio@vger.kernel.org>; Thu,  3 Oct 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976644; cv=none; b=K/gNzf0UbhZgXDHZ+q+acR2EA9jRcGSFwDtk0Rsq+GxPYGkQ54GHdY471cV/8PXMcTHBgmFjfNjZmCVAPUTicx+UFC/9yFwu1PDGyUh96736xiirbfyyEPQk0hPo8gekzNsz6DMBMI5cpQ7aWJY7hyItS/wJ05f2IOSoU0QptPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976644; c=relaxed/simple;
	bh=bEcKiskLCb0FkIzpcuK+l+XVpvdNI8jh3Jam2eFvAh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TiAkIOd/d/zrBPRo2v09rVBQfdGogzYgqXUZ4/erjf5f6RUlPU+Ilf7fuj/ad9wgwpVmaJxS273scaqmpe2bxULHzhLFhXctq+4Fgn0wXNncXGVeEUrXfLRSYBzMiaZCI0OEuq0UIDa0jdil0hL3ispFPWqEuvipeQW4RLZbbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pxBtbn5+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cfa129074so955295f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 03 Oct 2024 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727976641; x=1728581441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahc2no+Czxl/YZN9o92085Arjh+KOagBu91zDuvSs8o=;
        b=pxBtbn5+EwQ4imi69Ec2aKxrZhpiQvRdJkJ99wkA1WuCZjCUDvypX7/Hi9pz9mY7Ju
         Kimh5V0N3XW5kzVCkivwNNNK5Baq05WfxU3FCZZNCZsw0bwnw07ee6H5GCKmKg2ekYBl
         shlYAXLiH6C9x+Wgh95WhybEUh04NIGENZub7B9uQgC49tDDB5sYrJP0SoenMPYxHwER
         S18Q9a6kSlISOVexM3exrLU0ZdS2SxENTL0xlSP7DlcVJNZSlWv6lyRtPDOSvov8J5lU
         0LXJMwU+JQLkLibk9F/EiM5XYT8Hw5vq8rAC2HiKz77k6FUbDSLOyf6e0OfkB/wkWV+b
         lnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976641; x=1728581441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahc2no+Czxl/YZN9o92085Arjh+KOagBu91zDuvSs8o=;
        b=V7ntTGFo0wG3r0SFklcr3Pf33XUc0lrrx9tPBOtewYiztTPH5+CvpWaA+JAjsaAJFN
         /dGgikYsSURzmgeshdOMlH9MyX0RhUyudE/QLzgyI3x7RAkD+hXMfQA5+7z4nXQgWmGr
         yEMvNnq6WRAFW7Vtg7ynnQhmJIhIJXof336nQTXUM9aHP0hNx/o1LL+6YGUnY5BhePgD
         QqeQZpa/r4AayLxTGpl4QHYqbZgWrp5KrTW2uFQiAD3HmT9H2Hn56r1EYBF42YHoU8xI
         e7RztgbKYu4opNIMfm01ueJnez0HVtnQ4TTmSqHblnXoQfd9hpOY23Ry9IvISYY4NJXN
         tzIw==
X-Gm-Message-State: AOJu0Yy+ksf2Dz8iMFXhs7Lp6v5/JsFxQH1BZMBK9aErjfyxFkNmt35H
	X6Rvp4VXzljD6mCdZzS7zNEBKusNb7JdvIBY0lPN5mOxXd5ARormA3JnpepKZVY=
X-Google-Smtp-Source: AGHT+IEewgd55xc+/qtBafOETjMt6cJ/QeE2v2xOF5AyvEdbEKtCOKrlt2nynwErRNbUgBMWa+qwNA==
X-Received: by 2002:adf:f54f:0:b0:37c:cd64:939c with SMTP id ffacd0b85a97d-37d0e8de830mr91832f8f.44.1727976640638;
        Thu, 03 Oct 2024 10:30:40 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d116asm1703735f8f.90.2024.10.03.10.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:30:39 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 03 Oct 2024 19:29:03 +0200
Subject: [PATCH v4 06/11] iio: backend: extend features
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-6-ceb157487329@baylibre.com>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, 
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Extend backend features with new calls needed later on this
patchset from axi version of ad3552r.

The follwoing calls are added:

iio_backend_ddr_enable
	enable ddr bus transfer
iio_backend_ddr_disable
	disable ddr bus transfer
iio_backend_buffer_enable
	enable buffer
iio_backend_buffer_disable
	disable buffer
iio_backend_data_transfer_addr
	define the target register address where the DAC sample
	will be written.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/industrialio-backend.c | 79 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        | 17 ++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 20b3b5212da7..d5e0a4da761e 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -718,6 +718,85 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
 	return 0;
 }
 
+/**
+ * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
+ * @back: Backend device
+ *
+ * Enable DDR, data is generated by the IP at each front (raising and falling)
+ * of the bus clock signal.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_ddr_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, ddr_enable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_enable, IIO_BACKEND);
+
+/**
+ * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate) mode
+ * @back: Backend device
+ *
+ * Disable DDR, setting into SDR mode (Single Data Rate).
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_ddr_disable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, ddr_disable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
+
+/**
+ * iio_backend_dma_stream_enable - Enable iio buffering
+ * @back: Backend device
+ *
+ * Enabling sending the dma data stream over the bus.
+ * bus interface.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_dma_stream_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, dma_stream_enable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_dma_stream_enable, IIO_BACKEND);
+
+/**
+ * iio_backend_dma_stream_disable - Disable iio buffering
+ * @back: Backend device
+ *
+ * Disable sending the dma data stream over the bus.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_dma_stream_disable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, dma_stream_disable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_dma_stream_disable, IIO_BACKEND);
+
+/**
+ * iio_backend_data_transfer_addr - Set data address.
+ * @back: Backend device
+ * @address: Data register address
+ *
+ * Some devices may need to inform the backend about an address
+ * where to read or write the data.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address)
+{
+	return iio_backend_op_call(back, data_transfer_addr, address);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr, IIO_BACKEND);
+
 static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
 							 struct fwnode_handle *fwnode)
 {
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 37d56914d485..990efdc47b1f 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -14,12 +14,14 @@ struct iio_dev;
 enum iio_backend_data_type {
 	IIO_BACKEND_TWOS_COMPLEMENT,
 	IIO_BACKEND_OFFSET_BINARY,
+	IIO_BACKEND_DATA_UNSIGNED,
 	IIO_BACKEND_DATA_TYPE_MAX
 };
 
 enum iio_backend_data_source {
 	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
 	IIO_BACKEND_EXTERNAL,
+	IIO_BACKEND_INTERNAL_RAMP_16BIT,
 	IIO_BACKEND_DATA_SOURCE_MAX
 };
 
@@ -89,6 +91,11 @@ enum iio_backend_sample_trigger {
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
+ * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
+ * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
+ * @dma_stream_enable: Enable DMA data stream.
+ * @dma_stream_disable: Disable DMA data stream.
+ * @data_transfer_addr: Set data address.
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -129,6 +136,11 @@ struct iio_backend_ops {
 					 size_t len);
 	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int reg,
 				  unsigned int writeval, unsigned int *readval);
+	int (*ddr_enable)(struct iio_backend *back);
+	int (*ddr_disable)(struct iio_backend *back);
+	int (*dma_stream_enable)(struct iio_backend *back);
+	int (*dma_stream_disable)(struct iio_backend *back);
+	int (*data_transfer_addr)(struct iio_backend *back, u32 address);
 };
 
 /**
@@ -164,6 +176,11 @@ int iio_backend_data_sample_trigger(struct iio_backend *back,
 int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_backend *back,
 				    struct iio_dev *indio_dev);
+int iio_backend_ddr_enable(struct iio_backend *back);
+int iio_backend_ddr_disable(struct iio_backend *back);
+int iio_backend_dma_stream_enable(struct iio_backend *back);
+int iio_backend_dma_stream_disable(struct iio_backend *back);
+int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address);
 ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan,
 				 const char *buf, size_t len);

-- 
2.45.0.rc1


