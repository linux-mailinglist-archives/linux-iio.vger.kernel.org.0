Return-Path: <linux-iio+bounces-18664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D936A9D3E5
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 23:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAFB17D33D
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 21:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE795224AF2;
	Fri, 25 Apr 2025 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GAnSa7F5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF9223DC9
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615382; cv=none; b=dmM3oN1thNPsWDbrstsndMj0rXCWFJUnGJ45e+GUr9Trb9QGwYQ1MqENPbNBRm+Hpyjeane5eTgDSBkd7cRK5Ys6I+VGtiYdRzKMyJhxDguYUOAHNhkD3NbqSr6xYQXzP+Gv/qdvbTvOAcfyLkqcw8pGc2NFXZUSYpVzqZoBfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615382; c=relaxed/simple;
	bh=S9yyrbbGceERU79hEYcii6LVQfguSKjlkyu5n+UlTsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLRPXTtDHuRlvrJwX0NgDVhZi3Oj/K7v+vpFeqhN7acimPkTi7LGnRqrFluq7NU3wa9WPOPc/uFeEo7MHla7g3RJnjLdrXNUccbmgbjuiAFVQC4SEFt0E9lNn8RNgmrOoaub+hKvHOxhc/rK1/2ePBYHEDBRmvSg37pUqjnl8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GAnSa7F5; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c7f876b320so1802972fac.1
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745615379; x=1746220179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BY1aWIkNQr9/WlVdM/imYDbUDJ4FCN12j5sBaq8Ups4=;
        b=GAnSa7F5xF9OG+cfKIBYF6rZ8E0vWFuGHxyOO9QzT6D8FFe/l8KR9MvD6EdVYViFIZ
         9GzjKYcDugPK9IPo7VIz1IO3AnAkOSjUfGfm+h/YpaIFcjHsGzp518RxAEXCzpT055eh
         2q8aTe1Sl8vbCBh8kE6KsjE/AgGcA8NcAdm9HgLHT/8pCHEiudD5BInzkfZmbM2y+U76
         vi2mSKf21N00vg5SFOn5u2VBtoLLzYLtuz99y5w/ZXIsy+QGu9UDCQ2GNoXVxJ9fWeyi
         nFVkcFX+XL6EARhp22GczlH+1y48lvjItRGZmlbhEQPGkA9D69Af5BHX8CbNmFYGMUr2
         rCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745615379; x=1746220179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BY1aWIkNQr9/WlVdM/imYDbUDJ4FCN12j5sBaq8Ups4=;
        b=HIUyqdTLznKiwsKOTxOK8SzCSGBJgnKtx5R3E+/enRZ9sYuAbtglCn73s2gBx7tuUf
         0EtswonKL+7feZPVAC9c2d5nXimBv9wjsCk14bCooFEiP+nlZlzEBbMFXX0KIJSL5QDj
         IiJ+Zz6TM6lCQcJUamzuMsEHIVPhu2i7bA7tEszPBmhrPCTs+ny4XAOq456tIpFbW+pL
         F/2cBHw63kacypcM5LJ0ZJQTWhdWWJTUAut5T+dt5FBTW7KY1GIwUM9fQkF1tHVWiuKR
         LUpQQ4VpwYrK0msc6LnRBqxzEdYdOfSrItnkaf8cQnD9ZmDUneklqLf7nG/kJnm+e1zg
         qAZQ==
X-Gm-Message-State: AOJu0Yx9T4Cm8xBg0otgW/z2Uum1fWpKnXPH7Dnh56zVRW2wtzyXrfaT
	Z1Wq2wwFhaxgxsq/0buTjo4JzNRiCGdRIgM5oNQrdvkIe4r7a4FTIdxm8cK2GH31araxse0eMNV
	X
X-Gm-Gg: ASbGncuU0SX7cb1ZDkmL+Nxp0QO0FMkPoOWn0stqxzSNscv2/Y4FZ+h17U33J9TX8S2
	WIvWhauFFqUqP8w1hNpnacWFryy4lvP483eAfm1G1nfcXUmG/f7PH65JmRi/0vOisYI9o+YjP/F
	Ll7W2iUySd5Wdnsbirc8HDXpbl8IE5bYLEynLWFt+3hwJ7LHqeqCQtGPHvuM5t7l9+vRAsunpUV
	R3r/QdyX4fPamcWkgegVRE5Z99hrmJCWZdA9ZUL9+xr+GynT2Jc0ZEBRy4d/qoNNlQYkbVty5Uw
	H3dLS6JaBCGQgMOOxZcIRnS0uKv48O8eT5HQ7r0rQefAJI9owTvkluQ=
X-Google-Smtp-Source: AGHT+IHgoMZkBfZXhz5aqoIzlRTV+NaG/N/wVFvnLQMLS1D8aZCmMXkvEWmf1mqpeRfkisZn7+z95Q==
X-Received: by 2002:a05:6871:792:b0:29e:4ba5:4ddc with SMTP id 586e51a60fabf-2d99db25561mr2208324fac.24.1745615379304;
        Fri, 25 Apr 2025 14:09:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f188052sm847673a34.8.2025.04.25.14.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:09:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 25 Apr 2025 16:08:43 -0500
Subject: [PATCH v3 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-1-f12df1bff248@baylibre.com>
References: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
In-Reply-To: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3719; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=S9yyrbbGceERU79hEYcii6LVQfguSKjlkyu5n+UlTsA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoC/nm4JmFy6kPkiyqKsDPXMzKl5mRSVcD8MkmU
 knBSH8PgtKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAv55gAKCRDCzCAB/wGP
 wJSvB/9gSprhYoKqm17uZXVZ6jJRFmsaX8jyoqQBaLCQeqXZdb0j74O/nlC316k+qfISf3o34yh
 /ZAovdK45qS71p3Y20kH3CqNKHpCUgnttFXhEdWcgNjsFcFr/UMUQw/M5T7sQTpYgxl/8sD88KJ
 f4tZd53Vyn5wkQq2ELL4SUF4oVvta5WyOAK5S7/tCmuGLWyJqC1j9ihqeiifuzZRZf+ypJPu4oD
 GxQdYZxyVLx+fmM0y832hdBwp/gcd4J4TH6K3ll5OlYcCJvk7n8SPI0Hjl3egeYyk196dIcMKzf
 B6ZjyRXK7+EJ+iq2t/OBgh4tZOCC5h/5hli4azVUGDAMwFoA
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
 include/linux/iio/iio.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..1115b219271b76792539931edc404a67549bd8b1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -7,6 +7,8 @@
 #ifndef _INDUSTRIAL_IO_H_
 #define _INDUSTRIAL_IO_H_
 
+#include <linux/align.h>
+#include <linux/build_bug.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/compiler_types.h>
@@ -777,6 +779,42 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
  * them safe for use with non-coherent DMA.
  */
 #define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
+
+#define __IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
+	static_assert(count); \
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
+static_assert(IIO_DMA_MINALIGN % sizeof(s64) == 0,
+	"macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment");
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */

-- 
2.43.0


