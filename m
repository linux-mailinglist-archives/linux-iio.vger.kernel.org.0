Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999E13A4871
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFKSOJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 14:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhFKSOJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 14:14:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF157613D2;
        Fri, 11 Jun 2021 18:12:09 +0000 (UTC)
Date:   Fri, 11 Jun 2021 19:14:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/7] staging:iio: Header cleanup
Message-ID: <20210611191403.14d676a9@jic23-huawei>
In-Reply-To: <CAHp75VfN93-B-UYCEMfxym-_XS_Edr+G07P6xO+83+gkMeC1LQ@mail.gmail.com>
References: <20210611152614.109361-1-jic23@kernel.org>
        <CAHp75VfN93-B-UYCEMfxym-_XS_Edr+G07P6xO+83+gkMeC1LQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Jun 2021 20:45:03 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 11, 2021 at 6:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > 0-day recently started giving some reports from the include-what-you-use
> > tool (needs LLVM builds).
> >
> > I was curious so decided to give it a spin.  It produces a wealth of
> > information, but the suggestions require a high degree of interpretation
> > and some choices are down to personal taste.
> >
> > This set covers resulting changes that I think make sense for remaining
> > IIO drivers in staging (which I just noticed are all Analog devices ones :)  
> 
> In general it's a good idea, but the tool doesn't know the project specifics.
> I believe that half of what you have done is simply wrong. That is, we
> have a lot of drivers that include kernel.h which is in its turn a
> rabbit hole of all possible headers and (circular) dependencies. So,
> for this and the other series, please double check that removed
> headers are not removed due to kernel.h (I believe this is the case
> for almost all if not all entries of slab.h, for example).

The tool seems to go rather the other way and suggest including things
that are 'obviously' included via another header that we need.

The reason for kernel.h includes when being added is almost always ARRAY_SIZE
or container_of as you identified.

The drivers where I'm removing slab.h don't actually make any direct
allocate or free calls, they are all wrapped up in various IIO core function
(devm_iio_device_alloc etc.)

Jonathan


> 
> The other half seems correct. But due to the above I can't give any
> tag on these...
> 

