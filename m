Return-Path: <linux-iio+bounces-18788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456BA9FA71
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 22:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47869169A1D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99501DE3AA;
	Mon, 28 Apr 2025 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xwPy127n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA31D63EF
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871849; cv=none; b=sdiMecOjz7UAnB37XWUDdiXS3whmt7tmX9rgHedFwXHAlWMkQ1grMaN3AWMCjPMhH8olaJur/7Ja8koWrFRE0YO8CaVkq1bLcDB4S/ENA7epodjAEcYO4yyf42PgyS9BH3jYldUQlC22s9KGk46ZSybA6pBKdxGBNigDKuLXqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871849; c=relaxed/simple;
	bh=NbvlMBP/8hkPgeT8KG8PAd/JVAGx954UfPXMpF7Wv10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kG9XXVoPfj6m61FVUs0LDckkpXsGR2dXZZTHswKR10iT3JWxnvddS2DWCBfu7Nw4yX/T4CkCzvbx41zZjWvRHRM2pV4u0VITiWRIxT1dsKgKiFDpBBji+oFwDkPDmmtQL/CCwQyehvOCLr7f8uLiAJz8mCSLKfn7MBd9Ejm3Ls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xwPy127n; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f9832f798aso4153086b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745871846; x=1746476646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDO3BrucMxULVTP7wxmNOUlpxABCLZ8/GfNo16L3AFU=;
        b=xwPy127ntU7sLNLubaBBMWQTsvfuBSwNSoQEWR69IZite85vtoM4rICaeX4NsZP+M+
         Gxe4BCJEjbi/+45/4SXZUhsE3H0wcq6LDEZEFRNXVbfYG3GnpCocigbc+EFqSWhfCULZ
         ptSRWAVQPMpwVOKGAkkblOzQ3I/sYX43+VZCU4eP7BnpqUSQOGeL1ABauRAj0ETpoV0Q
         83RicAj1jVJMH6YRwdbjbY/6MOQPeH8+9J8k3wNdkV4xT+lp3FC5A0CKV4YJkb5H7WM2
         gAXE/E4u4dCM2Xtn9nIIgFHdLdb6OUJRKMrH4uWQrZdahmAXIB3JuEgqIBpwFtUachKC
         as2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871846; x=1746476646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDO3BrucMxULVTP7wxmNOUlpxABCLZ8/GfNo16L3AFU=;
        b=hraG8GRD7AluXxYNuWsUDxj2CuUNv8aSBJQUZFdjJSLIs46wUg8W3emQugDzO8jUQ9
         uhekKaCgvBu7m+vHUrbmVRKGuwB29jZmspWe1EzTSpza9rf2EWfXHH+ICtoXh8KuzGAZ
         12ngZ77+4GSPE4G5L9odIHb2dXd2ffx/jBq4KojnDNinVWqFzhk5CYzlE3eoFYPAdCx8
         8sQoHNidEXjOIMdSDYQn4olMKa9EiQv2e+R1S9cy3nQ9C3KNRq2dJvZGuP8xG6nuTS2d
         SSb7rQuZDblWLWoC2Ok2eYygaSLa+2RFjvYW0Ad87YDXivmJgGkMTDuOEJwkO2463Ooq
         hlkA==
X-Gm-Message-State: AOJu0Yxj9nABFlC1JYsMGBNMKDYaeFhGJfMxzaUE3q58TbV8OCmJPc2e
	aq5CLJYPP0YLyz2xDgiVx+Fwi3x7aRwiaHnVFr4DQUmFm+6ZZzGA/lhEHRY84Mw=
X-Gm-Gg: ASbGncur4dXGXPIYPpCIMw6h17AUmhJH5Nx+6wUgba23lv1Cs9h9G+2zVRb5SklAQoW
	P3iM0Yb8+yMbfVLsJLuLw4KoLDPNsXoEnyfX8+nDov9aN/m4sPGf9uzfjyWxvjmCQFe9pf9Ponk
	aP5RMHI3rLRcQFUJs+nxJGwrKAK/DWOJi0sCI+f6QHA+ANS1ZmUOOpXnsSdkGX0ZQd5Ja7WKReW
	9dCOFSgrAhjvVpZs4mEoZjeUToVkp0OUibvx4BjRz7ITjRrFsDyp3bLf+q8rypVWkkM+qe9dFs3
	dlIETHGrAOuFWmjOetfvpxkyQavWmnDGI+q3VdZXm0uhgpg=
X-Google-Smtp-Source: AGHT+IEIb+/7jwFycj6Lxs0AIAmOXJEQMNM+ExPcVNff3F0TuKaEDFx36DEm3NSKVEONbWj2NvQzbw==
X-Received: by 2002:a05:6808:1597:b0:3f7:6824:5839 with SMTP id 5614622812f47-402115793e8mr196510b6e.19.1745871845666;
        Mon, 28 Apr 2025 13:24:05 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec970ec5sm2196187b6e.34.2025.04.28.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:24:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 15:23:03 -0500
