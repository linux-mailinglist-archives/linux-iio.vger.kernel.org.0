Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D08131B5C8
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 08:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhBOH66 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 15 Feb 2021 02:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBOH65 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 02:58:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC26C0613D6
        for <linux-iio@vger.kernel.org>; Sun, 14 Feb 2021 23:58:16 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lBYll-0005Rw-TF; Mon, 15 Feb 2021 08:58:09 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lBYlk-0006DX-NP; Mon, 15 Feb 2021 08:58:08 +0100
Date:   Mon, 15 Feb 2021 08:58:08 +0100
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
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
Message-ID: <20210215075808.cir3smhrikrxfv76@pengutronix.de>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-3-o.rempel@pengutronix.de>
 <CACRpkdZ5ZQDcy5RP=CVPJ14Lyktw_4yOuELJRweeDpPKRL3RVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CACRpkdZ5ZQDcy5RP=CVPJ14Lyktw_4yOuELJRweeDpPKRL3RVA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:57:30 up 74 days, 22:03, 40 users,  load average: 0.08, 0.02,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 12, 2021 at 10:26:39AM +0100, Linus Walleij wrote:
> On Mon, Feb 8, 2021 at 2:53 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Add simple IRQ or GPIO base event counter. This device is used to measure
> > rotation speed of some agricultural devices, so no high frequency on the
> > counter pin is expected.
> >
> > The maximal measurement frequency depends on the CPU and system load. On
> > the idle iMX6S I was able to measure up to 20kHz without count drops.
> >
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> From GPIO and interrupt point of view this driver looks good to me.
> I don't know about the userspace interface etc.

May I have your Reviewed-by?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
