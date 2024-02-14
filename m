Return-Path: <linux-iio+bounces-2555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F27854DE0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 17:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F936287D49
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B495FF13;
	Wed, 14 Feb 2024 16:16:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F360F5FDD9
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927411; cv=none; b=fSqx3WtnZNqBf0QH1KvKHBx0yBG/EZvEn+y2+8Ml9Ps4S5CTDB22Ap5wz4KRYOgIubyUS5zYEbrh1QPqw+1eiwvsW5/nIO/7IzsnkZ8aDiZcfAM08YHcpQp5PZ3f3jgS+YqFVc4MW+MEcBI72fiWD+UJSLsYyFaIWp+M77RftYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927411; c=relaxed/simple;
	bh=L+oIgzjrFnzauVVHbAUt4EyphHgUD2w4Ot8KTaamqpE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NglOGvU+DgcadlNHlTPoR+/MB6xeHDDZ5Ykx9tHaXtPY6NB8TkE1oVAIkKyhH7hu3l12EUH30Hv8c2BUKBijWi/ty46+7ouNB8838yneXx9ANoJssfs5vaxrw/7opuSDQ4x19msAmamDlLL7Xbmv6uh5O9CtVpew16KWYkIpluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZjsR4YV9z67ZyK;
	Thu, 15 Feb 2024 00:12:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E643140DEA;
	Thu, 15 Feb 2024 00:16:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 16:16:40 +0000
Date: Wed, 14 Feb 2024 16:16:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan LoBue <jlobue10@gmail.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <jic23@kernel.org>,
	<jagathjog1996@gmail.com>, <luke@ljones.dev>, <benato.denis96@gmail.com>,
	<linux-iio@vger.kernel.org>, <lkml@antheas.dev>, <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iio: accel: bmc150: Duplicate ACPI entries
Message-ID: <20240214161639.0000436e@Huawei.com>
In-Reply-To: <CAHp75Vf4kMPevMvdi8rApe9PEf2AdhCfTAdVW_6OCp_f3jSPGA@mail.gmail.com>
References: <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
	<20240213223806.27056-1-jlobue10@gmail.com>
	<CAHp75VdyQxpy5wT=X+0TKnd5x4uJzqcSJikHs2Mx-VOEzbnv9g@mail.gmail.com>
	<5773370.DvuYhMxLoT@nobara-ally-pc>
	<CAHp75Vf4kMPevMvdi8rApe9PEf2AdhCfTAdVW_6OCp_f3jSPGA@mail.gmail.com>
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

On Wed, 14 Feb 2024 17:39:53 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Feb 14, 2024 at 5:07=E2=80=AFPM Jonathan LoBue <jlobue10@gmail.co=
m> wrote:
> > On Wednesday, February 14, 2024 1:35:56 AM PST Andy Shevchenko wrote: =
=20
> > > On Wed, Feb 14, 2024 at 12:38=E2=80=AFAM Jonathan LoBue <jlobue10@gma=
il.com> wrote: =20
>=20
> ...
>=20
> > > > Comment describing the duplicate ACPI identifier issue has been add=
ed
> > > > before the "BOSC0200" entry here. =20
> > >
> > > Hmm... =20
> >
> > You asked for a changelog after the cutter, although it really seems
> > unnecessary to me here as it's repetitive in nature with comment above.=
 =20
>=20
> This is fine and needed. My comment was about the actual placement of
> the comment (should be immediately before the ID entry and not
> detached from it.
>=20
> ...
>=20
> > > > + * The "BOSC0200" ACPI identifier used here in the bmc150 driver i=
s not =20
> > >
> > > s/ACPI//
> > > s/in the bmc150 driver//
> > > =20
> >
> > So update the first sentence in the comment to be:
> >
> > The "BOSC0200" identifier used here is not...
> > ? =20
>=20
> Yes.
>=20
> > > > + * unique to devices using bmc150. The same "BOSC0200" identifier =
is found
> > > > + * in the ACPI tables of the ASUS ROG ALLY and Ayaneo AIR Plus whi=
ch both
> > > > + * use a Bosch BMI323 chip. This creates a conflict with duplicate=
 ACPI
> > > > + * identifiers which multiple drivers want to use. Fortunately, wh=
en the
> > > > + * bmc150 driver starts to load on the ASUS ROG ALLY, the chip id =
check
> > > > + * portion fails (correctly) and a dmesg output similar to this:
> > > > + * "bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0" can be seen.
> > > > + * This allows the bmi323 driver to take over for ASUS ROG ALLY. =
=20
>=20
> ...
>=20
> > > >  static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] =
=3D { =20
> > >
> > > ...it should be here. But don't resend, let's Jonathan to decide in
> > > case he won't amend this when applying.
> > > =20
> > > >         {"BOSC0200"}, =20
> >
> > This seems to be a stylistic preference on whether or not to include th=
is
> > long comment inside of the ACPI match table or not. Stylistically, my
> > preference would be to include it directly above the match table and not
> > inside of it. I will wait for Jonathan Cameron's comments about what to=
 do
> > here. =20
>=20
> In my p.o.v. it's not stylic as we refer to the exact ID and having
> comment detached is, besides being unusual, may go outdated too
> quickly as code is being grown and developed. So, I really want it to
> be closer to the ID entry.

Yes, please send a v3 with it next to the relevant ID.
Also dont send new versions in reply to old ones.
For IIO patches at least, a new thread every time please.

>=20


