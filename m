Return-Path: <linux-iio+bounces-14339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9FDA100E5
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 07:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754381886707
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 06:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F6A23D3C2;
	Tue, 14 Jan 2025 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpg81u4Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671E23D3C1;
	Tue, 14 Jan 2025 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736837047; cv=none; b=Xg7To5rutTb8eDQOzcBBQIPyDrjUvD+qByIKnm0gIQ/eUolsAumqgAnA0dMA7vDfXIJNg3LDqTxT65/MzkBYYjGf7WyG1qoNMF+WgPBxsnxb0soqFXGLGVQHaGkJktuvzwXi4Ylg6l9pTCT7m5U6RhIcexSz15QnOqnI3rira88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736837047; c=relaxed/simple;
	bh=luEIYGMffl7GDfhakUCVV7q9lBFDIBjGXPgFuxfeZkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWN01GarojkN1B17OhlmK2oh6eZ/FpZT9DL9SAPNU0mCLxhkRiCrEmA6+FVoY1AkPzSx8+PWpoFfji2iSatCjynvJbTjOjp/wBqKk/dGPgN1E3aoCPtLrZ8obXdxQcFHmpJdPcUGd/KHhWp6Ec1ket0+9pLqLp8H5G7qLGetKo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpg81u4Z; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so8570323a91.3;
        Mon, 13 Jan 2025 22:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736837045; x=1737441845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RQvyYbXWmCge0m1z9dDVhMneiBIcQc8seHD91E8Opg=;
        b=hpg81u4Zp64IX9GJldGqqBNenmGF5t0Jrc5gFEprvHN4D/tl8bVYCXJfvhkwVKV7zy
         FyUFAtustffe/Ds0tjCjDzwpv/PlOQuVpZoTfJ4f3M0cYmK2Zz3K/bXv0XFMnllyzAcc
         Ds661mMRt3mvqML6keXhbkM4kA3Jk/Hw+u7gu/IUqrW+S0JWPaeo5ITO0PaSxJMobzqC
         4p0adBK+KM2U/3JyirN6tA/jpXRxh/X8jm6/bUAavL0Xbc8NRRycKdCfACRAVh2puIg6
         0khmLX4x7JBcconU+Zs5CUlxYKlQhwdkivgYwDkpYJqwRzJJN79UTmlmidyq7GVzoeZ8
         JspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736837045; x=1737441845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RQvyYbXWmCge0m1z9dDVhMneiBIcQc8seHD91E8Opg=;
        b=wdkSaQTaXrWVRZBzJxVSE1e2WQ8yFWb0C/AHQkXYfwE/R3gLjjvg87b0grO+VEne1z
         yqJ1HTmi2hSoEnoU6XAS0t10EPGbRrzvBNGxsG5t7NJfvKvHX8QOM+7c7Gt0LC+7BrQL
         sLLfxjQj7Jum4c2RS0fkYyXdB7dcnnXWns+w72/n2dC+RNOqriyDd0Bl3J6uDZ+EVSiF
         qZMVrTho7+UPNoYz1PQQBYC2v7tfvWeM40UAX+0+/4BeydJ2yO8kPA6NCOfArnmZV8si
         aAUBDfv6nGEi564vJ6xyFNy3/YeZVewU5O7n1W3mgBjt+M1AX61F51SrFFq66/P5GMO/
         iPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf7hMiD00p3L9NbKYlmpDP8jccFlxgXuKlE8YQme39mmtW1HJL3t2r5hAeAZMESntEMMTyu0Jse68=@vger.kernel.org, AJvYcCVAv+ftdTWSiul6imfqqI+SOgvjomSp9oJL0qio73M31Z4CwLFxLYnthFqRE2yV+oi6QRnO+wP6SBn/z0GW@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiFdM5pti54LF36VY60mPqgHa2BMPZNdVwA5pW9DQw6/4tKTP
	oP5DfMTJM05K/9WjopdKnLC1kCULE2bzb4FvH1rJywqBottdCYryFL9DKsrqjieOSz+GRRetOUP
	pP6xpKOz92WvPS3dsx4vaq1GMjQUfIArI
X-Gm-Gg: ASbGncs8VdR0bnQ52k6xOCQocE3P6OLogDpqXPcqHz+xHgDIxG4DJGUCzDnn8GVCIZ5
	QOmDVUzDXcedZTSPEKvd3FLPj0L9okRO1PPSLFi4=
