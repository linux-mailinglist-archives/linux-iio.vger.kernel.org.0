Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1319A32264C
	for <lists+linux-iio@lfdr.de>; Tue, 23 Feb 2021 08:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBWHRX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Feb 2021 02:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhBWHRT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2021 02:17:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003B5C061786
        for <linux-iio@vger.kernel.org>; Mon, 22 Feb 2021 23:16:38 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lERvq-0004vW-Rn; Tue, 23 Feb 2021 08:16:30 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lERvq-0005Jg-2d; Tue, 23 Feb 2021 08:16:30 +0100
Date:   Tue, 23 Feb 2021 08:16:30 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v6 0/2] add support for GPIO or IRQ based evemt counter
Message-ID: <20210223071630.lazyuvhr4xgqhafi@pengutronix.de>
References: <20210216081356.3577-1-o.rempel@pengutronix.de>
 <YDMNiBjnJKanhTUH@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDMNiBjnJKanhTUH@shinobu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:08:49 up 82 days, 21:15, 39 users,  load average: 0.09, 0.07,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William,

On Mon, Feb 22, 2021 at 10:48:56AM +0900, William Breathitt Gray wrote:
> On Tue, Feb 16, 2021 at 09:13:54AM +0100, Oleksij Rempel wrote:
> > changes v6:
> > - rename it to interrupt-counter
> 
> Hi Oleksij,
> 
> Sorry to nitpick again, I think "irq-counter" as Jonathan suggested in
> an earlier review would be a better name afterall. Would you be able to
> rename this driver to use that name instead?

I would prefer not to rename it. IRQ (Interrupt Request) is a signal
outside of the system. Below some frequency rate, amount of counted
ISR (interrupt service routine) calls or events would be equal to the actual
IRQs. If frequency is too high, we will count ISR, but not IRQs. In
any case, interrupt-counter is more or leas neutral, without triggering
too many wrong assumptions.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
