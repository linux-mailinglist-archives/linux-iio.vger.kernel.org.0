Return-Path: <linux-iio+bounces-6890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB7916704
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 14:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AC31C20908
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA7D14EC7E;
	Tue, 25 Jun 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6sFX25V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BAB14E2D6;
	Tue, 25 Jun 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317470; cv=none; b=mQDVS6ruz4crWj9LBXoOUV1Ozv89a4ZAby5teu5TQaT3GFlP3LiP13FmqlPMRFiTpjqFxRIU1OpwzK5oq7CBdzVglqaqm9m4iI1r+HzJWx3DfJ8cQuE5u2P1YnGAesAr1PTrti18c4K+FZ/iRsWgn0tGzZkAjTa5pOS6A5uIGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317470; c=relaxed/simple;
	bh=Q1lhFEQ1phCH+ZrXQLuXoSxpnCxPdsqnWE5TlBzySXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWElWrC4VfV5HEdBrwMq5cH7maqx/RXi6NmQ/sh0NcO4RX9CoWQTZVlehqgsHIA5GdCqJCgUD6gJuBCyz2aU0T2m+driYLtu7/0mGBwJ9q0Ng1v6jHRhpj+fRtdASNbJzJ9z2rEBcyknHXSyDsy25NHZuzs+xMHMRqqOIVJJgKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6sFX25V; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3658197cdbbso2970959f8f.3;
        Tue, 25 Jun 2024 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719317467; x=1719922267; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=onIQ8Fs/SPTD1uRRoKnFLfdSPdc5b5iKL1mMSUg4mzU=;
        b=Q6sFX25VZWZ3l6bnV5U1Sv/kmXAPRmSRcyDj9UiXO3t8/bREDS2okXIO06iGnbeYOF
         i1EX9Hr4L07Qx0SwQaPlx7f3jNKPwiEMrlV7z0bp6rRZ4cZff19T/4RMV/5pGan51hR2
         7vwcz9J8/uQbI0NWFH0Gwk8zLCeIysw3/ctQyBKebsQo5bXETmAZ47yYK82eO0hpEFaK
         8LIF3q7j8VhPhL8H5/VQDj6sjUHrfJeWwSzatTAK/24QhJ+g3r6QTZr0Fjekz2B3DSic
         vycbmsKPpa9vWYiv9Sm1iW1VToFU41dhwvW4suh+QLdO64Xx8YB9PbdUfaIt4oI0BAzk
         klxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719317467; x=1719922267;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onIQ8Fs/SPTD1uRRoKnFLfdSPdc5b5iKL1mMSUg4mzU=;
        b=vKUNKxM2RK0bpgrQWjriui4lkjU7fe/cHHKumHu34yFdVM88qV+O89Ofc0rUugLRHq
         ovxbAhWpJBPuskR/ycyYqYkQEJHXMy6bV9KClqKa8Z6oXyb6qm0SdrUY4VWsptl9e2Yv
         X/i8wqBsEIUw46yzqUCj7PHbxCADJxeQiGwJ6PVIDygVA/UQCtMH8mDm3qt10WUUwOLf
         x4zI6hf0MiQQ7AnL8x6t6E3/8g5aLlgfy+uZexjGD9TyvTFaqf4h0lQ3VfA0E12yGihv
         rTuzz2tgSCIofjFs/TWOZFoP7Hz6nfFhEsoQCYtSCLTQcqSYWU8k7OqTs4pc6p1MWpou
         +vPg==
X-Forwarded-Encrypted: i=1; AJvYcCVh1Q426vftwIFKYC3X5Ke80YXUlSZ75qwB+zVKy/0sU4z8+WXSbDI+izTzKR+11+q46B17HXb2x/6YktdOyGmbDPMGn43v6q+FP8qERRX8qMJv9PGJ6EsOj5UwJxk2w0UphMWJVA/K
X-Gm-Message-State: AOJu0YyDtrpQiNT6QXIE0DI0addT3PW1nXj+NUa1wBgSXSlGI6CzwgPI
	H1GsF9F0wKkiw6X27I/Ig1+PxijCChv+1NK/9q8Ix/7LxMENEcPm
X-Google-Smtp-Source: AGHT+IFkgMq1ksP3f4FSqjua8vGYVcg+qlT/3J9grFteNZy0rXnkuSZZyQppUNgcgjBG35J6IKJ71g==
X-Received: by 2002:a05:6000:1fa6:b0:362:df5e:6807 with SMTP id ffacd0b85a97d-366e9492bb1mr6518217f8f.28.1719317466589;
        Tue, 25 Jun 2024 05:11:06 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366dc9c855fsm11956304f8f.84.2024.06.25.05.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:11:06 -0700 (PDT)
Message-ID: <197002f721d0b635e2df6351469036f87c4dd0eb.camel@gmail.com>
Subject: Re: [PATCH 7/8] iio: add sd modulator generic iio backend
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood
 <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date: Tue, 25 Jun 2024 14:14:57 +0200
In-Reply-To: <06edd10d-eab4-41db-83d4-232fc43e1759@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	 <20240618160836.945242-8-olivier.moysan@foss.st.com>
	 <20240623161150.358f95bf@jic23-huawei>
	 <2dbd160b-135e-4882-9fd3-9d921742f49d@foss.st.com>
	 <1ef85cdcffefee6b6a68927816f3d26c074a5331.camel@gmail.com>
	 <06edd10d-eab4-41db-83d4-232fc43e1759@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 18:26 +0200, Olivier MOYSAN wrote:
