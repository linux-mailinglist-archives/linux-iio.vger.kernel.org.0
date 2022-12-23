Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0509D65512C
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 15:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLWOIE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 09:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWOIC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 09:08:02 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DFF248C2
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 06:08:01 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id c14so3290179qvq.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 06:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHtFcKLcvhK0mboZMOdOw5ZLhPm38IwbseT9gxozaoM=;
        b=SBAEnsaZRJAVdSJRGHLsdxlvMRmpO587XryNuKHmSz6swYPz6xB1ThTAHT1wRAERoN
         IYhYo6vtul7KhJcDYcypz73KGeaslYruiwIxgGf56AY8JODVuRJdVzIEwrM3pfU90KiA
         Qw+y7wDu6BciSKvQ3ftAI+gT1U1Jb6Se0cog8XeHnfGp0fICP+wRlW1XsqcNU4lQgIDE
         aravQqvQZqAd0vvmTJmJExSCVi5YlnW80aIyBX+4428TFhrqO15BLrjeOnLPIv7nhBTx
         mX49BwPl0uz4j/rmjVThVBjHjinkqtyO3wY4bjvhFeheo9+BlF6DuyhMZU/aLBNKQ4bX
         lCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHtFcKLcvhK0mboZMOdOw5ZLhPm38IwbseT9gxozaoM=;
        b=h3LwuklOkgWoqG5E/lvpLse0VX8FOQR1oE+J8axMeT1K06PLdoGeY5utbOGRBgQCza
         8al1YcG1trnb8jtMIEGO7X1Dp98jP/1Wny0VBnvJyd+VELJAsm6JEqFXMaA6j6kPmB+Q
         Uh13P7uM7RK9mvr97Ea6akRx3xD60/Vgiggn1je7FNwY+EPUco8V3g9ZBPBY2B33PP7j
         dB7Rm+RYhV92tjSo2OA244R0L/T8sNOygPYd3Q71JL+eV6H7c1kOndkoMkhL+PCwjIa7
         jLjtbFPZG5KBxTRXDUg8Uicr6r1fA370gqdzBg7kbD7D3VBcCsUHEEiyJSWtOYKwu9Pd
         Kf2w==
X-Gm-Message-State: AFqh2kq1MX6dnULv0R8jNkFKrFq8+F/7zk40u1oertJRTd97VuqA2B+g
        Z+uCmGrkv5eVG5phbae1aJe7JXGIi96Or7cse4s=
X-Google-Smtp-Source: AMrXdXvZfTssM2NYxXM7pd+v5jIB7aX+yzt6g+6mmykkIuU1D/55NNZ6tRWhT+NeiTuUAPU8HZZkTjnjwsaqxmYg6sQ=
X-Received: by 2002:a05:6214:186d:b0:4c7:3b70:82f with SMTP id
 eh13-20020a056214186d00b004c73b70082fmr415352qvb.25.1671804480227; Fri, 23
 Dec 2022 06:08:00 -0800 (PST)
MIME-Version: 1.0
References: <CALpf1uAE+H+kMHmCoeACF65YDK0cNwie5MG3a11rkVKs59XLLg@mail.gmail.com>
 <0adad745-004d-8f70-510c-8af3c0935c2a@gmail.com>
In-Reply-To: <0adad745-004d-8f70-510c-8af3c0935c2a@gmail.com>
From:   Mehdi Djait <mehdidjait@gmail.com>
Date:   Fri, 23 Dec 2022 15:07:23 +0100
Message-ID: <CALpf1uCQ5t=mrNMrMywHjcp4me39cknFoXkkJw=Wj6U-otbJ1g@mail.gmail.com>
Subject: Re: KX132/134-1211
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le ven. 23 d=C3=A9c. 2022 =C3=A0 09:29, Matti Vaittinen
<mazziesaccount@gmail.com> a =C3=A9crit :
>
> Hi Mehdi,
>
> On 12/22/22 16:06, Mehdi Djait wrote:
> > Hello Matti,
> >
> > First of all I apologize for bothering you out of the blue and I hope i=
t
> > is not a bad time to send you an email with a couple of questions.
>
> No problem. But I suggest you CC the IIO mail list when sending this
> kind of questions. It may be the messages where the list is not in CC
> are regarded as spam by my mail filters... Besides, others with more
> insight to IIO may be able to further help you when the list is CC'd ;)
>

