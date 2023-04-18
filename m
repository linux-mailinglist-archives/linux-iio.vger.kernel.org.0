Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016CB6E6608
	for <lists+linux-iio@lfdr.de>; Tue, 18 Apr 2023 15:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjDRNeb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Apr 2023 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDRNeb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Apr 2023 09:34:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70959119
        for <linux-iio@vger.kernel.org>; Tue, 18 Apr 2023 06:34:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kt6so35078768ejb.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Apr 2023 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681824868; x=1684416868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/fjESUg1jzNTMnsyWZnYDkko9sCIyQq9ydxJTGm7JSQ=;
        b=LPnbMDL5baOskV9YOdRorWcOaCn6XDoMZzzxj1bnXzbQY+Z0A/hjBXDbZXLV5gZePn
         Q4G4BxPP8dwZO8g7QJyeirxl+Xw8Qe9L0BrN+zetXZG3GtH98myVBd/U1JyOgOcjtLjF
         qTrNOAaCK8Enc0wN5UH/nrVBhHuzTKzL93uymQYDxC0qbFBSHE9a7z7eJaqr/xnfwwWT
         mliADJ/DCTzvj9RGCEpRwBqpcFqTWt5q0tstpj2SvtUV/3WxXN0usONxF5EbESkIGbSA
         Lppa2eNJQsvwZabuV8DEpY2QNrmpfmPoqswUpZMjMPVeQZtmmOgRKYQodhggRJrbgUGw
         Tfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681824868; x=1684416868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fjESUg1jzNTMnsyWZnYDkko9sCIyQq9ydxJTGm7JSQ=;
        b=SgFrGzMVmkpQDzGhhjAuu6jrJP0haoLL9V4u4FEqSB/27cSoS1dTIsNLlCOJD+emZi
         PBdV4kGWrn5MPjSUVFSdXZ1LSznEBr3Ou09qFTCSc83klNd37WdcY+oECrFp4Ez07mHk
         DpAVp86FtyxL0rJ4UuIPVh8FvoQ8U8WolggPAGBZSGK5REdH2aPqIUdexC37X7e9oNIz
         9ybDHUSedePk84UVSBcl7d3Sknmb/W6U3z6R/uy1s3tYJV+B50WXtY8Do/YOzN0JyB10
         8rMkQ067OaR4kOr+1wx3IsWnVteQvUbnIXlawmDItSRaWGg0FyG3t5Cp/7wrFsxszyfW
         XWCA==
X-Gm-Message-State: AAQBX9ePTR6u1n9fBgSWHeB52ETRdL6hjYn+lpw8aAo7HCJx7IcdRCK1
        5DRxHCxP/a1lAig8GUDQT0pANliRt/WBCBiS
X-Google-Smtp-Source: AKy350bVDymMDsOKHDnVTO3cE7ktsLIT1hkPw7RQ6gWdz4BgxehBvQcQE+/wrkKgRtqewEN88uCAoQ==
X-Received: by 2002:a17:907:a07:b0:94f:a309:67b9 with SMTP id bb7-20020a1709070a0700b0094fa30967b9mr4277625ejc.6.1681824867335;
        Tue, 18 Apr 2023 06:34:27 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id n13-20020a1709065dad00b0094a52b041dasm7971630ejv.112.2023.04.18.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 06:34:26 -0700 (PDT)
Message-ID: <c7b49491507bb85e5dc2b1b8b03a6c35b02978af.camel@gmail.com>
Subject: Re: adi-axi-adc issues and how to properly support this designs
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Tue, 18 Apr 2023 15:36:35 +0200
In-Reply-To: <20230416143316.59dca9f3@jic23-huawei>
References: <dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com>
         <20230410132138.6c5b4c87@jic23-huawei>
         <d5c0f825838f84f734d5af1f26bb0eac915532d5.camel@gmail.com>
         <20230416143316.59dca9f3@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
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

