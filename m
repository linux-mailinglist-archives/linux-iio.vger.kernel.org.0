Return-Path: <linux-iio+bounces-26552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0AC92EFD
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 19:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21B93A65B8
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3761D2D0C82;
	Fri, 28 Nov 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLUQgNlF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A412853F8
	for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764355811; cv=none; b=H41ehw+9B0K01mJy+8MneBW3BYPhdbuByop8kVJPe435RZ/K3IQyKY6FrnOl8tC1zfe8ZGRxNJocQKSAfpeu7VMRrFqG19T6nTmqhZO9VyPF39mFggqlG9CUhFLbbGd0/v7DcmKZzLf61F+FQa0wkkl9HSIBghQd7xhLONIklrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764355811; c=relaxed/simple;
	bh=/h8yBxablWPek+7hHxFXlQhCloZaZBbzt6CtKnqg49U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyt8cT+Sgz2D3kFiqn0bfGipKuvNmoTpLggBNDYYSbNye6QYYjEET65+2bwPYI6rTMANnbr037ntorlkFcQSpQEcGNrpd5uqrD9jw2AI1obJ5f8ksKemBeBXWJh3h/TaqAcIipESyC5vWnD/XsWRzwHSTird/sq1ErSPTgTtkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLUQgNlF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7291af7190so343694466b.3
        for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764355805; x=1764960605; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WX7GZ7QIiC0YJ3z3A28BFLchPllyieUl7kC9JuxEexI=;
        b=ZLUQgNlFXiLH6Rlo7oZ0ws+ftdsP+cuH7kkzkn38g6xObqeiZBQ3c/QhiKOxpeDi+O
         2u5lUiIXOY/6mEIhrheLGBi6VDXNmm/WIXDaAjgifdVLyB63XaBRRPbtJP6u8fBIijNr
         p3l6OoImDwHrdXRU4yk7z2XtyuKDFaI/xgwUD8cooasj3FeIPC7SYxB9PqMVgrh5SXNV
         gYYuStITzxHWBNnLc1bjUYHwGFpAN+diIu4Lu9IOOHwQl/4BauLfGSmdBX6Ul2Hy5u7A
         WuYm2XDglEsERBAMetrm9k58jCfqgk3OalK0ZOQeWijqlcTZyFf7wGWk7Rv6s/FvFlYs
         4ZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764355805; x=1764960605;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WX7GZ7QIiC0YJ3z3A28BFLchPllyieUl7kC9JuxEexI=;
        b=FKsfcPjo3BTyMvT183tFevQKB64a2f85kZG+OXhiV69HxWdhRPOeGdPlvMBJrVHMTz
         KmaksTZ0nYZRqVu9Me5ST34nloGY28TmhbrmYoX5MtcgU6TnFiehDxyxyQaUlaAMCeB5
         SPF+JYJylT1OaRQGOtZXk8rOEzUkIAn3TzuKQaC0feYSf8BuN6FIXyJNVooXfSJqVoEt
         Ivjy2ewFoNHq73kou3DdV4imbzMLuHD5qovd8vOxLb8YxvsDALfOqiE1dTu1+0QHG7fR
         j0qGg0H3IMAKwrhJXxGWfrkVbDMYLiRx8RqldtDcEy/sfKVfx7YiLl3MRMGT8Qif3/A5
         LzdA==
X-Forwarded-Encrypted: i=1; AJvYcCXJVDaauhC+VmF/hes/wFPz7D+dOGRJ8m629MVYMfWE7jMFja75kM31Mhr2MNsv4Krl8lZP1GPRAsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7en1cdDiS1XJlo21I3UYpzDfx2ElypwaD79bSIxVQlB0KsZd3
	dHPkuZoKeiSe/mQWAfgKQm0DRPXc4B9owP1wX7IT9tFIL5jPZiRSSLes
