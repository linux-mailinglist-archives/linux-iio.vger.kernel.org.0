Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD9E6DC686
	for <lists+linux-iio@lfdr.de>; Mon, 10 Apr 2023 14:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDJMGY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Apr 2023 08:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDJMGX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2023 08:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B7A59C1
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 05:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FAFC611E6
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 12:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94661C433EF;
        Mon, 10 Apr 2023 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681128380;
        bh=5QAKQorjN+Z6FUyJe0c2eyOhDL/u4Hu03efCCQU7Sq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sWsjlJKkbzwqtGoh7i9i/JSsqzyCXKg999SQsQFYNPfj12nIbeiXnVzEjxhKNul4D
         ErpRTq/uQSM26+zCYox3WloiL9DD49YlSMeMvW7DERCf7zTWtyVqjLa3gwXh5UcKli
         pk4hGnYvDdXMb0lZNA4OhvPTIUNJVvbF5Tr4JWbtZGFf0KLY4U94u/fR2pl7NjOvfC
         AErL2FstuKDOYHBO6COu7G4Rz9sVqmdcFg6i9w9DxC+mbpN7b56P3fe5TirTDaWIFq
         bu2OeRRAxTqe6AxfL8LfdSDbhzHdJUkr+fOW6wiPhkpVA5HJOYVj1zBN6bZ6/tp3Z6
         lt7iUwPzGAhyw==
Date:   Mon, 10 Apr 2023 13:21:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: adi-axi-adc issues and how to properly support this designs
Message-ID: <20230410132138.6c5b4c87@jic23-huawei>
In-Reply-To: <dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com>
References: <dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Mar 2023 16:40:44 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Hi Jonathan,
>=20

Hmm. Complex topic, so I'd definitely like others to weigh in with
opinions .

> There are some major issues with the implementation we have upstream
> for the adi-axi-adc driver. The only user is the ad9467 driver. In the
> rest of the email I will refer to ad9467 as the converter device and
> axi-adc as the IP core.=20
>=20
> Let me start to state that these designs, in a very a basic way, have a
> converter connected to a IP core that typically lives in a FPGA. This
> core connects to a DMA core (which is used by the DMA buffer
> implementation) so we can keep up with the high rates of these
> converters. So there's a link between these devices and we try to
> implement that so far looking at them as one single IIO device.
>=20
> Let's go to the major issues now:
>=20
> 1) There is a circular dependency between the two device. And when
> compiled as modules for example, we cannot really rmmod the modules
> anymore:
>=20
> "root@analog:~# rmmod ad9467
> rmmod: ERROR: Module ad9467 is in use
>=20
> root@analog:~# rmmod adi-axi-adc.ko
> rmmod: ERROR: Module adi_axi_adc is in use by: ad9467
> "
>=20
> This easy to understand as the ad9467 driver as a direct symbol
> dependency on the axi-adc one. And this one calls 'module_get()' as
> soon as it attaches to a "client"

