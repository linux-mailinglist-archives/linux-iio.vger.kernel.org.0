Return-Path: <linux-iio+bounces-19055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE536AA8845
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA8718967E9
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93038190497;
	Sun,  4 May 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAMz6lbw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7DB1EEE6;
	Sun,  4 May 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746378266; cv=none; b=dgCwMuPpJWAbnCVy7scMb4drBYJFMMOb5LCEFEPKkmcX88Uciz/SxtYEJDVNIOQc4EbuWGWEj5f7ZtVrWeyXhBe9zIrWgdpWBbL3KKPi2f2QSkIM7s/bfiWU8YJiuFiiqYx2ZFNDK5ofjyuOmsXjsZtjfyQVBb5R24ysQEyhE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746378266; c=relaxed/simple;
	bh=fNOqglqnNM7H3m0NXi7zKXl57DbLdJLQPotrOwoKorc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uThEeUJ9tvowLK5OvJ75X5xunypmApP3ErcNd0GF+A+z2fw1HOVsNC7W+X/QlYnHCGLnyEFuPw2vd40U8dsJ73bl0ahw00rejAHY2pV1uhBT+qe09w74bJjMnru5ODl+EGPWyCNRMDgBhNWgmjsbB7ITNDcDgFXx8PTXhDbtYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAMz6lbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4863C4CEE7;
	Sun,  4 May 2025 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746378265;
	bh=fNOqglqnNM7H3m0NXi7zKXl57DbLdJLQPotrOwoKorc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vAMz6lbw+qEuQk1/7iibovO4HVRu5uXFcBwwweswE5gDrSUKpnAwviokuct4k4zuy
	 v6Cl0PFNb3uH4t94XVelryqP0/ze4NrkZ4ZZ3S7/3emZKLXAIwpSQweedTi5GWjwPC
	 tE5Yo42pmlmWVrPe39WEJUyHfPQZYTO6GenZuf5D3IB3oGZid8fNPkgAAx/yqQwuas
	 LSbyTrCGFGZwN/GNQqiq7mshdq3eqlxx6t+H4AENWOw+C9kdDnPxCXOiwDqlEoFLox
	 T5/5UNKaV6Zz1beylFSBtkIHrMSoxgOXdIoRzQP2O1LmhdcV4v2nFMaWxxw/N5nm96
	 WkoY9HbVVaVRg==
Date: Sun, 4 May 2025 18:04:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org, Fabio Estevam
 <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
Message-ID: <20250504180420.73b96437@jic23-huawei>
In-Reply-To: <CAOMZO5BCLWFJ=83r0saT=NxVP0f9G-P-2QosDNGArYAtX6v5Lw@mail.gmail.com>
References: <20250429150213.2953747-1-festevam@gmail.com>
	<20250429183301.326eaacf@jic23-huawei>
	<CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
	<CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
	<20250430141112.00004bb8@huawei.com>
	<CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
	<20250430182537.00007eab@huawei.com>
	<CAOMZO5BCLWFJ=83r0saT=NxVP0f9G-P-2QosDNGArYAtX6v5Lw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 16:37:30 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Wed, Apr 30, 2025 at 2:25=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>=20
> > Should be:
> > #define MAX1363_4X_CHANS(bits, ev_spec, num_ev_spec) {                 =
 \
> >         MAX1363_CHAN_U(0, _s0, 0, bits, ev_spec, num_ev_spec),         =
 \
> >         MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),         =
 \
> >         MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),         =
 \
> >         MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),         =
 \
> >         MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),    =
 \
> >         MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),    =
 \
> >         MAX1363_CHAN_B(1, 0, d1m0, 14, bits, ev_spec, num_ev_spec),    =
 \
> >         MAX1363_CHAN_B(3, 2, d3m2, 15, bits, ev_spec, num_ev_spec),    =
 \
> >         IIO_CHAN_SOFT_TIMESTAMP(8)                                     =
 \
> >         } =20
>=20
> I have applied your suggestion.
>=20
> Please take a look and let me know your thoughts.
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
> +       MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(1, 0, d1m0, 14, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(3, 2, d3m2, 15, bits, ev_spec, num_ev_spec),     \

Ah. I was wrong for last two channels above. The scan masks for single chan=
nel for
differential channels also index a bunch we aren't using in this device.

> +       MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),     \
//gap here as we aren't using 4,5  6,7 8,9, 10,11

> +       MAX1363_CHAN_B(1, 0, d1m0, 14, bits, ev_spec, num_ev_spec),     \
Should be 18
https://elixir.bootlin.com/linux/v6.14.5/source/drivers/iio/adc/max1363.c#L=
262
> +       MAX1363_CHAN_B(3, 2, d3m2, 15, bits, ev_spec, num_ev_spec),     \
and 19 I believe.