> Hi Nuno,
>=20
> On 6/24/24 17:22, Nuno S=C3=A1 wrote:
> > Hi Olivier,
> >=20
> > On Mon, 2024-06-24 at 14:43 +0200, Olivier MOYSAN wrote:
> > > Hi Jonathan,
> > >=20
> > > On 6/23/24 17:11, Jonathan Cameron wrote:
> > > > On Tue, 18 Jun 2024 18:08:33 +0200
> > > > Olivier Moysan <olivier.moysan@foss.st.com> wrote:
> > > >=20
> > > > > Add a generic driver to support sigma delta modulators.
> > > > > Typically, this device is a hardware connected to an IIO device
> > > > > in charge of the conversion. The device is exposed as an IIO back=
end
> > > > > device. This backend device and the associated conversion device
> > > > > can be seen as an aggregate device from IIO framework.
> > > > >=20
> > > > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > >=20
> > > > Trivial comments inline.
> > > >=20
> > > > > diff --git a/drivers/iio/adc/sd_adc_backend.c
> > > > > b/drivers/iio/adc/sd_adc_backend.c
> > > > > new file mode 100644
> > > > > index 000000000000..556a49dc537b
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/adc/sd_adc_backend.c
> > > > > @@ -0,0 +1,110 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Generic sigma delta modulator IIO backend
> > > > > + *
> > > > > + * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
> > > > > + */
> > > > > +
> > > > > +#include <linux/iio/backend.h>
> > > > > +#include <linux/iio/iio.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/mod_devicetable.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/regulator/consumer.h>
> > > > > +
> > > > > +struct iio_sd_backend_priv {
> > > > > +	struct regulator *vref;
> > > > > +	int vref_mv;
> > > > > +};
> > > > > +
> > > > > +static int sd_backend_enable(struct iio_backend *backend)
> > > > > +{
> > > > > +	struct iio_sd_backend_priv *priv =3D
> > > > > iio_backend_get_priv(backend);
> > > > > +
> > > > > +	return regulator_enable(priv->vref);
> > > > > +};
> > > > > +
> > > > > +static void sd_backend_disable(struct iio_backend *backend)
> > > > > +{
> > > > > +	struct iio_sd_backend_priv *priv =3D
> > > > > iio_backend_get_priv(backend);
> > > > > +
> > > > > +	regulator_disable(priv->vref);
> > > > > +};
> > > > > +
> > > > > +static int sd_backend_read(struct iio_backend *backend, int *val=
, int
> > > > > *val2,
> > > > > long mask)
> > > > Nothing to do with this patch as such:
> > > >=20
> > > > One day I'm going to bit the bullet and fix that naming.
> > > > Long long ago when the Earth was young it actually was a bitmap whi=
ch
> > > > I miscalled a mask - it only had one bit ever set, which was a dumb
> > > > bit of API.=C2=A0 It's not been true for a long time.
> > > > Anyhow, one more instances isn't too much of a problem I guess.
> > > >=20
> > >=20
> > > I changed the callback .read_raw to .ext_info_get to take Nuno's comm=
ent
> > > about iio_backend_read_raw() API, into account.
> > > So, I changed this function to
> > > static int sd_backend_ext_info_get(struct iio_backend *back, uintptr_=
t
> > > private, const struct iio_chan_spec *chan, char *buf)
> > > for v2 version.
> > >=20
> >=20
> > Maybe I'm missing something but I think I did not explained myself very
> > well. What I
> > had in mind was that since you're calling .read_raw() from
> > IIO_CHAN_INFO_SCALE and
> > IIO_CHAN_INFO_OFFSET, it could make sense to have more dedicated API's.
> > Meaning:
> >=20
> > iio_backend_read_scale(...)
> > iio_backend_read_offset(...)
> >=20
> > The iio_backend_read_raw() may make sense when frontends call
> > iio_backend_extend_chan_spec() and have no idea what the backend may ha=
ve
> > added to
> > the channel. So, in those cases something like this could make sense:
> >=20
> > switch (mask)
> > IIO_CHAN_INFO_RAW:
> >=20
> > ...
> >=20
> > default:
> > 	return iio_backend_read_raw();
> >=20
> > but like I said maybe this is me over-complicating and a simple
> > iio_backend_read_raw() is sufficient. But I think I never mentioned
> > something like
> > .read_raw -> .ext_info_get.
> >=20
>=20
> Thanks for clarification. Your previous message was actually clear=20
> enough regarding iio_backend_read_raw() API.
>=20
> However, your comment about extend_chan_spec(), let me think that I=20
> could maybe spare a new API, and just re-use iio_backend_ext_info_get()=
=20
> callback.
> Nevertheless, this API cannot be used directly, as it can be used only=
=20
> for a frontend associated to a single backend. There is a comment in=20
> iio_backend_ext_info_get() about the need of another API for such case.
>=20
> So I considered introducing this new API (instead of read_raw):
> ssize_t iio_backend_ext_info_get_from_backend(struct iio_backend *back,=
=20
> uintptr_t private, const struct iio_chan_spec *chan, char *buf)
> (I'm not sure this name is the most relevant).

Yeah, don't think that's the way to go... If you have multiple backends the=
 idea
is to add a .get_backend() callback into struct iio_info so we can get the
backend handle of the frontend device. It was not done because we still don=
't
have a valid user for such a callback.

But having the said the above, I also don't think we should use any extende=
d
info API to handle scale and offset as those are standard attributes. That =
would
open a dangerous precedence :).
=20
>=20
> But if you don't like this alternative too much, I will keep the initial=
=20
> "catch all" iio_backend_read_raw() API.

Right...

- Nuno S=C3=A1
> > >=20

