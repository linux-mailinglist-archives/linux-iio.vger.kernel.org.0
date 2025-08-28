Return-Path: <linux-iio+bounces-23332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71965B395C1
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 09:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD393BA81D
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818D2D3A7B;
	Thu, 28 Aug 2025 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaK3PgXC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7427A130;
	Thu, 28 Aug 2025 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367047; cv=none; b=ds9qg/yss0Odvma4l/5ZvsJNFXwHecM7tUcjNpqH5miKtDGLbdKq7OhBqkqRkAntwVE4mn6PuSz/cqtvNqVXsl1JyWhnWadswNY5bQNnKANcgM2ZfgnBBcMG7ZE0DjuatorEbCyxO2TwZDrVL9IINj8mtnpnlmnEHz5yPLfHrm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367047; c=relaxed/simple;
	bh=kmsd29Tqmz31V/sbkKfx3JiAU8TKi6TvSl3B6wrtCJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksiq0gzdQy/M9jmX2zTpvKEOnaTeuDngadxFDywMBbEX4o1N2Tmknpw5F0MZRpubbWd+DJ0at0fJhnZMl7n/rWxjLfG7D/P+sFaXMsQl/FgpvBmF5ALel/kgQh5XTYwZ1HKYAkZaH4R26b9fQvzt1n9r4e0pQZ+nIVS9+0Q6Ngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaK3PgXC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso437832f8f.3;
        Thu, 28 Aug 2025 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756367044; x=1756971844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0INQ3eSnSL95+ISHXv/Nm6m5DjYjfSgZtTbDRvm4xg=;
        b=WaK3PgXCSCTMwjqXvrPSozDCXrX2lhFDo/rcESHgZlZqe0I8PL8YnjzRal64g/u878
         R8De/F6ZV9t8u5c3oHhYfhHyDmq+ndDdBZI8KqzB9R/UY7TKXYIgxwFcDM6qUqwnguSa
         nhN6odWqtvgrEm1weTYueHPogQzniDHISd6iheDIafKTb48pvyeaHhJLhXXmdAQFd294
         sb8kJhTLcAEVD1iuokKMt6I/lK6pPM4dNdPNZP+0QzJNtCovZygD/m1yEa853uYq4wts
         8erZ0RhCw2jivukvrUuKoAIO1UEVEQFHv28qwEBwiVoSPGFCQL5yCWWa5y4DVGLQwQvi
         KYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367044; x=1756971844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0INQ3eSnSL95+ISHXv/Nm6m5DjYjfSgZtTbDRvm4xg=;
        b=pIC7Ia6+ZO9jYtXjnKnSUEUqBo+VERvX0dMO2zSR254ytsNMqGTT/bnpdFy71NuqFn
         sz7l6khUyPZ4WlsmgnKXHsCIV6ZbCYIITpbNPHiPr5k8t5WTlFI3W9R9zmq2mfFMNpb1
         TUhlquC6K/W7kk0wlqPn/07Nud5XeTuv8aU7J1jVtMYeN3tG9bBoHxPwFiddHgRnpYAr
         IzFGWpyV0huHhyNWsycVPQzVrPyOeSOVXksIEkXWhFavqDQqQIs0JNscUS7YaI2/Rb9w
         ifQ2Eewz01UbHefu467QA/XTIxn1bSgLX1JSYO9hmjEz26tn9dSxiELe8clB3TrHzJ/K
         ilRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpctQJHEKL5h91h/EI47hS0PIyc3djTa9+ae3BzPO0SW4RhqYa+Jsy9BIcAxsUgSw39ntLgPL9NCc1PUjy@vger.kernel.org, AJvYcCXzwU29Tdjmhqu1Tk6xNx/VX2F94Ju7aGz4zm547hzPQxbqanGjxYk9iqi7vf7UMqDM94zL7BIawMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9p4Xt+/qzw+rEPSqJGaEEaSkp0eJPZTnkCvvbO+Fw7EhnU+g
	5+QMmpK1FLG6+BSfam7IGIp8N80hLRzFvOkwQQuaKQm53yo9jQv996mB
X-Gm-Gg: ASbGncvyKgoIk+1zFzxSWqzpm1K8ZR1DVZYysucPR96tqaezDPv2GhvWbxdFP7bQTS2
	5yFovD+CfLB5g//z81OVc11Fi6BELtB5RsRtX3VVi/8U/C+DO0/M/OMi+1EjX1j+NClQcfTbMe8
	BIpDpm1+EYhQ6aX/kcvy5OwLNNbXueWc6yj5BQyGThVHoJg5q+d+xTxw276+HQR5iHYQDDhTXG4
	/+AOGcgNknAGVKdGKnmqYm7bermIWF94vV9MdIUeT/UIft25M0GnfBLDEGEcJnxDpvbjYSH+zKp
	xUvA7wHQEoAPDJOs2DVwX+9o0/RwsnokOMzVqeCQKuwkLSNpBAkTZmvyRJ9AsFCrR6SG5TwPAI2
	EmeCN/Lw5qUhQSb3SHvdHfa9bI0QQUUg4ddP4xdAqpbgLLyoyx0mB9nr6NQ==
