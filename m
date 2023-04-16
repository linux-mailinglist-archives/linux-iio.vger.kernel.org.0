Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD136E38AA
	for <lists+linux-iio@lfdr.de>; Sun, 16 Apr 2023 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDPNdR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Apr 2023 09:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPNdQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Apr 2023 09:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B51BD4
        for <linux-iio@vger.kernel.org>; Sun, 16 Apr 2023 06:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E8BF61044
        for <linux-iio@vger.kernel.org>; Sun, 16 Apr 2023 13:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A1CC433D2;
        Sun, 16 Apr 2023 13:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681651993;
        bh=xgl5BCPe0jt/UonDfv4v9hNJ/LdvR2kDrPQias0gZCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E/hzJ0miA3UFy+PrKjY5msN6c2aNYrvM7rfIdb2D1IdbI7hkA5hlwIlVzfz7N9LCd
         wHKdV4HOkJtC87Y5Ybq0jM1g3azQHThNakNvpxvjM2OvL+jcPj8pHJYpIOclrFwi/n
         2c+MvutNfUU3W6TO13pCHyjq0ow5B8WotYxiFAIom+162Pdb/qAtZYt0j1aPDE+J2z
         UvJz9WyENw8xpoTdEdGliRDU8ERUDd2w41PGkJcwj161Q4nOdb97ZpM0xVWwUFRCgW
         OCaQ4SaDp5147dKoJgLBEkeO3Hc4Ah2RvSh+pIFiIuJPRx3rC4rYek86SAs7yD43vV
         rNSFfhBvIYuTQ==
Date:   Sun, 16 Apr 2023 14:33:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: adi-axi-adc issues and how to properly support this designs
Message-ID: <20230416143316.59dca9f3@jic23-huawei>
In-Reply-To: <d5c0f825838f84f734d5af1f26bb0eac915532d5.camel@gmail.com>
References: <dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com>
        <20230410132138.6c5b4c87@jic23-huawei>
        <d5c0f825838f84f734d5af1f26bb0eac915532d5.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Apr 2023 11:11:43 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Hi Jonathan,
>=20
> Thanks for the feedback. Definitely helpful...
>=20
> On Mon, 2023-04-10 at 13:21 +0100, Jonathan Cameron wrote:
> > On Fri, 31 Mar 2023 16:40:44 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > Hi Jonathan,
> > >  =20
> >=20
> > Hmm. Complex topic, so I'd definitely like others to weigh in with
> > opinions .
> >  =20
> > > There are some major issues with the implementation we have upstream
> > > for the adi-axi-adc driver. The only user is the ad9467 driver. In the
> > > rest of the email I will refer to ad9467 as the converter device and
> > > axi-adc as the IP core.=20
> > >=20
> > > Let me start to state that these designs, in a very a basic way, have=
 a
> > > converter connected to a IP core that typically lives in a FPGA. This
> > > core connects to a DMA core (which is used by the DMA buffer
> > > implementation) so we can keep up with the high rates of these
> > > converters. So there's a link between these devices and we try to
> > > implement that so far looking at them as one single IIO device.
> > >=20
> > > Let's go to the major issues now:
> > >=20
> > > 1) There is a circular dependency between the two device. And when
> > > compiled as modules for example, we cannot really rmmod the modules
> > > anymore:
> > >=20
> > > "root@analog:~# rmmod ad9467
> > > rmmod: ERROR: Module ad9467 is in use
> > >=20
> > > root@analog:~# rmmod adi-axi-adc.ko
> > > rmmod: ERROR: Module adi_axi_adc is in use by: ad9467
> > > "
> > >=20
> > > This easy to understand as the ad9467 driver as a direct symbol
> > > dependency on the axi-adc one. And this one calls 'module_get()' as
> > > soon as it attaches to a "client" =20
> >=20
> > Ouch. module_get() never works for this.=C2=A0 Long time ago I thought =
it
> > did :(=C2=A0 An unbind will bypass that (as well any real hot unplug pa=
ths).
> >  =20
>=20
> Yeps, it bypasses it but I just wanted to point out the flaw in the curre=
nt design :)

