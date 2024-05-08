Return-Path: <linux-iio+bounces-4873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316AB8BFC1A
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EC21C21E4E
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE565823B0;
	Wed,  8 May 2024 11:32:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8B620300;
	Wed,  8 May 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167963; cv=none; b=MAoFNxg9BQpbWXX3MfxIYH0FHm9NYEBTW+uHzGz8C7DgLr1PqpuNxCf/WtmiPqmVMMnY51X/f1oiYLIhucChjxtNczIDwJ8bzUDGjxld/p/elJfdMoua4avzCtmWkRW6k2T8I4ofJjF2ATtdrvmBt6X8mN8iZZCsqQOQ7Fa3uAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167963; c=relaxed/simple;
	bh=JjcJh0OWUmjImQpwnItg5E36J9yZ7XWHg4/bM6ecvWs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQ+yFPpkZ3SaCZLeXRnU7q3OobyFDH2/SWNEV2QcueRVZAwOwmYoEKmDBwJl8pTLjYikCpNA7hVRZIIRQmk1GF9SBKTqKMnrPp7EZGBkM/BrMBvu2WXd1Eb6s7ksRzur0bnQhputBMkIt69i/i8+mCmmyv9GG4EuHOmfeUqT+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZCfd1V1Qz6K9J9;
	Wed,  8 May 2024 19:32:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 630BA140B33;
	Wed,  8 May 2024 19:32:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 8 May
 2024 12:32:37 +0100
Date: Wed, 8 May 2024 12:32:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<noname.nuno@gmail.com>, Julien Stephan <jstephan@baylibre.com>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 10/10] iio: adc: ad7380: add support for
 resolution boost
Message-ID: <20240508123237.00003a8a@Huawei.com>
In-Reply-To: <CAMknhBHOXaff__QyU-wFSNNENvs23vDX5n_ddH-Dw3s6-sQ9sg@mail.gmail.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	<20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
	<a04d8015ea1606ce1eca86f7eaaa85a1c1b46d7a.camel@gmail.com>
	<20240506144616.0b90664b@jic23-huawei>
	<CAMknhBHOXaff__QyU-wFSNNENvs23vDX5n_ddH-Dw3s6-sQ9sg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 6 May 2024 09:44:25 -0500
David Lechner <dlechner@baylibre.com> wrote:

> FYI, Julien is AFK for a bit so I'll try to respond to the non-trivial co=
mments.
>=20
> On Mon, May 6, 2024 at 8:46=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Mon, 06 May 2024 10:55:46 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > =20
> > > On Wed, 2024-05-01 at 16:55 +0200, Julien Stephan wrote: =20
> > > > ad738x chips are able to use an additional 2 bits of resolution when
> > > > using oversampling. The 14-bits chips can have up to 16 bits of
> > > > resolution and the 16-bits chips can have up to 18 bits of resoluti=
on.
> > > >
> > > > In order to dynamically allow to enable/disable the resolution boost
> > > > feature, we have to set iio realbits/storagebits to the maximum per=
 chips.
> > > > This means that for iio, data will always be on the higher resoluti=
on
> > > > available, and to cope with that we adjust the iio scale and iio of=
fset
> > > > depending on the resolution boost status.
> > > >
> > > > The available scales can be displayed using the regular _scale_avai=
lable
> > > > attributes and can be set by writing the regular _scale attribute.
> > > > The available scales depend on the oversampling status.
> > > >
> > > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > >
> > > > ---
> > > >
> > > > In order to support the resolution boost (additional 2 bits of reso=
lution)
> > > > we need to set realbits/storagebits to the maximum value i.e :
> > > >   - realbits =3D 16 + 2 =3D 18, and storagebits =3D 32 for 16-bits =
chips
> > > >   - realbits =3D 14 + 2 =3D 16, and storagebits =3D 16 for 14-bits =
chips
> > > >
> > > > For 14-bits chips this does not have a major impact, but this
> > > > has the drawback of forcing 16-bits chip users to always use 32-bits
> > > > words in buffers even if they are not using oversampling and resolu=
tion
> > > > boost. Is there a better way of implementing this? For example
> > > > implementing dynamic scan_type?
> > > > =20
> > >
> > > Yeah, I don't think it's that bad in this case. But maybe dynamic sca=
n types is
> > > something we may need at some point yes (or IOW that I would like to =
see supported
> > > :)). We do some ADCs (eg: ad4630) where we use questionably use FW pr=
operties to set
> > > a specific operating mode exactly because we have a different data la=
yout (scan
> > > elements) depending on the mode. =20
> >
> > Yeah. Fixed scan modes were somewhat of a bad design decision a long ti=
me back.
> > However, the big advantage is that it got people to think hard about wh=
ether it is
> > worth supporting low precision modes. For slow devices it very rarely i=
s and
> > forcing people to make a decision and the advantage we never supported
> > low precision on those parts.
> >
> > Having said that there are good reasons for dynamic resolution changing
> > (the main one being the storage case you have here) so I'd be happy to
> > see some patches adding it. It might be easier than I've always thought
> > to bolt on.
> >
> > This and inkernel event consumers have been the two significant features
> > where I keep expecting it to happen, but every time people decide they =
really
> > don't care enough to make them work :(
> > =20
>=20
> Supposing we knew someone willing and able :-) ...
>=20
> Do you have any specific requirements for how dynamic resolution
> changing should work? Any particular sticky points we should watch out
> for?
>=20
> I'm assuming this would just affect the bufferY/*_type attributes,
> i.e. if you write a channel scale attribute to change the resolution,
> then the scan_type info may change and the bufferY/*_type would need
> to be read again.

I think you'd use those sysfs files for the control as well.  So write
to the *_type for a channel. That might well effect a bunch of other
channels.

Another interface would perhaps be more confusing than anything and
something simple won't be specific enough as we are sure to get a
device with multiple channels only some of which have variable scale.

Definitely don't allow such a write when buffered capture is going on
as that would be chaos.   Also for this one we'd want control over
the file attributes for those files so they are only writeable if
we support changing this (which is rare).

Also need a way of knowing what values are available so probably
*_type_available - the presence of that also indicating if the scale
can be changed.

J


>=20


