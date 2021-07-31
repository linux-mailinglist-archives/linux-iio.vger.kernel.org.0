Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2CD3DC780
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 19:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGaRpV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 13:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhGaRpV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 13:45:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E3DC60EE6;
        Sat, 31 Jul 2021 17:45:11 +0000 (UTC)
Date:   Sat, 31 Jul 2021 18:47:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Liam Beguin <liambeguin@gmail.com>, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 05/13] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Message-ID: <20210731184750.669af583@jic23-huawei>
In-Reply-To: <18f749be-284f-3342-a6d2-b42aa39fc13a@axentia.se>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
        <20210721030613.3105327-6-liambeguin@gmail.com>
        <c9d77dc0-7f4c-0df0-cce1-8cb30074e115@axentia.se>
        <CD4CE5OQT5TJ.2BFPBRYK7FCOW@shaak>
        <18f749be-284f-3342-a6d2-b42aa39fc13a@axentia.se>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Jul 2021 09:19:58 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2021-07-28 02:21, Liam Beguin wrote:
> > On Fri Jul 23, 2021 at 5:16 PM EDT, Peter Rosin wrote:  
> >> On 2021-07-21 05:06, Liam Beguin wrote:  
> >>> From: Liam Beguin <lvb@xiphos.com>
> >>>
> >>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> >>> Add support for these to allow using the iio-rescaler with them.
> >>>
> >>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> >>> ---
> >>>  drivers/iio/afe/iio-rescale.c | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> >>> index d0669fd8eac5..2b73047365cc 100644
> >>> --- a/drivers/iio/afe/iio-rescale.c
> >>> +++ b/drivers/iio/afe/iio-rescale.c
> >>> @@ -41,6 +41,20 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> >>>  		do_div(tmp, 1000000000LL);
> >>>  		*val = tmp;
> >>>  		return scale_type;
> >>> +	case IIO_VAL_INT_PLUS_NANO:
> >>> +		tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
> >>> +		tmp = div_s64(tmp, rescale->denominator);
> >>> +
> >>> +		*val = div_s64(tmp, 1000000000LL);
> >>> +		*val2 = tmp - *val * 1000000000LL;
> >>> +		return scale_type;  
> > 
> > Hi Peter,
> >   
> >>
> >> Hi!
> >>
> >> My objection from v5 still stands. Did you forget or did you simply send
> >> the
> >> wrong patch?  
> > 
> > Apologies, again I didn't mean to make it seem like I ignored your comments.
> > I tried your suggestion, but had issues when *val2 would overflow into
> > the integer part.  
> 
> Not saying anything about it not working does indeed make it seem like you
> ignored it :-)  Or did I just miss where you said this? Anyway, no problem,
> it can be a mess dealing with a string of commits when there are numerous
> things to take care of between each iteration. And it's very easy to burn
> out and just back away. Please don't do that!

Just to add here, I'm really appreciating the two of you figuring this out
between you and looking forward to getting the resulting improvements (particularly
the tests!) in place.

Thanks,

Jonathan
