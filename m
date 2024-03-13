Return-Path: <linux-iio+bounces-3475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B1F87A4C0
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 10:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215A71C21C5E
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE61BDD9;
	Wed, 13 Mar 2024 09:18:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E7A1B967;
	Wed, 13 Mar 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321527; cv=none; b=Amx0tSytuzdtXoX3RPLgEjQIO+W5kIFNH6Wnd1z7tmTfYmqpBHqFqG1YV5cyZez95U67wigKi+GfHpo8MJNouj+hF6Mwyd41/CeTNjl1/xj4vccWV2NRY4rN9edeH42cqs43GuRD2uWuQEEANDuT8RlnRspWyGcqZRjbwHTUysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321527; c=relaxed/simple;
	bh=RFkHpCQG/4jrrEhe9g+aKoOyktmLhxWFBxwKFFn7F14=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlyN46M4pUp4GsT9FgBSBRnDTLy/GZrAGJjvDW2RyfPLLRPDXACh3Fp+/j5HHhMwyY4OpSecoizTf2Qts1v579fbFvkwBkbjzBJf+ldrz87m1y+ehCJ31lWbzL65X4AgQiwVdKv9Army+Wrx0yETsO8wHrw4M2MKOEjW92rlFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TvlLC53FWz6G8xK;
	Wed, 13 Mar 2024 17:18:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 753FF140A35;
	Wed, 13 Mar 2024 17:18:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 13 Mar
 2024 09:18:27 +0000
Date: Wed, 13 Mar 2024 09:18:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Julia
 Lawall" <Julia.Lawall@inria.fr>, Peter Zijlstra <peterz@infradead.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, <marek.vasut@gmail.com>
Subject: Re: [RESEND PATCH v2 0/4] of: automate of_node_put() - new approach
 to loops.
Message-ID: <20240313091827.00000b7f@Huawei.com>
In-Reply-To: <CAL_JsqJ5XaxoL9=urL4ReVv5rhkkti5LN+nFGy1btyO2u7qjEw@mail.gmail.com>
References: <20240225142714.286440-1-jic23@kernel.org>
	<20240301223942.GA3179769-robh@kernel.org>
	<20240303115633.41128a62@jic23-huawei>
	<20240309173332.277fce7d@jic23-huawei>
	<CAL_JsqJ5XaxoL9=urL4ReVv5rhkkti5LN+nFGy1btyO2u7qjEw@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 12 Mar 2024 12:10:46 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Mar 9, 2024 at 10:33=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sun, 3 Mar 2024 11:56:33 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > =20
> > > On Fri, 1 Mar 2024 16:39:42 -0600
> > > Rob Herring <robh@kernel.org> wrote:
> > > =20
> > > > On Sun, Feb 25, 2024 at 02:27:10PM +0000, Jonathan Cameron wrote: =
=20
> > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > >
> > > > > Some discussion occured on previous posting.
> > > > > https://lore.kernel.org/linux-iio/20240223124432.26443-1-Jonathan=
.Cameron@huawei.com/
> > > > >
> > > > > Summary:
> > > > > * fwnode conversions should be considered when applying this
> > > > >   infrastructure to a driver. Perhaps better to move directly to
> > > > >   the generic FW property handling rather than improve existing
> > > > >   of specific code.
> > > > > * There are lots of potential places to use this based on detecti=
ons
> > > > >   from Julia's coccinelle scripts linked below.
> > > > >
> > > > > The equivalent device_for_each_child_node_scoped() series for
> > > > > fwnode will be queued up in IIO for the merge window shortly as
> > > > > it has gathered sufficient tags. Hopefully the precdent set there
> > > > > for the approach will reassure people that instantiating the
> > > > > child variable inside the macro definition is the best approach.
> > > > > https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@k=
ernel.org/
> > > > >
> > > > > v2: Andy suggested most of the original converted set should move=
 to
> > > > >     generic fwnode / property.h handling.  Within IIO that was
> > > > >     a reasonable observation given we've been trying to move away=
 from
> > > > >     firmware specific handling for some time. Patches making that=
 change
> > > > >     to appropriate drivers posted.
> > > > >     As we discussed there are cases which are not suitable for su=
ch
> > > > >     conversion and this infrastructure still provides clear benef=
its
> > > > >     for them.
> > > > >
> > > > > Ideally it would be good if this introductory series adding the
> > > > > infrastructure makes the 6.9 merge window. There are no dependenc=
ies
> > > > > on work queued in the IIO tree, so this can go via devicetree
> > > > > if the maintainers would prefer. I've had some off list messages
> > > > > asking when this would be merged, as there is interest in building
> > > > > on it next cycle for other parts of the kernel (where conversion =
to
> > > > > fwnode handling may be less appropriate). =20
> > > >
> > > > I'll let you take it. For the series:
> > > >
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > >
> > > > I've got some drivers/of/ conversions too, but they are probably ne=
xt
> > > > cycle at this point.
> > > >
> > > > Rob =20
> > >
> > > Thanks Rob,
> > >
> > > Whether this makes it for this cycle is probably dependent on whether
> > > Linus does decide to do got to rc8 as hinted at as a possibility
> > > + whether Greg feels comfortable taking these through his tree
> > > (char-misc is the normal path for IIO).  I know various people
> > > are hoping this series makes it, but if doesn't we can do an immutable
> > > tree early next cycle (though obviously that may reduce speed of adop=
tion).
> > >
> > > We are discussing the equivalent pull request for the fwnode version =
here:
> > >
> > > https://lore.kernel.org/linux-iio/2024030239-gift-cabdriver-266b@greg=
kh/T/#m87e7208820ebf6416a77a2973773b65a087b4796
> > >
> > > I've optimistically applied this series to my togreg-cleanup branch
> > > and merged that into the togreg branch of iio.git for linux-next to p=
ick up.
> > > =20
> >
> > Greg, would you consider a last minute pull request for these, or picki=
ng them up
> > directly?  It would be helpful for Rob's follow ups and the work Julia =
is doing
> > with coccinelle and automating of locating cases to apply this approach.
> >
> > If the device_for_each_child_node_scoped() series is fine this is almos=
tly
> > exactly the same thing for the device tree specific case. Not sure what=
 your
> > plans are for that pull request so I might be jumping the gun.
> >
> > If not (and assuming the generic property version does make it in) I'll=
 do
> > an immutable branch based on rc1 so that others can build on this via t=
hat.
> > Fiddlier solution for everyone but given how late we are, perhaps the w=
iser
> > one. =20
>=20
> I'm happy to pick up the first 3 patches for 6.9 if you want.

Thanks Rob, that would be great.

Jonathan

>=20
> Rob
>=20


