Return-Path: <linux-iio+bounces-3591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B4287EAA4
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 15:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A111F21CBF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E804D5A2;
	Mon, 18 Mar 2024 14:16:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D8D4CB30
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771364; cv=none; b=HymMKqijhmhUwAq9hOLkyAqifI2Xd7m8FiUTkj7Knei+cXxhp0vWHuIAewlGeUmheeffCF0pch5OjHu+WhhNr3Pt+1Uj0O6sKxeRoNOGCJZ8bF4LUQzmNGJjhwrDLPmvgpOzSLeZg+WCIqEcQWF5NFPAlEXSFQyYNtmCA+Ms7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771364; c=relaxed/simple;
	bh=z+pQGMwNwU1U37wYo50BFC7h53G1oNxdRNdMLy2GZPo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuKT+Mj/LyRFFbVaPmsZ2Ofw5vEmGmXpJ/U/cHanx/Jy9AjvyHzzvrDBkl0pVbLmV3LVb6CACMRBvbFB9xSEY+WQd2G6bHmcNbldAwWWle6Ck5ohVtTeZ33QnVatAI21xP0IYQ529LncViNRgkipfMc3KhuUhhKuIRrJ5E3PX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TyxcJ20sCz6K9XJ;
	Mon, 18 Mar 2024 22:11:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 293EF1408F9;
	Mon, 18 Mar 2024 22:15:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 14:15:58 +0000
Date: Mon, 18 Mar 2024 14:15:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Nuno Sa <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 2/4] iio: trigger: move to the cleanup.h magic
Message-ID: <20240318141557.00006a3b@Huawei.com>
In-Reply-To: <CAHp75VcQbjSqvtDxcoAFkC84560UuZ1xwDu+kdpXHu9MKXuHWA@mail.gmail.com>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	<20240229-iio-use-cleanup-magic-v3-2-c3d34889ae3c@analog.com>
	<ZfXz6E086KPWUn8Q@surfacebook.localdomain>
	<20240318123320.000030d3@Huawei.com>
	<CAHp75VcQbjSqvtDxcoAFkC84560UuZ1xwDu+kdpXHu9MKXuHWA@mail.gmail.com>
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

On Mon, 18 Mar 2024 15:12:20 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Mar 18, 2024 at 2:33=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Sat, 16 Mar 2024 21:32:56 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > Thu, Feb 29, 2024 at 04:10:26PM +0100, Nuno Sa kirjoitti: =20
>=20
> ...
>=20
> > > > -   ret =3D bitmap_find_free_region(trig->pool,
> > > > -                                 CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> > > > -                                 ilog2(1)); =20
> > > =20
> > > > +           ret =3D bitmap_find_free_region(trig->pool,
> > > > +                                         CONFIG_IIO_CONSUMERS_PER_=
TRIGGER,
> > > > +                                         ilog2(1)); =20
> > >
> > > Despite being in the original code, this is funny magic constant... =
=20
> >
> > Not that magic, build time config variable to avoid adding complexity
> > of dynamic expansion of various structures. We could have picked a big
> > number but someone will always want a bigger one and from what I recall
> > actually make it expandable was nasty to do.  Been a long time, though
> > so I'm open to patches that get rid of this in favor of a dynamic solut=
ion. =20
>=20
> I didn't get you, sorry. Logarithm (by any base) from 1 is 0. Writing
> it as arithmetic expression seems funny to me.

Ah. I was looking at the line above ;)

That one is because it lines up with the docs for bitmap_find_free_region()
Last parameter is order, but seems more natural to express it in number of =
bits
hence the 1 rather that superficially looking like we are asking for
a region of length 0.


>=20


