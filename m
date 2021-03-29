Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6F734C511
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 09:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhC2HjD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 29 Mar 2021 03:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhC2Hir (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 03:38:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5996C061574
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 00:38:46 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lQmTv-00024v-EI; Mon, 29 Mar 2021 09:38:39 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lQmTu-0005hP-5G; Mon, 29 Mar 2021 09:38:38 +0200
Date:   Mon, 29 Mar 2021 09:38:38 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <20210329073838.uneltwujt26dhrnl@pengutronix.de>
References: <20210319144509.7627-1-o.rempel@pengutronix.de>
 <20210319144509.7627-4-o.rempel@pengutronix.de>
 <20210320154601.0131805d@jic23-huawei>
 <20210322115635.GA14791@pengutronix.de>
 <20210322142722.000053a6@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210322142722.000053a6@Huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:33:21 up 116 days, 21:39, 34 users,  load average: 0.09, 0.05,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 22, 2021 at 02:27:22PM +0000, Jonathan Cameron wrote:
> > > > +static DECLARE_TI_TSC2046_8_CHANNELS(tsc2046_adc, 12);
> > > > +
> > > > +static const struct tsc2046_adc_dcfg tsc2046_adc_dcfg_tsc2046e = {
> > > > +	.channels = tsc2046_adc_channels,
> > > > +	.num_channels = ARRAY_SIZE(tsc2046_adc_channels),
> > > > +};
> > > > +  
> > > 
> > > Hmm.  Flexibility that isn't yet used.  Normally I'm pretty resistant
> > > to this going in, unless I'm reassured that there is support for additional
> > > devices already in the pipeline.  Is that true here?  Otherwise
> > > this is basically unneeded complexity.  
> > 
> > In the long term this driver should replace
> > drivers/input/touchscreen/ads7846.c
> > 
> > This driver supports ti,ads7843, ti,ads7845, ti,ads7846.. at least with
> > following number of supported channels:
> > ti,ads7843 - 4 channels: x, y, aux0, aux1
> > ti,ads7845 - 3 channels: x, y, aux0
> > ti,ads7846 - 8 channels...
> > 
> > Currently I don't have this HW for testing and there a subtle
> > differences that have to be taken care of and tested.
> > 
> 
> Note that I'm only going to merge this driver with an explicit statement
> from Dmitry as input maintainer that he is fine with this approach.

Since there is still no Dmitry's feedback please take a look to the
ti,ads7843 datasheet:
https://www.ti.com/lit/ds/symlink/ads7843.pdf

On the page 1 you can see, that this device has two general purpose ADC
inputs IN3, IN4. If some one will decide to mainline support for this
pins, will end with IIO ADC driver any way :)

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