It was a surprise to me when Lars pointed this out years ago.
All we can do is treat it as a hint for something that makes
little sense for a user to deliberately do.

>=20
> >  =20
> > >=20
> > > 2) It's fairly easy to crash the kernel:
> > >=20
> > > "
> > > root@analog:/sys/bus/spi/drivers/ad9467# echo spi0.0 > unbind
> > > root@analog:/sys/bus/iio/devices/iio:device2# echo 1 >
> > > buffer0/in_voltage0_en
> > > root@analog:/sys/bus/iio/devices/iio:device2# echo 1 > buffer0/enable
> > > [=C2=A0 132.349133] 8<--- cut here ---
> > > [=C2=A0 132.352193] Unable to handle kernel paging request at virtual
> > > address e0940000 when read
> > > [=C2=A0 132.360333] [e0940000] *pgd=3D0208b811, *pte=3D00000000, *ppt=
e=3D00000000
> > > [=C2=A0 132.366668] Internal error: Oops: 7 [#1] SMP ARM
> > > [=C2=A0 132.371289] Modules linked in: ad9467 adi_axi_adc ad9517
> > > [=C2=A0 132.376609] CPU: 1 PID: 444 Comm: bash Not tainted 6.2.9-dirt=
y #3
> > > [=C2=A0 132.382701] Hardware name: Xilinx Zynq Platform
> > > [=C2=A0 132.387223] PC is at adi_axi_adc_update_scan_mode+0x34/0x88
> > > [adi_axi_adc]
> > > [=C2=A0 132.394020] LR is at arm_heavy_mb+0x1c/0x38
> > > [=C2=A0 132.398212] pc : [<bf0060c4>]=C2=A0=C2=A0=C2=A0 lr : [<c03182=
0c>]=C2=A0=C2=A0=C2=A0 psr: a0000013
> > > [=C2=A0 132.404392] sp : e0929e30=C2=A0 ip : deaddead=C2=A0 fp : c443=
0270
> > > [=C2=A0 132.409678] r10: c8a0bc18=C2=A0 r9 : deaddeac=C2=A0 r8 : c89b=
1c00
> > > [=C2=A0 132.414895] r7 : c4430340=C2=A0 r6 : c45db7c0=C2=A0 r5 : e093=
ffc0=C2=A0 r4 :
> > > 000003f0
> > > [=C2=A0 132.421413] r3 : 00010000=C2=A0 r2 : e0940000=C2=A0 r1 : 0000=
0000=C2=A0 r0 :
> > > 00000000
> > > " =20
> >=20
> > It's nasty but generally that sort of path can be prevented with some
> > careful locking and checking of indicators that a component has gone aw=
ay.
> > So whenever you unbind one aspect it notifies the other one that it has=
 gone
> > away. I'm not sure where to currently look for best practice in this.
> >=20
> > There are a lot of similar situations - basically anywhere a set of=20
> > drivers end up hanging off two buses.=C2=A0 v4l and media drivers in ge=
neral
> > end up doing this a lot.
> >=20
> > One I'm familiar with is how some of the CXL tear down happens and
> > that lead me to device_release_driver() which is also used by usb etc.
> > I've not looked at this for a while but it may provide the tear down ne=
eded
> > if the right dance is used.=C2=A0 I think that will work if your conver=
tor
> > driver is using services off the IP core driver and someone unbinds
> > that ip-core driver.
> >  =20
>=20
> Yes, CCF does it with refcounting and some dummy clock ops for the case a=
 clock
> provider is gone (with active consumers).

That must be 'exciting' on occasion as no way to know if the clock disappea=
red
or reset and hence the device interface might lock up.=20

>=20
> >  =20
> > >=20
> > > 3) This solution does not really scale. There are designs where we ha=
ve
> > > multiple instances of the IP core attached to the client (typically if
> > > a converter like this has more than one channel, we have one instance
> > > of the core per channel). The way we have it know, that would not me
> > > feasable.
> > >  =20
>=20
> ...
>=20
> >=20
> >  =20
> > > However, one thing that
> > > I'm not sure it will be ideal with having two devices is synchronizing
> > > accesses to the IP core. For example, the axi-dac driver (that I also
> > > intend to bring upstream as part of this work) also has an userspace
> > > interface so we need to be carefull. =20
> >=20
> > I'm a bit lost. I think we'd only expect to see a userspace interface
> > on the 'front end' driver. Is there something on the driver handling the
> > IP core as well (beyond debug which you can do whatever you like with :)
> >  =20
>=20
> See below...=20
>=20
> > > But I guess this is no different
> > > for devices which are accessed by the in-kernel IIO interface.
> > >=20
> > > I'm way more inclined to go with 2). =20
> >=20
> > I'm not sure I fully follow what option 2) is!=C2=A0 Perhaps a bit
> > of ascii art?
> >  =20
>=20
> So option 2 is pretty much treating the IP core also as a separate IIO de=
vice.
> This is not so visible in axi-adc but on the dac counterpart, the settings
> to generate tones (frequency/phase) are on the core. So, this could map to
> IIO ABI.

