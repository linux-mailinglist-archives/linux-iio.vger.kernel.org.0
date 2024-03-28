Return-Path: <linux-iio+bounces-3890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B689046B
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E097F1F22351
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D7B131E2E;
	Thu, 28 Mar 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv48bbru"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB561304A2;
	Thu, 28 Mar 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641585; cv=none; b=dlxY+c5v5iJGa3WAWKJ3I6odVw0zG4k9vanNT0vKhSweezJDTZSdlR7syWB3SnXyyyFz9K9/ECptv/WXyPm1y4iYEBJ93MJ/uNBA9yx9txa1ZWKLQLAWXPljxHMOIXMlME1Z2p5Bb8mlCB2F8cYx9ggMFFLO82N7yggIg7QJ0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641585; c=relaxed/simple;
	bh=qyQUoXy023JIBQTtvFF+Bd/yOnnqvkyALUjGrxU1/h0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxL5YfLitMg6ckgCjPIFpECI9kOehFp3GxmHDoYkIazagDlMGqPF8doNte9cBWKcgGz77bdwWQ0GQYxnx4ru0SPLfamOD9LwIN0Z5KACTUgHXaX/a5CrGqEkavKzheqDklYUBZiix6NtwVutlJdAmZ1M8XN743ivmqOuJjaIIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv48bbru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59B9C433C7;
	Thu, 28 Mar 2024 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711641584;
	bh=qyQUoXy023JIBQTtvFF+Bd/yOnnqvkyALUjGrxU1/h0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qv48bbruU2M0h8t/1bXyZHf9hHNm2f31cadRKh0DbLd3hq7Bh/N1HtDbFuOSxMqEg
	 mQrBZ3sHjTnDzJpCsntqgtAquj04hmbcfNS8gUED+2Qnsb0wBbD6tpyHIUf/QJvkVq
	 PxYjrr2RWSJRgtzZwKpaYVcS4IUivZWB/7ohU3N+DBDPXY/tvNfYvgwR9UDGARMkVk
	 7N7SCFbiQj2Fs7KR3luENIONQo8UxRRri8mA0PiIVA+IE/T0j/0ksq4le0QyoR19kK
	 z87MfCAuOFKeQLMLMxUe9mMgjxUDU6vu+pGgRAGDwhZgwX8tZHy0MXilQEBRE5tz92
	 u++xwi0DOYEcg==
Date: Thu, 28 Mar 2024 15:59:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa via B4 Relay  <devnull+nuno.sa.analog.com@kernel.org>,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Dragos Bogdan <dragos.bogdan@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 08/10] iio: backend: add new functionality
Message-ID: <20240328155929.20848a6a@jic23-huawei>
In-Reply-To: <cec2ac9c67aeae7c59434a86713f35461d171c04.camel@gmail.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	<20240328-iio-backend-axi-dac-v1-8-afc808b3fde3@analog.com>
	<20240328151632.298bd95f@jic23-huawei>
	<cec2ac9c67aeae7c59434a86713f35461d171c04.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Mar 2024 16:42:38 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-03-28 at 15:16 +0000, Jonathan Cameron wrote:
> > On Thu, 28 Mar 2024 14:22:32 +0100
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > This adds the needed backend ops for supporting a backend inerfacing
> > > with an high speed dac. The new ops are:
> > >=20
> > > * data_source_set();
> > > * set_sampling_freq();
> > > * extend_chan_spec();
> > > * ext_info_set();
> > > * ext_info_get().
> > >=20
> > > Also to note the new helpers that are meant to be used by the backends
> > > +		return 0;
> > > +	/*
> > > +	 * !\NOTE: this will break as soon as we have multiple backends on =
one
> > > +	 * frontend and all of them extend channels. In that case, the core
> > > +	 * backend code has no way to get the correct backend given the
> > > +	 * iio device.
> > > +	 *
> > > +	 * One solution for this could be introducing a new backend
> > > +	 * dedicated callback in struct iio_info so we can callback into the
> > > +	 * frontend so it can give us the right backend given a chan_spec.
> > > +	 */ =20
> >=20
> > Hmm. This is indeed messy.=C2=A0 Could we associate it with the buffer =
as presuably
> > a front end with multiple backends is using multiple IIO buffers?
> >  =20
>=20
> Hmm, the assumption of having multiple buffers seems plausible to me but =
considering
> the example we have in hands it would be cumbersome to get the backend. C=
onsidering
> iio_backend_ext_info_get(), how could we get the backend if it was associ=
ated to one
> of the IIO buffers? I think we would need more "intrusive" changes to mak=
e that work
> or do you have something in mind=3D

Nope. Just trying to get my head around the associations. I hadn't thought =
about
how to make that visible in the code.  Probably a callabck anyway.

> =20
> > As you say a dance via the front end would work fine. =20
>=20
> I'm happy you're also open for a proper solution already. I mention this =
in the
> cover. My idea was something like (consider the iio_backend_ext_info_get(=
)):
>=20
> if (!indio_dev->info->get_iio_backend())
> 	return -EOPNOTSUPP;
>=20
> back =3D indio_dev->info->get_iio_backend(indio_dev, chan_spec);
>=20
> It would be nice to have some "default/generic" implementation for cases =
where we
> only have one backend per frontend so that the frontend would not need to=
 define the
> callback.
Agreed - either a default that means if the callback isn't provided we get =
the
single backend or if that proves fiddly at least a standard callback we can
use in all such cases.

>  =20
> >=20
> >  =20
> > > +	iio_device_set_drvdata(indio_dev, back);
> > > +
> > > +	/* Don't allow backends to get creative and force their own handler=
s */
> > > +	for (ext_info =3D chan->ext_info; ext_info->name; ext_info++) {
> > > +		if (ext_info->read !=3D iio_backend_ext_info_get)
> > > +			return -EINVAL;
> > > +		if (ext_info->write !=3D iio_backend_ext_info_set)
> > > +			return -EINVAL;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, IIO_BACKEND); =20
> >  =20
> > > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> > > index a6d79381866e..09ff2f8f9fd8 100644
> > > --- a/include/linux/iio/backend.h
> > > +++ b/include/linux/iio/backend.h
> > > @@ -4,6 +4,7 @@
> > > =C2=A0
> > > =C2=A0#include <linux/types.h>
> > > =C2=A0
> > > +struct iio_chan_spec;
> > > =C2=A0struct fwnode_handle;
> > > =C2=A0struct iio_backend;
> > > =C2=A0struct device;
> > > @@ -15,6 +16,26 @@ enum iio_backend_data_type {
> > > =C2=A0	IIO_BACKEND_DATA_TYPE_MAX
> > > =C2=A0};
> > > =C2=A0
> > > +enum iio_backend_data_source {
> > > +	IIO_BACKEND_INTERNAL_CW, =20
> >=20
> > CW?=C2=A0 Either expand out what ever that is in definition of add a co=
mment
> > at least. =20
>=20
> Continuous wave :)

Spell that out.

>=20
> >  =20
> > > +	IIO_BACKEND_EXTERNAL, =20
> > What does external mean in this case? =20
>=20
> In this particular case comes from a DMA source (IP). I thought external =
to be more
> generic but if you prefer, I can do something like IIO_BACKEND_DMA?

So from another IP block?   For that to be reasonably 'generic' we'd need a=
 way
to known where it was coming from.

Now I remember advantage of reviewing on weekends - fewer replies during th=
e reviews :)

Jonathan


