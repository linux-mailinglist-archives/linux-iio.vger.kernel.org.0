Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3195189CA
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiECQ2B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 3 May 2022 12:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239526AbiECQ2A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 12:28:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949583CFFD
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:24:26 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt4w01dPMz67bVT;
        Wed,  4 May 2022 00:21:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 18:24:23 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 17:24:22 +0100
Date:   Tue, 3 May 2022 17:24:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
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
        =?ISO-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        "Mugilraj Dhavachelvan" <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
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
Message-ID: <20220503172421.0000615c@Huawei.com>
In-Reply-To: <20220503142725.h6pcf2socuxgteix@pengutronix.de>
References: <20220503085935.1533814-1-jic23@kernel.org>
        <20220503085935.1533814-2-jic23@kernel.org>
        <20220503142725.h6pcf2socuxgteix@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 May 2022 16:27:25 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> On Tue, May 03, 2022 at 09:58:04AM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Discussion of the series:
> > https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas@arm.com/
> > mm, arm64: Reduce ARCH_KMALLOC_MINALIGN brought to my attention that
> > our current IIO usage of L1CACHE_ALIGN is insufficient as their are Arm
> > platforms out their with non coherent DMA and larger cache lines at
> > at higher levels of their cache hierarchy.
> > 
> > Note this patch will greatly reduce the padding on some architectures
> > that have smaller requirements for DMA safe buffers.
> > 
> > The history of changing values of ARCH_KMALLOC_MINALIGN via
> > ARCH_DMA_MINALIGN on arm64 is rather complex. I'm not tagging this
> > as fixing a particular patch from that route as it's not clear what to tag.
> > 
> > Most recently a change to bring them back inline was reverted because
> > of some Qualcomm Kryo cores with an L2 cache with 128-byte lines
> > sitting above the point of coherency.
> > 
> > c1132702c71f Revert "arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_CACHE_BYTES)"
> > That reverts:
> > 65688d2a05de arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_CACHE_BYTES) which
> > refers to the change originally being motivated by Thunder x1 performance
> > rather than correctness.
> > 
> > Fixes: 6f7c8ee585e9d ("staging:iio: Add ability to allocate private data space to iio_allocate_device")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/linux/iio/iio.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index faf00f2c0be6..30937f8f9424 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -9,6 +9,7 @@
> >  
> >  #include <linux/device.h>
> >  #include <linux/cdev.h>
> > +#include <linux/slab.h>
> >  #include <linux/iio/types.h>
> >  #include <linux/of.h>
> >  /* IIO TODO LIST */
> > @@ -657,8 +658,13 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
> >  	return dev_get_drvdata(&indio_dev->dev);
> >  }
> >  
> > -/* Can we make this smaller? */
> > -#define IIO_ALIGN L1_CACHE_BYTES
> > +/*
> > + * Used to ensure the iio_priv() structure is aligned to allow that structure
> > + * to in turn include IIO_ALIGN'd elements such as buffers which must not share
> > + * cachelines with the rest of the structure, thus making them safe for use with
> > + * non-coherent DMA.
> > + */
> > +#define IIO_ALIGN ARCH_KMALLOC_MINALIGN  
> 
> Given the purpose of IIO_ALIGN is to define the alignment for DMA'able
> memory, I wonder why it's called "IIO_ALIGN" and not for example
> "DMA_MINALIGN".

Much like crypto I want a single place that provides the IIO requirements
for this.  Could rename it IIO_DMA_MINALIGN I guess.  The reason behind
that is to allow for a switch on mass if a new approach is accepted
along the lines of what Catalin proposed.  The discussions around
CRYPTO made it clear that there are sometimes additional requirements
from a subsystem beyond simply that of DMA (IIO has a similar issue
to crypto that mean it's not simple to shift the alignment requirements
at runtime because the compiler is getting told things are aligned to
a higher degree than the allocations).

https://lore.kernel.org/all/20220405135758.774016-8-catalin.marinas@arm.com/
and below that point.

> 
> There is nothing iio specific about this value, is there? Then
> consequently it doesn't need to be defined in an iio header, but
> somewhere generic. Or even one step further: Why isn't there a macro
> __align_for_dma that can be used directly to annotate the relevant
> member in a struct?

There is, but it's not currently available on all architectures.

ARCH_DMA_MINALIGN

Catalin's series proposed making it generally available:
https://lore.kernel.org/all/20220405135758.774016-2-catalin.marinas@arm.com/

but suggestion for now was to go with ARCH_KMALLOC_MINALIGN

https://lore.kernel.org/linux-iio/Yl6jB5DOUy+Yqyzl@arm.com/

Thanks,

Jonathan


> 
> Best regards
> Uwe
> 

