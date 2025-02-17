Return-Path: <linux-iio+bounces-15654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD78FA383E0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A33C173B7E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415221C172;
	Mon, 17 Feb 2025 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j46GGvSN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FDB21ADC1
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797505; cv=none; b=lQi8gPecGdQxqnfO68k+ktsvYkBkDmLlgrgmvDNqI1W2SlD9UwqJoxXorxafgt2h66QwY0DNvJNEBi9TiS8QOdOqqeodhzycTKak04zlCGeXkzOI5cbXZFUi9IxACG1XgN5QI9HbHaVQM9qMHFA7cwEpdjFStt7Z02cyNrjhg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797505; c=relaxed/simple;
	bh=t2l66dpfrRzsj/UMYpm+PmQl5Rwk6OWjU44Cbw1alrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bK1E8n4UT6+sYhsZZL6f/gk8LT914UQBOMlSTQqNElAaFYFNaSPBveL1wlVQuhSLmfh+sG1467UtW42jTi6eLr4vDIjy/HXf7nzUb5jl+WJsmJj5nWU2tyG/xwaCBSysCUuzZzEfV/iaRfh4FvBHR2VxPOKxQJWcjCegYNSmFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j46GGvSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDEAC4CEE2;
	Mon, 17 Feb 2025 13:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739797504;
	bh=t2l66dpfrRzsj/UMYpm+PmQl5Rwk6OWjU44Cbw1alrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j46GGvSN97TJGkGkF6+gXi/XYu8pu0M2u0a/yx6rowrpsDbCnGvsCf2HDJWWOrLPv
	 PCi/zYiKgVhJ8D4rpfAtQhgKx03uLga9mS0/KCtSvHYCBHD2bduIb52pH3Wg20mc5h
	 av60q1r3k5V88ovk4hVuvDEZ5Y3f0fv7e85PCFwcJzqU5oaUq/Ndq8ijWxIWLNQx+P
	 tAlZqIKSOCd/Z0jiW7kG/CNEf5Zf56vSfOX1pv7Oi5EmHGyrpXmmuM1DnXE4h0G2Ka
	 VfN5sype5TNhWVWjVl1uzoAVkva5Vvvc2Pao4QyWSyXs6NU92ANVeIQC7QEBqR2hrU
	 B198fyj+V0RVg==
Date: Mon, 17 Feb 2025 13:04:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, Mudit
 Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>, =?UTF-8?B?Sm8=?=
 =?UTF-8?B?w6Nv?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, Cosmin
 Tanislav <demonsingur@gmail.com>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, Gwendal Grignou <gwendal@chromium.org>,
 Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz Duszynski
 <tomasz.duszynski@octakon.com>, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 11/27] iio: adc: ad4695: Stop using
 iio_device_claim_direct_scoped()
Message-ID: <20250217130452.3a95e8a4@jic23-huawei>
In-Reply-To: <a8b34cb7270ab2045894a978797023a8c7fafd63.camel@gmail.com>
References: <20250209180624.701140-1-jic23@kernel.org>
	<20250209180624.701140-12-jic23@kernel.org>
	<20250216181907.40d36bf7@jic23-huawei>
	<6db4821e-9cfe-4256-a357-51a00a50d083@baylibre.com>
	<a8b34cb7270ab2045894a978797023a8c7fafd63.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 10:48:03 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2025-02-16 at 13:00 -0600, David Lechner wrote:
