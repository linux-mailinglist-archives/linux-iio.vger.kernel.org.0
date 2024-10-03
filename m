Return-Path: <linux-iio+bounces-10059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382698F48B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4111F21E11
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0408F1AC884;
	Thu,  3 Oct 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfXn9TuU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CA1ABED9;
	Thu,  3 Oct 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974200; cv=none; b=UacuYvuhmL4ISHXKxIwrwC/I6/3PGYoapizm+GJ193nu7iImm2nGedhD5f6wMieXXUnRQ0HEAwMsDZOcNUTlHhBrvopwUYp3tDWEhkz1m7BCbb3NB1GPfEMVv+Pw/XydmE2EZqjaygvh4in5V5yndmsrpbxvj+31IIW8rNATZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974200; c=relaxed/simple;
	bh=7koLyHPDo+qEkV7cTyZAP8yY6rmuZ3JOGuG5yYfrBOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AF9Sthwlq5osjUUEEWEDBLSnkoUo8sJ+cdZSOQFtmANc6047drRVn9QVPDXW15/N89WEiDjnfpNlQI9n87AfqtaQlAtqx723j5J6CBKOKtvXVyzef0JOcU64GwrWtPQQzIlfRMQLyLn4XwnHkBHsDCwPNu/5WcBiz8LgfarJSw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfXn9TuU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d56155f51so137725666b.2;
        Thu, 03 Oct 2024 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974197; x=1728578997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoUh692mjj/PuFEXCwDXCJ5PT3l2iDf/Tiv5bvQT/sY=;
        b=KfXn9TuUMNpukwsQGwIVvfYkCddMZlTjKYSKkZ467jJi9s0h8U+USlaUCcWLe8uL6S
         ywga81vqdgBf6yDPVlqqQK/RhIZlClwTnXX+9pNM9wQsCWgp5Sbamkx7jgrBAe2L7LKb
         VR8Fxn/fpiIB6rji+IRFFpZUdNbQna7iCLLPdZKZwACpqaLu00/I2Q27RuCjnfCaEYEV
         HUMImkpOS+jceiuzZ+wxFJsBDUXU1P94XhVBDiQ11Nuw8mGD6YpA5jZqgSAJrBhE8HPM
         l+rjqQ8YlpkrPDMLt1V3KlmOA08voNujsjgvGAeU3nmA475CIcZr8KvtE7XX3Kni/htI
         HH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974197; x=1728578997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoUh692mjj/PuFEXCwDXCJ5PT3l2iDf/Tiv5bvQT/sY=;
        b=uwz/hOL8lEDExGpYD4ByXQJa7mspAwBKOilX7iDoDZ++sSf6MweiFcA6g1mSeRwa9J
         EKz3j3xCy5fjmb41RokFBgIHb5IG+OhDQfSZKNvIcxrCHWaxOtuc0CABZc+09jGCIHS6
         +IyFgBzIeWqAzo5xkBc7YUKJOi4d3st8U+Yx7AN32gT8+AkLntWvMNrf2lsnKdgJLFKZ
         YZhGn/0WxD3/tK9Fk+pRWjIKTbWHS5Nbvnhid/ffC1yBz6Y6VdULJezxjhZpzzy5cCXv
         ez2AKiUt3j90Wij5iwZHs/2osGMwXYEPpUZ3NxhLijhuzGK/hUvrZHlfhW8qLrNagiY3
         zWiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyk5YHwg7CJ7Tc076J8L6V/77h4H0VbswPHl9JSQPujzgBNnQidILDahmb0rD4jCruO7RwDrDgT60=@vger.kernel.org, AJvYcCVz3VfeeRNvHAgmPrdYABjfmPvWy52xFUMBg63qAeC9mPVrS7oWBxcxMpFyZahPguyDki6RzByEkvlNQ3k9@vger.kernel.org
X-Gm-Message-State: AOJu0YzwndBxGyeVyt6172ZHxHkDujVB4k2LVHtm5GcQ1PCZ/9SwJv+D
	yLbVVBtaoCdMcYgOrsDYT8zxqRbDAlnZb/Rg4fukqmO8Q5aJgKzGXG2YqCiw
X-Google-Smtp-Source: AGHT+IEaZu+RM6wUMOtfLrYnm4ThrLKwdBx9ZufmoMfeNZMzw1YjqoCW0Js02LEOGbMLEaJ+fGJFhQ==
X-Received: by 2002:a05:600c:1e07:b0:42c:b037:5fce with SMTP id 5b1f17b1804b1-42f777b204fmr60095315e9.3.1727974186098;
        Thu, 03 Oct 2024 09:49:46 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0134sm19783385e9.31.2024.10.03.09.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:49:45 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 18:49:33 +0200
Subject: [PATCH 1/8] iio: resolver: ad2s1210 add missing select REGMAP in
 Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-ad2s1210-select-v1-1-4019453f8c33@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727974182; l=827;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7koLyHPDo+qEkV7cTyZAP8yY6rmuZ3JOGuG5yYfrBOA=;
 b=6Ubv21WEcM1kx7llZHyaJOSdkLaa+UtvERt9/khe+pXPBQPIinL+8mWEWGCAbKmYzk9ea2XEx
 4+r3BmSXeYhCo00W0wDYTMq0nHptpFAZgkbn4VNvnl/wVxSioAB7dos
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of regmap, but does not select the required
module.
Add the missing 'select REGMAP'.

Fixes: b3689e14415a ("staging: iio: resolver: ad2s1210: use regmap for config registers")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/resolver/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
index 424529d36080..640aef3e5c94 100644
--- a/drivers/iio/resolver/Kconfig
+++ b/drivers/iio/resolver/Kconfig
@@ -31,6 +31,7 @@ config AD2S1210
 	depends on SPI
 	depends on COMMON_CLK
 	depends on GPIOLIB || COMPILE_TEST
+	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices spi resolver
 	  to digital converters, ad2s1210, provides direct access via sysfs.

-- 
2.43.0


