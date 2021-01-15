Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703692F7D6A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jan 2021 14:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbhAON56 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jan 2021 08:57:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2358 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbhAON55 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2021 08:57:57 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DHN1V0qjwz67WPc;
        Fri, 15 Jan 2021 21:53:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 15 Jan 2021 14:57:16 +0100
Received: from localhost (10.47.77.110) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 15 Jan
 2021 13:57:15 +0000
Date:   Fri, 15 Jan 2021 13:56:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stephan Gerhold <stephan@gerhold.net>
CC:     Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: accel: bma255: Fix bmc150/bmi055
 compatible
Message-ID: <20210115135635.0000034b@Huawei.com>
In-Reply-To: <YAFUVuq6upzuH0VF@gerhold.net>
References: <20201202083551.7753-1-stephan@gerhold.net>
        <20201209181739.GA708144@robh.at.kernel.org>
        <20201213132514.00d7ffff@archlinux>
        <20210114205937.11e650d0@archlinux>
        <YAFUVuq6upzuH0VF@gerhold.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.77.110]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Jan 2021 09:37:42 +0100
Stephan Gerhold <stephan@gerhold.net> wrote:

> On Thu, Jan 14, 2021 at 08:59:37PM +0000, Jonathan Cameron wrote:
> > On Sun, 13 Dec 2020 13:25:14 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Wed, 9 Dec 2020 12:17:39 -0600
> > > Rob Herring <robh@kernel.org> wrote:
> > >   
> > > > On Wed, 02 Dec 2020 09:35:51 +0100, Stephan Gerhold wrote:    
> > > > > The bmc150-accel-i2c.c driver has an "_accel" suffix for the
> > > > > compatibles of BMC150 and BMI055. This is necessary because BMC150
> > > > > contains both accelerometer (bosch,bmc150_accel) and magnetometer
> > > > > (bosch,bmc150_magn) and therefore "bosch,bmc150" would be ambiguous.
> > > > > 
> > > > > However, the binding documentation suggests using "bosch,bmc150".
> > > > > Add the "_accel" suffix for BMC150 and BMI055 so the binding docs
> > > > > match what is expected by the driver.
> > > > > 
> > > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > > Fixes: 496a39526fce8 ("iio: accel: bmc150-accel: Add DT bindings")
> > > > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >       
> > > > 
> > > > Reviewed-by: Rob Herring <robh@kernel.org>    
> > > Applied to the fixes-togreg branch of iio.git which is now based on stuff
> > > queued up for the merge window. I'll send a pull not long after rc1.
> > >   
> > 
> > Not sure why, but the Fixes tag above is invalid. 
> >   
> 
> I think we can call this a "race condition" :)
> 
> I sent the patch on Dec 02 and you rebased the patch on Dec 03 for
> "iio-for-5.11b-take2" (because some sign offs were missing there).
> My patch simply refers to the old commit hash.
> 
> Stephan

That would do it! :)

I suspected as much but was being lazy so didn't bother looking :)

Jonathan
