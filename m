Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14D437FC2C
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhEMRO7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhEMRO7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:14:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C5B61408;
        Thu, 13 May 2021 17:13:47 +0000 (UTC)
Date:   Thu, 13 May 2021 18:14:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Junho <djunho@gmail.com>
Subject: Re: [PATCH 0/2] IIO: Alignment fixes part 1 - sizes too small as
 well.
Message-ID: <20210513181456.740e8309@jic23-huawei>
In-Reply-To: <CAHp75VefwPWqZfqCT0HmPgoer6_dvnR+VJ0mnOSvF-_tHqq4GA@mail.gmail.com>
References: <20210501165314.511954-1-jic23@kernel.org>
        <CAHp75VefwPWqZfqCT0HmPgoer6_dvnR+VJ0mnOSvF-_tHqq4GA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 1 May 2021 22:14:16 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, May 1, 2021 at 7:55 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > I finally got around to do a manual audit of all the calls to
> > iio_push_to_buffers_with_timestamp() which has the somewhat odd requirements
> > of:
> > 1. 8 byte alignment of the provided buffer.
> > 2. space for an 8 byte naturally aligned timestamp to be inserted at the
> >    end.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

Applied to the fixes-togreg branch of iio.git and marked for stable.

For these two I decided to go the quick way as they are broken even on systems
where the alignment issue doesn't matter.

Thanks,

Jonathan

> 
> > As discussed previous in
> > https://lore.kernel.org/linux-iio/20200920112742.170751-1-jic23@kernel.org/
> > it is not easy to fix the alignment issue without requiring a bounce buffer
> > (see part 4 of the alignment fixes for a proposal for that where it is
> > absolutely necessary).
> >
> > In these cases the buffer is neither big enough, nor correctly aligned
> > so fix both issues in one go.
> >
> > Cc: Daniel Junho <djunho@gmail.com>
> >
> > Jonathan Cameron (2):
> >   iio: adc: ad7768-1: Fix too small buffer passed to
> >     iio_push_to_buffers_with_timestamp()
> >   iio: adc: ad7923: Fix undersized rx buffer.
> >
> >  drivers/iio/adc/ad7768-1.c | 8 ++++++--
> >  drivers/iio/adc/ad7923.c   | 4 +++-
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > --
> > 2.31.1
> >  
> 
> 