First of all, thank you for the quick response!
I will CC the IIO mailing list  next time :)

> > My name is Mehdi Djait, I am a student living in Germany currently,
> > REALLY interested in linux kernel development and still trying to find
> > something to contribute to the kernel. The IIO subsystem seems like a
> > good place to start for a kernel Newbie and am currently investing my
> > time in learning the subsystem (reading driver implementations, the
> > IIO-core, lurking in the mailing list ...) I have been looking lately
> > everywhere for sensors without a kernel driver and I stumbled upon the
> > KX132/134-1211 accelerometers and that's why I decided to send you an
> > email with these questions:
>
> Oh, thanks for contacting me :) So, you have the sensor hardware at your
> hands? I think this is mandatory when writing a driver.
>

Yes of course!

> > - Am I correct in assuming that the accelerometer does not have a kerne=
l
> > driver ? I looked in the RohmSemiconductor Linux-Kernel-Input-Drivers
> > and Linux-Kernel-Sensor-Drivers GitHub repos and grepped inside the iio=
,
> > staging and linux-next trees
>
> Yes and no :) There is a kernel driver which supports many of the kx*
> accelerometers in the ROHM downstream Linux-Kernel-Input-Drivers, and I
> believe it also supports the KX132/KX134. Yet, as the name suggests -
> these drivers are not exposing the accelerometer using IIO but the INPUT
> subsystem. Reason is that quite a few device manufacturers still use the
> accelerometers via HAL written on top of the INPUT. Heikki Haikola (in
> CC) has authored many of these drivers. The INPUT is not the preferred
> subsystem for acceleromerers though - so you're correct when planning to
> write an IIO driver for upstream.
>
> > - Is anyone working on a driver now ? If not, I am really interested in
> > trying to write one for some basic functionality. I am fully __AWARE__
> > how difficult the task is (I did read your LinkedIn posts) but I am
> > truly motivated and I will use every example I can find as reference:
> > the drivers under iio/accel, the GitHub repos from RohmSemiconductor an=
d
> > your KX02AA driver that recently landed in linux-next (Congrats :) )
>
> Upstream support for (ROHM or any other) ICs is very welcome. It enables
> more and more people to benefit from the ICs. Companies can rarely
> support small customers and open source drivers make it possible for the
> people to work without this support :) This work has been on my TODO
> list since I added KX022A driver - but it has had low priority and I
> seem to always have some other tasks. So, Your work on these ICs is more
> than welcome!
>

I am glad to hear that!

> > I=E2=80=99m eager to receive your feedback! (and sorry for the long tex=
t)
>
> It was not too long :)
>
> If you wish to proceed with the driver, then I would have couple of
> suggestions to you. As far as I remember the KX132 is not really _that_
> different from the KX022A. Sure the resolution is different as may be
> the G-ranges. But the logic of the register interface is largely same. I
> suggest you to study the possibility of extending the KX022A driver to
> support the other variants. I would differentiate the IC types based on
> device-tree and fill in the register offsets/required quirks in the
> driver private data.
>
> The other suggestion from me is that you could check the IC's logic from
> the Linux-Kernel-Input-Drivers. I think there were some minor
> differencies in the behaviour for example when the BUFE or PC1 bits are
> toggled.
>
> Feel free to ask us if you hit to problems with the work, but please
> note that most of us in Finland are having a holiday season right now -
> so many of us will be offline until January.
>

I will probably hit many problems ;) But I will try my best

Kind regards
Mehdi Djait

> Yours,
>         -- Matti
>
> > Kind regards
> > Mehdi Djait
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>
>
