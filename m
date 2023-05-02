Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA30B6F3DAD
	for <lists+linux-iio@lfdr.de>; Tue,  2 May 2023 08:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjEBGnX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 May 2023 02:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjEBGnW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2023 02:43:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2835F3A94
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 23:43:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a34a14a54so679648966b.1
        for <linux-iio@vger.kernel.org>; Mon, 01 May 2023 23:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683009798; x=1685601798;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LQWRAwGt/kXyygDlVdh+43w4MWALiFKOBoM53S1bgTY=;
        b=VDZz8Tgtjsz8R/etPLXfxraTLBgaBIPfhTNSMk7T5dT2F48Avf6i/REdDKZOGA+IK1
         AJatugWRaHVIigxzEwY2QYOCFhvXbe08uiloHgKLucWtkqovbRhwJV6XMX0PzPYkg1Ns
         zVuH0hHwVyY/SjKZADEUw0QCSPr/rUQGl9TPO0AlHkoMGVIrSln/XThdcUjRER3ba6Pz
         iUCjWkcYO9gpbYwo47G/qtz9k4Jr/Emd0Z0Re9o0+FvgjUYrE2eB50TYVYRUlq63lO1D
         FB2+jsJKvFk8y7u8wuHrz4x782XtEAjHXhnVY1W2fopQMcONAnSenDQhfr3khGLyvXOi
         oFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683009798; x=1685601798;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQWRAwGt/kXyygDlVdh+43w4MWALiFKOBoM53S1bgTY=;
        b=I15uxW8/ofiVlfTCj0xN3duoIQg+/uv2ek1TdIAyo0rnV/CPhhmt3u5VFqSvDzEA19
         ny2Vun3caNICUFoNC7YG/ISeIrKtDUOZ/glrR36l8OwUnEbtAZMU08p62bICZxduM3N9
         a6AtuBbybWcuOWd5JR2FVyP2lEeWFRH5nWztKiZ8vdAM3jEJ1hEwZRSirqQaXGR9mW8x
         6KLgdlXNbvAKWS93Sy4KlmuaxpTwbpDGnNZZLQaUYFwXjwW0A+xkSfzoBctJWGE+3G3H
         vDPA80jPSvjmwBUh9VirjGc3WGcqOJothj5sJZ7IaS+bbT0IDZBz+nORNuo31d+TaJY3
         RJRg==
X-Gm-Message-State: AC+VfDzUP77FV8HsdAiPE+7DIGv8lRsMIGGkMOyRdAmsDcHIfDqiUwmA
        8CvOWcO6naaJdPHr0NuV3fLX5eM18rU=
X-Google-Smtp-Source: ACHHUZ7IKiJUwDRiFkFjrbwKcOu4XMN/Jol37dD04NWebWj7yRAs+jV7G2avG738dDpGKhFos1vQBQ==
X-Received: by 2002:a17:907:3eaa:b0:953:93ab:50cf with SMTP id hs42-20020a1709073eaa00b0095393ab50cfmr17305199ejc.70.1683009798346;
        Mon, 01 May 2023 23:43:18 -0700 (PDT)
Received: from ?IPv6:2001:a61:2571:bd01:f98:8f79:3ba6:ab03? ([2001:a61:2571:bd01:f98:8f79:3ba6:ab03])
        by smtp.gmail.com with ESMTPSA id k18-20020a1709060cb200b0094ed72b6552sm15760342ejh.98.2023.05.01.23.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 23:43:17 -0700 (PDT)
Message-ID: <a6dc93c2e7012504d42434e1ed6683fc143b5231.camel@gmail.com>
Subject: Re: adi-axi-adc issues and how to properly support this designs
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Tue, 02 May 2023 08:43:17 +0200
In-Reply-To: <20230501171256.45ae3f6b@jic23-huawei>
References: <dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com>
         <20230410132138.6c5b4c87@jic23-huawei>
         <d5c0f825838f84f734d5af1f26bb0eac915532d5.camel@gmail.com>
         <20230416143316.59dca9f3@jic23-huawei>
         <c7b49491507bb85e5dc2b1b8b03a6c35b02978af.camel@gmail.com>
         <20230501171256.45ae3f6b@jic23-huawei>
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

On Mon, 2023-05-01 at 17:12 +0100, Jonathan Cameron wrote:
> On Tue, 18 Apr 2023 15:36:35 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sun, 2023-04-16 at 14:33 +0100, Jonathan Cameron wrote:
> > > On Fri, 14 Apr 2023 11:11:43 +0200
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > =C2=A0=20
> > > > Hi Jonathan,
> > > >=20
> > > > Thanks for the feedback. Definitely helpful...
> > > >=20
> > > > On Mon, 2023-04-10 at 13:21 +0100, Jonathan Cameron wrote:=C2=A0=
=20
> > > > > On Fri, 31 Mar 2023 16:40:44 +0200
> > > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > Hi Jonathan,
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > Hmm. Complex topic, so I'd definitely like others to weigh in wit=
h
> > > > > opinions .
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > There are some major issues with the implementation we have ups=
tream
> > > > > > for the adi-axi-adc driver. The only user is the ad9467 driver.=
 In the
