Return-Path: <linux-iio+bounces-22606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BCFB21663
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 22:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3425D3B68DE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658F2DA775;
	Mon, 11 Aug 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob/yIfzH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC12D47F9;
	Mon, 11 Aug 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943943; cv=none; b=JlYKFsU6qQ4372R60sLjOXmv7oXpJUxXg468OcOGS6JPd7GaLP4Oh2U5IfbLJZFdCGis/RI4z7u91N/a5Er7LxgwH/59gaNL+R9MtjBCGYsRGPXuKla9W4qJMvDuKaTPo48ebius9507yR38F2tr3slihJWNeAFtAghb+7OOKFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943943; c=relaxed/simple;
	bh=z+N9HKMf43dB8SbHDpAKnQGM462JuzP2hLnzywSwO8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjGqprOZ6ocbdw2eRN7ccK60j4tO6BNOluWZ1/5inkkT9KNsm9kC+vxmCSkjJrPlVeY8UKuH1bdIAS/of2wrnsT+xjFmqIiJRtJ3hh8CMQMbdjaq6vug1HxEIpqq+tJGv9YLqZLI7dfyt8C3NySLgxWpC2T6h6accVCnxqZ/NyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob/yIfzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ABBC4CEED;
	Mon, 11 Aug 2025 20:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754943942;
	bh=z+N9HKMf43dB8SbHDpAKnQGM462JuzP2hLnzywSwO8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ob/yIfzHWPzoT+uIL2DAMepsicYWZRV0VNecgGFL21mNBP5gC6ZBaXvNCH8922OQ1
	 pBXKgFGdDeR0n2ulZ7xZ+VQCMm39yt6J2BqlCD6XvJA5kYE9Z9XOtFbX7p9VJYQtci
	 IoeRPM1iAWInBB/pYtF8yKds1BNM3UNgdOfLaGTM5x9waobDHjcpE6A+0DDqMC1cMx
	 gCbBJB1sG283BypTNR+kq+c15Z1p1GFTQYSZhHPWoSUsBw2CRbPZAWrQQF6p3BCvZn
	 QCHeZVEAm8fV8p3bE84/LFjShidVG0WTFF0F0+8C3MiVx5JSfI3nKYu+lpTBKqvIWO
	 mank+bfqSBEXA==
Date: Mon, 11 Aug 2025 21:25:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, anshulusr@gmail.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
Message-ID: <20250811212533.341e7c44@jic23-huawei>
In-Reply-To: <CAE3SzaRZGvOwi0UeBU9Nw2=_jwF9AYLyY0BFG9tHzwbMFv1o7g@mail.gmail.com>
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
	<CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
	<CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
	<CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com>
	<20250806161801.000061c0@huawei.com>
	<aJO05BNi2TsYtdwe@smile.fi.intel.com>
	<20250807140401.00006c85@huawei.com>
	<aJcapPt8f5YMUBH3@smile.fi.intel.com>
	<20250809205736.34b75763@jic23-huawei>
	<CAHp75VffV4Xomb-1zp6_xB=r+PJzsDnj_gjwyWas8cX7dhuhng@mail.gmail.com>
	<CAE3SzaRZGvOwi0UeBU9Nw2=_jwF9AYLyY0BFG9tHzwbMFv1o7g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 02:18:34 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> On Sun, Aug 10, 2025 at 2:04=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sat, Aug 9, 2025 at 9:57=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote: =20
> > > On Sat, 9 Aug 2025 12:53:40 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > > On Thu, Aug 07, 2025 at 02:04:01PM +0100, Jonathan Cameron wrote: =
=20
> > > > > On Wed, 6 Aug 2025 23:02:44 +0300
> > > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > > > > On Wed, Aug 06, 2025 at 04:18:01PM +0100, Jonathan Cameron wrot=
e: =20
> > > > > > > On Tue, 5 Aug 2025 14:47:32 +0200
> > > > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > > > > > > On Tue, Aug 5, 2025 at 6:05=E2=80=AFAM Akshay Jindal <aksha=
yaj.lkd@gmail.com> wrote: =20
> > > > > > > > > On Tue, Aug 5, 2025 at 2:36=E2=80=AFAM Andy Shevchenko
> > > > > > > > > <andy.shevchenko@gmail.com> wrote: =20
> >
> > ...
> > =20
> > > > We can do it, but this sounds to me like a step back. Implementing =
proper PM
> > > > runtime callbacks is a step forward. =20
> > > I entirely agree that runtime PM is good to have and it does a lot mo=
re
> > > than just turning the power on and off once per probe / remove cycle.=
 =20
>=20
> Initially, while working on a patch for this driver(sysfs for data
> freshness), while testing
> I needed to suspend the sensor but could not because the driver only supp=
orts
> system suspend and resume. At that time, I had made up my mind that I
> have to add
> runtime suspend support for this driver because before Andy's
> comments, I used to consider
> runtime PM support as a way to give control to users to do on-demand
> suspension and
> resuming sensor operations. But now I learnt that it is so much more.
>=20
> So Irrespective of the acceptance of this patch, my next patch was
> going to be runtime PM support.
>=20
> Will it be acceptable, that this driver like many other drivers have
> support for both remove callback
> and runtime PM?
Sounds good. Though you probably don't need an explicit remove callback,
just one more devm_add_action_or_reset().

That stuff just allows you to register the 'undo' immediately after the
'do' in probe which makes for easy to read code in many cases.

Jonathan

>=20
> Thanks,
> Akshay.
>=20


