Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD02DCF15
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443281AbfJRTKX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 15:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443280AbfJRTKX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 15:10:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 137B62070B;
        Fri, 18 Oct 2019 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571425822;
        bh=SV8Vv5FvDe2SpzdgeslYgVDRdktvHpA3+HZ2ioDyY+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=swhyE8aXu2rhXWjbH/OHfscJsQ35cA/seBvUbMpUNbtKhE6uEg+ooPdTHIn/fqOm9
         akfk2pq6oEpcUrKZ2+HIEo42KVYyLI9KfAOgia7b9WcPt74QZDAq6gEldz8FbJVEp+
         TRLMggQbp7cGYYbX3I+sQSHRXpapijDGul+f6OMc=
Date:   Fri, 18 Oct 2019 20:10:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "hslester96@gmail.com" <hslester96@gmail.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad9834: add a check for devm_clk_get
Message-ID: <20191018201016.0a7fde4f@archlinux>
In-Reply-To: <3acc69aceb04667ba34200f54c59b3d160ab2f5d.camel@analog.com>
References: <20191016142540.26450-1-hslester96@gmail.com>
        <3acc69aceb04667ba34200f54c59b3d160ab2f5d.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Oct 2019 12:56:33 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2019-10-16 at 22:25 +0800, Chuhong Yuan wrote:
> > ad9834_probe misses a check for devm_clk_get and may cause problems.
> > Add a check like what ad9832 does to fix it.
> >   
> 
> This could also use a Fixes tag, but not a big deal.
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

As a general point though, the fact that a devm error handler
actually has things to do suggests this code doesn't pass
the obviously correct test.

Nothing to do with this patch mind you!

Jonathan

> 
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/staging/iio/frequency/ad9834.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/staging/iio/frequency/ad9834.c
> > b/drivers/staging/iio/frequency/ad9834.c
> > index 038d6732c3fd..23026978a5a5 100644
> > --- a/drivers/staging/iio/frequency/ad9834.c
> > +++ b/drivers/staging/iio/frequency/ad9834.c
> > @@ -417,6 +417,10 @@ static int ad9834_probe(struct spi_device *spi)
> >  	st = iio_priv(indio_dev);
> >  	mutex_init(&st->lock);
> >  	st->mclk = devm_clk_get(&spi->dev, NULL);
> > +	if (IS_ERR(st->mclk)) {
> > +		ret = PTR_ERR(st->mclk);
> > +		goto error_disable_reg;
> > +	}
> >  
> >  	ret = clk_prepare_enable(st->mclk);
> >  	if (ret) {  

