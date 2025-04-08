Return-Path: <linux-iio+bounces-17807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CCBA7FC01
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6493B64DB
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A99268C65;
	Tue,  8 Apr 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X3WEjOF5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E9267F7B
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107622; cv=none; b=NM1VZ8X3jNgeGzofx5Olw4Dr5mNxF0lfsOZp9zmjLOIeRiQIbQFicY+rQ/MI6veyEf41BogoHfOn6zpUxJoM9Y6XOMETea0j1X0EG/dBU9G4VQ2Naar1cuc27A86qXMfG89Cyx1bi5FuTy7d+J3eLgcowqVKZXc8LjaLOymAEHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107622; c=relaxed/simple;
	bh=lgsAI1C4GJ9f/lxYOr2FZ5rkqth02XBYIH8GiAkKCgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvgkQwjEVE8MMEyC70s4zq51acKzOyjWfxavtCx2weeAmK++K4e+VoHj1N5ZxT2NlNIJG+e181e+kkC+GLwHuIhCsLUNV7f8yIIhuXf0h/t0T9d2syA2kHUatlQx1EJuACZxWlQOL9tRqL1DSDnKIN0K16INkc48pvr1GfIBw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X3WEjOF5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39727fe912cso2342504f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744107617; x=1744712417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYLrYCRZJaz3Q9z9V56+5pPJKQA4s8QRrtBGVRh2868=;
        b=X3WEjOF5Q1YCT3wxvcOsbRSmVJzWjIrRGi/Q1sqnAEicm1G3sigx0vKU9Abz+54YOp
         1U4wj5BWcmB7PNm0fRt2BwyDGcJYAu0Wkof2tIV303kZKbbt4jh46yVVA5VXTcP0b6/S
         qsdSHr1boNDKWUpsBTZQCDFrs3STf8j8Sfop0Y8m/hT8wooRO4E+p/FNxo5YXpgkcrLV
         jcoZCaW10pxYE9Rw00VSgxqGnEwULDV++SzFXmOLEF3radfrE27SH51Z3YwaDq2MQwpE
         pmKYiMA8yECMGMRum5PDyWNWCysw0I7UPFP7i5j6M7fmQCUG9gVcGskkwccAL7I5ZxWu
         l2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107617; x=1744712417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYLrYCRZJaz3Q9z9V56+5pPJKQA4s8QRrtBGVRh2868=;
        b=hAeVZl4ZWJT08GNIPGBNuyojC0VU6Q3G4u3rkuaQQjlJfV2pQWulJ2UWYZBBTXU6nx
         SLGC1XvUj75Vz9UA8Pz3zawE2NSaNTsnkA+0nARB9vkWm7ZMjdv+BGZy3Deo55J4g0mm
         jeKYuZyxMcRjsl4xpfBBJYJJlVIoj7itR9uP7M6pGdwQpFgUhk2fSWNs1LUhlnin4ST1
         ZApG2QufbdmfTZ6WKeE+mhya82gfJitLn2TbsS+MtIpaaGyrL1PvZVUCBIgbLiefx4X3
         SxgaIzSHenNh4TU9Ji0OfpHwXRRWywmFYrAwCHgLPurj26Ou+DiyG0nu74lOCWsUn6LA
         boLA==
X-Gm-Message-State: AOJu0YzQfI2aaRQfZu0BPeJ+4aDP1bLPK7LLANoQO1YUZEh53K48Qo1D
	GEeavvk1AHYICTp553NQ+wDAWJRE2ijnWx29J4Y+c7sMNMkVRCD1C93rd8v1PgZjjOhErlb9Z7a
	q
X-Gm-Gg: ASbGncvdXcw7yE3XRhkXRXT2THljNwmDRJ9fMCkm4EaXaKZPYH8kLyW22ug9WupkTn3
	adBOuIAqeAuJztjuZrvJXPQgyIHIa0f/CY+UAFPDl3kJ2thQ6YYeWx8/qyVl+joAdwD/3z55tGo
	30UheIMZCZ1rA5j8iGBBLzCBnmbOSH6g0Zdbcl0M8LvEzNg0RdWrl+ldq4RFe2SWVpsAJW+HbC7
	aXBbg3D9ZHuwlKkqxRJa+yqoGy9zW6VGFEjlxOyT0Tf/7X8wcLhMXmqzRlO+eQeIRmTnxCWkvKe
	Yt1ZXFtrXzb6hJQHTjPhdtWYrvwLPZFtlw9QKrHZm/yZCmDAl+nMhCTHK+g1KRsboDm5Cfspett
	mNtXNHNir7xDXBh7YXL3HLg==
