Return-Path: <linux-iio+bounces-5583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B68D718F
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 20:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2AA1F219B8
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 18:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15750154C02;
	Sat,  1 Jun 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXDjSkhh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAB208D4;
	Sat,  1 Jun 2024 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717267423; cv=none; b=PiM46p48dOKY9l+kTqHPhj7rftp3KfhdUR4Lxs+gQVta27fY+2rmFWuXXQr3O/Al2h+IRyfVQkN5AqhBX0Mbfw+AbQ+omXiFN4yMXyuWq9dN1f4Iza5aEeGK+EY8J0eu5VkAQDE1nk3ycpe7V83kunujc2hjUEsVDt6wEYjPIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717267423; c=relaxed/simple;
	bh=JHPacm35K7W1WC34s5PGuycHj5car7YNlXfVgVtqLWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuTtRs/uWuUlmkaNbt0IpRGmUEU8pg/O+kkgCJ+/Q0i98RZKRyo2s6RfSuhJaHmZhwcaaVF5yLDjyx4Y+xX3neXmlzd1hjQ2TzSmb+btzOgiIO5Mmo+58Ue3t+ODctpotpY99OOcrFE1lqeiZoxHzXGbPwMCMutKzPzl2q0z11o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXDjSkhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6370C116B1;
	Sat,  1 Jun 2024 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717267423;
	bh=JHPacm35K7W1WC34s5PGuycHj5car7YNlXfVgVtqLWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZXDjSkhhrfTQplr5y5P3NSNhZQZ3bgDSWwRVT8/2HrxYTFFK4a53RFpnPl2B77Kv1
	 B/7QyD6C3XzGKP+aXeSClpPD7w7ocyQuBspjedtDX9KALxXAxGF1U/Bx7owqsCo1FZ
	 FXZRxUJEtfv91mC9NwSaVnczYPK6j7oDgAz06V70/mhNIpbkwvWhtFsDDbhmtlPVTS
	 nYqHR7+haHmUAHEQsuRKC9ABgQQOj9Y3ZuDT9CsjRLSVeXTee05zjmR3hAflpSF/+a
	 coZZh2AkfuunDZOKGil87gQMWMAO/VZmAME5mIRsEPIBune3m25U6mYIrXBELWF8tE
	 CTtxbO4dOiyvA==
Date: Sat, 1 Jun 2024 19:43:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, "Ceclan, Dumitru" 
 <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: adc: ad7173: Add support for AD411x devices
Message-ID: <20240601194328.6c28f743@jic23-huawei>
In-Reply-To: <d3c2496deb6a1764d06a63592b416d30d43fcc47.camel@gmail.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	<20240527-ad4111-v3-5-7e9eddbbd3eb@analog.com>
	<6f18184de4a37993baedc15b44ecf0a6834a24d1.camel@gmail.com>
	<917bc1d9-fbdc-4ca2-a156-813b57c8201e@gmail.com>
	<30192c2a-5275-41ac-bc20-aa5f436846a3@baylibre.com>
	<d3c2496deb6a1764d06a63592b416d30d43fcc47.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 May 2024 08:19:57 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-05-29 at 15:59 -0500, David Lechner wrote:
> > On 5/29/24 9:03 AM, Ceclan, Dumitru wrote: =20
> > > On 29/05/2024 15:46, Nuno S=C3=A1 wrote: =20
> > > > On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrot=
e: =20
> > > > > From: Dumitru Ceclan <dumitru.ceclan@analog.com> =20
> > >=20
> > > ...
> > >  =20
> > > > > =C2=A0static const struct ad7173_device_info ad7173_device_info[]=
 =3D {
> > > > > +	[ID_AD4111] =3D {
> > > > > +		.name =3D "ad4111",
> > > > > +		.id =3D AD7173_AD4111_AD4112_AD4114_ID,
> > > > > +		.num_voltage_inputs_with_divider =3D 8,
> > > > > +		.num_channels =3D 16,
> > > > > +		.num_configs =3D 8,
> > > > > +		.num_voltage_inputs =3D 8,
> > > > > +		.num_gpios =3D 2,
> > > > > +		.higher_gpio_bits =3D true,
> > > > > +		.has_temp =3D true,
> > > > > +		.has_vcom_input =3D true,
> > > > > +		.has_input_buf =3D true,
> > > > > +		.has_current_inputs =3D true,
> > > > > +		.has_int_ref =3D true,
> > > > > +		.clock =3D 2 * HZ_PER_MHZ,
> > > > > +		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> > > > > +		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> > > > > +	}, =20
> > > >=20
> > > > At some point it would be nice to drop the ad7173_device_info array=
...
> > > >  =20
> > > What are good alternatives to this? =20
> >=20
> > Drivers like ad7091r8 have individual static struct ad7091r_init_info
> > instead of putting them all in an array. I like doing it that
> > way because it makes less code to read compared to having the
> > array.
> >=20
> > It would let us get rid of enum ad7173_ids, have one level less
> > indent on each static const struct ad7173_device_info and=20
> >=20
> > { .compatible =3D "adi,ad7172-2", .data =3D &ad7173_device_info },
> >=20
> > would now fit on one line since we no longer need the array
> > index.
> >  =20
>=20
> Exactly... But up to you to do it now or defer it to a later patch.
>=20
Agreed - the array pattern for this is not a good idea as it
also encourages people to assign meaning to the enum values leaving
stuff expressed as code that should be a flag or value inside these
device_info structures.

Some of those where mistakes of a younger me ;(

Jonathan

> - Nuno S=C3=A1


