Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB786F333F
	for <lists+linux-iio@lfdr.de>; Mon,  1 May 2023 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjEAP5O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 May 2023 11:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjEAP5N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2023 11:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560A29B
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 08:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D63EB61DC9
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 15:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C592AC433D2;
        Mon,  1 May 2023 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682956630;
        bh=QCbSuYkIpmV9bdHyWavtqX0GrzIc8K0ZabxOeg29TG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hcIiM8kljoUw28IPGvGXi9DkA8WyU29MKWr3QBuuCM2dA4zvE3xKVo7BDtyZg33dF
         fAAfB5dOkVir9DhpAfLh/V2x4hfmKsYB7ZOZlbwC6dlRhtlVTg4JMXMtUnRiHqNvHq
         /CB+aM7wfdUDijEX/iFxvVh3wWyN5h56n1jKzhfQd17ry1WhIGTFaijYbtokaS+xPu
         RxOz3Haib46E+DKB2jsPA5N8PYWeKfg1JYsiSyV2qiBSuA8WgYI1rlWiaCT5cz4jUC
         8f38tlZ98Lywg3L5NLzuLM7BKaZ0RklFKNUpj1qn3oz0Br9NSARx8DRoZEPhUUHGFk
         ecl6TQf+QtMSA==
Date:   Mon, 1 May 2023 17:12:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: adi-axi-adc issues and how to properly support this designs
Message-ID: <20230501171256.45ae3f6b@jic23-huawei>
In-Reply-To: <c7b49491507bb85e5dc2b1b8b03a6c35b02978af.camel@gmail.com>
References: <dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com>
        <20230410132138.6c5b4c87@jic23-huawei>
        <d5c0f825838f84f734d5af1f26bb0eac915532d5.camel@gmail.com>
        <20230416143316.59dca9f3@jic23-huawei>
        <c7b49491507bb85e5dc2b1b8b03a6c35b02978af.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Apr 2023 15:36:35 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2023-04-16 at 14:33 +0100, Jonathan Cameron wrote:
