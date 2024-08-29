Return-Path: <linux-iio+bounces-8882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C1964E42
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 20:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CB02854E9
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 18:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2131B81AE;
	Thu, 29 Aug 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvn/24yo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739881B0120;
	Thu, 29 Aug 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957880; cv=none; b=NZgNSA0cClDyFUvLT364gpypRqflkCLcMujbzkM1Yo2JDLZPydDCixeFgvsX19B8URY3bmYsXzs3x5Hh+urwjAyaXkUimltXp6Q1R+1vLEyMpH4F4Dd6Hl3jHso8swRwC308Ki1Te9fTUlVNoLj9mKMIqbW//QmJg5pD817OnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957880; c=relaxed/simple;
	bh=/kIdD3v9PL35nwxm6CuWpYZdRCoiMQcuUVF75ZnSC2Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umGdDvcF74Rrl+GfgwnPi4ruhrKHgZzMPutPMZl5Ng6N3//4Anw2tFyLJ8P/Zjl09xp8lTirhjAUQuqTsDQWo0FNRd6CDzwp/Dz6EGuCgf8Abbh6Gz+xKX8oQr2GEq1ux5gX3n8HFYJ9+moWqiArUgo88HAOB1rY5CHc85Wo83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvn/24yo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86883231b4so115970866b.3;
        Thu, 29 Aug 2024 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724957876; x=1725562676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7UZoDEfc6CPKoWrLjn6mASVFpzP1uqbEEK2Alllrf7A=;
        b=hvn/24yo0cPyX1P2ZJBURiKBtoqIeQV+mPpO9m0XF93dmKhKong+ulMKyERyE9lX8M
         Jju7I5j4GkZLd3FOtnHZ+Nwne9xfHnbzbyxNtRuGAec/h+qflFZxVIWTkxt+gak+eu7G
         g9Kfeogduxg68sKpAKz/YnRKQliw9dSpoXLdT7kQOK1eLnZPX4OZ7osZY0WHX9iLYukJ
         dVRPdqSVDuXcBaSjPOzhpBNgs7EAIE8+r/K15NtKfbRtACvrQ9MNuIV6RB9vQxdWScNU
         mK8rMAFrsUIzcBJONreOXpXqKHhTk5EMiCHPQLsMsRolyNFFvq1N4NzVH4ENgiktL3N7
         mYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724957876; x=1725562676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UZoDEfc6CPKoWrLjn6mASVFpzP1uqbEEK2Alllrf7A=;
        b=U/gqJdv0w2TMrjEbkJmJbW/yNoAFeK2I2GCom39HWEqEpAmtvo+lO8Sz3qbmJAHugS
         Xz6bBbvLruQbmhm6wis3FZUqdDqAY6b7biuaRmNRBm0oxChr2a6ZXhElthsf3Gz59FdO
         2jXfNeToVkjb/yp51OE4oGhWlSbpZeE4FaIKidt7Ud/FzqfAiZqCJsw5C1c00nB8PV3p
         SK5uRxE1MpY5Oq0sG81+lqQgtqVmFS8xk/p3K043Heytkrz18+QKx6srUo6gMi2APAEO
         iEYDGIZOJH3P3qB5V397Tx3zPh+Gb18KfMO0hMHWHoqRBJCMasbUZRiGzqno7mlr1yRL
         rU/A==
X-Forwarded-Encrypted: i=1; AJvYcCVbSxPXHuPnYwL3czjHA7Q6P4Z3ZB19+xjpaQqQtGQ//nQGngnYxR1KiwkHTKbZvES132xlavEl0gD/@vger.kernel.org, AJvYcCWifEjjrgkqF11a6PB640q4rTMx8iyTzdB10w6g4HAgFQB4R4DCmFk9QmPszVU0uvJbAhQh7cpEYYgf@vger.kernel.org, AJvYcCXU7WE0uXc58jCokuxGubl0kVLEbQZgXTDbHjRBMMGwJyhwIrzXCKJCJ//R7Ij4B2eePAevlWfHBkajMcRM@vger.kernel.org
X-Gm-Message-State: AOJu0YxgV0M+QZzIw1iMZHXpGff34hPGuNz/f/5vSNFiDdZENeTfJG6b
	Bi477ubWb0wiXVGZqB+u6UOSbkrzJQC2o/8/KCgOZuVCFT1k8MqQ
X-Google-Smtp-Source: AGHT+IEImtgET40/r9Zokthw3/Oe/03HXIKcIgIm5jMXppV4ADkjPViqN9kcofe9QI9MSv9JQjAAMA==
X-Received: by 2002:a17:907:7252:b0:a7d:a080:baa with SMTP id a640c23a62f3a-a897f8f77f9mr308939666b.34.1724957875909;
        Thu, 29 Aug 2024 11:57:55 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:f22f:934f:9b88:e7ce])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898922710csm109846166b.223.2024.08.29.11.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 11:57:55 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 29 Aug 2024 20:57:53 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 1/7] iio: pressure: bmp280: Use bulk read for humidity
 calibration data
Message-ID: <20240829185753.GA3493@vamoiridPC>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-2-vassilisamir@gmail.com>
 <ZtBkNu0luJyT1emw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBkNu0luJyT1emw@smile.fi.intel.com>

On Thu, Aug 29, 2024 at 03:06:14PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 28, 2024 at 10:51:21PM +0200, Vasileios Amoiridis wrote:
> > Convert individual reads to a bulk read for the humidity calibration data.
> 
> ...
> 
> > +	calib->H2 = get_unaligned_le16(&data->bme280_humid_cal_buf[H2]);
> > +	calib->H3 = data->bme280_humid_cal_buf[H3];
> > +	tmp_1 = get_unaligned_be16(&data->bme280_humid_cal_buf[H4]);
> > +	tmp_2 = FIELD_GET(BME280_COMP_H4_GET_MASK_UP, tmp_1);
> > +	h4_upper = FIELD_PREP(BME280_COMP_H4_PREP_MASK_UP, tmp_2);
> > +	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW,
> 
> > +			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> 
> Either I don't understand the side effects, or this is the same as tmp_1. No?
> 

Hi Andy,

Thanks again for taking the time to review this!

This is the same as tmp1, and I didn't notice that I should change it.
Thanks for pointing it out.

Cheers,
Vasilis
> > +	calib->H4 = sign_extend32(h4_upper | h4_lower, 11);
> > +	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK,
> > +			get_unaligned_le16(&data->bme280_humid_cal_buf[H5])), 11);
> > +	calib->H6 = data->bme280_humid_cal_buf[H6];
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

