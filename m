Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C52D185C5D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 13:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgCOMb7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 08:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbgCOMb7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:31:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543C220663;
        Sun, 15 Mar 2020 12:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584275518;
        bh=9+avE/69m1EhPZprZ7Bil5NCEReetgLzufxdqwAh0+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CzNGech/27bgfG9ielu0uR0EtbavMXgNqiVpFqfMDo0+EJPA554ceRbFWKH9VUUsh
         BK1lguFvyv4j8tM911svs1NHXdoeg819yaACTbxy51J/Mw4peNy5QrDTaOMqYMGuyV
         Zg8SThNSPjgnka7GuFnOaA0wTVIxKzVoioietAoQ=
Date:   Sun, 15 Mar 2020 12:31:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v2 1/8] iio: light: st_uvis25: Drop unneeded casting
 when print error code
Message-ID: <20200315123154.48bddabb@archlinux>
In-Reply-To: <20200315122609.31ab6673@archlinux>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
        <20200315122609.31ab6673@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Mar 2020 12:26:09 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 13 Mar 2020 12:49:48 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Explicit casting in printf() usually shows that something is not okay.
> > Here, we really don't need it by providing correct specifier.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> Applied to the togreg branch of iio.git.  
> 

+CC Rohit and Nishant

On that note.  Cleaning other cases of this out sounds like good and
useful work for those who have asked recently.

git grep -A 4 dev_err  -- drivers/iio/ | grep \(int\)

Gives a few likely places to look.

If not I'll sweep up the lot in a week or so as clearly been some
cut and paste going on here and I'd rather it didn't happen again.

Thanks,

Jonathan

> thanks,
> 
> Jonathan
> 
> > ---
> > v2: no change
> >  drivers/iio/light/st_uvis25_i2c.c | 4 ++--
> >  drivers/iio/light/st_uvis25_spi.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
> > index 4889bbeb0c73..400724069d19 100644
> > --- a/drivers/iio/light/st_uvis25_i2c.c
> > +++ b/drivers/iio/light/st_uvis25_i2c.c
> > @@ -31,8 +31,8 @@ static int st_uvis25_i2c_probe(struct i2c_client *client,
> >  
> >  	regmap = devm_regmap_init_i2c(client, &st_uvis25_i2c_regmap_config);
> >  	if (IS_ERR(regmap)) {
> > -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> > -			(int)PTR_ERR(regmap));
> > +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
> > +			PTR_ERR(regmap));
> >  		return PTR_ERR(regmap);
> >  	}
> >  
> > diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
> > index a9ceae4f58b3..cd3761a3ee3f 100644
> > --- a/drivers/iio/light/st_uvis25_spi.c
> > +++ b/drivers/iio/light/st_uvis25_spi.c
> > @@ -31,8 +31,8 @@ static int st_uvis25_spi_probe(struct spi_device *spi)
> >  
> >  	regmap = devm_regmap_init_spi(spi, &st_uvis25_spi_regmap_config);
> >  	if (IS_ERR(regmap)) {
> > -		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> > -			(int)PTR_ERR(regmap));
> > +		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
> > +			PTR_ERR(regmap));
> >  		return PTR_ERR(regmap);
> >  	}
> >    
> 

