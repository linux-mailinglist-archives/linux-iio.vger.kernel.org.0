Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF5332443
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 12:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhCILmV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 06:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhCILmD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 06:42:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C98C06175F
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 03:42:03 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lJakJ-000179-Dx; Tue, 09 Mar 2021 12:41:51 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lJakI-0006Xk-R7; Tue, 09 Mar 2021 12:41:50 +0100
Date:   Tue, 9 Mar 2021 12:41:50 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210309114150.lubvvtqblw2y5zlk@pengutronix.de>
References: <20210305133813.27967-1-o.rempel@pengutronix.de>
 <20210305133813.27967-3-o.rempel@pengutronix.de>
 <20210305190239.000075fe@Huawei.com>
 <CAHp75Veu-G41mDUZubCgHD_V+_znd0HJoO03ZL7JpgwtjMYLCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Veu-G41mDUZubCgHD_V+_znd0HJoO03ZL7JpgwtjMYLCQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:41:05 up 97 days,  1:47, 44 users,  load average: 0.07, 0.06,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 09, 2021 at 01:05:27PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 5, 2021 at 9:05 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 5 Mar 2021 14:38:13 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> > > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > > the touchscreen use case. By implementing it as IIO ADC device, we can
> > > make use of resistive-adc-touch and iio-hwmon drivers.
> > >
> > > So far, this driver was tested with custom version of resistive-adc-touch driver,
> > > since it need to be extended to make use of Z1 and Z2 channels. The X/Y
> > > are working without additional changes.
> > >
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> >
> > Hi Oleksij,
> >
> > To consider this as a possible long term route instead of just making this
> > a touchscreen driver, we'll want to see those mods to the resistive-adc-touch.
> > Of course that doesn't stop review of this in the meantime.
> >
> > There are quite a few things in here that feel pretty specific to the touchscreen
> > usecase. That makes me wonder if this is a sensible approach or not.
> 
> I'm wondering if this has any similarities with existing drivers under
> drivers/input/touchscreen.

Yes, for example: drivers/input/touchscreen/ads7846.c

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
