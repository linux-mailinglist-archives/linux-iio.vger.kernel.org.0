Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861D0129854
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 16:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfLWPgY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 10:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWPgY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 10:36:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAA420709;
        Mon, 23 Dec 2019 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577115383;
        bh=hzPoQ1fvvaQxsqmLyBqPFPkPlBBrXBsg0roCFv+pqOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s4MSQy2xmhUVo8/AbEh0aCKi1q4LwtYsKJO4iAXF4ZSJ/enbaPVSONUXcL+pc1/dA
         aovhls2gAlH9TNRo4SZeYIxvODZjtbaY7vMf768DkL8faFhnveOIBlMEVd9Lecs0TW
         cntyTLkgwyffKMSduHFWeDDUb9NpN77AynMqT+4E=
Date:   Mon, 23 Dec 2019 15:36:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] iio: adc: ad7923: Add of_device_id table
Message-ID: <20191223153618.234c29cd@archlinux>
In-Reply-To: <daf1148cb29129023ebd1c11f2b0fba86c9446f3.camel@analog.com>
References: <20191217111158.30888-1-djunho@gmail.com>
        <20191217111158.30888-4-djunho@gmail.com>
        <daf1148cb29129023ebd1c11f2b0fba86c9446f3.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Dec 2019 11:30:56 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-12-17 at 08:11 -0300, Daniel Junho wrote:
> > Accomplish device tree compatibility to driver AD7923
> > by adding of_device_id table and making a subsequent call to
> > MODULE_DEVICE_TABLE.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> > Signed-off-by: Daniel Junho <djunho@gmail.com>
> > ---
> >  drivers/iio/adc/ad7923.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index e535cec9fc02..6d56fa0b9e30 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -348,9 +348,19 @@ static const struct spi_device_id ad7923_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(spi, ad7923_id);
> >  
> > +static const struct of_device_id ad7923_of_match[] = {
> > +	{ .compatible = "adi,ad7904", },
> > +	{ .compatible = "adi,ad7914", },
> > +	{ .compatible = "adi,ad7923", },
> > +	{ .compatible = "adi,ad7924", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, ad7923_of_match);
> > +
> >  static struct spi_driver ad7923_driver = {
> >  	.driver = {
> >  		.name	= "ad7923",
> > +		.of_match_table = ad7923_of_match,
> >  	},
> >  	.probe		= ad7923_probe,
> >  	.remove		= ad7923_remove,  

