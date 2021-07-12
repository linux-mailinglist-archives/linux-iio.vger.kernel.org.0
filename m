Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE18D3C5E58
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhGLObN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 10:31:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3389 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhGLObM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 10:31:12 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GNm3D6LL8z6BBQd;
        Mon, 12 Jul 2021 22:14:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 16:28:21 +0200
Received: from localhost (10.47.25.8) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 12 Jul
 2021 15:28:20 +0100
Date:   Mon, 12 Jul 2021 15:28:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Maxime Ripard <maxime@cerno.tech>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>, "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
Message-ID: <20210712152802.00003de4@Huawei.com>
In-Reply-To: <20210712141613.66hw4glnkqlw3n4d@gilmour>
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
        <20210712130444.bois24oukqmxpg27@gilmour>
        <20210712145639.00004604@Huawei.com>
        <20210712141613.66hw4glnkqlw3n4d@gilmour>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.8]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Jul 2021 16:16:13 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

> On Mon, Jul 12, 2021 at 02:56:39PM +0100, Jonathan Cameron wrote:
> > On Mon, 12 Jul 2021 15:04:44 +0200
> > Maxime Ripard <maxime@cerno.tech> wrote:
> >   
> > > Hi,
> > > 
> > > On Mon, Apr 12, 2021 at 02:23:31PM +0200, Linus Walleij wrote:  
> > > > This adjusts the ST Sensor bindings with the more fine-grained
> > > > syntax checks that were proposed late in the last kernel cycle
> > > > and colliding with parallel work.
> > > > 
> > > > Cc: devicetree@vger.kernel.org
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>    
> > > 
> > > I'm not really sure of how I supposed to fix this, but this creates an
> > > issue on the Pinephone
> > > (arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts) that has a
> > > LIS3MDL with only the DRDY pin routed and thus only has a single
> > > interrupt in the DT.
> > > 
> > > One of the if condition in that patch enforces that there's two
> > > interrupts for the LIS3MDL, but it's not really clear to me why after
> > > looking at the datasheet?  
> > 
> > It shouldn't be enforcing that 2 are specified rather that 2 'might' be
> > specified.  
> 
> But then you don't need that condition at all, it's already what is
> being enforced by the main schema here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/iio/st,st-sensors.yaml#n90

Good point.  I'd argue that we should drop this entry infavour or explicit match
on one of the others, but perhaps that gives an error?

> 
> > maxItems is set, but not minItems.   
> 
> Yeah, and if one is missing the other is added with the value of the
> other.

Gah.  Indeed, not good and needs fixing.

> 
> What the schema enforces currently is that (for the common part) the
> interrupt list can be between 1 and 2 and then for a specific set of
> compatibles (including the LIS3MDL) it has to be exactly 2.
> 
> Even the common part looks weird though, it says that it can handle up
> to three interrupts but has maxItems: 2?

That is indeed odd and I expect an omission on the assumption that the minItems
from the general one would not be overridden. 

@Linus?

> 
> > Driver wise, at the moment it looks like we only handle one interrupt.
> > So to handle selection when two are possible and either 1 or 2 might
> > be wired up we need to add interrupt names (with default order so we
> > don't break anything before adding them to the binding).
> > 
> > Would that work for this device?  
> 
> I don't know the LIS3MDL to comment whether it makes sense or not, but
> it looks like it's a single sensor so I'm not really sure why we'd need
> more than one interrupt

Looks like they are hard wired to specific functions.  Data ready does
what it says on the tin, but the INT line is used for threshold events.
Depending on the application a particular device is being used for, it
might well make sense to only wire either one of them.

> 
> Maxime
> 

