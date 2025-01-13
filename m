Return-Path: <linux-iio+bounces-14331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A7A0C4CF
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 23:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A347A496B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602341E04B5;
	Mon, 13 Jan 2025 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDjo4t1Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595019AD89;
	Mon, 13 Jan 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807566; cv=none; b=m/3YyBtog1OT/x3n++5YQt73Ytgn42CBl3FtHao1KAuCEoYhk2LqNDrY4F238DxALyfpnqg+iaS7SZ/wtm4VG3Qo1zNGJ3E3o3r/AUYN7XtYZEnOmhveaQLxXamHmh3Q0hipg/p+sYwoXqH/QmHjMaM/PuUBTfy3KLeWcPjb0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807566; c=relaxed/simple;
	bh=Hb8+ZRcPMdgZ8JVzf096crixRii9kG0dLaDzNU+A38A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=P9AT3VJOdaOEwQFipsBwfdY81UM1qzPyp+pdbMiHkKuH4UWH7AdiwCRdzbWcW7dkkGYjcQq8bgsg++uMXHxGlbYUIGSrhe8Bod0A7aQZZ9gC6N7ClmOvgKBrGTXQu0aUSTU9voKiotT1kcPz49c2H0n7GNesi6G8kS7/hIjpP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDjo4t1Z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso4966689f8f.2;
        Mon, 13 Jan 2025 14:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736807563; x=1737412363; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kC5ZLO2wqe4rCC8a1YRUukDPf2FKx/o1plQCwueR24c=;
        b=MDjo4t1ZguaRX2WWsSpG3GfF07fSDJbEI2Vn12/vRZ87FDYYtvlPzXLUqi9KrT5/co
         uPbnVttFUmiYXPV6HWpesGFw176emEk7IN3sQ5u/ZUeSlByXHaLFqVqDHSEjv1UQIpFu
         WimjU/sqsKYqibARf7O9lEsvy5z9bSCXNt4EdhQzbtYpo1GXIAUUZQ5K8N7gi3+bfJID
         onG28pFltBdu9j3/9sOBPoTdIQGOMn7P8aYkR4RKB6d4SyAaAVMq4t+AZ4ah8h2fAclM
         1CPe/QU8Zty9onjhtI2HUokQ+dwHDMrrDTFj94YlR14kndBjECZNRH6/xujAvGiMPp35
         iX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736807563; x=1737412363;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kC5ZLO2wqe4rCC8a1YRUukDPf2FKx/o1plQCwueR24c=;
        b=dzjE0pjtngM1DsjCSNJsHC2qv7Lr84U0NojRegzEF0X1gc6gUcNy3OTw3ZgalOxzbK
         cZGA0Iri//Ohw7qsWKeYolEA4hGGNYoYTSEiM9OFq7O5YLDRf8galKPRXl3KBlrSnXV3
         dYcBTib+Q5hc1UpFeQKO3FCD5uHCiYYvTjBaW9/7N8xuLBPmCPTxPvdJHXrFF9svowbv
         K+3qYBFOwtixaIaCEstpL9bMq33+IpgbDQMks68xrgH90OuQKeFHGJKu3m+EgO+5FVrO
         bpGc8yB+wYN5V81XdSxDR7a+XOonIoc6L1SZX0cB7dWmvhovSFyF6iIo2uo9EiT6fvOR
         dK1w==
X-Forwarded-Encrypted: i=1; AJvYcCViHRFYVbtkw42BUr0QbMjGRp7nbVX86hfj12K9EogTojHCVVcYs4FcQWhX5Rtf3rMrt84yvcJiToY0HUbB@vger.kernel.org, AJvYcCWa2eNyBueTM+LhcgN69x4NR52xjkHnRJDha3rp+j9r6Z81K//UJty2JyDtlkyOgGkfwJpftuQVn0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5pCba+LYc6ONhQ5xC/+xef7OW2yEBH0sRxu+ldrIWW4BddPNT
	4kLmAcmg4jrRZzdYClkWeosl1T2uwiEOg8FEiF+3I7M93/ghGRgQ
