Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B28336E58
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 09:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhCKI5P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 03:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhCKI5M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Mar 2021 03:57:12 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05249C061574
        for <linux-iio@vger.kernel.org>; Thu, 11 Mar 2021 00:57:11 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id g27so21090005iox.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Mar 2021 00:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44CweRzKGCg1BGh921OhI2ggQcVUPvPZzuVY+hxzvK4=;
        b=gxYMLwk+Ezd+ojWXFugqPZtJ7KsarvegynFAmG7WkaUqF+1KmI1BjL5liRc99ycYCM
         jXtX8smilFUkHauP+WwES+Lm6e+n2WS1Y5UOMYlHdrfOECSicv1D7K/sudYPUjNCSXJC
         b4FiaSKoSFDGAMuywKCB9PBkwhGhEuZfwKmsvTow6izem7EeYdj0laXjbHLedqO6RPll
         PVBCClNGPHvajx+g4eUfZBkK/4B3QRxcn1DUp8CsGt7fdWyIi9TwIiGRTuHhjdviGwRV
         TdFg20thExYH/5XBLSaG7GX5cNpV+dOK50PoyIIp1+1eLJtmlXa8udr75/Jm/3zCZP9m
         tbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44CweRzKGCg1BGh921OhI2ggQcVUPvPZzuVY+hxzvK4=;
        b=S83x+1POEj8KlYmIKK1WdQruAHM6JsIFvI0unbJKTOIU/yhuVEsjQqGnqbwrWPsmWn
         InWd4zvZztUtrTlY0TKhmkipMaaF9XZDTx2KJq3KLcFCgbYg5vUbgPzyDFjHREVEd1Ie
         FdwOho1Y4E4DoYnZx6dBGmLep8zguqKOpLBArH2rD2w+/kaVzkRuuNcjvb4VQ1J8aKQr
         sIok56FoRn5d0R50r8MdC2gqrCMg+pTmgIqM5rlT3WDnKX7hw9me1pxCblkRVTg+2BYn
         zX4FNfkyKalqTw0qcpsA9OACPzNShCxrZw19wWSEoz6q5ZNyf7alJ2Hr37T49GmL7B1l
         FuxA==
X-Gm-Message-State: AOAM531jGH81HudWytyeT9oX/IXgxdMbN4IAJkn7R48R9Vg5hg86Qz5N
        /tvvZP3zxBU25tZzjbh6gGG62OCJUe3wYhCIfphQ+JPRzu36WA==
X-Google-Smtp-Source: ABdhPJzOcEGMTR4GxMFJM3a/Hd8mt/RR5Mg2g3JF4+t5JDdXK/3bJ0pE/bwpfh9iGTkfEmfGVOBAD/toIH701aybHUg=
X-Received: by 2002:a02:ec6:: with SMTP id 189mr2492645jae.91.1615453031307;
 Thu, 11 Mar 2021 00:57:11 -0800 (PST)
MIME-Version: 1.0
References: <CANBZqrGur27Mn8upmfz216tz4ZsgZoVEJTjhgmhDbWT-5_kxZg@mail.gmail.com>
 <20210310174535.00007ae2@Huawei.com> <20210310181843.00001b8f@huawei.com>
In-Reply-To: <20210310181843.00001b8f@huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 11 Mar 2021 10:57:00 +0200
Message-ID: <CA+U=Dsp98caW89g9FbsV-+KQ-NjyOqd+KSkO+aaFp4qBb-hpMg@mail.gmail.com>
Subject: Re: Contribution to linux-iio for GSOC 2021
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Utkarsh Verma <utkarshverma294@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 10, 2021 at 8:20 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 10 Mar 2021 17:45:35 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Wed, 10 Mar 2021 19:24:39 +0530
> > Utkarsh Verma <utkarshverma294@gmail.com> wrote:
> >
> > > Hello,
> > >
> > > This is Utkarsh Verma. I am a 3rd year Bachelor of Technology
> > > Undergrad in Electronics Engineering from HBTU, Kanpur, India.
> > >
> > > I want to participate in GSOC this summer, by contributing to the IIO
> > > subsystem. But more importantly, I want to be a part of this community
> > > and get my hands dirty.
> > >
> > > I have done the operating system course and know the very basics of
> > > Linux Kernel. I have also read some chapters of the "Linux Device
> > > Drivers" book. I am very new to the iio subsystem and I am still
> > > reading the documentation and the conversation on the mailing list. So
> > > if anyone can suggest some easy fixes/tasks for getting started would
> > > really be appreciated.
> > >
> > > I would be really happy to contribute.

