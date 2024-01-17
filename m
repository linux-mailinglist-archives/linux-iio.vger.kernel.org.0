Return-Path: <linux-iio+bounces-1737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05719830BB3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 18:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146511C24835
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861B52262F;
	Wed, 17 Jan 2024 17:09:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF62260A;
	Wed, 17 Jan 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511350; cv=none; b=O5TeMnK67ba3TyA1uOzS1b6vpocPm0ztO1RiUNXfifpE3eHIRxK4moxBBpef9oOJbpvS6rAa6K5E3kArUB3M4OJ1Qhem6JV+ft12QZGkNauT3qVDGSlvpoUoNe6knVH09+9y6IciSRXQSPppKGlqMVew0VcDW1e5bsUnFCxWsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511350; c=relaxed/simple;
	bh=8rCLW97VTQgOPb7tCpZeyUmAMdm8HayFqAqnGmm+V5k=;
	h=Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy; b=oFkNBGxq61a7m+8MasWyycZpvqKZgl2RXRRqAXel+OFyqS+ebRaixnd7kclOng2s4/Y8U/822u+ygxYInnVvHmwB4QaX6BZ5t0V+2hQ59p4p7CosSRw3h0CIk7WU4U2NShIMQKks2tCdM1TGuAZxfUA5RinzKLOMU8oa1lVuQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TFXN10q6Vz6J9tl;
	Thu, 18 Jan 2024 01:06:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E097140C72;
	Thu, 18 Jan 2024 01:09:05 +0800 (CST)
Received: from localhost (10.48.153.213) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Jan
 2024 17:09:05 +0000
Date: Wed, 17 Jan 2024 17:09:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Julia
 Lawall" <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: Re: [PATCH 2/4] of: unittest: Use __free(device_node)
Message-ID: <20240117170904.00006549@Huawei.com>
In-Reply-To: <20240117170144.00004a43@Huawei.com>
References: <20240114165358.119916-1-jic23@kernel.org>
	<20240114165358.119916-3-jic23@kernel.org>
	<CAL_Jsq+vsXgBYtj66NG+3eZM-9gGw4QkU-bpn+JprAmG+UWmTQ@mail.gmail.com>
	<20240117170144.00004a43@Huawei.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 17 Jan 2024 17:01:44 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 16 Jan 2024 12:26:49 -0600
> Rob Herring <robh@kernel.org> wrote:
>=20
> > On Sun, Jan 14, 2024 at 10:54=E2=80=AFAM Jonathan Cameron <jic23@kernel=
.org> wrote: =20
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > A simple example of the utility of this autocleanup approach to
> > > handling of_node_put()
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/of/unittest.c | 10 +++-------
> > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > > index e9e90e96600e..b6d9edb831f0 100644
> > > --- a/drivers/of/unittest.c
> > > +++ b/drivers/of/unittest.c
> > > @@ -233,27 +233,23 @@ static void __init of_unittest_dynamic(void)
> > >
> > >  static int __init of_unittest_check_node_linkage(struct device_node =
*np)
> > >  {
> > > -       struct device_node *child;
> > > +       struct device_node *child __free(device_node) =3D NULL;   =20
> >=20
> > In another thread[1], it seems that initializing to NULL is bad form
> > according to the chief penguin. But as this is a refcounted pointer
> > rather than an allocation, IDK? =20
>=20
> I'm not sure the argument applies here. My understanding is it's not
> really about the =3D NULL, but more about where the __free(device_node) i=
s.
> The ordering of that cleanup wrt to other similar clean up is to do it
> in reverse order of declaration and in some cases that might cause troubl=
e.
>=20
> Here, the only way we could ensure the allocation was done at the right
> point and we didn't have that __free before it was set, would be to add
> variants of for_each_child_of_node() etc that did something like
>=20
> #define for_each_child_of_node_scoped(parent, child) \
> 	for (struct device_node *child __free(device_node) =3D \
> 	       of_get_next_child(parent, NULL); \
>              child !=3D NULL; \
> 	     child =3D of_get_next_child(parent, child))
>=20
> So that the child variable doesn't exist at all outside of the scope
> of the loop.
>=20
> I thought about proposing that style of solution but it felt more invasive
> than a simple __free() annotation.  I don't mind going that way though
> if you prefer it.

Note that if we did this I'd expect us to convert all current use case
and then we can probably do a global name change back to
for_each_child_of_node() as I can't see why we'd retain the other variant.
The rare (I think) case of breaking out of the loop whilst holding the
handle can be covered by pointer stealing anyway.

Jonathan

>=20
> Alternative is just to make sure the struct device_node * is always
> declared just before the for loop and not bother setting it to NULL
> (which is pointless anyway - it just felt fragile to not do so!)
>=20
> Jonathan
>=20
> >=20
> > Rob
> >=20
> > [1] https://lore.kernel.org/all/289c4af00bcc46e83555dacbc76f56477126d64=
5.camel@pengutronix.de =20
>=20


