Return-Path: <linux-iio+bounces-16394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384C1A4F17D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 00:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9057A3279
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 23:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D0F278170;
	Tue,  4 Mar 2025 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOrmORN2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40BD1F4CB0;
	Tue,  4 Mar 2025 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130965; cv=none; b=mBd8YPqeLkMYnB8Z3+iWQRpCPubAHGmlM54+VvJMq/sSPus6MQDTeCK5ghB5y6oXUNDeUHqfJHJvVUXAuFrvdTvlSHIG5AgpgnBVG3WMEdB29TrEDLWxPa9amTXFiLymvpxtqzoLCOPL8kCNQ3a1fF0gmazmmrYYusK8CPV2IpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130965; c=relaxed/simple;
	bh=wRG2/3guVplG1fzSZhJr0O1MeFWo6h3depSrnEEaUuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gi785SLykDpnbi7ak3wEWSPa/hVtEU6zWHIuisXRyZUu3V0BUhJr62KMltA+Q2GkRMfHgrt9mWq8JI8oLVWZvK/qgfhGpMYcXjK7uY7q8OVJ6+zAW/1g9ha9io2TiM4f7KbS+8VTIzwb7va1YzTJmog230eMhOc1HjfH0crzclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOrmORN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96B2C4CEE5;
	Tue,  4 Mar 2025 23:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741130965;
	bh=wRG2/3guVplG1fzSZhJr0O1MeFWo6h3depSrnEEaUuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EOrmORN2cXFTtf4xgHiVYacgPtdIj2PQA1cmWGAFXVYhMfjY7YuzjdVqAsAsZSADp
	 UGqFfkNr+DFxISDtg+Q+k5Az2dOBTpoIGL3GjJXWEiV5KG8JgfM3SSKtccM51wQnXU
	 G6TKC4yEQm21V8tk+mdY+99FWnkCGpQJaobQwK+08f9F2CPkAOUfmzex5leU+eejHe
	 0QvA8ePd8Pl1REBqPOBtS0l+ZT62q6Fymi6acNTTr98B8OaqYB+YVKCYNNtTBD6ktP
	 P2RskC78fqw78Qi+JWLmtEmuZrlc/Eha9leWs4hTj3sUl72Js/mfYFzixTWs+tJLUL
	 Oyy5tLEa7kINw==
Date: Tue, 4 Mar 2025 23:29:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
 linux-iio@vger.kernel.org, andre.przywara@arm.com, lee@kernel.org,
 sre@kernel.org, lars@metafoo.de, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 0/2] Fix Regression with AXP20X for 6.13-rc1
Message-ID: <20250304232913.020056fa@jic23-huawei>
In-Reply-To: <67c743e3.050a0220.327e31.55b3@mx.google.com>
References: <20241210224859.58917-1-macroalpha82@gmail.com>
	<20241211215826.06162190@jic23-huawei>
	<67606b09.050a0220.3905d.5bc7@mx.google.com>
	<CAGb2v64vn-h02Bn2AKftphpNNcx9h9K3pKvdjuANsDhwiqbsrQ@mail.gmail.com>
	<67c743e3.050a0220.327e31.55b3@mx.google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Mar 2025 12:18:10 -0600
Chris Morgan <macroalpha82@gmail.com> wrote:

> On Tue, Dec 17, 2024 at 02:04:37AM +0800, Chen-Yu Tsai wrote:
> > On Tue, Dec 17, 2024 at 2:01=E2=80=AFAM Chris Morgan <macroalpha82@gmai=
l.com> wrote: =20
> > >
> > > On Wed, Dec 11, 2024 at 09:58:26PM +0000, Jonathan Cameron wrote: =20
> > > > On Tue, 10 Dec 2024 16:48:57 -0600
> > > > Chris Morgan <macroalpha82@gmail.com> wrote:
> > > > =20
> > > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > >
> > > > > After performing a git bisect, I identified a commit that broke t=
he
> > > > > battery and charger driver for my AXP717 PMIC. This was caused by
> > > > > commit e37ec3218870 ("mfd: axp20x: Allow multiple regulators").
> > > > >
> > > > > After digging into it, it appears when mfd_add_devices was called=
 with
> > > > > a platform ID of PLATFORM_DEVID_NONE, the devm_iio_channel_get() =
call
> > > > > made by the various AXP20X power drivers would not be able to gen=
erate
> > > > > a dev_name(dev) for some reason, and the iio_channel_get() call u=
sed in
> > > > > the devm_ helper would fall back to making a iio_channel_get_sys()
> > > > > call. After the platform ID was updated, now iio_channel_get() is=
 no
