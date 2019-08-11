Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0858F890A7
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHKIYR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 04:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfHKIYR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Aug 2019 04:24:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9D35216F4;
        Sun, 11 Aug 2019 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565511856;
        bh=HUqE2jicU2f5TLW18jlaxJAUP1YeHMHB74GR0cNbTIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lOe1e06owzyl2ouywaeLtHmVL0DrwjKmJmiHl/a9N4X8pk5zfn5ax64yBBW4LHCBm
         PXsa12XH5VCfNNDkflAge2itnDiU+2s6bNAa/6Ef01akTp98v0YzZOSP3bmHttbzVl
         5WMqKtRaD2x1Rwhl+L6c3W2TRXV5JW1Fwrn83Wdg=
Date:   Sun, 11 Aug 2019 09:24:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stefan Agner <stefan@agner.ch>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: Fix temperature reading in probe
Message-ID: <20190811092411.4474796c@archlinux>
In-Reply-To: <20190806073114.4mujzdvbrgxivizs@uno.localdomain>
References: <20190805155515.22621-1-jacopo+renesas@jmondi.org>
        <20190805181244.663585ac@archlinux>
        <20190806073114.4mujzdvbrgxivizs@uno.localdomain>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 6 Aug 2019 09:31:14 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Hi Jonathan,
> 
> On Mon, Aug 05, 2019 at 06:12:44PM +0100, Jonathan Cameron wrote:
> > On Mon,  5 Aug 2019 17:55:15 +0200
> > Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> >  
> > > The max9611 driver reads the die temperature at probe time to validate
> > > the communication channel. Use the actual read value to perform the test
> > > instead of the read function return value, which was mistakenly used so
> > > far.
> > >
> > > The temperature reading test was only successful because the 0 return
> > > value is in the range of supported temperatures.
> > >
> > > Fixes: 69780a3bbc0b ("iio: adc: Add Maxim max9611 ADC driver")
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>  
> >
> > Applied to the fixes-togreg branch of iio.git and marked for
> > stable.  That'll be a bit fiddly given other changes around this
> > so we may need to do backports.
> >  
> 
> Indeed, I should have mentioned this patch depends on Joe's
> ae8cc91a7d85 ("iio: adc: max9611: Fix misuse of GENMASK macro")
> which is now in linux-next, otherwise it might atually trigger errors
> due to the wrong mask value.
> 
> I wonder if there's a way to keep track of these dependencies for the
> sake of backporting, or it's an operation that has to be carried out
> manually...
A note in the commit message is normally enough as all the stable
maintainers check that first.  In this particular case both patches
are marked for stable so will get picked up automatically in the right
order (hopefully!).

Thanks,

Jonathan

> 
> Thanks
>    j
> 
> >  
> > > ---
> > >  drivers/iio/adc/max9611.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > > index 917223d5ff5b..e9f6b1da1b94 100644
> > > --- a/drivers/iio/adc/max9611.c
> > > +++ b/drivers/iio/adc/max9611.c
> > > @@ -480,7 +480,7 @@ static int max9611_init(struct max9611_dev *max9611)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	regval = ret & MAX9611_TEMP_MASK;
> > > +	regval &= MAX9611_TEMP_MASK;
> > >
> > >  	if ((regval > MAX9611_TEMP_MAX_POS &&
> > >  	     regval < MAX9611_TEMP_MIN_NEG) ||
> > > --
> > > 2.22.0
> > >  
> >  