X-Gm-Gg: ASbGnctP34KFfGABcAQeB7WbGvGBsKnbUXVpow1C6U5Yz1owTbTtp1N3OfXL9dKrKkE
	epbPubkX9YByqn9QYHxm1E1eVIpZmvPPAN4pBdAT1+f/Ssyyh18epXIZ8SOar73BCRuR6fLsQoD
	iUyM0fCj/PAy8M8iEvbFLhM6tnFDe53PmeekgrD0AzD1SvLvq4jGXXd07FOGsoSnp1CUHMDQysV
	S3Kg/6FVSbRvf2v9JnKocPM6gk4tZ3rG0301Sd797ug77/HZKVLp8UJG5OJuYEUB3SGZgR1bJdR
	CRUIoWnqlK9ThSk0zMZCtRGHQTF7tUBBEloMPiqchH245ou6hO44fW7xxV3jnZpL7oHcEe9A6jU
	J
X-Google-Smtp-Source: AGHT+IE6mvedaS+IVZCH4a08F4mKIEYjt3slaJPEOuifdL9mgUv1/1jK05KNX3G0I1AvQ97kaSVfXA==
X-Received: by 2002:a5d:5986:0:b0:386:605:77e with SMTP id ffacd0b85a97d-38a873572a5mr20314990f8f.49.1736807562392;
        Mon, 13 Jan 2025 14:32:42 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-990d-46e6-a7a0-1b88.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:990d:46e6:a7a0:1b88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1f2esm13263423f8f.98.2025.01.13.14.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 14:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jan 2025 23:32:38 +0100
Message-Id: <D71AW9R10XCO.D7ONB8ZU3M56@gmail.com>
Subject: Re: [PATCH 2/2] iio: light: veml6030: fix scale to conform to ABI
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rishi Gupta" <gupt21@gmail.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
To: "Matti Vaittinen" <mazziesaccount@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
 <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>
 <129de6d6-50f4-44d7-9a06-db61a6669810@gmail.com>
 <D711DZJWGQX5.2D4PLVQN7NB8Z@gmail.com>
 <CANhJrGNT9H07MokRbVXRmDprZ+aV0XoDi=LhvrOkeSLzHnqsYw@mail.gmail.com>
In-Reply-To: <CANhJrGNT9H07MokRbVXRmDprZ+aV0XoDi=LhvrOkeSLzHnqsYw@mail.gmail.com>

On Mon Jan 13, 2025 at 8:52 PM CET, Matti Vaittinen wrote:
> ma 13.1.2025 klo 17.05 Javier Carrasco
> (javier.carrasco.cruz@gmail.com) kirjoitti:
> >
> > On Mon Jan 13, 2025 at 12:56 PM CET, Matti Vaittinen wrote:
> > > On 07/01/2025 22:50, Javier Carrasco wrote:
> > > > The current scale is not ABI-compliant as it is just the sensor gai=
n
> > > > instead of the value that acts as a multiplier to be applied to the=
 raw
> > > > value (there is no offset).
> > > >
> > > > Use the iio-gts helpers to obtain the proper scale values according=
 to
