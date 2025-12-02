Return-Path: <linux-iio+bounces-26638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C613C9BE37
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 16:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F324E3141
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0372F22A4E5;
	Tue,  2 Dec 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNdpYtev"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107F62AE70
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687873; cv=none; b=N9XQ7du5ziKpXUyTii8nUTfaFdmHhdWH//YD1d8bgawQdGuZv6EcaRk8eHc2BxfpZ70jObvyAs4v3Wyj6rId74afRrboPZ0JHVe1X1XMKQGIIMe1q9mZHoQexGeOn8k2XboP4n6jxrnGwKk2/TPzFu90F/vYttf7lR+nPC3yNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687873; c=relaxed/simple;
	bh=HYijSUSn0hro0W1A1dG1mFj3T4wSkeDuYzLRP1HYDMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PgawlbheIdxQMKR7eYQkUkLKaYc9DYF+97gnUCuocwdF4wWvMv8c7KJGcG2nt9d4x+P6QgQL7QCaT2DnDexAXK94tDDn6H+Z0d5XapCJi5Ein8+r3pxmDIoZKkAgD/pJfftQCPcCMiW6k8kiNLVPK8GU0/+VHDAzKc5/NyNmgfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNdpYtev; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so41976875e9.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 07:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764687870; x=1765292670; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WGSsYT5bkGCIa+dpPiHT5SiBWMh8trrXZ1WS3t4AGnk=;
        b=aNdpYtevsnPjeIgwZMlixD+1BL6U7zqEH9mgvG25JwxHb+BtnCFaXYjT20JrkgABdA
         euo5JcYSK0Cs1dlAF71C/RXrBQSTGRxAX190sJwGXKHNYG+/yUxMpIRb6+dJhsd6IEFS
         LNUYYY+8JpEcmTNSqBWGPL7fyufR5eUQsImImualXE9/1wsF6FE4jfwC/ZkIEjqzMceX
         7f9b5OedWNI1JX72aUG2300n2KX93t+Q49rERWqDDXuQKgF2f34H102hooitNwNMvJft
         4V2QzYRoetg/R8cy0D6fTU1Mf6vILmqNH8DnVYHu1OxG5cE54pxbNGbFCF9wtAypKXs0
         Pmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764687870; x=1765292670;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGSsYT5bkGCIa+dpPiHT5SiBWMh8trrXZ1WS3t4AGnk=;
        b=NwgTBlMToCKrILoPSLEUo0vaaRLL/Z3ReztCEYP29ZoUNcK3y5dOIYtbS30Wh82NLf
         P069e1z+ghswKBLBpSeH16zIOWMRSN5K5T+FLhiMZX4S3t058q1Z8TSLh6vaZZzoIgFl
         PoqAHTTo8LsryCakeQvYEimlDrNwoOZT4YZp6PUGCYYUsoCOWI3oUil6/3QW/5pyWgfr
         6ZdXm35hyAjDaAqdOf1DlRHlMcLs0n/QsJ/pyqLAPwJI2k3m9reqXQTKr2/wD2UPFKWq
         ClWa/CTA7OfPlooWvCY6ULwABhUoJKiWyl6k5fdF1BYieia6B5v05FsCG3sTbwyqcHfx
         cyIw==
X-Forwarded-Encrypted: i=1; AJvYcCUhtEPpp8NOnqtQZxBvtvMlNR7RSY7pi5iZQFCdJkpbZZw2OgbH+7aP+2TVUhfAQKJuNBPe4lkPghc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5b1genaXzxNRwNNDwZzW++FECHbGeV5alkADgl0nIDwhejMHV
	gmmLnhlKG8S8gRAy1D2BF459JHtu2y6dpujFGw2VIZHVgUHb/+m0flN2
X-Gm-Gg: ASbGncvHiTbEE4NsIS0u/rgkPz7ULV4TXnSctQKCAOXE+yRgbEuQADPhkJQB3bNDg/1
	b/VmiR6JjHJIPV0qkvx0NGuaX18Yr7waAqaJdSdfjnCBnSOKhNPxTnBIbGz8o04B06exdPb5YkV
	2OJf9Gb5tc6x70AXq0hBA7UvhIIx7hztinNCcerpnmdLm1maNPY8Ev0aiqK3EkWkUvPdJPW3eKv
	bhvMe+BTiWEk0Y04AUxr3mPuq1vX5kB/LDeBydMKJf2X9dORXOkUsN3EH8flUTEFBHdhKo8QgIs
	71hNDKq1d5oCItjkJwl34Nby5edqMbYa15Nc9IfFmv1/UI9QbYiZnfSBvGbgjcp0hoYwmDVw32Q
	OzDO7DZIT4apLNCef0rNnXshmvYLXlRYn8kI01EJQK54Sa+dsoi0DUyryTgjJ5wWGpoZf1ULUzW
	5CS/yQlnpYsQdQewmZo3I=
