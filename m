Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42BA3A1BCC
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 19:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFIRcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 13:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhFIRcO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 13:32:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E01613CA;
        Wed,  9 Jun 2021 17:30:17 +0000 (UTC)
Date:   Wed, 9 Jun 2021 18:32:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     <linux-iio@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 0/4] iio: Drop use of %hhx and %hx format strings
Message-ID: <20210609183211.3427f59b@jic23-huawei>
In-Reply-To: <20210609140934.00002f44@Huawei.com>
References: <20210603180612.3635250-1-jic23@kernel.org>
        <20210609140934.00002f44@Huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Jun 2021 14:09:34 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> Hi All,
> 
> Not quite sure how I managed to cc Nathan on the patches, but not the
> cover letter.  Anyhow +Cc Nathan.
> 
> @Nathan. I dropped the tags you gave to v1 as described below, but
> it's not a huge change. Very much appreciated if you could take a quick look.

Thanks for the quick turn around Nathan!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at.

Note I won't push this out as non rebasing for a few days so
still time to take additional reviews into account etc.

Jonathan

> 
> Input from others also appreciated!
> 
> Thanks,
> 
> Jonathan
> 
> 
> On Thu,  3 Jun 2021 19:06:08 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
> > 
> > Note that patch from Arnd is now also part of this series, due to the
> > length specifier related issue Joe raised.
> > 
> > I have chosen to go with 0x%02x rather than %#04x as I find it more readable.
> > 
> > V2:
> > Use 0x%02x (Joe Perches)
> > Include Arnd's original patch, modified for the above.
> > 
> > Arnd Bergmann (1):
> >   iio: si1133: fix format string warnings
> > 
> > Jonathan Cameron (3):
> >   iio: light: si1133: Drop remaining uses of %hhx format string.
> >   iio: imu: inv_mpu6050: Drop use of %hhx format string.
> >   iio: light: si1145: Drop use of %hhx format specifier.
> > 
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  5 ++---
> >  drivers/iio/light/si1133.c                 | 18 +++++++++---------
> >  drivers/iio/light/si1145.c                 | 10 +++++-----
> >  3 files changed, 16 insertions(+), 17 deletions(-)
> >   
> 

