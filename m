Return-Path: <linux-iio+bounces-6051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1919011CF
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746562827A4
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B778015CD4D;
	Sat,  8 Jun 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPx8Ldb4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715774C65;
	Sat,  8 Jun 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717855427; cv=none; b=Kw/Tg+dWqZEEnzTOTogUxQN/Vf4WT7DOPYrIxj0aJpe/qPp7lgtxFjoDnOWfKY/7BzcJVJoOR2a+YJiTrITh3Q4stBTbmZlFsotJLj8cTb5pFfOM0GcOw/7rLnz9c/3kfSFx886HzbfmYqrHb+o1pIcGXKzvFXS51mXYf3sRFbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717855427; c=relaxed/simple;
	bh=Hl7JElkJcbdHpUtB65SLQIwMa2FPm6koXDztf5INB2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQl7vy2qaMLElf4Z1PCkt8ZqSJpI6xPq6b44k9Fn6j648kdXhAqGCModONzR9Fm7oZwMZGp3MQZS1NQ88o7AlLhQbWaFQbUTWs6palFr/E6FLbozLNiNoxe8ewEReqEgIl4Wra4NcgFlYEYr4CCA+aujJwNL100xuLYWAlyuGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPx8Ldb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CB4C2BD11;
	Sat,  8 Jun 2024 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717855427;
	bh=Hl7JElkJcbdHpUtB65SLQIwMa2FPm6koXDztf5INB2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GPx8Ldb4VVgxo75lr7ZV6H7JG22n6bMhkHEJm/RmkRzsD5GMNoyY8BQUlolCTf+Ea
	 xGgQx1X58mq6W2CcJESG46g54I2jasFjgK1846RgWlVRW5vuV9ELsa1eV+z6S/T1Qa
	 7CCR+urxGyNOabOBZ+IWID1SCFoXOnTeUAjriUQ/S2IWXsPfLa3Gk5eICsohyR4SIK
	 GWQ0Aw5fR1555q93FTAtJdMCwz+5FuHRYp5pwrhghZ0G3ovqEXMWaPBCKsESt7hS2I
	 3ru07fHtvHt+7q4ks0X6GYcGBkXmIx0rcRldFFf9L7ZTgQOwng+tFdxSsBtSjtn8V+
	 QNC75seFk5Atw==
Date: Sat, 8 Jun 2024 15:03:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "O'Griofa, Conall"
 <conall.ogriofa@amd.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Message-ID: <20240608150340.06e8c1e2@jic23-huawei>
In-Reply-To: <f789d5b8-46d4-47ab-a74b-72daf72116a0@linux.dev>
References: <20240311162800.11074-1-sean.anderson@linux.dev>
	<20240314154824.37150a54@jic23-huawei>
	<a9ed95ec-aafe-49f6-93dd-c94c73620de2@linux.dev>
	<DM6PR12MB4217EAA1049F815F234EE6D18B282@DM6PR12MB4217.namprd12.prod.outlook.com>
	<3b481539-0c9c-4110-ad03-bd252e80efb0@linux.dev>
	<20240316133627.5d2bf585@jic23-huawei>
	<7ee83f15-88fc-4530-84b7-b8ee31663dbc@linux.dev>
	<20240318152446.00001345@Huawei.com>
	<7ddf8d4a-5b68-432d-93c1-ff270403cb60@linux.dev>
	<20240319134258.0000574d@Huawei.com>
	<f789d5b8-46d4-47ab-a74b-72daf72116a0@linux.dev>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Jun 2024 13:42:19 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 3/19/24 09:42, Jonathan Cameron wrote:
> > On Mon, 18 Mar 2024 11:28:49 -0400
> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >  =20
> >> On 3/18/24 11:24, Jonathan Cameron wrote: =20
> >> > On Mon, 18 Mar 2024 11:18:43 -0400
> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >> >    =20
> >> >> On 3/16/24 09:36, Jonathan Cameron wrote:   =20
> >> >> > On Fri, 15 Mar 2024 13:47:40 -0400
> >> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >> >> >      =20
> >> >> >> Hi Conall,
> >> >> >>=20
> >> >> >> On 3/15/24 09:18, O'Griofa, Conall wrote:     =20
> >> >> >> > [AMD Official Use Only - General]
> >> >> >> >=20
> >> >> >> > Hi,
> >> >> >> >=20
> >> >> >> > I think there was a fix for this issue applied to the version =
that was running on 5.15 that didn't seem to make it into the upstream driv=
er.
> >> >> >> > Please see link for reference https://github.com/Xilinx/linux-=
xlnx/commit/608426961f16ab149b1b699f1c35f7ad244c0720
> >> >> >> >=20
> >> >> >> > I think a similar fix to the above patch is may be beneficial?=
       =20
