Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F9B35CC
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 09:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfIPHjO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 03:39:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32892 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfIPHjO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 03:39:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so6653480wme.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2019 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=AZOOb0eMKM38NxrEFDZXr4UaRQupPbk1mNGsC8p/he4=;
        b=TpLtYuE+M41PL1Ay8mc17xVjTWeuBtG5RHIHWNw4dVxVA/Fo5cTtmUXfEWEu3ls0ow
         RVB8xyqK10yLpFfjAGDcI2eZUi9sCKdcZlaefcGpMi6nQiSPs4yMVoJXM53qXiuQhHJ4
         n41agEFUsDvlTuHnpWXV16fFWUwBz+8owSA6xLc5YYIKvZm42HP57nhjDgjK3EGqleXA
         1bCkbLaeY8YMQG3NmRi93uPzDxgXkvcsOBB9neWEHlcL8FR7JpwIX8XiO6CuP9oBobfd
         KP6sKzvD4i4mcmMrIUx3sOWPscwv2tO9hOjkQKthLA3fxwG28PI7M56W+Pb9E9YL+xIt
         6P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=AZOOb0eMKM38NxrEFDZXr4UaRQupPbk1mNGsC8p/he4=;
        b=OMit9p23xT0v/cioEqRpW1JnQsXgRLQB5x1WM7G9K/ZNo+AVoSctC1IyGD9Yb7zufb
         svfYf6cz3A3oeODC52dCOS+1c9K+j4IZUcRZB9xXLR6/7HsYe+XyfUDmYqK+M7iLRL+n
         ErxnNGklFWO7zxxaKocho/ZE0oFK/5ZwrCOXe1andajk8cIpJE+go/9XyWrHW2QUyElv
         WTyUPRsQcOPq74r53hdrw39KcnEvWX0PrHvRqFeVi5olNX5Nb9+Ge39wsw9FTMbBU3zJ
         jqexL2oGAA9Do5Tgq9n+On6BzWiMHJX5t+vk03URPElP3hUvYdxAoa8JLkz/tjFa9+QF
         FwKg==
X-Gm-Message-State: APjAAAVPxtHf29NC6eYZ/5LlwcHmH6zGt38blY4lwc/jiQeVkglCSs1x
        ih78+zdFrIajsv9Jw0F84uJUYkbLrsQNQj8O5ZQ=
X-Google-Smtp-Source: APXvYqxsUMKr+faKmdkURyVYfYWy+1c8WJsCKpuJ/rHW3T34azv0/4BmTcceu8YZvwcxQWVQ5lB+8nLqp7OMyxLrfVk=
X-Received: by 2002:a1c:a617:: with SMTP id p23mr12882480wme.166.1568619551576;
 Mon, 16 Sep 2019 00:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <1f13820761bbdb4db685a90e9bcf35a388b246cf.camel@analog.com>
 <2b7ab6c3-6ff6-69b5-bbd4-f8a1966b6b57@essensium.com> <20190915114939.13fc6d44@archlinux>
