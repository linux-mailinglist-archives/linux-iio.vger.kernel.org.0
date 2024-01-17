Return-Path: <linux-iio+bounces-1740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FC2830DCE
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 21:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A52B22D05
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 20:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744F624B24;
	Wed, 17 Jan 2024 20:14:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D322EF5;
	Wed, 17 Jan 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522446; cv=none; b=ULmwcFPJ0IzzEYSSK2DR1t24t81B4J/Muio3l6OkeWYKEx7HJ30EWs2pArHPdLNe673wBzvN6VIilMpw1GAgRMul37FGlSoVCYO2U00dxVuPJoZjJl3La2nQolYhU4hNxmM9Qf4fWP5Hx4oN5W7zPqFDumJnahiKTOB6duDknpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522446; c=relaxed/simple;
	bh=GpvNvnhLXozc6WP27ixII0ay/K2GATUmfZ0U1gFMPFI=;
	h=Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy; b=PlLxf3CIDRheffO0f5qWZdAhTbnolNpX/cs6SIyXIJXlmPQwSyEBvLpzhTtK0kPoasK+rpxlPKUvBI1zwnbQRHgnZ0j72hT18T41ryLU86+FrBVTFYLhX2YFv2Q0USBnPCbccdr607ofB0oJy0tWOccwlfNq5Y0r2aUk/794CPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TFcTF4ySbz6K8sR;
	Thu, 18 Jan 2024 04:11:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CD96140CF4;
	Thu, 18 Jan 2024 04:14:00 +0800 (CST)
Received: from localhost (10.48.153.213) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Jan
 2024 20:13:59 +0000
Date: Wed, 17 Jan 2024 20:13:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Julia
 Lawall" <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>
Subject: Re: [PATCH 2/4] of: unittest: Use __free(device_node)
Message-ID: <20240117201356.00007535@Huawei.com>
In-Reply-To: <20240117194743.GA2888190-robh@kernel.org>
References: <20240114165358.119916-1-jic23@kernel.org>
	<20240114165358.119916-3-jic23@kernel.org>
	<CAL_Jsq+vsXgBYtj66NG+3eZM-9gGw4QkU-bpn+JprAmG+UWmTQ@mail.gmail.com>
	<20240117170144.00004a43@Huawei.com>
	<20240117194743.GA2888190-robh@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 17 Jan 2024 13:47:43 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jan 17, 2024 at 05:01:44PM +0000, Jonathan Cameron wrote:
> > On Tue, 16 Jan 2024 12:26:49 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >  =20
> > > On Sun, Jan 14, 2024 at 10:54=E2=80=AFAM Jonathan Cameron <jic23@kern=
el.org> wrote: =20
> > > >
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > A simple example of the utility of this autocleanup approach to
> > > > handling of_node_put()
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >  drivers/of/unittest.c | 10 +++-------
> > > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > > > index e9e90e96600e..b6d9edb831f0 100644
> > > > --- a/drivers/of/unittest.c
> > > > +++ b/drivers/of/unittest.c
> > > > @@ -233,27 +233,23 @@ static void __init of_unittest_dynamic(void)
> > > >
> > > >  static int __init of_unittest_check_node_linkage(struct device_nod=
e *np)
> > > >  {
> > > > -       struct device_node *child;
> > > > +       struct device_node *child __free(device_node) =3D NULL;   =
=20
> > >=20
> > > In another thread[1], it seems that initializing to NULL is bad form
> > > according to the chief penguin. But as this is a refcounted pointer
> > > rather than an allocation, IDK? =20
> >=20
> > I'm not sure the argument applies here. My understanding is it's not
> > really about the =3D NULL, but more about where the __free(device_node)=
 is.
> > The ordering of that cleanup wrt to other similar clean up is to do it
> > in reverse order of declaration and in some cases that might cause trou=
ble. =20
>=20
> Rereading Linus' reply again, I think it is more that you see how=20
> something is freed right where it is allocated, and the way to do that=20
> is the allocation and declaration are together.

Ok.  Maybe both issues surfaced in different threads.  Both are valid points
I've seen made about this stuff.

>=20
> > Here, the only way we could ensure the allocation was done at the right
> > point and we didn't have that __free before it was set, would be to add
> > variants of for_each_child_of_node() etc that did something like
> >=20
> > #define for_each_child_of_node_scoped(parent, child) \ =20
>=20
> Note that you don't need child here except to define the name of child.=20
> Otherwise, the variable name you need for the loop is implicit.

Agreed.

> OTOH,=20
> defining a name which has no type defined anywhere in the user function=20
> isn't great for readability either.

Agreed it's not great to have the type missing, but I couldn't
think of a better option. So I think if we want these toys and to not
have it as a 2 part statement that's what we get.

>=20
> WRT the whole renaming, it might be better to keep 'scoped' in the name=20
> so that it is obvious how child needs to be handled. Or is the compiler=20
> smart enough to catch any case of doing it wrong?

I'm not sure we have variable name shadowing detection turned on.
If that was on we should see a warning on someone not realizing there
is a local scoped version.  I'm fine with keeping the name.
>=20
> > 	for (struct device_node *child __free(device_node) =3D \
> > 	       of_get_next_child(parent, NULL); \
> >              child !=3D NULL; \
> > 	     child =3D of_get_next_child(parent, child))
> >=20
> > So that the child variable doesn't exist at all outside of the scope
> > of the loop.
> >=20
> > I thought about proposing that style of solution but it felt more invas=
ive
> > than a simple __free() annotation.  I don't mind going that way though
> > if you prefer it. =20
>=20
> My only preference currently is to not get yelled at. :)

Always nice ;)

>=20
> > Alternative is just to make sure the struct device_node * is always
> > declared just before the for loop and not bother setting it to NULL
> > (which is pointless anyway - it just felt fragile to not do so!) =20
>=20
> Would the compiler know to avoid invoking __free if exiting before the=20
> variable is set?

If it's declared just before the loop, there wouldn't be such a path
as the init condition of the loop sets it to a valid handle or NULL.

I looked at about the first half (alphabetical order) of the 127 files
with for_each_child_of_node().

Vast majority are easily converted.  I think I counted 4 possible bugs
that need a closer look and a bunch were care would be needed (typically
steal the pointer for a return).

Happy to do a small set of them and see what it looks like if you think
that is a promising direction to try?

+CC Peter Zijlstra as person most likely to have seen similar discussions
or provide input based on his own cleanup.h conversions.

Jonathan

>=20
> Rob
>=20


