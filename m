Return-Path: <linux-iio+bounces-23637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA56B4014A
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1821B610F2
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69B2D4801;
	Tue,  2 Sep 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcbHz0sp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA152D24A6;
	Tue,  2 Sep 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817489; cv=none; b=tHs5hLtx+fcPkNg3aZhZzSIV5q3Fmw//Y9ZsUiBdCrh7iTj58s3bVaQtxhmIZ3kf1i1Tbs2xiXcyJaWzsYdSt2oaEgTBYhoFm2HraOgKHJ/aI5VECKCIWGNsC3E+Yx3oE8bLC4j6Xg0o97fXLnxs+5vvkWAy6JScbwKnlxvTTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817489; c=relaxed/simple;
	bh=TLGUagObZWCOkXwqXDTAIZvt/XeG7eaULdgwo4uktKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKiLboSPXNg0e1ii497n7dqHKR7oBYIl3T1VhdQkbMcJPhzNTnKu7NEO82LSMPMOMKEN+eiKU1U3RT8PXHfj6JzEHmDy+9twNA/wLyEhgcUF2kqLN4CJqbusTu8wCR0YJx0GplXjWJZrrY7Nr6wvwRkZ9dzW7yEKgJli+AMIcn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcbHz0sp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afefc7be9d4so621217466b.1;
        Tue, 02 Sep 2025 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756817486; x=1757422286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDLwODCLgRkUSbfU6TAGsZBnCsuHRzplrwr17+6otoo=;
        b=bcbHz0spkpVmh1c0tkiUWAyg29UYnWh9Ev/kX2tvx/6hRopd1HgYurpG7gcngRgCEo
         ebv5mVivJWDsgARs0DY9aWDEvYkC2tOcRUVKgtOMUuzKiR8ltmVi+da1w94FBPwwold7
         ou9Z8FJFjVQyzbu/pwOXdkjUvg4l9Unbzz6rXH4B6jLKgrJEEesJVzv/FnvQcklKEdN4
         ZuAsOuA0E44U5z5opfmS+3iujKQ0X2EcDB7wGvlp+ekpA9G4j2yR46bD53M5mbVt85g3
         aTGhRNFg3owD8zorZc9R4tjz9lvGQ5+uwkju4A42eYwd1c6EBy4p0DUEr5m6zEy/jjOd
         3Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817486; x=1757422286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDLwODCLgRkUSbfU6TAGsZBnCsuHRzplrwr17+6otoo=;
        b=FQovXXgAnpMXjAR/srlpfMGvqoPe0XcvQ/OAxR/kIKJcGBsj/ikhlWgsRPFYsEQORc
         /2pnHXr9ts2L+LBckXq24SnYiElXmzhLnk6yoGq/aF/ccRIVMUCBeCOKrF3ytSkU9Pc6
         b0tSq5lLC4Sd8+rwzTITnw5TUbdSNMxjYQ5J6xX5GwOC9TOa6iiRwbYTB8PQj1SU7Coy
         HCvZv45m9712FvCfzb94xHhnN3+VPxL7rb/tpXGXjgC+wzp6fVi2CuvgtRK53C0gUqUi
         hUd7s4P0GgIQ0lPKqla+KqTxASSXY2uDV5XFHGuCtYKxJJZyfN5TOQm0w362esYUWTe9
         DJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWz6pfrhfOho3OkOEhj/pe9312jIVmnJ910ympSSJsIC+NjlbBgBQp2mEqvtOgvLC82w0Psa6zDPRXeXnhV@vger.kernel.org, AJvYcCXSkZ2DQ+CySynJL15uxcubxm2y+4Fob/UI53P4L1PV+VaZJVizubStImFhsmxxvd9QqHjibZ2vHPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4/vxORU0rGhDMB0inDbFDSzJ3QirXqyKAqjZO1P+CraHALP/
	vcqMXlaZgnS9IUVgEi3Yn5oCbzbDW6BQ2EtPUDOK9ZKTawojvso/IpCA
X-Gm-Gg: ASbGncvVnJMJc5oV1m6Dn6W7d/usY7znNcsecjzK+FfS62yBzlmB4FumC10H/6eREHO
	gZlvtjlNCb27ItrHuoOVctjd9mf/aPk6akggCLJ4KNxmawLLvTR5jXCSqxcyGAiv1UrHXeX9UNC
	2s3IotA1zSn4L9W2yyNVTks+fzN0vL/kr3mqVXbSI34QYR98zSQcKDGy8zv6fGWtXH3DJHJissk
	V00oALXiDwDEZO1cRt6MObMFIFylaMYBiteDPLcaRwyrCdiDvssI+Xg+bPMrsSX1Tu7Cotc9pEV
	mQQM2k4COq2Wb9LzL4TXccmSkiYIqFTVl/n09XzC+/gZ0S8fTBLlqGrBG8VzUxWO0zWhGFk+Xe9
	3yOjwKS9MSriHft3vikwz
