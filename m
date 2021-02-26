Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6F325DB0
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 07:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZGqr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Feb 2021 01:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhBZGqr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2021 01:46:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31FBC06174A
        for <linux-iio@vger.kernel.org>; Thu, 25 Feb 2021 22:46:06 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lFWt0-0005Dx-CP; Fri, 26 Feb 2021 07:46:02 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lFWsz-0007ps-9S; Fri, 26 Feb 2021 07:46:01 +0100
Date:   Fri, 26 Feb 2021 07:46:01 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     devicetree@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
Message-ID: <20210226064601.io6tznddikhcmvb3@pengutronix.de>
References: <20210208135347.18494-3-o.rempel@pengutronix.de>
 <YCjlPhEtyH+vfSi4@shinobu>
 <20210215091737.fx6dwiz7tt56wbkr@pengutronix.de>
 <YDMMJJ985Zq9oEOv@shinobu>
 <20210223100656.efbshsh5bz66uhj5@pengutronix.de>
 <20210223174516.wjlh7hnrd5qe5s6w@pengutronix.de>
 <YDW7Hihg0gGQh8UR@shinobu>
 <20210224073506.GA24260@pengutronix.de>
 <YDYKF7zdyjZX30gX@shinobu>
 <YDYMRVgC3BrjISKU@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDYMRVgC3BrjISKU@shinobu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:44:43 up 85 days, 20:51, 38 users,  load average: 0.10, 0.06,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 24, 2021 at 05:20:21PM +0900, William Breathitt Gray wrote:
> On Wed, Feb 24, 2021 at 05:11:03PM +0900, William Breathitt Gray wrote:
> > On Wed, Feb 24, 2021 at 08:35:06AM +0100, Oleksij Rempel wrote:
> > > On Wed, Feb 24, 2021 at 11:34:06AM +0900, William Breathitt Gray wrote:
> > > > Alternatively, we can take a more generic approach: ignore the GPIO
> > > > names and focus solely on the IRQ lines; because the GPIO lines will
> > > > always be tied to respective IRQ lines here, using the IRQ as the basis
> > > > of the name should always be valid. The "name" member of the struct
> > > > irq_chip can work for this. I haven't tested this, but I think something
> > > > like this would work:
> > > > 
> > > > 	cnt_signals[0].name = irq_get_chip(priv->irq)->name;
> > > 
> > > ok, i'll take a look at it.
> > 
> > If that doesn't work, then use devm_kasprintf() to generate the name
> > based on the IRQ line number. The idea here is that the user should be
> > able to identify that the Signal component for this Count is the
> > respective IRQ.
> > 
> > William Breathitt Gray
> 
> I realized that these irq_chip names are often just the device name
> which isn't very useful either. :-(
> 
> In that case, I suppose we really are just left with generating the name
> based on the IRQ line number then. This should be fine then:
> 
> 	cnt_signals[0].name = devm_kasprintf(dev, GFP_KERNEL, "IRQ %d",
> 					     priv->irq);
> 	if (!cnt_signals[0].name)
> 		return -ENOMEM;
> 
> I think this would make it clear to the user that this Signal is the
> respective IRQ (whether sourced from GPIO or not).

ack, with one correction. cnt_signals should be allocated, otherwise
this value will be set per driver not per device.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