> >> >> >>=20
> >> >> >> These patches look functionally identical to me.     =20
> >> >> >=20
> >> >> > Because there are no channels with scan index between
> >> >> > 22 * 2 + 16 (that patch) and 22 * 3 (your patch) that is
> >> >> > the effect is indeed the same. But given the issues is the
> >> >> > 64 limit on maximum scan index, 22 * 3 =3D 66 is an ugly value
> >> >> > to compare with.
> >> >> >=20
> >> >> > I'm still very against the use of scan_index for anything other
> >> >> > than scan indices (which is why partly how this bug wasn't noticed
> >> >> > in the first palce). So the check should be scan_index !=3D -1
> >> >> > and uses of those values elsewhere in the driver should be fixed
> >> >> > (which looks simple to do from a quick glance at the code).     =
=20
> >> >>=20
> >> >> OK, so how do the sysfs files get named then?   =20
> >> >=20
> >> > Using channel and channel2 as appropriate (+ index and modified
> >> > which change the meaning of channel2) - scan_index never had
> >> > anything to do with sysfs file names - just the value in
> >> > bufferX/in_xyz_scan_index   =20
> >>=20
> >> I tried to prototype setting scan_index to -1, but when registering ch=
annels I saw
> >>=20
> >> [    1.637049] iio iio:device0: tried to double register : in_voltage_=
raw
> >> [    1.637245] xilinx-ams ffa50000.ams: Failed to register sysfs inter=
faces
> >> [    1.637433] xilinx-ams: probe of ffa50000.ams failed with error -16
> >>=20
> >> And AIUI .channel is filled in by ams_parse_firmware. =20
> >=20
> > Is indexed set for the channel?  Check it at the point of calling
> > devm_iio_device_register() as the code that builds the channels in this
> > driver is complex, so maybe it's getting overwritten?
> >=20
> > There might be a core bug somewhere, but there are other drivers using
> > -1 scan index without hitting this problem so my first instinct is
> > something is getting wrongly set in the driver. =20
>=20
> Upon further review, I think scan_index should remain the same, and this
> patch should be applied as-is.
>=20
> address is the only driver-private data in all of iio_chan_spec.
> Unfortunately, it is suggestively named "address" and not "priv" or
> "driver_id" or something similar. So the original author of this driver
> went "Ah, I should put the channel address offsets in this register."
> Except, because this driver has three address spaces, this is not enough
> to uniquely identify the channel. So he then stuck an actual unique
> identifier in scan_index. Now, you may object to this since the driver
> doesn't actually support scans, but that is the current situation.
>=20
> So there is really nothing wrong with scan_index semantically in the
> context of the driver. We should not convert one address space's
> channels to use -1 scan_index, since it is used as a unique identifier
> elsewhere in the channel.
>=20
> Future patches could convert scan_index to address, and store the
> address offsets in an array. So e.g. reading a channel would go from
> e.g.
>=20
> 	if (chan->scan_index >=3D AMS_PS_SEQ_MAX)
> 		*val =3D readl(ams->pl_base + chan->address);
> 	else
> 		*val =3D readl(ams->ps_base + chan->address);
>=20
> to
>=20
> 	if (chan->address >=3D AMS_PS_SEQ_MAX)
> 		*val =3D readl(ams->pl_base + ams_chan_addr[chan->address]);
> 	else
> 		*val =3D readl(ams->ps_base + ams_chan_addr[chan->address]);
>=20
> which while strictly less perfmant due to another level of indirection
> does conform to existing semantics for scan_index. But TBH I don't see
> much point in this.
>=20
> But the above change would be pretty significant and has a chance of
> causing bugs of its own. So I would rather this bug fix be applied as-is
> and the scan_index semantics be modified at some other time.
Ok.  I'll pick this one up, but I'd either like the change you mention above
or maybe as a lesser nice but easier solution, a patch adding comments
on the use of scan_index in this driver.

Applied to the fixes-togreg branch of iio.git.  Thanks for figuring out
what happened here and the clear explanation.

Jonathan

>=20
> --Sean
>=20
> >>=20
> >> --Sean
> >>  =20
> >> >>=20
> >> >> --Sean
> >> >>    =20
> >> >> >>=20
> >> >> >> --Sean
> >> >> >>      =20
> >> >> >> >> -----Original Message-----
> >> >> >> >> From: Sean Anderson <sean.anderson@linux.dev>
> >> >> >> >> Sent: Thursday, March 14, 2024 5:30 PM
> >> >> >> >> To: Jonathan Cameron <jic23@kernel.org>
> >> >> >> >> Cc: linux-iio@vger.kernel.org; O'Griofa, Conall <conall.ogrio=
fa@amd.com>;
> >> >> >> >> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kerne=
l.org; Lars-Peter
> >> >> >> >> Clausen <lars@metafoo.de>
> >> >> >> >> Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_=
channels in
> >> >> >> >> scan_mask
> >> >> >> >>
> >> >> >> >> Caution: This message originated from an External Source. Use=
 proper caution
