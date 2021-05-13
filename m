Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34BE37FB10
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 17:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhEMPws (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 11:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232251AbhEMPwk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 11:52:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B569961408;
        Thu, 13 May 2021 15:51:28 +0000 (UTC)
Date:   Thu, 13 May 2021 16:52:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Lucas Stankus <lucas.p.stankus@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] staging: iio: cdc: ad7746: avoid overwrite of
 num_channels
Message-ID: <20210513165236.586b8beb@jic23-huawei>
In-Reply-To: <CA+U=DsptfNDut3984MJkKckgWBhNd_0p17RfpidEXwYhMRfxtg@mail.gmail.com>
References: <cover.1620766020.git.lucas.p.stankus@gmail.com>
        <09e65d3a235febfc4c3ee172b573ba8c9cde94b8.1620766020.git.lucas.p.stankus@gmail.com>
        <CA+U=DsptfNDut3984MJkKckgWBhNd_0p17RfpidEXwYhMRfxtg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 20:20:02 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Tue, May 11, 2021 at 11:55 PM Lucas Stankus
> <lucas.p.stankus@gmail.com> wrote:
> >
> > AD7745 devices don't have the CIN2 pins and therefore can't handle related
> > channels. Forcing the number of AD7746 channels may lead to enabling more
> > channels than what the hardware actually supports.
> > Avoid num_channels being overwritten after first assignment.
> >
> > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> > ---
> >  drivers/staging/iio/cdc/ad7746.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> > index e03d010b2f4c..9e0da43b2871 100644
> > --- a/drivers/staging/iio/cdc/ad7746.c
> > +++ b/drivers/staging/iio/cdc/ad7746.c
> > @@ -693,7 +693,6 @@ static int ad7746_probe(struct i2c_client *client,
> >                 indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
> >         else
> >                 indio_dev->num_channels =  ARRAY_SIZE(ad7746_channels) - 2;
> > -       indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);  
> 
> ohh; good catch
> 
> this falls into the category of a fix, so a Fixes tag is required;
> this looks so old, that i did not bother tracking it before
> 83e416f458d53  [which is 2011]
> 
> so, maybe something like:
> 
> Fixes: 83e416f458d53 ("staging: iio: adc: Replace, rewrite ad7745 from
> scratch.")

ouch.  Given I was queuing up some fixes I've added this one to the fixes-togreg
branch of iio.git and marked it for stable.

So drop this one from your v2 series with the changes requested in patch 1.

Thanks,

Jonathan

> 
> >         indio_dev->modes = INDIO_DIRECT_MODE;
> >
> >         if (pdata) {
> > --
> > 2.31.1
> >  

