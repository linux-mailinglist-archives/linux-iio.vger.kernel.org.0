Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAD1B87E5
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgDYRBP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgDYRBP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 13:01:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B9B206B6;
        Sat, 25 Apr 2020 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587834074;
        bh=gt3fpYTkrKObtHXD/pWODA9eL7Nil3GW9E4wiPFnZsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=elUDhyeGLpVAWIboxfI9gncmA3dQ/XCSrHFj4TQaq7iWRdfwCJzVmiQCEnyxxrcIS
         fRIAfxI//TPr0jppQtXhM5ubHSKY+QXfNFYCyfBxyI7oZGoIQXWJ32Pcae8OiMmBnW
         ufVvh9hdock4NsfDcooY+NIDw6qnbV8bCuayk8pQ=
Date:   Sat, 25 Apr 2020 18:01:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] iio: adc: ad7476: remove redundant null check on
 an array
Message-ID: <20200425180110.3ffa5696@archlinux>
In-Reply-To: <f2c6d3f3f8f884e87f1c9895fe99b77e8f4c1e3e.camel@analog.com>
References: <20200424130419.22940-1-colin.king@canonical.com>
        <f2c6d3f3f8f884e87f1c9895fe99b77e8f4c1e3e.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Apr 2020 15:01:26 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2020-04-24 at 14:04 +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The null check on st->chip_info->convst_channel is redundant because
> > convst_channel is a 2 element array of struct iio_chan_spec objects
> > and this can never be null. Fix this by removing the null check.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing.
I didn't take this as a fix as it's not doing any harm in the meantime
whilst this patch goes the slow route.

Thanks,

Jonathan

> 
> > Addresses-Coverity: ("Array compared against 0")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/iio/adc/ad7476.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > index e9984a38fc4c..4e816d714ad2 100644
> > --- a/drivers/iio/adc/ad7476.c
> > +++ b/drivers/iio/adc/ad7476.c
> > @@ -309,7 +309,7 @@ static int ad7476_probe(struct spi_device *spi)
> >  	indio_dev->num_channels = 2;
> >  	indio_dev->info = &ad7476_info;
> >  
> > -	if (st->convst_gpio && st->chip_info->convst_channel)
> > +	if (st->convst_gpio)
> >  		indio_dev->channels = st->chip_info->convst_channel;
> >  	/* Setup default message */
> >    