In-Reply-To: <20190915114939.13fc6d44@archlinux>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 16 Sep 2019 09:39:00 +0200
Message-ID: <CAN8YU5NVWubV0HeXDHZ=fJThaKTC5R2AoNtX-BsDdifVkiJZnA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fixes for ad7949
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Couret Charles-Antoine <charles-antoine.couret@essensium.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno dom 15 set 2019 alle ore 12:49 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Fri, 13 Sep 2019 16:00:29 +0200
> Couret Charles-Antoine <charles-antoine.couret@essensium.com> wrote:
>
> > Le 13/09/2019 =C3=A0 09:24, Ardelean, Alexandru a =C3=A9crit :
> > > On Thu, 2019-09-12 at 16:43 +0200, Andrea Merello wrote:
> > >> [External]
> > >>
> > >> This patch series fixes ad7949 driver incorrectly read data, simplif=
y the
> > >> code, and enforces device timing constraints.
> > >>
> > >> This has been tested on a UltraZed SOM + a custom carrier equipped w=
ith
> > >> several AD7689 A/Ds. Patches have been developed on a Xilinx upstrea=
m
> > >> kernel and then rebased on linux-next kernel.
> > >>
> > > Thanks for the patches.
> > > Added Charles-Antoine to also take a look.
> > > Apologies for not thinking of adding him sooner.
> > >
> > > I typically try to review changes for ADI parts, but he wrote it, so =
he may have more input than I do.
> > > Jonathan will likely also take a look.
> > >
> > > If it's agreed, I would say to at least take the first patch ("iio: a=
d7949: kill pointless "readback"-handling code")
> > > now and see about the rest.
> > > The rest are a bit more open to discussion, so a v2 may happen.
> >
> > Hi,
> >
> > Don't worry. Due to the fact I don't have on my mail client access to
> > the whole discussions, I'm making a complete answer there based on the
> > archive of the mailing list. Sorry for that.
> >
> >
> > For the patch 1, I approve it too. This part of code is useless because
> > the feature was removed. RIP my code. :D
> >
> > For the patch 2, the cache information was added due to comment from
> > Jonathan Cameron when I developed the driver. The comment was:
> >
> > > Look very carefully at the requirements for a buffer being passed
> > > to spi_sync.  It needs to be DMA safe.  This one is not.  The usual
> > > way to do that easily is to put a cacheline aligned buffer in your
> > > ad7949_adc_chip structure.
>
> The short version of this is best illustrated with an example.
> This only applies systems where the DMA engines are not coherent
> (i.e. a change made by a DMA engine is not automatically updated to
>  all other places a copy is held in caches in the system, we have to
>  do it by hand).
>
> We have a structure like
> struct bob {
>         int initial_data;
>         u8 buffer[8];
>         int magic_flags
> };
>
> When a DMA transfer is setup involving 'buffer', the DMA engine may take
> up to a cacheline (typically 64 bytes) including buffer, make a copy of i=
t
> and assume that the only bit of hardware working in this cacheline is its=
elf.
> (Linux is 'guaranteeing' this when it tells the DMA engine to use this bu=
ffer.'.
> Whilst that DMA is going on, a CPU can write something in magic flags.
> That something might be important but unrelated to the DMA transfer going
> on.
>
> The DMA finishes, having put new data in the buffer element of the copy
> of the cacheline local to . It's guaranteed to not change it's copy of th=
e
> cacheline (in this case containing the whole of bob).   However, it's ver=
sion
> of magic_flags is out of date so when we flush the caches at the end of t=
he
> non coherent DMA transfer (to force the CPU to read it from main memory a=
nd
> get the new values in buffer), the value of magic_flags can be reset to t=
he
> version the DMA engine has.
>
> So, upshot is to avoid any potential of such problems, DMA buffers 'must'
> always be in a cacheline containing nothing that might be changed by
> other activities.  This can mean it is safe to put both TX and RX buffers
> in the same cacheline as we won't touch either during an SPI transfer.
>
> > >
> > > Lots of examples to copy, but it's also worth making sure you underst=
and
> > > why this is necessary.
> >
> > For the endianess thing, it shouldn't be required to make an explicit
> > conversion into the driver. According to the spi.h documentation:
> >
> > > * In-memory data values are always in native CPU byte order, translat=
ed
> > > * from the wire byte order (big-endian except with SPI_LSB_FIRST). So
> > > * for example when bits_per_word is sixteen, buffers are 2N bytes lon=
g
> > > * (@len =3D 2N) and hold N sixteen bit words in CPU byte order.
> > So from my point of view the SPI subsystem always converts to the right
> > endianess. We don't have to take care about it.
>
> Correct, though as I commented on that patch, that's not always 'possible=
'
> and not all drivers set the word length 'correctly'.

Thank you both for the explanations about DMA and SPI endianess :)

So indeed 2/4 seems OK to me, and it doesn't need any further
endianess-related fix.


> Wolfram's presentation on trying to implement DMA safety in I2C at ELCE20=
18
> also touches on a lot of this.
>
> Thanks,
>
> Jonathan
>
> >
> >
> > For patch 3, I didn't use delay_usecs fiels due to the timings
> > definition in the datasheet in "READ/WRITE SPANNING CONVERSION WITHOUT =
A
> > BUSY INDICATOR" mode. During the delay, the chip select line must be
> > released which is not the case when we use delay_usecs field. So I add
> > the delay instruction after the write step to be compliant with these
> > timings.
> >
> >
> > For patch 4, I explained a bit in the other thread. Maybe we have a
> > difference of behaviour due to the choice of the timings "modes"?
> >
> >
> > BTW, from my point of view the datasheet is not totally clear about the
> > timings and what is mandatory or not in the expected behaviour.
> >
> > Regards,
> >
> > Charles-Antoine Couret
> >
>
