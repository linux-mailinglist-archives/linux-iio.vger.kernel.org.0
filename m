Return-Path: <linux-iio+bounces-6816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2BD915223
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4761F2205D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019E19B5B6;
	Mon, 24 Jun 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjuWtSvn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5ED19B595;
	Mon, 24 Jun 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242580; cv=none; b=BjJ4JEHqPjqgna8yYUatwUAFQB4I+Cddm2mFc3x6VWlc8OpHgEh1f5/za268rhYrjv1r9hs2dt+zunO0rC+SA5KmlMkx9Ey/c5O0Veh4vNFHqq296SD7PUDeCbptErDsBSavgmJLr3a2OvuzaAf+1Rb3M+TGTAXjfo6yZPadE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242580; c=relaxed/simple;
	bh=70ZgxnauQ8qjj062IrhRcJou3GMIDmv5u7umql5+AAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QiJ9UXu8Jl/lTU8ZP4SkyW3Y7Rno7APO3h1del4MVWSKwKvjxOg5JXkmATjKkXaPqFoUSCqp88G0AVf9dRRcyMvk2oUnHvQm7XvSUQmbgAaQhhSdwrzkR12a/zh9N6Mo2YCPiMVYIsb05yu44NJVYezrq4uVgqnZPFWr5gBsfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjuWtSvn; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec50d4e47bso29677401fa.2;
        Mon, 24 Jun 2024 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719242576; x=1719847376; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tXyhmAmmS/6Cy5Xtbgm9RQtLXYOO7vlUxcAJ9Q0MIKQ=;
        b=bjuWtSvnY1ebb3mYgunoQGuGNRtjmnRNBrUTWaOKOY/KP0S0z8d23rr3fo2HdfmTdh
         rLoQIMewqvnOt3M9FZNN5/fYBfSQ5moW3f/XVR/VamEPTECJw7nOeBkBt8hMeeJX4IfH
         BELeS9fSTvtok4UgEFSV1Z8bofCUAUHveUoXP0wk/TvjJUeCyDWqkcif+rqb6VGa/cEB
         JZi0JA26hlv+oSwm0YuzzuXwuDSyfDwBdCgraIyNuGXp5lYOXSDdJdyUh/sH5P9Ln2Hu
         hiA80v/9MBCuigXzaxnhwmVUg0upOYEn4PlwU2WezxayRlAaWkiNHw4d9vmAU41zk1b8
         vQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242576; x=1719847376;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXyhmAmmS/6Cy5Xtbgm9RQtLXYOO7vlUxcAJ9Q0MIKQ=;
        b=kscZBSS+z7t1OMJWAwbZWklBKW3qeksiRkoYq6N06ehCISTZAzhXCO9Y4vj6mupq5T
         eax2Dg1zmZGsl++FoxJbvtdJAF38cjwlpMY+W+9oKIuZ1K6HbkImF7R2t339CtIfQI95
         Pb5gfbjF8kwfqH+TuOsjQ7fGp0dOJhFxaFkdWeTGKmhuRLNS0+Cf0U5MS+qgg6d+/4Yz
         Dswq7w5N5yp/z5gq+hu7rVPtODosRnojtP/ZYXMasevGlvE3nQoWZtjkQCzjKg3Fg9Oo
         o0NvENXI9Ux0gMXBCyKO299jk+AcOD2VlpQsSRNlkGnZuGaDiCZTI058vPvUWmKrXgH5
         qr2w==
X-Forwarded-Encrypted: i=1; AJvYcCWTiL0BwmWZwIlbic6Cd5/v6K/CZc6FTLgrfbgVAst4tGUUPkY60S4Fgh6WSdfJJZL6alm6CXxMALWzdISJFVvfV7cSWk6XNdGfjdVmX9sip9KrSRMME/eyDuhlVRIY1d3KvkrMkyVQ
X-Gm-Message-State: AOJu0YzFepall6IVEo8pVTapK5OFpBcJ8Z6Hho+xl9TCyRFIrczJErSB
	4PkUVEjLiTZgk0vD3ShhMZeeh/7lM1ARS/ywWewCkTya4KBUvxyZLtzHb70z
X-Google-Smtp-Source: AGHT+IHhQUd8xX7sWURRCX5nkC6C31c6u8hLoHvN4uXiN08tv4aApkw9xwYLCzMqEIFCJtaZT83GcA==
X-Received: by 2002:a2e:9d88:0:b0:2ea:7e50:6c94 with SMTP id 38308e7fff4ca-2ec5b27e7f9mr31577811fa.16.1719242575117;
        Mon, 24 Jun 2024 08:22:55 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042d10csm4880811a12.40.2024.06.24.08.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:22:54 -0700 (PDT)
