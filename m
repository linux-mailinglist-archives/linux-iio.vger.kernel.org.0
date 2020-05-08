Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D530B1CB2D3
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHPaY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 11:30:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbgEHPaY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 11:30:24 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D1289655DC33477CB90C;
        Fri,  8 May 2020 16:30:22 +0100 (IST)
Received: from localhost (10.47.95.97) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 8 May 2020
 16:30:22 +0100
Date:   Fri, 8 May 2020 16:30:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad5933: rework probe to use devm_
 function variants
Message-ID: <20200508163000.000016de@Huawei.com>
In-Reply-To: <20200508125746.GH4820@sirena.org.uk>
References: <20200428093128.60747-1-alexandru.ardelean@analog.com>
        <20200502192542.63cc25a2@archlinux>
        <20200507095016.GC9365@kadam>
        <20200508134307.0000233a@Huawei.com>
        <20200508125746.GH4820@sirena.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.97]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 May 2020 13:57:46 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, May 08, 2020 at 01:43:07PM +0100, Jonathan Cameron wrote:
> > Dan Carpenter <dan.carpenter@oracle.com> wrote:  
> 
> > > It feels like we should just make a devm_ version of regulator_enable().
> > > Or potentially this is more complicated than it seems, but in that case
> > > probably adding devm_add_action_or_reset() is more complicated than it
> > > seems as well.  
> 
> > It has been a while since that was last proposed.   At the time the
> > counter argument was that you should almost always be doing some form
> > of PM and hence the regulator shouldn't have the same lifetime as the
> > driver.   Reality is that a lot of simple drivers either don't do
> > PM or have elected to not turn the regulator off so as to retain state
> > etc.  
> 
> Same issue as before - I fear it's far too error prone in conjunction
> with runtime PM, and if the driver really is just doing an enable and
> disable at probe and remove then that seems fairly trivial anyway.  I
> am constantly finding abuses of things like regulator_get_optional()
> (which we do actually need) in drivers and it's not like I can review
> all the users, I don't have much confidence in this stuff especially
> when practically speaking few regulators ever change state at runtime so
> issues don't manifest so often.
> 

Fair enough.  We'll carry on doing it with devm_add_action_or_reset
which forces us to take a close look at why we always want the lifetime
to match that of the device.

Note the key thing here is we don't have a remove in these drivers.
Everything is managed.  Mixing and matching between managed and unmanaged
causes more subtle race conditions...

Jonathan