> >> >> >> >> when opening attachments, clicking links, or responding.
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> On 3/14/24 11:48, Jonathan Cameron wrote:       =20
> >> >> >> >> > On Mon, 11 Mar 2024 12:28:00 -0400
> >> >> >> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >> >> >> >> >       =20
> >> >> >> >> >> ams_enable_channel_sequence constructs a "scan_mask" for a=
ll the PS
> >> >> >> >> >> and PL channels. This works out fine, since scan_index for=
 these
> >> >> >> >> >> channels is less than 64. However, it also includes the
> >> >> >> >> >> ams_ctrl_channels, where scan_index is greater than 64, tr=
iggering
> >> >> >> >> >> undefined behavior. Since we don't need these channels any=
way, just       =20
> >> >> >> >> exclude them.       =20
> >> >> >> >> >>
> >> >> >> >> >> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> >> >> >> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>    =
   =20
> >> >> >> >> >
> >> >> >> >> > Hi Sean,
> >> >> >> >> >
> >> >> >> >> > I'd ideally like to understand why we have channels with su=
ch large
> >> >> >> >> > scan indexes.  Those values should only be used for buffere=
d capture.
> >> >> >> >> > It feels like they are being abused here.  Can we set them =
to -1
> >> >> >> >> > instead and check based on that?
> >> >> >> >> > For a channel, a scan index of -1 means it can't be capture=
d via the
> >> >> >> >> > buffered interfaces but only accessed via sysfs reads.
> >> >> >> >> > I think that's what we have here?       =20
> >> >> >> >>
> >> >> >> >> From what I can tell, none of the channels support buffered r=
eads. And we can't
> >> >> >> >> nai=CC=88vely convert the scan_index to -1, since that causes=
 sysfs naming conflicts
> >> >> >> >> (not to mention the compatibility break).
> >> >> >> >>       =20
> >> >> >> >> >
> >> >> >> >> > I just feel like if we leave these as things stand, we will=
 get bitten
> >> >> >> >> > by similar bugs in the future.  At least with -1 it should =
be obvious why!       =20
> >> >> >> >>
> >> >> >> >> There are just as likely to be bugs confusing the PL/PS subde=
vices...
> >> >> >> >>
> >> >> >> >> FWIW I had no trouble identifying the channels involved with =
this bug.
> >> >> >> >>
> >> >> >> >> --Sean
> >> >> >> >>       =20
> >> >> >> >> > Jonathan
> >> >> >> >> >
> >> >> >> >> >       =20
> >> >> >> >> >> ---
> >> >> >> >> >>
> >> >> >> >> >>  drivers/iio/adc/xilinx-ams.c | 8 ++++++--
> >> >> >> >> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >> >> >> >> >>
> >> >> >> >> >> diff --git a/drivers/iio/adc/xilinx-ams.c
> >> >> >> >> >> b/drivers/iio/adc/xilinx-ams.c index a55396c1f8b2..4de7ce5=
98e4d
> >> >> >> >> >> 100644
> >> >> >> >> >> --- a/drivers/iio/adc/xilinx-ams.c
> >> >> >> >> >> +++ b/drivers/iio/adc/xilinx-ams.c
> >> >> >> >> >> @@ -414,8 +414,12 @@ static void ams_enable_channel_sequen=
ce(struct
> >> >> >> >> >> iio_dev *indio_dev)
> >> >> >> >> >>
> >> >> >> >> >>      /* Run calibration of PS & PL as part of the sequence=
 */
> >> >> >> >> >>      scan_mask =3D BIT(0) | BIT(AMS_PS_SEQ_MAX);
> >> >> >> >> >> -    for (i =3D 0; i < indio_dev->num_channels; i++)
> >> >> >> >> >> -            scan_mask |=3D BIT_ULL(indio_dev->channels[i]=
.scan_index);
> >> >> >> >> >> +    for (i =3D 0; i < indio_dev->num_channels; i++) {
> >> >> >> >> >> +            const struct iio_chan_spec *chan =3D
> >> >> >> >> >> + &indio_dev->channels[i];
> >> >> >> >> >> +
> >> >> >> >> >> +            if (chan->scan_index < AMS_CTRL_SEQ_BASE)
> >> >> >> >> >> +                    scan_mask |=3D BIT_ULL(chan->scan_ind=
ex);
> >> >> >> >> >> +    }
> >> >> >> >> >>
> >> >> >> >> >>      if (ams->ps_base) {
> >> >> >> >> >>              /* put sysmon in a soft reset to change the s=
equence */       =20
> >> >> >> >> >       =20
> >> >> >>      =20
> >> >> >      =20
> >> >>=20
> >> >>    =20
> >> >    =20
> >>  =20
> >  =20


