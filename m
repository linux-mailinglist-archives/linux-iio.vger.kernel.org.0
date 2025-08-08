Return-Path: <linux-iio+bounces-22442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A2B1E52B
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 11:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12A43BC7D2
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7959026B2AD;
	Fri,  8 Aug 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0kkV5N7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818825EF90;
	Fri,  8 Aug 2025 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643627; cv=none; b=Dj+3jW72mOEnpEbaMIW3NFeLINOnJK9Kptz9DFkF1+x4+zPTgk167KzGz01ademJVp83Kynw2NeMRmHL0XmG2tWudVSH6/G5VQyPPfKbPwb0kdHs4cpoSh+SLAgkTQYWuMaosq40HH3AJhiX22S0BJmAXmZhOzacCnXJEcyUA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643627; c=relaxed/simple;
	bh=GL2ZrboJ9iHfDfAE0NcP4l10BIigsRXNQYX1hN5Y720=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8WKMlfbRgTRLVF2NDsPN4SNK/XgHkNG1comVMdbZm/xVcLRBus5DnWK/KdQ6hy3YZDfuo52pAWn9L3IUYnWkr7RZPtRk+NO9m88NR3Z1q736EAwkkeYNKn7F1KOMPgjTTYSA9UFXOsdYAOgZXkHMvA9A+Sfm334Nnov9+GqJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0kkV5N7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af937728c3eso492434566b.0;
        Fri, 08 Aug 2025 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643623; x=1755248423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k8rdjH+Db+Fz5b710nahZQZSQrrrT57SDbAIyGOmM94=;
        b=d0kkV5N7S9ndL7IgUoL68X1EW4S7leq0xKbH2PVLwJnHowHiV7YMR6+V/zNRaTqg4t
         5p1N9qCnLqcI3gsJdn2ysZGunOQcquDANRTE+yisPHu2xG4KdvHZrS0kF7vqyeNyYPb1
         qa2zrIjgli1SK5QpVZK3f0uOyj50QF2wwYnWexrdqs5Wcjt5RIS5Mho2YPkJJvXCbTju
         WDB5ix3pVGvElkBrf4bh4+1GjqwPUrCcNyTe39GIdUCnA6uXxRtZ1ojJn3l9BHnZlzjP
         lHuEJSHW0Bu/5NF+2UNEyMQcWsjZQWz+nJHsJzwQrvsf55JzDkZRF9GbSf0pjzyDTvLg
         R6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643623; x=1755248423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8rdjH+Db+Fz5b710nahZQZSQrrrT57SDbAIyGOmM94=;
        b=HvIP1QBe7FGmbuaA0t9+g8OUZP4M6AvUTNF4ms2IBPVZkPHWZCKjinnoaRm6u5xkkH
         glyoGg2xHPxD8wgZqpiRRniQav5TlGJIzTlxbPTBQm/oN9wX7ZMA3ilouhOlCdMXZbb/
         BTpzcG4ole6nMyy5ZCr/u4InuCjZwaQ1Kqc4m0yX1vBfBBOMudx8Nj3xeCJpdUetGRtO
         DqccDGut8Z/UixsnW1T2a0A43QQyk3QH77qowrGQbUraNthprHnTD/Lx9NzyJNiHCL+r
         PqDXByT8EvuEzPPUh+ey/tN7xUIJcBQ/xzVqZH7JYN5qCygDePHl3+8E9TupX9iuhA6F
         C69w==
X-Forwarded-Encrypted: i=1; AJvYcCUE56uR80nvxXxigsCDhS6tZC5ZjRoSaLbzGhs73Nj6/lrjdKikG+iYVLjC589iZE+UG46Q3Mns9xeK@vger.kernel.org, AJvYcCVjHHW2xmeSbz/0Ca4npDuCq4OBgDwh2JMUm9/6oPrZqi78rcLuMsebMJcM7xspTxxavt1dZXh9zRio@vger.kernel.org, AJvYcCW5IHx+M6+qv8AgJ84Y/+kZ5hRWGOJzKVqO7Vx1qwI8K1J0XpKD01Xkbv7jbwlldDJfnN3SVuHL1hl0wrrQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3QfWhaUUE5sIdZcIsbQOgFJkRlWIdzSOenA/cxKqQ5X5PBAW
	/7ugeUFgwxKYctsMSCFXiXJiB8EAazdKxZWPCqnbiJhOuAj0PUMepJlD
