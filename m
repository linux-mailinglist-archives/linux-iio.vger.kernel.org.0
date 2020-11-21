Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1F12BC02F
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 16:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgKUPQN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 10:16:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgKUPQN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:16:13 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D953922226;
        Sat, 21 Nov 2020 15:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605971772;
        bh=J0NAtmLnEUd+mVUZrTSi31yGZZeF71+5jMMP1hUxojI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hh1N8q8mpi9+5mKubsau4V9mpyEExN/ljKKqy6ooupcTHCFE50N3+wtic4UzWvxLJ
         3L8PQ6JODlhewB2w/qXjB0joxrrnXjzkST6anCHwtGdcCKVbcrRyNIaXSa0T3PD+se
         mCLg0CuJPlokQtM0AhFdFUMHKb0qLGMNo8h6afm8=
Date:   Sat, 21 Nov 2020 15:16:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7292: remove unneeded spi_set_drvdata()
Message-ID: <20201121151608.0b16dc66@archlinux>
In-Reply-To: <20201120142158.GA2179@smtp.gmail.com>
References: <20201119142720.86326-1-alexandru.ardelean@analog.com>
        <20201120142158.GA2179@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Nov 2020 11:21:58 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> LGTM.
> Tested on raspberry pi kernel - rpi-5.9.y.
> 
> ad7292 was heavily based on ad7768-1. 
> Maybe this might apply to ad7768-1 as well.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Tested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Thanks,

Applied to the togreg branch of iio.git and will be pushed out as testing
shortly for all the usual reasons.

Thanks,

Jonathan

> 
> On 11/19, Alexandru Ardelean wrote:
> > This seems to have been copied from a driver that calls spi_set_drvdata()
> > but doesn't call spi_get_drvdata().
> > Setting a private object on the SPI device's object isn't necessary if it
> > won't be accessed.
> > This change removes the spi_set_drvdata() call.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/adc/ad7292.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> > index ab204e9199e9..70e33dd1c9f7 100644
> > --- a/drivers/iio/adc/ad7292.c
> > +++ b/drivers/iio/adc/ad7292.c
> > @@ -276,8 +276,6 @@ static int ad7292_probe(struct spi_device *spi)
> >  		return -EINVAL;
> >  	}
> >  
> > -	spi_set_drvdata(spi, indio_dev);
> > -
> >  	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
> >  	if (!IS_ERR(st->reg)) {
> >  		ret = regulator_enable(st->reg);
> > -- 
> > 2.17.1
> >   