X-Google-Smtp-Source: AGHT+IEBxiosM0ynntLWUxK9nKTH8YYNh2WJL8ba42XGeLyM+oQGqPneX/yA9YKSPCog6q5WrCrr6Q==
X-Received: by 2002:a05:600c:3152:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-47904b24282mr314250375e9.29.1764687870109;
        Tue, 02 Dec 2025 07:04:30 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47927808a3esm18576935e9.1.2025.12.02.07.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:04:29 -0800 (PST)
Message-ID: <a6194f8f0b8506283d2941a869961fd4f284634d.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,  David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean	 <alexandru.ardelean@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 02 Dec 2025 15:05:09 +0000
In-Reply-To: <8edcbe15-b3cf-4259-9d07-87c07f1f400e@vaisala.com>
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
	 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
	 <5d343af235c499382bd2eac987357e857865b457.camel@gmail.com>
	 <8edcbe15-b3cf-4259-9d07-87c07f1f400e@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-02 at 16:52 +0200, Tomas Melin wrote:
> Hi,
>=20
> On 02/12/2025 15:47, Nuno S=C3=A1 wrote:
> > On Tue, 2025-12-02 at 12:53 +0000, Tomas Melin wrote:
>=20
> > > =C2=A0static const struct iio_chan_spec ad9434_channels[] =3D {
> > > -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
> > > +	{
> > > +		.type =3D IIO_VOLTAGE,
> > > +		.indexed =3D 1,
> > > +		.channel =3D 0,
> > > +		.info_mask_shared_by_type =3D
> > > +		BIT(IIO_CHAN_INFO_SCALE) |
> > > +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > +		BIT(IIO_CHAN_INFO_CALIBBIAS),
> > > +		.info_mask_shared_by_type_available =3D
> > > +		BIT(IIO_CHAN_INFO_SCALE) |
> > > +		BIT(IIO_CHAN_INFO_CALIBBIAS),
> >=20
> > Odd style for info_mask_shared_by_type_available and info_mask_shared_b=
y_type. Seems we have
> > more line breaks than needed.
> >=20
> Looking at existing code, there seems to many different ways to indent
> these kind of lines. Can you please provide your preferred style?
>=20

Looking at the same driver I would expect something like:

https://elixir.bootlin.com/linux/v6.18/source/drivers/iio/adc/ad9467.c#L289

So, just break the line when the col limit is reached.

>=20
> >=20
> > > +		.scan_index =3D 0,
> > > +		.scan_type =3D {
> > > +			.sign =3D 's',
> > > +			.realbits =3D 12,
> > > +			.storagebits =3D 16,
> > > +		},
> > > +	},
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0static const struct iio_chan_spec ad9467_channels[] =3D {
> > > @@ -367,6 +389,7 @@ static const struct ad9467_chip_info ad9434_chip_=
tbl =3D {
> > > =C2=A0	.default_output_mode =3D AD9434_DEF_OUTPUT_MODE,
> > > =C2=A0	.vref_mask =3D AD9434_REG_VREF_MASK,
> > > =C2=A0	.num_lanes =3D 6,
> > > +	.offset_range =3D ad9434_offset_range,
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0static const struct ad9467_chip_info ad9265_chip_tbl =3D {
> > > @@ -499,6 +522,33 @@ static int ad9467_set_scale(struct ad9467_state =
*st, int val, int val2)
> > > =C2=A0	return -EINVAL;
> > > =C2=A0}
> > > =C2=A0
> > > +static int ad9467_get_offset(struct ad9467_state *st, int *val)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret =3D ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	*val =3D ret;
> > > +
> > > +	return IIO_VAL_INT;
> > > +}
> > > +
> > > +static int ad9467_set_offset(struct ad9467_state *st, int val)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (val < st->info->offset_range[0] || val > st->info->offset_range=
[2])
> > > +		return -EINVAL;
> > > +
> > > +	ret =3D ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	/* Sync registers */
> >=20
> > I think this is not what David meant by adding a comment. IMHO, the com=
ment as-is does not
> > bring any added value.
> The sync operation is needed in several places and is not commented in
> other locations either. Do you prefer no comment or even more elaborate
> comment for this particular sync operation?
>=20

I know. I'm just stating the comment, as is, does not bring much value. But=
 I was not the one asking
for it so I guess you should ask David :)

- Nuno S=C3=A1