X-Google-Smtp-Source: AGHT+IGxgp39FjNPJEbArAS3WynvmgHVgFnW8e0TESe1VHTjuSvvOXJpuMeA42affgvOD3UXCRT7NQ==
X-Received: by 2002:a05:6000:290b:b0:391:300f:7474 with SMTP id ffacd0b85a97d-39d6fc291bemr8609128f8f.18.1744107617207;
        Tue, 08 Apr 2025 03:20:17 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d7c6d838bsm4396138f8f.69.2025.04.08.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:20:16 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 08 Apr 2025 12:18:53 +0200
Subject: [PATCH v4 3/5] iio: backend: add support for data source get
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250408-wip-bl-ad3552r-fixes-v4-3-b33c0264bd78@baylibre.com>
References: <20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com>
In-Reply-To: <20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=2lP6oKpb0hmzBUffbG/vd1ZR0rWtSFsiZRG8+MHxxuM=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/8kPI5UatbjprZUaeTtvfZUYiSee7OzwtRD3D9gQus
 ej3+Hymo5SFQYyLQVZMkaUuMcIk9HaolPICxtkwc1iZQIYwcHEKwET4zzAyHHn5SVrd8Q2bmc3z
 G+8+/LmxckLQp6fO/OITo7KYjc9fe8vw3831U5NsifpytkD93u07+Vd/yvqrrvOKe+n+mbHLipS
 WsQIA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add backend support for getting the data source used.

The ad3552r HDL implements an internal ramp generator, so adding the
getter to allow data source get/set by debugfs.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/industrialio-backend.c | 28 ++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index a43c8d1bb3d0f4dda4277cac94b0ea9232c071e4..c1eb9ef9db08aec8437d0d00cf77914ad6611b72 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -380,6 +380,34 @@ int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_source_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_data_source_get - Get current data source
+ * @back: Backend device
+ * @chan: Channel number
+ * @data: Pointer to receive the current source value
+ *
+ * A given backend may have different sources to stream/sync data. This allows
+ * to know what source is in use.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_source_get(struct iio_backend *back, unsigned int chan,
+				enum iio_backend_data_source *data)
+{
+	int ret;
+
+	ret = iio_backend_op_call(back, data_source_get, chan, data);
+	if (ret)
+		return ret;
+
+	if (*data >= IIO_BACKEND_DATA_SOURCE_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_source_get, "IIO_BACKEND");
+
 /**
  * iio_backend_set_sampling_freq - Set channel sampling rate
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index e45b7dfbec35c094942a3034fc6057a7960b9772..e59d909cb65924b4872cadd4b7e5e894c13c189f 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -84,6 +84,7 @@ enum iio_backend_interface_type {
  * @chan_disable: Disable one channel.
  * @data_format_set: Configure the data format for a specific channel.
  * @data_source_set: Configure the data source for a specific channel.
+ * @data_source_get: Data source getter for a specific channel.
  * @set_sample_rate: Configure the sampling rate for a specific channel.
  * @test_pattern_set: Configure a test pattern.
  * @chan_status: Get the channel status.
@@ -115,6 +116,8 @@ struct iio_backend_ops {
 			       const struct iio_backend_data_fmt *data);
 	int (*data_source_set)(struct iio_backend *back, unsigned int chan,
 			       enum iio_backend_data_source data);
+	int (*data_source_get)(struct iio_backend *back, unsigned int chan,
+			       enum iio_backend_data_source *data);
 	int (*set_sample_rate)(struct iio_backend *back, unsigned int chan,
 			       u64 sample_rate_hz);
 	int (*test_pattern_set)(struct iio_backend *back,
@@ -176,6 +179,8 @@ int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
 				const struct iio_backend_data_fmt *data);
 int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
 				enum iio_backend_data_source data);
+int iio_backend_data_source_get(struct iio_backend *back, unsigned int chan,
+				enum iio_backend_data_source *data);
 int iio_backend_set_sampling_freq(struct iio_backend *back, unsigned int chan,
 				  u64 sample_rate_hz);
 int iio_backend_test_pattern_set(struct iio_backend *back,

-- 
2.49.0


