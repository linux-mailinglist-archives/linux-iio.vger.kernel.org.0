Return-Path: <linux-iio+bounces-20285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3835AD0D61
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 14:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3977A261C
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 12:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1E2206B8;
	Sat,  7 Jun 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqeHPf/C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB74C8F;
	Sat,  7 Jun 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749298970; cv=none; b=ACSSK7Dmu9Y6AalPeIKiy6ycSM7uRkXSV5JDXPWIiyG7Zm3TgFYUJn1apPzj+OgjOueZrMiWOVh5ThA1o78EDoxlsumZ2ftOpA4CagrFxdAnd69C6U4FLA2OilwjRHwb665j+4nIS96BlyOuvRTR9aJTEPucH7fB6ysMb6bg3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749298970; c=relaxed/simple;
	bh=3ptY2tgV7V2evTtzjA4beZ9ycyJUvCiShYm+BtCxdKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDyz8YVlFpchwbnx+X5Xed7z7ZQ/6Kuhxg3Jqgqj0Q/JarYpZu7+5SStb2EYquJyMNNYfm/2Efgp05rfQsh4EkVlXTZYtRO9uVKcjI4Wjpmw6Jiv8m3wYcv89Yf4ob13I++Y3PMdkCrWPBzR0SDgy7A95mVxNbMxxFfL/snX3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqeHPf/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02B5C4CEE4;
	Sat,  7 Jun 2025 12:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749298969;
	bh=3ptY2tgV7V2evTtzjA4beZ9ycyJUvCiShYm+BtCxdKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FqeHPf/ClNtD9Ye1YqTR2FsONCmVPHn5xu0xys2VhSBHAyjBeJq0LCiy0yMovM87F
	 ZFlSB1u+WuyJ81UX9kcqKIweJ+uwO2vfd8gcFS8AaQzIWT1s2udOMJvq+WkBq7eHdt
	 w9bxN6Q5UyZ90ce2UQGgnUiir62JSymdaM1gVKv37c/hbbrbqA4oyPdI8GoSNLRhfc
	 KJ9RerG7QQxQ2IxF0aXt9whIu9EcU7szc6M8onYgishr+tcWhFSbneRcyEjP7LhOsX
	 JvR8GEBq3I6T/3hWvmmtkEtOURqE5wb7srWGtRjZNSxis1tmkb5/ZtSTOWB2Be5nQ1
	 NSuyyHphSp90Q==
Date: Sat, 7 Jun 2025 13:22:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com
Subject: Re: [PATCH v10 01/12] iio: adc: ad7768-1: Ensure SYNC_IN pulse
 minimum timing requirement
Message-ID: <20250607132238.4ce19d54@jic23-huawei>
In-Reply-To: <57edc6dc-bbf7-4491-a43b-c33b9466d8d0@baylibre.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
	<d3ee92a533cd1207cf5c5cc4d7bdbb5c6c267f68.1749063024.git.Jonathan.Santos@analog.com>
	<57edc6dc-bbf7-4491-a43b-c33b9466d8d0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Jun 2025 15:14:59 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/4/25 2:35 PM, Jonathan Santos wrote:
> > The SYNC_IN pulse width must be at least 1.5 x Tmclk, corresponding to
> > ~2.5 =C2=B5s at the lowest supported MCLK frequency. Add a 3 =C2=B5s de=
lay to
> > ensure reliable synchronization timing even for the worst-case scenario.
> >=20
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > --- =20
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
This stands fine on it's own so applied even if I don't yet pick up the
rest of the series.

Applied to the testing branch of iio.git which I'll rebase on rc1 sometime
early next week.

Thanks,

Jonathan

>=20
> > v10 Changes:
> > * New patch.
> > ---
> >  drivers/iio/adc/ad7768-1.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 51134023534a..8b414a102864 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -252,6 +252,24 @@ static const struct regmap_config ad7768_regmap24_=
config =3D {
> >  	.max_register =3D AD7768_REG24_COEFF_DATA,
> >  };
> > =20
> > +static int ad7768_send_sync_pulse(struct ad7768_state *st)
> > +{
> > +	/*
> > +	 * The datasheet specifies a minimum SYNC_IN pulse width of 1.5 =C3=
=97 Tmclk,
> > +	 * where Tmclk is the MCLK period. The supported MCLK frequencies ran=
ge
> > +	 * from 0.6 MHz to 17 MHz, which corresponds to a minimum SYNC_IN pul=
se
> > +	 * width of approximately 2.5 =C2=B5s in the worst-case scenario (0.6=
 MHz).
> > +	 *
> > +	 * Add a delay to ensure the pulse width is always sufficient to
> > +	 * trigger synchronization.
> > +	 */
> > +	gpiod_set_value_cansleep(st->gpio_sync_in, 1);
> > +	fsleep(3);
> > +	gpiod_set_value_cansleep(st->gpio_sync_in, 0);
> > +
> > +	return 0; =20
>=20
> There is no other return, so this could be a void function. In this case,=
 it is
> fine because a later patch adds another return. But in the future, be sur=
e to
> mention that in the commit message (or below the ---) so that reviewers w=
ill
> know why without having to look ahead.
>=20
> > +}
> > + =20


