Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CA4378FA4
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhEJNwO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:52:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3044 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbhEJNmN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:42:13 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff29S0Wr2z6lpj7;
        Mon, 10 May 2021 21:35:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 15:41:04 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 14:41:03 +0100
Date:   Mon, 10 May 2021 14:39:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean Nyekjaer <sean@geanix.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 5/6] iio: accel: fxls8962af: add hw buffered sampling
Message-ID: <20210510143921.00001774@Huawei.com>
In-Reply-To: <f50d0b0f-f00d-35c9-9cf5-2a9e9ffaa8ca@geanix.com>
References: <20210506070940.312959-1-sean@geanix.com>
        <20210506070940.312959-5-sean@geanix.com>
        <20210508173947.47d18328@jic23-huawei>
        <f50d0b0f-f00d-35c9-9cf5-2a9e9ffaa8ca@geanix.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 May 2021 09:54:05 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 08/05/2021 18.39, Jonathan Cameron wrote:
> > On Thu,  6 May 2021 09:09:39 +0200
> > Sean Nyekjaer <sean@geanix.com> wrote:
> >   
> >> When buffered sampling is enabled, the accelerometer will dump data into
> >> the internal fifo and interrupt at watermark. Then the driver flushes
> >> all data to the iio buffer.
> >> As the accelerometer doesn't have internal timestamps, they are
> >> approximated between the current and last interrupt.
> >>
> >> Signed-off-by: Sean Nyekjaer <sean@geanix.com>  
> > 
> > Hi Sean,
> > 
> > Couple of things I adjusted whilst applying this.
> > 1) trigger.h isn't used as no triggers are involved currently in this driver so
> >    I dropped it.
> > 2) kfifo allocation etc has changed in the IIO core whilst this driver was in
> >    development. Now we have devm_iio_kfifo_setup() which does everything your
> >    locals _setup() function does. 
> > 
> > I've made changes for both of the above whilst applying so please take a look
> > at the result which I'll shortly push out as testing for the autobuilders to
> > poke at as well.
> > 
> > Other than that I tweaked a bit of whilespace in the id tables in patch 1.
> > 
> > Series applied to the togreg branch of iio.git but initially just pushed out as
> > testing to let 0-day work it's magic.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> Hi Jonathan,
> 
> Guess it's okay, but I can't find the patches here:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=togreg
> 
Gah. As happens far too often I forgot to push.  It's now there as testing to
actually let the autobuilders poke a it.


> :-)
> 
> Br,
> /Sean
> 

