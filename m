Return-Path: <linux-iio+bounces-10457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AEF99A3EB
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 14:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B764B1C2218F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542DD216A11;
	Fri, 11 Oct 2024 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYtxGuFo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80B1E5027;
	Fri, 11 Oct 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649866; cv=none; b=hmAYTDZFMi2eRLAY0Kh+nO6Z9HiV2U/Kn/cYJKefsMvHnawwc7MPqm67PlTy8AAUtG+3yYJuuMJQZSKE+RH5QaqVYF/7Yl/uNdSD84esDkifklNQKJ73gEnaBgyf7ctMQKDHjh0GiuPZWu2q/N26cuJ04qDcyQ9B9+JkXkgBrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649866; c=relaxed/simple;
	bh=mXF5tY1r8sZ+BePLSvut8fwsgeweL9N6J98VLTTvPLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/mE1XmvavyGfGTU0RO1MFVRc7nvqX+fXJ6tKK6vm1Bxu95JRBHay8XuP4fgv2wgiAvjD6vEGMcKXS9hi1Wm+XeGaqdgUcryQ9sx9zzMFmha/IONL1R7Clre+8QSwvAmomdafxirYJG4H89OUcYktJdy0fpU939ZeJ58ygG4DYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYtxGuFo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9951fba3b4so312065066b.1;
        Fri, 11 Oct 2024 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728649863; x=1729254663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63D6g6LIgJSLc7UFUFlkwljQcLXEYto6STChMviNESg=;
        b=MYtxGuFof1tx5V8y3nBaHxGF+fxX0aaNNvNGWuYJknYjpKcoc53hgxdtOg6+XLloQ+
         O79qRxw/dEQ4htgaIMuPIzmxOyxlKISXLbiufrNlwSb2olJ2UkWqI1DILzI8dNe9msM+
         Ocg+s878D2ON0RK3S/TcD8xwyCnqxkktqeQg+Mwu4wOOuo8z1DtODGJsjsob5Jefnl0X
         xpWT0LbjLsIrs+Tx2lwmmehQKinvVPY/088ZY2vcb7f3OVcBvPoqlZenutw0VV4TTcDR
         T694+FTfDIukMaPA94/Vkz/ZZSoQnU62NfGd7ZICORJDonGsXSiOvQWlUWeUA4zEU2/z
         S9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728649863; x=1729254663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63D6g6LIgJSLc7UFUFlkwljQcLXEYto6STChMviNESg=;
        b=j2Oo7a79P9IBb7xd7PfvyKt/LUwFCdPpZTonmSQg1N/37rpeHd/XzAazw74vjL6p3Y
         fmcR1c+RMO1NRvkyfmTKkDGEj5I8wRZI7rHwRUzmZ0cew52cF114U9FmNYZaacddbflu
         +jk3Lz+YlOo1Qs0am3a2lGU8ht9w3HeFQ5txrd8ybeb6d6IUgN2Tbf930TqZoXyzPtuZ
         +jQuwpHFcInaVD1tx0EfgZznORfNqZDFo6bLRTGIge7NGACbK4tNK5NO53WiKbz8V3qq
         X5lbDSXsHogUnkSJL+ENRTXXqdCGLIotJQu4Bq5S1y0viLSUwANstGD9REXrM6h6prIX
         9S4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTb7ckvwH/uKiwpWXD+4B/aKGBg6F4lf/TPaPsIkw7pteiprI3j2GK0HX5r8XLdGjEEbfLZnYp+hg=@vger.kernel.org, AJvYcCWNeSwOkOy1vdIK6TmUkZusywDF5U5os07HpiSqQhZ8dPzGpNguO5Zm0ycUtSRdCs9GC9ambrGttfz5oPhY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxngm8CoTqvDYRXCoiKGnfWE+DHaJ/cDPMEjAAkLtOUc7MwrKyz
	Fpp9jbsVgB8YMiF1tQb8IZ0bGOn2KL/BEAA30EvWf1GDaVe/VOMg
X-Google-Smtp-Source: AGHT+IHOI1+rAgiSZXEcbJ0u5CvDrlSaAtckGUxZS7Y/N9xHUmUDEO9strUSS97owHZQnmSzbyRzzw==
X-Received: by 2002:a17:907:e297:b0:a99:8893:84d with SMTP id a640c23a62f3a-a99b95a7842mr217739866b.28.1728649862407;
        Fri, 11 Oct 2024 05:31:02 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f2437csm207068766b.57.2024.10.11.05.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 05:31:01 -0700 (PDT)
Message-ID: <26f2e35e-0a07-4b24-91a2-a48d4bc5dadc@gmail.com>
Date: Fri, 11 Oct 2024 14:31:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: Fix uninitialized variable
To: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net,
 skhan@linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angel Iglesias <ang.iglesiasg@gmail.com>, Adam Rizkalla
 <ajarizzo@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241011093752.30685-1-0xff07@gmail.com>
 <20241011115334.367736-1-0xff07@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241011115334.367736-1-0xff07@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2024 13:52, Yo-Jung (Leo) Lin wrote:
> clang found that the "offset" in bmp580_trigger_handler doesn't get
> initialized before access. Add proper initialization to this variable.
> 
> Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
> ---
> Change in v2:
> - Make value initialization immediate before its first use.
> - Link to v1: https://lore.kernel.org/all/20241011093752.30685-1-0xff07@gmail.com/
> 
> ---
>  drivers/iio/pressure/bmp280-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index f4df222ed0c3..682329f81886 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -2222,6 +2222,8 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
>  		goto out;
>  	}
>  
> +	offset = 0;
> +
>  	/* Pressure calculations */
>  	memcpy(&data->sensor_data[offset], &data->buf[3], 3);
>  

That was a quick reply. I would recommend you to wait a little bit while
the first version is under discussion.

I still see the offset thing a bit weird. data->sensor_data uses an
offset to avoid hard-coded numbers, but for data->buf we do exactly
that, in the very same lines.

Setting offset to 0 to access the first element i.e. no offset required,
and then adding the actual offset sizeof(s32), which could even be a
const if the first access was to sensor_data[0], looks to verbose.

These things are of course not critical, and the proposed fix is
definitely ok, but I am missing some consistency here.

