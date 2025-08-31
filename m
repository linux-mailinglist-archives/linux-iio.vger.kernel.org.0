Return-Path: <linux-iio+bounces-23543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1478B3D42F
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 17:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091C83A69FB
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868A26F295;
	Sun, 31 Aug 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDzWq3YJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831472367C3;
	Sun, 31 Aug 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756654799; cv=none; b=fuOw7EcMWk3Aaod2ybFBwzCn9SwCTJRJp+gwha9j7Bz37vW89wKFyeQZ+Jzn8ep+yUeiJrUGPQYkMR4luh7vT5rhD2CYYH465m5pMbLPiQ7ecUVbpAN7LhqzHXNtn95GeMMNkpQt2nRrOG0f4rsvaL+Pro+XX88veq9y3Z2+hAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756654799; c=relaxed/simple;
	bh=GVoUaPV2C+fAqJs1mr7QJ+Zk1P0oaVra7tdzm+wTzqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KokN7NQesea8lJSV+xX2GO6iFgdihe1Rbzh6cB78mzXWv30ZkYh6F9oVEQueXvdW2rQlUo8+J4MjZNoUSL9z6I72r8zdCBYQEeqLl7z1pEPCgOWFFXU6VGJKZk1Vwlw3XMPHm+ur2ywO9lf2cykTH7clhylq8kh/GrPj9nfPC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDzWq3YJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB65C4CEED;
	Sun, 31 Aug 2025 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756654799;
	bh=GVoUaPV2C+fAqJs1mr7QJ+Zk1P0oaVra7tdzm+wTzqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aDzWq3YJ/l6GLSLzO0WrCKAcqGRvEd6OW+wLEAHJ1xQdJTv5dU1inCvRxFfwPmVQR
	 61n5PVeUpqmXKspTr9q9/xbL2RM6BWwqus4m2KU5hPE6ihurEPdCgni4Ad6gk+Mh4r
	 k4Yr3CiFJBMUxdGmxfcFDDEsG1DM3BZToE4fFkJCThnVVuBMr7Hh2uV12pysZmsJ8E
	 DIbzYa2YKbMctZcSe/TSOjsgBTwLEremdxsPJ53whjub3RlDt02vqi3f9SoO+vNYnP
	 Ah7U6YMB7JcXYPXVyPwQXRH6I30wf1uboUABCrUKVFrP/LKepS78DLzDEuawNasl22
	 /KrSsmte5DngQ==
Date: Sun, 31 Aug 2025 16:39:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, lanzano.alex@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: ABI: document accel and roc event
 attributes
Message-ID: <20250831163949.0dc59265@jic23-huawei>
In-Reply-To: <CAHp75VckFnumUG8GodAwigG10NVd66Tj-2Tkm3kLWQUET0EorQ@mail.gmail.com>
References: <20250830115858.21477-1-gustavograzs@gmail.com>
	<20250830115858.21477-3-gustavograzs@gmail.com>
	<CAHp75Vf13aqDJj2j7MtfLTAT2MW-S3+M7wtEXsG1Wh7EKfxJSQ@mail.gmail.com>
	<20250830180534.24a8ad56@jic23-huawei>
	<20250830180920.7a65df94@jic23-huawei>
	<CAHp75VckFnumUG8GodAwigG10NVd66Tj-2Tkm3kLWQUET0EorQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Aug 2025 22:58:17 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 30, 2025 at 8:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> > On Sat, 30 Aug 2025 18:05:34 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote: =20
> > > On Sat, 30 Aug 2025 15:49:50 +0300
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > > On Sat, Aug 30, 2025 at 2:58=E2=80=AFPM Gustavo Silva <gustavograzs=
@gmail.com> wrote: =20
> > > > >
> > > > > Add accelerometer and rate of change event-related sysfs attribut=
es
> > > > > exposed by the bmi270 driver. =20
> > > >
> > > > Seems to me like the absent attributes that are already in the kern=
el,
> > > > should be added in the separate patch. =20
> > > Agreed that would be ideal. =20
> >
> > Actually what did you mean by absent attributes? =20
>=20
> Absent in the documentation, but present in the code. That's what this
> patch adds mainly, no?
>=20
> > This is documenting ABI that is part of the general 'scope' of the full
> > IIO ABI but which hasn't turned up before in this particular combination
> > (or possibly we missed updating docs when it did!)
> >
> > Whether it is worth separating out any we know are in another driver is
> > an open question, but Gustavo hasn't called out any as being like that.
> > It's possible that these are all surfacing for the first time in this d=
river. =20
>=20
> Hmm... But if the code handles the attribute which is not documented,
> that needs to be fixed.
>=20
The core code handles a massive number of combinations that make no sense
because the attributes are constructed from 5+ parameters, each with many
values. So what matters here is whether a combination is in use, not whethe=
r it
could be instantiate by a driver using standard IIO structures.

Sometimes we miss things in reviews so gaps occur. Those absolutely should
be fixed, but we shouldn't documents stuff on basis it 'might' be ABI in
future.

Jonathan