X-Google-Smtp-Source: AGHT+IHDY/b7fEpr+zM9TOwB6mxcT1yYikeZYY/D9XXHKrQCGFRQqZR1ty8y1y/kCx/8kapVx36ZOw==
X-Received: by 2002:a17:907:a47:b0:afe:ea93:ddbb with SMTP id a640c23a62f3a-b01d975d241mr1039266066b.45.1756817485720;
        Tue, 02 Sep 2025 05:51:25 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:620:3f00:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0681aefdsm1050799766b.8.2025.09.02.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:51:25 -0700 (PDT)
Date: Tue, 2 Sep 2025 14:51:23 +0200
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
Subject: Re: [PATCH v2 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
Message-ID: <20250902125123.GA49718@legfed1>
References: <20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com>
 <20250901-hdc3020-units-fix-v2-2-082038a15917@liebherr.com>
 <DCIAU0EO8E0K.3JIXZ2XICP3YC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCIAU0EO8E0K.3JIXZ2XICP3YC@gmail.com>

Am Tue, Sep 02, 2025 at 08:04:53PM +0800 schrieb Javier Carrasco:
> Hi Dimitri, thank you for your patch. A few comments inline.
> 
> On Tue Sep 2, 2025 at 1:51 AM CST, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> >
> > According to the ABI the units after application of scale and offset are
> > milli degree celsius for temperature thresholds and milli percent for
> > relative humidity thresholds. Currently the resulting units are degree
> > celsius for temperature thresholds and hysteresis and percent for relative
> > humidity thresholds and hysteresis. Change scale factor to fix this issue.
> >
> > Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
> > Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  drivers/iio/humidity/hdc3020.c | 69 +++++++++++++++++++++++++-----------------
> >  1 file changed, 41 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> > index 8aa567d9aded9cab461f1f905b6b5ada721ba2f0..deb19e0291f7f820c5f8760fbf0682379ab5f34b 100644
> > --- a/drivers/iio/humidity/hdc3020.c
> > +++ b/drivers/iio/humidity/hdc3020.c
> > @@ -72,6 +72,13 @@
> >  #define HDC3020_MAX_TEMP_HYST_MICRO	164748607
> >  #define HDC3020_MAX_HUM_MICRO		99220264
> >  
> > +/*
> > + * In order to avoid overflows when returning thresholds and hysteresis values,
> > + * the fraction of these is set to 13107, also the datasheet refers to 65535
> > + * this is not enough to prevent overflows. Dividing this value by 5 fixes this.
> > + */
> > +#define HDC3020_THRESH_FRACTION		(65535 / 5)
> > +
> 
> I think the comment is a bit too verbose. If you explain why the value
> has to be divided by 5, you probably don't need to tell the result of
> the division. Something as simple as "divide 65535 from the datasheet by
> 5 to avoid overflows" could do.
>

Ok, will change the comment as you suggested.

> >  struct hdc3020_data {
> >  	struct i2c_client *client;
> >  	struct gpio_desc *reset_gpio;
> > @@ -376,15 +383,16 @@ static int hdc3020_thresh_get_temp(u16 thresh)
> >  	int temp;
> >  
> >  	/*
> > -	 * Get the temperature threshold from 9 LSBs, shift them to get
> > -	 * the truncated temperature threshold representation and
> > -	 * calculate the threshold according to the formula in the
> > -	 * datasheet. Result is degree celsius scaled by 65535.
> > +	 * Get the temperature threshold from 9 LSBs, shift them to get the
> > +	 * truncated temperature threshold representation and calculate the
> > +	 * threshold according to the formula in the datasheet and additionally
> > +	 * scale by HDC3020_THRESH_FRACTION to avoid precision loss when
> > +	 * calculating threshold and hysteresis values.
> 
> If I got it right, you are actually dividing by 5 and not by
> HDC3020_THRESH_FRACTION.

I do scale it by HDC3020_THRESH_FRACTION.

Formula from the datasheet is:
T( deggree celsius) = -45 + (175 * temp) / 65535

Before patching it was(scaled by 65535):

T(degree celsius) * 65535 = -2949075 + (175 * temp)

After patching(scaled by 13107):

T(degree celsius) * 13107 = -589815 + (35 * temp)

I need to scale the return value to avoid precision loss when
calculating threshold and hysteresis values.

> 
> >  	 */
> >  	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
> >  	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
> >  
> > -	return -2949075 + (175 * temp);
> > +	return -589815 + (35 * temp);
> >  }
> >  
> >  static int hdc3020_thresh_get_hum(u16 thresh)
> > @@ -394,13 +402,14 @@ static int hdc3020_thresh_get_hum(u16 thresh)
> >  	/*
> >  	 * Get the humidity threshold from 7 MSBs, shift them to get the
> >  	 * truncated humidity threshold representation and calculate the
> > -	 * threshold according to the formula in the datasheet. Result is
> > -	 * percent scaled by 65535.
> > +	 * threshold according to the formula in the datasheet and additionally
> > +	 * scale by HDC3020_THRESH_FRACTION to avoid precision loss when
> > +	 * calculating threshold and hysteresis values.
> 
> Same here?
> 

See above.

> >  	 */
> >  	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
> >  	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
> >  
> > -	return hum * 100;
> > +	return hum * 20;
> >  }
>

Best regards,
Dimitri Fedrau