Those are of interest to which bit of analog circuitry?  The big beyond the
front end?  If so fine to provide that via the IIO interfaces, but the=20
front end device should proxy them (using the IIO in kernel consumer interf=
aces
- which probably needs some work to make them safe to the provider going aw=
ay.
=46rom below, seems that a more focused interface for this particular device
representation may make sense.

>=20
> However, I guess we can provide some callback/ops to read_raw()/write_raw=
()=20
> to extend the front end converter (This is what is done today upstream but
> in the wrong direction). In this way, I think we could still only expose =
the
> frond end device.

Yup.  Either via the IIO consumer route, or something custom.  Depends a bit
on whether we want the front ends drivers to play nicely with other
backends (alternatives to adi-axi-adc part).  You touch on this later so
that all sounds good.

>=20
> > >=20
> > > Another thing that I've been thinking is how should we implement the =
IP
> > > core driver... As stated, there are usecases where we have mulitple
> > > instances of these devices. Well, that is how we've been doing things
> > > in ADI tree but essentially the core is just one big "block/device"
> > > [1]. However, the way we've been doing things is actually ok because
> > > every sub-block on these IPs have their own memory map allowing to
> > > control everything needed by the sub-blocks. =20
> >=20
> > Device model wise, that sounds like something that would be neater split
> > up. So one kernel device registered per sub-block.=C2=A0 That should ma=
ke
> > it easier to handle referencing them from front end drivers.=C2=A0 You =
can
> > also then unbind individual blocks etc rather than having to do them
> > in one go.=C2=A0 If there is need for a 'parent' block then this might =
be
> > a fit for the auxiliary bus framework - or something that looks like
> > that but suits your particular requirements.
> >  =20
>=20
> Agreed. Instead of auxiliary bus, I've been thinking in two option:
>  * Normal devicetree (FW) + kref based approach (as CCF, in kernel IIO, e=
tc)
>  * component API [1]. The component API looks to fit nicely in these desi=
gns
> and I would not have to care about refcounting. It's also an all or nothi=
ng
> approach. Either all devices are present or none is which honestly, I thi=
nk
> it makes sense.=C2=A0I also don't dislike the two staged binding approach=
... One thing
> that worries me is that it looks to be very tailored for DRM (there's eve=
n some
> DRM specific comments in the code :)) which might bring some unexpected, =
unpleasant
> surprises.
>=20

Interesting.  I wasn't aware of that one.  If it looks good to you then
I'd be interested to see what resulting code looks like.

