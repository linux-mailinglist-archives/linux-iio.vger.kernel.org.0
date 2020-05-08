Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BBA1CAB6E
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgEHMnc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 08:43:32 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727105AbgEHMnb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 08:43:31 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6032C5A5AE26CA40D204;
        Fri,  8 May 2020 13:43:30 +0100 (IST)
Received: from localhost (10.47.95.97) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 8 May 2020
 13:43:29 +0100
Date:   Fri, 8 May 2020 13:43:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] staging: iio: ad5933: rework probe to use devm_
 function variants
Message-ID: <20200508134307.0000233a@Huawei.com>
In-Reply-To: <20200507095016.GC9365@kadam>
References: <20200428093128.60747-1-alexandru.ardelean@analog.com>
        <20200502192542.63cc25a2@archlinux>
        <20200507095016.GC9365@kadam>
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

On Thu, 7 May 2020 12:50:16 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Sat, May 02, 2020 at 07:25:42PM +0100, Jonathan Cameron wrote:
> > On Tue, 28 Apr 2020 12:31:28 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:  
> > > +static void ad5933_cleanup(void *data)
> > > +{
> > > +	struct ad5933_state *st = data;
> > > +
> > > +	clk_disable_unprepare(st->mclk);
> > > +	regulator_disable(st->reg);  
> > 
> > Please do two separate callbacks so that these can be handled
> > in the correct places.  I.e. you do something then immediately
> > register the handler to undo it.
> > 
> > Currently you can end up disabling a clock you haven't enabled
> > (which I am fairly sure will give you an error message).  
> 
> Yeah.  It does.
> 
> It feels like we should just make a devm_ version of regulator_enable().
> Or potentially this is more complicated than it seems, but in that case
> probably adding devm_add_action_or_reset() is more complicated than it
> seems as well.
> 
> regards,
> dan carpenter

It has been a while since that was last proposed.   At the time the
counter argument was that you should almost always be doing some form
of PM and hence the regulator shouldn't have the same lifetime as the
driver.   Reality is that a lot of simple drivers either don't do
PM or have elected to not turn the regulator off so as to retain state
etc.

Mark what do you think?

Jonathan

