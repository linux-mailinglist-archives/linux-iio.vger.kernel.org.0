Return-Path: <linux-iio+bounces-21399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3483AFA50E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 14:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E43D18976A7
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65AB20F098;
	Sun,  6 Jul 2025 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vre18jYi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3843A1BA;
	Sun,  6 Jul 2025 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751803697; cv=none; b=fL+fDoRRmHJwBb7/+uIkC6pwoxYUdBoX2M1nYDHYUXucC5sfOzf40hYrx+4rLafDkfEGzVjcmr6Ww8nWfJ3JUBurr1VPb8zX7deGJoRxDf6CTFDVs0LFR4Eca43Bhf5WSKhWDEmWxL/1k7V9h5Hvt90AEWEltLzlVGyjvkMJdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751803697; c=relaxed/simple;
	bh=XpoWv8xta0VLHMCKopuMDFXlJSopoAkpIk+CWYp7CpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5ZoPvY1gR6IdFxUHU9/sYbo3AcLuY9Guq2Kegs7k0WR6Jm9sxapSSTj9pcnivqb9vgmKGx2YUOI4rpLB9NW+9ZczEcqk/w516N36Z3rybknfTN5O8Yia/tAVh38L7Ommk51rjKFo/bVitKXURtVsviKC6sYAf+vpKarRZYDXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vre18jYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53F0C4CEED;
	Sun,  6 Jul 2025 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751803696;
	bh=XpoWv8xta0VLHMCKopuMDFXlJSopoAkpIk+CWYp7CpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vre18jYiYCHIIIE4ibLvL/mUJ116J7ErrS6VpBf154/DJ1OctUwv+laQ6Cqbyjjjo
	 6+mYuhEgcOlwR/EF6c1i6v4wYS8xXMooufl6OXKPXqxMpoPnpp+mCli1mXjXbtBhas
	 l5aXmk0Xn440BNTVW9Z3R0BpBDGD4TNGR53OjghrNBY+PPmOUQ2mSfZnFaNL0CuDoh
	 C+ABcW8P57W7gFubFGFKUI3EuBBJxBGX8QTYVMguYkJgkU/CbEgVq2JLAUQazsvPrA
	 ZzJJSGtcHMtCoJEE1UVmOp01bBb/pSZiWGTjsZe7LFz2mPOncyVpVt9M6dpYLfahuv
	 ZljKRUL6iH1MQ==
Date: Sun, 6 Jul 2025 13:08:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v11 4/8] iio: accel: adxl345: add inactivity feature
Message-ID: <20250706130808.2b6a1161@jic23-huawei>
In-Reply-To: <aGalkb42uRQ12Wr0@smile.fi.intel.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
	<20250702230315.19297-5-l.rubusch@gmail.com>
	<aGaTH6gVqHxn9Xct@smile.fi.intel.com>
	<CAFXKEHb4MQk=6hyh-02Fq_XmkQmMiwc-WT4ZSviP6x4XA463mQ@mail.gmail.com>
	<aGalkb42uRQ12Wr0@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Jul 2025 18:45:21 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jul 03, 2025 at 04:59:50PM +0200, Lothar Rubusch wrote:
> > On Thu, Jul 3, 2025 at 4:26=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote: =20
> > > On Wed, Jul 02, 2025 at 11:03:11PM +0000, Lothar Rubusch wrote: =20
>=20
> ...
>=20
> > > >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> > > >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> > > >  #define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > > > +#define ADXL345_REG_INACT_AXIS_MSK   GENMASK(2, 0)
> > > > +#define ADXL345_POWER_CTL_INACT_MSK  (ADXL345_POWER_CTL_AUTO_SLEEP=
 | ADXL345_POWER_CTL_LINK)
> > > >
> > > >  #define ADXL345_TAP_Z_EN             BIT(0)
> > > >  #define ADXL345_TAP_Y_EN             BIT(1)
> > > >  #define ADXL345_TAP_X_EN             BIT(2)
> > > >
> > > > +#define ADXL345_INACT_Z_EN           BIT(0)
> > > > +#define ADXL345_INACT_Y_EN           BIT(1)
> > > > +#define ADXL345_INACT_X_EN           BIT(2)
> > > > +#define ADXL345_INACT_XYZ_EN         (ADXL345_INACT_Z_EN | ADXL345=
_INACT_Y_EN | ADXL345_INACT_X_EN)
> > > > +
> > > >  #define ADXL345_ACT_Z_EN             BIT(4)
> > > >  #define ADXL345_ACT_Y_EN             BIT(5)
> > > >  #define ADXL345_ACT_X_EN             BIT(6) =20
> > >
> > > Now it's even more mess. I am lost in understanding which bits/masks =
are from
> > > the same offset and which are not.
> > > =20
> >=20
> > I'm sorry for that. I mean, while the above is supposed to make it
> > clear where the "values" are coming from, I also could setup something
> > like the following which is shorter.
> > +#define ADXL345_INACT_XYZ_EN        GENMASK(2,0)
> > +#define ADXL345_ACT_XYZ_EN        GENMASK(6,4)

Definitely not for those.  They aren't a mask, but rather 3 only somewhat
related bits.

> >=20
> > As I understand you, you'd rather prefer to see the latter one in the k=
ernel? =20
>=20
> My personal preference can be found, for example, in
> drivers/pinctrl/intel/pinctrl-intel.c. But I'm not insisting to use
> _my_ schema. Just find a way how to group them semantically.
>=20


