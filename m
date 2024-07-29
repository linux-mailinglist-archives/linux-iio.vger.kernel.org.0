Return-Path: <linux-iio+bounces-8022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77293F877
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 16:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCF528159C
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16923154C19;
	Mon, 29 Jul 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3aV5L0ST"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E814EC60
	for <linux-iio@vger.kernel.org>; Mon, 29 Jul 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264140; cv=none; b=avhvIccd/KiIgqN/NB9kFO9dDUzGNzYZ31t7B3/FsT4y566m8Z9WhfuZtW3SgjhwtX+nK6rVV06j/NijGILxYYGB2rbY7lZBH6FbI1Rwf3WewaD7UlCLSQgkCCZrOuLwPdH6Vyrz5wdhNWcz8XoE/wIfSCykp5I+GAJTEQJN2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264140; c=relaxed/simple;
	bh=Pa38IDDz14ZyF1Kf+6NrTlL3LquE/bkSNCFq2Fv3qCA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TSsLLh79U6QonvYExGLD9k7qbcDuvgdcsbJnxYOXwXnJlpchGQ4l6bqDr6LwFgeNtcpsvR5/DIf+SQWlRBCGi/Dsn5gS4dv+QGRziSD3GxJpGfL1GBeA1ErNHj1DoGRnUf0fRktuU+f/CaM7VhGb4QwecHM9lttzMw+tTjtbpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3aV5L0ST; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42816ca782dso15381395e9.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Jul 2024 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722264137; x=1722868937; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vryNgyzMsFde+cbe622LWwyKPkGWCTER1RhK0F4O8U=;
        b=3aV5L0STHV2sWsoHNVwh6zESYw2eZIPKDKksAey+bUownSMc/x2fCHgzwmlXRWcVWa
         xRR2TCgM2ZvmrFlsar+JLWKHFN48M9eKTyfU5CIijuqcyxXFluxYV11lfWst4UA/ak7b
         eA990enPPF6ayq5QMKjH6yaH2r3RRTZ6fYUUZfsSbp2tbvcKq3Pa6njmIxsrCo+G+yuG
         KypqNb35RN/CbV6+hYMxh/utbxbi7OHW4Eulgbpg3fQQ4yTBoUtzVAmpU6/0FJmpSLix
         YtWsYUCC5SlABEtkwb/D5kxIetv0mZU7lu2KOBPiTnDzQ9HsyNNnCKitO/2DAe04ETzh
         LmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264137; x=1722868937;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/vryNgyzMsFde+cbe622LWwyKPkGWCTER1RhK0F4O8U=;
        b=P4dXpQZdVYg/8dOHhS3IJlt+HswnQwGbt/fTYOhoQuDvu05tLOHu7DSHtu80aWbqv5
         YfE5htgLWYyo/bjJvrIUhAvgQL0yGDgIc5XNXIMgFakd8/Cpo3NWMlzDhpuYcfLghK3y
         0yy1QyKQw/oFVTcFsEDNQR59xd+MzX4WbQoO/lx3mJqfXhzQr0ZL8wqFoNaZqlVOEXd6
         Qn14ZrtiIPBwIH0oRSHBhIo6sLH6ltQUfyyImLsMkwu0mDVoOm3/h9AjRveyMOMeB3Zj
         /LB73ABs37McoQz0vaOtPwzZxFE50MNJy7FOmsh0Oyor4XErv2U50XF6AvBp0M3EeDXO
         vzcg==
X-Forwarded-Encrypted: i=1; AJvYcCXH/vjtjSsCpyQw6qRPFgRHhJp0xJZWwSy0oTrdx3zsLFMYvxWjbxRhaFNiYkGWA8YNOM3FFB9qnwpXcUM7YMcbnIQgaS9apXga
X-Gm-Message-State: AOJu0YzE0lKo8sUGE8t2b7ba41I4RIvBJXRjjh+ZesA75ToYTtyeBlgo
	A5rycKO6c4wo9QhFu/YNQ+CQhCVTJ1TOywkUct7rWiBgMf8M91djq1EHFDRsU14=
