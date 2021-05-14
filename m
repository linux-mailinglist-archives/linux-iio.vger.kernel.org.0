Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F653804C3
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhENH6w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 03:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbhENH6w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 03:58:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7862FC061574
        for <linux-iio@vger.kernel.org>; Fri, 14 May 2021 00:57:41 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lhShQ-0001hC-LK; Fri, 14 May 2021 09:57:32 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lhShP-0005IV-Vo; Fri, 14 May 2021 09:57:31 +0200
Date:   Fri, 14 May 2021 09:57:31 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 0/3] mainline ti tsc2046 adc driver
Message-ID: <20210514075731.ipxq2o4cdxd3piu3@pengutronix.de>
References: <20210428073208.19570-1-o.rempel@pengutronix.de>
 <20210503122818.59f50e45@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210503122818.59f50e45@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:44:59 up 162 days, 21:51, 46 users,  load average: 0.01, 0.04,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Mon, May 03, 2021 at 12:28:18PM +0100, Jonathan Cameron wrote:
> On Wed, 28 Apr 2021 09:32:05 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> Hi Oleksij,
> 
> Series applied with the tweaks as per review to patch 3.  Please
> check I didn't mess those up though.
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to poke at it.

It works. Thx!

Now i need to make configurable iio buffer layout

for the drivers/input/touchscreen/resistive-adc-touch.c

Do you have ideas what is the proper way to make it?

Regards,
Oleksij

> 
> Jonathan
> 
> > changes v6:
> > - get blessing from Dmitry Torokhov
> > - rebase against latest iio/testing
> > - use simple name for iio_dev->name
> > - use Jonathan's version for oversampling-ratio description 
> > 
> > changes v5:
> > - remove type for the settling-time-us property
> > 
> > changes v4:
> > - spell fixes
> > - add more comments
> > - make code more readable
> > - move scan_buf to the priv
> > - use FIELD_GET to extract ADC data
> > - make some multi line code as one line
> > - do not use atomic API for trig_more_count
> > - fix build warning on 64bit system
> > - add NULL check for the devm_kasprintf()
> > - use return devm_iio_device_register(), without additional error
> >   printing.
> > 
> > changes v3:
> > - different spell fixes
> > - add some notes about driver structure
> > - rename the trigger to point on the touchscreen nature of it
> > - rename DT binding to oversampling-ratio
> > - make sure we have some defaults in case no DT property is set
> > 
> > changes v2:
> > - rework and extend DT binding properties
> > - remove touchscreen related code from the IIO ADC driver
> > - make trigger be active longer then IRQ is requesting. This is needed
> >   to get "inactive" samples
> > - make oversampling and settle time configurable
> > 
> > TI TSC2046 is a touchscreen controller based on 8 channel ADC. Since most of
> > this ADC based touchscreen controller share same set of challenges, it
> > is better keep then as simple IIO ADC devices attached to a generic
> > resistive-adc-touch driver.
> > 
> > This driver can replace drivers/input/touchscreen/ads7846.c and has
> > following advantages over it:
> > - less code to maintain
> > - shared code paths (resistive-adc-touch, iio-hwmon, etc)
> > - can be used as plain IIO ADC to investigate signaling issues or test
> >   real capacity of the plates and attached low-pass filters
> >   (or use the touchscreen as a microphone if you like ;) )
> > 
> > Oleksij Rempel (3):
> >   dt-bindings:iio:adc: add generic settling-time-us and
> >     oversampling-ratio channel properties
> >   dt-bindings:iio:adc: add documentation for TI TSC2046 controller
> >   iio: adc: add ADC driver for the TI TSC2046 controller
> > 
> >  .../devicetree/bindings/iio/adc/adc.yaml      |  12 +
> >  .../bindings/iio/adc/ti,tsc2046.yaml          | 115 +++
> >  MAINTAINERS                                   |   8 +
> >  drivers/iio/adc/Kconfig                       |  12 +
> >  drivers/iio/adc/Makefile                      |   1 +
> >  drivers/iio/adc/ti-tsc2046.c                  | 720 ++++++++++++++++++
> >  6 files changed, 868 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> >  create mode 100644 drivers/iio/adc/ti-tsc2046.c
> > 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
