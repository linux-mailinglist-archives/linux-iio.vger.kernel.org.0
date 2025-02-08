Return-Path: <linux-iio+bounces-15157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A159CA2D628
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 14:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346AE167D13
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73E246344;
	Sat,  8 Feb 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7aN/YpT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4251A3157;
	Sat,  8 Feb 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739019716; cv=none; b=WXFMLQiLjMicejfbXjSoDWLlI4NSsVTV4jk3HVwAGIICHpIacUnDG1A796Jhp2oEW8d/sdcuX7AWsNAmRim4We5CGOZCvj5P5tmC81+F28HMMhL0A15hs/tSCTfDagl+nV87DNg6qg025/N++zNTIuyAFMcBZXijScwEWUl2g6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739019716; c=relaxed/simple;
	bh=V5vec8PpiED22t7ygC/hZpyml2vl0CPM6zxX4o5lAo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwW5YmwGpeQVWGN+HAK4LA0urqihZJ+GxRyAyKQT/OZxL7QjczYV3ccijBWvD7Onu3RpFbFlOxZmOCAkl1q7oUfpGjNcurvyopS2cKwekVJXd59NRsmjDy4cfnRp6plgZEyYJY4J3ESiiIAhvfDgKSuJ0Z7cqGpmMdVOUduCPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7aN/YpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA33C4CED6;
	Sat,  8 Feb 2025 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739019715;
	bh=V5vec8PpiED22t7ygC/hZpyml2vl0CPM6zxX4o5lAo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c7aN/YpTGmUqOuiAL7IEqm6XILmeXLuLqIEv+29lD52lckTMVMLxkfaF8yyuSX/AR
	 c4I4/J/5qLXirmvBFIjonruZCoJKIbIfIBjIQ78cWDxNu3T7oINSo5epVZKkt+pHsS
	 t8whEmZbxJOPg/QpwBVnX1y+QvCgaKY/xVOWvCnXkdUjAa70f2VM9eKr9cidm4dzCW
	 Nr6qIfu9VX6BQGNVHcdftRQmKAoIlhJrvdzgUHMpakbzg2Zdz0kmBfzTTc/533A2UK
	 0KYQuuiuNNMdUQzWp5yS0jhKZZYYszUMokcQ8XAExSo25Nz4Ug0NcXFaUpuufxQFKJ
	 s9EWens109G7Q==
Date: Sat, 8 Feb 2025 13:01:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Linus
 Walleij <linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>, David
 Lechner <dlechner@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250208130143.121058d6@jic23-huawei>
In-Reply-To: <8353a96d-fe39-45c2-b6da-e8083a6bdcd8@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
	<e44851669ce7e91d1295ab7352535c93b89d35bf.1738328714.git.mazziesaccount@gmail.com>
	<20250131174118.0000209a@huawei.com>
	<8353a96d-fe39-45c2-b6da-e8083a6bdcd8@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Feb 2025 15:58:18 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 31/01/2025 19:41, Jonathan Cameron wrote:
> > On Fri, 31 Jan 2025 15:37:48 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >  =20
> >> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> >> an automatic measurement mode, with an alarm interrupt for out-of-wind=
ow
> >> measurements. The window is configurable for each channel.
> >> =20
>=20
> Hi Jonathan,
>=20
> I just sent the v2, where I (think I) addressed all comments except ones=
=20
> below. Just wanted to point out what was not changed and why :)
>=20
> ...
>=20
> >  =20
> >> +struct bd79124_raw {
> >> +	u8 bit0_3; /* Is set in high bits of the byte */
> >> +	u8 bit4_11;
> >> +};
> >> +#define BD79124_RAW_TO_INT(r) ((r.bit4_11 << 4) | (r.bit0_3 >> 4)) =20
> > You could do this as an endian conversion and a single shift I think.
> > Might be slightly simpler. =20
>=20
> I kept this struct with bytes matching the register spec. Doing the=20
> endian conversion and then shifting would probably have worked, but my=20
> head hurts when I try thinking how the bits settle there. Especially if=20
> this is done on a big-endian machine. I can rework this for v3 if you=20
> feel very strongly about this.

The key is that an endian conversion is always the same as OR + SHIFT
because that is being done in the system endiannes.

Doesn't matter that much, but we may see follow up patches switching
this over to the endian handlers.

=46rom datasheet point of view it tends to depend on whether they show
an illustration of a bulk read or not to whether it's described
as a multi byte value, or as bits in smaller registers.

>=20
> ...
>=20
> >  =20
> >> +static irqreturn_t bd79124_event_handler(int irq, void *priv)
> >> +{
> >> +	int ret, i_hi, i_lo, i;
> >> +	struct iio_dev *idev =3D priv;
> >> +	struct bd79124_data *d =3D iio_priv(idev);
> >> +
> >> +	/*
> >> +	 * Return IRQ_NONE if bailing-out without acking. This allows the IRQ
> >> +	 * subsystem to disable the offending IRQ line if we get a hardware
> >> +	 * problem. This behaviour has saved my poor bottom a few times in t=
he
> >> +	 * past as, instead of getting unusably unresponsive, the system has
> >> +	 * spilled out the magic words "...nobody cared". =20
> > *laughs*.  Maybe the comment isn't strictly necessary but it cheered
> > up my Friday. =20
> >> +	 */
> >> +	ret =3D regmap_read(d->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
> >> +	if (ret)
> >> +		return IRQ_NONE;
> >> +
> >> +	ret =3D regmap_read(d->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
> >> +	if (ret)
> >> +		return IRQ_NONE;
> >> +
> >> +	if (!i_lo && !i_hi)
> >> +		return IRQ_NONE;
> >> +
> >> +	for (i =3D 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
> >> +		u64 ecode;
> >> +
> >> +		if (BIT(i) & i_hi) { =20
> > Maybe cleaner as a pair of
> >=20
> > for_each_set_bit() loops.
> >  =20
>=20
> I kept the original for 2 reasons.
>=20
> 1. the main reason is that the for_each_set_bit() would want the value=20
> read from a register to be in long. Regmap wants to use int. Solving=20
> this produced (in my 'humblish' opinion) less readable code.
>=20
> 2. The current implementation has only one loop, which should perhaps be=
=20
> a tiny bit more efficient.

OK.
>=20
> >> +			ecode =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> >> +					IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
> >> +
> >> +			iio_push_event(idev, ecode, d->timestamp);
> >> +			/*
> >> +			 * The BD79124 keeps the IRQ asserted for as long as
> >> +			 * the voltage exceeds the threshold. It may not serve
> >> +			 * the purpose to keep the IRQ firing and events
> >> +			 * generated in a loop because it may yield the
> >> +			 * userspace to have some problems when event handling
> >> +			 * there is slow.
> >> +			 *
> >> +			 * Thus, we disable the event for the channel. Userspace
> >> +			 * needs to re-enable the event. =20
> >=20
> > That's not pretty. So I'd prefer a timeout and autoreenable if we can. =
=20
>=20
> And I did this, but with constant 1 sec 'grace time' instead of=20
> modifiable time-out. I believe this suffices and keeps it simpler.

We might want to present that value to userspace anyway at somepoint, but
a fixed value is fine.

Jonathan

>=20
>=20
> Yours,
> 	-- Matti


