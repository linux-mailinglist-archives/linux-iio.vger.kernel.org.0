Return-Path: <linux-iio+bounces-22480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7237B1EE5B
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 20:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90731A040A6
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B15280A3B;
	Fri,  8 Aug 2025 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kyj+tZNv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C521E0AF;
	Fri,  8 Aug 2025 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677685; cv=none; b=RvXIvZKrldBOxDl6i4uCjYiWMGEm4aJ8J/2l+aRqExmIs1/PRGDhVfVAMxP1NmiBe7ZbsuyQPbJ0QoYDnm7uTIwYWJqB9/DZ7vpW9Tde8Sq0GfB0l52qQ7h3C6X7oDoFcaanX9aP6pvF9GMu6DETFOsq21zm8OANDtdku01UOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677685; c=relaxed/simple;
	bh=MazXUo943+X2UVuaNwH1s9IZeQdzULpXZNh/GwXwKgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZe7rQ/ETHH8AAOi/OVOJuTai8IsY8IhHjX1AeS73R/lK3t3tabezTc8yyvu1aL3UU7U+wciYDEn/wsDuTV4vl2jx+K0HA47+7MPq0zuKilkOkhQ12vJ9tc6r+4cCHp0RYt0qNLURpCVDyJMtXZsPEaT0v161yfkxY3VbruR+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kyj+tZNv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24099fade34so18541565ad.0;
        Fri, 08 Aug 2025 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754677683; x=1755282483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8g27/tWKhrTSpKyKMDMHi0vvYXVRNDi0Nwm0pcXet5w=;
        b=Kyj+tZNv8E5uQxgTNUfmFW8MwylbjELvAPUGIliV1WNpUEC+R7800EX/d0ySgwMWmX
         yY8RXa/mZ8RveJpsR+UD5ufAfSuhg7ku0c3Meka6lWfw6Pju93FIMWkJivRTgCkNmPez
         OZwD4yyq9s9p87Y9GRLzKscsulWl07jGsqb5iBZTOJvr57Y15IZhlM11Hc8B8+tQ+1K0
         zueot9tCYzI8YAj49HbNF4gQh3icZ0alPO7hmE33ZRM1zlTxGRa9w42bySsf5N8A3o2h
         h6JosRYtVd+Tb8/V+sOX7mQqIwwiytpOjs29ITespCdfP527uwPHwAGdEYERUhi/xC3k
         tznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754677683; x=1755282483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8g27/tWKhrTSpKyKMDMHi0vvYXVRNDi0Nwm0pcXet5w=;
        b=IDkqRMqHY3vIFhXXQG6XDr5sxYQoMuH1sDPnIrNhtSlSOLD6JafRmJCkuSa6KboekP
         7UmYylct0HjmC7ZNL8Lj81qSwpqr7WQJ5HriR+jVRfPS4eHRBHsE5lcSklkpayYL8a/S
         sKcP+H9v3P4X2XDe9ALhsHh0x71nl9qUjIr5lXNeH3kIiz3XxKlCYG3YGiQDPv+QGxBZ
         nZ0wILU0PItQZ8Khv2O26uZHVBqQyIeD+30vxfgZzetrw9sNK5T6JBx5XpAwot38yZH9
         tBIt7uR5RC8rJ74+TYCy9TpCSLflOjmWDP9/jZKoHHqiCATQ3vQE5tDViH9KqueBP77o
         Zdlw==
X-Forwarded-Encrypted: i=1; AJvYcCUT3uhd4W2fCLr6XTLOQn89Ao30g5rbSAjee41HcTjEIezxENAYRBi+aRvOok4pdzyYqT3pPZkHjD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWV9XZAiPjROSaKtAYv8bnCYVlrONzbFbZJqeVvqDQ6MB0+0w
	osWoYTZ+HGmBDwDhIFfO38fSXRWcI2WYBbHxc7yr3rx6Z8+aDpcIY/nn
X-Gm-Gg: ASbGncv7RiDJHDfAMz5Zu9SahgbUQIJ9yei0DIrgAetvqXiw6mNU2GK5SzqN8abD0EP
	8e2bNAhF3SGNtrHWOkGjRIRgEg7aHea09FYaHc6dlp4pSvM8PoGemWsxJuuBqC+HtIdVcI9Bai2
	tRB/HI8wJjcytf0SLr1rPSCRjXKmP1bZ3hezlIOg9qVEOyfkjI8k82TVnembEv9yADjxcbYtJXt
	7l60B6io+cFDu/owyfTuoqu8sn3+kwoGF3K/I03u9ZJZyLB1LdaATxV6N4YA4s76k4HnAh28J+b
	83MGfwlCkEsS1FBzqRnYNRJ/hbZ4MkgpitM8FEp40pxRyNHRaJRIrfIDAFyLKojOqK7nQ8prmXW
	GRiIwWQnTA5ipqyJHm71/E4hmRhFtSaI=
X-Google-Smtp-Source: AGHT+IH+dK3QXl3eVdsBAFikIByTtBPN8Ez6fesh6xwhKONE2vzthG8501Lt6Tp6iYWkVILGgmG/ew==
X-Received: by 2002:a17:903:19ce:b0:240:cd3e:d860 with SMTP id d9443c01a7336-242c220df9cmr60893515ad.41.1754677683325;
        Fri, 08 Aug 2025 11:28:03 -0700 (PDT)
Received: from localhost ([2804:30c:1f50:da00:c6fb:5400:5af6:282f])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1ef6bcfsm216891195ad.5.2025.08.08.11.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 11:28:02 -0700 (PDT)
Date: Fri, 8 Aug 2025 15:28:14 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH] MAINTAINERS: Update max30208 for bouncing maintainer
Message-ID: <aJZBvi2cXN6LZEFb@debian-BULLSEYE-live-builder-AMD64>
References: <20250808174901.4556B33A@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808174901.4556B33A@davehans-spike.ostc.intel.com>

Hello,

I'd like to take maintainership of that one.

On 08/08, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This maintainer's email no longer works. Remove it from MAINTAINERS.
> Also mark the driver as an orphan.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-iio@vger.kernel.org
> ---
> 
>  b/MAINTAINERS |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff -puN MAINTAINERS~MAINTAINERS-20250707-6 MAINTAINERS
> --- a/MAINTAINERS~MAINTAINERS-20250707-6	2025-08-08 10:45:11.062417377 -0700
> +++ b/MAINTAINERS	2025-08-08 10:45:11.078418776 -0700
> @@ -15005,9 +15005,8 @@ F:	Documentation/devicetree/bindings/reg
>  F:	drivers/regulator/max20086-regulator.c
>  
>  MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
> -M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
M:	Marcelo Schmitt <marcelo.schmitt@analog.com>

>  L:	linux-iio@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
> -S:	Maintained
S:	Supported

>  F:	drivers/iio/temperature/max30208.c
>  
>  MAXIM MAX77650 PMIC MFD DRIVER
> _
> 

