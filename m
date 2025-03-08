Return-Path: <linux-iio+bounces-16576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C11A57C3F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 18:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA40418935C0
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE481DE3AB;
	Sat,  8 Mar 2025 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4qx3dZ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1B839F4;
	Sat,  8 Mar 2025 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741453911; cv=none; b=KmfCwG1ditxcBd7mVjEsbar11T0Lk3X33/FAUWTquPutc+UnrYzOF5AXjwu7LrtH/VrWAv103g818IMym18WYNCoGXkgi+lFSfLFZguLMFXhAapFxjc8Ld+5m6MKYTVVzfVjCVSkp7pBycpOgjeyMqztG8xxGbzA3PdMVy7GsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741453911; c=relaxed/simple;
	bh=TktOTQZs8kD9YGtq1C6Xz4cWmbmAcCnQKMa7JTIh71U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z37LIiWwR1x0VcD8mIknLgWS4C5h8n757ECpS8gslOU6Rajfb4l48AqyaDPSegiFWy58OkmEN8a0fehPGL5ECZZ8jBx6ohaJfcLVzNsplaga1RwpDTTVyPMyLAWhicEvh5IhprXtxZWXP3x9G6SP0ZElLszb6ytnlL2LOLyhGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4qx3dZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90D6C4CEE0;
	Sat,  8 Mar 2025 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741453910;
	bh=TktOTQZs8kD9YGtq1C6Xz4cWmbmAcCnQKMa7JTIh71U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k4qx3dZ1DWrnzyOX2MEMsCf9P6DAPv/quv+uHuOOYEXeFKN8Iu5uFvGmmb27mtIWt
	 BarZknMYI7RLZgacZ1+4cnKuQhg+xhecWj94G0jXkQ3Y0VNnhMFBxcc4LzL7x0zu9d
	 jWQWsSvSizbqoHRbOXu65+XSOqr9pwo67Vc90ZaqFetFA62HDIwAttKW7x0yJgkT2L
	 HJJ6zi81GWa3FfSmzTRY0IguJOP3FdYgl26kmXW4wLGMqbhPGYfiZhImwXDOkub+L3
	 D9KWLpBuYe5D/SG3U2NzNJd3pwoOs85gwMZcwdA9i75Hh5IzwhMRs1LDDWGsp+gsSl
	 dZonqvEsuJarQ==
Date: Sat, 8 Mar 2025 17:11:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
 andre.przywara@arm.com, lee@kernel.org, sre@kernel.org, lars@metafoo.de
Subject: Re: [PATCH 0/2] Fix Regression with AXP20X for 6.13-rc1
Message-ID: <20250308171141.2339d93e@jic23-huawei>
In-Reply-To: <DM6PR19MB372230C8D4D32FB780357C99A5CA2@DM6PR19MB3722.namprd19.prod.outlook.com>
References: <20241210224859.58917-1-macroalpha82@gmail.com>
	<20241211215826.06162190@jic23-huawei>
	<67606b09.050a0220.3905d.5bc7@mx.google.com>
	<CAGb2v64vn-h02Bn2AKftphpNNcx9h9K3pKvdjuANsDhwiqbsrQ@mail.gmail.com>
	<67c743e3.050a0220.327e31.55b3@mx.google.com>
	<20250304232913.020056fa@jic23-huawei>
	<DM6PR19MB372230C8D4D32FB780357C99A5CA2@DM6PR19MB3722.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 20:19:43 -0600
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Tue, Mar 04, 2025 at 11:29:13PM +0000, Jonathan Cameron wrote:
> > On Tue, 4 Mar 2025 12:18:10 -0600
> > Chris Morgan <macroalpha82@gmail.com> wrote:
> >  =20
> > > On Tue, Dec 17, 2024 at 02:04:37AM +0800, Chen-Yu Tsai wrote: =20
> > > > On Tue, Dec 17, 2024 at 2:01=E2=80=AFAM Chris Morgan <macroalpha82@=
gmail.com> wrote:   =20
> > > > >
> > > > > On Wed, Dec 11, 2024 at 09:58:26PM +0000, Jonathan Cameron wrote:=
   =20
