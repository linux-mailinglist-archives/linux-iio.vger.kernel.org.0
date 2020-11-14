Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE962B300B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 20:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgKNTQq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 14:16:46 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39033 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgKNTQq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2020 14:16:46 -0500
X-Greylist: delayed 78586 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Nov 2020 14:16:45 EST
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 60FE7FF805;
        Sat, 14 Nov 2020 19:16:43 +0000 (UTC)
Date:   Sat, 14 Nov 2020 20:16:42 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] iio: adc: at91_adc: rework trigger definition
Message-ID: <20201114191642.GA5272@piout.net>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
 <20201113212650.507680-5-alexandre.belloni@bootlin.com>
 <20201114170230.5a94a192@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114170230.5a94a192@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/11/2020 17:02:30+0000, Jonathan Cameron wrote:
> On Fri, 13 Nov 2020 22:26:45 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > Move the available trigger definition back in the driver to stop cluttering
> > the device tree. There is no functional change except that it actually
> > fixes the available triggers for at91sam9rl as it inherited the list from
> > at91sam9260 but actually has the triggers from at91sam9x5.
> 
> Is that a fix we might want to backport?  If not we should probably put a clear
> statement in here to avoid it getting picked up by the bot.
> 
> I'd argue it's to invasive a change to backport.
> 

Nobody ever complained about it so I don't think it is necessary to
backport. Anyway, the proper backportable fix would be to simply change
the device tree, that avoids the driver change which I also think is too
invasive. I'll include the DT change in v2.