> > > > the gain and integration time to match the resolution tables from t=
he
> > > > datasheet and drop dedicated variables to store the current values =
of
> > > > the integration time, gain and resolution. When at it, use 'scale'
> > > > instead of 'gain' consistently for the get/set functions to avoid
> > > > misunderstandings.
> > > >
> > > > Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient l=
ight sensor")
> > > > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > >
> > > Thanks for the patch Javier.
> > >
> > > And, sorry for a review which is more about questions than suggested
> > > improvements. I find it hard to focus on reading code today.
> > >
> > > > ---
> > > >   drivers/iio/light/Kconfig    |   1 +
> > > >   drivers/iio/light/veml6030.c | 499 ++++++++++++++++--------------=
-------------
> > > >   2 files changed, 189 insertions(+), 311 deletions(-)
> > > >
> > >
> > > I like the diffstats of this Fix! :) It's nice you found gts-helpers
> > > helpful :)
> >
> > I wonder how painful the int. time/gain/scale issue in ALS was before
> > iio-gts existed :D
> >
> I don't really know. I wrote the gts-helpers as soon as I wrote my
> first light sensor driver :)
>
> > > ...
> > >
> > > > +
> > > > +static int veml6030_process_als(struct veml6030_data *data, int ra=
w,
> > > > +                           int *val, int *val2)
> > > > +{
> > > > +   int ret, scale_int, scale_nano;
> > > > +   u64 tmp;
> > > > +
> > > > +   ret =3D veml6030_get_scale(data, &scale_int, &scale_nano);
> > > > +   if (ret < 0)
> > > > +           return ret;
> > > > +
> > > > +   tmp =3D (u64)raw * scale_nano;
> > > > +   *val =3D raw * scale_int + div_u64(tmp, NANO);
> > > > +   *val2 =3D div_u64(do_div(tmp, NANO), MILLI);
> > >
> > > do_div() is horrible on some platforms. Or, at least it used to be. I=
s
> > > there really no way to go without it? We're dealing with 16bit data a=
nd
> > > maximum of 512x total gain only, so maybe there was a way(?)
> > >
> > > Maybe a stupid question (in which case I blame mucus in my head) - co=
uld
> > > you just divide the raw value by the total gain?
> > >
> >
> > In its current form we need the 64-bit operations to handle the scale,
> > and it will probably have to stay like that for the reasons I give you
> > below.
>
> Still, I wonder if multiplying by scale really differs from dividing
> by the total gain? I think the scale is inversely proportional to the
> total gain, right?
>

I am sorry, but I am not sure if I got your point here. The scale is the
multiplier to get lux from raw, and for example it's not just 1/512 for
the maximum total gain, as that is not taking the intrinsic resolution
of the sensor. Maybe I am misunderstanding something, but I don't see the
way around raw * scale with the scale being one of the discrete values
provided in the application note.

I will give you a simple example, so you can tell me where my reasoning
fails:

raw =3D 100 counts
scale =3D 2.1504 lux/count (when IT=3D25ms and GAIN=3D1/8)
processed =3D 215.04 lux (raw * scale, ABI compliant for IIO_LIGHT)

The reply to your comment below explains why we have a PROCESSED
IIO_LIGHT in the first place.

> > > >   static irqreturn_t veml6030_event_handler(int irq, void *private)
> > > > @@ -1084,6 +968,13 @@ static int veml6030_hw_init(struct iio_dev *i=
ndio_dev, struct device *dev)
> > > >     int ret, val;
> > > >     struct veml6030_data *data =3D iio_priv(indio_dev);
> > > >
> > > > +   ret =3D devm_iio_init_iio_gts(dev, 2, 150400000,
> > >
> > > Can you please explain the seemingly odd choice for the max scale?
> > >
> > > Just a quick look at the sensor spec and this driver allows me to ass=
ume
> > > following:
> > >
> > > Maximum 'total gain' from both HWGAIN and integration time is 16 * 32=
 =3D 512.
> > >
> > > If we chose the 'total gain' 1x to match scale 1, then the smallest
> > > scale would be 1/512 =3D 0.001 953 125
> > >
> > > This is 1953125 NANOs. This would mean the max-scale 1X =3D> gain 1X =
would
> > > not cause precision loss. (Well, I'm not at my sharpest as I've caugh=
t
> > > cold - but I _think_ this is true, right?)
> > >
> > > If I read this correctly, the only channel where the scale gets appli=
ed
> > > is the INTENSITY channel, right? Hence it should be possible to chose
> > > the scale as we see best. (Unless the idea of this seemingly odd scal=
e
> > > is to maintain the old intensity / scale values in order to not shake
> > > userland any more - in which case this could be mentioned).
> > >
> >
> > The scale is applied to an IIO_LIGHT channel, not to the INTENSITY,
>
> Isn't the IIO_LIGHT channel a PROCESSED one? I thought the scale
> shouldn't be applied to it. (Driver may still apply scale internally,
> but users should not see it, right? And if the driver does it only
> internally, then the driver can also multiply values using (N *
> scale). Well, I suppose you can as well use this "fitted MAX SCALE" -
> but maybe it warrants a comment.

IIO_LIGHT provides RAW and PROCESSED values, which shouldn't have
happened in the first place as PROCESSED is just raw * scale, if scale
had been right from the beginning. Actually, when I took over this
driver, I was tempted to drop the PROCESSED value, but it was too late
for that without breaking ABI. My guess is that the processed value was
provided because in_illuminance_scale was not the right multiplier, only
the gain.
Note that in_illuminance_scale is also provided to the user, and that
must comply with the ABI definitions.

Thank you again,
Javier Carrasco

