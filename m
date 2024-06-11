Return-Path: <linux-iio+bounces-6183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E964B904269
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 19:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996881F23269
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524334C634;
	Tue, 11 Jun 2024 17:29:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC74D8AB;
	Tue, 11 Jun 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126956; cv=none; b=s9J2x0cOVu3dxBIaVmbPgz30wgcfWbIeJWaT5uwrKnP+PhQ++wSoNg0Chemf3zPYyf8QSFjHZ/2FhjqaRVPEOg8HD7nPfEGqh7oKWLKMSKm4UuCrjVWMfsAn3aBgXOppWupM4TtbPpnHMJIUCH5TRd9D/pN00L6w1G4cGtUQozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126956; c=relaxed/simple;
	bh=mxsgjXODlhD8yQ8oI/Bqh1Xv3piPGgXIqnVcMLMxt0Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kt9JRbW8XL9bJ6nUwYhy1HwIxcTtZ+PxOPskDr1yiSslWUWH7KB7IIdQ2kNrnrWqypTqlX0fWlMGcVYRy//hNqmWdZIJPrYalXVqqE8PeMJrMxgAX5Fw3tYiVa/prYfXm700FDvgQJCJklBcfJv9Jmm8H1xkEXC+RB8e07NXTy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VzFsD6Zz0z6K73N;
	Wed, 12 Jun 2024 01:24:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DE8D9140A70;
	Wed, 12 Jun 2024 01:29:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Jun
 2024 18:29:11 +0100
Date: Tue, 11 Jun 2024 18:29:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=
	<jpaulo.silvagoncalves@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Francesco Dolcini
	<francesco@dolcini.it>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, =?ISO-8859-1?Q?Jo?=
 =?ISO-8859-1?Q?=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=
	<joao.goncalves@toradex.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1119: Add driver
Message-ID: <20240611182910.000008f1@Huawei.com>
In-Reply-To: <20240610132629.xjj32vzrekpl356w@joaog-nb>
References: <20240606163529.87528-1-francesco@dolcini.it>
	<20240606163529.87528-3-francesco@dolcini.it>
	<20240609115234.20e08840@jic23-huawei>
	<20240610132629.xjj32vzrekpl356w@joaog-nb>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 10 Jun 2024 10:26:29 -0300
Jo=E3o Paulo Gon=E7alves <jpaulo.silvagoncalves@gmail.com> wrote:

> Hi Jonathan,
>=20
> Thanks for the review!
>=20
> > > +
> > > +static int ads1119_validate_gain(struct ads1119_state *st, int scale=
, int uscale)
> > > +{
> > > +	int gain =3D 1000000 / ((scale * 1000000) + uscale);
> > > +
> > > +	switch (gain) {
> > > +	case 1:
> > > +	case 4:
> > > +		return gain; =20
> > Odd to calculate it if we don't need it
> > 		return MICRO / (scale * MICRO + uscale);
> > use constants as it's easy to drop a 0 in these without anyone noticing.
> > =20
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > + =20
>=20
> Just a minor. I do use the calculated value on write_raw() by storing it =
as the
> new channel gain and would still need to validate it as scale/uscale come=
s from
> userspace. Maybe I can just remove the validate_gain function and do the =
check
> directly on write_raw(). What do you think?

If that's the only caller, sure, move it to write raw.

Jonathan

>=20
> Regards,
> Jo=E3o Paulo Gon=E7alves
>=20


