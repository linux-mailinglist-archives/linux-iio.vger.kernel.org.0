Return-Path: <linux-iio+bounces-19266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A67AAED3E
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 22:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6328169FB6
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A9628FAA5;
	Wed,  7 May 2025 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AztOIbFo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8B28F948
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650625; cv=none; b=sacqkKpEk+Fs3v6wulkgoW1sB6EQLq7nK1vvbM6NXIlF6xd8LiVE6Xkq/Y90O38e6ZgO7ewX7AmAQLsMVK6i8VNmLS4uVyYo/5p1F81th58OgrBai4ximDnuHycIjflUg2SIrTA2G0u+Mm9vfZsJgi0QR8kkNMjSRPUkX+Uo1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650625; c=relaxed/simple;
	bh=KXhEzNu9vMA0LlJD+DPGW7NGscBEnrm7VeMGbRK9U/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7fcKJsQf+i3zo9oLLWrU1lUBgu89j5hdsQmjJYR32noe0lr7CppYIxesLny9+ogMB70MCluADvO4P8KIuR3mONiG5U6vqAYMA8oTc5Y/6gHQi3F3d5V8bLUMelFDZqAPwWqbu9HWETdPzHuB7WmkiKNrNS9icc3WGqAJ5+XIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AztOIbFo; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7302a769534so154857a34.1
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746650621; x=1747255421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsDoH9wedifhugPM5JBN/pxKp+uLG0gE7R6WQkp6CbY=;
        b=AztOIbFo/40+dbLiN+K9vEq8Q27BO5256hxM2PWEh+9azhPiRF2OWGyNl3cmAv3PYL
         G1HfNh/LgS/UM14FNTG6HwYRhakNKv3ku/jymdVqI2KTeF60u7bXU5UDgN9dP7c4VBxw
         l2R0pcMv4MxYPL17ly1AjRVs4d2IYb8BDTZd3my4BrPo8pLV6y2Fr7OO1puFTbV0KPDq
         3wvjf77z5F1qnrDmVSIbRU0Vr4kz9lRD2Dvc0OZY+l4C9JAdO8XsSlMk4AgOnOU7Wq10
         FMlqpN70WyLGVmlavxiUa5H41QyqXQF+exFmwXgChS9s66OAxkgA1luNYWMPdfZQgg0N
         ai4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650621; x=1747255421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsDoH9wedifhugPM5JBN/pxKp+uLG0gE7R6WQkp6CbY=;
        b=wTrXfCbvIBABiH75eAN1TCBXr3sIoYVNBlXDY9KkX+5/w0s3ZAdFDVdAN5FBLKn8NM
         jON9j3p3m9FA/u+IDvwqTVlaLpBYaL4+rbZJFzN6D788N55UrXtx90in+4lvxwFM6uab
         v7NLxXSYpXNHCF5BOT93Wuhj6FyFOwJ2BwUeG/e77igvE/PK64/tYAXZgGP9SasTR3zc
         XPA2bEwoK/h658/ehePCry8bwg2zq1IHHrRWMr6e7iVdQivTozmS119joq9vYYISulF3
         901ZG+4GsDH8bvYk5ZjNUcFD6NWaOxh9gGntshDR23vHNfAzZOnyPH/RdHLPaEgd+SD2
         8NmQ==
X-Gm-Message-State: AOJu0YyZc6xIfXPgXQeN6SZeElPabhZWWWcfqQAxLtgQdJGmx4x5pkCq
	MOpxr/jrjB3gJKDX0V+JTdERnUdCQu8VGQQVXxoIECLXyfTASiaS0yDWvUULgm0=
X-Gm-Gg: ASbGncu4C0rLjl4dbLcBW3UWp2Ik4B05aKAc3ufwUZUd2I6VCPPm/Jjbxjmy5kngrGz
	c9rnitgZ5MgidM4qe9JYwkCzYkuKROITphW0s4VpC4Hmba54/BYWCWLKcTu3awu6gmnSOM6miO+
	Z9RqxpVPtPYmERbybcTzZeHuAskI1GvE64WbGJZ4q8yd5GLp3GZGfMRpDOR9QZw5bBZPAC96xLM
	VSyjW7zTvkpuS20LqrlO0v65N4o+K8LKHTpw4MrLy5TOvS1TSw7YVzWtqala67uBBghvxoLlac6
	Wv+A5kAf0spEret7HFf1xN8ZyLQZRDuXR9i8o3Hs+QFl5g==
X-Google-Smtp-Source: AGHT+IGuMbSopsw0kPB3BOKdZwGLMyA4fTqZkg1sp+VqbZBKSh74y17YUdx5+VNzA+Dlkjgu5EqA2g==
X-Received: by 2002:a05:6871:692:b0:2d5:d5c:a851 with SMTP id 586e51a60fabf-2db5bd81d15mr3352825fac.6.1746650621211;
        Wed, 07 May 2025 13:43:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5cd716d3sm898642fac.21.2025.05.07.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 May 2025 15:42:40 -0500
Subject: [PATCH v6 1/7] iio: make IIO_DMA_MINALIGN minimum of 8 bytes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-1-4aee1b9f1b89@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KXhEzNu9vMA0LlJD+DPGW7NGscBEnrm7VeMGbRK9U/g=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoG8XMenAMAnq7gPRRFS22x5xeEEEtJEsUd6xym
 y6ke1GkKsKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBvFzAAKCRDCzCAB/wGP
 wLngCACRoGSeRFy1n5EjP/iotCrHZcEvDzkEXMr6F/ZItm2ApnS+GHg2GEuOB5DOqzcUTIIXHCL
 9KQ+3veOSVxITb+z1+PHlVLj6hf79gLTAyV7h9dW3x8s3rY3fCT58TNwyK7/Se70eOlNThdaIu2
 pkXyZHdfmNZPSjbfvTMxxLG4PsvkaX1byJZXk40WocOq0pqQXFzD/5+jvGeNRfsUHhrhPN0HCJL
 Eg2YmfnUHvbYbWafrR8i25s9cd+kPm+MKU9xU3mEjale2EtU96Ej0fX4fvekuvWL8X0rClfwM3S
 cdjsFjvGtSkBlUpbBSnj3SZSLZBce9MRNi27B3UPREc1YOcX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a condition to ensure that IIO_DMA_MINALIGN is at least 8 bytes.
On some 32-bit architectures, IIO_DMA_MINALIGN is 4. In many cases,
drivers are using this alignment for buffers that include a 64-bit
timestamp that is used with iio_push_to_buffers_with_ts(), which expects
the timestamp to be aligned to 8 bytes. To handle this, we can just make
IIO_DMA_MINALIGN at least 8 bytes.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
- Removed the #if and use MAX instead since apparently clang raises an
  error that __alignof__ isn't defined when used in a #if condition.
---
 include/linux/iio/iio.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..a574f22398e45cad1ea741d20d302f88756a1b13 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/compiler_types.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/iio/types.h>
 /* IIO TODO LIST */
@@ -775,8 +776,14 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
  * to in turn include IIO_DMA_MINALIGN'd elements such as buffers which
  * must not share  cachelines with the rest of the structure, thus making
  * them safe for use with non-coherent DMA.
+ *
+ * A number of drivers also use this on buffers that include a 64-bit timestamp
+ * that is used with iio_push_to_buffer_with_ts(). Therefore, in the case where
+ * DMA alignment is not sufficient for proper timestamp alignment, we align to
+ * 8 bytes instead.
  */
-#define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
+#define IIO_DMA_MINALIGN MAX(ARCH_DMA_MINALIGN, sizeof(s64))
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */

-- 
2.43.0


