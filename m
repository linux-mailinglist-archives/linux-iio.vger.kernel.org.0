Return-Path: <linux-iio+bounces-23501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB65B3CF1A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 21:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF9B175BDB
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4912DE704;
	Sat, 30 Aug 2025 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFxwFCwY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790E1C3F0C;
	Sat, 30 Aug 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582891; cv=none; b=LZCwmJdnBc91VVwtq+T8HOPUskoJycFlrhawka2+jKFGb3V/XVr0I8WtjqZ/ltnm03WX4tODKZWNChQBlhlbt4R6zJmfgIiIpkMLfO4COKm0THtsM5JCjYlGHHxcssDCVIz7pOr5j/lVodgxjhhPrhILqIgasbXA4uoJAgLt1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582891; c=relaxed/simple;
	bh=ziXAFQ1O56+Mf+mMhR/H54NFvw6Gs4uAR/zs3zMb3sU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zpgr3MXoAs+j0dH0q/g50IKSTAtNW1eCM+aKUmfKA8I5na3U1PwNDkQnlN5UxbOkI85A482aDy/57fKJxN8mYtD6RzDpHrIBkRtF5O7308+Zsy29s6t2Q4POs4hkI3fgvDPfGSXFjb3UNggK5kD5QooxoQeqjBWo5v+2o4xzuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFxwFCwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8D0C4CEEB;
	Sat, 30 Aug 2025 19:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756582890;
	bh=ziXAFQ1O56+Mf+mMhR/H54NFvw6Gs4uAR/zs3zMb3sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iFxwFCwY9KaSZbNbbUK19hbKVggXoImp1dEguJItHHa2A9aujBOll97Nhqtq7PFOE
	 IQlH4QHWSPt+3odFdTKS6u8etawRt1BksvV06P1L5qvin/oP5ccJO8imHZgeHcHOco
	 aeLgNjLttDa4XOyMEBSuKKFTC+BGXQSoKKONHTCaWaybSjoXEbuZ8dsAHCvqymiVlL
	 mQ7F5zWZr07e7o45qaR859EExYYKRmIo9uBUTMqQ2AguO1t80h+uxf++98vvJKByF0
	 Hq7VmLvr/KJ1RxZZtL99VNJYuQgubGqCvHJPK9gyTumy7Yb5NZuaM98BFhDna57Hlk
	 kFavmVie2z6xw==
Date: Sat, 30 Aug 2025 20:41:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Karel Balej
 <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, David Wronek
 <david@mainlining.org>, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Message-ID: <20250830204120.37050ee8@jic23-huawei>
In-Reply-To: <CAHp75Vfg4E7nUXwQowN0wtNKQR_i6W+E_JT0xwCKSoY+ghGFvA@mail.gmail.com>
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
	<CAHp75Ve=xJ6vTUydaTw9GuYr22ZXp3HFA5N0tP7NET=CvZJB8Q@mail.gmail.com>
	<CAHp75Vd+hAucOyjqLj=rY3oLSySiReVupRQdBjwoLQSPAZMNMQ@mail.gmail.com>
	<22825864.EfDdHjke4D@radijator>
	<CAHp75Vfg4E7nUXwQowN0wtNKQR_i6W+E_JT0xwCKSoY+ghGFvA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Aug 2025 18:05:06 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 30, 2025 at 4:07=E2=80=AFPM Duje Mihanovi=C4=87 <duje@dujemih=
anovic.xyz> wrote:
> > On Saturday, 30 August 2025 06:41:58 Central European Summer Time Andy
> > Shevchenko wrote: =20
> > > On Sat, Aug 30, 2025 at 7:37=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote: =20
> > > > On Fri, Aug 29, 2025 at 2:41=E2=80=AFAM David Lechner <dlechner@bay=
libre.com> =20
> > wrote: =20
> > > > > On 8/28/25 5:17 PM, Duje Mihanovi=C4=87 wrote: =20
>=20
> ...
>=20
> > > > > > +     ret =3D regmap_bulk_read(*map, regs[chan], buf, 2); =20
> > >
> > > On top, please drop a double pointer and use map directly. That's
> > > already a pointer, what's the issue with it to begin with? =20
> >
> > struct regmap is only defined in a regmap-internal header, so it has to
> > be a double pointer or a struct containing a regmap pointer. I went
> > with David's advice and created this struct. =20
>=20
> I might have missed something... So, the root of this is how we
> allocate memory for the data structure and what we keep in the priv
> member there. Indeed, it keeps the pointer to the field in the
> allocated memory, so if we allocate a memory just to keep one pointer
> it should be doubled (independently on the possibility to access the
> data type we are using to keep in priv).
>=20

To avoid confusion of layers of pointers I'd spin a structure for iio_priv

struct pm886_data {
//nothing else for now.
	struct regmap *map;
};

Then there will be no double pointers visible and this will looks like
most other drivers where this is at least one other bit of state to store.

Very high chance something else will need to go in there at some point anyw=
ay!

Jonathan

