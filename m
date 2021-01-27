Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39F2305372
	for <lists+linux-iio@lfdr.de>; Wed, 27 Jan 2021 07:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhA0Gsq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 27 Jan 2021 01:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhA0Gpo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jan 2021 01:45:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6840FC061756
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2021 22:45:04 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l4eZW-0004fd-O8; Wed, 27 Jan 2021 07:44:58 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1l4eZV-0006BJ-VI; Wed, 27 Jan 2021 07:44:57 +0100
Date:   Wed, 27 Jan 2021 07:44:57 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 0/2] add support for GPIO based counter
Message-ID: <20210127064457.qyal6jli5qj52ovx@pengutronix.de>
References: <20210126131239.8335-1-o.rempel@pengutronix.de>
 <84d94006-44d3-70ac-2054-2419b0555a87@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <84d94006-44d3-70ac-2054-2419b0555a87@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:43:19 up 55 days, 20:49, 25 users,  load average: 0.06, 0.05,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 26, 2021 at 02:18:34PM +0100, Marc Kleine-Budde wrote:
> On 1/26/21 2:12 PM, Oleksij Rempel wrote:
> > changes v4:
> > - use IRQ_NOAUTOEN to not enable IRQ by default
> > - rename gpio_ from name pattern and make this driver work any IRQ
> >   source.
> > 
> > changes v3:
> > - convert counter to atomic_t
> 
> What's the guaranteed width of atomic_t? IIRC a long time ago it was 24 bit only....

32 bits. The counter is wrapped after 4294967295

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