On Sun, 2023-04-16 at 14:33 +0100, Jonathan Cameron wrote:
> On Fri, 14 Apr 2023 11:11:43 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > Hi Jonathan,
> >=20
> > Thanks for the feedback. Definitely helpful...
> >=20
> > On Mon, 2023-04-10 at 13:21 +0100, Jonathan Cameron wrote:
> > > On Fri, 31 Mar 2023 16:40:44 +0200
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > =C2=A0=20
> > > > Hi Jonathan,
> > > > =C2=A0=20
> > >=20
> > > Hmm. Complex topic, so I'd definitely like others to weigh in with
> > > opinions .
> > > =C2=A0=20
> > > > There are some major issues with the implementation we have upstrea=
m
> > > > for the adi-axi-adc driver. The only user is the ad9467 driver. In =
the
> > > > rest of the email I will refer to ad9467 as the converter device an=
d
> > > > axi-adc as the IP core.=20
> > > >=20
> > > > Let me start to state that these designs, in a very a basic way, ha=
ve a
> > > > converter connected to a IP core that typically lives in a FPGA. Th=
is
> > > > core connects to a DMA core (which is used by the DMA buffer
> > > > implementation) so we can keep up with the high rates of these
> > > > converters. So there's a link between these devices and we try to
> > > > implement that so far looking at them as one single IIO device.
> > > >=20
> > > > Let's go to the major issues now:
> > > >=20
> > > > 1) There is a circular dependency between the two device. And when
> > > > compiled as modules for example, we cannot really rmmod the modules
> > > > anymore:
> > > >=20
> > > > "root@analog:~# rmmod ad9467
> > > > rmmod: ERROR: Module ad9467 is in use
> > > >=20
> > > > root@analog:~# rmmod adi-axi-adc.ko
> > > > rmmod: ERROR: Module adi_axi_adc is in use by: ad9467
> > > > "
> > > >=20
> > > > This easy to understand as the ad9467 driver as a direct symbol
> > > > dependency on the axi-adc one. And this one calls 'module_get()' as
> > > > soon as it attaches to a "client"=C2=A0=20
> > >=20
> > > Ouch. module_get() never works for this.=C2=A0 Long time ago I though=
t it
> > > did :(=C2=A0 An unbind will bypass that (as well any real hot unplug =
paths).
> > > =C2=A0=20
> >=20
> > Yeps, it bypasses it but I just wanted to point out the flaw in the cur=
rent
> > design :)
>=20
> It was a surprise to me when Lars pointed this out years ago.
> All we can do is treat it as a hint for something that makes
> little sense for a user to deliberately do.
>=20
> >=20
> > > =C2=A0=20
> > > >=20
> > > > 2) It's fairly easy to crash the kernel:
> > > >=20
> > > > "
> > > > root@analog:/sys/bus/spi/drivers/ad9467# echo spi0.0 > unbind
> > > > root@analog:/sys/bus/iio/devices/iio:device2# echo 1 >
> > > > buffer0/in_voltage0_en
> > > > root@analog:/sys/bus/iio/devices/iio:device2# echo 1 > buffer0/enab=
le
> > > > [=C2=A0 132.349133] 8<--- cut here ---
> > > > [=C2=A0 132.352193] Unable to handle kernel paging request at virtu=
al
> > > > address e0940000 when read
> > > > [=C2=A0 132.360333] [e0940000] *pgd=3D0208b811, *pte=3D00000000, *p=
pte=3D00000000
> > > > [=C2=A0 132.366668] Internal error: Oops: 7 [#1] SMP ARM
> > > > [=C2=A0 132.371289] Modules linked in: ad9467 adi_axi_adc ad9517
> > > > [=C2=A0 132.376609] CPU: 1 PID: 444 Comm: bash Not tainted 6.2.9-di=
rty #3
> > > > [=C2=A0 132.382701] Hardware name: Xilinx Zynq Platform
> > > > [=C2=A0 132.387223] PC is at adi_axi_adc_update_scan_mode+0x34/0x88
> > > > [adi_axi_adc]
> > > > [=C2=A0 132.394020] LR is at arm_heavy_mb+0x1c/0x38
> > > > [=C2=A0 132.398212] pc : [<bf0060c4>]=C2=A0=C2=A0=C2=A0 lr : [<c031=
820c>]=C2=A0=C2=A0=C2=A0 psr: a0000013
> > > > [=C2=A0 132.404392] sp : e0929e30=C2=A0 ip : deaddead=C2=A0 fp : c4=
430270
> > > > [=C2=A0 132.409678] r10: c8a0bc18=C2=A0 r9 : deaddeac=C2=A0 r8 : c8=
9b1c00
> > > > [=C2=A0 132.414895] r7 : c4430340=C2=A0 r6 : c45db7c0=C2=A0 r5 : e0=
93ffc0=C2=A0 r4 :
> > > > 000003f0
> > > > [=C2=A0 132.421413] r3 : 00010000=C2=A0 r2 : e0940000=C2=A0 r1 : 00=
000000=C2=A0 r0 :
> > > > 00000000
> > > > "=C2=A0=20
> > >=20
> > > It's nasty but generally that sort of path can be prevented with some
> > > careful locking and checking of indicators that a component has gone =
away.
> > > So whenever you unbind one aspect it notifies the other one that it h=
as
> > > gone
> > > away. I'm not sure where to currently look for best practice in this.
> > >=20
> > > There are a lot of similar situations - basically anywhere a set of=
=20
> > > drivers end up hanging off two buses.=C2=A0 v4l and media drivers in =
general
> > > end up doing this a lot.
> > >=20
> > > One I'm familiar with is how some of the CXL tear down happens and
> > > that lead me to device_release_driver() which is also used by usb etc=
.
> > > I've not looked at this for a while but it may provide the tear down
> > > needed
> > > if the right dance is used.=C2=A0 I think that will work if your conv=
ertor
> > > driver is using services off the IP core driver and someone unbinds
> > > that ip-core driver.
> > > =C2=A0=20
> >=20
> > Yes, CCF does it with refcounting and some dummy clock ops for the case=
 a
> > clock
> > provider is gone (with active consumers).
>=20
> That must be 'exciting' on occasion as no way to know if the clock disapp=
eared
> or reset and hence the device interface might lock up.=20
>=20
> >=20
> > > =C2=A0=20
> > > >=20
> > > > 3) This solution does not really scale. There are designs where we =
have
> > > > multiple instances of the IP core attached to the client (typically=
 if
> > > > a converter like this has more than one channel, we have one instan=
ce
> > > > of the core per channel). The way we have it know, that would not m=
e
> > > > feasable.
> > > > =C2=A0=20
> >=20
> > ...
> >=20
> > >=20
> > > =C2=A0=20
> > > > However, one thing that
> > > > I'm not sure it will be ideal with having two devices is synchroniz=
ing
> > > > accesses to the IP core. For example, the axi-dac driver (that I al=
so
> > > > intend to bring upstream as part of this work) also has an userspac=
e
> > > > interface so we need to be carefull.=C2=A0=20
> > >=20
> > > I'm a bit lost. I think we'd only expect to see a userspace interface
> > > on the 'front end' driver. Is there something on the driver handling =
the
> > > IP core as well (beyond debug which you can do whatever you like with=
 :)