X-Gm-Gg: ASbGncuTOMhKmA+eW+FT+nb7Ea6z2LwkWFuIKHKuvdkIAJQqP5Li+LZ7hETK01AweGX
	WIjTMmhlDNPBpF3Nm/jp+smaAk1WkxQUoSdOnDwyzfO1lQoemigOrZTkbIkP45NhWJt6GGCWmGt
	2EyJrVwK/enD69L8mrqocBv5QTbi9AlVfSa/MFdNPGSIZWsJp7c15Gw6VMupHlyY2cUfs3c2Nrq
	bCxePesP38s/69HSec5KmS4Q9nwdEoWRYD4NsDQeRGoam6Ul2EQkezcWeORdneXiiLGuIkuoemS
	48Lhx1+nmcHX3DappoEfmE4fBmyuTZY4whN4U25EEcgP1VXyO4RHW6YihmmiOvEmsTGKXUnGyWI
	CiVRmLpoq9PtRPRmQvoC6u3xUQ6Asq7X1YZGL/HVOK35zuafDnN8qbpe83vXO5YP/tXjmVJDPdi
	2tg+U/RMcKZdyV70II/kFft1kz6RElK6wfwlirw3B6qt5Jp7WETxbmC1FTXUxSRufqmTY=
X-Google-Smtp-Source: AGHT+IEfDY4uJ23hVVMVaAzxQghRjOMG1yRqhMDfjHc9KdSb/oNvxNcfvVZLVHw5LrgA3lbTv/qKSQ==
X-Received: by 2002:a17:907:d93:b0:b73:3028:93a1 with SMTP id a640c23a62f3a-b767150b284mr2641160466b.9.1764355804992;
        Fri, 28 Nov 2025 10:50:04 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:123e:4501:6960:7067:c8e2:c770])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f516416esm518395066b.4.2025.11.28.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 10:50:04 -0800 (PST)
Date: Fri, 28 Nov 2025 19:50:02 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/9] iio: adc: Add support for ad4062
Message-ID: <zryqws2h2i4duejczo2rptwhlzhile7fa7brriqh2hmtarwjxn@cr2cyzymwpav>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-3-a375609afbb7@analog.com>
 <aSQxiSoZcI_ol3S5@smile.fi.intel.com>
 <aslj3klmv6heyyhgltzewkdze5p4c3hlkzfbxbfnzwwgd375gv@m6iqpst5sv6b>
 <aSgSsGSUuBtMOuro@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSgSsGSUuBtMOuro@smile.fi.intel.com>