> > > > > longer falling back to iio_channel_get_sys(). At least this is my
> > > > > limited understanding of what happened. =20
> > > >
> > > > The dev_name(dev) not getting a name doesn't sound quite right to m=
e.
> > > >
> > > > Time to look at the ancient creaking ghost that is the iio_map hand=
ling.
> > > >
> > > > struct iio_channel *iio_channel_get(struct device *dev,
> > > >                                   const char *channel_name)
> > > > {
> > > >       const char *name =3D dev ? dev_name(dev) : NULL;
> > > >       struct iio_channel *channel;
> > > >
> > > >       if (dev) {
> > > >               channel =3D fwnode_iio_channel_get_by_name(dev_fwnode=
(dev),
> > > >                                                        channel_name=
);
> > > >               if (!IS_ERR(channel) || PTR_ERR(channel) !=3D -ENODEV)
> > > >                       return channel;
> > > >       }
> > > >
> > > >       return iio_channel_get_sys(name, channel_name);
> > > > }
> > > > EXPORT_SYMBOL_GPL(iio_channel_get);
> > > >
> > > > We didn't invent the relevant phandle stuff in DT via the patch you=
 point at
> > > > so all that matters is what gets passed to that iio_channel_get_sys=
()
> > > >
> > > > So key here is that dev should be set, so we are passing dev_name(d=
ev) into
> > > > iio_channel_get_sys()
> > > > I'm guessing that changed...
> > > >
> > > > Ah.  The iio_maps in
> > > > https://elixir.bootlin.com/linux/v6.12.4/source/drivers/iio/adc/axp=
20x_adc.c#L158
> > > > are our problem. Those hardcode the consumer_dev name. The fix just=
 changed
> > > > those names. Back when this infrastructure was written we were in t=
he world of
> > > > board files, so everything was hard coded in them - or in an MFD li=
ke this
> > > > it was treated as a singleton device.
> > > >
> > > > So as to how to fix it... Assuming the new device names are the sam=
e for all
> > > > the mfd parts that make up each pmic, then you should be able to fi=
gure out the
> > > >  extra the number and build the channel maps to allow you to find t=
he numbered
> > > > devices. =20
> > >
> > > Is there a way to figure out the device number at runtime? The issue =
is
> > > each time the device attempts to probe and fails, the device number
> > > increments, making it a "hitting a moving target" problem. =20
> >=20
> > The ADC device is a mfd cell or child device of the PMIC mfd device.
> > So you should be able to use dev->parent to get it directly? We do
> > that at least for the regulator driver. =20
>=20
> Sorry to dig up such an old thread. I'm taking a look at this one again
> and can confirm passing pdev->dev.parent to devm_iio_channel_get() is
> insufficient to get the driver to find the correct ADC channel. Would
> there be another/better way to do this other than the
> devm_iio_channel_get_sys() as proposed? Or should we be walking the
> parent somehow looking for the named ADC channel on each child device
> (which would also require a new symbol most likely)?

Hi Chris

=46rom what I recall the point was to get the number from pdev->dev.parent
rather than simply passing it to the devm_iio_channel_get() call.

That should allow building of channel maps that provide the correct
device name to allow the provider to be found.

Jonathan

>=20
> Thank you,
> Chris
>=20
> >=20
> > ChenYu
> >  =20
> > > Thank you,
> > > Chris
> > > =20
> > > >
> > > > That's a lot lighter change than moving over to DT based phandles f=
or all this.
> > > > (which is the modern way to handle it).
> > > >
> > > > As a cheeky check, just edit those maps to whatever IDs you have an=
d see
> > > > if it works.  Probably not an upstreamable solution but will confir=
m we have
> > > > it correct.
> > > >
> > > > Your patch works because we allow for some fuzzy matching (I can't =
remember
> > > > why) that doesn't use the consumer device name.
> > > > That works as long as there is only one instance.  I'm guessing all=
 this
> > > > mess came about because someone has a board with two of these devic=
es. On such
> > > > a board we need the precise matching including the device name.
> > > >
> > > > Jonathan
> > > > =20
> > > > >
> > > > > To fix this, I added a new devm_ helper of devm_iio_channel_get_s=
ys()
> > > > > that directly calls iio_channel_get_sys(), and I updated all the
> > > > > affected drivers with the new routine. I then no longer experienc=
ed
> > > > > any issues with the drivers on my devices.
> > > > >
> > > > > Chris Morgan (2):
> > > > >   iio: core: Add devm_ API for iio_channel_get_sys
> > > > >   power: supply: axp20x: Use devm_iio_channel_get_sys() for iio c=
hans
> > > > >
> > > > >  drivers/iio/inkern.c                    | 18 ++++++++++++++++++
> > > > >  drivers/power/supply/axp20x_ac_power.c  |  4 ++--
> > > > >  drivers/power/supply/axp20x_battery.c   | 16 ++++++++--------
> > > > >  drivers/power/supply/axp20x_usb_power.c |  6 +++---
> > > > >  include/linux/iio/consumer.h            | 20 ++++++++++++++++++++
> > > > >  5 files changed, 51 insertions(+), 13 deletions(-)
> > > > > =20
> > > > =20
>=20