> > > > > > rest of the email I will refer to ad9467 as the converter devic=
e and
> > > > > > axi-adc as the IP core.=20
> > > > > >=20
> > > > > > Let me start to state that these designs, in a very a basic way=
, have a
> > > > > > converter connected to a IP core that typically lives in a FPGA=
. This
> > > > > > core connects to a DMA core (which is used by the DMA buffer
> > > > > > implementation) so we can keep up with the high rates of these
> > > > > > converters. So there's a link between these devices and we try =
to
> > > > > > implement that so far looking at them as one single IIO device.
> > > > > >=20
> > > > > > Let's go to the major issues now:
> > > > > >=20
> > > > > > 1) There is a circular dependency between the two device. And w=
hen
> > > > > > compiled as modules for example, we cannot really rmmod the mod=
ules
> > > > > > anymore:
> > > > > >=20
> > > > > > "root@analog:~# rmmod ad9467
> > > > > > rmmod: ERROR: Module ad9467 is in use
> > > > > >=20
> > > > > > root@analog:~# rmmod adi-axi-adc.ko
> > > > > > rmmod: ERROR: Module adi_axi_adc is in use by: ad9467
> > > > > > "
> > > > > >=20
> > > > > > This easy to understand as the ad9467 driver as a direct symbol
> > > > > > dependency on the axi-adc one. And this one calls 'module_get()=
' as
> > > > > > soon as it attaches to a "client"=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > Ouch. module_get() never works for this.=C2=A0 Long time ago I th=
ought it
> > > > > did :(=C2=A0 An unbind will bypass that (as well any real hot unp=
lug paths).
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > Yeps, it bypasses it but I just wanted to point out the flaw in the=
 current
> > > > design :)=C2=A0=20
> > >=20
> > > It was a surprise to me when Lars pointed this out years ago.
> > > All we can do is treat it as a hint for something that makes
> > > little sense for a user to deliberately do.
> > > =C2=A0=20
> > > > =C2=A0=20
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > 2) It's fairly easy to crash the kernel:
> > > > > >=20
> > > > > > "
> > > > > > root@analog:/sys/bus/spi/drivers/ad9467# echo spi0.0 > unbind
> > > > > > root@analog:/sys/bus/iio/devices/iio:device2# echo 1 >
> > > > > > buffer0/in_voltage0_en
> > > > > > root@analog:/sys/bus/iio/devices/iio:device2# echo 1 > buffer0/=
enable
> > > > > > [=C2=A0 132.349133] 8<--- cut here ---
> > > > > > [=C2=A0 132.352193] Unable to handle kernel paging request at v=
irtual
> > > > > > address e0940000 when read
> > > > > > [=C2=A0 132.360333] [e0940000] *pgd=3D0208b811, *pte=3D00000000=
, *ppte=3D00000000
> > > > > > [=C2=A0 132.366668] Internal error: Oops: 7 [#1] SMP ARM
> > > > > > [=C2=A0 132.371289] Modules linked in: ad9467 adi_axi_adc ad951=
7
> > > > > > [=C2=A0 132.376609] CPU: 1 PID: 444 Comm: bash Not tainted 6.2.=
9-dirty #3
> > > > > > [=C2=A0 132.382701] Hardware name: Xilinx Zynq Platform
> > > > > > [=C2=A0 132.387223] PC is at adi_axi_adc_update_scan_mode+0x34/=
0x88
> > > > > > [adi_axi_adc]
> > > > > > [=C2=A0 132.394020] LR is at arm_heavy_mb+0x1c/0x38
> > > > > > [=C2=A0 132.398212] pc : [<bf0060c4>]=C2=A0=C2=A0=C2=A0 lr : [<=
c031820c>]=C2=A0=C2=A0=C2=A0 psr: a0000013
> > > > > > [=C2=A0 132.404392] sp : e0929e30=C2=A0 ip : deaddead=C2=A0 fp =
: c4430270
> > > > > > [=C2=A0 132.409678] r10: c8a0bc18=C2=A0 r9 : deaddeac=C2=A0 r8 =
: c89b1c00
> > > > > > [=C2=A0 132.414895] r7 : c4430340=C2=A0 r6 : c45db7c0=C2=A0 r5 =
: e093ffc0=C2=A0 r4 :
> > > > > > 000003f0
> > > > > > [=C2=A0 132.421413] r3 : 00010000=C2=A0 r2 : e0940000=C2=A0 r1 =
: 00000000=C2=A0 r0 :
> > > > > > 00000000
> > > > > > "=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > It's nasty but generally that sort of path can be prevented with =
some
> > > > > careful locking and checking of indicators that a component has g=
one away.
> > > > > So whenever you unbind one aspect it notifies the other one that =
it has
> > > > > gone
> > > > > away. I'm not sure where to currently look for best practice in t=
his.
> > > > >=20
> > > > > There are a lot of similar situations - basically anywhere a set =
of=20
> > > > > drivers end up hanging off two buses.=C2=A0 v4l and media drivers=
 in general
> > > > > end up doing this a lot.
> > > > >=20
> > > > > One I'm familiar with is how some of the CXL tear down happens an=
d
> > > > > that lead me to device_release_driver() which is also used by usb=
 etc.
> > > > > I've not looked at this for a while but it may provide the tear d=
own
> > > > > needed
> > > > > if the right dance is used.=C2=A0 I think that will work if your =
convertor
> > > > > driver is using services off the IP core driver and someone unbin=
ds
> > > > > that ip-core driver.
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > Yes, CCF does it with refcounting and some dummy clock ops for the =
case a
> > > > clock
> > > > provider is gone (with active consumers).=C2=A0=20
> > >=20
> > > That must be 'exciting' on occasion as no way to know if the clock di=
sappeared
> > > or reset and hence the device interface might lock up.=20
> > > =C2=A0=20
> > > > =C2=A0=20
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > 3) This solution does not really scale. There are designs where=
 we have
