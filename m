Return-Path: <linux-iio+bounces-18537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F34FA97A1C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E75171D40
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504C42C1791;
	Tue, 22 Apr 2025 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KCOBwBNr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49420297A60
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359729; cv=none; b=MViMC7DRjLYh7nuJL/5e6lgFxMTlK6IOJqhiM9NHUShwgOwZxRLPAck32TsGkicaIB0Wrf6bxy8nncPgse5A7lxSJVFY/ituHETEHzZT39r7In9H9EgpmTAs2zWm6PKGmoGdfg4hkfNkvmjqo7hGL4m7BRDFRfPCpU30tg2c0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359729; c=relaxed/simple;
	bh=nCzR1/emrbeUL84tCt3IiYuUEVzi1rCzDn2Z6fqJM44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHnOybI4PeM5hDpX5L8o/FmhRr5/YWlc+kUom+sbdVlFYN24159arDSozWcjraSdisBbf/7Wo4Tp9v/915mslsgi5hRfgpwhmeh/QROX38IoQ/O+OKY2VbQttTEmPARJ0iMwOhr0WSTYkAc1tQlEZj5xsAx8jk9pPQ6JQ7xOIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KCOBwBNr; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72bb9725de1so1290530a34.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 15:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745359725; x=1745964525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9K2B+Xay9TH+WRl+WF3lyeO5h1JwZugbslpoI+5AHg=;
        b=KCOBwBNrhb0MyQfMFQaroSKXqmrCq+7KR7e67Fg9b7h3ph4XEkTyLilnMXDKB12jzu
         c+5yLHSD1Qh2v+FnPYuirb6mfyXrv6nKA2Rj9dt5kZGZV+ji3VSiEYuQGjrm/hP5604D
         v8KP/SrDiQvcvnyp5hSDVtJ1Qgg/ziT7jpC+GuKfwzpIBwwS2eqcFU0kMkiGoWPA8p+E
         LmUXkxB929ik+wzcNDMmR1R+OI0orgEkKlULjjDHi0bsPtNnZ/3UVgPDo6FzlVoXU9ye
         eguOj0RT+dLEnnx+Vt8imU1HX6KqoYOwttlKBspNAOwEQkumWKTa7JWnUI0ctyPaDYjc
         297g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359725; x=1745964525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9K2B+Xay9TH+WRl+WF3lyeO5h1JwZugbslpoI+5AHg=;
        b=v3ccbvidp/ZB1mp6TpxHg1M4qIQmqPA2AC0kS6Rl6ZCZmC84OmHI/XJPBLPH+XVtXq
         FTP/8HG3ifBvQTG2+DmbJkgGswQUfoHcdRc6WP5HLg/T8vPiCAk+ABoBIzGS0kWO0Kpz
         DF4eq3Po7JcU1NPfEDHogg5bQPGCdn7YfKXVE907QAVQ3sJVkHPojBgqrI6VgRx+T5Zs
         3Q2dHLxA+hNeI3cqALCBNcwr2B791QlxLcC2TSg5I6kI6J4XUpewh+vI+iq5BY3Nlg0I
         jlYHd33KYFugjYSMvbzo+RqkJSJ1bPMEED/1eMhFm/mecb0UE+/iI5CpmUsreLA1c42b
         nXZA==
X-Gm-Message-State: AOJu0YwMX3TdrFFH01iySZvwRiLaBf4w/yNKZONoMLGxExo//fZT9D/v
	14CJINj0gtU9RRkKDQVhH4Nq/RSbT3FhALduZbrkR6/gxVWmtuUBHjec4JV7Seg=
X-Gm-Gg: ASbGncsNSf/0dJPxhQMKVAhdEE6zj66vJBURvH0YHO5Skqpm6im3cZmMcTxE9RcFtg5
	nUi8SuAyB6JeN593Rh89V3B+pR1eYVc/oJUVyTthn/f7aACpZgP1oGApEYdLczHTRvsC26s9oAq
	Anh+VluuJ3TJQBuYYQ9N6gt/sW8iwMfwAAeR4GnYUoYmSeVzTKqWMIoDJAOcf2uRuU2k2tr0Rzy
	68+hSDQS8szM9d6MZvlMIPYdoPYVoJH8naC1P4AziQCitSO466ziy+uBJnkTeH23F2MW8SuOY1N
	d+25KjRWnFoo4DN+DQEKnt4AhHHDqkQQCkLrNaYZcgPK5l4=
X-Google-Smtp-Source: AGHT+IH9UlcMwP6SptMTSFVihJ/iz9gBXiP46PQmSgYR0lDL6OqVr1KITJanla834aaysMRXitqaWQ==
X-Received: by 2002:a05:6830:3813:b0:730:da:1165 with SMTP id 46e09a7af769-7300632c65dmr13414959a34.21.1745359725278;
        Tue, 22 Apr 2025 15:08:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730048848dfsm2265938a34.52.2025.04.22.15.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:08:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Apr 2025 17:07:46 -0500
Subject: [PATCH v2 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2962; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=nCzR1/emrbeUL84tCt3IiYuUEVzi1rCzDn2Z6fqJM44=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoCBM9pXsoFeECQODQSXKUf+R+nqAiwzg2R14di
 eSX7AycMvuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAgTPQAKCRDCzCAB/wGP
 wDU/CACaaPDIIK7yQ4QaByRNrsGGx3mAq/LvHL9GakyNv998abhnWQTZ0Ue2ye4vTXEsv/ERja0
 vlcjBv6HxuJ/mPV8MzNx6Rah+WZIAe0rcTIuBx4J7i+Mso7eGGVDp/LjMLePye3PYnumWKpavRy
 Yk0p1RqkgEIhIqTi+GggQYvsJVZ6h5ngl02BhN02xRtAKV46VjQci66m0EaYvmApDuqg0UPNjcZ
 M96Ap1ZaJxoNNvdMht3X9sIr5zcqG31wGiAQDSdCcdJTM4HYBVdPFlkIcpCGmnytcviPQmjjsxC
 /8f8RJrpl5Ip4TJfX7L/LddlhzV8vamiGUCUTqizsRvrrldk
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new macros to help with the common case of declaring a buffer that
is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
to do correctly because of the alignment requirements of the timestamp.
This will make it easier for both authors and reviewers.

To avoid double __align() attributes in cases where we also need DMA
alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/iio.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..4dd811e3530e228a6fadbd80cfb2f5068c3d6a9a 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -7,6 +7,7 @@
 #ifndef _INDUSTRIAL_IO_H_
 #define _INDUSTRIAL_IO_H_
 
+#include <linux/align.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/compiler_types.h>
@@ -777,6 +778,41 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
  * them safe for use with non-coherent DMA.
  */
 #define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
+
+#define _IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
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
+	_IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(sizeof(s64))
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
+	_IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
+
+_Static_assert(sizeof(IIO_DMA_MINALIGN) % sizeof(s64) == 0,
+	"macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment");
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */

-- 
2.43.0


