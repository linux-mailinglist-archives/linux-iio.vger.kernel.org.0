Return-Path: <linux-iio+bounces-10308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D065F9937ED
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 22:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BA31F21E6A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 20:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143601DE88C;
	Mon,  7 Oct 2024 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6RVNW4+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413491DE4E4;
	Mon,  7 Oct 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331611; cv=none; b=b9vpaqHcbhmBrLqxs/MfIC1blMWS/7TZMHxm940kZKu8MrwmaS7Z/2AmWFRcTkHeBOXH41KHhlUkYiIt6fYZO82X8V3QvSKWuRdDiCpx8bQeo2HaSb/liYu2UX1JzkYHXQkg6SCvl8dx1seRRYR7IxvDSU5Xq4mdibaKlPFaNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331611; c=relaxed/simple;
	bh=cSrQdFh/glnM53KZpVEaEFTaQWDmzrMDUr7TZOHHYuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAg9QUMjOojd3nx36rFawPMHOvZEK/3g1iT3v0xHSw30CBvY5Cs1WR1ieCzL7pGfAVkP9wFyRmzRXPi5nEe3PuiKoHLMqkV3vt8WenKoqoLpTL+M3c9lPPuqnRgCuKlAOMwekitIvW5y2f0HmnwYuiE580k/axEJv8p2yUd2xU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6RVNW4+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so65309565e9.3;
        Mon, 07 Oct 2024 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728331608; x=1728936408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zc6In5fZyyrs2++UurZyEkhU82+YsB8yxwapLjC+8nA=;
        b=P6RVNW4+zPSp0xNYZSGm5Z6qbpcT56ZuaLK/BRJZTz4Nxq5eiZr+X/GVnxdOWofxUd
         pIOKVqt+iShRYvKlwLQa25tEtsyazCbF25CrDxeIUzOmFP/RhRjAN99DYTQPIuLEZ3cE
         MMLg/aWUDRvXHdQ8y8rnCe0FlX7yASeTRVqpsgg+HYMVtFz+CdA9eqlQZECmKyMPJAJn
         SARsbw+xk/qrq2N5DDTaEP/JdJx3TioO4xAqsEcTNMqu+EgC7vMRpA0QG4qAp7x3NtCo
         S47J6/Ffm2thn6+QfBw8aYjc6TL5v+fvmpZSXCKCDeiZEx9Lg7kfpkHMeNZMOQWgXDup
         u5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728331608; x=1728936408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zc6In5fZyyrs2++UurZyEkhU82+YsB8yxwapLjC+8nA=;
        b=v18/iu7a4U7uktLnNhDIZfHhYqNaKvkDHEsaIjLusfj5YCQiSPsVoUwkiy3BBx2tpy
         rVkTpalZfCnjS7QWYXIk8yjB+OhT3lhW27iBjiVidgjVS0gUPRAoJ56rYUlmvScqRz2D
         nQj2V32clvJkwnOazPfH+vl3LdwrGONF7Zpd614F5A3WJh3uIcE80CeTA1+u5HXlyMCI
         cKrKJn5cfp57skmi291EddwFVMMzQmWN/ta/aBZnUTBvP+pjhQuh0mIyWQ2ebSfXGlP9
         sWIeo6c279ZX4m+3bDTTPkw99n5yX20Rl0IY3026zAfLQGVcK1yhy/E8M70sQz09zMyw
         HmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8xNopjk2471VLS6sZy33IJJbI6diz1MKsCdCdOlOgUnpYeq9Q80pogeE6m+DswuvT0ZuLPfp+42ln7A5z@vger.kernel.org, AJvYcCX5oSPQx8evWtWycuYAQlg6V/e8XBMW3oZrG0yolYAdB+jmqigeOae/3j7v6VCPmCCdFoTQ1S0M+jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwshBiJqsgT/41P9Gyif/ADVmRnh1EySoNc8WZTJBrYHAngK2nX
	fQp11gdUHs4lBhyx1l1QKfjoYJOUecBFNisYJIuwml2NB1Lu93/7
X-Google-Smtp-Source: AGHT+IENfBCHeLxTGZh8Hoz+XNCHNjYBLHSP9Ra8mk1zGDB1Mbw/r4uIy0359R6Its3zqEaZFgMFsA==
X-Received: by 2002:a05:600c:1c90:b0:42c:bcc8:5882 with SMTP id 5b1f17b1804b1-42f85a6e05dmr131300045e9.7.1728331608489;
        Mon, 07 Oct 2024 13:06:48 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-26cc-001d-7ed0-e346.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:26cc:1d:7ed0:e346])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89eda21esm85547155e9.46.2024.10.07.13.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:06:48 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 07 Oct 2024 22:06:39 +0200
Subject: [PATCH v2 2/2] iio: frequency: admv4420: fix missing select
 REMAP_SPI in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-ad2s1210-select-v2-2-7345d228040f@gmail.com>
References: <20241007-ad2s1210-select-v2-0-7345d228040f@gmail.com>
In-Reply-To: <20241007-ad2s1210-select-v2-0-7345d228040f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728331603; l=828;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=cSrQdFh/glnM53KZpVEaEFTaQWDmzrMDUr7TZOHHYuo=;
 b=wS3p3LN7m6/BXHDfGLGD8bzNgDxDsOwDO7XsFfmzgD/OSNKDNgUlxVwtDdJLXOnokc4YlBtTb
 GmpR5/3AWliDXSlowGzKNnMmI5xkKFrAUXr4rmWxkwCBeFZDf5eTDSX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: b59c04155901 ("iio: frequency: admv4420.c: Add support for ADMV4420")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/frequency/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 7b1a7ed163ce..583cbdf4e8cd 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -94,6 +94,7 @@ config ADMV1014
 config ADMV4420
 	tristate "Analog Devices ADMV4420 K Band Downconverter"
 	depends on SPI
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices K Band
 	  Downconverter with integrated Fractional-N PLL and VCO.

-- 
2.43.0


