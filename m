Return-Path: <linux-iio+bounces-23967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7435EB520B3
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B600582922
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C0C2D46C9;
	Wed, 10 Sep 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJP1H/bT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77C2571DC;
	Wed, 10 Sep 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531542; cv=none; b=Oh2Wcqhik/o7ZqUj0j9Ob5d4EMrzo8VfTLq5G4Rlep3QUSQI5zaq8gjrHydp18rS7RSD2kzpa7k3ZyFkbhNEIG2mNa2GVyluYC+cNxeOBKXY5PvBDPTpwgas9csOeBCqihvIOTejoUdcRDAyO3kRQyfkB5/RyA6qRwbOPj5YsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531542; c=relaxed/simple;
	bh=MZoH5Dw3FlDYGUDpz/hLH4usGwkTmmO2EeJ1AyiZ/SY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBPakCA5ZVuu+rHZ1U73ha5UArLBm3In57LrYLh/2RF1Qp0Jts79cdf6YElanH9OsV3RsEsyktLeq5BODZHxXE/7P0nyfllkAgNp7PZPoenVeG1k6eXgJ/9T1CY++jhJtxpK4pabqQ6sfCFLlCjCGKjMr1p8tfU+uNeuMZkK7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJP1H/bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66D1C4CEEB;
	Wed, 10 Sep 2025 19:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757531541;
	bh=MZoH5Dw3FlDYGUDpz/hLH4usGwkTmmO2EeJ1AyiZ/SY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJP1H/bTlgo2Ox+uZlHmbBwPKRVt8xYkKXM8wt0KB6Zr4JBBkXcj5MkW2V5900VLi
	 JSRGF0PT+erVz71/10BwwGw9hXe34R3x4TB687P2RcbDw4WgMV6i7oqdmZ/4d7nEW+
	 5lAv4Jb7ZXG4ETJE9dreoUJONiTXblgfyHaEZJtmFdHskECCJPzPQaAh3RiCN+wjZ1
	 n2HNfZ4rIfTV0uVtNcUATAGb9Q+VLn+PvCsEqs9vv6IjUKzXI26VWBJ1el5MNuDH9H
	 OsSLkpd1LX0THZL6aAieXtUtnNzh5gwOWviITOmbswHvkqWQzTBFG6oefY4sx0FB55
	 Uf0QDs1DnA+5g==
Date: Wed, 10 Sep 2025 20:12:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, anshulusr@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: light: ltr390: Implement runtime PM support
Message-ID: <20250910201212.5d9f57bc@jic23-huawei>
In-Reply-To: <CAE3SzaTZ8PXM_B8FBetOTSfz2myGZ=WzPp8h2d79Q95zKLq5hw@mail.gmail.com>
References: <20250909194649.10512-1-akshayaj.lkd@gmail.com>
	<CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com>
	<CAE3SzaTZ8PXM_B8FBetOTSfz2myGZ=WzPp8h2d79Q95zKLq5hw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2025 18:06:32 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Hi Andy,
> Thank you very much for your valuable feedback.
> I do have a small request regarding the review process. Over the past 3=
=E2=80=934
> versions,most of the comments have been about fixing indentations and
> improving code readability. I would kindly request if it would be possible
> to consolidate such cosmetic comments into a single review round.
>=20
> I completely understand that incremental feedback makes sense when the co=
de
> is actively changing, but if the changes are minimal, spreading out minor
> suggestions over multiple review cycles tends to unnecessarily increase t=
he
> turnaround time.
>=20
> Your support in this would help me address the comments more efficiently.
>=20
> On Wed, Sep 10, 2025 at 12:47=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Sep 9, 2025 at 10:47=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gma=
il.com> wrote: =20
> > > +static int ltr390_read_raw(struct iio_dev *iio_device,
> > > +                          struct iio_chan_spec const *chan, int *val,
> > > +                          int *val2, long mask) =20
> >
> >
> > Also logical split might be better, i.e. putting val and val2 on the
> > same line. Then mask will be on the next one =20
> Ok, will fix.
>=20
> > >  static void ltr390_powerdown(void *priv)
> > >  {
> > >         struct ltr390_data *data =3D priv;
> > > +       struct device *dev =3D &data->client->dev;
> > > +       int ret;
> > >
> > >         guard(mutex)(&data->lock);
> > >
> > >         /* Ensure that power off and interrupts are disabled */
> > > -       if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> > > -                               LTR390_LS_INT_EN) < 0)
> > > -               dev_err(&data->client->dev, "failed to disable interr=
upts\n");
> > > +       if (data->irq_enabled) {
> > > +               ret =3D regmap_clear_bits(data->regmap, LTR390_INT_CF=
G, LTR390_LS_INT_EN);
> > > +               if (ret < 0)
> > > +                       dev_err(dev, "failed to disable interrupts\n"=
); =20
> >
> > In event_config we assure that IRQ is enabled. =20
> What do you mean here?
> > =20
> > > +               data->irq_enabled =3D false; =20
> >
> > Here we may lie about the facts. What will the driver do, if the IRQ
> > is triggered just before this line? =20
> I don't see why the device will trigger an IRQ, when we are disabling
> the INT via
> regmap_clear_bits before this.

There may be a theoretical race with an incoming interrupt only being obser=
ved
after the regmap_clear_bits() has returned.  The question becomes whether t=
hat
matters.  data->irq_enabled is not relevant to the actual interrupt handling
and the power down isn't stopping registers being read, just new data being
captured.  So should be fine.

>=20
> > =20
> > > +               pm_runtime_put_autosuspend(&data->client->dev); =20
> >
> > You have dev, use it. =20
> Ok, will fix.
>=20
> >
> > But where is the symmetrical pm_runtime_get*()? =20

>=20
> This is the fundamental approach of managing IRQ handling + runtime PM.
> suggested by Jonathan in preliminary rounds and employed by many drivers.
> "When enabling IRQ, increase the refcount, and decrease when disabling"
> This is done because ltr390 does not have a wakeup functionality.

It's not really about enabling the irq. It's more about turning on autonomo=
us
data capture that in turn is related to enabling events (which indeed cause
irqs).  So similar to what we tend to do with runtime pm in the buffer enab=
le
callbacks as we are intentionally holding the power on.

So this function is effectively disabling the events - be it in a fast
fashion given it happens on driver unbind.


>=20
> put_autosuspend is tied to disable which can happen in 2 places:
> 1. event_config.
> 2. powerdown (if irq enabled).
>=20
> pm_runtime_get* is tied to enable which can happen only at 1 place:
> 1. event_config.
>=20
> If IRQ was enabled before power down, that means in event_config
> we had already called pm_runtime_get* and increased the refcount to 1.
> This will come down to 0 as a result of either of disabling event_config
> or powerdown.

Exactly this bit.  Maybe this would all have been cleaner if we had
just called this events_enabled rather than irq_enabled?

Andy, if you are fine with the explanation I'll tidy up the minor stuff
whilst applying.

Jonathan

>=20
> Thanks,
> Akshay.


