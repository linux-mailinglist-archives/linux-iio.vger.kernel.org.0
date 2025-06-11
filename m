Return-Path: <linux-iio+bounces-20462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE39AD5C41
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA4E17EB5D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE11C8606;
	Wed, 11 Jun 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l64DM2Nx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFB1BD01F
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659545; cv=none; b=gzl70A7FP4JDUa4Wg9maeGL2H6TcJPIKZ117Y368pRCTp1TH+Onn2q/QFTJjSQr336OVaAyur2Kuf21ouLwb1BQFY0ExL4vXeeIA2+Da4L0emk5ttv6Id09r4u6ISx6sUFWVCm/SK27zO3ZvThX5d39/PgIswsCljfqaYyjL/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659545; c=relaxed/simple;
	bh=619NipebrQ/4rl0I8LQkG+svmQ9z6ckFy0lSp0XoiPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASzHzpyDhSqDkqUU1Vpjxs8sh0RHVB9xFqZzQay49H/MdLZ4CahcVKEZDCdIRSQFrSAK553YtGmAf9HlET8TkCYM+llW3tLwfoNdO9sj5eQK+yCe8mjl+Xyk1rzB4i9VyVFmot+j5U+IsnVMCRq3svtqqU5pY2Z/UCb8GMG/Erk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l64DM2Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32951C4CEEA;
	Wed, 11 Jun 2025 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659544;
	bh=619NipebrQ/4rl0I8LQkG+svmQ9z6ckFy0lSp0XoiPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l64DM2NxrAFmbgeEAalo6uqzEZaM6Xtkx/Szd09FRqIeBLl3jwENl0l6LQ6wnE8Zf
	 RsRV0xqaibe5cjqTG7CtfeEzaANk/iiqmQ1AtCQ6L3e/s01D3Hat9Pta6b/L9gtS2T
	 yBEI3FuO6fMAowSiuT77lxPDPLUBFES+UgTas63lRjOLLzK9iEno3fmWMhEdArW6l2
	 weeeDgu3atz7Nu6KFVIjzlF3PIKr8XjZTV/W/APef7SDAd8mDQ6o8MJE2N2ZOflDCr
	 K8pb813uymHbgRvjpy24XNiYJ4mdKTTRYHX8D1n2IBCMvdgm/yCrKS25uR/h2RemBi
	 9RpdPU6EDu/lA==
Date: Wed, 11 Jun 2025 17:32:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 <linux-iio@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/2] iio: dummy: Drop unused export.h include.
Message-ID: <20250611173217.270a3696@jic23-huawei>
In-Reply-To: <20250609103905.00004bee@huawei.com>
References: <20250609070616.3923709-1-jic23@kernel.org>
	<20250609070616.3923709-3-jic23@kernel.org>
	<CAHp75Vdovs=REuauj_zU3V_aw+zUjWY-pKV5sEuayJb9By1JkQ@mail.gmail.com>
	<20250609103905.00004bee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jun 2025 10:39:05 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 9 Jun 2025 12:27:33 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Mon, Jun 9, 2025 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kernel.=
org> wrote: =20
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Resolves:
> > >   warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h>=
 is present   =20
> >=20
> > While this true...
> >  =20
> > >  #include <linux/kernel.h>   =20
> >=20
> > ...I prefer a full and not half-baked solution, i.e. revisiting all
> > headers and esp. replacing kernel.h with what is used.
> >  =20
> > > -#include <linux/export.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/irq.h>   =20
> >=20
> > While doing that, the headers may be sorted (in the same or preparatory=
 patch).
> >  =20
>=20
> Whilst I agree that more work is need, I also don't like the time it might
> take to get to it and the warnings that might mean more significant issue=
s get
> missed in the wash in the meantime.
>=20

After I wrote this I remembered that this is our 'reference' code so we
should hold it to a higher standard.  So I'll try and come back and improve
this one sometime soon rather than just papering over the cracks.

Given I tend to build with W=3D1 and right now I'm swamped with pages
of these warnings I'm really keen to get rid of them in IIO anyway
and I see lots of activity to squash them more generally.

I'm a bit grumpy that this warning got added without (as far as I saw)
any attempt to first clean up upstream.

J

> Jonathan
>=20