Message-ID: <1ef85cdcffefee6b6a68927816f3d26c074a5331.camel@gmail.com>
Subject: Re: [PATCH 7/8] iio: add sd modulator generic iio backend
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood
 <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date: Mon, 24 Jun 2024 17:22:54 +0200
In-Reply-To: <2dbd160b-135e-4882-9fd3-9d921742f49d@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	 <20240618160836.945242-8-olivier.moysan@foss.st.com>
	 <20240623161150.358f95bf@jic23-huawei>
	 <2dbd160b-135e-4882-9fd3-9d921742f49d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Olivier,

On Mon, 2024-06-24 at 14:43 +0200, Olivier MOYSAN wrote:
> Hi Jonathan,
>=20
> On 6/23/24 17:11, Jonathan Cameron wrote:
> > On Tue, 18 Jun 2024 18:08:33 +0200
> > Olivier Moysan <olivier.moysan@foss.st.com> wrote:
> >=20
> > > Add a generic driver to support sigma delta modulators.
> > > Typically, this device is a hardware connected to an IIO device
> > > in charge of the conversion. The device is exposed as an IIO backend
> > > device. This backend device and the associated conversion device
> > > can be seen as an aggregate device from IIO framework.
> > >=20
> > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> >=20
> > Trivial comments inline.
> >=20
> > > diff --git a/drivers/iio/adc/sd_adc_backend.c
> > > b/drivers/iio/adc/sd_adc_backend.c
> > > new file mode 100644
> > > index 000000000000..556a49dc537b
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/sd_adc_backend.c
> > > @@ -0,0 +1,110 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Generic sigma delta modulator IIO backend
> > > + *
> > > + * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
> > > + */
> > > +
> > > +#include <linux/iio/backend.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +struct iio_sd_backend_priv {
> > > +	struct regulator *vref;
> > > +	int vref_mv;
> > > +};
> > > +
> > > +static int sd_backend_enable(struct iio_backend *backend)
> > > +{
> > > +	struct iio_sd_backend_priv *priv =3D iio_backend_get_priv(backend);
> > > +
> > > +	return regulator_enable(priv->vref);
> > > +};
> > > +
> > > +static void sd_backend_disable(struct iio_backend *backend)
> > > +{
> > > +	struct iio_sd_backend_priv *priv =3D iio_backend_get_priv(backend);
> > > +
> > > +	regulator_disable(priv->vref);
> > > +};
> > > +
> > > +static int sd_backend_read(struct iio_backend *backend, int *val, in=
t *val2,
> > > long mask)
> > Nothing to do with this patch as such:
> >=20
> > One day I'm going to bit the bullet and fix that naming.
> > Long long ago when the Earth was young it actually was a bitmap which
> > I miscalled a mask - it only had one bit ever set, which was a dumb
> > bit of API.=C2=A0 It's not been true for a long time.
> > Anyhow, one more instances isn't too much of a problem I guess.
> >=20
>=20
> I changed the callback .read_raw to .ext_info_get to take Nuno's comment=
=20
> about iio_backend_read_raw() API, into account.
> So, I changed this function to
> static int sd_backend_ext_info_get(struct iio_backend *back, uintptr_t=
=20
> private, const struct iio_chan_spec *chan, char *buf)
> for v2 version.
>=20

Maybe I'm missing something but I think I did not explained myself very wel=
l. What I
had in mind was that since you're calling .read_raw() from IIO_CHAN_INFO_SC=
ALE and
IIO_CHAN_INFO_OFFSET, it could make sense to have more dedicated API's. Mea=
ning:

iio_backend_read_scale(...)
iio_backend_read_offset(...)

The iio_backend_read_raw() may make sense when frontends call
iio_backend_extend_chan_spec() and have no idea what the backend may have a=
dded to
the channel. So, in those cases something like this could make sense:

switch (mask)
IIO_CHAN_INFO_RAW:

...

default:
	return iio_backend_read_raw();

but like I said maybe this is me over-complicating and a simple
iio_backend_read_raw() is sufficient. But I think I never mentioned somethi=
ng like
.read_raw -> .ext_info_get.

The other thing I mentioned was to instead of having:


if (child) {
	ch->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
				 BIT(IIO_CHAN_INFO_SCALE) |
				 BIT(IIO_CHAN_INFO_OFFSET);
}

You could use iio_backend_extend_chan_spec() and have the backend set the S=
CALE and
OFFSET bits for you as it seems these functionality depends on the backend.

But none of the above were critical or things that I feel to strong about.

Anyways, just wanted to give some clarification as it seems there were some
misunderstandings (I think).

- Nuno S=C3=A1

> >=20