On Thu, Nov 27, 2025 at 10:58:24AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 26, 2025 at 12:40:00PM +0100, Jorge Marques wrote:
> > On Mon, Nov 24, 2025 at 12:20:57PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 24, 2025 at 10:18:02AM +0100, Jorge Marques wrote:
> 
> ...
> 
> > > > +#define AD4062_MON_VAL_MAX_GAIN		1999970
> > > 
> > > This is decimal...
> > > 
> > > > +#define AD4062_MON_VAL_MIDDLE_POINT	0x8000
> > > 
> > > ...and this is hexadecimal. Can you make these consistent?
> > > Also, is there any explanation of the number above? To me
> > > it looks like 2000000 - 30. Is it so? Or is this a fraction
> > > number multiplied by 1000000 or so? In any case some elaboration
> > > would be good to have.
> > > 
> > Since this is not a magic number, I will use directly below.
> > It MAX_MON_VAL/MON_VAL_MIDDLE_POINT = 0xFFFF/0x8000
> 
> Okay, at least it will explain the value.
> 
> ...
> 
> > > > +	if (val < 1 || val > BIT(st->chip->max_avg + 1))
> > > 
> > > in_range() ?
> > > 
> > > 	in_range(val, 1, GENMASK(st->chip->max_avg, 0))
> > > 
> > > if I am not mistaken. Also note, the GENMASK() approach makes possible
> > > to have all 32 bits set, however it's most unlikely to happen here anyway.
> > > 
> > Sure, but requires locals to not trigger suspicious usage of sizeof.
> >   	// ...
> >   	const u32 _max = GENMASK(st->chip->max_avg, 0);
> >   	const u32 _min = 1;
> >   	int ret;
> >   
> >   	if (in_range(val, _min, _max))
> > > > +		return -EINVAL;
> 
> It's fine.
> 
> ...
> 
> > > > +static int ad4062_calc_sampling_frequency(int fosc, unsigned int n_avg)
> > > > +{
> > > > +	/* See datasheet page 31 */
> > > > +	u64 duration = div_u64((u64)(n_avg - 1) * NSEC_PER_SEC, fosc) + AD4062_TCONV_NS;
> > > > +
> > > > +	return DIV_ROUND_UP_ULL(NSEC_PER_SEC, duration);
> > > 
> > > Why u64?
> > > 
> > > The DIV_ROUND_UP_ULL() seems an overkill here. Or do you expect duration be
> > > more than 4 billions?
> > > 
> > This is necessary since at fosc 111 Hz and avg 4096 it does take longer
> > than 4 seconds, even though I do timeout after 1 seconds in the raw
> > acquisition.
> 
> Values above NSEC_PER_SEC+1 do not make sense (it will return 0),
> and that fits u32. Can you refactor to avoid 64-bit arithmetics?
>

Ok, any frequency lower than 1 Hz does not make sense.

  static int ad4062_calc_sampling_frequency(int fosc, unsigned int oversamp_ratio)
  {
  	/* See datasheet page 31 */
  	u32 period = NSEC_PER_SEC / fosc;
  	u32 n_avg = BIT(oversamp_ratio) - 1;
  
  	/* Result is less than 1 Hz */
  	if (n_avg >= fosc)
  		return 1;
  	return NSEC_PER_SEC / (n_avg * period + AD4062_TCONV_NS);
  }

> > > > +}
> 
> ...
> 
> > > > +static int ad4062_soft_reset(struct ad4062_state *st)
> > > > +{
> > > > +	u8 val = AD4062_SOFT_RESET;
> > > > +	int ret;
> > > > +
> > > > +	ret = regmap_write(st->regmap, AD4062_REG_INTERFACE_CONFIG_A, val);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Wait AD4062 treset time */
> > > > +	fsleep(5000);
> > > 
> > > 5 * USEC_PER_MSEC
> > > 
> > > This gives a hint on the units without even a need to comment or look somewhere
> > > else.
> > >
> > // TODO
> > Since the device functional blocks are powered when voltage is supplied,
> > here we can stick with the treset datasheet value 60ns (ndelay(60)).
> 
> Add a comment and it will work for me, thanks!
> 
> > > > +	return 0;
> > > > +}
> 
> ...
> 
> > > > +static const int ad4062_oversampling_avail[] = {
> > > > +	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096,
> > > 
> > > It's not easy to count them at glance, please add a comment with indices.
> > > 
> > Ack, will use
> >   static const int ad4062_oversampling_avail[] = {
> >           BIT(0), BIT(1), BIT(2), BIT(3), BIT(4), BIT(5), BIT(6), BIT(7), BIT(8),
> >   	BIT(9), BIT(10), BIT(11), BIT(12),
> >   };
> 
> Of course you can use bit notations, but what I meant is to have
> 
> 	1, 2, 4, 8, 16, 32, 64, 128,		/*  0 -  7 */
> 	256, 512, 1024, 2048, 4096,		/*  8 - 12 */
> 
> (or something alike).
> 
Ack
> > > > +};
> 
> ...
> 
> > > > +static int ad4062_get_chan_calibscale(struct ad4062_state *st, int *val, int *val2)
> > > > +{
> > > > +	u16 gain;
> > > > +	int ret;
> > > > +
> > > > +	ret = regmap_bulk_read(st->regmap, AD4062_REG_MON_VAL,
> > > > +			       &st->buf.be16, sizeof(st->buf.be16));
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	gain = get_unaligned_be16(st->buf.bytes);
> > > > +
> > > > +	/* From datasheet: code out = code in × mon_val/0x8000 */
> > > > +	*val = gain / AD4062_MON_VAL_MIDDLE_POINT;
> > > 
> > > > +	*val2 = mul_u64_u32_div(gain % AD4062_MON_VAL_MIDDLE_POINT, NANO,
> > > > +				AD4062_MON_VAL_MIDDLE_POINT);
> > > 
> > > I don't see the need for 64-bit division. Can you elaborate what I miss here?
> > > 
> > > > +	return IIO_VAL_INT_PLUS_NANO;
> > > > +}
> > > 
> > Can be improved to
> > 
> >   static int ad4062_get_chan_calibscale(struct ad4062_state *st, int *val, int *val2)
> >   {
> >   	int ret;
> >   
> >   	ret = regmap_bulk_read(st->regmap, AD4062_REG_MON_VAL,
> >   			       &st->buf.be16, sizeof(st->buf.be16));
> >   	if (ret)
> >   		return ret;
> >   
> >   	/* From datasheet: code out = code in × mon_val/0x8000 */
> >   	*val = get_unaligned_be16(st->buf.bytes) * 2;
> >   	*val2 = 16;
> >   
> >   	return IIO_VAL_FRACTIONAL_LOG2;
> >   }
> 
> Much better, thanks!
> 
> ...
> 
> > > > +static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int, int gain_frac)
> > > 
> > > Forgot to wrap this line.
> > > 
> > ack
> > > > +{
> > > > +	u64 gain;
> > > > +	int ret;
> > > > +
> > > > +	if (gain_int < 0 || gain_frac < 0)
> > > > +		return -EINVAL;
> > > > +
> > > > +	gain = mul_u32_u32(gain_int, MICRO) + gain_frac;
> > > 
> > > > +
> > > 
> > > Redundant blank line.
> > > 
> > Ack.
> > > > +	if (gain > AD4062_MON_VAL_MAX_GAIN)
> > > > +		return -EINVAL;
> > > > +
> > > > +	put_unaligned_be16(DIV_ROUND_CLOSEST_ULL(gain * AD4062_MON_VAL_MIDDLE_POINT,
> > > > +						 MICRO),
> > > > +			   st->buf.bytes);
> > > 
> > > Also in doubt here about 64-bit division.
> > > 
> > This can be slightly improved to
> > 
> >   static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int,
> >   				      int gain_frac)
> >   {
> >   	u32 gain;
> >   	int ret;
> >   
> >   	if (gain_int < 0 || gain_frac < 0)
> >   		return -EINVAL;
> >   
> >   	gain = gain_int * MICRO + gain_frac;
> >   	if (gain > 1999970)
> 
> But this magic should be changed to what you explained to me
> (as in 0xffff/0x8000 with the proper precision, and this
>  can be done in 32-bit space).
> 
> Or even better
> 
> 	if (gain_int < 0 || gain_int > 1)
> 		return -EINVAL;
> 
> 	if (gain_int == 1 && gain_frac > 0x7fff) // did I get this right?
> 		return -EINVAL;
> 
gain_frac would be 999999 max, or 999970 for the limit that fits in the
register after the math. I think > 1.999.970 is self explanatory.
> >   		return -EINVAL;
> >   
> >   	put_unaligned_be16(DIV_ROUND_CLOSEST_ULL((u64)gain * AD4062_MON_VAL_MIDDLE_POINT,
> >   						 MICRO),
> 
> ...with temporary variable at minimum.
> 
> But again, I still don't see the need for 64-bit space.
> 

Well, by dividing mon_val and micro values by a common divisor the
operation fit in 32-bits:

  static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int,
                                        int gain_frac)
  {
          const u32 mon_val = AD4062_MON_VAL_MIDDLE_POINT / 64;
          const u32 micro = MICRO / 64;
          const u32 gain = gain_int * MICRO + gain_frac;
          int ret;

          if (gain_int < 0 || gain_frac < 0)
                  return -EINVAL;

          if (gain > 1999970)
                  return -EINVAL;

          put_unaligned_be16(DIV_ROUND_CLOSEST(gain * mon_val, micro), st->buf.bytes);

          ret = regmap_bulk_write(st->regmap, AD4062_REG_MON_VAL,
                                  &st->buf.be16, sizeof(st->buf.be16));
          if (ret)
                  return ret;

          /* Enable scale if gain is not equal to one */
          return regmap_update_bits(st->regmap, AD4062_REG_ADC_CONFIG,
                                    AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
                                    FIELD_PREP(AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
                                               !(gain_int == 1 && gain_frac == 0)));
  }


> >   			   st->buf.bytes);
> >   
> >   	ret = regmap_bulk_write(st->regmap, AD4062_REG_MON_VAL,
> >   				&st->buf.be16, sizeof(st->buf.be16));
> >   	if (ret)
> >   		return ret;
> >   
> >   	/* Enable scale if gain is not equal to one */
> >   	return regmap_update_bits(st->regmap, AD4062_REG_ADC_CONFIG,
> >   				  AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
> >   				  FIELD_PREP(AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
> >   					     !(gain_int == 1 && gain_frac == 0)));
> >   }
> > 
> > To provide the enough resolution to compute every step (e.g., 0xFFFF and
> > 0xFFFE) with the arbitrary user input.
> 
> ...
> 
> > > > +static int __ad4062_read_chan_raw(struct ad4062_state *st, int *val)
> > > 
> > > Can be named without leading double underscore? Preference is to use
> > > the suffix, like _no_pm (but you can find better one).
> > > 
> > Since there is one usage of this method, can be merged into ad4062_read_chan_raw.
> 
> Good choice!
> 
> ...
> 
> > > > +	struct i3c_priv_xfer t[2] = {
> > > > +		{
> > > > +			.data.out = &st->reg_addr_conv,
> > > > +			.len = sizeof(st->reg_addr_conv),
> > > > +			.rnw = false,
> > > > +		},
> > > > +		{
> > > > +			.data.in = &st->buf.be32,
> > > > +			.len = sizeof(st->buf.be32),
> > > > +			.rnw = true,
> > > > +		}
> > > > +	};
> 
> > > > +	/* Change address pointer to trigger conversion */
> > > > +	ret = i3c_device_do_priv_xfers(i3cdev, &t[0], 1);
> > > 
> > > Why array? Just split them on per transfer and use separately. This gives a bit
> > > odd feeling that the two goes together, but no. They are semi-related as we
> > > have a special condition after the first one.
> > > 
> > For this commit sure, but in the next a fallback method is introduced
> > for when the gp1 gpio line is not connected.
> > There are two register to trigger and read samples:
> > 
> > * write CONV_READ -> read dummy value - [conversion] -> read value -> [conv ...
> > * write CONV_TRIGGER - [conversion] -> read value -> write ...
> > 
> > The first allows almost twice the sampling frequency, but does not work
> > with the fallback because In-Band-Interrupt for CONV_READ are not
> > yielded.
> 
> Do you mean that the same array is reused differently? If so, then okay.
> 
Yes
> > > > +	if (ret)
> > > > +		return ret;
> 
> ...
> 
> > > > +	fsleep(4000);
> > > 
> > > 4 * USEC_PER_MSEC, also would be good to add a comment for this long delay.
> > > 
> > Will add
> > 	/* Wait device functional blocks to power up */
> > Based on hardware tests, I can drop to 2 * USEC_PER_MSEC, lower than
> > that the device is not ready to switch to acquisition mode for
> > conversions.
> 
> Good!
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
Best regards,
Jorge

