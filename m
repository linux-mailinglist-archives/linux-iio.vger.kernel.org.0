Return-Path: <linux-iio+bounces-4907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2733E8C0263
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7546286273
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8446E57F;
	Wed,  8 May 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI002wFH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8FDF59;
	Wed,  8 May 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187290; cv=none; b=f0r1xkOnGzOmf92Mx++MkGQ/VFnPaAAcoeFB0aBDVjE6IfKWlp2KGmLptAfGJcNi9hQ+EF6GrbmBV9nwRPqovsMpDslsjeTuJxEfV2yrGOHfj1Cnkd714D66NsHNIC1HqIITvMQPKUTFF0XL54N/zT6IHthKwIeghJ5il/gOxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187290; c=relaxed/simple;
	bh=Mw+VZlTdGtflxbbTzx7jll13TQYxsp5LK4huFabt5PE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9jOFdig8sMJbT0zX8BmjyX/YwJircGnOFHNl8WU8lAd8B2H5xsWuk9cGO2VCbMK5vzKrUSHcRFXQgcLmbPEU4FeD4VZuVvPV1kuCGKIcUE+MJv0unmPNkeAm/H6zPsRSF7WeCoQilT9p2xjlS9XbZzynz45E++IuCAPU+X6wc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI002wFH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59ce1e8609so192569466b.0;
        Wed, 08 May 2024 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715187287; x=1715792087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHgxMaByXX4E+eRyO3f3LGeB6dJNQ8+p+ORtHJ8dNm0=;
        b=LI002wFH8f3Qax59X+I1mEBosm6CzMQycOtdee7kF5c14xmKMz6j3ZhGT62lGAR055
         Epk9FlqVa6KuC690tF7UUV/KyryzsgSTK71kZojjLCXo3xPb2jPBeRcsWRn3PgcIKGFc
         cajJwb2ZoR6Me3Gw6XlZuMIUvcrjhsbVoPeVcfZ1v5ZOuIrdbM2Q06CM+U9s2E2Wb8ur
         CsiYtWVR0gwVcSfFaxhNWMAaKCiQjCIODRBWKAxe/lACs8QSpBTEz4NY3tX31gHSI3tf
         5zT3xZOT/HCXCe2JGd0G7q87J4s/BpqX3M1pccTiECgdDUk1jGKmco09zAsm2u1A65YO
         K+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187287; x=1715792087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHgxMaByXX4E+eRyO3f3LGeB6dJNQ8+p+ORtHJ8dNm0=;
        b=t+BsOsIng9tJCTVBX9zfquBB7Lr0JoNtvBpmr+xvoIc/9BNEcsFbhWTzC6dN/o/wJt
         HFl1K24/KUteMGcwsb9OtCpj/fnrzA3TXRo7kzZth71KVexAyVcvcmxasSDngoin9/hX
         lpAJbPgosXa2AtTv80qKoShCbJ35qG1wJfj1xGn166B2Qu6gg+lk1wLPV3knhT41mEa1
         c3fnKgfpX0umpVt76qCkZgi7EmMO+9j5v6s3Rb2aq4RcnVNNVbuH3zyNVi1dIZGAJ9wI
         P7SzEAFH6f5O8t7iHNcmAyGf5zY5BBAgWCE0fD+Pd2pM35Hxn9bFyvU32MlF0LhRZXf4
         sC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDEgAZnQHwQM6YDuAbNkVzWFmlIUPEjBnhNjx6MLdoW8a1IlEnAA0/ieZUof24Dm4QJottFkGTKxuc0Mn47cxYawW+aSGRl/3t2LGfaEBxVtgcsIdEF4n1VaJZy5yM4tJaalVE96MW
X-Gm-Message-State: AOJu0YzlURAvGCe4MGh7LRLVZv6ENsJWduir2GSjjyGObk01ynuhxTzU
	TinjLhrxctqmVtEFIkIscsvL9TM96oOvcDEqWklq8zEqPe1wonbe
X-Google-Smtp-Source: AGHT+IGo8sw9ZIEdE3gzfkVic0oNCWBscnMjU+b3pFYCuIWhENnO7OB5iT1VcFRddCuJGAb/vbkCsg==
X-Received: by 2002:a17:906:b156:b0:a59:ac10:9be5 with SMTP id a640c23a62f3a-a5a1177fe41mr14431666b.27.1715187286986;
        Wed, 08 May 2024 09:54:46 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id ef7-20020a17090697c700b00a59c59b2dc8sm4444781ejb.200.2024.05.08.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:54:46 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 8 May 2024 18:54:44 +0200
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] iio: pressure: bmp280: Add triggered buffer support
 and
Message-ID: <20240508165444.GA144826@vamoiridPC>
References: <20240508163425.143831-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508163425.143831-1-vassilisamir@gmail.com>

On Wed, May 08, 2024 at 06:34:16PM +0200, Vasileios Amoiridis wrote:
> Based on upstream master with the previous patches of this series applied
> as well.
> 
> IMPORTANT NOTE: There is a fix queued up for this driver here [1]. It is going
> to conflict with PATCH [7-9/9]. The previous patches should be fine. The
> solution should be quite trivial with minor changes in all 3 PATCH [7-9/9].
> When it is deemed necessary I can resubmit the patches or help with resolving
> the issue.
> 
> Changes in v6:
> 
> PATCH [1-3/9]: new:
> 	- split of PATCH [5/10] of v5 according to proposal here [2].
> 
> PATCH [4/9]: new:
> 	- split of PATCH [6/10] of v5 according to proposal here [3].
> 
> PATCH [6/9]:
> 	- Removed mutex_lock() and added guard(mutex) to
> 	  bmp580_nvmem_{read/write}() functions as well.
> 
> PATCH [9/9]:
> 	- In the buffer handlers, add 'goto out;' instead of just returning the
> 	  error because iio_trigger_notify_done() wouldn't be called in case of
> 	  error.
> 
> [1]: https://lore.kernel.org/linux-iio/043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com/
> [2]: https://lore.kernel.org/linux-iio/20240505200818.1e70c664@jic23-huawei/
> [3]: https://lore.kernel.org/linux-iio/20240505202106.1c780044@jic23-huawei/
> 
> Vasileios Amoiridis (9):
>   iio: pressure: bmp280: Remove dead error checks
>   iio: pressure: bmp280: Remove, add and update error messages
>   iio: pressure: bmp280: Make error checks consistent
>   iio: pressure: bmp280: Use unsigned data types for raw sensor data
>   iio: pressure: bmp280: Refactorize reading functions
>   iio: pressure: bmp280: Introduce new cleanup routines
>   iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
>   iio: pressure: bmp280: Add SCALE, RAW values in channels and
>     refactorize them
>   iio: pressure: bmp280: Add triggered buffer support
> 
>  drivers/iio/pressure/Kconfig       |    2 +
>  drivers/iio/pressure/bmp280-core.c | 1130 ++++++++++++++++++++--------
>  drivers/iio/pressure/bmp280-spi.c  |    8 +-
>  drivers/iio/pressure/bmp280.h      |   34 +-
>  4 files changed, 844 insertions(+), 330 deletions(-)
> 
> 
> base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
> -- 
> 2.25.1
> 

I messed up with the versioning before, please don't comment here if 
possible. The correct thread is the following:

https://lore.kernel.org/linux-iio/20240508165207.145554-1-vassilisamir@gmail.com/T/#t

Sorry for the mess up.

Cheers,
Vasilis

