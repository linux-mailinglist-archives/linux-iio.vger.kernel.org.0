Return-Path: <linux-iio+bounces-10653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757DF9A030F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 09:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAA61C24980
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D8D1C4A2B;
	Wed, 16 Oct 2024 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqpnWXAj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8851C1738;
	Wed, 16 Oct 2024 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065047; cv=none; b=iv9LapwHZJk0x0ou3sRbaaj67dkLqnSN27l985FXlVh2IlJmBUFxRIBAQm40K6/7RK5gI/hIcMZptsdio+Z4L+QSIESm9HYSUNTBAvx/IK0XUAQkkMwLoDP8C9eoR+SyU4XY9MtclhOROqaW/KGwxC2G7IkFveF2CRxflTpdIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065047; c=relaxed/simple;
	bh=Uu2AZgGXRqdhhrna22HLPxO9DEkbdx5WPqejTwlzqxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPN7jq1hKPj4gcepO2/1ArRZZ0uGAG3o5spJ4+FcJSfCt1yldHnEFr/DDBa3IcqNp76V+/iC2hAMa7ruUCAoMlGNRxKxj1pogJZozjxcHyqcxsjVoXkQBuHaoHxbAjpVKzioB8a9hYoZ+bu5CNsF9OzZnz+79s2P/Z8iDMX8g4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqpnWXAj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso6834473a12.2;
        Wed, 16 Oct 2024 00:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729065044; x=1729669844; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HSNC+5SGIRbATuqyvZHMD9wWlmxIGVun3q7GDqQBxCg=;
        b=SqpnWXAjeFmrfadZDBk/S/KZnDkZE2muz46E68R0TqPV/WhupkE6uJZRva56g9SQNu
         zuS0YVqtA35fsDzt43JZuc7rfDZszBSVlXIUAybAkl7wzuJQxxkt2oZ8lY1FVm7tGYDB
         bkzRdAvor8QbaBPPX2ElSUOm4URDBAw2BNOY5IedwBpwp8hXNBuVEs9wkFMp1Zj0J2iy
         P/5vvCGgJcC0RJp9z+G/JE4fLK9wy+iy2ClTaPVeFYcFw3oEa7NC66EL5qjlkV4ldfbY
         xkWwIbqB0YgDW7K4Tc9Ap6B0kp5T+gLxR2kDIDhccBLVJYZnthYlb6JqG/n21N/GJgSR
         IAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729065044; x=1729669844;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSNC+5SGIRbATuqyvZHMD9wWlmxIGVun3q7GDqQBxCg=;
        b=oH8aDW9/6kjn5s4A8dzFJTzWp5tcCnxNMGBjbn1oL4JZqXp23OjBl4T1Hulad+nlbJ
         T3gxupWBvBtAXF04CEUCUe5ZYLO+Q/p57oWR12YE/AvjxJHkWRfTRdvshJILCrmyZm88
         d8Q+S2ljFsuRhQoo3BWI7qffWYx2GgPa6+mYj3aW5K9ILGxD92v6+t2FJ/d9Lq9i6Mr8
         d9LQp5L3vJJxfN8PEen353LxTnTBoHSX4yOZT26UtdPUjJWMGw+rqMh73fTCTorK9pAl
         ZZW7W45k/W43G0TXG2USja+yadI/WapdYMX/biwjdtF9WaD7Ha2SBiKm8GL6U5CELkJo
         wlsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpYFD/p9vQbIrVRy3ibd7fdcZ0gC28e76dWAuCGoavm0PBrzniD2ADSP/1r5rDos7TQxDC42yP+Qdo@vger.kernel.org, AJvYcCWK/iyBkw5UHn2myCUX8AQJCSdufMXtuG9wCxFQrCj0Yi38s5H6RwbzhiIk6tWwwkyAm2pemvR61NPma21n@vger.kernel.org
X-Gm-Message-State: AOJu0YwIH42PXzlZhkV4w5HneXEUDLnePty5d5yOfJniCgJgy+OEM1KY
	pblPrYKPD5T38p36GqxAi368+OaLyhM95hNnQU0uCPqZKzV42bEEc0gpBZzmGzNSDQ==
X-Google-Smtp-Source: AGHT+IFHmYLQxETTPmEeXrSXPJLuthr55iJg3jmQ50v870UkcZTvimJLubGOu8Of4//FtD9xK17l2A==
X-Received: by 2002:a17:907:7ba8:b0:a9a:1778:7024 with SMTP id a640c23a62f3a-a9a1778712cmr712081066b.20.1729065043397;
        Wed, 16 Oct 2024 00:50:43 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29817eb9sm150833866b.121.2024.10.16.00.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:50:42 -0700 (PDT)
