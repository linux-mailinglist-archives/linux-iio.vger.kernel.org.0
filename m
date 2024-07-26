Return-Path: <linux-iio+bounces-7939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F8F93D458
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 15:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DC21C2445F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7EC17DE03;
	Fri, 26 Jul 2024 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1NaWQUC+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D517D358
	for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001111; cv=none; b=sz8MCegShjCeb+6nVwrag0IabB/ZGKpgvIXQy4A98lVZr5Xu/QetxOm2VohyTihqsrqkDns5aCOrBsLxANYI2YRzOf1br6HBoJwyYhL4qy8Dc7os9Y9uda9pNr82m6NAwyciuIJV9Ul7eLUdzrrmfLCHMhjRFGR8PnMhmNcAcmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001111; c=relaxed/simple;
	bh=1Zkeq+FwqQEawcogj4oIwsbpb8D1Iv72qVcSnJf5tMA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=bnJ66cl1Df4k/ijA2jj4itEhm5bWGagm0pz99neRBavvCBYkEIEgioZa7uN98NeMfIb0sVm9DAWm3q8b82LRvDJ2hYqqG8lb2w9YMdHIMY6CMcdwhDqf2F3Q3/ucWzhiQwmIhVoJ+ZuA9fdsmq8i4IiDG2tW3+lBthx+j/xdtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1NaWQUC+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso15440155e9.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722001106; x=1722605906; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GigEj7Lw695sg9deooVuaRWVw5+qGFsdSGqMpUPvSFE=;
        b=1NaWQUC+lYWv5rEPn5Ato0AIUIK7uiKQjUha6BCl0yPfiL3JIfVzLd9Kheg8s/2jT5
         hzp3RQOmJjjcbwsLpaMGpzxPGh+bMmsmlUoj5nq7uF5E6Z4GlQOvvtpfUThbD9DZ/CYM
         yr9ZaPyrG3goy2GXv9/6dXIFCZFG3RovPI3EalyNFsGSUNIbXFGy1dmicmiAFDSCq7gj
         e7Bt7oiH3FZq1IYNrw5azadPGTseEEYEU4V4x/Y0Pv4v/4Ujc45DAW7m6EGdi3hXpqGT
         YddW1zeVx0KZyYtCcSIwOUp2cEoWtyIDbrChZluyO+o8J+FtQQEeYmbxLLwksVKTwrLN
         Q0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722001106; x=1722605906;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GigEj7Lw695sg9deooVuaRWVw5+qGFsdSGqMpUPvSFE=;
        b=vG5MHzuVE5bfnUQJX1VJ34RdYvhfWAoOFP7Id47UqwnWl9vyN6csVA+n56P3nw++np
         H8cl88ON8ev/+oLFwEFLpLxTRd+q2kY+GHp7jBbZUDTAq+T/o1yAS8BtyLS8vDYmjveX
         EpOJ4A6M5WiRN6SgIrIFPKlRjBHxrWTSz6mQjPj8mMekUHV/WMbenJ3B7D1ut6htd4i9
         K1GezUU0lk7e1/XeQhQ7WRnyODrdAoyuJdS3/pjIA0wBhEUWiMYCkEyViiYhsbmcQJY9
         pad98cXNNlijVh8hRyBajYId+WH7nOVZTW03rIh54MhWbsrb8wnYNRIhkBfK/ndrUsPM
         534w==
X-Gm-Message-State: AOJu0Yz9Of7Vby4BJCJ6h95IGj2fME2xNxqQ2CtouYcmI342hB7HeKGO
	huCqwgrcBe/cK5D2+oE3TKEVmaNy54cPlHyZE+S9sqDr+Pd6CucyWV7MIPGko1s=
X-Google-Smtp-Source: AGHT+IGDZyhVw3kXH9RHTJAk2rcXnF8LgZzeybbdjh6TQjgDoePuX2hy6ELD0soTgQTGWbm60VfOjA==
X-Received: by 2002:a05:600c:548b:b0:426:5f75:1c2c with SMTP id 5b1f17b1804b1-42806b83e4amr35706195e9.11.1722001106301;
        Fri, 26 Jul 2024 06:38:26 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f940e62dsm123524595e9.39.2024.07.26.06.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 06:38:25 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jul 2024 15:38:24 +0200
Message-Id: <D2ZIG2NK223D.J9VK1MWOICE3@baylibre.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
From: "Esteban Blanc" <eblanc@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 <baylibre-upstreaming@groups.io>, "Lars-Peter Clausen" <lars@metafoo.de>,
 "Michael Hennerich" <Michael.Hennerich@analog.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Nuno Sa"
 <nuno.sa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.17.0
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
 <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
 <0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>
In-Reply-To: <0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>

Hi Nuno,