X-Google-Smtp-Source: AGHT+IFZFxS6E27mnr9vmlBnL/tw27bvTGWht1x8YDq/zlbnhtJdSomwiir8f5bX62qkw+iQQ586Rg==
X-Received: by 2002:a05:600c:3505:b0:426:67ad:38e3 with SMTP id 5b1f17b1804b1-42811d73aa0mr55232845e9.3.1722264137354;
        Mon, 29 Jul 2024 07:42:17 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a635csm180606715e9.30.2024.07.29.07.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 07:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jul 2024 16:42:16 +0200
Message-Id: <D323OLK1T0CG.1OGNBVY1FDVJT@baylibre.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Jonathan Cameron" <jic23@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
 <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
 <20240629173945.25b72bde@jic23-huawei>
In-Reply-To: <20240629173945.25b72bde@jic23-huawei>

On Sat Jun 29, 2024 at 6:39 PM CEST, Jonathan Cameron wrote:
> On Thu, 27 Jun 2024 13:59:13 +0200
> Esteban Blanc <eblanc@baylibre.com> wrote:
>
> > This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> >=20
> > The driver implements basic support for the AD4030-24 1 channel
> > differential ADC with hardware gain and offset control.
> >=20
> > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>

...

> > +static int ad4030_spi_read(void *context, const void *reg, size_t reg_=
size,
> > +			   void *val, size_t val_size)
> > +{
> > +	struct ad4030_state *st =3D context;
> > +
> > +	struct spi_transfer xfer =3D {
> > +		.tx_buf =3D st->tx_data,
> > +		.rx_buf =3D st->rx_data.raw,
> > +		.len =3D reg_size + val_size,
> > +	};
> > +	int ret;
> > +
> > +	memcpy(st->tx_data, reg, reg_size);
> > +
> > +	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	memcpy(val, &st->rx_data.raw[reg_size], val_size);
>
> Can you just use spi_write_then_read() here?
>

I was planning on doing that. But I'm getting a timeout issue when
using `spi_write_then_read`. I can see the tx_data going out, rx_data
is recived but CS is kept asserted. I need to investigate more but in
the meantime I'm using this as it is working. I will remove this
workaround if I can find a fix and add a comment for now.

> > +	if (ret)
> > +		return ret;
> > +
> > +	if (st->chip->precision_bits =3D=3D 16)
> > +		offset <<=3D 16;
> > +	else
> > +		offset <<=3D 8;
>
> As below. This is hard tor read. Just use appropriate unaligned gets for =
the
> two cases to extract the write bytes directly.
>
> > +	*val =3D be32_to_cpu(offset);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad4030_set_chan_gain(struct iio_dev *indio_dev, int ch, int=
 gain_int,
> > +				int gain_frac)
> > +{
> > +	struct ad4030_state *st =3D iio_priv(indio_dev);
> > +	__be16 val;
> > +	u64 gain;
> > +
> > +	gain =3D mul_u32_u32(gain_int, MICRO) + gain_frac;
> > +
> > +	if (gain > AD4030_REG_GAIN_MAX_GAIN)
> > +		return -EINVAL;
> > +
> > +	val =3D cpu_to_be16(DIV_ROUND_CLOSEST_ULL(gain * 0x8000, MICRO));
> > +
> > +	return regmap_bulk_write(st->regmap, AD4030_REG_GAIN_CHAN(ch), &val,
> > +			  AD4030_REG_GAIN_BYTES_NB);
> > +}
> > +
> > +static int ad4030_set_chan_offset(struct iio_dev *indio_dev, int ch, i=
nt offset)
> > +{
> > +	struct ad4030_state *st =3D iio_priv(indio_dev);
> > +	__be32 val;
> > +
> > +	if (offset < st->min_offset || offset > st->max_offset)
> > +		return -EINVAL;
> > +
> > +	val =3D cpu_to_be32(offset);
> > +	if (st->chip->precision_bits =3D=3D 16)
> > +		val >>=3D 16;
> > +	else
> > +		val >>=3D 8;
>
> I 'think' I get what this is doing but not 100% sure as it's a bit too un=
usual
> and I'm not even sure what happens if we shift a __be32 value on a little=
 endian
> system. I would instead split this into appropriate cpu_to_be24() and cpu=
_to_be16()
> to put the value directly in the right place rather than shifting in plac=
e.

cpu_to_be24 does not exist yet. I will have a look on how to add them.


All the other comments will be addressed in V2.

Best regards,

--=20
Esteban "Skallwar" Blanc
BayLibre