> > >=20
> > > Another option and now that we support output buffers and multiple
> > > buffers per device would be to support these cores as one device
> > > (likely in the addac folder).
> > > However, I think that keeping each block
> > > as a standalone device might keep things more simple. But I assume it=
's
> > > tempting to get a first user to the multi buffer support :) =20
> >=20
> > Do we end up with with one front end, with a bunch of IP cores (or sub =
cores etc)
> > behind it?=C2=A0 If so I'd like the front end (where buffers are presen=
ted)
> > to have a bunch of output buffers.=C2=A0 I'd assume that there are cont=
rols
> > for some front ends that affect the data flowing into multiple IP
> > blocks? (gain etc).=C2=A0 That front end (which would be the IIO driver)
> > might well register for multiple backends (IP block driver).
> >  =20
>=20
> Yes. Think of high speed ADCs/DACs with more than one channel/
> data paths. Typically each interface (LVDS/CMOS/JESD) of that path is con=
nected
> to the fpga mapping to it's own sub IP block. So yes, you're right. In th=
is
> case, as we are moving more for the "front end" approach, we will still h=
ave
> users for multi buffer support :).
>=20
> > >=20
> > > Now for the big elephant of all the above... Everything that I've been
> > > saying means breaking the current ABI. I'm fairly confident that we
> > > should not have any upstream user for these drivers because it lacks a
> > > lot of features that are only present in ADI tree. So, I think it's ok
> > > to destroy the ABI but of course I cannot guarantee there are no users
> > > :). =20
> >=20
> > I'm less worried about doing this for this driver than the vast majority
> > of others because at least for upstream I don't think we'll have huge
> > numbers of users.=C2=A0 + they'll shout at you not me ;)
> >  =20
> > >=20
> > > So, would it be fine for me to not care about the current ABI while
> > > working on this? Because, it will be very difficult to come up with
> > > something that is compatible with what we have. Well, there's always
> > > the option of coming up with a -v2 (or something like that) for these
> > > drivers keeping the ones we have now, untouched. Ideas? =20
> >=20
> > Probably good to layout the current ABI as exposed and then we can see
> > whether what we are changing is stuff not used in normal software flows
> > anyway or if we are going to break critical stuff.=C2=A0 IF we end up w=
ith
> > a /sys/bus/iio/device/iio:deviceX that has the same interfaces, then
> > the user won't care that the driver structure underneath is totally dif=
ferent.
> > I don't care about debug related interfaces remaining stable ABI =20
>=20
> Maybe with this front end device logic where we are only still exposing o=
ne
> IIO device, we we'll end up not breaking that much the ABI (if breaking a=
t all).

It'll probably change in subtle ways, but maybe in ways that userspace
doesn't notice :)  If we can get away with it that would be great.
Otherwise I'm going to rely on you ADI folk telling me we can get away
with the ABI breakage.

> >=20
> > Going for a v2 may be the best option - marking the other one deprecated
> > and getting rid of it after a number of years.=C2=A0 If you (ADI in gen=
eral)
> > reckon you can get away with it then I'm happy.=C2=A0 The usecases for =
this
> > stuff tend to be sufficiently high end that I'd imagine you only have to
> > deal with a fairly small number of customers and many of them won't
> > use upstream directly anyway.
> >  =20
> > >=20
> > > So... feedback is very much appreciated :) =20
> >=20
> > I think unfortunately this is going to be an area where experimentation
> > is needed, particularly as I suspect you have a lot of different device=
s all
> > with subtle differences in requirements. We need soemthing that supports
> > them all.
> >=20
> > For extra fun. In the ideal sense any driver for a convertor should work
> > equally well with different IP cores (if any ever come along).
> >  =20
>=20
> Yeah, that is actually my goal. In my head, I'm planning to have a tiny
> middleware module where IP core drivers register with some ops() (that we
> can always extend) and front end devices get() these cores and then call
> the exposed API. Then, ideally, this module should not have any specific
> information about the IP core specific internals (naturally some ops/API
> might be more tailored to some drivers but we should try to keep them as
> generic as possible)...=20

Nice and good luck :)

Jonathan

>=20
> [1]: https://elixir.bootlin.com/linux/latest/source/drivers/base/componen=
t.c
> - Nuno S=C3=A1
>=20