> > > > > > multiple instances of the IP core attached to the client (typic=
ally if
> > > > > > a converter like this has more than one channel, we have one in=
stance
> > > > > > of the core per channel). The way we have it know, that would n=
ot me
> > > > > > feasable.
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > ...
> > > > =C2=A0=20
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > However, one thing that
> > > > > > I'm not sure it will be ideal with having two devices is synchr=
onizing
> > > > > > accesses to the IP core. For example, the axi-dac driver (that =
I also
> > > > > > intend to bring upstream as part of this work) also has an user=
space
> > > > > > interface so we need to be carefull.=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > I'm a bit lost. I think we'd only expect to see a userspace inter=
face
> > > > > on the 'front end' driver. Is there something on the driver handl=
ing the
> > > > > IP core as well (beyond debug which you can do whatever you like =
with :)
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > See below...=20
> > > > =C2=A0=20
> > > > > > But I guess this is no different
> > > > > > for devices which are accessed by the in-kernel IIO interface.
> > > > > >=20
> > > > > > I'm way more inclined to go with 2).=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > I'm not sure I fully follow what option 2) is!=C2=A0 Perhaps a bi=
t
> > > > > of ascii art?
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > So option 2 is pretty much treating the IP core also as a separate =
IIO
> > > > device.
> > > > This is not so visible in axi-adc but on the dac counterpart, the s=
ettings
> > > > to generate tones (frequency/phase) are on the core. So, this could=
 map to
> > > > IIO ABI.=C2=A0=20
> > >=20
> > > Those are of interest to which bit of analog circuitry?=C2=A0 The big=
 beyond the
> > > front end?=C2=A0 If so fine to provide that via the IIO interfaces, b=
ut the=20
> > > front end device should proxy them (using the IIO in kernel consumer
> > > interfaces
> > > - which probably needs some work to make them safe to the provider go=
ing away.
> > > From below, seems that a more focused interface for this particular d=
evice
> > > representation may make sense.
> > > =C2=A0=20
> >=20
> > Not sure I'm following your question but I'll try... The settings are o=
n the IP
> > core beyond the front end but I would say they are of interest of the f=
ront end
> > device. For instance, we might generate a tone on the IP core (setting =
phase and
> > frequency) but these bits are to be transmitted trough a dac/dds (our f=
ront end
> > device) analog, digital front end.
>=20
> hehe. I avoided opening your email for a few weeks because I thought it m=
ight
> drag me down a rat hole.=C2=A0 Then I find there is just a nice clean rep=
ly to
> my question that would have taken me 2 mins to read.
>=20

Ehehe. nice surprise then :)

> That makes complete sense.=C2=A0 To my mind only the front end needs to b=
e an IIO
> device, but if it's convenient to represent the back end as one we can pr=
obably
> make that work as well.
> >=20

Alright, I'll go then the one IIO device route for v1 (at least start worki=
ng with
that goal :)) so we can see how it looks like...

Thanks for your feedback on this!

- Nuno S=C3=A1
