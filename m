Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A796A6E1F12
	for <lists+linux-iio@lfdr.de>; Fri, 14 Apr 2023 11:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDNJLw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Apr 2023 05:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDNJLv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2023 05:11:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A668A5FDE
        for <linux-iio@vger.kernel.org>; Fri, 14 Apr 2023 02:11:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e16so3511303wra.6
        for <linux-iio@vger.kernel.org>; Fri, 14 Apr 2023 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681463505; x=1684055505;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/lyEe9CvzU2NNf8wnIBVvtas08Yu/dJLcNALOgProfQ=;
        b=sT7FWEnBNkbWgqwBUwEZJmJXo3k8nzLDByKs+nDNtwOc3+ySfVSE5qPryECG0nnM6t
         0JZH16wnyssnYqjFFdLe3gciXcJqDkZ3g3ndhcB3op3KIn7zHR777FjlSZSAVP2cT9Gi
         yLG/KVVZQSHTCKMZ0tws3mRTTpBWJjCQiyvYw8Wr0niFprfUKIuPnDLmQpqN0DIVQnC1
         QiH4TLww3F7zUKPQH5nhYCIwEji4gLOI+0f01Xt8IekCHIcKg+fN0SF2XDQXI/vBovvs
         IyvowdhVYYQ6L/fPwdRM8D9Naq2ISmRYWi9vuKy24fbwwWeLa3SojM4fEFcnLxdrePPq
         MUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681463505; x=1684055505;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lyEe9CvzU2NNf8wnIBVvtas08Yu/dJLcNALOgProfQ=;
        b=RHGkG1qgywbq3FjHpaRzw/mRMWYnpFx21DL702budzXp9pJ3kBt743LDf36c78LByt
         Lh7YQdY2uT6FurVN4MUPXq0AnZfCEvTiaH29+PUyLn6V/IVB9YyvcMWfihhnRaG/ZAdI
         uAGyTnN+amki1fhwOw60GDlRGPm58+FVUMK1MCAjIQihAaWaWaGKNjoJxso+mMXMN7KF
         t4ZXRYHcyCn86UzsKE/sC/RVJEACzJ8yoXzBJ88tRkpt50Kn5g4pciM/Mg0ulY1xZqAT
         GFBQQpGzQw6NStedyIGUtFAsQt2lVlF3xh1A2airiiKqOpvN8GLHLzh0hMnxteSX7jiN
         mHrw==
X-Gm-Message-State: AAQBX9cKmIHKF1om0Idufdj1dRknFxvKTs5FzsP41BwxtFafLQWdfved
        20kN+OC5A12i3mn4HnJAoTEip2VNB78D/AYa
X-Google-Smtp-Source: AKy350b6IGWoZU4BecSMxukoJcl9W7DNTz9CvIGKgekLPctxmOHQOFFOXVqIZADy6Ev/katrO/NAYw==
X-Received: by 2002:adf:ed4c:0:b0:2ef:b21c:f6a0 with SMTP id u12-20020adfed4c000000b002efb21cf6a0mr3721175wro.53.1681463504822;
        Fri, 14 Apr 2023 02:11:44 -0700 (PDT)
Received: from ?IPv6:2001:a61:134d:a001:f2d9:b7d:7ae:9db3? ([2001:a61:134d:a001:f2d9:b7d:7ae:9db3])
        by smtp.gmail.com with ESMTPSA id v16-20020adff690000000b002f6962ee703sm1844007wrp.61.2023.04.14.02.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 02:11:44 -0700 (PDT)
Message-ID: <d5c0f825838f84f734d5af1f26bb0eac915532d5.camel@gmail.com>
Subject: Re: adi-axi-adc issues and how to properly support this designs
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Fri, 14 Apr 2023 11:11:43 +0200
In-Reply-To: <20230410132138.6c5b4c87@jic23-huawei>
References: <dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com>
         <20230410132138.6c5b4c87@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for the feedback. Definitely helpful...