Ouch. module_get() never works for this.  Long time ago I thought it
did :(  An unbind will bypass that (as well any real hot unplug paths).


>=20
> 2) It's fairly easy to crash the kernel:
>=20
> "
> root@analog:/sys/bus/spi/drivers/ad9467# echo spi0.0 > unbind
> root@analog:/sys/bus/iio/devices/iio:device2# echo 1 >
> buffer0/in_voltage0_en
> root@analog:/sys/bus/iio/devices/iio:device2# echo 1 > buffer0/enable
> [  132.349133] 8<--- cut here ---
> [  132.352193] Unable to handle kernel paging request at virtual
> address e0940000 when read
> [  132.360333] [e0940000] *pgd=3D0208b811, *pte=3D00000000, *ppte=3D00000=
000
> [  132.366668] Internal error: Oops: 7 [#1] SMP ARM
> [  132.371289] Modules linked in: ad9467 adi_axi_adc ad9517
> [  132.376609] CPU: 1 PID: 444 Comm: bash Not tainted 6.2.9-dirty #3
> [  132.382701] Hardware name: Xilinx Zynq Platform
> [  132.387223] PC is at adi_axi_adc_update_scan_mode+0x34/0x88
> [adi_axi_adc]
> [  132.394020] LR is at arm_heavy_mb+0x1c/0x38
> [  132.398212] pc : [<bf0060c4>]    lr : [<c031820c>]    psr: a0000013
> [  132.404392] sp : e0929e30  ip : deaddead  fp : c4430270
> [  132.409678] r10: c8a0bc18  r9 : deaddeac  r8 : c89b1c00
> [  132.414895] r7 : c4430340  r6 : c45db7c0  r5 : e093ffc0  r4 :
> 000003f0
> [  132.421413] r3 : 00010000  r2 : e0940000  r1 : 00000000  r0 :
> 00000000
> "

It's nasty but generally that sort of path can be prevented with some
careful locking and checking of indicators that a component has gone away.
So whenever you unbind one aspect it notifies the other one that it has gone
away. I'm not sure where to currently look for best practice in this.

There are a lot of similar situations - basically anywhere a set of=20
drivers end up hanging off two buses.  v4l and media drivers in general
end up doing this a lot.

One I'm familiar with is how some of the CXL tear down happens and
that lead me to device_release_driver() which is also used by usb etc.
I've not looked at this for a while but it may provide the tear down needed
if the right dance is used.  I think that will work if your convertor
driver is using services off the IP core driver and someone unbinds
that ip-core driver.


>=20
> 3) This solution does not really scale. There are designs where we have
> multiple instances of the IP core attached to the client (typically if
> a converter like this has more than one channel, we have one instance
> of the core per channel). The way we have it know, that would not me
> feasable.
>=20
> Issues number 2) and 3) would more or less be easy to solve moving from
> of_parse_phandle() and from devm_ (using plain kmalloc() + krefs). The
> big issue to me is 1) because, for example, in the driver we have out
> of tree for ad9467, we do a tuning on the adc LVDS interface that we do
> not do in the upstream version. And why is this problematic? Because
> this means the converter driver has to do some configurations on the IP
> core device and hence we have a bidirectional link between these 2
> devices which, while doable, is far from ideal and can become complex
> to keep it sane.

That sort of thing becomes inevitable when we have two hardware buses
involved (e.g. SPI and AXI).=20

>=20
> To be fair, what we have in upstream today is inspired a lot in what
> ADI has out of tree (likely even better) but I truly think we need to
> do it better. As I want to start working on this, I want to share some
> ideas that I have on my head and hopefuly get some feedback on the
> direction to go. So, here it goes:
>=20
> 1) The obvious one is to flip the logic of the "communication" link.
> Right now callbacks are done from the IP core driver to the converter.

That does seem potentially backwards.  My instinct would be to have
it the other way around. Controls tend to be at the convertor end and
it tends to be the only part that 'knows' what data is being captured.
The way we've done this in IIO in general has evolved over time, but
I think we are standardising on the 'convertor' front end consuming services
from other elements.  So if it's an analog output IIO device driver consumi=
ng
the services of an ADC, then the device you talk to represents the analog o=
utput
devices (e.g. an accelerometer) and you don't use the userspace interfaces
of the ADC in this at all.=20

> As stated, the converter might need to access the IP core to ask/do
> some configurations. Well, from what I've seen in other projects we
> have, I'm positive everything can be done by being the converter the
> "entry point". This effectively means, that IP core devices would
> register somewhere (I'm thinking in a tiny interface module that can
> likely be reused for the axi-dac counterpart of the axi-adc) and the
> converter device would "get" it during probe.

Yes, like treating the IP core as a resource like a gpio / clock etc that a=
 driver
consumes.

>=20
> 2) With respect to 1), while treating the devices as 1 might look
> appealing, I'm not really sure it's the right thing to do. This,
> because these devices are effectively two different devices: the
> converter is typically a SPI device while the IP core is a MMIO device.

Yes.  Or look at it a different way, it's a device that sits on two
host buses (SPI and AXI) each of which has a controller.  One is the SPI
master, the other is the IP core with it's MMIO interface.

> Treating them as 1, makes things like the IIO direct_reg_access not
> doable (unless we duplicate some code and manually add the second
> debugfs interface).=20

It should work for the SPI accessed front end. I guess you are talking
about the IP core part. I'm not sure we should treat that as anything
to do with a IIO. It's a generic 'bus controller'.

> Another thing not ideal with 1) is that the DMA
> buffer interface really belongs on the IP core (looking on how the HW
> is designed) and not on the converter driver.=20

