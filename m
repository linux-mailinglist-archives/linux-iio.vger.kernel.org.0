Return-Path: <linux-iio+bounces-21288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F70AF7048
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 12:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605ED1BC1ADB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CC42EA159;
	Thu,  3 Jul 2025 10:27:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB82E5424;
	Thu,  3 Jul 2025 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538442; cv=none; b=fuyheWGJjtaPWm18FLxMwPky5URVsfaPm79wZPBG7CNbHlNVFDWg4rZQEBWmKwjefPzGEnGyfta4go0dM2s3Y8JyDnY/pDBNf0A+92o/sfd1QkkmI/2St4Tj2JFEfUwCKpqOMGuqjz6+WxuRXW0z6bL4MqD4oFat4gx9mc5ysrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538442; c=relaxed/simple;
	bh=DjI8oLdMLDrBuy1PxAjHjfkK1mZRk2rczmkFo0BW58g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLz0SJmpP6wwmKX4CKjaI238RrlSU8PspcvSvBDB0vbQcfLoUjLbvhfw7Q7fNPSnSv9N+fBpj3rhOzqiNPWLQMG+VItMWh0E4FAZ8vPT09x9FvLRK6iY0jb8L0U0eoXN7PFWy0cqaF/vMMnj3/n1a5IMr/lWjPgCwNSLdZWA0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXtGm1MV0z6DKbF;
	Thu,  3 Jul 2025 18:26:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E8F231402F0;
	Thu,  3 Jul 2025 18:27:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 12:27:08 +0200
Date: Thu, 3 Jul 2025 11:27:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andrew Ijano <andrew.ijano@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, "Colin King (gmail)"
	<colin.i.king@gmail.com>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Gustavo Bastos <gustavobastos@usp.br>, Julien Stephan
	<jstephan@baylibre.com>, <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: iio: accel: sca3000: dead code issue
Message-ID: <20250703112706.0000064d@huawei.com>
In-Reply-To: <CANZih_Rc3aht-ZTuuEytad8A1d5eC8Z_Dq2GQD8K2QiyFjcBZQ@mail.gmail.com>
References: <1c1e39cb-5fe0-46b3-898e-c65bbb3beb30@gmail.com>
	<aGUh7uXenHc7NYB2@smile.fi.intel.com>
	<20250702164022.000027e8@huawei.com>
	<CANZih_Rc3aht-ZTuuEytad8A1d5eC8Z_Dq2GQD8K2QiyFjcBZQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 2 Jul 2025 23:52:02 -0300
Andrew Ijano <andrew.ijano@gmail.com> wrote:

> On Wed, Jul 2, 2025 at 12:40=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 2 Jul 2025 15:11:26 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > =20
> > > On Wed, Jul 02, 2025 at 10:00:55AM +0100, Colin King (gmail) wrote:
> > > =20
> > > >                 ret =3D spi_w8r8(st->us,
> > > > SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
> > > > =20
> > > > >>>  the call to spi_w8r8 returns 0 on success or -ve on an error =
=20
> > >
> > > Where did you get this from, please?  Any link to elixir or Git repo?
> > > =20
> >
> > Hmm.  Just for reference the docs of spi_w8r8 are:
> >
> > * Return: the (unsigned) eight bit number returned by the
> > * device, or else a negative error code.
> >
> > Not 0 on success (well not unless it is zero.
> >
> > So the check indeed looks wrong as should be if (ret < 0)
> >
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=
=3Dtesting&id=3Dca66d8208762492df8442a503db568d9aab65f2f
> > It's in my tree.
> >
> > I'll drop the patch when I'm on the right machine.  Andrew, could
> > you do a new version fixing this up?  If not can make the changes
> > but will be at least the weekend before I get a chance.
> > =20
>=20
> Hey, guys! Thanks for pointing this out, I totally missed this problem
> before. I'll try to fix this tomorrow.
>=20
> In this case, should I send a new version of the patchset fixing the
> problem or a single patch following this commit with the fix?

Given there will probably be some fuzz for the later patches, send
a new version of the whole series.

Thanks

Jonathan

>=20
> Thanks,
> Andrew