On Mon, 2023-04-10 at 13:21 +0100, Jonathan Cameron wrote:
> On Fri, 31 Mar 2023 16:40:44 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > Hi Jonathan,
> >=20
>=20
> Hmm. Complex topic, so I'd definitely like others to weigh in with
> opinions .
>=20
> > There are some major issues with the implementation we have upstream
> > for the adi-axi-adc driver. The only user is the ad9467 driver. In the
> > rest of the email I will refer to ad9467 as the converter device and
> > axi-adc as the IP core.=20
> >=20
> > Let me start to state that these designs, in a very a basic way, have a
> > converter connected to a IP core that typically lives in a FPGA. This
> > core connects to a DMA core (which is used by the DMA buffer
> > implementation) so we can keep up with the high rates of these
> > converters. So there's a link between these devices and we try to
> > implement that so far looking at them as one single IIO device.
> >=20
> > Let's go to the major issues now:
> >=20
> > 1) There is a circular dependency between the two device. And when
> > compiled as modules for example, we cannot really rmmod the modules
> > anymore:
> >=20
> > "root@analog:~# rmmod ad9467
> > rmmod: ERROR: Module ad9467 is in use
> >=20
> > root@analog:~# rmmod adi-axi-adc.ko
> > rmmod: ERROR: Module adi_axi_adc is in use by: ad9467
> > "
> >=20
> > This easy to understand as the ad9467 driver as a direct symbol
> > dependency on the axi-adc one. And this one calls 'module_get()' as
> > soon as it attaches to a "client"
>=20
> Ouch. module_get() never works for this.=C2=A0 Long time ago I thought it
> did :(=C2=A0 An unbind will bypass that (as well any real hot unplug path=
s).
>=20

Yeps, it bypasses it but I just wanted to point out the flaw in the current=
 design :)

>=20
> >=20
> > 2) It's fairly easy to crash the kernel:
> >=20
> > "
> > root@analog:/sys/bus/spi/drivers/ad9467# echo spi0.0 > unbind
> > root@analog:/sys/bus/iio/devices/iio:device2# echo 1 >
> > buffer0/in_voltage0_en
> > root@analog:/sys/bus/iio/devices/iio:device2# echo 1 > buffer0/enable
> > [=C2=A0 132.349133] 8<--- cut here ---
> > [=C2=A0 132.352193] Unable to handle kernel paging request at virtual
> > address e0940000 when read
> > [=C2=A0 132.360333] [e0940000] *pgd=3D0208b811, *pte=3D00000000, *ppte=
=3D00000000
> > [=C2=A0 132.366668] Internal error: Oops: 7 [#1] SMP ARM
> > [=C2=A0 132.371289] Modules linked in: ad9467 adi_axi_adc ad9517
> > [=C2=A0 132.376609] CPU: 1 PID: 444 Comm: bash Not tainted 6.2.9-dirty =
#3
> > [=C2=A0 132.382701] Hardware name: Xilinx Zynq Platform
> > [=C2=A0 132.387223] PC is at adi_axi_adc_update_scan_mode+0x34/0x88
> > [adi_axi_adc]
> > [=C2=A0 132.394020] LR is at arm_heavy_mb+0x1c/0x38
> > [=C2=A0 132.398212] pc : [<bf0060c4>]=C2=A0=C2=A0=C2=A0 lr : [<c031820c=
>]=C2=A0=C2=A0=C2=A0 psr: a0000013
> > [=C2=A0 132.404392] sp : e0929e30=C2=A0 ip : deaddead=C2=A0 fp : c44302=
70
> > [=C2=A0 132.409678] r10: c8a0bc18=C2=A0 r9 : deaddeac=C2=A0 r8 : c89b1c=
00
> > [=C2=A0 132.414895] r7 : c4430340=C2=A0 r6 : c45db7c0=C2=A0 r5 : e093ff=
c0=C2=A0 r4 :
> > 000003f0
> > [=C2=A0 132.421413] r3 : 00010000=C2=A0 r2 : e0940000=C2=A0 r1 : 000000=
00=C2=A0 r0 :
> > 00000000
> > "
>=20
> It's nasty but generally that sort of path can be prevented with some
> careful locking and checking of indicators that a component has gone away=
.
> So whenever you unbind one aspect it notifies the other one that it has g=
one
> away. I'm not sure where to currently look for best practice in this.
>=20
> There are a lot of similar situations - basically anywhere a set of=20
> drivers end up hanging off two buses.=C2=A0 v4l and media drivers in gene=
ral
> end up doing this a lot.
>=20
> One I'm familiar with is how some of the CXL tear down happens and
> that lead me to device_release_driver() which is also used by usb etc.
> I've not looked at this for a while but it may provide the tear down need=
ed
> if the right dance is used.=C2=A0 I think that will work if your converto=
r
> driver is using services off the IP core driver and someone unbinds
> that ip-core driver.
>=20

Yes, CCF does it with refcounting and some dummy clock ops for the case a c=
lock
provider is gone (with active consumers).

>=20
> >=20
> > 3) This solution does not really scale. There are designs where we have
> > multiple instances of the IP core attached to the client (typically if
> > a converter like this has more than one channel, we have one instance
> > of the core per channel). The way we have it know, that would not me
> > feasable.
> >=20

