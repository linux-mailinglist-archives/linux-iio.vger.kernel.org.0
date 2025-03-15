Return-Path: <linux-iio+bounces-16864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30157A62D2C
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 14:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1360A3B7185
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACC51F5847;
	Sat, 15 Mar 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mrk8Pk5F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962041DF24E;
	Sat, 15 Mar 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742043887; cv=none; b=MdOdSeDbMSIHL8g3PDuV6VBrFbBCd73wWY35A6jxNjlLgheLVgUrly/100zR1fzW46mAMo/2yfTIQUi6EfboUF/a9lBYZinaY0GTp9dfelrYEWwZBq5yGsxiDFAqyzy+EMeQC4wnH0alFZEb6+/X9364KfJvGh1B89VzdNTC4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742043887; c=relaxed/simple;
	bh=u6Iel8b2bCzAd8Tww+Qf0dhhEXLDIZmc3KbYsEv1G0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtjX6g0H2rFOBjujEgNCBJUHGMerekAKZkNemuKMP4E5dyY96vJ1jomJ6MjEmT3qBT+p27mihRUvJmxzQDpg9Gqy20lX4pTFGtjKm0SDmVCUPmDYgiFRui7+L+jDoIxWa0Mwn5iTAYEcVzRlmvOrKDkaNg7sCSHYPvITGx7W+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mrk8Pk5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFFDC4CEE5;
	Sat, 15 Mar 2025 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742043887;
	bh=u6Iel8b2bCzAd8Tww+Qf0dhhEXLDIZmc3KbYsEv1G0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mrk8Pk5F90SugKmQu1VgwcVBUwJbkoEYfwQx5uKwCiLaVJErq5xNP7M4xfYJ8U/6B
	 IWiCsb3uegOcbtuhIVvN+GCulIk7yubWRrk3M++t5xQL/CK63UdCGs3kCi26vHGLeh
	 oSWb6L1kArhgtpaVdKFl8Azf0x0C73iV1W9RRHCcCuAvBwxDJjxKdb/in78763tVo7
	 u3T5PkuAr37vBD9VzG1C67T8DgYV0pKHLSsdJgr0j/m4wn3ew0+FN1Zl6pAjFP/0tC
	 xF9jhYYLcKD3W20JNUjSzhae6msANv43HRKJ1TuGC1QFWfgGxVf2zXvdKtn9u69vvw
	 G2Uv0kRZv1WlQ==
Date: Sat, 15 Mar 2025 13:04:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Esteban Blanc	
 <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: adc: ad4030: explain rearranging raw sample
 data
Message-ID: <20250315130439.63bfa105@jic23-huawei>
In-Reply-To: <5ee9f7cebe54313dbb4054a7215a5220316bce9c.camel@gmail.com>
References: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
	<20250310-iio-adc-ad4030-check-scan-type-err-v1-5-589e4ebd9711@baylibre.com>
	<5ee9f7cebe54313dbb4054a7215a5220316bce9c.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 09:30:32 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-03-10 at 15:43 -0500, David Lechner wrote:
> > Add a comment explaining why the raw sample data is rearranged in the
> > in the ad4030_conversion() function. It is not so obvious from the code
> > why this is done.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> (BTW, for some reason I started to send the tags without first checking t=
he
> complete series. So I could have just replied to the cover :facepalm:

I do that sometimes when I know I might not get to the end of the series :)

Just to add to the confusion...

Series applied to the testing branch of iio.git which I'll rebase after
rc1 is available.

Thanks

Jonathan

>=20
> - Nuno S=C3=A1
>=20
> > =C2=A0drivers/iio/adc/ad4030.c | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> > index
> > 54ad74b96c9f256a67848330f875379edc828b0b..636f9f33e66af73d102722b984dc1=
230e141
> > 7d1e 100644
> > --- a/drivers/iio/adc/ad4030.c
> > +++ b/drivers/iio/adc/ad4030.c
> > @@ -646,6 +646,12 @@ static int ad4030_conversion(struct iio_dev *indio=
_dev)
> > =C2=A0					=C2=A0=C2=A0 &st->rx_data.dual.diff[0],
> > =C2=A0					=C2=A0=C2=A0 &st->rx_data.dual.diff[1]);
> > =C2=A0
> > +	/*
> > +	 * If no common mode voltage channel is enabled, we can use the raw
> > +	 * data as is. Otherwise, we need to rearrange the data a bit to
> > match
> > +	 * the natural alignment of the IIO buffer.
> > +	 */
> > +
> > =C2=A0	if (st->mode !=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> > =C2=A0	=C2=A0=C2=A0=C2=A0 st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_CO=
M)
> > =C2=A0		return 0;
> >  =20
>=20