X-Gm-Gg: ASbGnctWF/iMpGIOeGbvsecVtTQHU9cA5o/UbAVuctIxQqlf3ASEtl9wqIewxsUYI7L
	aWqb9j4J0IWczK+aBjsu9h7eKjNEA5FgOVIOlVdrRP/aRJPQ/FBSc2XOWwGSqvKUS6irI2+xeqF
	jwAsrfPN7uNTuZVBTY2x/dIXGahZIqnzKwM2vBRSVUYKWB1G8StxKz6JKZE129hTkQVsOSla5Td
	BlvK8Rl4ocM/U9hn4QbYRFxFA+Zd4FjkOCAVUojAAE4vqjykcanNWRV1t0ZGRIDHcu4BlrzDzzO
	6gu/aPpkoElbe0N4r2Jqfw6H3CbtBqbcVJJ4VoFrmwPLNx5bIbdkRrWfPXgTGO6EthoU58RCSg5
	hBaM6360+iHUMq7k3C1Js
X-Google-Smtp-Source: AGHT+IHecywVS5Ip+72T+mjbLiYvwjd3kAV0wAjDP6j9FnxibAvP4+TjMFuGgQyhV1yEeCxPZmNa9w==
X-Received: by 2002:a17:907:948d:b0:af9:21ed:6ebe with SMTP id a640c23a62f3a-af9c700b437mr176174566b.21.1754643623233;
        Fri, 08 Aug 2025 02:00:23 -0700 (PDT)
