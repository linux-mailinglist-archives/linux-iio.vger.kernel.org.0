Return-Path: <linux-iio+bounces-27664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE45D17D97
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 11:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C3613004EF9
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A534343D7F;
	Tue, 13 Jan 2026 10:01:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD2FCA52;
	Tue, 13 Jan 2026 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298465; cv=none; b=g0uKYwgOhegDPrPemJIAqwOGwxyilLS+y7dw7kAOnak4SJ4IPaH/1dKz5NqERvZk77lyeZV2HgE++XJWbKjl+DRK6Phga3WsK8yg6s3x3/+d7hLcRlN0UOx8rqBujXUEMhJGYoWTTw+w3Dq5wUH6sjhZ+4KWmH2btC4eDMM9ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298465; c=relaxed/simple;
	bh=wVcWp/bbxzZ7ey9eorvF34tO+nvMEpMqXLNewcqvwTg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWjeb+dJXcLfUKIhgypYFo66grynzFIUqNFGM/dyGqA3OgD+ZpmIN22whu7up4Cwmg9njTwLyPr8fXNZQ991v7eZsypJ9mlkjYY/tkiEv0WwlW24hCiSL26EqtKtjt7bOL7HKcnzzhdMCEo0kmFG2IZmNOsp9CyookmQ2x+vA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dr4WD56W5zJ468F;
	Tue, 13 Jan 2026 18:00:40 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 870DC40563;
	Tue, 13 Jan 2026 18:00:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 13 Jan
 2026 10:00:52 +0000
Date: Tue, 13 Jan 2026 10:00:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Tomas Melin <tomas.melin@vaisala.com>
CC: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, "Nuno
 Sa" <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, "David
 Lechner" <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
Message-ID: <20260113100051.0000077a@huawei.com>
In-Reply-To: <51085acb-91c9-43ad-8f7e-94f1e9c995ed@vaisala.com>
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	<20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
	<20251221200014.29af7df8@jic23-huawei>
	<356a75b0-dc3e-4d10-a827-1af3b4ab638f@vaisala.com>
	<997f9d13f44031170a4518abf23ee6806d526054.camel@gmail.com>
	<20260111114109.28b01266@jic23-huawei>
	<d36d38b2ae691371c653927fcba310bc525e0aac.camel@gmail.com>
	<51085acb-91c9-43ad-8f7e-94f1e9c995ed@vaisala.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 13 Jan 2026 09:47:46 +0200
Tomas Melin <tomas.melin@vaisala.com> wrote:

> Hi,
>=20
> On 12/01/2026 15:21, Nuno S=E1 wrote:
> > On Sun, 2026-01-11 at 11:41 +0000, Jonathan Cameron wrote: =20
> >> On Mon, 05 Jan 2026 14:57:02 +0000
> >> Nuno S=E1 <noname.nuno@gmail.com> wrote:
> >> =20
> >>> On Mon, 2026-01-05 at 13:06 +0200, Tomas Melin wrote: =20
> >>>> Hi,
> >>>>
> >>>> On 21/12/2025 22:00, Jonathan Cameron wrote:=A0  =20
> >>>>> On Tue, 16 Dec 2025 11:40:06 +0000
> >>>>> Tomas Melin <tomas.melin@vaisala.com> wrote:
> >>>>> =A0  =20
> >>>>>> Not all users can or want to use the device with an iio-backend.
> >>>>>> For these users, let the driver work in standalone mode, not coupl=
ed
> >>>>>> to the backend or the services it provides.
> >>>>>>
> >>>>>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>=A0  =20
> >>>>> Hi Tomas,
> >>>>> =A0  =20
> >>>>>> =A0static int ad9467_probe(struct spi_device *spi)
> >>>>>> @@ -1352,21 +1361,25 @@ static int ad9467_probe(struct spi_device =
*spi)
> >>>>>> =A0	indio_dev->channels =3D st->info->channels;
> >>>>>> =A0	indio_dev->num_channels =3D st->info->num_channels;
> >>>>>> =A0
> >>>>>> +	/* Using a backend is optional */=A0  =20
> >>>>>
> >>>>> I'll largely defer to Nuno on the backend aspects but I would like a
> >>>>> lot more than a statement that it is optional in this comment.
> >>>>> At least something about where the data goes and what a real system
> >>>>> that didn't provide a backend would look like etc.=A0  =20
> >>>>
> >>>> Having the backend as optional is about flexibility to incorporate t=
hese
> >>>> devices as fits best with the system. The current backend approach is
> >>>> pretty much dictated with how the ADI default backend is implemented.
> >>>> These devices are fully configurable via SPI interface so the backend
> >>>> doesn't necessarily need to be anything fancy or even configurable.
> >>>>
> >>>> So there is atleast two use cases that promote the optional iio-back=
end
> >>>> approach
> >>>> =A0- simple backend that is not configurable, no need for a dedicated
> >>>> driver. The backend (FPGA) sits and waits for data and handles it wh=
en
> >>>> it arrives=A0  =20
> >>>
> >>> Agree on the above. Ideally we could have some dummy backend for the =
above but
> >>> it is not really easy/maintainable to have it. =20
> >>
> >> When we say the backend needs no driver, where does the data end up?
> >> Is the idea that it goes into some processing pipeline and sent to
> >> some external path that we have no visibility of? i.e. We configure the
> >> data capture in Linux but never see the data? =20
> >=20
> > Yes, that's also my assumption about Tomas's usecase. =20
>=20
> The data becomes available to user space but there is currently no
> immediate need or natural place to create a separate instance to
> function as a backend device.
>=20
> But that being said, I'm leaning towards thinking that perhaps a
> minimalistic backend should always be registered after all. That would
> keep the idea of the backend always existing intact.
> But since the backend can be missing a lot of the features defined for
> the current ADI backend, capability handling would need to be added to
> the backend framework to make it functional.
>=20
> Looking into how this could be achieved with reasonable impact, I have
> tried to identify capabilities that we could add for starters, and then
> have the frontend behave differently depending on what features are prese=
nt.
>=20
> Something like this (added to backend_info),
> .caps =3D IIO_BACKEND_CAP_TEST_PATTERNS |  --> backend patterns are avail.
> 	IIO_BACKEND_CAP_BUFFERING |  --> backend has buffering cap.
> 	IIO_BACKEND_CAP_CALIBRATION, --> backend supports calibration
>=20
> If you think this seems reasonable, I can implement something like this
> and post a new version for comments.
>=20
Sounds good to me, but I defer to Nuno for backend stuff!

Thanks,

Jonathan

> Thanks,
> Tomas
>=20
>=20
>=20
> >=20
> > - Nuno S=E1 =20
>=20
>=20
>=20


