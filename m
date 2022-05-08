Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1816B51EED7
	for <lists+linux-iio@lfdr.de>; Sun,  8 May 2022 18:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiEHQNa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiEHQN0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 12:13:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD340B1F4
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 09:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B398B80DBF
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 16:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260B9C385AC;
        Sun,  8 May 2022 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652026173;
        bh=Js+8DCLS00gXFqd38kaQTrqqANtkG5NhwwhkY1zryIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mbO0p0bvSdOPW53s8GNwOkt93l/XKlus5vnZfj/EQy0tM/ALQQ2W2x+ykj3iedv/j
         zQALCgas/BjZRQbz4PoRTUnfujD3dGpHtK+J1CoLeTZFH4lXO0O4O/4azNkJs8BuIG
         K9xVeddHavVJhh6gdmVd8+BBmm96IZQdNX9Sg2A0I/4V6q51xUG68fZwU1VC7Hmpc2
         Uw5fkMkqBe6yFRy4vUpisZXeOoB0Mhph12MvkWc6m63fX3LJV2jZ/KoIjCY4oX4BLC
         moA94sGs7QV3CGl490BcQvcfwKJCM9BeivjSMnHp1Rg0rMDY6YBXHuZULDUDWiEyrB
         YbYs8BqJ9SCzQ==
Date:   Sun, 8 May 2022 17:17:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        "Akinobu Mita" <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        "David Lechner" <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Marcelo Schmitt" <marcelo.schmitt1@gmail.com>,
        =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        "Mugilraj Dhavachelvan" <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "Paul Cercueil" <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>
Subject: Re: [PATCH 01/92] iio: core: Fix IIO_ALIGN as it was not
 sufficiently large on some platforms.
Message-ID: <20220508171755.0545b3c6@jic23-huawei>
In-Reply-To: <20220503172421.0000615c@Huawei.com>
References: <20220503085935.1533814-1-jic23@kernel.org>
        <20220503085935.1533814-2-jic23@kernel.org>
        <20220503142725.h6pcf2socuxgteix@pengutronix.de>
        <20220503172421.0000615c@Huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 May 2022 17:24:21 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 3 May 2022 16:27:25 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > On Tue, May 03, 2022 at 09:58:04AM +0100, Jonathan Cameron wrote: =20
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > Discussion of the series:
> > > https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas@a=
rm.com/
> > > mm, arm64: Reduce ARCH_KMALLOC_MINALIGN brought to my attention that
> > > our current IIO usage of L1CACHE_ALIGN is insufficient as their are A=
rm
> > > platforms out their with non coherent DMA and larger cache lines at
> > > at higher levels of their cache hierarchy.
> > >=20
> > > Note this patch will greatly reduce the padding on some architectures
> > > that have smaller requirements for DMA safe buffers.
> > >=20
> > > The history of changing values of ARCH_KMALLOC_MINALIGN via
> > > ARCH_DMA_MINALIGN on arm64 is rather complex. I'm not tagging this
> > > as fixing a particular patch from that route as it's not clear what t=
o tag.
> > >=20
> > > Most recently a change to bring them back inline was reverted because
> > > of some Qualcomm Kryo cores with an L2 cache with 128-byte lines
> > > sitting above the point of coherency.
> > >=20
> > > c1132702c71f Revert "arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_=
CACHE_BYTES)"
> > > That reverts:
> > > 65688d2a05de arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_CACHE_BY=
TES) which
> > > refers to the change originally being motivated by Thunder x1 perform=
ance
> > > rather than correctness.
> > >=20
> > > Fixes: 6f7c8ee585e9d ("staging:iio: Add ability to allocate private d=
ata space to iio_allocate_device")
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  include/linux/iio/iio.h | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index faf00f2c0be6..30937f8f9424 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -9,6 +9,7 @@
> > > =20
> > >  #include <linux/device.h>
> > >  #include <linux/cdev.h>
> > > +#include <linux/slab.h>
> > >  #include <linux/iio/types.h>
> > >  #include <linux/of.h>
> > >  /* IIO TODO LIST */
> > > @@ -657,8 +658,13 @@ static inline void *iio_device_get_drvdata(const=
 struct iio_dev *indio_dev)
> > >  	return dev_get_drvdata(&indio_dev->dev);
> > >  }
> > > =20
> > > -/* Can we make this smaller? */
> > > -#define IIO_ALIGN L1_CACHE_BYTES
> > > +/*
> > > + * Used to ensure the iio_priv() structure is aligned to allow that =
structure
> > > + * to in turn include IIO_ALIGN'd elements such as buffers which mus=
t not share
> > > + * cachelines with the rest of the structure, thus making them safe =
for use with
> > > + * non-coherent DMA.
> > > + */
> > > +#define IIO_ALIGN ARCH_KMALLOC_MINALIGN   =20
> >=20
> > Given the purpose of IIO_ALIGN is to define the alignment for DMA'able
> > memory, I wonder why it's called "IIO_ALIGN" and not for example
> > "DMA_MINALIGN". =20
>=20
> Much like crypto I want a single place that provides the IIO requirements
> for this.  Could rename it IIO_DMA_MINALIGN I guess.=20

I've switched to this naming for v2.

> The reason behind
> that is to allow for a switch on mass if a new approach is accepted
> along the lines of what Catalin proposed.  The discussions around
> CRYPTO made it clear that there are sometimes additional requirements
> from a subsystem beyond simply that of DMA (IIO has a similar issue
> to crypto that mean it's not simple to shift the alignment requirements
> at runtime because the compiler is getting told things are aligned to
> a higher degree than the allocations).
>=20
> https://lore.kernel.org/all/20220405135758.774016-8-catalin.marinas@arm.c=
om/
> and below that point.
>=20
> >=20
> > There is nothing iio specific about this value, is there? Then
> > consequently it doesn't need to be defined in an iio header, but
> > somewhere generic. Or even one step further: Why isn't there a macro
> > __align_for_dma that can be used directly to annotate the relevant
> > member in a struct? =20
>=20
> There is, but it's not currently available on all architectures.
>=20
> ARCH_DMA_MINALIGN
>=20
> Catalin's series proposed making it generally available:
> https://lore.kernel.org/all/20220405135758.774016-2-catalin.marinas@arm.c=
om/
>=20
> but suggestion for now was to go with ARCH_KMALLOC_MINALIGN
>=20
> https://lore.kernel.org/linux-iio/Yl6jB5DOUy+Yqyzl@arm.com/
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> >=20
> > Best regards
> > Uwe
> >  =20
>=20

