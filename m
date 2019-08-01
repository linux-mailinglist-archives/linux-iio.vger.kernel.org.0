Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C767DBB2
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 14:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfHAMlr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 08:41:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730319AbfHAMlr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Aug 2019 08:41:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BFE41B0E29E4A17A32B1;
        Thu,  1 Aug 2019 20:41:35 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 1 Aug 2019
 20:41:34 +0800
Date:   Thu, 1 Aug 2019 13:41:21 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH 3/3][V4] dt-bindings: iio: imu: add bindings for
 ADIS16460
Message-ID: <20190801134121.00003097@huawei.com>
In-Reply-To: <CAL_JsqLXTnrtCr4hVVc9HrOkkvwGWk02EibdutfUBm4JDnJO5Q@mail.gmail.com>
References: <20190723073641.27801-1-alexandru.ardelean@analog.com>
        <20190723073641.27801-4-alexandru.ardelean@analog.com>
        <20190727195623.42c8b4f3@archlinux>
        <CAL_JsqLXTnrtCr4hVVc9HrOkkvwGWk02EibdutfUBm4JDnJO5Q@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jul 2019 17:24:40 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Sat, Jul 27, 2019 at 12:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 23 Jul 2019 10:36:40 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >  
> > > This change adds device-tree bindings for the ADIS16460.
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> >
> > Really trivial, but convention (as driven by what git am -s does if nothing
> > else, is to add extra tags in chronological order.  So Rob would be after
> > you.  I tweaked it which I don't always remember to do.  
> 
> I'd argue it is in chronological order as the submitter added my tag
> and then sent it out. If you applied it and added my tag, then it
> would be after (but before yours).

Bike shedding to follow...

Possibly but given you gave the Reviewed-by for v2, and it hasn't changed
is Alex's the same Signed-off-by as seen on V2, or a new one reflecting the
addition of your Reviewed-by? 

:)


> 
> > It's not consistent across the kernel but I'll fight for my little corner
> > to be :)  
> 
> More consistency would be nice then there's less tribal knowledge
> about maintainers for submitters to learn.

Agreed.

Jonathan

> 
> Rob


