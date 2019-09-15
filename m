Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDB6B2F8D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 12:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfIOK0Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 06:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbfIOK0X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 06:26:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB6C2053B;
        Sun, 15 Sep 2019 10:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568543182;
        bh=8X8ChAHptHMjdfzF2hEECnEWUms5Rcmj9WbQCoqbz6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bBc7809kAPdWYdUXwANBXpM5UYl+kWvN5Qg6Q0iqs7o3MSYKTjDCIrRTrJ4hy064T
         +KfhwapAe50a5mEkOwYhQSSDJol2BDy3UHxkOR9riD9jhFwq45ZQHRpJyLvLGgQW4w
         YIBF5nYWIE7VrdsBz2u3SoddJoyX+VjrEvqWOKRk=
Date:   Sun, 15 Sep 2019 11:26:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: ad7949: kill pointless "readback"-handling
 code
Message-ID: <20190915112617.7121665f@archlinux>
In-Reply-To: <e592cdc194cfa0ac0eb1a9539d890a1e5f70feb1.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
        <20190912144310.7458-2-andrea.merello@gmail.com>
        <e592cdc194cfa0ac0eb1a9539d890a1e5f70feb1.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Sep 2019 06:37:17 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2019-09-12 at 16:43 +0200, Andrea Merello wrote:
> > [External]
> > 
> > The device could be configured to spit out also the configuration word
> > while reading the AD result value (in the same SPI xfer) - this is called
> > "readback" in the device datasheet.
> > 
> > The driver checks if readback is enabled and it eventually adjusts the SPI
> > xfer length and it applies proper shifts to still get the data, discarding
> > the configuration word.
> > 
> > The readback option is actually never enabled (the driver disables it), so
> > the said checks do not serve for any purpose.
> > 
> > Since enabling the readback option seems not to provide any advantage (the
> > driver entirely sets the configuration word without relying on any default
> > value), just kill the said, unused, code.  
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> 
> > 
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > ---
> >  drivers/iio/adc/ad7949.c | 27 +++------------------------
> >  1 file changed, 3 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index ac0ffff6c5ae..518044c31a73 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -57,29 +57,11 @@ struct ad7949_adc_chip {
> >  	u32 buffer ____cacheline_aligned;
> >  };
> >  
> > -static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
> > -{
> > -	if (!(ad7949_adc->cfg & AD7949_CFG_READ_BACK))
> > -		return true;
> > -
> > -	return false;
> > -}
> > -
> > -static int ad7949_spi_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
> > -{
> > -	int ret = ad7949_adc->resolution;
> > -
> > -	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
> > -		ret += AD7949_CFG_REG_SIZE_BITS;
> > -
> > -	return ret;
> > -}
> > -
> >  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> >  				u16 mask)
> >  {
> >  	int ret;
> > -	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
> > +	int bits_per_word = ad7949_adc->resolution;
> >  	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
> >  	struct spi_message msg;
> >  	struct spi_transfer tx[] = {
> > @@ -107,7 +89,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >  				   unsigned int channel)
> >  {
> >  	int ret;
> > -	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
> > +	int bits_per_word = ad7949_adc->resolution;
> >  	int mask = GENMASK(ad7949_adc->resolution, 0);
> >  	struct spi_message msg;
> >  	struct spi_transfer tx[] = {
> > @@ -138,10 +120,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >  
> >  	ad7949_adc->current_channel = channel;
> >  
> > -	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
> > -		*val = (ad7949_adc->buffer >> AD7949_CFG_REG_SIZE_BITS) & mask;
> > -	else
> > -		*val = ad7949_adc->buffer & mask;
> > +	*val = ad7949_adc->buffer & mask;
> >  
> >  	return 0;
> >  }  

