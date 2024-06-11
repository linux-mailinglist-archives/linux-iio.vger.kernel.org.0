Return-Path: <linux-iio+bounces-6181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C8B904237
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 19:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EA428B2D9
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270347F4A;
	Tue, 11 Jun 2024 17:14:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A6F4779E;
	Tue, 11 Jun 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126054; cv=none; b=VR55zCYlFqMnPLIpz6VOd+1r/JZYZmYSXKeC8B2SBxxaTWhAZqTZAO01Dy8NGQLi9vepXAaNzOomITOUeXOkjaYXgJ8g+EFwc3gXMKwL8AQDJLax5ErGK7CgYakn+ktN3iARBgQd9j9IIo13JYfuwpRcGCb7Gbxy5TPF8fmexHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126054; c=relaxed/simple;
	bh=IxlRiz3TtmeLkmRBSx1JGNu4U8ENYe6tAfBUPxcJBgQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYjNi5TTOrlXdMggcfOpHBwNzhWo5gFElQ2RmusNICuXpzB5qi74HrvINSqvHB/Cc5wjRVm9JQbyubs8Dgf9kFHYsO9mqjJn/ZLBOWrqXTKKyhxIfJ3AA31BCzdt2eShexOdXmI2gPruiW+Pd5U6qhZ47sQ96Lhd7b7wigOZzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VzFXF1SGsz6J9yR;
	Wed, 12 Jun 2024 01:09:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 14509140516;
	Wed, 12 Jun 2024 01:14:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Jun
 2024 18:14:08 +0100
Date: Tue, 11 Jun 2024 18:14:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Mudit Sharma
	<muditsharma.info@gmail.com>, <lars@metafoo.de>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <robh@kernel.org>, <ivan.orlov0322@gmail.com>,
	<javier.carrasco.cruz@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: light: ROHM BH1745 colour sensor
Message-ID: <20240611181407.00003f61@Huawei.com>
In-Reply-To: <CANhJrGM9czj0RL3OLCgRHEKc2QOjG9P0AZTrZxvYUk65TCpHRg@mail.gmail.com>
References: <20240606162948.83903-1-muditsharma.info@gmail.com>
	<20240606162948.83903-2-muditsharma.info@gmail.com>
	<20240608172227.17996c75@jic23-huawei>
	<CANhJrGM9czj0RL3OLCgRHEKc2QOjG9P0AZTrZxvYUk65TCpHRg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 10 Jun 2024 08:58:44 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> la 8. kes=E4k. 2024 klo 19.22 Jonathan Cameron (jic23@kernel.org) kirjoit=
ti:
> >
> > On Thu,  6 Jun 2024 17:29:42 +0100
> > Mudit Sharma <muditsharma.info@gmail.com> wrote:
> > =20
> > > Add support for BH1745, which is an I2C colour sensor with red, green,
> > > blue and clear channels. It has a programmable active low interrupt
> > > pin. Interrupt occurs when the signal from the selected interrupt
> > > source channel crosses set interrupt threshold high or low level.
> > >
> > > This driver includes device attributes to configure the following:
> > > - Interrupt pin latch: The interrupt pin can be configured to
> > >   be latched (until interrupt register (0x60) is read or initialized)
> > >   or update after each measurement.
> > > - Interrupt source: The colour channel that will cause the interrupt
> > >   when channel will cross the set threshold high or low level.
> > >
> > > This driver also includes device attributes to present valid
> > > configuration options/values for:
> > > - Integration time
> > > - Interrupt colour source
> > > - Hardware gain
> > > =20
>=20
> > > +
> > > +#define BH1745_CHANNEL(_colour, _si, _addr)                         =
          \
> > > +     {                                                              =
       \
> > > +             .type =3D IIO_INTENSITY, .modified =3D 1,              =
           \
> > > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),        =
         \
> > > +             .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_HARDWAR=
EGAIN) | \ =20
> >
> > Provide _SCALE instead of HARDWAREGAIN
> > As it's an intensity channel (and units are tricky for color sensors gi=
ven
> > frequency dependence etc) all you need to do is ensure that if you halve
> > the _scale and measure the same light source, the computed
> > _RAW * _SCALE value remains constant. =20
>=20
> ...Which is likely to cause also the integration time setting to
> impact the SCALE.
>=20
> You may or may not want to see the GTS-helpers
> (drivers/iio/industrialio-gts-helper.c) - which have their own tricky
> corners. I think Jonathan once suggested to me to keep the
> HARDWAREGAIN as a read-only attribute to ease seeing what is going on.
> For the last couple of days I've been reworking the BU27034 driver to
> work with the new sensor variant - and I can definitely see the value
> of the read-only HARDWAREGAIN when we have per channel gain settings +
> integration time setting which all contribute to the scale...

I'm wondering if that was good advice, but it's definitely better
than letting userspace control the gain and integration time separately
as there is no sensible way to know how to control that beyond -
it's a bit dark and I forgot I can change the integration time,
crank up the gain!

>=20
>=20
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>=20
> ~~ When things go utterly wrong vim users can always type :help! ~~
>=20
> Discuss - Estimate - Plan - Report and finally accomplish this:
> void do_work(int time) __attribute__ ((const));
>=20


