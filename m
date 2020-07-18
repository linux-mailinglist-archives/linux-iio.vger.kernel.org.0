Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6763224CFE
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgGRQ0J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgGRQ0J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jul 2020 12:26:09 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A899C0619D2
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2020 09:26:09 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id C67F99E0030;
        Sat, 18 Jul 2020 17:26:05 +0100 (BST)
Date:   Sat, 18 Jul 2020 17:26:04 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Tachici, Alexandru" <Alexandru.Tachici@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad7192: move ad7192_of_match table
 closer to the end of the file
Message-ID: <20200718172604.4257a4f8@archlinux>
In-Reply-To: <191e9880ea3dd0e127b102f006c208f31d57c421.camel@analog.com>
References: <20200415055804.17971-1-alexandru.ardelean@analog.com>
        <20200415055804.17971-2-alexandru.ardelean@analog.com>
        <191e9880ea3dd0e127b102f006c208f31d57c421.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jul 2020 16:11:39 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2020-04-15 at 08:58 +0300, Alexandru Ardelean wrote:
> > The change is more cosmetic. There is no need to reference this table in
> > the probe function since 'of_device_get_match_data' is used, which
> > obtains
> > this information from the driver object.  
> 
> This looks like it could be applied now.
> The iio/testing branch seems to have patch [1/2].
Thanks.

Applied.

Jonathan

> 
> Thanks
> Alex
> 
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/adc/ad7192.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index 1431f555daa6..fd89a5115c55 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -908,15 +908,6 @@ static int ad7192_channels_config(struct iio_dev
> > *indio_dev)
> >  	return 0;
> >  }
> >  
> > -static const struct of_device_id ad7192_of_match[] = {
> > -	{ .compatible = "adi,ad7190", .data =
> > &ad7192_chip_info_tbl[ID_AD7190] },
> > -	{ .compatible = "adi,ad7192", .data =
> > &ad7192_chip_info_tbl[ID_AD7192] },
> > -	{ .compatible = "adi,ad7193", .data =
> > &ad7192_chip_info_tbl[ID_AD7193] },
> > -	{ .compatible = "adi,ad7195", .data =
> > &ad7192_chip_info_tbl[ID_AD7195] },
> > -	{}
> > -};
> > -MODULE_DEVICE_TABLE(of, ad7192_of_match);
> > -
> >  static int ad7192_probe(struct spi_device *spi)
> >  {
> >  	struct ad7192_state *st;
> > @@ -1050,6 +1041,15 @@ static int ad7192_remove(struct spi_device *spi)
> >  	return 0;
> >  }
> >  
> > +static const struct of_device_id ad7192_of_match[] = {
> > +	{ .compatible = "adi,ad7190", .data =
> > &ad7192_chip_info_tbl[ID_AD7190] },
> > +	{ .compatible = "adi,ad7192", .data =
> > &ad7192_chip_info_tbl[ID_AD7192] },
> > +	{ .compatible = "adi,ad7193", .data =
> > &ad7192_chip_info_tbl[ID_AD7193] },
> > +	{ .compatible = "adi,ad7195", .data =
> > &ad7192_chip_info_tbl[ID_AD7195] },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, ad7192_of_match);
> > +
> >  static struct spi_driver ad7192_driver = {
> >  	.driver = {
> >  		.name	= "ad7192",  