Subject: [PATCH v4 1/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-1-6f7f6126f1cb@baylibre.com>
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
In-Reply-To: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4338; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NbvlMBP/8hkPgeT8KG8PAd/JVAGx954UfPXMpF7Wv10=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoD+OxkAV7kbZhJxHC4iKN/xmbZ/Lc7pauhbWdp
 +DmlLR4dguJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaA/jsQAKCRDCzCAB/wGP
 wJ72B/0UaG/hbNwQmC2jqV8Rbj6GBpaWfbcJAA1elDDGhYuyJ64XSLue9cdWjFH6yHyLS6A9xFI
 +onUBUrKMut5HCGv9SdkQo5a9imJSUAXjTv8Ybl5c/tk6Jrsq1URo3qjRmbmL4/kH4L5gv27bQ3
 oKMt+m/912KVXfQxhD3WgV75N+7lUB6G8GJd2hyhlVFrkcXqVi1yB0ynX9s39mqfcundWaczazG
 qfz/2+xNtm9ozLVPvaRf0fREtx5UaYGSOj9W/fkpXMbpysJW8cmG1acPjbDyoAKZ4nDBw/g+Jig
 dXM8MBCBPdgtaLwMqGWw6SdzKM6WU8EmTzGIqtMyx16s0Hpo
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new macros to help with the common case of declaring a buffer that
is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
to do correctly because of the alignment requirements of the timestamp.
This will make it easier for both authors and reviewers.

To avoid double __align() attributes in cases where we also need DMA
alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Drop the static_asserts(). Some 32-bit arches were triggering one, so
  we had to address the problem instead of hoping that it didn't exist.
  The other made a multi-statement macro, which isn't the best practice
  and didn't have a way to make a really helpful error message. The
  condition we were trying to catch is still caught by -Wvla.
* Changed __align(IIO_DMA_MINALIGN) to __align(MAX(IIO_DMA_MINALIGN,
  sizeof(s64))). As the build-bots found, there are some 32-bit arches
  where IIO_DMA_MINALIGN is 4, but we still need 8-byte alignment for
  the timestamp.

v3 changes:
* Use leading double-underscore for "private" macro to match "private"
  functions that do the same.
* Use static_assert() from linux/build_bug.h instead of _Static_assert()
* Fix incorrectly using sizeof(IIO_DMA_MINALIGN).
* Add check that count argument is constant. (Note, I didn't include a
  message in this static assert because it already gives a reasonable
  message.)

/home/david/work/bl/linux/drivers/iio/accel/sca3300.c:482:51: error: expression in static assertion is not constant
  482 |         IIO_DECLARE_BUFFER_WITH_TS(s16, channels, val);
      |                                                   ^~~

v2 changes:
* Add 2nd macro for DMA alignment
---
 include/linux/iio/iio.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..95d90740b4ffb3ebd819d03ad2bd05ecf40d4384 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -7,9 +7,12 @@
 #ifndef _INDUSTRIAL_IO_H_
 #define _INDUSTRIAL_IO_H_
 
+#include <linux/align.h>
+#include <linux/build_bug.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/compiler_types.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/iio/types.h>
 /* IIO TODO LIST */
@@ -777,6 +780,40 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
  * them safe for use with non-coherent DMA.
  */
 #define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
+
+#define __IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
+	type name[ALIGN((count), sizeof(s64) / sizeof(type)) + sizeof(s64) / sizeof(type)]
+
+/**
+ * IIO_DECLARE_BUFFER_WITH_TS() - Declare a buffer with timestamp
+ * @type: element type of the buffer
+ * @name: identifier name of the buffer
+ * @count: number of elements in the buffer
+ *
+ * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts(). In
+ * addition to allocating enough space for @count elements of @type, it also
+ * allocates space for a s64 timestamp at the end of the buffer and ensures
+ * proper alignment of the timestamp.
+ */
+#define IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
+	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(sizeof(s64))
+
+/**
+ * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer with timestamp
+ * @type: element type of the buffer
+ * @name: identifier name of the buffer
+ * @count: number of elements in the buffer
+ *
+ * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses __aligned(IIO_DMA_MINALIGN)
+ * to ensure that the buffer doesn't share cachelines with anything that comes
+ * before it in a struct. This should not be used for stack-allocated buffers
+ * as stack memory cannot generally be used for DMA.
+ */
+#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count)	\
+	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count)		\
+	/* IIO_DMA_MINALIGN may be 4 on some 32-bit arches. */	\
+	__aligned(MAX(IIO_DMA_MINALIGN, sizeof(s64)))
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */

-- 
2.43.0


