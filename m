Return-Path: <linux-iio+bounces-19122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B70EAA991C
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089CC3BFEDC
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BD554279;
	Mon,  5 May 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mie3ee7g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74931189916
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462765; cv=none; b=FYTtk4c6kAxxwVOD7h9XCpfTEDJ0pyGspYeVFqYymIvnLoy+Fy0WRg4i7jEW0WVd5SdUVERf2emu7iBh7BDzsM3E6GwA4WV8L9qOsPNcrEtyjeQxhj9/g49RrgqnmjnurL4rJvNO0JeA+EYyDK2kH/XitK3dCgda+WsdSwjjywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462765; c=relaxed/simple;
	bh=46OSuZf2dhljZm7iLcR4nEvANejbGAzfctNVEsdQaN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GDmZFn5N2EvrRQwdOUJpHSx7VGu9ecM4CsniOZv0ol3WzLbQRiDKkySQ8G6Fe9xYaeN8TiidsKxCswm5vZu6yz/EY7dWMc3oYSAsxAlqQyg/zR/afPxsip7qseM7OGpcg9oJuRmGf0QQellG9V6Vp7hVeRMIpRFtkZhkDhqSSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mie3ee7g; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-40356cb3352so1451538b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746462762; x=1747067562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJgqOXHKtLEYu5Dc95e8O+Sgs8ALpz+j191fEgS8hIA=;
        b=mie3ee7g6bKMhnWx9Js2PDjSN+cRPyfAF1yFjA/QA7M6N45+SS7vz2/85E2kTRbgrE
         2iicBKE7CYK9zGqlM0IeoTGcz231qHZhYpFxSV6Tc6WxMNugtePpqOrNQsP1QEBsCm69
         a98THqAcv51/xL8c8ZUsyn8XOoyhaipjHjZ96JlIWGbDbcSsdx6LukJjGiIGZmZzQ3FX
         0TgvaGa+UyVRxpzJzEixDlcSSJbBYurGOD9DbHeFo3IFbOMByUXY2DIdKOkG4P7EPErv
         s3KsOhJgdSXpqsOzj6BJQyPYlzufF956Ybkmth8cnjzUrlFJcZEpqsJgfyFEj3rkzUeS
         eugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462762; x=1747067562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJgqOXHKtLEYu5Dc95e8O+Sgs8ALpz+j191fEgS8hIA=;
        b=tALOOBtdV/F8BpAk8LTEcNPd1+PrzwqFdqzdAsSImP15r0PTVKtFBO4FNoxkc9dV1B
         He+fAfryo5h4aWjKjnIc7t2sD1jtA+LIOyNodvZ8mmi8d9Yf8qoOJYSRYAQBnLrpJYd3
         xFKz8dWco41xPBkeLGCHhI+7Rrj66z+6k2sbV+P/sEBBSdglVMEu/OXrwjy64MR4wXsC
         vriWYDwJOgxAl7fkM7YwTBHc7A9r/+lz+4YofxVMzAxnZPNGt3swvfvn3GhhIygk5Ha+
         H46OH7aO2WArvLeOVVzq+gulOr5+XMp/lzZQRPncLWPKta0VWdQEaP9tgZX3+f2PbqHd
         P/HQ==
X-Gm-Message-State: AOJu0YwM6TtAka+APbpofGFu5A13oja88Duqyt9Qu2MswPHd3MLrKkoI
	03Tmpj2YY+A+YuCBHx04eWBEYg1tCmjf50LGzJ5VOAn66XYtHmOVwmfAmgzGQko=
X-Gm-Gg: ASbGncvaP8L7n02vj8Xxopj+36SNZtOtqahDpCx/d70HPEyhp16xgq92Oy83VTGuBFu
	bvuNddKo55y072X0w6e5zSUzixpicaqw+AkI/xbKxI4Zxaeb9+sZozhOmgFKqSRk2DiR1HLbh0M
	V5Lu2bM3oAXORUb6gu8K97QObxa2m5HQjYr7a0DRBxE4nbULHJUpPQIO+mVDY+2x1oYv7ZabJdX
	/2Ca3RpX8uWeJ54ftH6YgK95QDbHJVUyOAQ6ITpn7tbhNqdxa+7McZxdGGllb3tuzsHihAhmNn+
	uHJEU27+5c+24CWhP9Ah16N8an7h2YZOw8cderwUBGLJkQ==
X-Google-Smtp-Source: AGHT+IGs/uio+N9GX6uoXBshi7EmIQjByvrsNNXX+NqolBl5ZTXdpZVjZB6aOujcazOYysdZc1C7fg==
X-Received: by 2002:a05:6808:2e44:b0:3f3:d699:e1a8 with SMTP id 5614622812f47-4036889329dmr99556b6e.13.1746462762462;
        Mon, 05 May 2025 09:32:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dae68f7sm1971854b6e.26.2025.05.05.09.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:32:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 11:31:42 -0500
Subject: [PATCH v5 1/7] iio: make IIO_DMA_MINALIGN minimum of 8 bytes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-1-814b72b1cae3@baylibre.com>
References: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
In-Reply-To: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=46OSuZf2dhljZm7iLcR4nEvANejbGAzfctNVEsdQaN8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGOf3wI8ZT4eFmRiGA5GwE6azCjTTRo1UWmFKt
 qQemRE5B6eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBjn9wAKCRDCzCAB/wGP
 wH0mB/0emTwkt4s59h+lwHQxEogmsxeNHdHGwpxtKif1U4oSd5BIhv04bnXgOEzZHho6ORDkML5
 T5Wx+rUcoPcfdZv4UINUOowft6FL8a2ZLzKxwV/cYf+93la/1Gj6fxP/tAmN4GRnTSQgtbKowYM
 KarS+EJX/y+GonOePKZqncyxqtKtoV4DX+VPCOJ8FqK1PYW/3e4GBut/zPaLq4I+X+mG+oZZ8Mx
 IVsCipaI9EJmcaP41FAXPSuw7BMqzbTfv6OPxBcNyWi+/5haxvZcJ75P8m7BHkrYJlZw9CFeO+Y
 XR+bpiOEfvYEZQlo3vHnK3lt8YXx5RKltXnVVjyN9KBxGTnw
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a condition to ensure that IIO_DMA_MINALIGN is at least 8 bytes.
On some 32-bit architectures, IIO_DMA_MINALIGN is 4. In many cases,
drivers are using this alignment for buffers that include a 64-bit
timestamp that is used with iio_push_to_buffers_with_ts(), which expects
the timestamp to be aligned to 8 bytes. To handle this, we can just make
IIO_DMA_MINALIGN at least 8 bytes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/iio.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..7e1e3739328d103262071bd34ba5f6631163c122 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -775,8 +775,18 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
  * to in turn include IIO_DMA_MINALIGN'd elements such as buffers which
  * must not share  cachelines with the rest of the structure, thus making
  * them safe for use with non-coherent DMA.
+ *
+ * A number of drivers also use this on buffers that include a 64-bit timestamp
+ * that is used with iio_push_to_buffer_with_ts(). Therefore, in the case where
+ * DMA alignment is not sufficient for proper timestamp alignment, we align to
+ * 8 bytes instead.
  */
+#if ARCH_DMA_MINALIGN < sizeof(s64)
+#define IIO_DMA_MINALIGN sizeof(s64)
+#else
 #define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
+#endif
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */

-- 
2.43.0