X-Google-Smtp-Source: AGHT+IGWxj8PJOfGKmxYV9MYhEamrofYuweC5iwxPr62AfTa7zxdayRqKfxdHpGMSw9A02u6VcUHMsM8tSfi4qTn+Y8=
X-Received: by 2002:a17:90b:2d44:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-2f548eceda2mr31805543a91.21.1736837044768; Mon, 13 Jan 2025
 22:44:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
 <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com> <129de6d6-50f4-44d7-9a06-db61a6669810@gmail.com>
 <D711DZJWGQX5.2D4PLVQN7NB8Z@gmail.com> <CANhJrGNT9H07MokRbVXRmDprZ+aV0XoDi=LhvrOkeSLzHnqsYw@mail.gmail.com>
 <D71AW9R10XCO.D7ONB8ZU3M56@gmail.com>
In-Reply-To: <D71AW9R10XCO.D7ONB8ZU3M56@gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Tue, 14 Jan 2025 08:43:53 +0200
X-Gm-Features: AbW1kvZZPxLGkRROQbnfEMNpFmLH5JL5lQWWUsyH6zSTe96DFUxCI-pClRjJcck
Message-ID: <CANhJrGOya1tmYcovYJZWkWmVE9NdLFHiDw7izmKtfYTXm57GVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: veml6030: fix scale to conform to ABI
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

