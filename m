Return-Path: <linux-iio+bounces-10245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F5991EA3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5E12820EF
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0440EACD;
	Sun,  6 Oct 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfSfICUa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53948101C4;
	Sun,  6 Oct 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728222539; cv=none; b=Wf0zX0kNymO5R1hFHqwt9HSh0y64g3FPcp0KuZK/LsefYUuBXs36uY8IaM4Gh12ZvdUJI9FrEGqKxQb5WOhlVMYSvDMMNqLxbdkWBNwWANI3YDBN0YabVgBRp/hewnEuB0HWZkF8byMv/BuempAz42XzYljp71zmB7eQk2MMySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728222539; c=relaxed/simple;
	bh=jPvFiYmTuPHm4yfpt7Nb8jNqmAdmYsNgW4P7C8U0omo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d37/pXDIGOqz94tkYgrMIgUpvEcO5yMHBFKauJOt+qJlgKAlOUMk4yz/2PVsF3rjEmhgmz1b8tl7N5pEOEqaIkYMqkRbA74efUYp+Ag8mOIzFNbpsPsqREjMPtivHbffAtooVskRq4UlyfsS5X4l8qrfb47jxxS6FOnCwDk8Txw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfSfICUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924FEC4CEC5;
	Sun,  6 Oct 2024 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728222537;
	bh=jPvFiYmTuPHm4yfpt7Nb8jNqmAdmYsNgW4P7C8U0omo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfSfICUasncD35QRb7Y9QSXPgl4DomSTwtERRpY5kIOUNqcJYiJKVPVomQVtUBKlf
	 KDDjtx/XhQBbCP0wkIOxj8IWw0B+lHb5vqZuJqqeBZYKUK3fcMe4jh0zwjGeXylluv
	 HmmqoZYc8R8VKsx9HcztQf6Fmzz91nq//EFMl1Ra9T7Y/aOQnerROML8+cG7KhmJ20
	 TQEHfTTn93ATLpGLSqy6TAId0ZENGIKubWMI09l/khEQMLnEEF53kmGDCClwYBki6O
	 JbsNLZ9aibxdMG0Ynds/KCuETJLsCXc36/Io5TkA/8unV4JWRFfUiFjbsk5gGsvNdb
	 cVzBrmS4qzSlA==
Date: Sun, 6 Oct 2024 14:48:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mihail Chindris
 <mihail.chindris@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 06/11] iio: backend: extend features
Message-ID: <20241006144841.08fb2102@jic23-huawei>
In-Reply-To: <ihkd45xlg3hejchdw6ksmuzoxu3cazmx5rd4d4zca7xl4rfcrd@krururfftdlx>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
	<20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-6-ceb157487329@baylibre.com>
	<451aaf360690cf60704e8a2880e98501156bda73.camel@gmail.com>
	<ihkd45xlg3hejchdw6ksmuzoxu3cazmx5rd4d4zca7xl4rfcrd@krururfftdlx>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Oct 2024 15:45:21 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Nuno,
>=20
> On 04.10.2024 14:54, Nuno S=C3=A1 wrote:
> > On Thu, 2024-10-03 at 19:29 +0200, Angelo Dureghello wrote: =20
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Extend backend features with new calls needed later on this
> > > patchset from axi version of ad3552r.
> > >=20
> > > The follwoing calls are added:
> > >=20
> > > iio_backend_ddr_enable
> > > 	enable ddr bus transfer
> > > iio_backend_ddr_disable
> > > 	disable ddr bus transfer
> > > iio_backend_buffer_enable
> > > 	enable buffer
> > > iio_backend_buffer_disable
> > > 	disable buffer
> > > iio_backend_data_transfer_addr
> > > 	define the target register address where the DAC sample
> > > 	will be written.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/industrialio-backend.c | 79 +++++++++++++++++++++++=
+++++++++++++++
> > > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 17 ++++++++
> > > =C2=A02 files changed, 96 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industr=
ialio-
> > > backend.c
> > > index 20b3b5212da7..d5e0a4da761e 100644
> > > --- a/drivers/iio/industrialio-backend.c
> > > +++ b/drivers/iio/industrialio-backend.c
> > > @@ -718,6 +718,85 @@ static int __devm_iio_backend_get(struct device =
*dev, struct
> > > iio_backend *back)
> > > =C2=A0	return 0;
> > > =C2=A0}
> > > =C2=A0
> > > +/**
> > > + * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) =
mode
> > > + * @back: Backend device
> > > + *
> > > + * Enable DDR, data is generated by the IP at each front (raising an=
d falling)
> > > + * of the bus clock signal.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_ddr_enable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, ddr_enable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_enable, IIO_BACKEND);
> > > +
> > > +/**
> > > + * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate=
) mode
> > > + * @back: Backend device
> > > + *
> > > + * Disable DDR, setting into SDR mode (Single Data Rate).
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_ddr_disable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, ddr_disable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
> > > +
> > > +/**
> > > + * iio_backend_dma_stream_enable - Enable iio buffering
> > > + * @back: Backend device
> > > + *
> > > + * Enabling sending the dma data stream over the bus.
> > > + * bus interface.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_dma_stream_enable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, dma_stream_enable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_dma_stream_enable, IIO_BACKEND);
> > > +
> > > +/**
> > > + * iio_backend_dma_stream_disable - Disable iio buffering
> > > + * @back: Backend device
> > > + *
> > > + * Disable sending the dma data stream over the bus.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_dma_stream_disable(struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, dma_stream_disable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_dma_stream_disable, IIO_BACKEND);
> > > + =20
> >=20
> > I'm not sure if this is what Jonathan was suggesting... Ate least I don=
't really
> > agree with it. I mean, yes, this is about buffering and to start receiv=
ing (or
> > sending) a stream of data. But AFAICT, it might have nothing to do with=
 DMA. Same as
> > .request_buffer() - It's pretty much always a DMA one but we should not=
 take that for
> > granted.

Agreed. The stream bit works, the DMA is more tenuous.  Maybe *data_stream_=
enable()
is generic enough.

> >=20
> > So going back to the RFC [1], you can see I was suggesting something li=
ke struct
> > iio_buffer_setup_ops. Maybe just add the ones we use for now? So that w=
ould
> > be.buffer_postenable() and .buffer_predisable(). Like this, it should b=
e obvious the
> > intent of the ops.
> >  =20
> ok, thanks,
>=20
> so something as :
>=20
> struct iio_backend_setup_ops {
> 	int (*buffer_postenable)(struct iio_backend *back);
> 	int (*buffer_predisable)(struct iio_backend *back);

Hmm. Maybe.  My issue with the original naming was the lack of clarify of
what it actually meant.  I'm not sure this helps though in some cases we
do put similar calls in the postenable callback (ones that start the
data flow) so at least it's consistent with that.

Jonathan
> };
>=20
> struct iio_backend_ops {
> 	struct iio_backend_setup_ops setup_ops;
>=20
> ?
>=20
> > - Nuno S=C3=A1
> >=20
> >  =20
>=20