> > On 2/16/25 12:19 PM, Jonathan Cameron wrote: =20
> > > On Sun,=C2=A0 9 Feb 2025 18:06:08 +0000
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >  =20
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >=20
> > > > This complex cleanup.h use case of conditional guards has proved
> > > > to be more trouble that it is worth in terms of false positive comp=
iler
> > > > warnings and hard to read code.
> > > >=20
> > > > Move directly to the new claim/release_direct() that allow sparse
> > > > to check for unbalanced context.=C2=A0 In some cases code is factor=
ed
> > > > out to utility functions that can do a direct return with the
> > > > claim and release around the call.
> > > >=20
> > > > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > > v2: Typo in commit description (David).
> > > > Note there are several sets current in flight that touch this drive=
r.
> > > > I'll rebase as necessary depending on what order the dependencies r=
esolve. =20
> > > I've done this rebase and applied on the testing branch of iio.git.
> > >=20
> > > Would appreciate a sanity check if anyone has time though!
> > >=20
> > > New code is as follows.=C2=A0 The one corner I was not sure on was
> > > that for calibbias reading the direct mode claim was held for a long
> > > time.=C2=A0 That seems to be unnecessary as we have a copy of osr any=
way
> > > in that function used for other purposes.
> > >  =20
> >=20
> > ...
> >  =20
> > > =C2=A0	case IIO_CHAN_INFO_CALIBBIAS:
> > > -		switch (chan->type) {
> > > -		case IIO_VOLTAGE:
> > > -			iio_device_claim_direct_scoped(return -EBUSY,
> > > indio_dev) {
> > > -				ret =3D regmap_read(st->regmap16,
> > > -					AD4695_REG_OFFSET_IN(chan- =20
> > > >scan_index), =20
> > > -					&reg_val);
> > > -				if (ret)
> > > -					return ret;
> > > -
> > > -				tmp =3D sign_extend32(reg_val, 15);
> > > -
> > > -				switch (cfg->oversampling_ratio) {
> > > -				case 1:
> > > -					*val =3D tmp / 4;
> > > -					*val2 =3D abs(tmp) % 4 * MICRO / 4;
> > > -					break;
> > > -				case 4:
> > > -					*val =3D tmp / 2;
> > > -					*val2 =3D abs(tmp) % 2 * MICRO / 2;
> > > -					break;
> > > -				case 16:
> > > -					*val =3D tmp;
> > > -					*val2 =3D 0;
> > > -					break;
> > > -				case 64:
> > > -					*val =3D tmp * 2;
> > > -					*val2 =3D 0;
> > > -					break;
> > > -				default:
> > > -					return -EINVAL;
> > > -				}
> > > -
> > > -				if (tmp < 0 && *val2) {
> > > -					*val *=3D -1;
> > > -					*val2 *=3D -1;
> > > -				}
> > > -
> > > -				return IIO_VAL_INT_PLUS_MICRO;
> > > +		switch (chan->type)
> > > +		case IIO_VOLTAGE: {
> > > +			if (!iio_device_claim_direct(indio_dev))
> > > +				return -EBUSY;
> > > +			ret =3D regmap_read(st->regmap16,
> > > +					=C2=A0 AD4695_REG_OFFSET_IN(chan- =20
> > > >scan_index), =20
> > > +					=C2=A0 &reg_val);
> > > +			iio_device_release_direct(indio_dev);
> > > +			if (ret)
> > > +				return ret;
> > > ////THIS IS THE BIT I WOuLD LIKE EYES on. =20
> >=20
> > Looks fine to me. =20
>=20
> +1
Thanks to you both for the quick replies.

Added Nuno's tags (and the fixlet on the first path - doh!)

Jonathan

>=20
> - Nuno S=C3=A1
> >  =20
> > > +
> > > +			tmp =3D sign_extend32(reg_val, 15);
> > > +
> > > +			switch (osr) {
> > > +			case 1:
> > > +				*val =3D tmp / 4;
> > > +				*val2 =3D abs(tmp) % 4 * MICRO / 4;
> > > +				break;
> > > +			case 4:
> > > +				*val =3D tmp / 2;
> > > +				*val2 =3D abs(tmp) % 2 * MICRO / 2;
> > > +				break;
> > > +			case 16:
> > > +				*val =3D tmp;
> > > +				*val2 =3D 0;
> > > +				break;
> > > +			case 64:
> > > +				*val =3D tmp * 2;
> > > +				*val2 =3D 0;
> > > +				break;
> > > +			default:
> > > +				return -EINVAL;
> > > +			}
> > > +
> > > +			if (tmp < 0 && *val2) {
> > > +				*val *=3D -1;
> > > +				*val2 *=3D -1;
> > > =C2=A0			}
> > > -			unreachable();
> > > +
> > > +			return IIO_VAL_INT_PLUS_MICRO;
> > > =C2=A0		default:
> > > =C2=A0			return -EINVAL;
> > > =C2=A0		} =20
>=20


