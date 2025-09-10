Return-Path: <linux-iio+bounces-23966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F5B52075
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FECE3B2A31
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7882D3EEB;
	Wed, 10 Sep 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUyZntpI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0A2D3EC1;
	Wed, 10 Sep 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530361; cv=none; b=HH2CGTRSDjZla3lGwjJ6Cr2LWXQGgCgvUrR+L7diKu7/4AjnMlZfbGbIXV12jYuwMwImZAuUidgA1kQt8MGeCaWEZlkP9kfEe7uGQAHXcapqCYKuimvXDsNTIusnSpF1Fw0Ng0kHvxYq9hx/tKphiHCO3fjegIsF1LSpGENVhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530361; c=relaxed/simple;
	bh=6kO8QRxpGi/RSQWLh7UK1nQbrkfxehJE8E0ugtQPzDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6ibIS35QU8qV3YLGPO5XNcx7MWSojIdCBnOw49kNNSrNiHt6Y8aWTfDnz1HDF9+YDj9FO3dM989R1slF5lOWDQdcEfxyUJOZaDGpakLL11SQNHXADp8umfib/G052R765qrTZvO2RFTvDh1lssaSXBWHRL7jZb/WO4WsAxHk34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUyZntpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239D3C4CEF7;
	Wed, 10 Sep 2025 18:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757530361;
	bh=6kO8QRxpGi/RSQWLh7UK1nQbrkfxehJE8E0ugtQPzDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XUyZntpI/o+lmhruMPPkYLJyC48j7aAHrZ+JrD9iZFd0MekIZlBT8CxjCK1VdweNU
	 +yMNdcwjnOgp3aBqXVrYa+VufX6M9MkrEDFZgFHw4cnEi9VNqkNJw2GVd7+v4DvmRV
	 zFd4RHG1Ky1z3/a8z1e3ZQEWsMyT9lJbLLPHJn1uc6VrcTxlj8a5cdWHezSkbMDDbz
	 3DaRR1Lm+RjOeTBSVH9GDjwrjMfDzU4qyER9pV1jocf3f47isIIeu+3HUHm/3ZBbME
	 qKL4L30D++4NG0Gxb47otRq+m80JQoAJKNxcAzT7//J+u94moV1xxeXHLkOX+cEAol
	 BK9mViXw0O9Yw==
Date: Wed, 10 Sep 2025 19:52:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, anshulusr@gmail.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: light: ltr390: Implement runtime PM support
Message-ID: <20250910195232.173ff14f@jic23-huawei>
In-Reply-To: <CAE3SzaQXOr6nh-MFAyLm_1J9kXisnzhak_VuVH4d2z6mXFe1NA@mail.gmail.com>
References: <20250909194649.10512-1-akshayaj.lkd@gmail.com>
	<CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com>
	<20250910120245.000033e8@huawei.com>
	<CAE3SzaQXOr6nh-MFAyLm_1J9kXisnzhak_VuVH4d2z6mXFe1NA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2025 23:30:36 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Hi Jonathan,
> Seeking your approval. If there is a requirement for v8, I can send that =
too.

Wait a day or so just to see if Andy is fine with your reply to him.

Thanks,

Jonathan

>=20
> Thanks,
> Akshay
>=20
> On Wed, Sep 10, 2025 at 4:32=E2=80=AFPM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Wed, 10 Sep 2025 10:17:00 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > =20
> > > On Tue, Sep 9, 2025 at 10:47=E2=80=AFPM Akshay Jindal <akshayaj.lkd@g=
mail.com> wrote: =20
> > > >
> > > > Implement runtime power management for the LTR390 sensor. The device
> > > > autosuspends after 1s of idle time, reducing current consumption fr=
om
> > > > 100 =C2=B5A in active mode to 1 =C2=B5A in standby mode as per the =
datasheet.
> > > >
> > > > Ensure that interrupts continue to be delivered with runtime PM.
> > > > Since the LTR390 cannot be used as a wakeup source during runtime
> > > > suspend, therefore increment the runtime PM refcount when enabling
> > > > events and decrement it when disabling events or powering down.
> > > > This prevents event loss while still allowing power savings when IR=
Qs
> > > > are unused. =20
> > >
> > > ...
> > > =20
> > > > +static int ltr390_read_raw(struct iio_dev *iio_device,
> > > > +                          struct iio_chan_spec const *chan, int *v=
al,
> > > > +                          int *val2, long mask) =20
> > >
> > > Isn't the mask unsigned long? Jonathan, do we get this fixed already?=
 =20
> >
> > Whilst it could (and probably should) be unsigned, it's not actually a =
mask.
> > That naming is a historical mess up / evolution thing - long ago it was=
 a bitmap.
> > It is now the index of a bit in the mask.  So this is unrelated(ish) to=
 the
> > recent fixes around the actual bitmaps/bitmasks.
> >
> > Changing this one is a lot more painful than the recent fix to the info=
mask
> > as it means changing the signature in every driver.
> > I'm doubtful on whether this one is worth the churn. =20
>=20