> > > =C2=A0=20
> >=20
> > See below...=20
> >=20
> > > > But I guess this is no different
> > > > for devices which are accessed by the in-kernel IIO interface.
> > > >=20
> > > > I'm way more inclined to go with 2).=C2=A0=20
> > >=20
> > > I'm not sure I fully follow what option 2) is!=C2=A0 Perhaps a bit
> > > of ascii art?
> > > =C2=A0=20
> >=20
> > So option 2 is pretty much treating the IP core also as a separate IIO
> > device.
> > This is not so visible in axi-adc but on the dac counterpart, the setti=
ngs
> > to generate tones (frequency/phase) are on the core. So, this could map=
 to
> > IIO ABI.
>=20
> Those are of interest to which bit of analog circuitry?=C2=A0 The big bey=
ond the
> front end?=C2=A0 If so fine to provide that via the IIO interfaces, but t=
he=20
> front end device should proxy them (using the IIO in kernel consumer
> interfaces
> - which probably needs some work to make them safe to the provider going =
away.
> From below, seems that a more focused interface for this particular devic=
e
> representation may make sense.
>=20

Not sure I'm following your question but I'll try... The settings are on th=
e IP
core beyond the front end but I would say they are of interest of the front=
 end
device. For instance, we might generate a tone on the IP core (setting phas=
e and
frequency) but these bits are to be transmitted trough a dac/dds (our front=
 end
device) analog, digital front end.

- Nuno S=C3=A1

>=20
