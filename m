Return-Path: <linux-iio+bounces-18386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16733A948D2
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 20:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1269B7A67BF
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D1B20CCD8;
	Sun, 20 Apr 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpWaTALR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE82F510
	for <linux-iio@vger.kernel.org>; Sun, 20 Apr 2025 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745173537; cv=none; b=H87TzK/GTz+LV/05M5VLTvhRrdwJPy2/Kh14ee2x0GkvVnqZHfoRZcxpNgUWJLh1qJSiat9w0jPUrJ5PrN1YXSrcmadyIZPH9pJGM/QBSSgB7NyewBulHiZi3fu6lShiG7CiPT02Fqb7TIZPjACPR5FcGCKYbYI4DRqz3Ya0qqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745173537; c=relaxed/simple;
	bh=kV9W+PvXQV6M0qZaosOUh3HD1K2nO0nQejXKSA0RyWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsMVNxMSrqORpj24v0r18WxA/qyKAK35Kld4herg5QogD84F9n6Q/yGQT3YvTuHXt/2JnZr3R3SaptZ1SPNw37Op8mIDxTJ2gUje4jEP5aOHnxXAWyaPJFsF57XCCU6Nf+ABxUoz/81qkY7YmYcUtMLCvyQZnS+EXXY+2iT2fEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpWaTALR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736b34a71a1so3727853b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 20 Apr 2025 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745173535; x=1745778335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbPMiQKrKtAoQy+2NSGCU7HQ6FXuRDfSWpm/9u8am/A=;
        b=gpWaTALRKj3Pm04yLWTX9bFF6P3jECDBuB27qLJ6V/c9SmWNr6p9EIoCn57dPNjmPH
         CH7J0xGCxdz2toR8iVLRGis4ghY5PXjZMdTe3c2Rfwd5ca/znVVpegaO2hsAwCO4dK2K
         7AwX5xq3HCKsPdjVQJA5UV1/Ld+PBRsEdJEG78Vq9BVxoTrQyl3hBPdQnAYsUTn3OFYX
         kloDn8SiNvMvtoIip2xIs5EFN4YMIbI0P0bjQVhEVSMWd9ftnr+4uq64hiHTsDpUgX3Z
         MI6jop1fe5S+/DcamUjcWglgxhFPIorfpofy7GzIfMSzZUPsZ5QVre4L7ksCyUHn4rWF
         Fyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745173535; x=1745778335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbPMiQKrKtAoQy+2NSGCU7HQ6FXuRDfSWpm/9u8am/A=;
        b=c6skCW+Ggwxb/x0RhOXeGgnpJ7v/iJLLVpH34S8o72yVxSvlMrfztsOH+lNpwT7RyC
         iqJjUwAdXvlT33+VhqYlN7huVpnhnlyTU1F8Y7uAVO3SV+yP5T1UuUnnJ9eFIC4uqFB0
         dKsyw142ldT9yxqwhMfx5cfnBb4YWXttYTjmdSvaiWmUX5Fg4bAmB36WNYMkzI5+/lMC
         vQpI9uknnt2RFI3p1cTSGu3uZyrwBi2zTpUUAdmCMspkM6rNz+bbUDHGwdaRYXzWI6Xa
         4lkqljVan+7H0WL5fnOxEUnKAhBAKKjdLksZjfFTHTCqy7F01gRrtbtxcWGtrxbzAHFQ
         kb7w==
X-Forwarded-Encrypted: i=1; AJvYcCVJkW0AiveAuBLU3Psu5TsROtcOyBjC2qzN0tzF6/+/ouuN70on771246oH/DlgPADFn1tfbhUYeWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSexCSWQVd3K8Q7Ix9JBLwOL6NRqzMJgiPJZj5M/EmxtaU9ge
	WU68bdz7inLSKRnWH8kFWGTnPrJlRib0PLXG1mY8HttPwvpekihM
X-Gm-Gg: ASbGncvNqx6Vl79fwTxqarVLDk64Qu5q2Xgp38pMCexFPKrVcKDXYSdHLVZH48nFjE1
	UnO1GBlNXv1XjpLtdDHy6tIAYXWOmFZL0C+1IJZRhfUvAdC0dzzH2t1HcHeevZwrg1C4JaO/E3V
	/9GfJGQTvao0fNvCnsXPRnQC2KQ93Q8JPL9ecCtdm+8S0ZyaZvmV1kswUUk2msP7DVyp+EQvwoX
	OdLzBzEqf5FIEic2taovpR6ZdNIZpuUr/f5xNmifmqGsV/SXqHeTZyI/oDzWj5K+QNRkqqEI/Bs
	XBe+jvOIYNLnnMVGBoeXIUE/ihSCNncEUznfL5EClFF6sHg=
