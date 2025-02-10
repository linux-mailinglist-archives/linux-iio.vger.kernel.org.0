Return-Path: <linux-iio+bounces-15291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341CA2F824
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 20:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03F63A152E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86131A315A;
	Mon, 10 Feb 2025 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlsfPdbp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CFE25E464;
	Mon, 10 Feb 2025 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214227; cv=none; b=k1pecHk67CCE5G2OVxbZEcMkYd3UIdST1AVDu3zkWEzPJd0PnPRQYhkYE5sFxOU5adKQ69oOHDttTahplBgSRnXkNJ8PspXwddHpO6AIsna4Rvn3kG7h4GaI6V++1YiiIzomtoSgN1mWFtoB4UZRnTIQAPzIo/qR1xmctY2s3RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214227; c=relaxed/simple;
	bh=SQ/Z150ewcrbVyxs4K08XuvWVFdINDF9Lg4z+pHuPjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSB4b5XMvxfqbSpXyLDvkXRqsTKS135NYdhOjX7ql7vAkjnegs35exhcTqiuFgu/09fmpjVlUYQsbxzW8YL/ZWh5FTJyEDmMDHgBATZFoebb9QaOKJw2fImpW57j/FE689cDN4S8Dtv845F9rITI9uNDwOKQJKZ0uOODGBOCw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlsfPdbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA552C4CED1;
	Mon, 10 Feb 2025 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739214226;
	bh=SQ/Z150ewcrbVyxs4K08XuvWVFdINDF9Lg4z+pHuPjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WlsfPdbpJht1QTaT7gKHGKQCEWDicwDEVmHTZHgJCUsYQLwf6WpkEIWvOx8T3nvd2
	 /8+UQ0iNkR4NRvh+SExcVz3+mJHt6LoVjrvV1Dh46EEDpQ/hzVLJkiP9yw2cSavrZ9
	 aEWvO6azAgQudH1RUgBD9OAOkoRzRq7a+007ODbWzStlgBp52+fJf7LrRXMstSYRqW
	 C/+paTFSpCWSEsx8Z9TNCX7V9V1TLGKn2Nq3mTNOL06nHjpvtAdOhiI+jwqM0e6jZu
	 VhoD/bELxbvIgjGKpT6ovClc4y4GsHD4lHU1gB724LvOw5XjdB8L3oRo6H40d24/zz
	 1vbrFbfLFvPbg==
Date: Mon, 10 Feb 2025 19:03:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ad4695: add offload-based oversampling
 support
Message-ID: <20250210190338.484c463e@jic23-huawei>
In-Reply-To: <efba6746-47a6-484f-ade5-f1e17246ac68@baylibre.com>
References: <20250109-ad4695-oversampling-v2-0-a46ac487082c@baylibre.com>
	<20250109-ad4695-oversampling-v2-1-a46ac487082c@baylibre.com>
	<e3fd7f56675908a60d8ce6bcb6ad4f05b828e132.camel@gmail.com>
	<efba6746-47a6-484f-ade5-f1e17246ac68@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 11:49:49 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> On 2025-01-13 09:35, Nuno S=C3=A1 wrote:
> > On Thu, 2025-01-09 at 13:47 -0500, Trevor Gamblin wrote: =20
> >> Add support for the ad4695's oversampling feature when SPI offload is
> >> available. This allows the ad4695 to set oversampling ratios on a
> >> per-channel basis, raising the effective-number-of-bits from 16
> >> (OSR =3D=3D 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e.=
 one
> >> full cycle through the auto-sequencer). The logic for reading and
> >> writing sampling frequency for a given channel is also adjusted based =
on
> >> the current oversampling ratio.
> >>
> >> The non-offload case isn't supported as there isn't a good way to
> >> trigger the CNV pin in this mode. Support could be added in the future
> >> if a use-case arises.
> >>
> >> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> >> --- =20
> > LGTM, just one small thing inline... Either way:
> >
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > =20
> >>  =C2=A0drivers/iio/adc/ad4695.c | 333 ++++++++++++++++++++++++++++++++=
++++++++++----
> >> -
> >>  =C2=A01 file changed, 303 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> >> index c8cd73d19e86..0caaeaa310ed 100644
> >> --- a/drivers/iio/adc/ad4695.c
> >> +++ b/drivers/iio/adc/ad4695.c
> >> @@ -79,6 +79,7 @@
> >>  =C2=A0#define=C2=A0=C2=A0 AD4695_REG_CONFIG_IN_MODE			=C2=A0 BIT(6)
> >>  =C2=A0#define=C2=A0=C2=A0 AD4695_REG_CONFIG_IN_PAIR			=C2=A0 GENMASK(=
5, 4)
> >>  =C2=A0#define=C2=A0=C2=A0 AD4695_REG_CONFIG_IN_AINHIGHZ_EN		=C2=A0 BI=
T(3)
> >> +#define=C2=A0=C2=A0 AD4695_REG_CONFIG_IN_OSR_SET			=C2=A0 GENMASK(1, =
0)
> >>  =C2=A0#define AD4695_REG_UPPER_IN(n)				(0x0040 | (2 * (n)))
> >>  =C2=A0#define AD4695_REG_LOWER_IN(n)				(0x0060 | (2 * (n)))
> >>  =C2=A0#define AD4695_REG_HYST_IN(n)				(0x0080 | (2 * (n)))
> >> @@ -127,6 +128,7 @@ struct ad4695_channel_config {
> >>  =C2=A0	bool bipolar;
> >>  =C2=A0	enum ad4695_in_pair pin_pairing;
> >>  =C2=A0	unsigned int common_mode_mv;
> >> +	unsigned int oversampling_ratio;
> >>  =C2=A0};
> >>    =20
> > ...
> > =20
> >> +
> >> +static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
> >> +{
> >> +	int val_calc, scale;
> >> +
> >> +	switch (osr) {
> >> +	case 4:
> >> +		scale =3D 4;
> >> +		break;
> >> +	case 16:
> >> +		scale =3D 2;
> >> +		break;
> >> +	case 64:
> >> +		scale =3D 1;
> >> +		break;
> >> +	default:
> >> +		scale =3D 8;
> >> +		break;
> >> +	}
> >> +
> >> +	val =3D clamp_t(int, val, S32_MIN / 8, S32_MAX / 8);
> >> + =20
> > Why not clamp()? AFAICS, we have the same type on all the arguments. I =
also
> > think clamp*() macros got the same improvements as min/max() ones which=
 means
> > that using the ones with explicit casts are not so often needed anymore=
. My
> > understanding is also that those macros are not that encouraged as it's=
 easy to
> > go wrong with the casts. =20
> I have no preference, this is just a recent habitual use of clamp_t(). If
> clamp() is preferred I can send a v3. Or maybe Jonathan can tweak it=20
> when it is

I've left it as clamp_T for now.  We can always follow up with a series
to tidy these up general.

Series applied though a bit provisionally as the SPI offload set needed
a few tweaks that might get changed.

Pushed out as testing for now.

Thanks,

Jonathan

>=20
> eventually applied?
>=20
> - Trevor
>=20
> >
> > - Nuno S=C3=A1 =20


