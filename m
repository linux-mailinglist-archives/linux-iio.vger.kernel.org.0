Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC57836ECCB
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 16:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhD2Oyl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 10:54:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2953 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhD2Oyl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Apr 2021 10:54:41 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FWJJs2Sv7z72fBb;
        Thu, 29 Apr 2021 22:48:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 16:53:52 +0200
Received: from localhost (10.52.122.22) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 29 Apr
 2021 15:53:51 +0100
Date:   Thu, 29 Apr 2021 15:52:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean Nyekjaer <sean@geanix.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <Nuno.Sa@analog.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] iio: accel: fxls8962af: add hw buffered
 sampling
Message-ID: <20210429155217.00006a34@Huawei.com>
In-Reply-To: <f679124a-4efc-c98d-49ec-dd294fe44b5a@geanix.com>
References: <20210428082203.3587022-1-sean@geanix.com>
        <20210428082203.3587022-3-sean@geanix.com>
        <20210428173238.0000540d@Huawei.com>
        <f679124a-4efc-c98d-49ec-dd294fe44b5a@geanix.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.22]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Apr 2021 09:40:00 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 28/04/2021 18.32, Jonathan Cameron wrote:
> >> When buffered sampling is enabled, the accelerometer will dump data into
> >> the internal fifo and interrupt at watermark. Then the driver flushes
> >> all data to the iio buffer.
> >> As the accelerometer doesn't have internal timestamps, they are aproximated
> >> between to interrupts.  
> > two?
> >
> > This tends to be a noisy approach, so people often try to apply a filter.
> > However, no need to do that for an initial version.
> >
> > There are some things in here referring to enabling triggered modes, but I'm
> > not seeing code to actually do so.  The fun question when dealing with fifos
> > and triggered mode is what the interface is to switch between the two.
> > One option I think we've used before is to just have 'no trigger' match
> > up to fifo mode and if a trigger is set, don't use the fifo.
> >  
> Thanks Jonathan.
> 
> Fixed the above text to:
> As the accelerometer doesn't have internal timestamps,
> they are approximated between the current and last interrupt.
Nice.

> 
> I don't know the correct term here, the accelerometer via the watermark, 
> is doing interrupts.
> Is that called no-trigger / trigger ?

Triggers are one per scan (Set of samples take at approximately the same time)
So anything involving a fifo is without trigger (we don't expose anything because
it is of no use for doing synchronous capture across multiple devices).

One day I'll add a terminology section to the docs!

J

> 
> /Sean

