Return-Path: <linux-iio+bounces-21383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79B1AFA458
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C52189E5A0
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D69B1F4CA9;
	Sun,  6 Jul 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/oDFaoV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387103207;
	Sun,  6 Jul 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751796584; cv=none; b=PVMiYu+uOZAZJulPwM6EPnv5YvBeVyXPcDp98kHt+f+ueLwr0bhqIaB6p7wmhhYxkAnfz6P7ZFyd0+YjiOz0TYMSeqjhU64jBK/5SodPAl/3TAc9tHlcHwfH2837OyrLt7CyOmABva8ptQoxn2bf7YUxnPaBigtvdZ3fsJiEHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751796584; c=relaxed/simple;
	bh=NrfxfUV4noESzV36/FpNEaK1ScHbu4sVg33P7kkdHiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gf3S78o6krueIx8DdibBZvZwRmtf6AvM+WD6Jfw2EtbXC1x5mWiU3FFkrx+ws8w8pvwzfmjjwWsbWlnos6uLU1iTvAjWV4IPkcrlaIWM2Q5fvqv4px9DpZA+aJdSXMoCQpKPuxJOaIjtblRYbIy/FAKWYgOpIriwL2IItx5nanc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/oDFaoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51565C4CEED;
	Sun,  6 Jul 2025 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751796583;
	bh=NrfxfUV4noESzV36/FpNEaK1ScHbu4sVg33P7kkdHiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D/oDFaoVNjE20lVuu7qT6sMcMeawbEMlFb5KdJpVXSurptYEaOGdYuuJa4TVypzBT
	 y/L6ycN2rYw5GpEZMg30qRKeLx3q8qRc5lLE1UErP66xgEJBdVI95afjh6z4KhWVc6
	 RT3b/tktjzjUqsLfglDbcvcRsS3sIhgjbPVSSNDRGKgX4Ut21LeYirXiITPQdwPVw3
	 RK0UJAS1jZoWG5Pe+Y2q+DI8GDznigICcwaEnjHl93wELbjD10i/dMotqytyDSFEXe
	 7WawQCRdxxFICIKky/8x4on5ihWdS7kcAJX3bOufrJJZn+/upkuekWVlrIEgXCa0uV
	 /jp53LHMGu6iA==
Date: Sun, 6 Jul 2025 11:09:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4000: don't use shift_right()
Message-ID: <20250706110936.665e27cc@jic23-huawei>
In-Reply-To: <e490200ef3498d0b9798e918a5a78ff429b004da.camel@gmail.com>
References: <20250702-iio-adc-ad4000-don-t-use-shift_right-v1-1-041c2d6c3950@baylibre.com>
	<e490200ef3498d0b9798e918a5a78ff429b004da.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 02 Jul 2025 15:09:19 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-07-02 at 08:23 -0500, David Lechner wrote:
> > Drop use of shift_right() macro for unsigned value. The shift_right()
> > macro is intended for signed values and is not needed for unsigned
> > values.
> >=20
> > This was found by a static analysis tool [1].
> >=20
> > Link:
> > https://github.com/analogdevicesinc/linux/pull/2831/files#diff-c14a34a6=
492576d22e7192cc0f61ad0083190aeb627191596fe12462f0c6f21aR557
> > =C2=A0[1]
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.
>=20
> > =C2=A0drivers/iio/adc/ad4000.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> > index
> > 5609a7845b6f50b5818613170df6b234f8f0c496..fd3d79fca78581e51bb904d0bcfed=
a3d3663
> > ea25 100644
> > --- a/drivers/iio/adc/ad4000.c
> > +++ b/drivers/iio/adc/ad4000.c
> > @@ -554,7 +554,7 @@ static void ad4000_fill_scale_tbl(struct ad4000_sta=
te *st,
> > =C2=A0	val =3D mult_frac(st->vref_mv, MICRO, st->gain_milli);
> > =C2=A0
> > =C2=A0	/* Would multiply by NANO here but we multiplied by extra MILLI =
*/
> > -	tmp2 =3D shift_right((u64)val * MICRO, scale_bits);
> > +	tmp2 =3D (u64)val * MICRO >> scale_bits;
> > =C2=A0	tmp0 =3D div_s64_rem(tmp2, NANO, &tmp1);
> > =C2=A0
> > =C2=A0	/* Store scale for when span compression is disabled */
> >=20
> > ---
> > base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
> > change-id: 20250702-iio-adc-ad4000-don-t-use-shift_right-bda6e41152b6
> >=20
> > Best regards, =20
>=20


