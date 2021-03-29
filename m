Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E10B34CDFB
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 12:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhC2K3U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 06:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231784AbhC2K3R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 06:29:17 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2BC261584;
        Mon, 29 Mar 2021 10:29:13 +0000 (UTC)
Date:   Mon, 29 Mar 2021 11:29:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: Rudimentary typo fix
Message-ID: <20210329112919.4e690e40@jic23-huawei>
In-Reply-To: <cec8e5bf-b7be-041e-e0ea-50a41f55d79f@infradead.org>
References: <20210323012215.451075-1-unixbhaskar@gmail.com>
        <cec8e5bf-b7be-041e-e0ea-50a41f55d79f@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Mar 2021 20:02:22 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 3/22/21 6:22 PM, Bhaskar Chowdhury wrote:
> > 
> > s/concurent/concurrent/
> > 
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>  
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied to the togreg branch of iio.git.
That will first be pushed out as testing for the autobuilders
such as 0-day to work their magic, and only later get pushed
out as a tree that I try to avoid rebasing once public.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/dac/ad5766.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> > index ef1618ea6a20..79837a4b3a41 100644
> > --- a/drivers/iio/dac/ad5766.c
> > +++ b/drivers/iio/dac/ad5766.c
> > @@ -89,7 +89,7 @@ static const char * const ad5766_dither_scales[] = {
> >  /**
> >   * struct ad5766_state - driver instance specific data
> >   * @spi:		SPI device
> > - * @lock:		Lock used to restrict concurent access to SPI device
> > + * @lock:		Lock used to restrict concurrent access to SPI device
> >   * @chip_info:		Chip model specific constants
> >   * @gpio_reset:		Reset GPIO, used to reset the device
> >   * @crt_range:		Current selected output range
> > --  
> 
> 

