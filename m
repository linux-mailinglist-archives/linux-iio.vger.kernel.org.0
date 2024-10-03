Return-Path: <linux-iio+bounces-10087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D75D98F874
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA935B2170B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463111ABEA7;
	Thu,  3 Oct 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7tQygjt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888811C3313;
	Thu,  3 Oct 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989501; cv=none; b=jDgPWb5DUiH+0uSYDoLDAIgahyCKB3Cdr9WarF2fa98c9RbyoERmTfRgfTT9Uxza4Z6SqCKthLkXbx7bCsLnJrNpfhXoRnhJ1N2kyx18MPLAbfggXo1y/9nJ0/v1ifI796QFAdIqwNbdLaOD4rPQOSkZG9ozn37OAgSI8HOi/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989501; c=relaxed/simple;
	bh=f8SNlbodZ6+8Ge5+EmksbhgV3QAvjXrOzvqennOTPB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqHDTtEMFQzxwKONYGxf79TWKkB7KzWyP0mVBMZ1EOt2fWRlrwjkKrtQaifqE2xsW+nEoKfi2PlR1H13TlbPsDfVOig5WKK7cM5KHmdDnVBhTITRw2L6J28oE16zPvLKi89XHuIQTzwOy5+tTq1XdrWcj/WI7rGd4lJ57WCufQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7tQygjt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ccfba5df5so1052318f8f.0;
        Thu, 03 Oct 2024 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989497; x=1728594297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EC5+9I7pvxrN68RX/sQyOKXnfn5s//W7Dk6RyljFGzk=;
        b=Z7tQygjt22uz4NAMupNukEdaURkdVZIW7pR1mppovtM4JjjT7rL311jk/tHyln7yGj
         ZQuTI3IQ1r/PfI1uDT6sJwnIgAv3KNxLiEHs1FTFFCwCnygNg+tLqWCXWJyCSvbwSI9V
         iSrTQTtAoTCqH9eTgAVmSLq+V0qml3cjbSIL9fBgWc623VsRz2Fe9GXcTDO/Z3U6/zHb
         nrPUMXcH4NTz9/4JCHmEteXCSbMhAZbusQvnbGNh6N9Z860GwicDGbtKLjuvHogBaGSY
         bCL+o6LDOym6pH7E9Yu5tuwOuGxDKDU9/9GI0yIYIiT0BsVWI+jkqB+DVM7QWcG7gG0N
         z+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989497; x=1728594297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EC5+9I7pvxrN68RX/sQyOKXnfn5s//W7Dk6RyljFGzk=;
        b=Igh4hiDJnUe1JjP1CaDc1EfykfgeU8ZTbrUPWnksK/VacVjNedy/IJkv3CEv5MBhl3
         jn29eEBdbuuC8P99Nvk1mXfaC85BWfKwplqSoDiR6FgfKTihNCtkDwfK6CtWPS//eyZz
         V+Wrh4XuCV0LnyXW9OA5sHDZHOAjopMIm5sEFCfq1Ud7f9K7Vr0LGXYw1lYw5KTonUBe
         8kErI9kMavVm6EMCKFrDrsWTkbxPgKwPooAzI2lkmSTP14saoU0l6DNtb44V7d3fd1Nt
         bqOCd/uU/Iu2cUYWlWH6WHlXLUGyDAlmZ8WKOZeDWVfNTPtR0hRJPgp7h2Xgn++pKzbP
         Tpfg==
X-Forwarded-Encrypted: i=1; AJvYcCW3H4aCeXfrYDUoJ6F4Kloi1OgdJUyJOKez2jD1APwL1SW+2gZpnuSXc3Da8TUQ6B37bSueXnFVX+b6TTd+@vger.kernel.org, AJvYcCWFk2BDvlw9mKu9UakElVVx1dBQbTbgk5xjvnzdyDRfCFah/1NkxxjSZgpJS5suY3sURbEcSXDrbn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGeR7MUT84s+SKOa76dlvxCt2sb3SJZpW9g4w4L+5j1GlSJIS
	tLYkNe04Rpqn+wintB/eAnGUgCMna+Md3KTHRFvO7CNuGq8b7VzVwV5MzmId
X-Google-Smtp-Source: AGHT+IE3KPhP/UI4FTdlWdhREPWN8iub3RMea9yPj/gEhA5jl9sroUoILaxUDjdgmOPs2n58+qHVwg==
X-Received: by 2002:a5d:4908:0:b0:37c:ccbc:6573 with SMTP id ffacd0b85a97d-37d0e6efee9mr393392f8f.18.1727989497311;
        Thu, 03 Oct 2024 14:04:57 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:04:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:49 +0200
Subject: [PATCH 03/13] iio: adc: ti-ads124s08: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-3-67c0385197cd@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
In-Reply-To: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
 Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 Mihail Chindris <mihail.chindris@analog.com>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>, 
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, 
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, 
 Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ondrej Jirman <megi@xff.cz>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=835;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=f8SNlbodZ6+8Ge5+EmksbhgV3QAvjXrOzvqennOTPB4=;
 b=dpZAUpjVcbCi50GBStpjHuE0+gJtab1xJgx9jGeI8q8lwhzCsUDn6wIV7mO1OlTW+xjPddFKc
 F4kQLbr/1oMD7GUTiikNhilpFdnsGxaZnlTHmdHM6b3uTvSRWXLahNG
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: e717f8c6dfec ("iio: adc: Add the TI ads124s08 ADC code")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6790e62700fe..45872a4e2acf 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1493,6 +1493,8 @@ config TI_ADS8688
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADS124S08
 	  and ADS124S06 ADC chips

-- 
2.43.0


