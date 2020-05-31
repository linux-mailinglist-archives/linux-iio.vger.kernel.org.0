Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1972B1E97F0
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 15:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgEaNri (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 09:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaNrh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 09:47:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF55206F1;
        Sun, 31 May 2020 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590932857;
        bh=W9e+yR1U2jmswqejwKdI6DpIbkOuPkTmwRk/UfmgM+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jm9T4PDe1nGD8vpCLT7/guTU40CR7nAqsDQJnfHUNgIf5T5l/cs24HblXAv9ee6xV
         dR3DfD5Ujxcx7WqwUBvmmnRLTd0SWlJoc+jCazTblLgExQPsdprHBpvXM+i8vmIsxZ
         s4ckZF56WlHuVzp+TXd8oFd6zSwxUuvtWM08xKTU=
Date:   Sun, 31 May 2020 14:47:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] iio: dac: ad5592r-base: Constify struct
 iio_chan_spec_ext_info
Message-ID: <20200531144733.72ecdaca@archlinux>
In-Reply-To: <efde021ebc6da585f030adde11fbb31c5cdca3a1.camel@analog.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
        <20200526210223.1672-4-rikard.falkeborn@gmail.com>
        <efde021ebc6da585f030adde11fbb31c5cdca3a1.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 May 2020 04:22:46 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2020-05-26 at 23:02 +0200, Rikard Falkeborn wrote:
> > [External]
> > 
> > ad5592r_ext_info is not modified and can be made const to allow the
> > compiler to put it in read-only memory.
> > 
> > Before:
> >    text    data     bss     dec     hex filename
> >   13293    2088     256   15637    3d15 drivers/iio/dac/ad5592r-base.o
> > 
> > After:
> >    text    data     bss     dec     hex filename
> >   13421    1960     256   15637    3d15 drivers/iio/dac/ad5592r-base.o
> >   
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> >  drivers/iio/dac/ad5592r-base.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-
> > base.c
> > index 410e90e5f75f..7402f67a551d 100644
> > --- a/drivers/iio/dac/ad5592r-base.c
> > +++ b/drivers/iio/dac/ad5592r-base.c
> > @@ -484,7 +484,7 @@ static ssize_t ad5592r_show_scale_available(struct
> > iio_dev *iio_dev,
> >  		st->scale_avail[1][0], st->scale_avail[1][1]);
> >  }
> >  
> > -static struct iio_chan_spec_ext_info ad5592r_ext_info[] = {
> > +static const struct iio_chan_spec_ext_info ad5592r_ext_info[] = {
> >  	{
> >  	 .name = "scale_available",
> >  	 .read = ad5592r_show_scale_available,  

