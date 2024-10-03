Return-Path: <linux-iio+bounces-10092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D532B98F87F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79991C20B08
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E521CDFCD;
	Thu,  3 Oct 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlwIbgrz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE51CCEC9;
	Thu,  3 Oct 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989510; cv=none; b=OOXvJmCt3DoxLbVmWXesxcQuf3C2O58qdWlLIZ0/ApOrQahiayFesx3PCK9yMrE1hQmplp8ScG6d3bNt4lnsCDM8U7y+OqyX4DPTGxKYhNK4N8ah4VGsyejYA9X3zbvM8S1MoHefKQLrWOkja8IHGk1Y0sj4+5pdvuvS4pQLM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989510; c=relaxed/simple;
	bh=rwzs+R9n07DgazaacHGl+cO82Lh5K1ZxeggqDpHV6XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvH25hHwODypP/0wKu1DaacIUQT3OIH3R48rmcR8sL8xMbjMuiOPw9TNLf9uLbQ8NB1o9WOHGeAopD2pMilezfWtlYAgd0inK1RHs1PEvGgtZmV4d/62lTN8NtOEksoYwRkPIvJg/LrBqD5uRqXdkHz0cU2mJbQIyeLBuzEpsRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlwIbgrz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so11435095e9.3;
        Thu, 03 Oct 2024 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989506; x=1728594306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bw72vsU7pP0++ACq6xhGW85isYA2BPlmk83ue0GWjQ=;
        b=dlwIbgrzgReCFcUS3vvStpiO3VNCtS79MxqleLL6pKMnxYZqZklA8WHeu9FodkXJqP
         Nd97xwyUq8rUOiZ2LYzIp6/LEUFmiuch/hdbDwQovmG07X3ujjH6CNa2bRXDzD8w6Zt7
         KfD1H2J+eEgsz7gBpngxjtj8HECZqj+Ccz2HCy7YCx5y7NUpfYR+nB2rxAA1+fvqGazG
         L4wgRlueOO/uvAhpzF6/e/5xvGMSXqBzroF1RUP3tktufpyNI0DmqW0N4lBupzZ5urwB
         O1sJurlX2lweIkc79HfYRU6uXAnRi0oam4pqy6erPcUIngfWX2uB26sWO5/dyOW0h8BL
         tveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989506; x=1728594306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bw72vsU7pP0++ACq6xhGW85isYA2BPlmk83ue0GWjQ=;
        b=R+fag57KzSb990898isnhAT4mOmxK4nv73uZjuBfiw19ze61HHOfN3kT2MUc1eEI3D
         dMJeDnVn0oLBKcHbtptcQjwM3ipJd3EGlkQEDCwTVtX+KfdaAos/ezmPvTW4MW1KrYA+
         rBNhxWt/rF9ieDfKB0FzqgHp2sIYAtF7Ldc5QjoAy7fNQ8IGFpglVR3RJ9RqnlZYshPo
         Zjy6eOGDOJQQ/woMivdljEu//8uA5aFue/LdJCq6l5v0kab1OHTTAab3vZ6aE9V5TtOF
         v2tWI/0lJwiAGC2cRGk0zimLUPUQUWQG/ihLFBRpKvVkIwvPUZ0nGLfjK+AuOE3022OD
         /+KA==
X-Forwarded-Encrypted: i=1; AJvYcCWVUzXL2fuQBu5dXyNZaegZG/r3vRhn4gFJgEKn2VfEMowPyiFZJXeYqd9dscbcPKAtv+ygsZ6A3q0=@vger.kernel.org, AJvYcCWwJNwAuujI9k4KrCTdbCT4vqH51Rm9xhzv8IECu4zUf2Gz9Iv1C55S9wuZ7E52H4w5T+0E90bCiue17iGx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZcoGSc6hkFGuwovjdoLdjhjPHZqwbTib+UoniR78Be0iYA8Q
	fkkHMNN7Jnx7dJOAt2qZqMsdllcvNtMi3vQf+0p/VJWI0a+UlSNAfE32YFVs
X-Google-Smtp-Source: AGHT+IGUvFIrKmVGP9HMIQm/+AQPKmsr7yJ8IuezitZaI67Q30TpNn5dpu7yECsxOQcu+XtBtUK8Wg==
X-Received: by 2002:a5d:404c:0:b0:374:c8dd:ea47 with SMTP id ffacd0b85a97d-37d0eb0b38fmr335072f8f.50.1727989506451;
        Thu, 03 Oct 2024 14:05:06 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:05:06 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:54 +0200
Subject: [PATCH 08/13] iio: dac: ad5766: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-8-67c0385197cd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=848;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=rwzs+R9n07DgazaacHGl+cO82Lh5K1ZxeggqDpHV6XQ=;
 b=0Hx4vX79qvDgIRspyDhx2lO7o12cwW7KwU40Nfak/iQbYJ1tVR7RoFkOxE9e7Yu+9MKZsvCM6
 /eCHAd8gK/WDrT12dH1j+EOiWvi4l/37dwNzku0burueJe0ZANo+xl9
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 885b9790c25a ("drivers:iio:dac:ad5766.c: Add trigger buffer")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/dac/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 9d4600ce0427..bb6cb9af9ed9 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -254,6 +254,8 @@ config AD5764
 config AD5766
 	tristate "Analog Devices AD5766/AD5767 DAC driver"
 	depends on SPI_MASTER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD5766, AD5767
 	  Digital to Analog Converter.

-- 
2.43.0


