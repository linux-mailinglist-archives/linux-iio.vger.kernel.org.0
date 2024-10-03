Return-Path: <linux-iio+bounces-10060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B42998F48D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0641C20DD5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6231AD3E5;
	Thu,  3 Oct 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxjLOwxE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416321ABEDF;
	Thu,  3 Oct 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974201; cv=none; b=TbXGMg9B+HtnkGZ18T38CQZkOPmpg6gaOn1mO55RjKDRViBx4sU6tfs6H6gsIgg782Ol62wxCr/AzPWSM9/UBv5MQz95NR5g1pb6Ftm2whaSmJbM+/xC1Ul1TNgM2/Z+LPZVvHW5vfojERaPP4pwydc3/STQUrNrU4XLx2iRWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974201; c=relaxed/simple;
	bh=Uh91tTL/mMMJSpE+mNqFNymkeRxM5fYzexOGyP4lCJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7R+yCE9UX1AL2flVmZ2PJy4iXEg1OAdygd12tR65RbtqyaCEcaGbcTXpSlMV5Gpc/O4Sd/VRabYTA03L6lqxA37MO8AF8xwQvxmi4jIuu3mDOGDV+9gyzft9kdibKJlJG8U/R9WpYsrq3G/+JvCtASjkvFn6WeXw8xy8VtlaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxjLOwxE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae102702so9904595e9.0;
        Thu, 03 Oct 2024 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974197; x=1728578997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjnhERr66k11ipGDbg0FidSma7lpRl30hnVWArjqldc=;
        b=FxjLOwxEsYTFqvPwKpguEThAta4DJEVtaMJ/PCAuK5oDh3oL1spJJhIwg490s3t5zc
         uIf9rr686mZNVg+4TklDhgG5KHI6BJcgeWPkskhZoQtqgSuM7m2I5FHlIBkSPxKHDdJC
         /EokMW/oFPBEW1zo1ZDYJVhdyC5tgozLUKS3I/WD3CMNQzB3vJHLng3CyuGybw3Dhmxf
         iIhD1dP3q3//THxqlU6bcWaiIqH93/DD/jYQBQcpfX4ebNpr5hV/Rge5F1fH2lHzdtXz
         4pXqcPy0pNs4c9apW3rNTP07IWss0rnOpj0yPcQFDmpjrqDlSN7tYkQuoYGH/AYHk5P4
         MQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974197; x=1728578997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjnhERr66k11ipGDbg0FidSma7lpRl30hnVWArjqldc=;
        b=qKQ+6P/63BxTwWNgWQNICTtmTveUxfgPFHKxXM2TcWFsOfdgmjQcGeA06yN+NQmcFf
         xvuycsQnCIwTi5EC+YKjQwxY+ol1Syz50XzIkczW4rwQvjwu3ylVll08LbD3YMukj73w
         AjEfHuBQlitPaJnrS9CI567GJhkjymBL+9bHPGzFPad6qNJuKHDqOhrAijlSCWVlrrfl
         MOgZj2vfutK7Pafa9ezGfKZOwmchV6L7UPPLbB74EfgfKJlsh4WIG5ibzH4HPDqhudhY
         aB/beOZA2hJleIM1s0fDweMDzdOonmhowlshlG/T5XTfT0/MBJykaSYwCM8qmp5AJg92
         3SFw==
X-Forwarded-Encrypted: i=1; AJvYcCUAZbwwQDGNBWLuuTSLd4CsHqHy17E6kD56jobXxOs+IDy8JEQc5Bgqx1zm8uvma4CmCHLdj8ZHv1jL+CJR@vger.kernel.org, AJvYcCXFopsznV7LwVocSIU3Vzv7pAqD14onWRTF/X6l/yPZwdyz2zyCmMml2DDCfhe10uA64cibtdIojhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4OWhCKmi7fkGWTYywEwSbjGoiwn+hW9AWwFBMENio6O4ZjUll
	9n5hvHAE8p8GyWp41Yxw3F0r3FojjVs9IbJDt2JjJ2CRFrjYkzdhISfrziCN
X-Google-Smtp-Source: AGHT+IFF7HIQj3jQEZ/yr4OHl2W5P12TdGeEHUavz1284RR+ngbaMCxpz4xpOmNLAkuKhpc54/TpxA==
X-Received: by 2002:a05:600c:1c98:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-42f777b5d7dmr47369045e9.6.1727974196982;
        Thu, 03 Oct 2024 09:49:56 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0134sm19783385e9.31.2024.10.03.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:49:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 18:49:40 +0200
Subject: [PATCH 8/8] iio: dac: stm32-dac-core: add missing select
 REGMAP_MMIO in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-ad2s1210-select-v1-8-4019453f8c33@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727974182; l=694;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Uh91tTL/mMMJSpE+mNqFNymkeRxM5fYzexOGyP4lCJA=;
 b=XJFEQuvWs0SuOgP3aoxyqHKVKo8NoRSCk64a7H65oTY/BHoLZhos3iPR6yLnBwIYkBwxvVT2e
 ogB//0fTwBRCPjCEL/R5Za0G6dyVwJkl8BvSQdoqAq4QyOArf2ZPY/A
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of regmap_mmio, but does not select the required
module.
Add the missing 'select REGMAP_MMIO'.

Fixes: 4d4b30526eb8 ("iio: dac: add support for stm32 DAC")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/dac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index f13daf0fd9f7..a5d083804b1c 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -485,6 +485,7 @@ config STM32_DAC
 
 config STM32_DAC_CORE
 	tristate
+	select REGMAP_MMIO
 
 config TI_DAC082S085
 	tristate "Texas Instruments 8/10/12-bit 2/4-channel DAC driver"

-- 
2.43.0