> > On Fri, 14 Apr 2023 11:11:43 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > Hi Jonathan,
> > >=20
> > > Thanks for the feedback. Definitely helpful...
> > >=20
> > > On Mon, 2023-04-10 at 13:21 +0100, Jonathan Cameron wrote: =20
> > > > On Fri, 31 Mar 2023 16:40:44 +0200
> > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > > =C2=A0  =20
> > > > > Hi Jonathan,
> > > > > =C2=A0  =20
> > > >=20
> > > > Hmm. Complex topic, so I'd definitely like others to weigh in with
> > > > opinions .
> > > > =C2=A0  =20
> > > > > There are some major issues with the implementation we have upstr=
eam
> > > > > for the adi-axi-adc driver. The only user is the ad9467 driver. I=
n the
> > > > > rest of the email I will refer to ad9467 as the converter device =
and
> > > > > axi-adc as the IP core.=20
> > > > >=20
> > > > > Let me start to state that these designs, in a very a basic way, =
have a
> > > > > converter connected to a IP core that typically lives in a FPGA. =
This
> > > > > core connects to a DMA core (which is used by the DMA buffer
> > > > > implementation) so we can keep up with the high rates of these
> > > > > converters. So there's a link between these devices and we try to
> > > > > implement that so far looking at them as one single IIO device.
> > > > >=20
> > > > > Let's go to the major issues now:
> > > > >=20
> > > > > 1) There is a circular dependency between the two device. And when
> > > > > compiled as modules for example, we cannot really rmmod the modul=
es
> > > > > anymore:
> > > > >=20
> > > > > "root@analog:~# rmmod ad9467
> > > > > rmmod: ERROR: Module ad9467 is in use
> > > > >=20
> > > > > root@analog:~# rmmod adi-axi-adc.ko
> > > > > rmmod: ERROR: Module adi_axi_adc is in use by: ad9467
> > > > > "
> > > > >=20
> > > > > This easy to understand as the ad9467 driver as a direct symbol
> > > > > dependency on the axi-adc one. And this one calls 'module_get()' =
as
> > > > > soon as it attaches to a "client"=C2=A0  =20
> > > >=20
> > > > Ouch. module_get() never works for this.=C2=A0 Long time ago I thou=
ght it
> > > > did :(=C2=A0 An unbind will bypass that (as well any real hot unplu=
g paths).
> > > > =C2=A0  =20
> > >=20
> > > Yeps, it bypasses it but I just wanted to point out the flaw in the c=
urrent
> > > design :) =20
> >=20
> > It was a surprise to me when Lars pointed this out years ago.
> > All we can do is treat it as a hint for something that makes
> > little sense for a user to deliberately do.
> >  =20
> > >  =20
> > > > =C2=A0  =20
> > > > >=20
> > > > > 2) It's fairly easy to crash the kernel:
> > > > >=20
> > > > > "
> > > > > root@analog:/sys/bus/spi/drivers/ad9467# echo spi0.0 > unbind
> > > > > root@analog:/sys/bus/iio/devices/iio:device2# echo 1 >
> > > > > buffer0/in_voltage0_en
> > > > > root@analog:/sys/bus/iio/devices/iio:device2# echo 1 > buffer0/en=
able
> > > > > [=C2=A0 132.349133] 8<--- cut here ---
> > > > > [=C2=A0 132.352193] Unable to handle kernel paging request at vir=
tual
> > > > > address e0940000 when read
> > > > > [=C2=A0 132.360333] [e0940000] *pgd=3D0208b811, *pte=3D00000000, =
*ppte=3D00000000
> > > > > [=C2=A0 132.366668] Internal error: Oops: 7 [#1] SMP ARM
> > > > > [=C2=A0 132.371289] Modules linked in: ad9467 adi_axi_adc ad9517
> > > > > [=C2=A0 132.376609] CPU: 1 PID: 444 Comm: bash Not tainted 6.2.9-=
dirty #3
> > > > > [=C2=A0 132.382701] Hardware name: Xilinx Zynq Platform
> > > > > [=C2=A0 132.387223] PC is at adi_axi_adc_update_scan_mode+0x34/0x=
88
> > > > > [adi_axi_adc]
> > > > > [=C2=A0 132.394020] LR is at arm_heavy_mb+0x1c/0x38
> > > > > [=C2=A0 132.398212] pc : [<bf0060c4>]=C2=A0=C2=A0=C2=A0 lr : [<c0=
31820c>]=C2=A0=C2=A0=C2=A0 psr: a0000013
> > > > > [=C2=A0 132.404392] sp : e0929e30=C2=A0 ip : deaddead=C2=A0 fp : =
c4430270
> > > > > [=C2=A0 132.409678] r10: c8a0bc18=C2=A0 r9 : deaddeac=C2=A0 r8 : =
c89b1c00
> > > > > [=C2=A0 132.414895] r7 : c4430340=C2=A0 r6 : c45db7c0=C2=A0 r5 : =
e093ffc0=C2=A0 r4 :
> > > > > 000003f0
> > > > > [=C2=A0 132.421413] r3 : 00010000=C2=A0 r2 : e0940000=C2=A0 r1 : =
00000000=C2=A0 r0 :
> > > > > 00000000
> > > > > "=C2=A0  =20
> > > >=20
> > > > It's nasty but generally that sort of path can be prevented with so=
me
> > > > careful locking and checking of indicators that a component has gon=
e away.
> > > > So whenever you unbind one aspect it notifies the other one that it=
 has
> > > > gone
> > > > away. I'm not sure where to currently look for best practice in thi=
s.
> > > >=20
> > > > There are a lot of similar situations - basically anywhere a set of=
=20
> > > > drivers end up hanging off two buses.=C2=A0 v4l and media drivers i=
n general
> > > > end up doing this a lot.
> > > >=20
> > > > One I'm familiar with is how some of the CXL tear down happens and
> > > > that lead me to device_release_driver() which is also used by usb e=
tc.
> > > > I've not looked at this for a while but it may provide the tear down
> > > > needed
> > > > if the right dance is used.=C2=A0 I think that will work if your co=
nvertor
> > > > driver is using services off the IP core driver and someone unbinds
> > > > that ip-core driver.
> > > > =C2=A0  =20
> > >=20
> > > Yes, CCF does it with refcounting and some dummy clock ops for the ca=
se a
> > > clock
> > > provider is gone (with active consumers). =20
> >=20
> > That must be 'exciting' on occasion as no way to know if the clock disa=
ppeared
> > or reset and hence the device interface might lock up.=20
> >  =20
> > >  =20
> > > > =C2=A0  =20
> > > > >=20
> > > > > 3) This solution does not really scale. There are designs where w=
e have
> > > > > multiple instances of the IP core attached to the client (typical=
ly if
> > > > > a converter like this has more than one channel, we have one inst=
ance
> > > > > of the core per channel). The way we have it know, that would not=
 me
