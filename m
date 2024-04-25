Return-Path: <linux-iio+bounces-4520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5F48B2487
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 17:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2DD285CFB
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E7414A616;
	Thu, 25 Apr 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lYm5AtCr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8C14A4F4
	for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057418; cv=none; b=dEyBz8B/JD2Hjt2QM006Tq7Q8/NXRWQRjb799FwMKUXxUIcjL2k73YeljEa9qOoWKeQKo/sG6nG2qY0XDR4Nm/ZoJIAsOOAlwlBhUmnPUKVH0/JaGWd4zS9xprMR+cujwMJ9Tc0lQWofTiMmv5x67M9GGbWgtB7JA6c98zrC4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057418; c=relaxed/simple;
	bh=c0UVqkjMuNtarShlxI0bIDMYPsBOuAUJ6QeQyiAWEuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7J+7WOQY+2tdd1YWOSzNE4ec0CDpoAFxPQ83ztNVyLTTMrB+cGaw/vHzSqMIc954DlPg+R8/KQ+IFB9XfBT47vVy1TXU6dsuv5x6L7qI58mcYkBlBJGKPDmizK10hK484B/FOK5MckpEPTY0MtvNd1GMzQlxs80sAv0TrcpQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lYm5AtCr; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-238fd648224so438830fac.2
        for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714057416; x=1714662216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuUgN+eqDnD1TSwHoUcLirGapuP4idukeuGNZ2DNfLI=;
        b=lYm5AtCr7ClXsH4zVnZ7RefhauWfTi6b3MRzk5sA9543gVL5jRqOaiUiUffW0Tcstt
         /dciL2CXA9/9BOvD3xvt9/ODK+pyoK6MSI/I0jaCQ8BhDBiVHAwR3oM71QiHVEPU11Kj
         61XRfoylO6ui1TM8dl+dCj6U+nPQqm+NgnmxD+O98aKihv65YvXji0oJHRweIy3ugACJ
         oC+sWjqiXHxQpE7WreUN10iv6LZ3Iv9FDIqrkqjcQzBstPS/VaWykDWt+G7fmx7cYDjl
         rzM9icX9Oka5gT0ugLLIZV3pnf64nuWWxO8U15BqSF7by2iWlod9mcyTrkWbZMZi3JKw
         k0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714057416; x=1714662216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuUgN+eqDnD1TSwHoUcLirGapuP4idukeuGNZ2DNfLI=;
        b=Lur5Xcs/n9vpuKkDw2czeqZPIXv27Lw0w424GYMXhdynC9ab62kEMui14Xcwvppotc
         DHFEkA19zBKlOT/H2e55qf6F9Xym/eLlA1Lm3WrZFr4i0i04Z7tDdqD5d2cPZ38RzNrL
         rv4WuDuu/T5Ma9uELOYYDinsKGShcsjQHDV/HcBrU0KEke6ZDm8HTKfZO1Qh7SeZylLY
         6wwDQiNxnJFg/4W+jK1PfK3e3Ww+A1gbx/WzsW4a4FTo0zWzNxZlUNz9lt0fDO+IRSrD
         1zFDt8/H7rt8HMlR+j5hpPtNxLQhidYLNeZelLU9+KZy1LaLn4NdrrWt49A3GaTWBPO1
         DIsw==
X-Forwarded-Encrypted: i=1; AJvYcCWAqKA54T+54mL8VphRsrgkhoXto+P95JoQbQ7+2xbsMIAtAki5FTm9s3Fp8aNrfVkDzjz2lM4//o8I0XnWRX0zdW6FPrgnLBVO
X-Gm-Message-State: AOJu0YyR+4vAoTZH9RP1+MhwKR6SOohkM9XPUuM96G83zhu8Ye2GQKhp
	8gB+MUXJ4TEKLTXGFeUHFD1yk/KjoD8ypErnyXpPQvquJInEw/donjvFZU1EhrYFj9R5UIBb0JL
	F
X-Google-Smtp-Source: AGHT+IFvAtaidOO7h0zkTLuuS0Zuix9lqDgu9+DKxThfm0jLTYtjgYSEE2bX05vg7lHkXPUfguF9Bw==
X-Received: by 2002:a05:6870:9f86:b0:22e:de21:e084 with SMTP id xm6-20020a0568709f8600b0022ede21e084mr7083274oab.9.1714057415874;
        Thu, 25 Apr 2024 08:03:35 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mp2-20020a056871328200b0023b6d4723edsm166739oac.14.2024.04.25.08.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:03:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] iio: adc: mxs-lradc-adc: don't set masklength
Date: Thu, 25 Apr 2024 10:03:28 -0500
Message-ID: <20240425-b4-iio-masklength-cleanup-v1-2-d3d16318274d@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
References: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The masklength field is marked as [INTERN] and should not be set by
drivers, so remove the assignment in the mxs-lradc-adc driver.

__iio_device_register() will populate this field with the correct value.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/mxs-lradc-adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 2e60c10ee4ff..8c7b64e78dbb 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -724,7 +724,6 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	iio->dev.of_node = dev->parent->of_node;
 	iio->info = &mxs_lradc_adc_iio_info;
 	iio->modes = INDIO_DIRECT_MODE;
-	iio->masklength = LRADC_MAX_TOTAL_CHANS;
 
 	if (lradc->soc == IMX23_LRADC) {
 		iio->channels = mx23_lradc_chan_spec;

-- 
2.43.2


