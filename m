Return-Path: <linux-iio+bounces-19105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD20DAA9744
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFFC7A6A1B
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B925DCF0;
	Mon,  5 May 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/4y6Wt6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D725DD01;
	Mon,  5 May 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458212; cv=none; b=l5uH7cAewGZnIBEP3dZoEqDAnDvwhqdIYMtr1KYR7Dfly+xNde5aklV5DFUzvNGuhYWyjvAiOiQdHNMmPFT0eb9BFnQmEIkJg1B0IOLEm3tUak9rO9Wl+uji7ihVNs5hTWVVLD6J1qCQv3/KuL4IFLEh5eQ7MecZ0BAGZRvQhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458212; c=relaxed/simple;
	bh=6x3lekKTFSPzx8ESHrUQ2eoOKoI6fl0LkpCkCYPxYoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vm7uMK3X8ojDXAXFIMxay0Lzkh2mOYcVygvy3QdhZ8Q5uOor6G3RnBr6LERLwsz/+64VEm0BYONHDQZ68lW3TvlSK2Pbx9PshGWsxYaL+TbV01a/BCnPzH5MHJBLP2cZinEe8wea9ZOIkfIohV5pf+fg6NUTEJNXoXaltSSAfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/4y6Wt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE02C4CEE4;
	Mon,  5 May 2025 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746458211;
	bh=6x3lekKTFSPzx8ESHrUQ2eoOKoI6fl0LkpCkCYPxYoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D/4y6Wt6d5qDhvjgoQLNKP+g2gJDnZW7tMVOOE3cgWnYpDn/jT9Lm6ZreZtaFs6sM
	 WQxTfYESl2L4Gygdn25AtPQ9ou4cTgVvAZ1BcDhbnvsnmpSB1D1FV5GBj26F5o91pS
	 UC1YD45VdPMhNghFb7Y3ZvpHR8q4+lJ8a0ztZkkUayBY9Zj/JjQoWRfNGCa8/HGaKQ
	 DH5qgZ2uvvn0araso6xTI6acj3KTRlV2JVIpDVCRnEXm8FpfVYjS1fIGpzmhAaE8sp
	 YHFGFsk2qrilxsqSfhoOBzGgeq1u5Ewoap/K7QmzGtrGzGkLAqAuoC6dkW+9DY8344
	 klXCALCoYS7Mg==
Date: Mon, 5 May 2025 16:16:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org, Fabio Estevam
 <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
Message-ID: <20250505161645.5bca37c5@jic23-huawei>
In-Reply-To: <CAOMZO5DeMNGqpF4T7tuvBBN=i95uReSTXkj-sNW2jZTUO++5ZA@mail.gmail.com>
References: <20250429150213.2953747-1-festevam@gmail.com>
	<20250429183301.326eaacf@jic23-huawei>
	<CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
	<CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
	<20250430141112.00004bb8@huawei.com>
	<CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
	<20250430182537.00007eab@huawei.com>
	<CAOMZO5BCLWFJ=83r0saT=NxVP0f9G-P-2QosDNGArYAtX6v5Lw@mail.gmail.com>
	<20250504180420.73b96437@jic23-huawei>
	<CAOMZO5DeMNGqpF4T7tuvBBN=i95uReSTXkj-sNW2jZTUO++5ZA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 11:24:36 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Sun, May 4, 2025 at 2:04=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>=20
> > Ah. I was wrong for last two channels above. The scan masks for single =
channel for
> > differential channels also index a bunch we aren't using in this device.
> > =20
> > > +       MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),  =
   \
> > > +       MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),  =
   \ =20
> > //gap here as we aren't using 4,5  6,7 8,9, 10,11
> > =20
> > > +       MAX1363_CHAN_B(1, 0, d1m0, 14, bits, ev_spec, num_ev_spec),  =
   \ =20
> > Should be 18
> > https://elixir.bootlin.com/linux/v6.14.5/source/drivers/iio/adc/max1363=
.c#L262 =20
> > > +       MAX1363_CHAN_B(3, 2, d3m2, 15, bits, ev_spec, num_ev_spec),  =
   \ =20
> > and 19 I believe. =20
>=20
> This works fine for me, thanks:
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
> +       MAX1363_CHAN_B(1, 0, d1m0, 18, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(3, 2, d3m2, 19, bits, ev_spec, num_ev_spec),     \
>         IIO_CHAN_SOFT_TIMESTAMP(8)                                      \
>         }
>=20
> > Maybe we can simplify this and make it less error prone. These scan ind=
ices
> > are always the same as the enum max1363_mode entries in the 2nd or 3rd =
parameter.
> > We can just reuse those I think.  Only the single channel ones apply he=
re
> > but those are the first set of entries in that enum.
> >
> > Bonus points for just dropping the parameter and using the existing addr
> > parameter for the macro as si as well.
> >
> > That is:
> > #define MAX1363_CHAN_U(num, addr, bits, ev_spec, num_ev_spec)   \
> >         {                                                              =
 \
> >                 .type =3D IIO_VOLTAGE,                                 =
   \
> >                 .indexed =3D 1,                                        =
   \
> >                 .channel =3D num,                                      =
   \
> >                 .address =3D addr,                                     =
   \
> >                 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),        =
   \
> >                 .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),=
   \
> >                 .datasheet_name =3D "AIN"#num,                         =
   \
> >                 .scan_type =3D {                                       =
   \
> >                         .sign =3D 'u',                                 =
   \
> >                         .realbits =3D bits,                            =
   \
> >                         .storagebits =3D (bits > 8) ? 16 : 8,          =
   \
> >                         .endianness =3D IIO_BE,                        =
   \
> >                 },                                                     =
 \
> >                 .scan_index =3D (addr),                                =
   \
> > The above changed from si to addr =20
>=20
> I tried this change on top of the previous one, and it still works.
>=20
> How do you think we should proceed? Can you please submit formal patches?
That would be perfect! If you can do it by modifying the macro as that is
going to be the simplest path to ensure there are no others even better.

Jonathan

>=20
> You can add:
>=20
> Reported-by: Fabio Estevam <festevam@denx.de>
> Tested-by: Fabio Estevam <festevam@denx.de>
>=20
> Thanks


