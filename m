Return-Path: <linux-iio+bounces-10556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C5D99C6CC
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 12:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CD71F23F37
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB7D17C990;
	Mon, 14 Oct 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dMlkLiEH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E7165F1D
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900584; cv=none; b=nGij5+6vvu/a7KdBE4VvTW/XP7NXAkboE/esdBjrb/eBQFQ2NcKkmkHIvlUQgbn4WlmC1YjjePki0gCRLH5ZDgBtmfrMYYrPl8flf4/ZMfQ3lCM3BA4sKArxF0YYPWPdLXmxGENvNAiJzqjLs6hvbkAXWaYeZdtuyvurt8i62mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900584; c=relaxed/simple;
	bh=I2hKyJkE5lSaVfqcBggLmA5y3mTRzqksloo07yQRvt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCP9XSEKnlbwNrH6RCeixskSVpf2RJ85OYaQ5suNUv3AblQ8K0lhFx7mkON2b1WWpZniG01D2DCrxcXtAc2e+Nyq+F9X5ZowrQqmsA1CJ3vedlFzmKdf0luDr/RuaZRSpek6uCSPpnIHFyM14Zlgm4xAjNpc9l655S0dV/ugyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dMlkLiEH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so788614f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728900579; x=1729505379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXD9nM+zJf+baf8I1HJHQEo8iyVRn909PphK3Jj4Bu4=;
        b=dMlkLiEHSDR0zyMuOpO1LL8Jc2QdRkZXqFzJeGnh0cWQG1N92yK3J0EeSoLed5cRnF
         OOZrUHgHU/nbWaHd3+D/IcxQirbG1cUBmJf4+7NUYvRwHsIL3e6zgz7QRwp5CYNonoOZ
         QNgVa7XzrJp47HKTzIbbD07izT+uqVjNtGADtOai4X9Kq+FobohTXi11KRjEASLqr64W
         Gb8/aGSWGJOdY24rN5VVMvvgtiKiW+LVYdem3wRxXeBY7hnhZ3UpHQwsppSOT3O5377h
         PtG0xJmsee7qJ5nD/BxA0qxPAesSnEBMfFKc/tmioap1pzAndJdm2OlttNukx5jeMVUu
         5lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900579; x=1729505379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXD9nM+zJf+baf8I1HJHQEo8iyVRn909PphK3Jj4Bu4=;
        b=hdUBfS4Fjl7+BuWkrnMGidJQcellTSI6qvXq5Iojz731mYwrjjQ3xZATrWzGiyx0TN
         pkTJ43BA0e1eCWhRkp0xoel7B6oABidtd4dn9RyW5QuPspKM8iFUtOkeLpXdklaHPAmH
         /91yZTjajGy9R52GVKqIcLmRXi6BmUxtf6flIvsxsdqZItqhmx51nPTM/x86lLclgyPT
         PLXAs3orAlR9/zFQQ3cNiBHwj1kjqKZBRtSuRPwEaApeti5vXfpS4LpP4dQQ98i64cHv
         o5ThdzvnQdMuxhTm8dE17f8pbprMsuNnMxrW7KhtCCLFQceBTiQWoEwyB5SUrUbYyeT7
         swWg==
X-Gm-Message-State: AOJu0YzHpXa9khHiCa/cfs71xjn+w1tfVzOMX4r80nXFG+zLXfkjoefT
	r5GmarsSJBprTe2t26DdmhbRSxB/aS/tn+DCAqL3cm9GDHZeuUUra1TdeQa2lYg=
X-Google-Smtp-Source: AGHT+IGSmgW6o07g4/8KAQfgtWH+HRp7++ZxjpoMsivKqGSwcc5AMgDayQqpF4/0Y+ilgr/D0dfuNg==
X-Received: by 2002:a5d:4d8c:0:b0:374:bd48:fae9 with SMTP id ffacd0b85a97d-37d5ff2a6fbmr5815490f8f.20.1728900579364;
        Mon, 14 Oct 2024 03:09:39 -0700 (PDT)
Received: from [127.0.1.1] (host-79-45-239-138.retail.telecomitalia.it. [79.45.239.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee0afsm10969352f8f.102.2024.10.14.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 03:09:38 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 14 Oct 2024 12:08:09 +0200
Subject: [PATCH v6 3/8] iio: backend: extend features
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-3-eeef0c1e0e56@baylibre.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
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