> > > > > feasable.
> > > > > =C2=A0  =20
> > >=20
> > > ...
> > >  =20
> > > >=20
> > > > =C2=A0  =20
> > > > > However, one thing that
> > > > > I'm not sure it will be ideal with having two devices is synchron=
izing
> > > > > accesses to the IP core. For example, the axi-dac driver (that I =
also
> > > > > intend to bring upstream as part of this work) also has an usersp=
ace
> > > > > interface so we need to be carefull.=C2=A0  =20
> > > >=20
> > > > I'm a bit lost. I think we'd only expect to see a userspace interfa=
ce
> > > > on the 'front end' driver. Is there something on the driver handlin=
g the
> > > > IP core as well (beyond debug which you can do whatever you like wi=
th :)
> > > > =C2=A0  =20
> > >=20
> > > See below...=20
> > >  =20
> > > > > But I guess this is no different
> > > > > for devices which are accessed by the in-kernel IIO interface.
> > > > >=20
> > > > > I'm way more inclined to go with 2).=C2=A0  =20
> > > >=20
> > > > I'm not sure I fully follow what option 2) is!=C2=A0 Perhaps a bit
> > > > of ascii art?
> > > > =C2=A0  =20
> > >=20
> > > So option 2 is pretty much treating the IP core also as a separate IIO
> > > device.
> > > This is not so visible in axi-adc but on the dac counterpart, the set=
tings
> > > to generate tones (frequency/phase) are on the core. So, this could m=
ap to
> > > IIO ABI. =20
> >=20
> > Those are of interest to which bit of analog circuitry?=C2=A0 The big b=
eyond the
> > front end?=C2=A0 If so fine to provide that via the IIO interfaces, but=
 the=20
> > front end device should proxy them (using the IIO in kernel consumer
> > interfaces
> > - which probably needs some work to make them safe to the provider goin=
g away.
> > From below, seems that a more focused interface for this particular dev=
ice
> > representation may make sense.
> >  =20
>=20
> Not sure I'm following your question but I'll try... The settings are on =
the IP
> core beyond the front end but I would say they are of interest of the fro=
nt end
> device. For instance, we might generate a tone on the IP core (setting ph=
ase and
> frequency) but these bits are to be transmitted trough a dac/dds (our fro=
nt end
> device) analog, digital front end.

hehe. I avoided opening your email for a few weeks because I thought it mig=
ht
drag me down a rat hole.  Then I find there is just a nice clean reply to
my question that would have taken me 2 mins to read.

That makes complete sense.  To my mind only the front end needs to be an IIO
device, but if it's convenient to represent the back end as one we can prob=
ably
make that work as well.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
> >  =20