One thing I've always wanted to do, is to convert the entire IIO
subsystem to devm_ variants.
Essentially getting rid of the iio_device_unregister() function in
favor of using devm_iio_device_unregister() and similar.

There's about ~217 uses of this function.
The more complicated one is in the 'drivers/platform/x86/toshiba_acpi.c'
I think reworking the Toshiba ACPI driver would also be interesting,
but it is some work.

Now, converting everything to devm_ variants can be considered a bit
of an obsession [by some people].
But I sometimes find potential memory leaks by doing this conversion.
And chances are that we may never be able to fully convert the IIO API
to be devm_ variant-only.
But it is an interesting process [for me], just the cleanup itself.

Another one, that was interesting until 1-2 years ago, was the
conversion of OF drivers to be a bit more ACPI friendly [as well].
This is also a bit of work to convert drivers that use only
of_property_read_xxxx()  functions to   device_property_read_xxx()
functions.
This isn't always straightforward in all drivers, but I do find it
interesting to unify the OF & ACPI interfaces, so that all you have to
do, is just switch the system from OF to ACPI underneath, and if the
device-tree conversion to ACPI is done right, it just works.

Then, there's the matter of moving fields [marked as [INTERN] )  from
"struct iio_dev"  to "struct iio_dev_opaque".
The value of this conversion is to reduce the review pain of having to
tell people not-to-use [INTERN] fields [especially when older drivers
do].

> > >
> > > Regards,
> > > Utkarsh Verma
> >
> > Hi Utkarsh,
> >
> > Welcome to IIO.
> >
> > If you want a practical immediate task to make sure you have flow
> > of submitting patches etc correct, one issue we've just started seeing
> > is that when we do
> >
> > make W=1
> >
> > we get some misleading reports like:
> >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> > > head:   4ef57c4862e38e6034978d8b247a511292d7055a
> > > commit: 1cabd1c21b2a6c5b0dd3fdcffe0b24c1d0e4fc38 [72/74] iio: hrtimer: Allow sub Hz granularity
> > > config: x86_64-randconfig-a011-20210308 (attached as .config)
> > > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 3a11a41795bec548e91621caaa4cc00fc31b2212)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install x86_64 cross compiling tool for clang build
> > >         # apt-get install binutils-x86-64-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=1cabd1c21b2a6c5b0dd3fdcffe0b24c1d0e4fc38
> > >         git remote add iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> > >         git fetch --no-tags iio testing
> > >         git checkout 1cabd1c21b2a6c5b0dd3fdcffe0b24c1d0e4fc38
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> drivers/iio/trigger/iio-trig-hrtimer.c:20: warning: expecting prototype for O periodic hrtimer trigger driver(). Prototype was for PSEC_PER_SEC() instead
> > >
> > >
> > > vim +20 drivers/iio/trigger/iio-trig-hrtimer.c
> > >
> > >     18
> > >     19  /* Defined locally, not in time64.h yet. */
> > >   > 20  #define PSEC_PER_SEC   1000000000000LL
> > >     21
> > >
> >
> > Gwendal figured out what was going on.  It's down to an incorrect marking of the
> > initial comment block (where copyright notice etc is ) as kernel doc
> > by prefixing it with /**
> >
> > If you'd like to first fine one of those cases and send a patch fixing it that
> > would be great.  Once we've sanity checked that first one for process issues etc
> > you could then ensure there are no other instances in IIO.
> >
> > No problem if not and you want something more substantial to start with.
> > This is just something that hit my inbox today that I'd otherwise clean up,
> > but seemed like a good task for anyone wanting to get started!
>
> Actually scrap that idea.  Serves me right for not reading all my IIO related emails
> but Gwendal already sent out a patch fixing them all.  Sorry!
>
> Jonathan
>
> >
> > Thanks,
> >
> > Jonathan
>
