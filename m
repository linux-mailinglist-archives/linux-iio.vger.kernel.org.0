Return-Path: <linux-iio+bounces-10053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3231998F47E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D795D1F224B5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C501AAE04;
	Thu,  3 Oct 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkraAiYq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA2F1A76C4;
	Thu,  3 Oct 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974191; cv=none; b=CPZxx0rDIdHn+Dn7cuMdYklOTVrTg7dd6n6102lhFPypUiDtGcpjbd6vf1NlA3qXqu7Fl/JQT+9WtGkkkFF0vUlHgfHRdys2WaGn5w1ylDgtHLwshJQCTsTNkkoY2zEbVdcwcUWav1HRNmeWF0uxyHPHtE7DTW0qd1B18v4Toiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974191; c=relaxed/simple;
	bh=HFXKlAA/rf97OjU5r2VevMCOcg7PTn2Wm612mXzTwD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfnNBgc980/BKyOvxAteSm4HLU2kj40sDc2QNISxqMqZE73VHrfLn6NS9fmdzS9c8Bb60jlbjNxs6ru1ztABdmT0ez9QyffiXxOaalo57S3Z3kAM8X8Ia8GA5MRCUJkURzYusRDG9yP9BqwONXYGbUcDC8Qu2j5qw36pdHxmojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkraAiYq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cc9aeb01dso865872f8f.2;
        Thu, 03 Oct 2024 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974188; x=1728578988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzYxjy/gqwyBEwj9WpfkqpkvI6K78CH7nFTrmBBYsrc=;
        b=bkraAiYq8CXf1RDUZzElbg+iCiUpMieKUC3n63y1L6k6UbCsD5bxAzlc0ZEVaXcafR
         RbC3txUE+OHDOzUQdKg9q44yAuKrrBtAqSOUGMcjUlSgn0odus3xrOO2cfJzGI8tvaBm
         cMqxAQdBpkgxkC8vJ6s+z+rPjMwt1UoMlh6btcCvwMeQRbFway/b7ePSypU0msls3Z70
         Xsr0Db1IQopzooyNySFaXwoGy5Ga9Vq+HITVfeLzGEf8Hcqfon/ObubfRQ+nWAacWSvo
         N7aPU5gtyDmR61s/BUdYyxXMobTBY4eUX4UDj/sZUPMYX3o3csTpSPXKRzCuMZnCGCUB
         SyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974188; x=1728578988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzYxjy/gqwyBEwj9WpfkqpkvI6K78CH7nFTrmBBYsrc=;
        b=EYQe3+t+DpGjuXtYwDE2t4f3uaPe9DVzSxxU2ChKRI3pjtppnCIwXJzFSx64WO9eTs
         v+brQ2BIU5/3TgTuyEqt8kHtjWoW9ybj03zqim14Ffw4u8WSNCKnxDcuL04l3atKU5wX
         iq8ibhCRVg7kGZhS9jldoGpEIfiBb0pV6oDTRuQ3UO1O2NgzEDoQsNTQWDYjYCNvHWcT
         VOsRMgik5ib5IY9AHNFVi/vRkTT6k93jZSmCs0QjcWJ6GzBYoy9O6EYz6hCUyz2LW0/b
         pqG8oxfksJzSnjEZ1mM0dWLbDPB2VsgxoPl8tqtOqlbjBs+wUWY9vHSSUvfQ16Z7mAg4
         aPtw==
X-Forwarded-Encrypted: i=1; AJvYcCVpOmWOg/4DosxIAsUiFXzCVypl77jajqohOF45lypUCfD2AiiBZ3qxTfJ4mbUokc6cvQyFsuLevZE=@vger.kernel.org, AJvYcCWAHxiLJI9fnpoSz1hEj0t0Qt2McanhDF4MQKw5hM++PO3FcprIWWFYOZrN8GZ4JZTIotGbxGodPxyAgr1I@vger.kernel.org
X-Gm-Message-State: AOJu0YzojykbCONYEMquiFsnmgyRN9qluc0gKaglDW03JIPeulWGmtDY
	k07hPapVcV94VTEw9RBOe+jutP8xf5WQTFA/0k7PUTL45Uq2xAAblEpN3QSr
X-Google-Smtp-Source: AGHT+IH9gaXJhXP6IPOzYoqiY1/9EFTARzCwFnDdOpe/kCqHL8IF2zBm910Qe2n1A9r7ixvm34cg3g==
X-Received: by 2002:a5d:56d2:0:b0:37c:cfb6:37b with SMTP id ffacd0b85a97d-37d0e6cae8amr40697f8f.7.1727974187596;
        Thu, 03 Oct 2024 09:49:47 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0134sm19783385e9.31.2024.10.03.09.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:49:47 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 18:49:34 +0200
Subject: [PATCH 2/8] iio: resolver: ad2s1210: add missing select
 (TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-ad2s1210-select-v1-2-4019453f8c33@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727974182; l=912;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=HFXKlAA/rf97OjU5r2VevMCOcg7PTn2Wm612mXzTwD8=;
 b=4MpN+amjMx7kJ5x/OI+W2WxrGmaFw4Qki61Toou9P7ILaBYhOAo3UJpm7X6JIpVkYgAsQJtBa
 LjOiGAKXO1RDYm727bnYyPzCVKYLc7SZhS1T44swjwYQnblwJwtKqsQ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 128b9389db0e ("staging: iio: resolver: ad2s1210: add triggered buffer support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/resolver/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
index 640aef3e5c94..de2dee3832a1 100644
--- a/drivers/iio/resolver/Kconfig
+++ b/drivers/iio/resolver/Kconfig
@@ -32,6 +32,8 @@ config AD2S1210
 	depends on COMMON_CLK
 	depends on GPIOLIB || COMPILE_TEST
 	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices spi resolver
 	  to digital converters, ad2s1210, provides direct access via sysfs.

-- 
2.43.0


