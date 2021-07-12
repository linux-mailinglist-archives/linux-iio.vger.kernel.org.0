Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C668F3C5DD3
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhGLN7t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 09:59:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3388 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbhGLN7s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 09:59:48 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GNlTt1ZMQz6K5qX;
        Mon, 12 Jul 2021 21:48:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 15:56:58 +0200
Received: from localhost (10.47.25.8) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 12 Jul
 2021 14:56:57 +0100
Date:   Mon, 12 Jul 2021 14:56:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Maxime Ripard <maxime@cerno.tech>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>, "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
Message-ID: <20210712145639.00004604@Huawei.com>
In-Reply-To: <20210712130444.bois24oukqmxpg27@gilmour>
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
        <20210712130444.bois24oukqmxpg27@gilmour>
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

On Mon, 12 Jul 2021 15:04:44 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

> Hi,
> 
> On Mon, Apr 12, 2021 at 02:23:31PM +0200, Linus Walleij wrote:
> > This adjusts the ST Sensor bindings with the more fine-grained
> > syntax checks that were proposed late in the last kernel cycle
> > and colliding with parallel work.
> > 
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>  
> 
> I'm not really sure of how I supposed to fix this, but this creates an
> issue on the Pinephone
> (arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts) that has a
> LIS3MDL with only the DRDY pin routed and thus only has a single
> interrupt in the DT.
> 
> One of the if condition in that patch enforces that there's two
> interrupts for the LIS3MDL, but it's not really clear to me why after
> looking at the datasheet?

It shouldn't be enforcing that 2 are specified rather that 2 'might' be
specified.  maxItems is set, but not minItems. 

Driver wise, at the moment it looks like we only handle one interrupt.
So to handle selection when two are possible and either 1 or 2 might
be wired up we need to add interrupt names (with default order so we
don't break anything before adding them to the binding).

Would that work for this device?

Jonathan
 
> 
> Maxime
> 