X-Google-Smtp-Source: AGHT+IEWdwPDTp2wGBRKm51WMi6gbbtkVrd1w0xWY4EUiBRYn8uCX7Dq7XGkONmElTUdYDg76Eg0NQ==
X-Received: by 2002:a05:6a00:1305:b0:736:42a8:a742 with SMTP id d2e1a72fcca58-73dc14ccd73mr11814475b3a.11.1745173535376;
        Sun, 20 Apr 2025 11:25:35 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfa59a8csm5161821b3a.106.2025.04.20.11.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:25:34 -0700 (PDT)
Date: Sun, 20 Apr 2025 15:26:45 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: nattan <nattanferreira58@gmail.com>
Cc: subhajit.ghosh@tweaklogic.com, jic23@kernel.org,
	lucasantonio.santos@usp.br, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9306: Refactor threshold get/set
 functions to
Message-ID: <aAU8ZczOnIIOcCOC@debian-BULLSEYE-live-builder-AMD64>
References: <20250419232128.35759-1-nattanferreira58@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419232128.35759-1-nattanferreira58@gmail.com>

Hello Nattan, Lucas,

Not sure it's worth extrancting the event direction comparison into that
separate function. Even though there is less code repetition, we now have an
extra comparison to handle get_thresh_reg() return. Despite of that, see
comments below.

On 04/19, nattan wrote:
> From: Nattan Ferreira <nattanferreira58@gmail.com>
> 
> Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set functions
> to use a helper function (get_thresh_reg) for obtaining the correct register
Wrap commit description to 75 columns.

> based on the direction of the event. This improves code readability,
> minimize the number of lines  and maintains consistency in accessing
> threshold registers.
> 
> Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
> Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
> Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
> ---
>  drivers/iio/light/apds9306.c | 38 ++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 69a0d609c..8e1cdaeb0 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -6,7 +6,6 @@
>   *
>   * Copyright (C) 2024 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>   */
> -
This doesn't seem to have any relation with the intent of the patch.
Drop this unrelated change.

>  #include <linux/bits.h>
>  #include <linux/cleanup.h>
>  #include <linux/delay.h>
> @@ -744,20 +743,28 @@ static int apds9306_event_period_set(struct apds9306_data *data, int val)
>  	return regmap_field_write(rf->int_persist_val, val);
>  }
>  
> -static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
> -				     int *val)
> +static int get_thresh_reg(int dir)
Even though these functions are declared static, it's common patter in IIO
that driver functions start with the name of the driver. So, it would be more
conventional to call it apds9306_get_thresh_reg().

>  {
> -	int var, ret;
> -	u8 buff[3];
> -
>  	if (dir == IIO_EV_DIR_RISING)
> -		var = APDS9306_ALS_THRES_UP_0_REG;
> +		return  APDS9306_ALS_THRES_UP_0_REG;
>  	else if (dir == IIO_EV_DIR_FALLING)
> -		var = APDS9306_ALS_THRES_LOW_0_REG;
> +		return APDS9306_ALS_THRES_LOW_0_REG;
>  	else
>  		return -EINVAL;
> +}
> +
> +static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
> +				     int *val)
> +{
> +	int reg, ret;
> +	u8 buff[3];
> +
> +	reg = get_thresh_reg(dir);
>  
> -	ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
There is now a blank line between function call (apds9306_get_thresh_reg()) and
the return check, which is unusual in IIO. Drop the blank line between those
	reg = get_thresh_reg(dir);
	if (reg == -EINVAL)
...

> +	if (reg == -EINVAL)
> +		return reg;
> +
> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
>  	if (ret)
>  		return ret;
>  
> @@ -769,22 +776,19 @@ static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
>  static int apds9306_event_thresh_set(struct apds9306_data *data, int dir,
>  				     int val)
>  {
> -	int var;
> +	int reg;
>  	u8 buff[3];
Add a blank line between local variable declarations and rest of function code.
> +	reg = get_thresh_reg(dir);
>  
Another blank line between function call and return check to be dropped here.

> -	if (dir == IIO_EV_DIR_RISING)
> -		var = APDS9306_ALS_THRES_UP_0_REG;
> -	else if (dir == IIO_EV_DIR_FALLING)
> -		var = APDS9306_ALS_THRES_LOW_0_REG;
> -	else
> -		return -EINVAL;
> +	if (reg == -EINVAL)
> +		return reg;
>  

Regards,
Marcelo

