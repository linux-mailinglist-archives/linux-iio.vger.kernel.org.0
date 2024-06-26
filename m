Return-Path: <linux-iio+bounces-6956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDDC9182CD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948601C2109D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B51181D07;
	Wed, 26 Jun 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFuTM4Bt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C945D27A;
	Wed, 26 Jun 2024 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409290; cv=none; b=Yl3K0ALXSUnZrdA0Urt8KRoTSR6kpvvCT54Bw5wTK2EhL1SXsmW/UaOWJFBMRMiYpWk90zEviEAnGG8woBLu1usFvJtx7OG8it3R5PdMi/F0t+L3byNZE/ODEo/gUNuxkBAWdEtwTA3IsO6ZH8HMyfKvpYX9L1Ke1kPUFXNmxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409290; c=relaxed/simple;
	bh=HrSZO+mufCH3ROjGCgZo5YVy40n5ev4jO6zbaDsuK5o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdmHFqLXDJYXBL0FbTSd8Bcj3/L0v44EtIQJRbssTAWd6RHMCUOYYY7aqXvFLv2vdo3bNqUaj7kvWq3FdB4AUXMlzLxcC5z5aqnmAH9fHSjeApwSbu3qi4wdA+pUHRE7NCq3sR4xD+MVK9YXTkhM9mOKHg/Rh3bhr2pLbpnmd3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFuTM4Bt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so329102a12.0;
        Wed, 26 Jun 2024 06:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409287; x=1720014087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Gwn7+SuPS0YuynZVCqM6KQQMJCn/7ZSf7kfzLBEkT0=;
        b=IFuTM4Bt8XDlAwZyBR1okE6HOVd3r7IRNu6SW0R6zfLVVx/3SBcQdCUXrwdxt5MGf1
         oU7wnD0ODn6CIDWGAROZkeonBnFsdSDo3z8h3K6AMu4fq/QoFjLWL1QZe4pH243jizz7
         M9nbyePpE7/f6QJOWiT015To3ENWjeCNFPowi7a684kBndPJZZqv6J/qQKCbMPljrL7j
         csmyfVlZTnPOJH+GdgeJyq53OlsbA1hre7H3S9hKmHt2t/koG4qGv9n2/0BXfExc98ad
         nJWf9TI1xFTQsmyuG3GnaglvQW+QqtE+wHH5bYSU9s0xug29hGH9e4Sx/ARcSw6HciWj
         I5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409287; x=1720014087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Gwn7+SuPS0YuynZVCqM6KQQMJCn/7ZSf7kfzLBEkT0=;
        b=nOwy+AodO8RCksXmiMg074ryPyhSfnmHw4jV26y4ZAVOm4RLbDOUEqgwHWMUTXOIuI
         TPWKO84DVYkNOb9GWXFwO3JWI0EM9HxObi5wsFpLl1I36sYKUgYpQzeG7MyfhQpmPWwn
         fbDkZeKOW4hENFkQ99tjFLs/xXzDVylzN/gveIG6LzuKZBhwJyEUN/ALNn8v6/Fu5f+C
         H/j1kPDnGmWiXx1erJDu5nby4ZKQMu10o272ZJMxGWXxzqBk3XYxJ9DbeH2cdPpNhC81
         ZCJzXtkNsNqtnR9TDSzy2MvAd5ELb43wQgKBKvNrqOVfUUMnmSY6XWYsVbq61AHZ+J1a
         WxuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+iQkFjPRkEeNukZXsOWY590iP25rdShm4NLBTYXrGtm78RidVYzbVg7mtnHxKao+9idPBwfQdUcBDyWQb9P62wr2M8hnz6HnnufcWgreUQ8LSqCIoOPimuc7Ucqf+aWaQTXaRCDCO
X-Gm-Message-State: AOJu0YyyWuEBEqBHZQxGro8mTDCaU3+TRiwCM98/HWNAcXOqgZisTKDK
	dLXMFjJjk5EtnTEBuAQ6qBVosmfLyh63VVVxg3S7nI5rmwu+5NEcO1nuyUMHGO0=
X-Google-Smtp-Source: AGHT+IFo0MuSaCkCK/lCM0cyS/xMQs0mcarUZGKuRUOSr+G7s8/Mr6ihmTpumoUGTzLoCAYLcGXsdw==
X-Received: by 2002:a05:6402:26ce:b0:57d:544d:16e with SMTP id 4fb4d7f45d1cf-57d544d01f6mr8195743a12.31.1719409286578;
        Wed, 26 Jun 2024 06:41:26 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:733b:db60:78bf:79c9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042d10csm7330527a12.40.2024.06.26.06.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:41:25 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 26 Jun 2024 15:41:23 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, ak@it-klinger.de,
	phil@raspberrypi.com, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, petre.rodan@subdimension.ro,
	579lpy@gmail.com, linus.walleij@linaro.org,
	semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Adam Rizkalla <ajarizzo@gmail.com>
Subject: Re: [PATCH v8 1/3] iio: pressure: bmp280: Generalize read_*()
 functions
