Return-Path: <linux-iio+bounces-14785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D018A243EA
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 21:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9291670C6
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226D1F7070;
	Fri, 31 Jan 2025 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i3p50MoR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E651F63F8
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355106; cv=none; b=ceoA1yI33J4UqRHFPc4iHQDpiRc9WaKJcqJS/8lhWNJSfw3B6hoMf1iHj5xqUugHHR4OHa95tRXy0HQaBxslCl0lGximXuAvw1E2hW4QrnoDvyy5AgENaDm7A6IfEp0vsvoX3IhdWyA6TYBhnnFUyNvnW7TGGrcuTPaKIQbf/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355106; c=relaxed/simple;
	bh=a4UCT4/NNPETnikiY/3/IXvAqgQyANJWQskJKLdiZxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DD0FWMSxfdqg5ta+JuT4UcPpsHj+A6BJalS6wtNur5tc4otHkUeJP7mMgFVlc4K/du27rRlZZtN9afRkNLIxILIdUJTnKw5ifH8gVs+tEd+UGZwsjy2MBCcdEmfwIyRXjXpihLd9VFCgSdXiByvjAtxC9psxw5WPhWKtCDCHIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i3p50MoR; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2a01bcd0143so1484714fac.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 12:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355104; x=1738959904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNU4SR73NkzT5flFO6XZzV58Nb+8n8xP048rFGpOLNA=;
        b=i3p50MoRqTck66HqRmjce02FFEVCLPd1WryuRoM8Vuk+27DcmPvbT5L1dLrth8Rspe
         SEJB+O8mrL3HlRbKg5VFYWuQCDhd9iOd4J+Lt4BFQJljF4pHcQrCLAKdvLDtw0FlJGV1
         7dEVAyPkdLMXt20S1aFiNAknpOWcDXQLBiMeQMF6UQLyyjAzwVOLhiheBRWtvlGJLrkT
         YS2GUkU7S1H9uADGOi9+20YUVkUG5taerhoyFL8T8fFl/7yBhswxXr+dFp1bwdy7n38P
         1IXFmSQrGkvfN+yZ77Yu/R9POZDUUjLQtzpE/7EtjT2Db+Ut9M+aCRHdVkFBw5e8e1N8
         FszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355104; x=1738959904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNU4SR73NkzT5flFO6XZzV58Nb+8n8xP048rFGpOLNA=;
        b=EJLlxz5sd9kK2dfIH96Cj4ABfWUxCDsoz8PylrGKROrtjxcldLzrmQewfwmfPbhD3D
         XxtSG7BVsQ38uDSO6erFYQlpciTth9HK961kwvYIdNdr4oVRC7Iuqyxm820iL6R3iDBm
         whwWwggYb5jzMLKnvmkEa1tT3CCfW9rmZx53B/YERWZvIDMNo9LnNltc9RdxwSuQPypm
         ntLepFaUCGWdCOkvY9oNYAcLRX0S4u+RTp/1EGpPyeh1nRd1ZFpTSz+Is7SN4Qkc2lNx
         9pddKDmgHKk/ETaNGuJsIQzYiRgpA+RJ0WUr8Z/WFv/wDGkHFpPTmBgISCehiQ9PPuk7
         22Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6FpH0d4w9Tv4VKE7ThpLgfKCvaJu+O9E0jIvzb4E65CKTK4XanTxZTLmBcdGbIAdMYhIe8NcLVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5zV9mXS+AWp89BPEahQYWornGqWAFt5Vah++Vofdh/xaFIY2m
	sw6ZSubSTiyG75FCfxk96snus9WY22RG8pAR/U0PaJLwF5oluUhG9e9QLEPIe1g=
X-Gm-Gg: ASbGnctiT6GP2f8RRTkB0ptbp0IYKkFNXTD+kriCFJlmgq7nIO9UKkYks60Tti71wwq
	qpm+cyUJi3pFIo3l/ySwn9Ccgd1NVL/4W5i4R4cvaldbGMU37lbFFQoz8q18JacgEnqpYPZYCUa
	ZA1LxMFmOHn7jAbELpiKh82x+w9G/L0Ni7rPDXCEdTfqKMphfqPMYa0o30/Iq97utQpIBJsSbCE
	FLEBZx+I5tgE16mEgxauIbLeTPJ5/oPnPsGpw0WfXn8CeJJeQrN9JHyKw/6M2A/4huHD13GLBdx
	H7jKNBLFZ1IHOh+YO1F8mt/pvsxQz5HZbk8ray0R3iTbGF8=
X-Google-Smtp-Source: AGHT+IEjjM8UkUItH0qBBqM7/8yjcARln6tFWMQk1I1vtwY7yg+bjxT3tjK0CN1AwA297vbCg45WVA==
X-Received: by 2002:a05:6871:7891:b0:29e:48d6:2e62 with SMTP id 586e51a60fabf-2b32f06986amr8146491fac.9.1738355104164;
        Fri, 31 Jan 2025 12:25:04 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:02 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:47 -0600
Subject: [PATCH 07/13] iio: amplifiers: hmc425a: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-7-991c8ccb4d6e@baylibre.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, 
 netdev@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-sound@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
gpiods_set_array_value_cansleep().

Passing NULL as the 3rd argument to gpiod_set_array_value_cansleep()
only needs to be done if the array was constructed manually, which is
not the case here. This change effectively replaces that argument with
st->gpios->array_info. The possible side effect of this change is that
it could make setting the GPIOs more efficient.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/amplifiers/hmc425a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 2ee4c0d70281e24c1c818249b86d89ebe06d4876..e8c67c8145b1b9ccb9b70ccd3ce4f5de08f96e69 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -161,8 +161,7 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 
 	values[0] = value;
 
-	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
-				       NULL, values);
+	gpiods_set_array_value_cansleep(st->gpios, values);
 	return 0;
 }
 

-- 
2.43.0