Message-ID: <61cf3072af74a8b2951c948ddc2383ba1e55954d.camel@gmail.com>
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: add high-speed platform driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Date: Wed, 16 Oct 2024 09:50:41 +0200
In-Reply-To: <23dafe91-2733-4ed6-901a-d324749d11b2@baylibre.com>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
	 <c3d55f78-5a54-49f8-b6a1-4ed0f24f8666@baylibre.com>
	 <8642bdb546c6046e8fe1d20ef4c93e70c95c6f71.camel@gmail.com>
	 <2815c8b0-e2ad-47cb-b5aa-00297cf57899@baylibre.com>
	 <781cf5fa075e13260e1b20f5acadb70bd8107cd0.camel@gmail.com>
	 <23dafe91-2733-4ed6-901a-d324749d11b2@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-15 at 10:23 -0500, David Lechner wrote:
> On 10/15/24 10:00 AM, Nuno S=C3=A1 wrote:
> > On Tue, 2024-10-15 at 09:38 -0500, David Lechner wrote:
> > > On 10/15/24 1:37 AM, Nuno S=C3=A1 wrote:
> > > > On Mon, 2024-10-14 at 16:15 -0500, David Lechner wrote:
> > > > > On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > >=20
> > > > > > Add High Speed ad3552r platform driver.
> > > > > >=20
> > > > >=20
> > > > > ...
> > > > >=20
> > > > > > +static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
> > > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec c=
onst *chan,
> > > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, l=
ong mask)
> > > > > > +{
> > > > > > +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	switch (mask) {
> > > > > > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > > > > > +		int sclk;
> > > > > > +
> > > > > > +		ret =3D iio_backend_read_raw(st->back, chan, &sclk, 0,
> > > > > > +					=C2=A0=C2=A0 IIO_CHAN_INFO_FREQUENCY);
> > > > >=20
> > > > > FWIW, this still seems like an odd way to get the stream mode SCL=
K
> > > > > rate from the backend to me. How does the backend know that we wa=
nt
> > > > > the stream mode clock rate and not some other frequency value?=
=20
> > > >=20
> > > > In this case the backend has a dedicated compatible so sky is the l=
imit :).
> > > > But
> > > > yeah,
> > > > I'm also not extremely happy with IIO_CHAN_INFO_FREQUENCY. But what=
 do you
> > > > have
> > > > in
> > > > mind? Using the sampling frequency INFO or a dedicated OP?
> > > >=20
> > >=20
> > > It think it would be most straightforward to have something
> > > like a iio_backend_get_data_stream_clock_rate() callback since
> > > that is what we are getting.
> >=20
> > Hmmm, what about exporting an actual clock? Maybe it's overkill but fro=
m a
> > correctness point of view, seems what we should actually do :)
>=20
> Does seem overkill to me. I wouldn't do it.
>=20

Yes it is. But to me (now that I slept on the matter) a new backend OP is a=
lso not
the way to go (or at least not coherent). We already have .bus_reg_read() a=
nd
.bus_reg_write() shared through the platform_data 'struct ad3552r_hs_platfo=
rm_data'
interface. Well, in reality we're asking for the bus clock here so better t=
o add a
.bus_clock() to that struct. And since (it seems) we are going the path of =
just
caring about the high speed rate, we might as well just make it a variable =
for
simplicity.

> >=20
> > >=20
> > > Re: the other recent discussions about getting too many
> > > callbacks. Instead of a dedicated function like this, we
> > > could make a set of generic functions:
> > >=20
> > > iio_backend_{g,s}et_property_{s,u}(8, 16, 32, 64}()
> > >=20
> >=20
> > Hmm interesting approach. I don't dislike it. Kind of a generic getter/=
setter
> > thingy.
> > We could then still have optional inline helpers that would call the ge=
neric
> > functions with the proper enum value.
> >=20
> > > that take an enum parameter for the property. This way,
> > > for each new property, we just have to add an enum member
> > > instead of creating a get/set callback pair.
> > >=20
> > > Unrelated to this particular case, but taking the idea even
> > > farther, we could also do the same with enable/disable
> > > functions. We talked before about cutting the number of
> > > callbacks in half by using a bool parameter instead of
> > > separate enable/disable callbacks. But we could cut it down
> > > even more by having an enum parameter for the thing we are
> > > enabling/disabling.
> >=20
> > If we don't get too strict about types it could even fall into the abov=
e u8
> > category.
> >=20
> > Instead of lot of new simple ops we just grow an enum.
>=20
> Sure. For that matter, maybe try to just stick with 32-bit
> for everything to keep it simple. Probably will eventually
> need 64-bit for some things, but might be able to get away
> with avoiding 8 and 16-bit.
>=20

Agreed. Anyways, nothing that I will take care in the near future (I would =
first like
for things to stabilize a bit). That said, if you want (or anybody else), f=
eel free
to send the patches :)

- Nuno S=C3=A1


