Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56614B2F99
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 12:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfIOKtq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 06:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfIOKtq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 06:49:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2672A20830;
        Sun, 15 Sep 2019 10:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568544584;
        bh=g4iKLO30QmH/vSe/ETt40kmvOqGQOFbeZ7Noprbaheg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vL7ZcPJWCLBmbl9LMnvPbIKRaQLVWeoHpn6b/3il2CW31emQp9WlGxevDYwACYMqV
         43C2zCwI8u/7hkV7AzVWQbR+XmA2dOXyB4vG/2zHECBkjRCRVMNt+uUZao+k1MOFQ9
         C54YVeatKNr40aiaDJFxNJnAXGiwLgPQKB1C7AQo=
Date:   Sun, 15 Sep 2019 11:49:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/4] Fixes for ad7949
Message-ID: <20190915114939.13fc6d44@archlinux>
In-Reply-To: <2b7ab6c3-6ff6-69b5-bbd4-f8a1966b6b57@essensium.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
        <1f13820761bbdb4db685a90e9bcf35a388b246cf.camel@analog.com>
        <2b7ab6c3-6ff6-69b5-bbd4-f8a1966b6b57@essensium.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Sep 2019 16:00:29 +0200
Couret Charles-Antoine <charles-antoine.couret@essensium.com> wrote:

> Le 13/09/2019 =C3=A0 09:24, Ardelean, Alexandru a =C3=A9crit=C2=A0:
> > On Thu, 2019-09-12 at 16:43 +0200, Andrea Merello wrote: =20
> >> [External]
> >>
> >> This patch series fixes ad7949 driver incorrectly read data, simplify =
the
> >> code, and enforces device timing constraints.
> >>
> >> This has been tested on a UltraZed SOM + a custom carrier equipped with
> >> several AD7689 A/Ds. Patches have been developed on a Xilinx upstream
> >> kernel and then rebased on linux-next kernel.
> >> =20
> > Thanks for the patches.
> > Added Charles-Antoine to also take a look.
> > Apologies for not thinking of adding him sooner.
> >
> > I typically try to review changes for ADI parts, but he wrote it, so he=
 may have more input than I do.
> > Jonathan will likely also take a look.
> >
> > If it's agreed, I would say to at least take the first patch ("iio: ad7=
949: kill pointless "readback"-handling code")
> > now and see about the rest.
> > The rest are a bit more open to discussion, so a v2 may happen. =20
>=20
> Hi,
>=20
> Don't worry. Due to the fact I don't have on my mail client access to=20
> the whole discussions, I'm making a complete answer there based on the=20
> archive of the mailing list. Sorry for that.
>=20
>=20
> For the patch 1, I approve it too. This part of code is useless because=20
> the feature was removed. RIP my code. :D
>=20
> For the patch 2, the cache information was added due to comment from=20
> Jonathan Cameron when I developed the driver. The comment was:
>=20
> > Look very carefully at the requirements for a buffer being passed
> > to spi_sync.  It needs to be DMA safe.  This one is not.  The usual
> > way to do that easily is to put a cacheline aligned buffer in your
> > ad7949_adc_chip structure.

The short version of this is best illustrated with an example.
This only applies systems where the DMA engines are not coherent
(i.e. a change made by a DMA engine is not automatically updated to
 all other places a copy is held in caches in the system, we have to
 do it by hand).

We have a structure like
struct bob {
	int initial_data;
	u8 buffer[8];
	int magic_flags
};

When a DMA transfer is setup involving 'buffer', the DMA engine may take
up to a cacheline (typically 64 bytes) including buffer, make a copy of it
and assume that the only bit of hardware working in this cacheline is itsel=
f.
(Linux is 'guaranteeing' this when it tells the DMA engine to use this buff=
er.'.
Whilst that DMA is going on, a CPU can write something in magic flags.
That something might be important but unrelated to the DMA transfer going
on.

The DMA finishes, having put new data in the buffer element of the copy
of the cacheline local to . It's guaranteed to not change it's copy of the
cacheline (in this case containing the whole of bob).   However, it's versi=
on
of magic_flags is out of date so when we flush the caches at the end of the
non coherent DMA transfer (to force the CPU to read it from main memory and
get the new values in buffer), the value of magic_flags can be reset to the
version the DMA engine has.

So, upshot is to avoid any potential of such problems, DMA buffers 'must'
always be in a cacheline containing nothing that might be changed by
other activities.  This can mean it is safe to put both TX and RX buffers
in the same cacheline as we won't touch either during an SPI transfer.

> >
> > Lots of examples to copy, but it's also worth making sure you understand
> > why this is necessary. =20
>=20
> For the endianess thing, it shouldn't be required to make an explicit=20
> conversion into the driver. According to the spi.h documentation:
>=20
> > * In-memory data values are always in native CPU byte order, translated
> > * from the wire byte order (big-endian except with SPI_LSB_FIRST). So
> > * for example when bits_per_word is sixteen, buffers are 2N bytes long
> > * (@len =3D 2N) and hold N sixteen bit words in CPU byte order. =20
> So from my point of view the SPI subsystem always converts to the right=20
> endianess. We don't have to take care about it.

Correct, though as I commented on that patch, that's not always 'possible'
and not all drivers set the word length 'correctly'.

Wolfram's presentation on trying to implement DMA safety in I2C at ELCE2018
also touches on a lot of this.

Thanks,

Jonathan

>=20
>=20
> For patch 3, I didn't use delay_usecs fiels due to the timings=20
> definition in the datasheet in "READ/WRITE SPANNING CONVERSION WITHOUT A=
=20
> BUSY INDICATOR" mode. During the delay, the chip select line must be=20
> released which is not the case when we use delay_usecs field. So I add=20
> the delay instruction after the write step to be compliant with these=20
> timings.
>=20
>=20
> For patch 4, I explained a bit in the other thread. Maybe we have a=20
> difference of behaviour due to the choice of the timings "modes"?
>=20
>=20
> BTW, from my point of view the datasheet is not totally clear about the=20
> timings and what is mandatory or not in the expected behaviour.
>=20
> Regards,
>=20
> Charles-Antoine Couret
>=20

