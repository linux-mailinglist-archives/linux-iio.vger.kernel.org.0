Return-Path: <linux-iio+bounces-10860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A59B9A68DC
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14852B29702
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D91F80AF;
	Mon, 21 Oct 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dov83Iu2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D71F4FDA
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514502; cv=none; b=ALJ9F1sSVJXJLLNojoczDyNCV9RQg8DeGdcPmmJcYlx1gdcpaJZpWyFu6oVCf0Ik4jybouICB/nPmgc0Esi2VAsfcpLACiIwIxuVUn40EROLbqj2045+BeOZi6HejeVd1/ePhbHPQEOtsOhEwnGbLP8v0GRZ+clEgZcB+j9eHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514502; c=relaxed/simple;
	bh=I2hKyJkE5lSaVfqcBggLmA5y3mTRzqksloo07yQRvt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcEFAcPNxo3tsMOoYz+SOKeVwUT8/fVZIoxabrnYvWeeAukNOD9FAa7dNVlUzXqB80Go/il2WgNyLD7eAAhr/Y1FsuGHqHaVoKvIp5iJkjWcL129Z3hPc+0yLgckB4xhcRTwcXuVcHhDHVQXCWnVc3FgHASPjhTFWcMOxgISWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dov83Iu2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso43687605e9.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729514498; x=1730119298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXD9nM+zJf+baf8I1HJHQEo8iyVRn909PphK3Jj4Bu4=;
        b=dov83Iu2gQDWacLj+0AvswVilfkV4lTlMBaIc0wrl+4gjDjRkE2q4mn2oD+szhAf6Z
         kFpiCS5dTDYbv/4H0E6IfqF+xiW78xhCGVlWJoJaLmzdwS0Kt2x+WprOPgcA6xzhJQ1k
         ZgSBd88An7et4BRvJH5f1FXjsItoVqPKyFHJrROw52NPoKtDV6BPlskojapX/lI6XO5q
         jGznXv9giYSEaPUGdI46MLzMjsllqpUIim9DyywiYMaSwtCwyf/K3kjHPr/vq8IpEk3h
         c9ycW3UoIFlp7Zz18Fv5bClRnOGuEIU3KI5F4J86lVDshPm804zR/f2eJP75XAzWzlPP
         wDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514498; x=1730119298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXD9nM+zJf+baf8I1HJHQEo8iyVRn909PphK3Jj4Bu4=;
        b=GhFuBG8DiU5vKSmL0LMV31h54Lgm3cDP+BMmGY0QJdOsQHm2w+U8C6QboTSepKy20p
         16T9TEQieiwak9jRfuMbQat2aw9hT/Egbj5rFbdVqrlBVsMPYvaZqTWX/lYXhtlG2S8h
         GaMHczFkUpe6mcFKFgFDJPWyLfzzCL3ipUIP6s8ry0a/yKpDDxzSdAUiAeUMfNnvxDMB
         +Rs2Zmm68HeVxjfg1oePo3hCPf0HokpvPVBqwbXx7VFrmVhWbuSMXqUYwn0bNsctG5n5
         YN3nCWTl+MQmCSMvrMeSN2mBKK6FplDFy0pi+TVtBegRMCJyWDHTa37Y/7qS8iO3VMlR
         +iLQ==
X-Gm-Message-State: AOJu0Yze/e48qXnLMdICP6Vu55qURLpRCscDE5MWVzQgBtbupzRUvCpi
	p4Lf+OaMva95FMtuZAj3HehiOVnq8o/pBHEoTs0eeMfZshJ9N1TYKMXaTXfZ7FY=
X-Google-Smtp-Source: AGHT+IF1TlFjb1F5KKfdr7S+M3gyE6IP3VNfcSwU6GUM3TN3he7rJaGKw2CRp8M6y8MWEl04HZXA8A==
X-Received: by 2002:a05:600c:4f42:b0:431:44fe:fd9f with SMTP id 5b1f17b1804b1-431616a3ac4mr87764155e9.23.1729514497737;
        Mon, 21 Oct 2024 05:41:37 -0700 (PDT)
Received: from [127.0.1.1] (host-82-61-199-210.retail.telecomitalia.it. [82.61.199.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc88esm55996075e9.46.2024.10.21.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:41:37 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 21 Oct 2024 14:40:13 +0200
Subject: [PATCH v7 3/8] iio: backend: extend features
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-3-969694f53c5d@baylibre.com>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
In-Reply-To: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Extend backend features with new calls needed later on this
patchset from axi version of ad3552r.

The follwoing calls are added:

iio_backend_ddr_enable()
	enable ddr bus transfer
iio_backend_ddr_disable()
	disable ddr bus transfer
iio_backend_data_stream_enable()
	enable data stream over bus interface
iio_backend_data_stream_disable()
	disable data stream over bus interface
iio_backend_data_transfer_addr()
	define the target register address where the DAC sample
	will be written.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/industrialio-backend.c | 78 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        | 17 +++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 20b3b5212da7..81f3d24f0c50 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -718,6 +718,84 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
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
+ * iio_backend_data_stream_enable - Enable data stream
+ * @back: Backend device
+ *
+ * Enable data stream over the bus interface.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_stream_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, data_stream_enable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_stream_enable, IIO_BACKEND);
+
+/**
+ * iio_backend_data_stream_disable - Disable data stream
+ * @back: Backend device
+ *
+ * Disable data stream over the bus interface.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_stream_disable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, data_stream_disable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_stream_disable, IIO_BACKEND);
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
index 37d56914d485..10be00f3b120 100644
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
+ * @data_stream_enable: Enable data stream.
+ * @data_stream_disable: Disable data stream.
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
+	int (*data_stream_enable)(struct iio_backend *back);
+	int (*data_stream_disable)(struct iio_backend *back);
+	int (*data_transfer_addr)(struct iio_backend *back, u32 address);
 };
 
 /**
@@ -164,6 +176,11 @@ int iio_backend_data_sample_trigger(struct iio_backend *back,
 int devm_iio_backend_request_buffer(struct device *dev,
 				    struct iio_backend *back,
 				    struct iio_dev *indio_dev);
+int iio_backend_ddr_enable(struct iio_backend *back);
+int iio_backend_ddr_disable(struct iio_backend *back);
+int iio_backend_data_stream_enable(struct iio_backend *back);
+int iio_backend_data_stream_disable(struct iio_backend *back);
+int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address);
 ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan,
 				 const char *buf, size_t len);

-- 
2.45.0.rc1