...

>=20
>=20
> > However, one thing that
> > I'm not sure it will be ideal with having two devices is synchronizing
> > accesses to the IP core. For example, the axi-dac driver (that I also
> > intend to bring upstream as part of this work) also has an userspace
> > interface so we need to be carefull.
>=20
> I'm a bit lost. I think we'd only expect to see a userspace interface
> on the 'front end' driver. Is there something on the driver handling the
> IP core as well (beyond debug which you can do whatever you like with :)
>=20

See below...=20

> > But I guess this is no different
> > for devices which are accessed by the in-kernel IIO interface.
> >=20
> > I'm way more inclined to go with 2).
>=20
> I'm not sure I fully follow what option 2) is!=C2=A0 Perhaps a bit
> of ascii art?
>=20

So option 2 is pretty much treating the IP core also as a separate IIO devi=
ce.
This is not so visible in axi-adc but on the dac counterpart, the settings
to generate tones (frequency/phase) are on the core. So, this could map to
IIO ABI.

However, I guess we can provide some callback/ops to read_raw()/write_raw()=
=20
to extend the front end converter (This is what is done today upstream but
in the wrong direction). In this way, I think we could still only expose th=
e
frond end device.

> >=20
> > Another thing that I've been thinking is how should we implement the IP
> > core driver... As stated, there are usecases where we have mulitple
> > instances of these devices. Well, that is how we've been doing things
> > in ADI tree but essentially the core is just one big "block/device"
> > [1]. However, the way we've been doing things is actually ok because
> > every sub-block on these IPs have their own memory map allowing to
> > control everything needed by the sub-blocks.
>=20
> Device model wise, that sounds like something that would be neater split
> up. So one kernel device registered per sub-block.=C2=A0 That should make
> it easier to handle referencing them from front end drivers.=C2=A0 You ca=
n
> also then unbind individual blocks etc rather than having to do them
> in one go.=C2=A0 If there is need for a 'parent' block then this might be
> a fit for the auxiliary bus framework - or something that looks like
> that but suits your particular requirements.
>=20

Agreed. Instead of auxiliary bus, I've been thinking in two option:
 * Normal devicetree (FW) + kref based approach (as CCF, in kernel IIO, etc=
)
 * component API [1]. The component API looks to fit nicely in these design=
