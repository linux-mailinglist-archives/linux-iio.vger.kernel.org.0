Return-Path: <linux-iio+bounces-10111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B717198FF23
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 10:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4611F21F4A
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A1140E38;
	Fri,  4 Oct 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3lsMyzq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323B81ACA;
	Fri,  4 Oct 2024 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032300; cv=none; b=sfNFi+skdwhi+0ye8b70i32OO0x+KjkbzqLFRF+px3znHJbQkNrAsaYyn1TJrMAN+3h0NU05Y8Kf0oL0WUW735k4U7jnJBGi/LnUC7+d6AdOhXr1eNHVqHk5AVCvvWHUpH78XUMQVtv7ot/ANqfDHr6LuSEAnbirLOYrPyDYxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032300; c=relaxed/simple;
	bh=EGnfqC5xLweujpoefTs2Ab9jge7hBihQLAe2RqjwVMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5X8JPxcX9uBgUD5gwMvbKPlAyTbsQmGFDf2xFbncOvW1xmO830Zxcu6GxY45Celb0/rY/tj8lzKl93x3E3mXI/xzlLDf63+3ZUueo/vZ20ZF5FmRoZMHAY+vw4ueoVXcbxpt/xDFlikeSBbBB9VOey4k7qEkE/BiVfxoOMDE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3lsMyzq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398c1bd0b8so2871129e87.0;
        Fri, 04 Oct 2024 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728032296; x=1728637096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9VtKmYVyjauFfcZHkwqEFt/dbGyZ5a23fJslEkH8fs=;
        b=P3lsMyzqpfKmNmuWq7tUs1zICboJba/WBQLEvrzZvPvDuTXNcIkPGwzzJGdQgoBR8f
         SD92xhF9z/pqS7gGHMTcRIoc+DSJGC9DdaG+4dHWAm4zzouVXGeoTPdMkHnBB14aOPCm
         nBedQuJClrZQDPQuC/8azsDmjRoLoUAY67JFQvSZa/r5JTO397/74sHdnI7Mohc4X72t
         U6NB53U4iqqZ6hvdcFDyrCtZkERG0sXTEsKYQqNxTM6HBsHli+xBGBRuYamtwtLgUGZ5
         pWobVCCoJUObqc5ky9zuMATsGkoAEMWrOCKMMVsKKoQCdCCRR37nkYV/xYzpm7/Ee22f
         s3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032296; x=1728637096;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9VtKmYVyjauFfcZHkwqEFt/dbGyZ5a23fJslEkH8fs=;
        b=UCiIs2Kj7iqIl2UBw/1R7mp7x78LHIfn/vg49P+6zxZC9LWT0B1wrWrrDWMWIhU0ot
         N7zShe+ra+5KsJMFQ0AzVzgq9EYrhLRNI2JLTisuFkVb0yKbC6GwaydWX+YJdA4KSIJy
         h1vrjOZvUw95wdw9vhdOYo8P62WdwGJxjO/HoA8bLrHHWlzWM5QhIyhVywCxvVelagCl
         nGqBMtMqxBS9nwyPjFwngWtiJJzJI8fbfC1dCGqSsx/8SXEUgBu4U8PJKD9DP3tKMjJN
         7660Lh2EDtI6oEG6x5KmzN922zeWm2ulpZOV28kGn4odfcSj+J0rlTDcSODckizM9Bcb
         FGmw==
X-Forwarded-Encrypted: i=1; AJvYcCW+cp5BXxCjy2i37LV1DzhJJsu08C2LB9wkbs1EIWyWcqJqpK4iHbfY+DveeY8uDaPvCVDh8696ByM=@vger.kernel.org, AJvYcCWR7czerHRd6QnxVwfmfgCFuwP7ij+0NnZ+wqlZWo9wrjJ4R2DFN+dxq7k20xJLpYZ+F+7yOdjpEhYQhdDg@vger.kernel.org
X-Gm-Message-State: AOJu0YzouuYia9H9Rv6s167Lo3jmjDSHnf/z3XOvV6/d9oADSlFIStI5
	7oNMKHxcbQezueKLKaoDx0zi6jCtAyXubGmGk0/hIAvqAPZYeth7
X-Google-Smtp-Source: AGHT+IFH8fPP2FCYLn43Nc4zHuLJlz9HFOMx6pp2zUzUPBJCJcgqmoOGQb8hvpUa5mG7cKUltJ0zVQ==
X-Received: by 2002:ac2:4c41:0:b0:539:8ad5:50a2 with SMTP id 2adb3069b0e04-539a626a0d6mr2034938e87.14.1728032295955;
        Fri, 04 Oct 2024 01:58:15 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a8296bdfsm371241e87.140.2024.10.04.01.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:58:15 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:58:13 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>,
	Leonard =?utf-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Alexandru Ardelean <ardeleanalex@gmail.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Shoji Keita <awaittrot@shjk.jp>, Dalton Durst <dalton@ubports.com>,
	Icenowy Zheng <icenowy@aosc.io>, Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH 11/13] iio: magnetometer: af8133j: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <Zv-uJaMH4JFK_nvA@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>,
	Leonard =?utf-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Alexandru Ardelean <ardeleanalex@gmail.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Shoji Keita <awaittrot@shjk.jp>, Dalton Durst <dalton@ubports.com>,
	Icenowy Zheng <icenowy@aosc.io>, Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
 <20241003-iio-select-v1-11-67c0385197cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003-iio-select-v1-11-67c0385197cd@gmail.com>

On 24-10-03 23:04, Javier Carrasco wrote:
> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 1d8f4b04621f ("iio: magnetometer: add a driver for Voltafield AF8133J magnetometer")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/magnetometer/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 8eb718f5e50f..f69ac75500f9 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -11,6 +11,8 @@ config AF8133J
>  	depends on I2C
>  	depends on OF
>  	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Voltafield AF8133J I2C-based
>  	  3-axis magnetometer chip.
> 
> -- 
> 2.43.0
> 

Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

-- 
Best regards,
Andrey Skvortsov

