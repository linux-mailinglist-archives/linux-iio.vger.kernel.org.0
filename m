Return-Path: <linux-iio+bounces-19267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7758EAAED37
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 22:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727C01B6562B
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C28628FAA7;
	Wed,  7 May 2025 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mH4Kug5w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0483428D8F5
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650625; cv=none; b=jVndbe4UhLzTZ9TIj4w26gxfvqJKvmzQ376kiU9nHDyazwDijnXXSpdr+e6DIhoRJGzoHHFjdIDRImGCfRnqf52E27PLm55dHbdLxdXexqPptGxUUxkJFismhDbkYlVPhssm9eVvgFA+cJ3hTw4UbgPOh/WtLUZWkPOgOQs9ETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650625; c=relaxed/simple;
	bh=Qkz6TboWaI7MFHoD3asvbEdknvmftSA+W8rgLRn7UjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1cJpbYhmUbCynfU/1X1m09Y+wHPeyHE0rYvEhRa0vl2jBNNgi6Xm64Dpb6EhPA1d8puQtFymPIKXyv5cANvTmYvA1b8wWzugf8gGZ0shAHMPXh3TI4JFyvjkjTq8MLbOoZxPTvmvgIZE48sBpw2sDylzciiNcpJMz+W6FbbrH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mH4Kug5w; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2cca475546fso219837fac.1
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746650623; x=1747255423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9C6eh6cD17EJef3d5HM9D4tHLrLT86syKoOQcjPQwA=;
        b=mH4Kug5w1lChHbBYu8jIZXmirJ3eh4oQEEjeZYC1lceGHh41VgeJPkyyWIT5PtpFUO
         r+DSemSuVOg/QEjymfh4G99CanvuRTtISTZsshyYKwBfDEOw48Y4YgP3AQ9s2U5t4sja
         TfJQsHDMP6tm3C31bMeiK3EVqm2vKhALfENMAW2X/7ZcmhNAvqqib0pjlLhJnSvphcZy
         HrbW0gpzaMnTd21/4YUAx6E2qwJ79Re+uLNcR2GaVAAT2GBlp0KgNtuP2tjyHRe8ewse
         X4P0GZ43Xzs0i4l0KzwL8XI98DFOg+3mMBVLe2NvKhx/WIvPOm3ERj/FQS7hi/Ancppo
         y5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650623; x=1747255423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9C6eh6cD17EJef3d5HM9D4tHLrLT86syKoOQcjPQwA=;
        b=rIDM6VoL2u0DlHApQPkam58X6z8+9K9HN6iwNKGLhH3ZSUdg7txHOUmMvWNhvzj7Yo
         PGTnKTGQEa8GU75R1LxSLcHRtYD/Yhrga6Ql3o0DtMHF3BOt9VgiYQzXv4No3J/zrgH6
         xW3By6Y7tOZe8gjPDCpv82jXGCyHQOwLFAYG3SgbDJ1r1+Jq8eXsgirw4PWMp0DAjyrS
         8+dp3pqOLr4LUCmlh2CnBZlbbUtjEadOMaJVJQITneXrKw9R8hhVxtzPYnzcHbdNYBV4
         iygyiJCwd4LyNHJ+x+r275Lxi0T2OiiYorUQStZNUDPHVj5Y+2IpM6KwW5PC/vY7O9DS
         PIsg==
X-Gm-Message-State: AOJu0Yz9tHVZYbMsGopySHRjTg3gUWjIpsIUAp2AZpBbhex7crkgCphp
	PJpdqZLWu0TX8z9kETTSztmHzvMbxT6Aj6s9JZ6ewbMXfpkgDpF0hayMKgq9Aa4=
X-Gm-Gg: ASbGncviKp/LHMXoATuVRehDgqL0t25fWolmvn10SOdnMJDUrJ89IYGg0Ehtp2olYAs
	+iSVecoM2TrmlCatuSy4TdAPa+TaXee3AslkvPcPKHrqn1cBAcLCAWeP0G8GvgRLg7VzMm+jOFL
	bR/XaNKzGj9hGRTXPe0PkXPrlyCJbq+9j/vJb6LoCmLBxiccZq2XkJOWkrEIKFhH06mp48dsKxK
	Exo2ielgVfW++bmHOC/bza2fAFiLjzjzmPuE8wtB9iBNA+RWByHQSwVwpcuCoceaa3adx3wZ1uR
	7l6wFp0Z2ZhgWtu3eiMR/c8CTjEo87K7Oq2XymCcZPKdgNXJHhRo/5wc
X-Google-Smtp-Source: AGHT+IENPH7fJFVZWI+5hLQbltsb6uPLojsgCu0d4mLuhreNgObStagGp6+xSfl6IozpO/zVgnEYcQ==
X-Received: by 2002:a05:6870:a7a0:b0:2c2:3eb4:e53 with SMTP id 586e51a60fabf-2db5c126f05mr2877972fac.37.1746650622970;
        Wed, 07 May 2025 13:43:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5cd716d3sm898642fac.21.2025.05.07.13.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 May 2025 15:42:41 -0500
Subject: [PATCH v6 2/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-2-4aee1b9f1b89@baylibre.com>
References: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
In-Reply-To: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4238; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Qkz6TboWaI7MFHoD3asvbEdknvmftSA+W8rgLRn7UjM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoG8XSBGqWPSVzxaO0ZMnShg5EsgNFTw6d5cS5L
 syZI6ewvIOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBvF0gAKCRDCzCAB/wGP
 wB0AB/9zqie1eENWSL0OQQqBATpe+2eVgIQGMFWAEa7WJHYw07K73zYwEpmZbJvfjFhPZzv57ot
 hxvzp7Y94iu/G1vwtc/vQ88etn1VI36o5jAMreTZHcLTQEhizFV1b217USh5XdaWNhEYc+3aHu5
 y+sIQtY93SDTnbG0utUX24FNFXmUwc1+s0KjcsA3Ccdyp/nlLLsL2ufTNdYMu0uVT5IrcGrLKiG
 KOX1enYu/mmX0alZqmCPeQulRunaS+JiZe6EeUveJb6Wqj+9exstphlnAZk+J1y77ZE2e1AuOhh
 Fa5k0E3X+cmHL3E+zO/B5ZHV3CpOoDUzaQRcCKPJSOUO2vMG
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new macros to help with the common case of declaring a buffer that
is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
to do correctly because of the alignment requirements of the timestamp.
This will make it easier for both authors and reviewers.

To avoid double __align() attributes in cases where we also need DMA
alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS().

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
* Revert back to __align(IIO_DMA_MINALIGN) as IIO_DMA_MINALIGN now has
  a minimum of 8 bytes.

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
 include/linux/iio/iio.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a574f22398e45cad1ea741d20d302f88756a1b13..d11668f14a3e17654fcf17a4e853d4b493205019 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -7,6 +7,7 @@
 #ifndef _INDUSTRIAL_IO_H_
 #define _INDUSTRIAL_IO_H_
 
+#include <linux/align.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/compiler_types.h>
@@ -784,6 +785,37 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
  */
 #define IIO_DMA_MINALIGN MAX(ARCH_DMA_MINALIGN, sizeof(s64))
 
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
+#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
+	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */

-- 
2.43.0


