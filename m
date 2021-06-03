Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59A439A9C6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFCSIh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 14:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhFCSIf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 14:08:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ACB461042;
        Thu,  3 Jun 2021 18:06:48 +0000 (UTC)
Date:   Thu, 3 Jun 2021 19:08:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [RESEND PATCH 0/4] iio: Drop use of %hhx and %hx format strings
Message-ID: <20210603190831.5a06fa9a@jic23-huawei>
In-Reply-To: <20210522192031.26ecba8a@jic23-huawei>
References: <20210517125554.1463156-1-jic23@kernel.org>
        <20210522192031.26ecba8a@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 May 2021 19:20:31 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 17 May 2021 13:55:50 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Resent because for some reason this didn't reach the mailing list
> > (I'm not sure it reached anywhere at all!)
> > 
> > A wrong use of one of these in
> > https://lore.kernel.org/linux-iio/20210514135927.2926482-1-arnd@kernel.org/
> > included a reference from Nathan to a patch discouraging the use of
> > these strings in general:
> > https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
> > 
> > I did a quick grep and established we only have a few instances of these in
> > IIO anyway, so in the interests of avoiding those existing cases getting
> > cut and paste into new drivers, let's just clear them out now.  
> 
> Series applied to the togreg branch of iio.git and pushed out as testing to
> let 0-day poke at it before I push it out for linux-next.

And I dropped 3 of these, because as Joe Perches pointed out
%#02x is a very odd specifier to use as the length includes the 0x prefix
and thus might as well not be there at all.
Intention was almost certainly either
%#04x or 0x%02x  

I prefer the second one so have rerolled the first 3 of these to take that
approach. The 4th is unaffected so I have left it applied.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Jonathan Cameron (4):
> >   iio: imu: inv_mpu6050: Drop use of %hhx format string.
> >   iio: light: si1133: Drop remaining uses of %hhx format string.
> >   iio: light: si1145: Drop use of %hhx format specifier.
> >   iio: chemical: sgp30: Drop use of %hx in format string.
> > 
> >  drivers/iio/chemical/sgp30.c               |  2 +-
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  5 ++---
> >  drivers/iio/light/si1133.c                 | 14 +++++++-------
> >  drivers/iio/light/si1145.c                 | 10 +++++-----
> >  4 files changed, 15 insertions(+), 16 deletions(-)
> >   
> 

