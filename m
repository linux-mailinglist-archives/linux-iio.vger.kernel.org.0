Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0627332412
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 12:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhCILbf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 06:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCILbJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 06:31:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F8C06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 03:31:08 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lJaZr-0008DH-0d; Tue, 09 Mar 2021 12:31:03 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lJaZq-0006HJ-8N; Tue, 09 Mar 2021 12:31:02 +0100
Date:   Tue, 9 Mar 2021 12:31:02 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210309113102.jogfzyflwefqi3i5@pengutronix.de>
References: <20210305133813.27967-1-o.rempel@pengutronix.de>
 <20210305133813.27967-3-o.rempel@pengutronix.de>
 <YEVcO/NeKzBsFEdL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEVcO/NeKzBsFEdL@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:30:28 up 97 days,  1:36, 44 users,  load average: 0.30, 0.10,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 07, 2021 at 03:05:31PM -0800, Dmitry Torokhov wrote:
> Hi Oleksij,
> 
> On Fri, Mar 05, 2021 at 02:38:13PM +0100, Oleksij Rempel wrote:
> > +
> > +	/* TODO: remove IRQ_NOAUTOEN after needed patches are mainline */
> > +	irq_set_status_flags(spi->irq, IRQ_NOAUTOEN);
> > +	ret = devm_request_threaded_irq(dev, spi->irq,
> > +					NULL,
> > +					&tsc2046_adc_irq,
> > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +					name, indio_dev);
> 
> I'd recommend dropping IRQF_TRIGGER_LOW and only using IRQF_ONESHOT and
> rely on the platform (ACPI, DT) to specify trigger polarity according to
> how device is wired in a given system. In general I believe newer
> drivers should not specify interrupt triggers themselves.

Ok, thx. Sounds good.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
