Return-Path: <linux-iio+bounces-22461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7058B1EA2D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03C11AA52BB
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6F52737E3;
	Fri,  8 Aug 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8iMGdHl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFA1482F2;
	Fri,  8 Aug 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662656; cv=none; b=F8T2W+arObZa+9GkQKFr5jT3CC+H+ZT6veeLzAKNdWblCFHWoyCIQaLY0/X8CTmdBvCqzhmb5iFCroc4EQn2EYhzX5wSelYvX7OP0YJdUUIoQcO7D8H1C2kdAfa/zz8AtGV0hFt0gz5T1nhR6bh3yAJCUOCLV4qSQ0khNWk+5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662656; c=relaxed/simple;
	bh=18bOJVl3ywIQO+1F9vAxCx3heO57g6E0VCx9+/oiTC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbA8XLe9qbrl/FKwvDd6/kZCdArV4mkIT5dhEUXvlGvboiJlz0DwsowyRzbUWmyla8TjPx3srWJYdvmXILaYFH1kFqX/FspUhtrvKxMsLRs9Udnaqs0tqnAshmjRZqNkHlgH8x8YphEXA7/+iXvmWS93PI3qSVgndn4s9gi8eGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8iMGdHl; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7094f298dc3so18360706d6.2;
        Fri, 08 Aug 2025 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754662654; x=1755267454; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZHkibtg2Q+TrEAqPuIe0syxbU3o+8f5vObMW+NHGo3A=;
        b=j8iMGdHllRzDTTUcGZL/LYYBxuZqXz7Ag7hNvViXpoRB9xBWkBQsylzZze/h9WL3Vu
         GXzetyV0phW98a7U/AdTe29BwAz/30E+rmmuRXo3ac3cFGGfb5DyJ5b8k9PHiouZqay2
         GLt14dmBeBzEdEVHmOvOXLmurUlepS62qFCm1DiLBpIbkdt9bzmU43e83Z3mZVKAUqqt
         V6/F87mNX4WVA7wGbwQWX3+YRYPi3VonUHgzFf8bBT00RPtsYsa2bhGaOY6RELm/4rmb
         Yy9jcT9LO5wM9lAmDraLldXDgIHc3EVgSpEZAEZSPy7D7xhdGSvl2jOFG8Vq+F3hqIJp
         pZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754662654; x=1755267454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHkibtg2Q+TrEAqPuIe0syxbU3o+8f5vObMW+NHGo3A=;
        b=oKXJNuah0X/Wi0TDMoKrUMCFHEGB2m+68q2526MAJkCdt/gyjY+5IPeePae1KOEb4b
         XB/ManUDaBC5hqU6sFQUkrTmbrVqJfZXEke3a1FcPH0NjmIAlT2cLbb5MxtUioSLMES6
         ePs4mlveIyCkCeOxZjuzKRIfxnH249f2Yefx/TiRS8wt9qm1KSFSxDeHhtU9cYDlc9bI
         KtC8GPHjQA0sWbWPWFJpx+C3bmKDolxaCSxl6sxkH+WMaRT8gaYeqUOGGifeKyDjAi2i
         AFa0+GZCS4qDK34uiKeMJg28MwfsizFoYNEYY8+tD9FTTMI1Ozki+5vAdvUOIiPY+WUo
         WD/w==
X-Forwarded-Encrypted: i=1; AJvYcCUstG8iHpuAbJpSjwN8e5HbpOGLqLnmXdHekywHLslebGvWGODKK6/SV4wXJMGg6U1i1Ed4PNIMxMKB@vger.kernel.org, AJvYcCVSXeTs7wkaJXZzESo4MixuDy9x2aDpBMOMzr+cHI8HJrGohvQ9GEwrLNm0rJSiwOl6IjWlFFbT/XeW@vger.kernel.org, AJvYcCWDf8zJFdYH7hKsfKAdKVCWEDqvTmpv++Gvq/X4k8Gm6Q4dkSYOSr/WLNgcWVIWTK/4bPwp+Hu8zMyk1tNS@vger.kernel.org
X-Gm-Message-State: AOJu0YxzPtmkeoIolqWYt7r631SlwoHWYsO0z+awhcNCZf1rDfMAH4i6
	tCCSmIQ73FiCZRU2Nh7c/6xPXLdBXMK1468oLIE0ILfaZwN6tLOH3trekInpn2Xuip2ZeA==
X-Gm-Gg: ASbGnctDcT49B7GEwzKvPospmdKIBhV6xjjk2oyGzlAVOjlTbgIdRPpSxJc0gHixS/r
	nr4oxlLha7MiFcjPd+HZ87+UoLuGhS14mugBhJ7bff5/g/yJFlHJJfccqaxh7JxJdMnvxsDwKu1
	v3ct9i1xZ2EsjgQEcHbh2sVe61zyE2pg9kR0pRyzhZV00LWtJjByQV8gIVYsIk/WNY2Nn814XVa
	nEddBk76pDFS8NqrtU0j4eM7h7aOdYDXLV4gVavUoKmZDndXIzqTai7CdumCX9gRCRLxN9RpXtF
	mDXovU2Szt6KzpWKWwFLQdfWgnX0m1Nlk3hJ9hIDVCotPGTagEeAFQvf3PIdiJWpumfkB4o92GB
	J/Scdc5rbGBrQOg==
