Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146AC1B87C3
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgDYQss (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgDYQsr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:48:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7864D206B9;
        Sat, 25 Apr 2020 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587833327;
        bh=tzCr+jaVMbJVOsWnde9XRc+ThyBXl/43wzxL1g/6FUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rerwil9d7r/ThdeWTlQfNmxH7wZuE8e3g35kefLFVhU5qLSxSaxIjjb2cW7B4pAq2
         4xuABzy1oSLCwVWCncKRzdiQIVjeW86meItgMP/qrR3ufMWaFsZgw/DV4E10WIsaOV
         6liccr+61yTaNNbWnj7ImerI4gaTJFKM5xf9ib+M=
Date:   Sat, 25 Apr 2020 17:48:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 13/16] iio: pressure: ms5611: Use
 get_unaligned_be24()
Message-ID: <20200425174843.352a5853@archlinux>
In-Reply-To: <20200421083645.GA23009@arch>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-13-andriy.shevchenko@linux.intel.com>
        <20200421083645.GA23009@arch>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 10:36:45 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> On Tue, Apr 21, 2020 at 03:31:32AM +0300, Andy Shevchenko wrote:
> > This makes the driver code slightly easier to read.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/iio/pressure/ms5611_i2c.c | 2 +-
> >  drivers/iio/pressure/ms5611_spi.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> > index 8089c59adce5..ced83162ae94 100644
> > --- a/drivers/iio/pressure/ms5611_i2c.c
> > +++ b/drivers/iio/pressure/ms5611_i2c.c
> > @@ -50,7 +50,7 @@ static int ms5611_i2c_read_adc(struct ms5611_state *st, s32 *val)
> >  	if (ret < 0)
> >  		return ret;
> >
> > -	*val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
> > +	*val = get_unaligned_be24(&buf[0]);
> >
> >  	return 0;
> >  }
> > diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> > index b463eaa799ab..517295616869 100644
> > --- a/drivers/iio/pressure/ms5611_spi.c
> > +++ b/drivers/iio/pressure/ms5611_spi.c
> > @@ -45,7 +45,7 @@ static int ms5611_spi_read_adc(struct device *dev, s32 *val)
> >  	if (ret < 0)
> >  		return ret;
> >
> > -	*val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
> > +	*val = get_unaligned_be24(&buf[0]);
> >
> >  	return 0;
> >  }  
> 
> Looks good.
> Acked-by: Tomasz Duszynski <tduszyns@gmail.com>
Added missing asm/unaligned.h includes and applied.

Thanks,

Jonathan

> 
> > --
> > 2.26.1
> >  