Received: from nsa ([185.128.9.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078afbsm1455962766b.4.2025.08.08.02.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:00:22 -0700 (PDT)
Date: Fri, 8 Aug 2025 10:00:39 +0100
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
Message-ID: <t54tty4xbcsozeouoqmytdw6saedgoxbemnr2azbiv2f4h2wta@rf4fnooawrgs>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
 <tc4od3jtqnj743naxefx5lxkha46wohuuvw46mik6nullvsqbe@knj4t23eaodw>
 <ngcbj6p7vfakah5fqsxqjlmrcycpg5rxfrbh4s34fll2kb3zq2@eyesluawn5w2>
 <076b7f07-e755-4fe7-84b1-f3f495978008@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <076b7f07-e755-4fe7-84b1-f3f495978008@gmail.com>

On Fri, Aug 08, 2025 at 08:37:07AM +0300, Matti Vaittinen wrote:
> On 07/08/2025 16:10, Nuno Sá wrote:
> > On Thu, Aug 07, 2025 at 01:41:31PM +0100, Nuno Sá wrote:
> > > On Thu, Aug 07, 2025 at 12:34:52PM +0300, Matti Vaittinen wrote:
> > > > The ad7476 driver defines separate chan_spec structures for operation
> > > > with and without convstart GPIO. At quick glance this may seem as if the
> > > > driver did provide more than 1 data-channel to users - one for the
> > > > regular data, other for the data obtained with the convstart GPIO.
> > > > 
> > > > The only difference between the 'convstart' and 'non convstart'
> > > > -channels is presence / absence of the BIT(IIO_CHAN_INFO_RAW) in
> > > > channel's flags.
> > > > 
> > > > We can drop the convstart channel spec, and related convstart macro, by
> > > > allocating a mutable per driver instance channel spec an adding the flag
> > > > in probe if needed. This will simplify the driver with the cost of added
> > > > memory consumption.
> > > > 
> > > > Assuming there aren't systems with very many ADCs and very few
> > > > resources, this tradeoff seems worth making.
> > > > 
> > > > Simplify the driver by dropping the 'convstart' channel spec and
> > > > allocating the chan spec for each driver instance.
> > > 
> > > I do not agree with this one. Looking at the diff, code does not look
> > > simpler to me...
> > 
> > Ok, on a second thought I'm ok with this. It makes adding devices easier
> > and (IIUC) for the one you're adding later we only have "convst_channel"
> > channels.
> 
> Yes, that's right. The BD79105 requires the convstart.
> 
> > On comment though...
> > 
> > > 
> > > - Nuno Sá
> > > 
> > > > 
> > > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > > 
> > > > ---
> > > > Revision history:
> > > >   v1 => v2:
> > > >   - New patch
> > > > 
> > > > I considered squashing this change with the one limiting the chip_info
> > > > scope. Having this as a separate change should help reverting if someone
> > > > complains about the increased memory consumption though.
> > > > ---
> > > >   drivers/iio/adc/ad7476.c | 31 ++++++++++++++++++-------------
> > > >   1 file changed, 18 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > > > index e97742912b8e..a30eb016c11c 100644
> > > > --- a/drivers/iio/adc/ad7476.c
> > > > +++ b/drivers/iio/adc/ad7476.c
> > > > @@ -29,8 +29,6 @@ struct ad7476_state;
> > > >   struct ad7476_chip_info {
> > > >   	unsigned int			int_vref_mv;
> > > >   	struct iio_chan_spec		channel[2];
> > > > -	/* channels used when convst gpio is defined */
> > > > -	struct iio_chan_spec		convst_channel[2];
> > > >   	void (*reset)(struct ad7476_state *);
> > > >   	bool				has_vref;
> > > >   	bool				has_vdrive;
> > > > @@ -41,6 +39,7 @@ struct ad7476_state {
> > > >   	struct gpio_desc		*convst_gpio;
> > > >   	struct spi_transfer		xfer;
> > > >   	struct spi_message		msg;
> > > > +	struct iio_chan_spec		channel[2];
> > > >   	int				scale_mv;
> > > >   	/*
> > > >   	 * DMA (thus cache coherency maintenance) may require the
> > > > @@ -153,24 +152,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
> > > >   #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
> > > >   		BIT(IIO_CHAN_INFO_RAW))
> > > >   #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> > > > -#define AD7091R_CONVST_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), \
> > > > -		BIT(IIO_CHAN_INFO_RAW))
> > > >   #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
> > > >   		BIT(IIO_CHAN_INFO_RAW))
> > > >   static const struct ad7476_chip_info ad7091_chip_info = {
> > > >   	.channel[0] = AD7091R_CHAN(12),
> > > >   	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
> > > > -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > >   	.reset = ad7091_reset,
> > > >   };
> > > >   static const struct ad7476_chip_info ad7091r_chip_info = {
> > > >   	.channel[0] = AD7091R_CHAN(12),
> > > >   	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > > -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
> > > > -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> > > >   	.int_vref_mv = 2500,
> > > >   	.has_vref = true,
> > > >   	.reset = ad7091_reset,
> > > > @@ -282,7 +275,7 @@ static int ad7476_probe(struct spi_device *spi)
> > > >   	const struct ad7476_chip_info *chip_info;
> > > >   	struct ad7476_state *st;
> > > >   	struct iio_dev *indio_dev;
> > > > -	int ret;
> > > > +	int ret, i;
> > > >   	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > > >   	if (!indio_dev)
> > > > @@ -332,16 +325,28 @@ static int ad7476_probe(struct spi_device *spi)
> > > >   	if (IS_ERR(st->convst_gpio))
> > > >   		return PTR_ERR(st->convst_gpio);
> > > > +	/*
> > > > +	 * This will never realize. Unless someone changes the channel specs
> > > > +	 * in this driver. And if someone does, without changing the loop
> > > > +	 * below, then we'd better immediately produce a big fat error, before
> > > > +	 * the change proceeds from that developer's table.
> > > > +	 */
> > > > +	BUILD_BUG_ON(ARRAY_SIZE(st->channel) != ARRAY_SIZE(chip_info->channel));
> > 
> > I guess it make sense but still looks too fancy for this :)
> 
> Nothing else but a developer's carefulness keeps the number of channels "in
> sync" for these two structs. I was originally doing WARN_ON() - but then I
> thought that it's be even better to catch this at build time. Then I found
> the BUILD_BUG_ON(). I see Andy suggested static_assert() instead - I've no
> idea why one is preferred over other though. Let's see if I get educated by
> Andy :)
> 
> > 
> > > > +	for (i = 0; i < ARRAY_SIZE(st->channel); i++) {
> > > > +		st->channel[i] = chip_info->channel[i];
> > > > +		if (st->convst_gpio)
> > 
> > I would flip this an do:
> > 	if (!st->convst_gpio)
> > 		break;
> 
> To me this would just add an extra line of code, and more complex flow. I
> would definitely agree if there were more operations to be done for the
> 'convstart channels' - but since this is really just "if it's convstart,
> then set a bit" - the
> 
> if (foo)
> 	bar;
> 
> seems simpler than
> 
> if (!foo)
> 	break;
> bar;

Yes but in this particular case, you likely would not need to do any
line break afterward because of indentation. Logically it also makes
sense because st->convst_gpio is a device property (not a channel one).
So it makes no sense to check it for all channels (I know we only have two
channels). So if you prefer, you could even do:

if (st->convst_gpio) {
	for (...)
		__set_bit(...);
}

which also would make more sense to me.

Up to you now :)

- Nuno Sá

> 
> > 		
> > > > +			st->channel[i].info_mask_separate |=
> > > > +				BIT(IIO_CHAN_INFO_RAW);
> > 		
> > 		__set_bit()...
> 
> Ok. Thanks.
> 
> 
> Thanks for the review(s) Nuno!
> 
> Yours,
> 	-- Matti

