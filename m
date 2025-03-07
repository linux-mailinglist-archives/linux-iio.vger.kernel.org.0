Return-Path: <linux-iio+bounces-16510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71D8A55EF8
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 04:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BC8173C31
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 03:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764B194A66;
	Fri,  7 Mar 2025 03:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANX+lhTd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106A18DB32;
	Fri,  7 Mar 2025 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319139; cv=none; b=uzYnMBXACjYKNyZeXFfShG8nd3+lUdlZSeKJyaPSV4GPk2XfEEUhYa2hKb2bYZvGtHNAncv9BqcsiDyrmtzSRA+lgcIO84YBflvRSsJtU2X5xLGHdcswaFWZo3GNo93P56qAXS/TseKHbT1wn6mViSWXmmpTOEL2uoYo008wrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319139; c=relaxed/simple;
	bh=tLUqZm0eNJ1rTuuXdj+f/sqylw0hX05mayVEHF7KvZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZRkam0vKq5ge1NZcno+j/N4I/KiHXu8BJBGmHyzpl8uls3JENUB/TzoMHlgu40W/N3Wgs3TD7in/QLlve3XAZvmFdEngG3ag0jWzrDucHiIXxG4RjLSqkPZ4yQRMu2deY690VlI8h6gM3i/EEyFjjgb30VI8mr/qSSJpB57VI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANX+lhTd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22398e09e39so24813645ad.3;
        Thu, 06 Mar 2025 19:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741319137; x=1741923937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnwlMexOUxV2S2U/hpi0ahnFqzZYEy2k/NFTV8x1kBQ=;
        b=ANX+lhTd/odX+QL3+9L3+MihXgvw6tpFq7+C3SAtsg6rM/ytfp5YYPZpi0WK/cMXzN
         Ryu04LPCpbFDDs2+lm9byDqsMSHibFsQzSfM0NPOYIbXPzQpRyyXzYRQch8VSVS/ZZoB
         c282xTEh59vOXlDyK/WqDfQfsKJWpzhlOPB9HgyJx48PUj06MmZLFpi60bXKVj3dC1BM
         OLBpuBq/whj6g8uVO8FXX+dj9muCCqUGOCDO0CFpLVQoBv3LC6Tnmbwtw5tTQf3bPq+t
         On6y2hOG0hGQqwjfbYfvwOArBgjgbNMrLWCg7FZAZ7/8mJtnYiQNLVjXqQ73rjZ2o/RO
         eo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741319137; x=1741923937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnwlMexOUxV2S2U/hpi0ahnFqzZYEy2k/NFTV8x1kBQ=;
        b=AymDKL8OVcenmA7tDaG7Y8RLUrXnpTJORUvLa3tiFhdDDYdgJ1h8zp4FEC2c720m5L
         QFr3GRFdxMAhhafyoJ29QLMlF9+74LOR8tsrv2invqO+GCyu9wpMHqwDWjjyj42nh8oR
         B0aZZ/iZfz3KL8IOav70RXVJugEo42yqOsDjDFm9UWtM0w/8UkuDDp9aLRkex/n65rww
         tzEbP0qnnkAEPI4p1DGUZd0sHx5pLmNeOkkxIb9TotnbJLm0qzho4GBlKUsnHHIxg01o
         +07wB/a8DxYW0sAFnpyIU28m5237UyRFYqAk/W5c5MSGupHAA7+RkVM4eCNkJEfqIz9f
         m0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrfx0Tj4vDYWyDj10GkWVyuuVg65uSTpdClScbVGBBv7HxmPAXwYoGGXWDLkpa2yGvyuTiGX0gXTEUbGZm@vger.kernel.org, AJvYcCXPWec520d+QouOv3FwG/lFDDcuy/mmzl2a1oVYVs/EKVD+U4f2gEN/6MqYh6Kmrw35NwZ1osWL+hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCkXezDfNKKm2insJ5sZCN2jSaYJG1C3IW+rSzo0j0VGmYuFMx
	95/HLTo/6LTN8jJrxI2YpiSw02nawlCIqhLPHVeW8ojrZPCLMS1q
X-Gm-Gg: ASbGncveMsYJNm9xCBQhtfKypg6uXtjPWYg/44du4XMNGxXJ0QCTyzk8/06MY6HGtNh
	oaSaGsWALVh4lEEdOiYF18nVhAFItMhpglRtR+l1WHnVixYx7aoTlTad567N1yew6bvY49nqo6O
	eplx2It5A+CtUbeJZsJ5nXmCZMv/HYVhFPrVsXilU69W/8CFSAyNWnWbKhHJTCad+F9nKYCShVW
	NuKNV3O2v30FyXMAbxiZxv06b5NfAO+lDeCsKak4Oi1XsHzcYso0hBl6gsTBAGcyRbWlROTk5W3
	xqIbHp5NAk4DfCvEszEZIYNpNegASWZCn2jBkFdZgFw/IF4b+aS/K4s=
X-Google-Smtp-Source: AGHT+IFuaAkfRLNIy6uNerSM149+aN7uTDDzS2Rxs5PjmbFtqCybN662n+tZe2npxQsWSCFir8snag==
X-Received: by 2002:a17:902:e5d2:b0:224:e33:8896 with SMTP id d9443c01a7336-22428886514mr30029155ad.11.1741319136850;
        Thu, 06 Mar 2025 19:45:36 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a91b8asm20163315ad.171.2025.03.06.19.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:45:36 -0800 (PST)
Date: Fri, 7 Mar 2025 00:46:29 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: gyro: bmg160_spi: add of_match_table
Message-ID: <Z8psFU4mhW76jFqE@debian-BULLSEYE-live-builder-AMD64>
References: <20250306145740.32687-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306145740.32687-1-jerrysteve1101@gmail.com>

On 03/06, Jun Yan wrote:
> Add the missing of_match_table to bmg160_spi
> driver to enhance device tree compatibility.
> 
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> 
> ---

LGTM

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> 
> Changes in v3
> - Adjust the content of the commit message; there are no code changes.
> - Link to v2: https://lore.kernel.org/linux-iio/20250220165001.273325-1-jerrysteve1101@gmail.com/
> 
> Changes in v2
> - Fix a syntax error (a missing comma after the .of_match_table = bmg160_of_match).
> - Fix the style issues found by checkpatch.pl.
> - Link to v1: https://lore.kernel.org/linux-iio/20250219150254.24664-1-jerrysteve1101@gmail.com/
> 
> ---
>  drivers/iio/gyro/bmg160_spi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
> index fc2e453527b9..ac04b3b1b554 100644
> --- a/drivers/iio/gyro/bmg160_spi.c
> +++ b/drivers/iio/gyro/bmg160_spi.c
> @@ -41,9 +41,19 @@ static const struct spi_device_id bmg160_spi_id[] = {
>  
>  MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
>  
> +static const struct of_device_id bmg160_of_match[] = {
> +	{ .compatible = "bosch,bmg160" },
> +	{ .compatible = "bosch,bmi055_gyro" },
> +	{ .compatible = "bosch,bmi088_gyro" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, bmg160_of_match);
> +
>  static struct spi_driver bmg160_spi_driver = {
>  	.driver = {
>  		.name	= "bmg160_spi",
> +		.of_match_table = bmg160_of_match,
>  		.pm	= &bmg160_pm_ops,
>  	},
>  	.probe		= bmg160_spi_probe,
> -- 
> 2.48.1
> 
> 