X-Google-Smtp-Source: AGHT+IEARlmxPP7ePbomx57jV59Vnj51ja91WbAjgkDpT2wZrH5+wmftvoM9H4n/NHkYz76gVwiYmA==
X-Received: by 2002:a05:6000:430d:b0:3cb:46fc:8eaa with SMTP id ffacd0b85a97d-3cb46fc8fe4mr7425313f8f.31.1756367043840;
        Thu, 28 Aug 2025 00:44:03 -0700 (PDT)
Received: from legfed1 (tmo-106-233.customers.d1-online.com. [80.187.106.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ca8f2811d9sm12653566f8f.20.2025.08.28.00.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:44:03 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:43:54 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: dimitri.fedrau@liebherr.com, Li peiyu <579lpy@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Lesiak <chris.lesiak@licorbio.com>
Subject: Re: [PATCH 2/2] iio: humditiy: hdc3020: fix units for thresholds and
 hysteresis
Message-ID: <20250828074354.GA3177@legfed1>
References: <20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com>
 <20250821-hdc3020-units-fix-v1-2-6ab0bc353c5e@liebherr.com>
 <DCANVO3ZBHUN.A8E9WABNLHG4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCANVO3ZBHUN.A8E9WABNLHG4@gmail.com>

Hi Javier,

Am Sun, Aug 24, 2025 at 08:36:58PM +0800 schrieb Javier Carrasco:
> Hello Dimitri, thank you for your patch. A few comments inline:
> 
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> >
> > According to the ABI the units after application of scale and offset are
> > milli degree celsius for temperature thresholds and milli percent for
> > relative humidity thresholds. Change scale factor to fix this issue.
> 
> I miss some explanation of what is going on (i.e. wrong) at the moment,
> the scale factor that is being used and what results are being obtained.
> 
Yes, will add it. Temperature is currently returned in degree celsius,
but should be returned in milli degree celsius. Relative humdity is
returned in percent, but should be returned in milli percent.

> > @@ -379,12 +379,12 @@ static int hdc3020_thresh_get_temp(u16 thresh)
> >  	 * Get the temperature threshold from 9 LSBs, shift them to get
> >  	 * the truncated temperature threshold representation and
> >  	 * calculate the threshold according to the formula in the
> 
> Having used 65535 back then without explaining why, or at least without using
> a #define was not the best idea. It's difficult to understand why it is used
> without getting into details.
>

Yes, will add a define and change the comment.

> 13107 is even less obvious. I believe you divided 65535 by 5 everywhere in the
> code, but it's not clear why.
>

The reason for it is to avoid overflows, because the thresholds and
hysteresis is now multiplied by 1000. Dividing the scale factor fixes this
issue, but makes the code even harder to understand. Will try to fix
this.

> I'd suggest a clear definition at the beginning of the code because it
> is used in different parts of the code, after having explained why it
> is necessary in the commit message as I mentioned before.
> 

Ok.

> > -	 * datasheet. Result is degree celsius scaled by 65535.
> > +	 * datasheet. Result is degree celsius scaled by 13107.
> >  	 */
> >  	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
> >  	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
> >  
> 
> Again, it's difficult to understand why everything is divided by 5.
>

Ok.

> > -	return -2949075 + (175 * temp);
> > +	return -589815 + (35 * temp);
> >  }
> >  
> >  static int hdc3020_thresh_get_hum(u16 thresh)
> > @@ -395,12 +395,12 @@ static int hdc3020_thresh_get_hum(u16 thresh)
> >  	 * Get the humidity threshold from 7 MSBs, shift them to get the
> >  	 * truncated humidity threshold representation and calculate the
> >  	 * threshold according to the formula in the datasheet. Result is
> > -	 * percent scaled by 65535.
> > +	 * percent scaled by 13107.
> >  	 */
> >  	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
> >  	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
> >  
> 
> Similarly, multiplying by 20 (100/5) looks weird for a percentage.
>

Ok, see above.

> > -	return hum * 100;
> > +	return hum * 20;
> >  }
> 
> ...
> 
> > @@ -630,7 +630,7 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
> >  		thresh = hdc3020_thresh_get_temp(ret);
> >  		switch (info) {
> >  		case IIO_EV_INFO_VALUE:
> 
> MILLI, as suggested for [1/2]? The same would apply to the following
> diffs.
> 

Ok.

> > -			*val = thresh;
> > +			*val = thresh * 1000;
> >  			break;
> >  		case IIO_EV_INFO_HYSTERESIS:
> >  			ret = hdc3020_read_be16(data, reg_clr);
> > @@ -638,18 +638,18 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
> >  				return ret;
> >  
> >  			clr = hdc3020_thresh_get_temp(ret);
> 
Best regards,
Dimitri Fedrau