s
and I would not have to care about refcounting. It's also an all or nothing
approach. Either all devices are present or none is which honestly, I think
it makes sense.=C2=A0I also don't dislike the two staged binding approach..=
. One thing
that worries me is that it looks to be very tailored for DRM (there's even =
some
DRM specific comments in the code :)) which might bring some unexpected, un=
pleasant
surprises.

> >=20
> > Another option and now that we support output buffers and multiple
> > buffers per device would be to support these cores as one device
> > (likely in the addac folder).
> > However, I think that keeping each block
> > as a standalone device might keep things more simple. But I assume it's
> > tempting to get a first user to the multi buffer support :)
>=20
> Do we end up with with one front end, with a bunch of IP cores (or sub co=
res etc)
> behind it?=C2=A0 If so I'd like the front end (where buffers are presente=
d)
> to have a bunch of output buffers.=C2=A0 I'd assume that there are contro=
ls
> for some front ends that affect the data flowing into multiple IP
> blocks? (gain etc).=C2=A0 That front end (which would be the IIO driver)
> might well register for multiple backends (IP block driver).
>=20

Yes. Think of high speed ADCs/DACs with more than one channel/
data paths. Typically each interface (LVDS/CMOS/JESD) of that path is conne=
cted
to the fpga mapping to it's own sub IP block. So yes, you're right. In this
case, as we are moving more for the "front end" approach, we will still hav=
e
users for multi buffer support :).

> >=20
> > Now for the big elephant of all the above... Everything that I've been
> > saying means breaking the current ABI. I'm fairly confident that we
> > should not have any upstream user for these drivers because it lacks a
> > lot of features that are only present in ADI tree. So, I think it's ok
> > to destroy the ABI but of course I cannot guarantee there are no users
> > :).
>=20
> I'm less worried about doing this for this driver than the vast majority
> of others because at least for upstream I don't think we'll have huge
> numbers of users.=C2=A0 + they'll shout at you not me ;)
>=20
> >=20
> > So, would it be fine for me to not care about the current ABI while
> > working on this? Because, it will be very difficult to come up with
> > something that is compatible with what we have. Well, there's always
> > the option of coming up with a -v2 (or something like that) for these
> > drivers keeping the ones we have now, untouched. Ideas?
>=20
> Probably good to layout the current ABI as exposed and then we can see
> whether what we are changing is stuff not used in normal software flows
> anyway or if we are going to break critical stuff.=C2=A0 IF we end up wit=
h
> a /sys/bus/iio/device/iio:deviceX that has the same interfaces, then
> the user won't care that the driver structure underneath is totally diffe=
rent.
> I don't care about debug related interfaces remaining stable ABI

Maybe with this front end device logic where we are only still exposing one
IIO device, we we'll end up not breaking that much the ABI (if breaking at =
all).
>=20
> Going for a v2 may be the best option - marking the other one deprecated
> and getting rid of it after a number of years.=C2=A0 If you (ADI in gener=
al)
> reckon you can get away with it then I'm happy.=C2=A0 The usecases for th=
is
> stuff tend to be sufficiently high end that I'd imagine you only have to
> deal with a fairly small number of customers and many of them won't
> use upstream directly anyway.
>=20
> >=20
> > So... feedback is very much appreciated :)
>=20
> I think unfortunately this is going to be an area where experimentation
> is needed, particularly as I suspect you have a lot of different devices =
all
> with subtle differences in requirements. We need soemthing that supports
> them all.
>=20
> For extra fun. In the ideal sense any driver for a convertor should work
> equally well with different IP cores (if any ever come along).
>=20

Yeah, that is actually my goal. In my head, I'm planning to have a tiny
middleware module where IP core drivers register with some ops() (that we
can always extend) and front end devices get() these cores and then call
the exposed API. Then, ideally, this module should not have any specific
information about the IP core specific internals (naturally some ops/API
might be more tailored to some drivers but we should try to keep them as
generic as possible)...=20

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/base/component.=
c
- Nuno S=C3=A1