> > +			struct {
> > +				s32 val[AD4030_MAX_DIFF_CHANNEL_NB];
> > +				u8 common[AD4030_MAX_COMMON_CHANNEL_NB];
>
> Not sure common makes sense as it comes aggregated with the sample. Maybe=
 this
> could as simple as:
>
> struct {
> 	s32 val;
> 	u64 timestamp __aligned(8);
> } rx_data ...

See below my answer on channels order and storagebits.

> So, from the datasheet, figure 39 we have something like a multiplexer wh=
ere we
> can have:
>
> - averaged data;
> - normal differential;
> - test pattern (btw, useful to have it in debugfs - but can come later);
> - 8 common mode bits;
>
> While the average, normal and test pattern are really mutual exclusive, t=
he
> common mode voltage is different in the way that it's appended to differe=
ntial
> sample. Making it kind of an aggregated thingy. Thus I guess it can make =
sense
> for us to see them as different channels from a SW perspective (even more=
 since
> gain and offset only apply to the differential data). But there are a cou=
ple of
> things I don't like (have concerns):
>
> * You're pushing the CM channels into the end. So when we a 2 channel dev=
ice
> we'll have:
>
>  in_voltage0 - diff
>  in_voltage1 - diff
>  in_voltage2 - CM associated with chan0
>  in_voltage0 - CM associated with chan1
>
> I think we could make it so the CM channel comes right after the channel =
where
> it's data belongs too. So for example, odd channels would be CM channels =
(and
> labels could also make sense).

I must agree with you it would make more sense.

> Other thing that came to mind is if we could somehow use differential =3D=
 true
> here. Having something like:
>
> in_voltage1_in_voltage0_raw - diff data
> ...
> And the only thing for CM would be:
>
> in_voltage1_raw
> in_voltage1_scale
>
> (not sure if the above is doable with ext_info - maybe only with device_a=
ttrs)
>
> The downside of the above is that we don't have a way to separate the sca=
n
> elements. Meaning that we don't have a way to specify the scan_type for b=
oth the
> common mode and differential voltage. That said, I wonder if it is that u=
seful
> to buffer the common mode stuff? Alternatively, we could just have the sc=
an_type
> for the diff data and apps really wanting the CM voltage could still acce=
ss the
> raw data. Not pretty, I know...

At the moment the way I "separate" them is by looking at the
`active_scan_mask`. If the user asked for differential channel only, I put =
the
chip in differential only mode. If all the channels are asked, I put
the chip in differential + common mode. This way there is no need to
separate anything in differential mode. See below for an example where
this started.

> However, even if we go with the two separate channels there's one thing t=
hat
> concerns me. Right now we have diff data with 32 for storage bits and CM =
data
> with 8 storage bits which means the sample will be 40 bits and in reality=
 we
> just have 32. Sure, now we have SW buffering so we can make it work but t=
he
> ultimate goal is to support HW buffering where we won't be able to touch =
the
> sample and thus we can't lie about the sample size. Could you run any tes=
t with
> this approach on a HW buffer setup?=20

Let's take AD4630-24 in diff+cm mode as an example. We would have 4 channel=
s:
- Ch0 diff with 24 bits of realbits and 24 bits of storagebits
- Ch0 cm with 8 bits of realbits and 8 bits of storagebits
- Ch1 diff with 24 bits of realbits and 24 bits of storagebits
- Ch1 cm with 8 bits of realbits and 8 bits of storagebits
ChX diff realbits + ChX cm realbits =3D 32 bits which is one sample as sent
by the chip.

The problem I faced when trying to do this in this series is that IIO doesn=
't
seem to like 24 storagebits and the data would get garbled. In diff only
mode with the same channel setup (selecting only Ch0 diff and Ch1 diff)
the data is also garbled. I used iio-oscilloscope software to test this set=
up.
Here is the output with iio_readdev:
```
# iio_readdev -s 1 ad4630-24 voltage0
WARNING: High-speed mode not enabled
Unable to refill buffer: Invalid argument (22)
```

I think this is happening when computing the padding to align ch1 diff.
In `iio_compute_scan_bytes` this line `bytes =3D ALIGN(bytes, length);`
will be invoked with bytes =3D 3 and length =3D 3 when selecting ch0 diff
and ch1 diff (AD4630-24 in differential mode). The output is 5. As
specified in linux/align.h:
> @a is a power of 2
In our case `a` is `length`, and 3 is not a power of 2.

It works fine with Ch0/1 diff with 24 realbits and 32 storagebits with 8
bits shift.

Intrestingly, a similar setup works great on AD4630-16:
- Ch0 diff with 16 bits of realbits and 16 bits of storagebits
- Ch0 cm with 8 bits of realbits and 8 bits of storagebits
- Ch1 diff with 16 bits of realbits and 16 bits of storagebits
- Ch1 cm with 8 bits of realbits and 8 bits of storagebits

In `iio_compute_scan_bytes` we will have ALIGN(3, 2) which will output
4, everything is fine. The output of iio-oscilloscope is as expected,
a clean sinewave and iio_readdev does not throw an error.

All this to say that at the moment, I'm not sure how I will be able to
put the CM byte in a separate channel for AD4630-24 without buffering it.
It would be useful to return a "packed" buffer.

> > +static int ad4030_conversion(struct ad4030_state *st, const struct
> > iio_chan_spec *chan)
> > +{
> > +	unsigned int bytes_to_read =3D (BITS_TO_BYTES(chan->scan_type.realbit=
s)
> > +
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 ((st->mode =3D=3D AD4030_OUT_DATA_MD_24_DI=
FF_8_COM
> > ||
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 st->mode =3D=3D AD4030_OUT_DATA_MD_16_DIFF=
_8_COM) ?
> > 1 : 0)) *
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 st->chip->num_channels;
> > +	struct spi_transfer xfer =3D {
> > +		.rx_buf =3D st->rx_data.raw,
> > +		.len =3D bytes_to_read,
> > +	};
> > +	unsigned char byte_index;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> > +	ndelay(AD4030_TCNVH_NS);
> > +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> > +	ndelay(AD4030_TCNVL_NS + AD4030_TCONV_NS);
> > +
> > +	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> > +	if (ret || (st->mode !=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> > +		=C2=A0=C2=A0=C2=A0 st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM))
>
> You should guarantee that st->mode is not invalid...

I don't see a code path where this could be the case. It's initialized
at 0 in the probe (a valid value) and always set before `ad4030_conversion`
in `ad4030_set_mode` called by `ad4030_buffer_preenable`. If the value
is invalid, this is a driver error, not an invalid input from the user.
Should I put an assert then?

> > +		return ret;
> > +
> > +	byte_index =3D st->chip->precision_bits =3D=3D 16 ? 3 : 4;
> > +	for (i =3D 0; i < st->chip->num_channels; i++)
>
> So even for a single channel conversion we are going through all?

Yes. For ad4030-24 (this patch), that ok since num_channels =3D 1.
For AD4630, we are getting the 2 channels samples anyway. Current
allowed `scan_mask` are ch0 and ch1 (diff mode) or ch0 to ch3 (diff +
common mode). The only case I could optimized currently is if I allowed
scan_mask such as: ch0 & ch2, ch0 & ch1 & ch2, ch0 & ch1 & ch3. I'm not
sure it makes sense to allow such `scan_mask` since the HW does not
support it.
What do you think?

> > +static int ad4030_read_raw(struct iio_dev *indio_dev,
> > +			=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> > +			=C2=A0=C2=A0 int *val2, long info)
> > +{
> > +	struct ad4030_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>
> Oh this is not neat :(. I guess there's still no work to make conditional=
 guards
> to look more as the typical pattern...

Yeah... At first I put checks inside each function. Then I put guards
inside each function. But at the end, almost every arm of the switch
case needs to be in direct mode so... I can put it back in the function,
as you wish.

> > +		switch (info) {
> > +		case IIO_CHAN_INFO_RAW:
> > +			return ad4030_single_conversion(indio_dev, chan,
> > val);
> > +
> > +		case IIO_CHAN_INFO_SCALE:
> > +			*val =3D (st->vref_uv * 2) / MILLI;
> > +			*val2 =3D st->chip->precision_bits;
> > +			return IIO_VAL_FRACTIONAL_LOG2;
>
> I don't think this applies to CM?

Indded. Scale is not available for the CM channels.

> > +static int ad4030_detect_chip_info(const struct ad4030_state *st)
> > +{
> > +	unsigned int grade;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(st->regmap, AD4030_REG_CHIP_GRADE, &grade);
> > +	if (ret)
> > +		return ret;
> > +
> > +	grade =3D FIELD_GET(AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE, grade);
> > +	if (grade !=3D st->chip->grade)
> > +		return dev_err_probe(&st->spi->dev, -EINVAL,
> > +				"Unknown grade(%u) for %s\n", grade,
> > +				st->chip->name);
>
> I think in here we still want to proceed and just print a warning...

I've put this in because it's a quick and easy way to check:
- If the SPI communication is working,
- If the correct chip is installed. If it's not the correct one, we can
  be sure that the parameters used to get any data out the chip will be
  wrong and the data completely useless.

If you feel that there is a use case I missed I will put a warning
instead, no problem.


All the comments I skipped and not replied to will be fixed in a V2.

Best regards,

--=20
Esteban "Skallwar" Blanc
BayLibre

