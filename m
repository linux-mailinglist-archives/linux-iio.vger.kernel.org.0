Return-Path: <linux-iio+bounces-12553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872489D6A13
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE721618A5
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB9139CFF;
	Sat, 23 Nov 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvshBxgE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6486AE3;
	Sat, 23 Nov 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379164; cv=none; b=MsPqC6l2Ae0CXVYOue31mF7UxqGINf5VrYi2d13C9W5OushbQTJCMYnGUsIVHf58kuCc4zCCO0TdnZppsfa4bzm+v2hVd1E3WNrQ3HHE5r5rHlLxeFWMrAY6UH3EDOBjWTx4Uxhr34UXOs/0l7ZftlLKHfN+g0jQKCo3x5f1Rjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379164; c=relaxed/simple;
	bh=xgeSKex4QQcGgGb278DlEhk6oYMFCVz0AaJy3CJNQyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSq0saQj79RzVmoExx5tlOpMgGFnfEqN5miH1MezPz2HmfpYqYA7vu/kDYYm7+u4gKnKtLrQEBPqngfvJ1cP3/vc11uciGGgTGhSCtzr1FeRC7GIyoh0fM0iD7efiC6eqMBFpwiVp2CwkrKROFvSejlntoBI3IG2sXV8k97ubD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvshBxgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61777C4CECD;
	Sat, 23 Nov 2024 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732379164;
	bh=xgeSKex4QQcGgGb278DlEhk6oYMFCVz0AaJy3CJNQyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JvshBxgE8mXULFxfo2t0L2tLHFa9fCRvrjwM2emzrR+37GtUIEIBLTO7MKneH3+iU
	 oXxMInZYcfHHAO4+a1PNHnC82rUl2sRiUCeduhdUrx3/q8ftcnxkE1pNUjzbqfH88V
	 OPP6ouVCZKGwj6PewO6PG6ktZuUkfvqCNmZL7dN9s5G0sDx5SfcVxIoV+K3DRSwE2c
	 cQ8shP18t4qu4D2Wn1D4sOHl6ollSk9q6VnzZekKVFBqM71g+QEcI6KK1K87U+x7Mo
	 rsNiDy5Q1PZ7VMjq5dj2VEg2d15EJ0fmSXzjwhoncHJtCGulxYVRhCS3fjoJmKCs2P
	 BjMlNAjRAF3Sw==
Date: Sat, 23 Nov 2024 16:25:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Victor.Duicu@microchip.com, andy.shevchenko@gmail.com, lars@metafoo.de,
 Marius.Cristea@microchip.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v11] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Message-ID: <20241123162557.02247657@jic23-huawei>
In-Reply-To: <c67cd8be57b54b792430fd56a57a3ee1@gmail.com>
References: <20241114084702.3499-1-victor.duicu@microchip.com>
	<c1b30741bec25e25c6e57389bf45d04f@gmail.com>
	<faed3b586e1af2d946d3f9b185a94b6ebf0f6f32.camel@microchip.com>
	<c67cd8be57b54b792430fd56a57a3ee1@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2024 14:43:11 +0100
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> On Thu, 14 Nov 2024 12:52:12 +0000, <Victor.Duicu@microchip.com> wrote:
> > On Thu, 2024-11-14 at 12:00 +0100, Matteo Martelli wrote: =20
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe
> > >  =20
> >=20
> > Hi Matteo,
> >  =20
> > > On Thu, 14 Nov 2024 10:47:02 +0200, <victor.duicu@microchip.com>
> > > wrote: =20
> > > > From: Victor Duicu <victor.duicu@microchip.com>
> > > >=20
> > > > This patch implements ACPI support to Microchip pac1921.
> > > > The driver can read the shunt resistor value and label from the
> > > > ACPI table.
> > > >=20
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> > > > ---
> > > >  =20
> >=20
> > ....
> >  =20
> > > >=20
> > > >=20
> > > > +#define PAC1921_ACPI_GET_uOHMS_VALS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > > +#define PAC1921_ACPI_GET_LABEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 1
> > > > +/*
> > > > + * The maximum acceptable shunt value is 2146.999999 OHM.
> > > > + * This value, which is below INT_MAX, was chosen in order to
> > > > + * allow the readings from dt and ACPI to share the same range
> > > > + * and to simplify the checks.
> > > > + * With this value the maximum current that can be read is
> > > > + * 0.1V / 2146.999999OHM =3D 46.576 uA
> > > > + * If we use INT_MAX the maximum current that can be read is
> > > > + * 0.1V / 2147.483647OHM =3D 46.566 uA
> > > > + * The relative error between the two values is
> > > > + * |(46.566 - 46.576) / 46.566| * 100 =3D 0.0214
> > > > + */
> > > > +#define PAC1921_MAX_SHUNT_VALUE_uOHMS=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2146999999UL
> > > > + =20
> > >=20
> > > Just a minor point about this: if I understand correctly that value
> > > comes from (INT_MAX / MICRO - 1) * MICRO + MAX_MICRO. This was to
> > > simplify the check in a single statement in
> > > pac1921_write_shunt_resistor()
> > > which is called when the shunt resistor is set from *sysfs* (neither
> > > from DT nor ACPI). I'm fine with this value and the new check but I
> > > find
> > > the explanation comment a bit confusing. If you could come up with a
> > > bit
> > > more clear explanation about the reason of such value I think it
> > > would be
> > > better otherwise I am fine with it as it is. Also, maybe use the full
> > > room
> > > for 80 characters per line and UOHMS instead of uOHMS to avoid mixed
> > > case if
> > > you are going with a new version. =20
> >=20
> > We could completely remove the need to use a constant below INT_MAX
> > with this check in pac1921_write_shunt_resistor:
> >=20
> > if ((!val && !val_fract) ||=C2=A0
> > ((val >=3D INT_MAX / MICRO) && (val_fract > INT_MAX % MICRO)))
> > 	return -EINVAL;
> >=20
> > Do you agree with this approach? =20
>=20
> Yes, something like this would be clearer to me.
>=20
> Anyway, I think you also need to check for val > INT_MAX / MICRO when
> val_fract is < INT_MAX % MICRO, right?
>=20
> Also, I think you can remove a couple of parenthesis.
>=20
> So something like the following maybe (but please double check it):
>=20
> 	if ((!val && !val_fract) || val > INT_MAX / MICRO ||
> 	   (val =3D=3D INT_MAX / MICRO && val_fract > INT_MAX % MICRO))
>=20
> I think that usually it would be better to use pre-computed constants
> instead of run-time divisions for efficiency but since the shunt
> resistor is likely going to be set rarely, I would go for this code for
> better clarity.
FWIW The compiler should be able to squash those into compile time constant=
s anyway.
>=20
>=20
> > Also, the use of mixed case was suggested by Andy to increase
> > readability. =20
>=20
> Ah, sorry for missing Andy's comment. I am fine with it if you also find
> it more readable.
>=20
> >=20
> > ...
> >  =20
> > >=20
> > >=20
> > > Best regards,
> > > Matteo Martelli =20
> >=20
> > With Best Regards,
> > Duicu Victor =20
>=20
> Thanks,
> Matteo Martelli