Message-ID: <20240626134123.GB26894@vamoiridPC>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
 <20240617230540.32325-2-vassilisamir@gmail.com>
 <20240622102826.2ba446d9@jic23-huawei>
 <20240622121918.GA123707@vamoiridPC>
 <20240623172330.0f94cae9@jic23-huawei>
 <20240623171841.GA202685@vamoiridPC>
 <20240625214439.245ae81a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625214439.245ae81a@jic23-huawei>

On Tue, Jun 25, 2024 at 09:44:39PM +0100, Jonathan Cameron wrote:
> On Sun, 23 Jun 2024 19:18:41 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Sun, Jun 23, 2024 at 05:23:30PM +0100, Jonathan Cameron wrote:
> > > On Sat, 22 Jun 2024 14:19:18 +0200
> > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > >   
> > > > On Sat, Jun 22, 2024 at 10:28:26AM +0100, Jonathan Cameron wrote:  
> > > > > On Tue, 18 Jun 2024 01:05:38 +0200
> > > > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > > > >     
> > > > > > Add the coefficients for the IIO standard units and the IIO value
> > > > > > inside the chip_info structure.
> > > > > > 
> > > > > > Move the calculations for the IIO unit compatibility from inside the
> > > > > > read_{temp,press,humid}() functions and move them to the general
> > > > > > read_raw() function.
> > > > > > 
> > > > > > In this way, all the data for the calculation of the value are
> > > > > > located in the chip_info structure of the respective sensor.
> > > > > > 
> > > > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>    
> > > > > Does this incorporate the fix?  I'm a little confused looking at
> > > > > what is visible here, so I'd like Adam to take a look.
> > > > > 
> > > > > Btw, you missed cc'ing Adam.
> > > > >     
> > > > 
> > > > Ah, I only used the output of get_maintainer...  
> > > 
> > > always be careful to sanity check that :)
> > >   
> > > > ...
> > > >     
> > > > > > @@ -518,11 +511,29 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
> > > > > >  	case IIO_CHAN_INFO_PROCESSED:
> > > > > >  		switch (chan->type) {
> > > > > >  		case IIO_HUMIDITYRELATIVE:
> > > > > > -			return data->chip_info->read_humid(data, val, val2);
> > > > > > +			ret = data->chip_info->read_humid(data, &chan_value);
> > > > > > +			if (ret)
> > > > > > +				return ret;
> > > > > > +
> > > > > > +			*val = data->chip_info->humid_coeffs[0] * chan_value;
> > > > > > +			*val2 = data->chip_info->humid_coeffs[1];
> > > > > > +			return data->chip_info->humid_coeffs_type;
> > > > > >  		case IIO_PRESSURE:
> > > > > > -			return data->chip_info->read_press(data, val, val2);
> > > > > > +			ret = data->chip_info->read_press(data, &chan_value);
> > > > > > +			if (ret)
> > > > > > +				return ret;
> > > > > > +
> > > > > > +			*val = data->chip_info->press_coeffs[0] * chan_value;
> > > > > > +			*val2 = data->chip_info->press_coeffs[1];
> > > > > > +			return data->chip_info->press_coeffs_type;
> > > > > >  		case IIO_TEMP:
> > > > > > -			return data->chip_info->read_temp(data, val, val2);
> > > > > > +			ret = data->chip_info->read_temp(data, &chan_value);
> > > > > > +			if (ret)
> > > > > > +				return ret;
> > > > > > +
> > > > > > +			*val = data->chip_info->temp_coeffs[0] * (s64)chan_value;    
> > > > 
> > > > This is the first difference with the previous version where I incorporated
> > > > the typecasting to (s64).  
> > > 
> > > On a 32 bit platform that will then get pushed into a 32 bit int and overflow
> > > I think.  Back when IIO got started everything was 32 bit so it didn't make sense
> > > to make these 64 bit or indeed to worry about forcing the size.
> > > 
> > > Jonathan
> > >   
> > 
> > Well, I use a 32-bit platform, (BeagleBone Black) and the negative values are
> > handled gracefully with this code. Also, how is that different from the previous
> > code? Instead of doing the typecasting to (s64) in the bmp580_read_temp()
> > function, we do it here. I feel that it is the same piece of code, just in
> > different places.
> 
> The problem, I think, is the storage between those two places is too small.
> It's not about negatives, but rather use that in the extremely large value
> case it might not fit in the 32 bit int behind val so casting that back up
> to 64 bits later won't recover the lost most significant bits.
> 

Well, that is tricky, I didn't think about it. Thanks for noticing.

> > What I can do though, for your peace of mind is the following:
> > 
> > Since the problem with overflow comes when we multiply by 1000 in order to have
> > milli-Celsius, what I can do, is to "force" the division with 2^16 to happen
> > first. In this way, they divided value cannot be overflowed. The division will
> > happen inside the bmp580_read_temp() function and let the multiplication happen
> > later by the IIO code. Then we can drop the (s64) from here.
> 
> See Adam's reply - that should avoid overflow and preserve accuracy which you
> tend to loose with divide then multiply.
> 
> Jonathan
> 

I saw it, and I will apply it, thanks to both of you!

Cheers,
Vasilis

