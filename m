Return-Path: <linux-iio+bounces-10057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A098F487
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9F31C21402
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B994A1ABEA7;
	Thu,  3 Oct 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoYq6S4G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823E1AB6C4;
	Thu,  3 Oct 2024 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974197; cv=none; b=d3NrcD6GH4qNffuYVnEFwZRgcRQf/FHtj1g+sXOBZgGuwUouHaWCs8dc05okrWbptCW4wt1D7KmLSGfBlSU+g5O8o6Tt/g/S+w4W2oB6W0Vro+suIHNj1HMuGAUU51EhZqrKXdeHYyrOwJICfNbYtv6nKZ+9V4bZmCPk3rxmXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974197; c=relaxed/simple;
	bh=jvLWzH4oOslszdfS3NY5Cj90RSF7nGqFhhnrSrcckog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gkVjDBKJWQ/JNABpWcA6MSmpKxxE27bDaQvdHLwJh/WkM9SuOV1BMYLt6DtBZPq1qvN7c8fMzSLW7ihmJkwj3r3xtXvRC9ef4hz83A6af/wIW2C2akkWf2lKN4fOs++y+wkAK1y+zVnaFmqjgJvkgwku7St77VKFVIPEIkA+t6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoYq6S4G; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so10578755e9.2;
        Thu, 03 Oct 2024 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974194; x=1728578994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFNQpHQ71lBD9ZwMnnd3IcDTvUoitTaTMyhu5x0wUI4=;
        b=OoYq6S4GIMmYbWnkVZ/jdBRlQHa4LLd4zArW6Wl05+3rVVtU9NS0+l1FNk54uSfTpm
         xCrHbtG9voXq4kjx/hcxzF4GHi3HD17lqmGbkQbsk02ZYZuCuUKlS7UVq9s3z6te6+3J
         PMm+jWvGiV66NKDN7DqFJ5xLTAgYE8NjIRSzhhMpt6cl1nvRHTmWC0fEAoyzfrBfGatB
         aklexmwwGDW8OUp/pZ8BmRFJbjgf+dkliAoC6GazDCCumI2nQpF+jcVWzuGflzBtotY+
         X1W1RkvSlR/eyrjhGflkUPvqcFrllVwP6Qxm5oC1Y0O6zWkciCU0tM3FUklVIIElZQWl
         MlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974194; x=1728578994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFNQpHQ71lBD9ZwMnnd3IcDTvUoitTaTMyhu5x0wUI4=;
        b=nRuQpHhAlBTlTImHm6gTQgio9ESpJ3ZxoY+J96JnswuJG3Eq55qXGt7SQnaostlUiH
         WjpnXb1rTxa6OHpbX1r10gaaF8E1QUveFmatqY+GVIkUJ8hHTjV4HbwtsVM6hq63wiry
         ao4xWr86Nmjv8DUpvEoFrfx0xem22COy6T5UfzSrYrRj4EeitXBShWnws1UdetKzkE1b
         ZzGuTxorbu9+aYQl2GScY0GopQAN9cV8RHA3UiUKuWhgwPvuRNAxcElapf+F4MQmJW2j
         dkhb7Tg+n1aHIJ+c7kK6PduZX+W1gCKFKj2erbHbMWErbaZCblh0f/fuJEJFfIYpdJJN
         5n4g==
X-Forwarded-Encrypted: i=1; AJvYcCXqF5mClL4TVI2jE8u57TiS8LsRMcgG4iqw1UpIkibGUMzUF3+wzQYbvDpkmwhMo/eQ2008EeZ8c/s=@vger.kernel.org, AJvYcCXsR6ZiRf6w1DPNVus5sDAK4WzTOYO/lux6piDQ+N1Yl7TOnHNiCLlPi9P5GJTQV3GIxScPCrtJaqgsgYDv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JVuZ2Wr0RJqijLc6Fs6nSFdFfheQeYoQa0hBw9FqyTFZlUo8
	6WacoUx64CtiDo2KfA4Tt0sURcv5ESCe5CgCfwmKNGbJjNUXawYs9Mj4YOXN
X-Google-Smtp-Source: AGHT+IH6YIckWtCF/wzgTaw+GP//kROSxCeGObYnfJTTUk6NLO95fDWadOhOgjN3osOrjgNowhfyqQ==
X-Received: by 2002:a05:600c:1d02:b0:426:51ce:bb14 with SMTP id 5b1f17b1804b1-42f8216591dmr15272145e9.30.1727974193817;
        Thu, 03 Oct 2024 09:49:53 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0134sm19783385e9.31.2024.10.03.09.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:49:53 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 18:49:38 +0200
Subject: [PATCH 6/8] iio: dac: ad5770r: add missing select REGMAP_SPI in
 Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-ad2s1210-select-v1-6-4019453f8c33@gmail.com>
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
In-Reply-To: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Cristian Pop <cristian.pop@analog.com>, 
 Mircea Caprioru <mircea.caprioru@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727974182; l=754;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=jvLWzH4oOslszdfS3NY5Cj90RSF7nGqFhhnrSrcckog=;
 b=7yuGPXAxX+CadwoXOj8P9jFMWyneZSDi8eXl+AVHJfAfb5lfH1qDVlb/4CjmnetSpQ++GLx2R
 2ZGxi1TYFqoCzoHIqUXyhYnJLo6GOL+GKlTrMSwWF/bDeXihusJWn3H
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/dac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 1cfd7e2a622f..3160b10f2752 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -262,6 +262,7 @@ config AD5766
 config AD5770R
 	tristate "Analog Devices AD5770R IDAC driver"
 	depends on SPI_MASTER
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices AD5770R Digital to
 	  Analog Converter.

-- 
2.43.0