> > > > > > On Tue, 10 Dec 2024 16:48:57 -0600
> > > > > > Chris Morgan <macroalpha82@gmail.com> wrote:
> > > > > >   =20
> > > > > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > > > >
> > > > > > > After performing a git bisect, I identified a commit that bro=
ke the
> > > > > > > battery and charger driver for my AXP717 PMIC. This was cause=
d by
> > > > > > > commit e37ec3218870 ("mfd: axp20x: Allow multiple regulators"=
).
> > > > > > >
> > > > > > > After digging into it, it appears when mfd_add_devices was ca=
lled with
> > > > > > > a platform ID of PLATFORM_DEVID_NONE, the devm_iio_channel_ge=
t() call
> > > > > > > made by the various AXP20X power drivers would not be able to=
 generate
> > > > > > > a dev_name(dev) for some reason, and the iio_channel_get() ca=
ll used in
> > > > > > > the devm_ helper would fall back to making a iio_channel_get_=
sys()
> > > > > > > call. After the platform ID was updated, now iio_channel_get(=
) is no
> > > > > > > longer falling back to iio_channel_get_sys(). At least this i=
s my
> > > > > > > limited understanding of what happened.   =20
> > > > > >
> > > > > > The dev_name(dev) not getting a name doesn't sound quite right =
to me.
> > > > > >
> > > > > > Time to look at the ancient creaking ghost that is the iio_map =
handling.
> > > > > >
> > > > > > struct iio_channel *iio_channel_get(struct device *dev,
> > > > > >                                   const char *channel_name)
> > > > > > {
> > > > > >       const char *name =3D dev ? dev_name(dev) : NULL;
> > > > > >       struct iio_channel *channel;
> > > > > >
> > > > > >       if (dev) {
> > > > > >               channel =3D fwnode_iio_channel_get_by_name(dev_fw=
node(dev),
> > > > > >                                                        channel_=
name);
> > > > > >               if (!IS_ERR(channel) || PTR_ERR(channel) !=3D -EN=
ODEV)
> > > > > >                       return channel;
> > > > > >       }
> > > > > >
> > > > > >       return iio_channel_get_sys(name, channel_name);
> > > > > > }
> > > > > > EXPORT_SYMBOL_GPL(iio_channel_get);
> > > > > >
> > > > > > We didn't invent the relevant phandle stuff in DT via the patch=
 you point at
> > > > > > so all that matters is what gets passed to that iio_channel_get=
_sys()
> > > > > >
> > > > > > So key here is that dev should be set, so we are passing dev_na=
me(dev) into
> > > > > > iio_channel_get_sys()
> > > > > > I'm guessing that changed...
> > > > > >
> > > > > > Ah.  The iio_maps in
> > > > > > https://elixir.bootlin.com/linux/v6.12.4/source/drivers/iio/adc=
/axp20x_adc.c#L158
> > > > > > are our problem. Those hardcode the consumer_dev name. The fix =
just changed
> > > > > > those names. Back when this infrastructure was written we were =
in the world of
> > > > > > board files, so everything was hard coded in them - or in an MF=
D like this
> > > > > > it was treated as a singleton device.
> > > > > >
> > > > > > So as to how to fix it... Assuming the new device names are the=
 same for all
> > > > > > the mfd parts that make up each pmic, then you should be able t=
o figure out the
> > > > > >  extra the number and build the channel maps to allow you to fi=
nd the numbered
> > > > > > devices.   =20
> > > > >
> > > > > Is there a way to figure out the device number at runtime? The is=
sue is
> > > > > each time the device attempts to probe and fails, the device numb=
er
> > > > > increments, making it a "hitting a moving target" problem.   =20
> > > >=20
> > > > The ADC device is a mfd cell or child device of the PMIC mfd device.
> > > > So you should be able to use dev->parent to get it directly? We do
> > > > that at least for the regulator driver.   =20
> > >=20
> > > Sorry to dig up such an old thread. I'm taking a look at this one aga=
in
> > > and can confirm passing pdev->dev.parent to devm_iio_channel_get() is
> > > insufficient to get the driver to find the correct ADC channel. Would
> > > there be another/better way to do this other than the
> > > devm_iio_channel_get_sys() as proposed? Or should we be walking the
> > > parent somehow looking for the named ADC channel on each child device
> > > (which would also require a new symbol most likely)? =20
> >=20
> > Hi Chris
> >=20
> > From what I recall the point was to get the number from pdev->dev.parent
> > rather than simply passing it to the devm_iio_channel_get() call.
> >=20
> > That should allow building of channel maps that provide the correct
> > device name to allow the provider to be found.
> >=20
> > Jonathan =20
>=20
> I don't suppose you have a few more tips, do you? I'm still kind of
> lost. I was able to crawl the parent node until I gathered the correct
> device struct pointer of the adc device, but even passing it to the
> devm_iio_channel_get() still doesn't work. I'm thinking that maybe it's
> because devm_iio_channel_get() then calls iio_channel_get() which then
> calls fwnode_iio_channel_get_by_name() which then calls
> __fwnode_iio_channel_get_by_name() which fails because there is no=20
> "io-channel-names" property in the device tree (because the driver hard
> codes the channel names). Now a call to iio_channel_get_sys() would
> work for me in this case, but I'm starting to wonder how it might work
> if we had more than one PMIC (which is the whole point of what the
> original fix and revert was trying to solve) so we might have to figure
> out a more elegant solution..
>=20
This isn't about doing things directly with the parent, but rather modifyin=
g the
map at creation time to contain the correct naming for the consumers.