X-Google-Smtp-Source: AGHT+IFJ65VpV6VGkUjkJp0LIBOjHlcR1qJbbBolxVL95tAtZH+4KOH1LX/sxvT4gnS+kDjlfDdn+Q==
X-Received: by 2002:ad4:5f0e:0:b0:6ff:1548:6f0b with SMTP id 6a1803df08f44-7099a520ef8mr40020316d6.44.1754662653319;
        Fri, 08 Aug 2025 07:17:33 -0700 (PDT)
Received: from nsa ([87.249.138.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c716effsm114875346d6.0.2025.08.08.07.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:17:32 -0700 (PDT)
Date: Fri, 8 Aug 2025 15:17:47 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] iio: adc: ad7476: Drop convstart chan_spec
Message-ID: <hugrto5p57yzk6svy36wywkkfftxdnpovpkmw4ocnqvm37hgr6@zyzzm4axofkd>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
 <tc4od3jtqnj743naxefx5lxkha46wohuuvw46mik6nullvsqbe@knj4t23eaodw>
 <ngcbj6p7vfakah5fqsxqjlmrcycpg5rxfrbh4s34fll2kb3zq2@eyesluawn5w2>
 <076b7f07-e755-4fe7-84b1-f3f495978008@gmail.com>
 <t54tty4xbcsozeouoqmytdw6saedgoxbemnr2azbiv2f4h2wta@rf4fnooawrgs>
 <62dbfa31-002b-4008-9273-01b161a72cac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62dbfa31-002b-4008-9273-01b161a72cac@gmail.com>

On Fri, Aug 08, 2025 at 12:09:21PM +0300, Matti Vaittinen wrote:
> On 08/08/2025 12:00, Nuno Sá wrote:
> > On Fri, Aug 08, 2025 at 08:37:07AM +0300, Matti Vaittinen wrote:
> > > On 07/08/2025 16:10, Nuno Sá wrote:
> > > > On Thu, Aug 07, 2025 at 01:41:31PM +0100, Nuno Sá wrote:
> > > > > On Thu, Aug 07, 2025 at 12:34:52PM +0300, Matti Vaittinen wrote:
> > > > > > The ad7476 driver defines separate chan_spec structures for operation
> > > > > > with and without convstart GPIO. At quick glance this may seem as if the
> > > > > > driver did provide more than 1 data-channel to users - one for the
> > > > > > regular data, other for the data obtained with the convstart GPIO.
> > > > > > 
> > > > > > The only difference between the 'convstart' and 'non convstart'
> > > > > > -channels is presence / absence of the BIT(IIO_CHAN_INFO_RAW) in
> > > > > > channel's flags.
> > > > > > 
> > > > > > We can drop the convstart channel spec, and related convstart macro, by
> > > > > > allocating a mutable per driver instance channel spec an adding the flag
> > > > > > in probe if needed. This will simplify the driver with the cost of added
> > > > > > memory consumption.
> > > > > > 
> > > > > > Assuming there aren't systems with very many ADCs and very few
> > > > > > resources, this tradeoff seems worth making.
> > > > > > 
> > > > > > Simplify the driver by dropping the 'convstart' channel spec and
> > > > > > allocating the chan spec for each driver instance.
> > > > > 
> > > > > I do not agree with this one. Looking at the diff, code does not look
> > > > > simpler to me...
> > > > 
> > > > Ok, on a second thought I'm ok with this. It makes adding devices easier
> > > > and (IIUC) for the one you're adding later we only have "convst_channel"
> > > > channels.
> > > 
> > > Yes, that's right. The BD79105 requires the convstart.
> > > 
> > > > On comment though...
> > > > 
> > > > > 
> > > > > - Nuno Sá
> > > > > 
> > > > > > 
> > > > > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > > > > 
> > > > > > ---
> > > > > > Revision history:
> > > > > >    v1 => v2:
> > > > > >    - New patch
> > > > > > 
> > > > > > I considered squashing this change with the one limiting the chip_info
> > > > > > scope. Having this as a separate change should help reverting if someone
> > > > > > complains about the increased memory consumption though.
> > > > > > ---
> > > > > >    drivers/iio/adc/ad7476.c | 31 ++++++++++++++++++-------------
> > > > > >    1 file changed, 18 insertions(+), 13 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > > > > > index e97742912b8e..a30eb016c11c 100644
> > > > > > --- a/drivers/iio/adc/ad7476.c
> > > > > > +++ b/drivers/iio/adc/ad7476.c
> > > > > > @@ -29,8 +29,6 @@ struct ad7476_state;
> > > > > >    struct ad7476_chip_info {
> > > > > >    	unsigned int			int_vref_mv;
> > > > > >    	struct iio_chan_spec		channel[2];
> > > > > > -	/* channels used when convst gpio is defined */
> > > > > > -	struct iio_chan_spec		convst_channel[2];
> > > > > >    	void (*reset)(struct ad7476_state *);
> > > > > >    	bool				has_vref;
> > > > > >    	bool				has_vdrive;
> > > > > > @@ -41,6 +39,7 @@ struct ad7476_state {
> > > > > >    	struct gpio_desc		*convst_gpio;
> > > > > >    	struct spi_transfer		xfer;
> > > > > >    	struct spi_message		msg;
> > > > > > +	struct iio_chan_spec		channel[2];
> > > > > >    	int				scale_mv;
> > > > > >    	/*
> > > > > >    	 * DMA (thus cache coherency maintenance) may require the
> > > > > > @@ -153,24 +152,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
> > > > > >    #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
> > > > > >    		BIT(IIO_CHAN_INFO_RAW))
> > > > > >    #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> > > > > > -#define AD7091R_CONVST_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), \
> > > > > > -		BIT(IIO_CHAN_INFO_RAW))
> > > > > >    #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
> > > > > >    		BIT(IIO_CHAN_INFO_RAW))
> > > > > >    static const struct ad7476_chip_info ad7091_chip_info = {
> > > > > >    	.channel[0] = AD7091R_CHAN(12),
> > > > > >    	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > > > -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
> > > > > > -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > > >    	.reset = ad7091_reset,
> > > > > >    };
> > > > > >    static const struct ad7476_chip_info ad7091r_chip_info = {
> > > > > >    	.channel[0] = AD7091R_CHAN(12),
> > > > > >    	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > > > -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
> > > > > > -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > > >    	.int_vref_mv = 2500,
> > > > > >    	.has_vref = true,
> > > > > >    	.reset = ad7091_reset,
> > > > > > @@ -282,7 +275,7 @@ static int ad7476_probe(struct spi_device *spi)
> > > > > >    	const struct ad7476_chip_info *chip_info;
> > > > > >    	struct ad7476_state *st;
> > > > > >    	struct iio_dev *indio_dev;
> > > > > > -	int ret;
> > > > > > +	int ret, i;
> > > > > >    	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > > > > >    	if (!indio_dev)
> > > > > > @@ -332,16 +325,28 @@ static int ad7476_probe(struct spi_device *spi)
> > > > > >    	if (IS_ERR(st->convst_gpio))
> > > > > >    		return PTR_ERR(st->convst_gpio);
> > > > > > +	/*
> > > > > > +	 * This will never realize. Unless someone changes the channel specs
> > > > > > +	 * in this driver. And if someone does, without changing the loop
> > > > > > +	 * below, then we'd better immediately produce a big fat error, before
5eefac72163e88cc6697bec77c54e4393788e1bf> > > > > > +	 * the change proceeds from that developer's table.
> > > > > > +	 */
> > > > > > +	BUILD_BUG_ON(ARRAY_SIZE(st->channel) != ARRAY_SIZE(chip_info->channel));
> > > > 
> > > > I guess it make sense but still looks too fancy for this :)
> > > 
> > > Nothing else but a developer's carefulness keeps the number of channels "in
> > > sync" for these two structs. I was originally doing WARN_ON() - but then I
> > > thought that it's be even better to catch this at build time. Then I found
> > > the BUILD_BUG_ON(). I see Andy suggested static_assert() instead - I've no
> > > idea why one is preferred over other though. Let's see if I get educated by
> > > Andy :)
> > > 
> > > > 
> > > > > > +	for (i = 0; i < ARRAY_SIZE(st->channel); i++) {
> > > > > > +		st->channel[i] = chip_info->channel[i];
> > > > > > +		if (st->convst_gpio)
> > > > 
> > > > I would flip this an do:
> > > > 	if (!st->convst_gpio)
> > > > 		break;
> > > 
> > > To me this would just add an extra line of code, and more complex flow. I
> > > would definitely agree if there were more operations to be done for the
> > > 'convstart channels' - but since this is really just "if it's convstart,
> > > then set a bit" - the
> > > 
> > > if (foo)
> > > 	bar;
> > > 
> > > seems simpler than
> > > 
> > > if (!foo)
> > > 	break;
> > > bar;
> > 
> > Yes but in this particular case, you likely would not need to do any
> > line break afterward because of indentation. Logically it also makes
> > sense because st->convst_gpio is a device property (not a channel one).
> > So it makes no sense to check it for all channels (I know we only have two
> > channels). So if you prefer, you could even do:
> > 
> > if (st->convst_gpio) {
> > 	for (...)
> > 		__set_bit(...);
> > }
> > 
> > which also would make more sense to me.
> 
> I considered this option, but I need to populate all the channels in
> st->channel with the template data from chip_info->channel anyways. Hence I
> want to loop through the channels also when the st->convst_gpio is not there
> :)

Ahh right! I completely missed that line:

st->channel[i] = chip_info->channel[i];

- Nuno Sá

> 
> > 
> > Up to you now :)
> 
> Well, I already sent the v3. (Sorry, I should've waited a bit more but
> wanted to get it out before the weekend). I kept the same logic as in v2.
> You can still suggest improvements there!
> 
> Yours,
> 	-- Matti

