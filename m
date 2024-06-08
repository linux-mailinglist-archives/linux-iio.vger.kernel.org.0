Return-Path: <linux-iio+bounces-6042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1375D900F99
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 07:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DB71C2117F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 05:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A2B17624E;
	Sat,  8 Jun 2024 05:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M98DHKDe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866941FDA
	for <linux-iio@vger.kernel.org>; Sat,  8 Jun 2024 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717823109; cv=none; b=sq1o3jYLyHI21fI4u3rYnXRbv9FUKMOWognIJTtMvaH1Q4arOTrB1ibq3yQKUh5kYtyTy+/VkFBSmolkn9CobviPGfKOYQjgVicVH3sQllex9BZ5FEEd7uWAhZC5CDw6/LNqERAjLudkYPIefngcF8xlxnsvw6ywWooEvlHyvHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717823109; c=relaxed/simple;
	bh=PeIC7jaj4ih5xSF9Ijsw0VsYPppqUjwRK53A1GYCWnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRU6WGvWw53vQP08BEI2ejpLxywn7pLKJY7LWzXd72k/BwVAO7w2HGjqxyWIoPCgBMYBov8YsWk+Au0qY2L4v+QDHzrTt6ZtrGagEA87hzzGxPinFVIep6QcHb3xryDnuiZVy977j+37XuaBIHhgNayr/H4H3qUQ8M4YIORPjq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M98DHKDe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f480624d0dso25981875ad.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Jun 2024 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717823108; x=1718427908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVyf4R9XarV25qB6duK9WTj+UmLmKUZkn+/5ABsZVFM=;
        b=M98DHKDemmNPqWSbVgRG0IowouZJt6PYJp8sJ6TKy08HIbeDPwYwV1/T7kWuwD+jFI
         Scxf+Oi6QGIIgXr1ZLTvBPG1899OWtXpMjQXdTIxzarorAy2AlMrwEDqUfCHnc+RQYzT
         1XBCgmr37nEIlPc22J0uPWE2PBkT5WhX7e3qqkaXN5pqi9nsfFw15jkmeC+Uib5Gtpf1
         CKZGdfeMD/gNILQTCDBGM9mt4UCgPicQYCLmb7WhrM7oR4r1/UIWYBSyRN0RqaYh9AkU
         temJk6UZ0AE3/rUQIlOnR3RAJPUNIVax/QVjwQETgcAaO9plJNefTTBZK48nXnaoheHl
         IFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717823108; x=1718427908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVyf4R9XarV25qB6duK9WTj+UmLmKUZkn+/5ABsZVFM=;
        b=PzgCIp39CPhmdr8fbU2qXkbGrewn93ntCGlnKXJIIEc2Es/qCmfQqEXsDCOOc3spLF
         WAoTJuMCALu+lxJlEsyLXZOyZdma+708+v0PZml1CTOhAVkQTOFnm5bv2GhtFhpQop7G
         ueueEdw0y+KUwr8RmxePYl1N4rxKFKrqn4+vD2+mzYL9hLwFfGky7UhtpPWPw683whXD
         zwJeTw7HQVZU4Rmh9ZgSDWJ9Z/KsKeQgte5Op61FSurUrq/ovE0MxRRggb9NLZiH6Fh4
         HUCT+YXOgsIbYlOdGA73woTWAS2fvK6YgatxZ56pAeX5tF3/s8Hxhl80n2uRvO9HZa0T
         f8ag==
X-Gm-Message-State: AOJu0YyEh3x1mqtHnFKPSrgsmk/GN0AgiTuOOL1jdlFxBoidfjIAEj6f
	/psfIKVOLUelDdgjZFvQ+VVS3RSppxGyQ/NMlBTmof5p+i9X7l5GOSmC3T2e
X-Google-Smtp-Source: AGHT+IE/xfTzWZKctrqOBJXEXWS1U/fsnJ8PCQKvQLpd1c7Qk2Pl5N9qirogIpvoqpneRyHzN6uiRA==
X-Received: by 2002:a17:902:cecd:b0:1e8:5cf9:37fc with SMTP id d9443c01a7336-1f6d02f55e4mr60010255ad.35.1717823107704;
        Fri, 07 Jun 2024 22:05:07 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd81c9c2sm43312365ad.308.2024.06.07.22.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 22:05:06 -0700 (PDT)
Date: Sat, 8 Jun 2024 02:06:21 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Fernando Yang <hagisf@usp.br>
Cc: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	jic23@kernel.org, lars@metafoo.de
Subject: Re: [PATCH v2 1/3] iio: adc: ad7266: Fix variable checking bug
Message-ID: <ZmPmzV7BOBZIlwFA@debian-BULLSEYE-live-builder-AMD64>
References: <20240508155435.183850-1-hagisf@usp.br>
 <20240603180757.8560-1-hagisf@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603180757.8560-1-hagisf@usp.br>

Hi Fernando,

This patch looks good.
I think a fixes tag would also be appropriate for this one.

Fixes: c70df20e3159 ("iio: adc: ad7266: claim direct mode during sensor read")

On 06/03, Fernando Yang wrote:
> The ret variable was not checked after iio_device_release_direct_mode(),
> which could possibly cause errors
> 
> Signed-off-by: Fernando Yang <hagisf@usp.br>
> ---
>  drivers/iio/adc/ad7266.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 353a97f9c..13ea8a107 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -157,6 +157,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
>  		ret = ad7266_read_single(st, val, chan->address);
>  		iio_device_release_direct_mode(indio_dev);
>  
> +		if (ret < 0)
> +			return ret;
>  		*val = (*val >> 2) & 0xfff;
>  		if (chan->scan_type.sign == 's')
>  			*val = sign_extend32(*val,
> -- 
> 2.34.1
> 
> 

