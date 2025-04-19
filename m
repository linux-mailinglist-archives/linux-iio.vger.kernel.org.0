Return-Path: <linux-iio+bounces-18348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BD3A9452E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 21:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0783BC843
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF081624FE;
	Sat, 19 Apr 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h998Wq3w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8304685
	for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745089269; cv=none; b=MeiSaFnIx3icso79snuZvVUOmhVsKaD+KY1x/LPazOdgJHJeWQYsw6zuYn1N64YyYoUxNnyaPhMJ13z1LF0OGfMVyGrm7aEok4VcxtK74/V2xyut1hH8ccMjJDpQ0frm0bhysiOsea74CvlCwXgLPUVynIuKh1uBWOZJ0YqB3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745089269; c=relaxed/simple;
	bh=l+LCgdTkjmtFYnLKc3GQEhb43MIKxIj8aE2yyidygKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ/JT+pyoVTCTAG/ZwbuUxAZ348Qe9hHVQhhkxva7A6AlXnOZatNGI9lS7Xhuyxs3mJHp6Kj0kKgoRS8PRLureNM0lFgcIZ9K/atc0fR+Ax5g3E66QHUQLEu5++wzWieMZU03jy90PI4gC6Pi/EQaj9Yjdo9Z0DetRywdX3W9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h998Wq3w; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3707828b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745089266; x=1745694066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7fc99PUSKcdXTICwdHhnoBAgLT+to3fm22HHeBKl48M=;
        b=h998Wq3wX381q7KRHIGkhndsKS+X19Zc+wUVivMbXIam7fmes82IZ185iPkWylOetu
         y4tKNYHwkOOffsa1ECIj22KjBcIlr246xMSLESVtuYY+YXaODP8FKOeqDtrqQy9/xgnC
         MRmuURe+px5PZRwWvA7JHLCsUZlXbsxz/3UFVhYiXkWO4MAJTtrgjQTa/qaIE1ZPbOQY
         ipx9TW2aoE9JeRkq+EuLRuyRJuminl1tdpwHgEFltOr45cvw0Xe5aG/P9So3Qnv206Z/
         qRE3xADiMLJ/XnSkFN6qC8Vn270nCh2SEihODCGY9rJHBmLrEXz6j7+4Or5TumcOGcAp
         S3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745089266; x=1745694066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fc99PUSKcdXTICwdHhnoBAgLT+to3fm22HHeBKl48M=;
        b=wj3o9i5rZGDfWHr402yatNj5o54U6HFmCck+Lt4JHkad1kJYLqPdJTdPl/BNcM2SGy
         l1B/g0eEaJYVc9Ca1lRLOnk7zvbhiXJXKV6FiQ8ni08RokeRwvpvSkROsqr7F7aVQhsx
         UTbUEDVZbPWjvHt4hGx/N04PnoEwX49/k6UKnJ04PDdCkHJUHlYB54GJXiQ0hkUV4oKZ
         x0cU9XHI5IUklyO4ZwOnbISYmF5PNBNbHtwsvtjoe5sg6H0bEfHi4wFB2/+3/r6Le3dS
         uuQ9yNPgTt4rRZozQr2cLfATgn/DFSPOWgZqpsCfDF67KeuNcdUUTDJnsHE/NwyCPtGA
         eEpA==
X-Forwarded-Encrypted: i=1; AJvYcCXqRvsdoXCnw8JaxMacbFtR78u2an6ryWXdsSemBipbUWBrQLwM4+BH10B3IodgNaO+tP28ddbci78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsksrL73PQulIyX5SdclCooEl8aHH4lz+knir80wOtfKWUdEj
	G9UxR7jZ5vaxWrGA1w5FJ2OYLzZBPMDjOjlH3AdcXU8/FqGnVdC6
