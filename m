Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF1F30778D
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jan 2021 15:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhA1N7N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jan 2021 08:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhA1N7C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jan 2021 08:59:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3CEC061756
        for <linux-iio@vger.kernel.org>; Thu, 28 Jan 2021 05:58:21 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l57oR-0006i7-4l; Thu, 28 Jan 2021 14:58:19 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1l57oG-0006AS-9M; Thu, 28 Jan 2021 14:58:08 +0100
Date:   Thu, 28 Jan 2021 14:58:08 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 2/2] counter: add IRQ or GPIO based pulse counter
Message-ID: <20210128135808.ttvd2xxjkmsqanr7@pengutronix.de>
References: <20210126131239.8335-1-o.rempel@pengutronix.de>
 <20210126131239.8335-3-o.rempel@pengutronix.de>
 <CACRpkdYSdtwSZxicJ1Rxp_XkK1BstpnzMcV0JqXg+cac_+gSSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdYSdtwSZxicJ1Rxp_XkK1BstpnzMcV0JqXg+cac_+gSSw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:57:01 up 57 days,  4:03, 33 users,  load average: 0.08, 0.05,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 28, 2021 at 09:24:08AM +0100, Linus Walleij wrote:
> Hi Oleksij,
> 
> thanks for your patch!
> 
> On Tue, Jan 26, 2021 at 2:15 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > +       priv->irq = platform_get_irq(pdev,  0);
> > +       if (priv->irq < 0) {
> > +               dev_err(dev, "failed to map GPIO to IRQ: %d\n", priv->irq);
> > +               return priv->irq;
> > +       }
> > +
> > +       priv->gpio = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
> > +       if (IS_ERR(priv->gpio))
> > +               return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get gpio\n");
> 
> I would attempt to get the IRQ from the GPIO if not defined explicitly
> in the device tree.
> 
> priv->gpio = devm_gpiod_get_optional(...)
> if (priv->gpio) {
>     /* Attempt to look up IRQ */
>     irq = gpiod_to_irq(priv->irq);
> }
> priv->irq = platfform_get_irq(...)
> if (priv->irq < 0 && irq > 0) {
>     /* Use the GPIO-related IRQ */
>     priv->irq = irq;
> } else if (priv->irq < 0) {
>    /* Error */
> }
> 
> This way the example in the device tree binding which only defines
> a GPIO and no interrupt will work if the GPIO chip provides an
> IRQ mapping.
> 

Ok, thx!
I'll send updated version after dt-binding discussion

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