So look at the existing struct iio_map arrays in the driver. You are going
to need to do a kmem_dup() to get your own copy to edit.  Then look up
the naming of the various child nodes via the parent (e.g. the mfd).
That will use device_for_each_child() to find a match to first part
of name and then the ID (which is available on the platform_device
structure).  Key is the naming will come from;
https://elixir.bootlin.com/linux/v6.13.5/source/drivers/base/platform.c#L686
(I think anyway) which is built up using the original node name
and the id (+ a suffix of .auto).

You can then fill those into the struct iio_map array copy.
Ugly corner is that we need the adc mfd child to be registered last
but that we should be able to manage.

Looking back at the thread, the issue you refer to on devices being
renumbered is a pain though.  without thinking that much about it,
that renaming feels like a bug to me as I'd really expect device
naming of the children to be static after the mfd has loaded.
Or does this renumbering only happen if the mfd probe fails?
If it's that case it won't matter for this work around.

Hope that gives you an idea.

The whole things is ugly but it is hard to set up the equivalent
of device tree pnode handles without the infrastructure so we
tend to end up with names like this code.
I'd be happy to see something else generic but not sure what it
would look like.

Jonathan

> Thank you,
> Chris
>=20
> >  =20
> > >=20
> > > Thank you,
> > > Chris
> > >  =20
> > > >=20
> > > > ChenYu
> > > >    =20
> > > > > Thank you,
> > > > > Chris
> > > > >   =20
> > > > > >
> > > > > > That's a lot lighter change than moving over to DT based phandl=
es for all this.
> > > > > > (which is the modern way to handle it).
> > > > > >
> > > > > > As a cheeky check, just edit those maps to whatever IDs you hav=
e and see
> > > > > > if it works.  Probably not an upstreamable solution but will co=
nfirm we have
> > > > > > it correct.
> > > > > >
> > > > > > Your patch works because we allow for some fuzzy matching (I ca=
n't remember
> > > > > > why) that doesn't use the consumer device name.
> > > > > > That works as long as there is only one instance.  I'm guessing=
 all this
> > > > > > mess came about because someone has a board with two of these d=
evices. On such
> > > > > > a board we need the precise matching including the device name.
> > > > > >
> > > > > > Jonathan
> > > > > >   =20
> > > > > > >
> > > > > > > To fix this, I added a new devm_ helper of devm_iio_channel_g=
et_sys()
> > > > > > > that directly calls iio_channel_get_sys(), and I updated all =
the
> > > > > > > affected drivers with the new routine. I then no longer exper=
ienced
> > > > > > > any issues with the drivers on my devices.
> > > > > > >
> > > > > > > Chris Morgan (2):
> > > > > > >   iio: core: Add devm_ API for iio_channel_get_sys
> > > > > > >   power: supply: axp20x: Use devm_iio_channel_get_sys() for i=
io chans
> > > > > > >
> > > > > > >  drivers/iio/inkern.c                    | 18 +++++++++++++++=
+++
> > > > > > >  drivers/power/supply/axp20x_ac_power.c  |  4 ++--
> > > > > > >  drivers/power/supply/axp20x_battery.c   | 16 ++++++++--------
> > > > > > >  drivers/power/supply/axp20x_usb_power.c |  6 +++---
> > > > > > >  include/linux/iio/consumer.h            | 20 +++++++++++++++=
+++++
> > > > > > >  5 files changed, 51 insertions(+), 13 deletions(-)
> > > > > > >   =20
> > > > > >   =20
> > >  =20
> >  =20


