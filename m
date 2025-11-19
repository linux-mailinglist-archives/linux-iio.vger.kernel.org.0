Return-Path: <linux-iio+bounces-26316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 837DBC6F969
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 16:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20669383518
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D57C357A2B;
	Wed, 19 Nov 2025 14:57:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961A26FDA5;
	Wed, 19 Nov 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564279; cv=none; b=smrPNbjFAAJLeiH2lyjIvHEvIBfCUjqSOIUOJqxuFGbEm229D6KqGPIrNxbizYMft4oco0sk/hx4DtQeeSIHIyins8Hw/Wzd8oRemY7mEwpHLYH2BpB5Y5absLIoR1YGxoShGpZjXRnWbZ0cqQNmc58eBAuc4GNw5kL7RHr2Og4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564279; c=relaxed/simple;
	bh=QWN9gUwvKY8aXzhsj+qDRUXyC+SH2snYW2dmZsE8QDs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCt9WXiG98DpzwLVD1c0p7+q4x4mnR32OQcGzMpIydSIdC27UGqYxpj9ltpU3BJG2Mx4icIAB2CTjsPxo7S9yfArC7Nausz1lIRQCS0HWepZih/7duRGOhUvyFQeEk8h8ZYps6DlaQxNoqB7oy2snhqO/4stnpur0fcWao9HVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dBPhw72v6zHnGcc;
	Wed, 19 Nov 2025 22:57:20 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E8A771402F4;
	Wed, 19 Nov 2025 22:57:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 19 Nov
 2025 14:57:53 +0000
Date: Wed, 19 Nov 2025 14:57:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, Shi Hao <i.shihao.999@gmail.com>,
	<Michael.Hennerich@analog.com>, <lars@metafoo.de>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: adt7316: replace sprintf() with
 sysfs_emit()
Message-ID: <20251119145751.00003a9c@huawei.com>
In-Reply-To: <CAHp75VejBvRX=5psgVgGPCsKk7gVgcDUd1q3Gn+4_jyzk=2pEw@mail.gmail.com>
References: <20251116101620.25277-1-i.shihao.999@gmail.com>
	<CAHp75VdY7W8EgOfKuxtTALj777aVatxV5dqsxm688JTy=iVW2Q@mail.gmail.com>
	<20251116152800.4c1849cc@jic23-huawei>
	<34a55901fe0729145097d287a98746f23eea13d8.camel@gmail.com>
	<CAHp75VejBvRX=5psgVgGPCsKk7gVgcDUd1q3Gn+4_jyzk=2pEw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 18 Nov 2025 14:10:25 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Nov 18, 2025 at 10:17=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> > On Sun, 2025-11-16 at 15:28 +0000, Jonathan Cameron wrote: =20
> > > On Sun, 16 Nov 2025 13:08:07 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
>=20
> ...
>=20
> > > Applied, but I will note that this driver is a long way from suitable
> > > for moving out of staging and I would be surprised if more than
> > > one or two of the lines changed in this patch make it through the
> > > necessary refactors (should anyone actually have another go at
> > > doing them).  Anyhow, I still think this is worth taking just to
> > > reduce the noise of remaining instances of this.
> > >
> > > I'd have deleted this long ago except I actually have one somewhere
> > > and it one of the supported parts was still listed as suitable for
> > > new designs when I checked not long ago. =20
> >
> > Seems to be now "just" in production. So no longer advised for new desi=
gns. I gave a
> > quick look and this is far from being a simple driver. It would require=
 a fair amount
> > of work to bring it out of staging. So, are there users relying on stag=
ing drivers? =20
>=20
> If there is no choice, yes. For example FBTFT is famous for being used
> by IoT / DIY _a lot_. Currently a bit less since we got tinyDRM
> subsystem with most popular drivers reimplemented there.
>=20
> > But I would assume that for staging we are still free to drop support i=
t? =20
>=20
> At any level, we are still free to drop :-) Just different conditions
> applied. For staging is basically an "effective immediately" case.
>=20

If no one replies to this thread in next few weeks to say otherwise, let us=
 see
if anyone objects to patches. I'll spin a series in a few weeks and they ca=
n sit
in linux-next for most of the cycle to see anyone notices.  It is easy to b=
ring
drivers back if turns out anyone cares and then there is some motivation to
finally clean them up.

staging/iio/
	accel/adis16203 is production
	adc/ad7816 is production (7817, 7818) - the 7816 itself is obsolete.
	addac/adt7316 is production (what we are discussing here)
	frequency/ad9832 + ad9835 are production
	frequency/ad9833 etc are production
	impedance/ad5933 + ad5934 are production

Thanks

Jonathan


=20