X-Gm-Gg: ASbGncsoy8h6i0pAwEo4cvC3eTf+dFK/AMb2GHsay+0ZR8LztlZblCDONfniiE40v/Y
	y0gGWyPHm3ZcOeKmkn2GhG4TblKQeLIalA+iJZ57XENISB3zPD4momRA9HYKVX8EEN+V6LLCiQj
	7sWiZIFcfLHOkuwiS3wil7o30khSBYw7n/AKgWZMgVOIfz/xC4ckb8Ti4UhQmyes8cLKYjsjwkL
	nJCDCiX9zQUoMSEo16N4PFJMI2Kfupqqpivb7isop2il7rHs4SMZy/KWVTxoWQE3QQh4/oYxvbz
	EIz4FIqY4KFme6QGarxoPHuc9X2jSet2K2hZyTLpSUJ/FpE=
X-Google-Smtp-Source: AGHT+IHjW4d/BeJg24FIVEf6kzi8Ev3Iv3sdGCfDFK0RpSluUwl2aqlYKR7xMqy4af+rDxxdPkj1wQ==
X-Received: by 2002:a05:6a00:2182:b0:736:53f2:87bc with SMTP id d2e1a72fcca58-73dc14cd36cmr7736572b3a.13.1745089266066;
        Sat, 19 Apr 2025 12:01:06 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbf8e083esm3630991b3a.39.2025.04.19.12.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 12:01:05 -0700 (PDT)
Date: Sat, 19 Apr 2025 16:02:16 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Arthur Pilone <art.pilone@gmail.com>
Cc: jic23@kernel.org, marcelo.schmitt@analog.com, linux-iio@vger.kernel.org,
	arthurpilone@usp.br, bruno.stephan@usp.br, aschwarz@usp.br
Subject: Re: [PATCH v1] iio: adc: ad7091r-base: Move reg volatility check to
 new macro
Message-ID: <aAPzOEjGLc-7yMkH@debian-BULLSEYE-live-builder-AMD64>
References: <20250419161347.28157-1-arthurpilone@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419161347.28157-1-arthurpilone@usp.br>

Hello Arthur, Bruno, Andre,

Your patch looks good to me. Just one comment inline.
With the macro updated according to suggestion
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 04/19, Arthur Pilone wrote:
> From: Arthur Pilone <art.pilone@gmail.com>
> 
> Both ad7091r_writeable_reg() and ad7091r_volatile_reg() perform the
> same test, checking whether a given 'reg' code is
> AD7091R_REG_RESULT or AD7091R_REG_ALERT. While ad7091r_volatile_reg
> returned true, ad7091r_writeable_reg returned false for the same
> condition. As such, both functions introduced duplicate code.
> 
> We chose to implement the test as the AD7091R_IS_VOLATILE_REG
> macro to remove the duplicate code without introducing new
> function calls, which would be the case if we chose to fix the
> duplicate code with one of the two following alternatives:
> 
>  A) Extracting a new function out of the test
> 
>  B) Rewriting ad7091r_writeable_reg to call
>     ad7091r_volatile_reg or vice-versa.
> 
> Signed-off-by: Arthur Pilone <art.pilone@gmail.com>
> Co-developed-by: Bruno Stephan <bruno.stephan@usp.br>
> Signed-off-by: Bruno Stephan <bruno.stephan@usp.br>
> Co-developed-by: Andre de Lima <aschwarz@usp.br>
> Signed-off-by: Andre de Lima <aschwarz@usp.br>
> ---
...
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 092ddea0f395..1b4e0ef43260 100644
> --- a/drivers/iio/adc/ad7091r-base.h
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -17,6 +17,8 @@
>  #define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
>  #define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
>  #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
> +#define AD7091R_IS_VOLATILE_REG(reg) (reg == AD7091R_REG_RESULT \
> +	|| reg == AD7091R_REG_ALERT)
Can we have the macro implementation all in one line?

#define AD7091R_IS_VOLATILE_REG(reg)					\
	((reg) == AD7091R_REG_RESULT || (reg) == AD7091R_REG_ALERT)

The extra () around reg is to make sure the expression is fully evaluated before
comparing to the address.

Thanks,
Marcelo

