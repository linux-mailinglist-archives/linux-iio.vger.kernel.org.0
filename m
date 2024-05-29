Return-Path: <linux-iio+bounces-5448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DF88D3965
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A231C229C0
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726E4159568;
	Wed, 29 May 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiZShIOy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31AE159214
	for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993285; cv=none; b=r2yRwIFWfQtqE8OwCI4Cj4zMGSjLrLvV3bkQEz5jXa9NA+HYSEM7LSsqgWvQhmMJ0bfumFaJHkbQB0o5UrZBHGW6n+QdQ0VDnFmWKr2VdfgUmaRCJaKMDDfrCuWhTkUR71cwFyM5NPUzWR/L7pVcVQKGQ6r+fKOVIWhJF+WfycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993285; c=relaxed/simple;
	bh=kA7CXxgdm0m1foHK3IR+qoqDJrbO6cKUy0Fh4VXhYZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apud1GjrtLRTGhTBbZNQknlriQ2Okn8yMMFoetHC05Tl+aWzBYlWA2x+UCWCKK8H3qd1Z6aAmcsUbYy6oqDVkJNdLoh/LuXJfP158YwNW9Vz68IACHHNJxYoh96E9i2GCET6yMT0502IXHS4/epQmZZx74+hzWEKINC0O3ObMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OiZShIOy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a653972487fso65457166b.1
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716993282; x=1717598082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd5Jaltzw12rjCKy5wbs74zqw1sF+7oimZgG7BDaEa4=;
        b=OiZShIOyKEFduqaeZrGuGp9mNLwOrN+IIXfAqH5a5CdmZg6xdB1CZluwEUG02Vptwc
         aQBqk59MANjHtkxkpWt/X9V6Tzza+NshNAdwT1klNEkicZrUNl2P8/e32vykBg6nZ+80
         NeucUgG+HH0CAMh/q23GubfhacN96+Sqn6IZWekkEWE+iZpcoNKsUIiwfyOgWgj1bN8/
         fVs8yBoEhF9mCQer+IzYrT4AV/SJH6rYNbw+QvDW1qN2/rncynf/fAoxWhOVJqf2olad
         dolyqP0/6ocoy9vw5wOPPWkLD7BLhaXR3/KiwDuQnu6cyUcgJ4d1bjV+1SJXeujDwDbd
         JMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993282; x=1717598082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd5Jaltzw12rjCKy5wbs74zqw1sF+7oimZgG7BDaEa4=;
        b=LMdAX3OZabBNWbzqrDUusO87TOG8P6YwMGTzfNuB/ELjFe/rGMYCbXd8mECizkjMpI
         0OCMmodw09aCv2yRFRevQGgqvFFtcMoHaPbqLG98qAAzlTpR+lOkEpG80ZpINO6/+kO4
         9D8xUhoWJiGC1DokJgtCmIv7uxmT7NXbCgmF4z1PLGWK5XL29wCeHfT5338rNEO1bzrQ
         psLzplRyfoQLUH7ad65xeDpvqUZRoJlTLVfj4b/JScPk3kGzDK1LKFJbWQKhjZh/LkWZ
         WrnOl9hOX3Vascs/llaGGNEGRzJPdcpWBTDa3Lr3B4lgNLGA2hKFAi7AwPcPiPBpndDa
         u5NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjhl5VuUPX9KMAkPevjoZrZF5JJ4xNzXvWsYQ/2Sxn/Zvj4ULd/1GUyqZ75xBN2wxLcIrJZQo2j7eSswkwOEB2SiPISQCsluGX
X-Gm-Message-State: AOJu0Yx2qkIQSmskt/qYsIYoY2bYaSeN2Yuzl5SHaGpzEFjaJjK8XCc0
	VbI3GtepXwyBs62m5492uCctG1vNZxEkP2zfDp+mcFqj5DARsp5Wzqsl+rTr7uU=
X-Google-Smtp-Source: AGHT+IHzDIOEvIZTdtVtvHtAQQImy8QQq+8Ht/4nvi42XIhMSlQyREMA7uCbQ/iCpAaEW85rsjw9JA==
X-Received: by 2002:a17:906:abd0:b0:a5a:896f:9be0 with SMTP id a640c23a62f3a-a62642eb70bmr1169713166b.27.1716993281816;
        Wed, 29 May 2024 07:34:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a64255dc8cesm83208466b.186.2024.05.29.07.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:34:41 -0700 (PDT)
Date: Wed, 29 May 2024 17:34:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linux@treblig.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: remove unused struct
 'adt7316_limit_regs'
Message-ID: <d9a3c974-8a13-43f8-a0d1-0e55f6e1f3ef@moroto.mountain>
References: <20240528233008.191403-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528233008.191403-1-linux@treblig.org>

On Wed, May 29, 2024 at 12:30:08AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'adt7316_limit_regs' has never been used since the original
> commit 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9
> driver").
> 
> The comment above it is a copy-and-paste from a different struct.
> 
> Remove both the struct and the comment.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/staging/iio/addac/adt7316.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 79467f056a05..23d036d2802c 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -209,14 +209,6 @@ struct adt7316_chip_info {
>  #define ADT7316_TEMP_AIN_INT_MASK	\
>  	(ADT7316_TEMP_INT_MASK)
>  
> -/*
> - * struct adt7316_chip_info - chip specific information
> - */
> -
> -struct adt7316_limit_regs {
> -	u16	data_high;
> -	u16	data_low;
> -};
>  

Could you delete the blank line as well?  Otherwise we have two blank
lines in a row and checkpatch will complain.

regards,
dan carpenter