This seems not hugely different from an SPI controller doing DMA.  The DMA
part is in the SPI controller, but the data flow control is all in the
IIO driver for whatever is on the Analog end. It will need some functionali=
ty
/ callbacks etc and the stuff mentioned earlier to ensure that tearing down
the IP core driver tears down it's users.

> However, one thing that
> I'm not sure it will be ideal with having two devices is synchronizing
> accesses to the IP core. For example, the axi-dac driver (that I also
> intend to bring upstream as part of this work) also has an userspace
> interface so we need to be carefull.

I'm a bit lost. I think we'd only expect to see a userspace interface
on the 'front end' driver. Is there something on the driver handling the
IP core as well (beyond debug which you can do whatever you like with :)

> But I guess this is no different
> for devices which are accessed by the in-kernel IIO interface.
>=20
> I'm way more inclined to go with 2).

I'm not sure I fully follow what option 2) is!  Perhaps a bit
of ascii art?

>=20
> Another thing that I've been thinking is how should we implement the IP
> core driver... As stated, there are usecases where we have mulitple
> instances of these devices. Well, that is how we've been doing things
> in ADI tree but essentially the core is just one big "block/device"
> [1]. However, the way we've been doing things is actually ok because
> every sub-block on these IPs have their own memory map allowing to
> control everything needed by the sub-blocks.

Device model wise, that sounds like something that would be neater split
up. So one kernel device registered per sub-block.  That should make
it easier to handle referencing them from front end drivers.  You can=20
also then unbind individual blocks etc rather than having to do them
in one go.  If there is need for a 'parent' block then this might be
a fit for the auxiliary bus framework - or something that looks like
that but suits your particular requirements.

>=20
> Another option and now that we support output buffers and multiple
> buffers per device would be to support these cores as one device
> (likely in the addac folder).
> However, I think that keeping each block
> as a standalone device might keep things more simple. But I assume it's
> tempting to get a first user to the multi buffer support :)

Do we end up with with one front end, with a bunch of IP cores (or sub core=
s etc)
behind it?  If so I'd like the front end (where buffers are presented)
to have a bunch of output buffers.  I'd assume that there are controls
for some front ends that affect the data flowing into multiple IP
blocks? (gain etc).  That front end (which would be the IIO driver)
might well register for multiple backends (IP block driver).

>=20
> Now for the big elephant of all the above... Everything that I've been
> saying means breaking the current ABI. I'm fairly confident that we
> should not have any upstream user for these drivers because it lacks a
> lot of features that are only present in ADI tree. So, I think it's ok
> to destroy the ABI but of course I cannot guarantee there are no users
> :).

I'm less worried about doing this for this driver than the vast majority
of others because at least for upstream I don't think we'll have huge
numbers of users.  + they'll shout at you not me ;)

>=20
> So, would it be fine for me to not care about the current ABI while
> working on this? Because, it will be very difficult to come up with
> something that is compatible with what we have. Well, there's always
> the option of coming up with a -v2 (or something like that) for these
> drivers keeping the ones we have now, untouched. Ideas?

Probably good to layout the current ABI as exposed and then we can see
whether what we are changing is stuff not used in normal software flows
anyway or if we are going to break critical stuff.  IF we end up with
a /sys/bus/iio/device/iio:deviceX that has the same interfaces, then
the user won't care that the driver structure underneath is totally differe=
nt.
I don't care about debug related interfaces remaining stable ABI

Going for a v2 may be the best option - marking the other one deprecated
and getting rid of it after a number of years.  If you (ADI in general)
reckon you can get away with it then I'm happy.  The usecases for this
stuff tend to be sufficiently high end that I'd imagine you only have to
deal with a fairly small number of customers and many of them won't
use upstream directly anyway.

>=20
> So... feedback is very much appreciated :)

I think unfortunately this is going to be an area where experimentation
is needed, particularly as I suspect you have a lot of different devices all
with subtle differences in requirements. We need soemthing that supports
them all.

For extra fun. In the ideal sense any driver for a convertor should work
equally well with different IP cores (if any ever come along).

Jonathan

>=20
> [1]:=C2=A0https://wiki.analog.com/resources/eval/user-guides/adrv9002/axi=
_adrv9002
> https://wiki.analog.com/resources/eval/user-guides/adrv9002/axi_adrv9002
> https://wiki.analog.com/resources/eval/user-guides/adrv9002/axi_adrv9002
>=20
> - Nuno S=C3=A1