ti 14.1.2025 klo 0.32 Javier Carrasco (javier.carrasco.cruz@gmail.com)
kirjoitti:
>
> On Mon Jan 13, 2025 at 8:52 PM CET, Matti Vaittinen wrote:
> > ma 13.1.2025 klo 17.05 Javier Carrasco
> > (javier.carrasco.cruz@gmail.com) kirjoitti:
> > >
> > > On Mon Jan 13, 2025 at 12:56 PM CET, Matti Vaittinen wrote:
> > > > On 07/01/2025 22:50, Javier Carrasco wrote:
> > > > > The current scale is not ABI-compliant as it is just the sensor gain
> > > > > instead of the value that acts as a multiplier to be applied to the raw
> > > > > value (there is no offset).
> > > > >
> > > > > Use the iio-gts helpers to obtain the proper scale values according to
> > > > > the gain and integration time to match the resolution tables from the
> > > > > datasheet and drop dedicated variables to store the current values of
> > > > > the integration time, gain and resolution. When at it, use 'scale'
> > > > > instead of 'gain' consistently for the get/set functions to avoid
> > > > > misunderstandings.
> > > > >
> > > > > Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
> > > > > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > > >
> > > > Thanks for the patch Javier.
> > > >
> > > > And, sorry for a review which is more about questions than suggested
> > > > improvements. I find it hard to focus on reading code today.
> > > >
> > > > > ---
> > > > >   drivers/iio/light/Kconfig    |   1 +
> > > > >   drivers/iio/light/veml6030.c | 499 ++++++++++++++++---------------------------
> > > > >   2 files changed, 189 insertions(+), 311 deletions(-)
> > > > ...
> > > >
> > > > > +
> > > > > +static int veml6030_process_als(struct veml6030_data *data, int raw,
> > > > > +                           int *val, int *val2)
> > > > > +{
> > > > > +   int ret, scale_int, scale_nano;
> > > > > +   u64 tmp;
> > > > > +
> > > > > +   ret = veml6030_get_scale(data, &scale_int, &scale_nano);
> > > > > +   if (ret < 0)
> > > > > +           return ret;
> > > > > +
> > > > > +   tmp = (u64)raw * scale_nano;
> > > > > +   *val = raw * scale_int + div_u64(tmp, NANO);
> > > > > +   *val2 = div_u64(do_div(tmp, NANO), MILLI);
> > > >
> > > > do_div() is horrible on some platforms. Or, at least it used to be. Is
> > > > there really no way to go without it? We're dealing with 16bit data and
> > > > maximum of 512x total gain only, so maybe there was a way(?)
> > > >
> > > > Maybe a stupid question (in which case I blame mucus in my head) - could
> > > > you just divide the raw value by the total gain?
> > > >
> > >
> > > In its current form we need the 64-bit operations to handle the scale,
> > > and it will probably have to stay like that for the reasons I give you
> > > below.
> >
> > Still, I wonder if multiplying by scale really differs from dividing
> > by the total gain? I think the scale is inversely proportional to the
> > total gain, right?
> >
> I am sorry, but I am not sure if I got your point here. The scale is the
> multiplier to get lux from raw, and for example it's not just 1/512 for
> the maximum total gain, as that is not taking the intrinsic resolution
> of the sensor. Maybe I am misunderstanding something, but I don't see the
> way around raw * scale with the scale being one of the discrete values
> provided in the application note.
>
> I will give you a simple example, so you can tell me where my reasoning
> fails:
>
> raw = 100 counts
> scale = 2.1504 lux/count (when IT=25ms and GAIN=1/8)
> processed = 215.04 lux (raw * scale, ABI compliant for IIO_LIGHT)
>
> The reply to your comment below explains why we have a PROCESSED
> IIO_LIGHT in the first place.
>
> > > > >   static irqreturn_t veml6030_event_handler(int irq, void *private)
> > > > > @@ -1084,6 +968,13 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
> > > > >     int ret, val;
> > > > >     struct veml6030_data *data = iio_priv(indio_dev);
> > > > >
> > > > > +   ret = devm_iio_init_iio_gts(dev, 2, 150400000,
> > > >
> > > > Can you please explain the seemingly odd choice for the max scale?
> > > >
> > > > Just a quick look at the sensor spec and this driver allows me to assume
> > > > following:
> > > >
> > > > Maximum 'total gain' from both HWGAIN and integration time is 16 * 32 = 512.
> > > >
> > > > If we chose the 'total gain' 1x to match scale 1, then the smallest
> > > > scale would be 1/512 = 0.001 953 125
> > > >
> > > > This is 1953125 NANOs. This would mean the max-scale 1X => gain 1X would
> > > > not cause precision loss. (Well, I'm not at my sharpest as I've caught
> > > > cold - but I _think_ this is true, right?)
> > > >
> > > > If I read this correctly, the only channel where the scale gets applied
> > > > is the INTENSITY channel, right? Hence it should be possible to chose
> > > > the scale as we see best. (Unless the idea of this seemingly odd scale
> > > > is to maintain the old intensity / scale values in order to not shake
> > > > userland any more - in which case this could be mentioned).
> > > >
> > >
> > > The scale is applied to an IIO_LIGHT channel, not to the INTENSITY,
> >
> > Isn't the IIO_LIGHT channel a PROCESSED one? I thought the scale
> > shouldn't be applied to it. (Driver may still apply scale internally,
> > but users should not see it, right? And if the driver does it only
> > internally, then the driver can also multiply values using (N *
> > scale). Well, I suppose you can as well use this "fitted MAX SCALE" -
> > but maybe it warrants a comment.
>
> IIO_LIGHT provides RAW and PROCESSED values,

Thanks. This explains why you chose the MAX SCALE in IIo init to be
this oddish looking value :)

> which shouldn't have
> happened in the first place as PROCESSED is just raw * scale, if scale
> had been right from the beginning. Actually, when I took over this
> driver, I was tempted to drop the PROCESSED value, but it was too late
> for that without breaking ABI. My guess is that the processed value was
> provided because in_illuminance_scale was not the right multiplier, only
> the gain.
> Note that in_illuminance_scale is also provided to the user, and that
> must comply with the ABI definitions.

Sure. Raw * scale must be lux. You still could use some driver
internal scale multiplier which you
applied before pushing the lux values to users, but this would make
the available scales handling more complicated. Hence, I now fully
agree with you using the
2, 150400000, in devm_iio_init_iio_gts() as max scale. Thank you for
the patience :)

I copied part of your reply below as I think this is the right order
of discussion:

> I will give you a simple example, so you can tell me where my reasoning
> fails:
>
> raw = 100 counts
> scale = 2.1504 lux/count (when IT=25ms and GAIN=1/8)
> processed = 215.04 lux (raw * scale, ABI compliant for IIO_LIGHT)

Your reasoning does not fail. But, the scale = 1 / (N * total_gain),
right? (N here depends on how we choose the scale/gain values) Here,
the total_gain means the effect of both the hardware_gain and the
integration time.

Hence,
processed =  X * (raw * scale)

=> processed = X * (raw * (1 / (N * total_gain))
=> processed = X * raw / (N * total_gain);

Hence I thought you might be able to get rid of this 64bit division by
using the total_gain from the iio_gts_get_total_gain() instead of
using the scale. Or, am I missing something?

Yours,
  -- Matti

-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));

