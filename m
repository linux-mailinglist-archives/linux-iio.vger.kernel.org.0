Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687E134CDDF
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhC2KYA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 06:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhC2KXq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 06:23:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A2FD61584;
        Mon, 29 Mar 2021 10:23:41 +0000 (UTC)
Date:   Mon, 29 Mar 2021 11:23:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 3/3] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210329112347.6a42628f@jic23-huawei>
In-Reply-To: <20210329073838.uneltwujt26dhrnl@pengutronix.de>
References: <20210319144509.7627-1-o.rempel@pengutronix.de>
        <20210319144509.7627-4-o.rempel@pengutronix.de>
        <20210320154601.0131805d@jic23-huawei>
        <20210322115635.GA14791@pengutronix.de>
        <20210322142722.000053a6@Huawei.com>
        <20210329073838.uneltwujt26dhrnl@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Mar 2021 09:38:38 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Mon, Mar 22, 2021 at 02:27:22PM +0000, Jonathan Cameron wrote:
> > > > > +static DECLARE_TI_TSC2046_8_CHANNELS(tsc2046_adc, 12);
> > > > > +
> > > > > +static const struct tsc2046_adc_dcfg tsc2046_adc_dcfg_tsc2046e = {
> > > > > +	.channels = tsc2046_adc_channels,
> > > > > +	.num_channels = ARRAY_SIZE(tsc2046_adc_channels),
> > > > > +};
> > > > > +    
> > > > 
> > > > Hmm.  Flexibility that isn't yet used.  Normally I'm pretty resistant
> > > > to this going in, unless I'm reassured that there is support for additional
> > > > devices already in the pipeline.  Is that true here?  Otherwise
> > > > this is basically unneeded complexity.    
> > > 
> > > In the long term this driver should replace
> > > drivers/input/touchscreen/ads7846.c
> > > 
> > > This driver supports ti,ads7843, ti,ads7845, ti,ads7846.. at least with
> > > following number of supported channels:
> > > ti,ads7843 - 4 channels: x, y, aux0, aux1
> > > ti,ads7845 - 3 channels: x, y, aux0
> > > ti,ads7846 - 8 channels...
> > > 
> > > Currently I don't have this HW for testing and there a subtle
> > > differences that have to be taken care of and tested.
> > >   
> > 
> > Note that I'm only going to merge this driver with an explicit statement
> > from Dmitry as input maintainer that he is fine with this approach.  
> 
> Since there is still no Dmitry's feedback please take a look to the
> ti,ads7843 datasheet:
> https://www.ti.com/lit/ds/symlink/ads7843.pdf
> 
> On the page 1 you can see, that this device has two general purpose ADC
> inputs IN3, IN4. If some one will decide to mainline support for this
> pins, will end with IIO ADC driver any way :)

Understood, but I'm still going to want Dmitry to give an opinion on
this.  That might take a little while though as he may well be busy!

Jonathan

> 
> Regards,
> Oleksij

