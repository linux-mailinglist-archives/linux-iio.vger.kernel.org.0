Return-Path: <linux-iio+bounces-19056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19305AA8849
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1FA189684A
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64D1E5208;
	Sun,  4 May 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpBR57PL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038311C701A;
	Sun,  4 May 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746378367; cv=none; b=Oty0UX1z0Kpu6A9t6aYKur/0L7DnTx7euDuCR2QkYD1XJF1kZazpy2UIaTrGhCMDYfC9ew8XLAgEwe/qgnfW+eKgyEukTxWnyYFgKLGDjZNNFFFC+Fz+hGCuawuYRWdNYq+YGintxwIYM8S6/METR2+PSAv/pKZIAiHE16Ss/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746378367; c=relaxed/simple;
	bh=ohIMwIJcjwXlI7Sby6M2lmwKtg53p/7ZlMhbMd9VT5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiQdd5e88bsdccLNFQkQb0U6YSFhpTWw2PljU485cAc1bFFyHg2LAnf/fWSmUZCPFJSknYoy92Ik1C95mYRQsyDYjlX9IvS+5mmh02LfpLavHmO1ZBA9OXBUwOStYotykBzPhCXID5DGUJoftJHjxNHsee72kirjwwEQjxnJ8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpBR57PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D166EC4CEE7;
	Sun,  4 May 2025 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746378366;
	bh=ohIMwIJcjwXlI7Sby6M2lmwKtg53p/7ZlMhbMd9VT5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JpBR57PLKrkp0RlgOtF+hmyewnJiDOzxjcqQPqnsUGNpH0R+wlAvWnPtiVyUeKUUf
	 ovDO/AwC73eHMTZJXNxH0zV0DMVVa0uqcKKuPtEOQjH7zlEiLFtlKr+N2enVYhSnNB
	 E7Wp3XJ4nk2FO18kSkMojIlF+gWh6G48JSq9OfPM6riO4PChTDQ821EkYfWvVe46ib
	 clP368ZZlkyXUrznjDsyyROjrM8YWKmOgmUrntvEehSP1cxXRuYnOr1CDU1cmckgFh
	 CnLdIkYIo1Ts8fwBmEDhXlOfhYnpTSfrDS5ezhwOEQRSc9XTnoVR6MDJ33BK+XAE0u
	 Ed8ay/svbBa5g==
Date: Sun, 4 May 2025 18:06:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org, Fabio Estevam
 <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
Message-ID: <20250504180600.66269584@jic23-huawei>
In-Reply-To: <CAOMZO5Bbpiz=xMKxEe93dNOkO2CLT-nhVd1SR_rvjOYNzn4wHw@mail.gmail.com>
References: <20250429150213.2953747-1-festevam@gmail.com>
	<20250429183301.326eaacf@jic23-huawei>
	<CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
	<CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
	<20250430141112.00004bb8@huawei.com>
	<CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
	<20250430182537.00007eab@huawei.com>
	<CAOMZO5BCLWFJ=83r0saT=NxVP0f9G-P-2QosDNGArYAtX6v5Lw@mail.gmail.com>
	<CAOMZO5Bbpiz=xMKxEe93dNOkO2CLT-nhVd1SR_rvjOYNzn4wHw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 3 May 2025 09:02:58 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> On Wed, Apr 30, 2025 at 4:37=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
>=20
> > I have applied your suggestion.
> >
> > Please take a look and let me know your thoughts.
> >
> > --- a/drivers/iio/adc/max1363.c
> > +++ b/drivers/iio/adc/max1363.c
> > @@ -504,10 +504,10 @@ static const struct iio_event_spec max1363_events=
[] =3D {
> >         MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),         =
 \
> >         MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),         =
 \
> >         MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),         =
 \
> > -       MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),     =
 \
> > -       MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),     =
 \
> > -       MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),     =
 \
> > -       MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),     =
 \
> > +       MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),    =
 \
> > +       MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),    =
 \
> > +       MAX1363_CHAN_B(1, 0, d1m0, 14, bits, ev_spec, num_ev_spec),    =
 \
> > +       MAX1363_CHAN_B(3, 2, d3m2, 15, bits, ev_spec, num_ev_spec),    =
 \
> >         IIO_CHAN_SOFT_TIMESTAMP(8)                                     =
 \ =20
>=20
> I have also tried changing it like this:
>=20
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -504,10 +504,10 @@ static const struct iio_event_spec max1363_events[]=
 =3D {
>         MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),          \
>         MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),          \
>         MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),          \
> -       MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),      \
> -       MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),      \
> -       MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),      \
> -       MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),      \
> +       MAX1363_CHAN_B(0, 1, d0m1, 28, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(2, 3, d2m3, 29, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(1, 0, d1m0, 30, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(3, 2, d3m2, 31, bits, ev_spec, num_ev_spec),     \
>         IIO_CHAN_SOFT_TIMESTAMP(8)                                      \
>         }
>=20
> In this case, the warnings are gone.
>=20
> Should the masks be 32-bit?
Their depth depends on particular channels but is between 18 and 24
(assuming I'm finally reading the tables right!)

Jonathan

>=20
> Thanks