Maybe we can simplify this and make it less error prone. These scan indices
are always the same as the enum max1363_mode entries in the 2nd or 3rd para=
meter.
We can just reuse those I think.  Only the single channel ones apply here
but those are the first set of entries in that enum.

Bonus points for just dropping the parameter and using the existing addr
parameter for the macro as si as well.

That is:
#define MAX1363_CHAN_U(num, addr, bits, ev_spec, num_ev_spec)	\
	{								\
		.type =3D IIO_VOLTAGE,					\
		.indexed =3D 1,						\
		.channel =3D num,						\
		.address =3D addr,					\
		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
		.datasheet_name =3D "AIN"#num,				\
		.scan_type =3D {						\
			.sign =3D 'u',					\
			.realbits =3D bits,				\
			.storagebits =3D (bits > 8) ? 16 : 8,		\
			.endianness =3D IIO_BE,				\
		},							\
		.scan_index =3D (addr),					\
The above changed from si to addr
		.event_spec =3D ev_spec,					\
		.num_event_specs =3D num_ev_spec,				\
	}


>         IIO_CHAN_SOFT_TIMESTAMP(8)                                      \
>         }
>=20
> @@ -577,8 +577,8 @@ static const struct iio_chan_spec
> max1238_channels[] =3D MAX1363_12X_CHANS(12);
>=20
>  static const enum max1363_modes max11607_mode_list[] =3D {
>         _s0, _s1, _s2, _s3,
> -       s0to1, s0to2, s0to3,
> -       s2to3,
> +       s0to1, s0to2, s2to3,
> +       s0to3,
>         d0m1, d2m3, d1m0, d3m2,
>         d0m1to2m3, d1m0to3m2,
>  };
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index 6a6568d4a2cb..8c9330a9f615 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1947,15 +1947,21 @@ static void
> iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
>          * available masks in the order of preference (presumably the lea=
st
>          * costy to access masks first).
>          */
> +       pr_err("******** masklength is %d", masklength);
> +       pr_err("******** longs_per_mask is %d", longs_per_mask);
> +
> +
>         for (i =3D 0; i < num_masks - 1; i++) {
>                 const unsigned long *mask1;
>                 int j;
>=20
>                 mask1 =3D av_masks + i * longs_per_mask;
> +               pr_err("******** mask1[%d] is 0x%lx\n", i, mask1[0]);
>                 for (j =3D i + 1; j < num_masks; j++) {
>                         const unsigned long *mask2;
>=20
>                         mask2 =3D av_masks + j * longs_per_mask;
> +                       pr_err("******** mask2[%d] is 0x%lx\n", i, mask2[=
0]);
>                         if (bitmap_subset(mask2, mask1, masklength))
>                                 dev_warn(indio_dev->dev.parent,
>                                          "available_scan_mask %d
> subset of %d. Never used\n",
>=20
> [    1.569250] iio-core: ******** masklength is 16
> [    1.569261] iio-core: ******** longs_per_mask is 1
> [    1.573834] iio-core: ******** mask1[0] is 0x1
> [    1.583173] iio-core: ******** mask2[0] is 0x2
> [    1.587629] iio-core: ******** mask2[0] is 0x4
> [    1.592091] iio-core: ******** mask2[0] is 0x8
> [    1.596569] iio-core: ******** mask2[0] is 0x3
> [    1.601027] iio-core: ******** mask2[0] is 0x7
> [    1.605482] iio-core: ******** mask2[0] is 0xc
> [    1.609942] iio-core: ******** mask2[0] is 0xf
> [    1.614400] iio-core: ******** mask2[0] is 0x1000
> [    1.619118] iio-core: ******** mask2[0] is 0x2000
> [    1.623832] iio-core: ******** mask2[0] is 0x40000
> [    1.628642] max1363 1-0064: available_scan_mask 10 subset of 0. Never =
used
> [    1.635543] iio-core: ******** mask2[0] is 0x80000
> [    1.640343] max1363 1-0064: available_scan_mask 11 subset of 0. Never =
used
> [    1.647229] iio-core: ******** mask2[0] is 0x3000
> [    1.651943] iio-core: ******** mask2[0] is 0xc0000
> [    1.656745] max1363 1-0064: available_scan_mask 13 subset of 0. Never =
used
> [    1.663631] iio-core: ******** mask1[1] is 0x2
> [    1.668088] iio-core: ******** mask2[1] is 0x4
> [    1.672544] iio-core: ******** mask2[1] is 0x8
> [    1.676997] iio-core: ******** mask2[1] is 0x3
> [    1.681452] iio-core: ******** mask2[1] is 0x7
> [    1.685905] iio-core: ******** mask2[1] is 0xc
> [    1.690365] iio-core: ******** mask2[1] is 0xf
> [    1.694820] iio-core: ******** mask2[1] is 0x1000
> [    1.699535] iio-core: ******** mask2[1] is 0x2000
> [    1.704251] iio-core: ******** mask2[1] is 0x40000
> [    1.709059] max1363 1-0064: available_scan_mask 10 subset of 1. Never =
used
> [    1.715945] iio-core: ******** mask2[1] is 0x80000
> [    1.720747] max1363 1-0064: available_scan_mask 11 subset of 1. Never =
used
> [    1.727632] iio-core: ******** mask2[1] is 0x3000
> [    1.732349] iio-core: ******** mask2[1] is 0xc0000
> [    1.737150] max1363 1-0064: available_scan_mask 13 subset of 1. Never =
used
> [    1.744038] iio-core: ******** mask1[2] is 0x4
> [    1.748488] iio-core: ******** mask2[2] is 0x8
> [    1.752941] iio-core: ******** mask2[2] is 0x3
> [    1.757393] iio-core: ******** mask2[2] is 0x7
> [    1.761846] iio-core: ******** mask2[2] is 0xc
> [    1.766300] iio-core: ******** mask2[2] is 0xf
> [    1.770756] iio-core: ******** mask2[2] is 0x1000
> [    1.775469] iio-core: ******** mask2[2] is 0x2000
> [    1.780184] iio-core: ******** mask2[2] is 0x40000
> [    1.784986] max1363 1-0064: available_scan_mask 10 subset of 2. Never =
used
> [    1.791871] iio-core: ******** mask2[2] is 0x80000
> [    1.796673] max1363 1-0064: available_scan_mask 11 subset of 2. Never =
used
> [    1.803558] iio-core: ******** mask2[2] is 0x3000
> [    1.808271] iio-core: ******** mask2[2] is 0xc0000
> [    1.813072] max1363 1-0064: available_scan_mask 13 subset of 2. Never =
used
> [    1.819961] iio-core: ******** mask1[3] is 0x8
> [    1.824415] iio-core: ******** mask2[3] is 0x3
> [    1.828865] iio-core: ******** mask2[3] is 0x7
> [    1.833317] iio-core: ******** mask2[3] is 0xc
> [    1.837771] iio-core: ******** mask2[3] is 0xf
> [    1.842224] iio-core: ******** mask2[3] is 0x1000
> [    1.846937] iio-core: ******** mask2[3] is 0x2000
> [    1.851649] iio-core: ******** mask2[3] is 0x40000
> [    1.856448] max1363 1-0064: available_scan_mask 10 subset of 3. Never =
used
> [    1.863334] iio-core: ******** mask2[3] is 0x80000
> [    1.868135] max1363 1-0064: available_scan_mask 11 subset of 3. Never =
used
> [    1.875026] iio-core: ******** mask2[3] is 0x3000
> [    1.879739] iio-core: ******** mask2[3] is 0xc0000
> [    1.884540] max1363 1-0064: available_scan_mask 13 subset of 3. Never =
used
> [    1.891427] iio-core: ******** mask1[4] is 0x3
> [    1.895882] iio-core: ******** mask2[4] is 0x7
> [    1.900334] iio-core: ******** mask2[4] is 0xc
> [    1.904787] iio-core: ******** mask2[4] is 0xf
> [    1.909239] iio-core: ******** mask2[4] is 0x1000
> [    1.913952] iio-core: ******** mask2[4] is 0x2000
> [    1.918666] iio-core: ******** mask2[4] is 0x40000
> [    1.923467] max1363 1-0064: available_scan_mask 10 subset of 4. Never =
used
> [    1.930353] iio-core: ******** mask2[4] is 0x80000
> [    1.935154] max1363 1-0064: available_scan_mask 11 subset of 4. Never =
used
> [    1.942045] iio-core: ******** mask2[4] is 0x3000
> [    1.946759] iio-core: ******** mask2[4] is 0xc0000
> [    1.951560] max1363 1-0064: available_scan_mask 13 subset of 4. Never =
used
> [    1.958445] iio-core: ******** mask1[5] is 0x7
> [    1.962898] iio-core: ******** mask2[5] is 0xc
> [    1.967351] iio-core: ******** mask2[5] is 0xf
> [    1.971804] iio-core: ******** mask2[5] is 0x1000
> [    1.976515] iio-core: ******** mask2[5] is 0x2000
> [    1.981233] iio-core: ******** mask2[5] is 0x40000
> [    1.986034] max1363 1-0064: available_scan_mask 10 subset of 5. Never =
used
> [    1.992920] iio-core: ******** mask2[5] is 0x80000
> [    1.997722] max1363 1-0064: available_scan_mask 11 subset of 5. Never =
used
> [    2.004612] iio-core: ******** mask2[5] is 0x3000
> [    2.009327] iio-core: ******** mask2[5] is 0xc0000
> [    2.014125] max1363 1-0064: available_scan_mask 13 subset of 5. Never =
used
> [    2.021011] iio-core: ******** mask1[6] is 0xc
> [    2.025463] iio-core: ******** mask2[6] is 0xf
> [    2.029916] iio-core: ******** mask2[6] is 0x1000
> [    2.034629] iio-core: ******** mask2[6] is 0x2000
> [    2.039343] iio-core: ******** mask2[6] is 0x40000
> [    2.044146] max1363 1-0064: available_scan_mask 10 subset of 6. Never =
used
> [    2.051031] iio-core: ******** mask2[6] is 0x80000
> [    2.055832] max1363 1-0064: available_scan_mask 11 subset of 6. Never =
used
> [    2.062717] iio-core: ******** mask2[6] is 0x3000
> [    2.067435] iio-core: ******** mask2[6] is 0xc0000
> [    2.072237] max1363 1-0064: available_scan_mask 13 subset of 6. Never =
used
> [    2.079123] iio-core: ******** mask1[7] is 0xf
> [    2.083579] iio-core: ******** mask2[7] is 0x1000
> [    2.088293] iio-core: ******** mask2[7] is 0x2000
> [    2.093006] iio-core: ******** mask2[7] is 0x40000
> [    2.097808] max1363 1-0064: available_scan_mask 10 subset of 7. Never =
used
> [    2.104694] iio-core: ******** mask2[7] is 0x80000
> [    2.109493] max1363 1-0064: available_scan_mask 11 subset of 7. Never =
used
> [    2.116378] iio-core: ******** mask2[7] is 0x3000
> [    2.121091] iio-core: ******** mask2[7] is 0xc0000
> [    2.125892] max1363 1-0064: available_scan_mask 13 subset of 7. Never =
used
> [    2.132777] iio-core: ******** mask1[8] is 0x1000
> [    2.137490] iio-core: ******** mask2[8] is 0x2000
> [    2.142203] iio-core: ******** mask2[8] is 0x40000
> [    2.147009] max1363 1-0064: available_scan_mask 10 subset of 8. Never =
used
> [    2.153896] iio-core: ******** mask2[8] is 0x80000
> [    2.158698] max1363 1-0064: available_scan_mask 11 subset of 8. Never =
used
> [    2.165583] iio-core: ******** mask2[8] is 0x3000
> [    2.170297] iio-core: ******** mask2[8] is 0xc0000
> [    2.175098] max1363 1-0064: available_scan_mask 13 subset of 8. Never =
used
> [    2.181983] iio-core: ******** mask1[9] is 0x2000
> [    2.186698] iio-core: ******** mask2[9] is 0x40000
> [    2.191504] max1363 1-0064: available_scan_mask 10 subset of 9. Never =
used
> [    2.198390] iio-core: ******** mask2[9] is 0x80000
> [    2.203191] max1363 1-0064: available_scan_mask 11 subset of 9. Never =
used
> [    2.210077] iio-core: ******** mask2[9] is 0x3000
> [    2.214788] iio-core: ******** mask2[9] is 0xc0000
> [    2.219591] max1363 1-0064: available_scan_mask 13 subset of 9. Never =
used
> [    2.226476] iio-core: ******** mask1[10] is 0x40000
> [    2.231363] iio-core: ******** mask2[10] is 0x80000
> [    2.236250] max1363 1-0064: available_scan_mask 11 subset of 10. Never=
 used
> [    2.243222] iio-core: ******** mask2[10] is 0x3000
> [    2.248022] iio-core: ******** mask2[10] is 0xc0000
> [    2.252910] max1363 1-0064: available_scan_mask 13 subset of 10. Never=
 used
> [    2.259882] iio-core: ******** mask1[11] is 0x80000
> [    2.264770] iio-core: ******** mask2[11] is 0x3000
> [    2.269570] iio-core: ******** mask2[11] is 0xc0000
> [    2.274458] max1363 1-0064: available_scan_mask 13 subset of 11. Never=
 used
> [    2.281430] iio-core: ******** mask1[12] is 0x3000
> [    2.286229] iio-core: ******** mask2[12] is 0xc0000
> [    2.291120] max1363 1-0064: available_scan_mask 13 subset of 12. Never=
 used
>=20


