Return-Path: <linux-iio+bounces-19553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBFEAB8D37
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C67D3A3E7E
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D62288CC;
	Thu, 15 May 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AseQbg7w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5519D07E;
	Thu, 15 May 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328784; cv=none; b=eclR+hxjaoPOq1v2X/Tj+BUkbVHFgkOMU7P6Fj7uGtzSjSlfCNLcj/wIRMUJwdNOq373WZUCu/4Ek/Xh2oBiZa8GnBxOZS22rLxIWwDcyuQdbcu4jwXWaEoAR8soFuEDZVMur7D2VQCspjObQ4G9Pj/w0qQUrhBTRTF+eK6ELX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328784; c=relaxed/simple;
	bh=HjI5Tmn7uWq4Z2O/TbcEhEVsZ2+CrZPS4Rlv2p45C0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwGTs9K6j2X/TJRyVodZ4H8KqN8fzdeFbOk9Z9vdKsD/MQ8Vbn+ixnFhHVSFscgquQpbFvgLhkngtORCTGMlnWYD/jPtpzkIqQGcGtvWpXuXBI53GtS96KN+TOD+IhkNJxuLOtcheIuj/ffDV5VHVIc2NnxZpmcnAGRUtbhSFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AseQbg7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1187C4CEE7;
	Thu, 15 May 2025 17:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747328783;
	bh=HjI5Tmn7uWq4Z2O/TbcEhEVsZ2+CrZPS4Rlv2p45C0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AseQbg7wRARQBQ+CyKQkQHPlWuKwhALHHIkn+7oJ2y5aBiSgDjKhroXBy3N+Xu+AJ
	 3dU1Okr0va3lJJC8YgY0SNGOmH5XXVQKbaKWgrtaLdkJMo1vyiyLjHNGm5hFFNrtTT
	 y2liCnw8+tmF7glFmZfPYvrn8wRM08nBXlk+7x0k9FS3avNHH10VslbvWtJx3/zjcd
	 XngCIGFFdUfnnuPZ+RYr3+sB3ELUBqnYJpGsOvglarffY5wEtR9hMGtItoscXK6JsI
	 CtrzTi9CYobYdRpETDEOrGicvlbVXwq9q3N4KDtoZPMMFxpqzSadGYyxhH92EpmGeG
	 dKUoRNQftpW6Q==
Date: Thu, 15 May 2025 18:06:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad7476: Support ROHM BU79100G
Message-ID: <20250515180616.23ca96fd@jic23-huawei>
In-Reply-To: <5ed56b89-8a9b-464f-9b87-f6553395a941@gmail.com>
References: <cover.1747123883.git.mazziesaccount@gmail.com>
	<a6d84a4c9cdd961fbda38182501983f26cceadc9.1747123883.git.mazziesaccount@gmail.com>
	<5f36c304-ed09-4a13-b22d-ceb5924c3739@gmail.com>
	<5ed56b89-8a9b-464f-9b87-f6553395a941@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 May 2025 12:21:30 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 14/05/2025 10:38, Matti Vaittinen wrote:
> > On 13/05/2025 11:26, Matti Vaittinen wrote: =20
> >> ROHM BU79100G is a 12-bit, single channel ADC. Support reading ADC
> >> measurements using the ad7476.c
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> ---
> >> =C2=A0 drivers/iio/adc/ad7476.c | 8 ++++++++
> >> =C2=A0 1 file changed, 8 insertions(+) =20
> >=20
> > For anyone who might hit this mail thread later:
> >=20
> > Conor made me realize that, for now, the BU79100G looks identical to th=
e=20
> > ads7866. Thus, these code-changes aren't needed at the moment, and this=
=20
> > patch can be dropped. For those who wish to use BU79100G, please=20
> > introduce it as
> >=20
> > compatible =3D "rohm,bu79100g", "ti,ads7866";
> >  =20
>=20
> I was too hasty.
>=20
> It seems to me that the fallback won't work with the current driver=20
> because the driver is not populating the of_match_table, but is relying=20
> solely on the spi_device_id table.
>=20
> Judging a quick code reading, the spi_driver_id table entries are=20
> matched to the modalias:
> https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/spi/spi.c#L393
>=20
> Which is (as far as I understand), generated from the first compatible:
> https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/of/base.c#L1170
>=20
> and not from the fallback one.
>=20
> I suppose this means that we would need to add the of_match_table entry=20
> for the ti,ads7866 to make the fallback entry to match the driver.
>=20
> But...
>=20
> The __spi_register_driver() has following comment:
> 	/*
> 	 * For Really Good Reasons we use spi: modaliases not of:
> 	 * modaliases for DT so module autoloading won't work if we
> 	 * don't have a spi_device_id as well as a compatible string.
> 	 */
> https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/spi/spi.c#L487
>=20
> So, having the of_match_table for would not be sufficient for the=20
> autoloading, which would still require the bu79100g to be in the=20
> spi_device_id table.
>=20
> Am I missing something? I don't see how the Linux SPI drivers benefit=20
> from the fallback entries in the dt? (Not saying fallbacks wouldn't be=20
> The Right Thing To Do. Ideally DTs aren't for Linux only, maybe some=20
> other systems can utilize them). To me it seems I still need to add the=20
> spi_device_id entry for the BU79100G, and of_match_table has no=20
> additional benefit? If this is right, then this patch is still relevant,=
=20
> even though the binding should be done as in v2.
+CC Mark Brown and linux-spi.


>=20
> Yours,
> 	-- Matti
>=20
>=20
>=20


