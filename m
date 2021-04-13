Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7035DB2F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Apr 2021 11:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245722AbhDMJbj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Apr 2021 05:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbhDMJbi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Apr 2021 05:31:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8038C061574
        for <linux-iio@vger.kernel.org>; Tue, 13 Apr 2021 02:31:18 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lWFNy-0007Gv-O1; Tue, 13 Apr 2021 11:31:06 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lWFNx-00027d-Ut; Tue, 13 Apr 2021 11:31:05 +0200
Date:   Tue, 13 Apr 2021 11:31:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [Ping for Dmitry] Re: [PATCH v5 3/3] iio: adc: add ADC driver for
 the TI TSC2046 controller
Message-ID: <20210413093105.lbqe46srqvv7tj6s@pengutronix.de>
References: <20210329073131.1759-1-o.rempel@pengutronix.de>
 <20210329073131.1759-4-o.rempel@pengutronix.de>
 <20210329115826.03bc5745@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210329115826.03bc5745@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:26:06 up 131 days, 23:32, 46 users,  load average: 0.00, 0.02,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dmitry,

probably this mail passed under your radar. Can you please add your
statement here.

On Mon, Mar 29, 2021 at 11:58:26AM +0100, Jonathan Cameron wrote:
> On Mon, 29 Mar 2021 09:31:31 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > the touchscreen use case. By implementing it as an IIO ADC device, we can
> > make use of resistive-adc-touch and iio-hwmon drivers.
> > 
> > Polled readings are currently not implemented to keep this patch small, so
> > iio-hwmon will not work out of the box for now.
> > 
> > So far, this driver was tested with a custom version of resistive-adc-touch driver,
> > since it needs to be extended to make use of Z1 and Z2 channels. The X/Y
> > are working without additional changes.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Hi Oleksij,
> 
> Couple of things in here I missed before, but big question is still whether
> Dmitry is happy with what you mention in the cover letter:
> 
> "This driver can replace drivers/input/touchscreen/ads7846.c and has
> following advantages over it:
> - less code to maintain
> - shared code paths (resistive-adc-touch, iio-hwmon, etc)
> - can be used as plain IIO ADC to investigate signaling issues or test
>   real capacity of the plates and attached low-pass filters
>   (or use the touchscreen as a microphone if you like ;) )"
> 
> So two things that need addressing in here are
> iio_dev->name (part number, not hybrid of that an spi device name)
> Why oversampling is DT rather than userspace controllable.
> For that I'm looking for clear reasoning for the choice.
 
Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
