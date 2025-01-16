Return-Path: <linux-iio+bounces-14405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93F6A14439
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 22:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582FA3A8AC3
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EE222CBF9;
	Thu, 16 Jan 2025 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3z4Grn5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F014901B;
	Thu, 16 Jan 2025 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064283; cv=none; b=FTetQkPZIx57H4f8xvClbZWELgxI3XV2dAoPQPLkONitV5+EeeRpYS3QKu7xTXcVj/H1C4JnEQGp/OpeA/qV7Ocm4k/YuaVJ1wQ8Vyb8J86KXNZVJNLjDHuiRmJQ1zBk79uQwluKO/AQ00+x6WsRq5e3LBr+bEZmDVVEl+kvyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064283; c=relaxed/simple;
	bh=2fAvzNdjk2hL944W39GIMJC3nCvSwpyPdP7ZbR9lI/U=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=lzRFsAiyYqHX+yPY2AaXLu7SM26fyJB5l8pCGHal6pUk/GEAIy6NEtQTroJRxnMrUX5+R+BGzcg4VoCzyR2DpwvYCbodGOVIO10GLamqwI7cPeRX/nVzV2m5WXoTcsRJlfLs/PzBJ1+2nHSrlS5rPOfyhZr+vcq/hAda2xMllOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3z4Grn5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43621d27adeso9384925e9.2;
        Thu, 16 Jan 2025 13:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737064280; x=1737669080; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XxTGHYdZ7YHMfHH2HGgOdbX57BN9n255CYDMiBMTieY=;
        b=g3z4Grn5pwYJ0gC0fhlkZxC/uKtC1GxG7+2ZV/17aS7l0z2HbuY8ApJ9uxeS3mRGKm
         QM2eYikc1RlrE1aoPu9PpgSPbLTs4IAwvEFD3nFR3m4siL3hAWq9ckNwXAkx1pv6DTnN
         fYvGN7XgoN37DkPFS6TUsHMHVRAz6lJS6ljO5sFgDasQOncep/FgQWdHvIxspb8CDVF+
         DXpNMRTLANR/sXrgVO6UtRqpbJdHedc9QvPGp9hGV+s838gui0Fe+EG0KRl8d4N4LYgL
         itdlQLwv4SIhrB1t5/KfW9nzUGJrqbFcauzE2aZiGbm+5FbDUX2kayISUh7DH4N/Y0WD
         da2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737064280; x=1737669080;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxTGHYdZ7YHMfHH2HGgOdbX57BN9n255CYDMiBMTieY=;
        b=HdQxxA9AQiHo0syvMzv4rgBwfhVAPeFe8oOG56oegkOJC9GsoMmpUUNkIhYviHRhkb
         W69MF+Kyo4CB5PA+h4sFGVruTGqY5HEBzFRdl1pbm4LaBbT8iqXb8XGLILWYt8KNCUon
         Z9cxRyFkHk/JtmCP8GHh+79UPtZ4egR7qrWjDRcJax5FPvCkSh3gnVoIaocK4DHTzkRL
         nkOvc8ucFmuHga5AsROx/bMvNm8C1gMPr3AEikj1TSmupeMszRMWJjTGfEPOp5Z4WI9g
         BUG6R/gmmu3rdDNFgXMPHsScwUrG2CjIFQknCoRN7Lb559aVfQ1uXLpSVg62OIsCoTqm
         YGqA==
X-Forwarded-Encrypted: i=1; AJvYcCUA56dJj5wiYzlBdp3/iik2b5dcSR9ZDxsMPosrelkFQ6sVV1W3K7pPFSmXLY2tG6OhvoBvw7Du2ca+MqsJ@vger.kernel.org, AJvYcCXUftFAZ5yIKR29LGjDdNxytb1hEjmi3tCvBdehL0E2y2rm5O5IhreNtlXYmhej5uStrwImOa7ZWhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCZTspLMEYjfPWOZqhdFTk9EEuZSH/0iXARjIsr6TNdnt4hhL
	1Rx9QXB6cC8hQWWN9CPqzlCCleqq1YH/mcb/FbjsKEjikr2ER7tehmUyE5tVJnI=
X-Gm-Gg: ASbGncvdW76vKULKb+b/iJz3r8VTHneUjJBdoHolmJqehQkvZE54I6XHR0pVtQNRs3B
	mvKmzhiKm2QxwkFJwUTkuy62YfUOv0mkOpDehmoS7TfzsQWGkQDTglE5lSXwoeZQaGxtlupLWr8
	2mpa+ipKvqtbmeAM+/Yj20YThlGynoSY9SuynB9ikQnlfTYR64Pu0KQLx/t5Zh8AdvGEaxSPqDU
	02z/+2DFjytxVhsNb/UkkdZcB7YImYiK8RHGRaXlzIurdQzowk/6lGPcg0jzTXpPgjrqlLyvo2r
	9YrNFeqwauv3hKXaNxKTnKHRRADvoI/l
X-Google-Smtp-Source: AGHT+IFkTFcDaP85g2bkGi04ybFRhGWgUBnrdRYJsxRlMg8SSMpsEHizocZxtRz/inHBH+2E6Fh75Q==
X-Received: by 2002:a5d:588a:0:b0:387:8752:5691 with SMTP id ffacd0b85a97d-38bf57c0879mr146517f8f.47.1737064280497;
        Thu, 16 Jan 2025 13:51:20 -0800 (PST)
Received: from localhost (host-80-180-16-130.retail.telecomitalia.it. [80.180.16.130])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38bf3221b65sm865776f8f.33.2025.01.16.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 13:51:20 -0800 (PST)
Date: Thu, 16 Jan 2025 22:51:20 +0100
Message-ID: <56d3d1f45c08064d13af42f6e67bddad@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH v2] iio: adc: pac1921: Move ACPI_FREE to cover all
 branches
To: victor.duicu@microchip.com, andy.shevchenko@gmail.com, jic23@kernel.org,
	lars@metafoo.de
Cc: marius.cristea@microchip.com, victor.duicu@microchip.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250115130347.10777-1-victor.duicu@microchip.com>
References: <20250115130347.10777-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Wed, 15 Jan 2025 15:03:47 +0200, <victor.duicu@microchip.com> wrote:
> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This patch moves ACPI_FREE in pac1921_match_acpi_device
> in order to cover all branches.

Just a reminder that in v1, I think Andy suggested to edit the commit
message by adding parenthesis to the function name. I also find it more
clear.

> 
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Fixes: 9fdf1d033316 ("iio: adc: pac1921: Add ACPI support to Microchip pac1921")
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
> 
> This patch ensures that status is freed before
> exiting the function.
> 
> Differences related to previous versions:
> v2:
> - add Fixes tag.
> - remove unnecessary blank line.
> 
> v1:
> - initial version for review.
> 
>  drivers/iio/adc/pac1921.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index 90f61c47b1c4..63f518215156 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -1198,11 +1198,11 @@ static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
>  
>  	label = devm_kstrdup(dev, status->package.elements[0].string.pointer,
>  			     GFP_KERNEL);
> +	ACPI_FREE(status);
>  	if (!label)
>  		return -ENOMEM;
>  
>  	indio_dev->label = label;
> -	ACPI_FREE(status);
>  
>  	return 0;
>  }
> 
> base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
> -- 
> 2.45.2
> 

LGTM.

Acked-by: Matteo Martelli <matteomartelli3@gmail.com>

Best regards,
Matteo Martelli

