Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436E12216FF
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 23:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgGOVaH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 17:30:07 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:58437 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVaH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 17:30:07 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AA304240009;
        Wed, 15 Jul 2020 21:30:03 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:30:03 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Microchip TCB Capture driver
Message-ID: <20200715213003.GD23553@piout.net>
References: <20200706114347.174452-1-kamel.bouhara@bootlin.com>
 <20200712143534.278ea3c7@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712143534.278ea3c7@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 12/07/2020 14:35:34+0100, Jonathan Cameron wrote:
> On Mon,  6 Jul 2020 13:43:42 +0200
> Kamel Bouhara <kamel.bouhara@bootlin.com> wrote:
> 
> > Hello,
> > 
> > Here is a new counter driver to support Microchip TCB capture devices.
> > 
> > Each SoC has two TCB blocks, each one including three independent
> > channels.The following series adds support for two counter modes:
> > increase and quadrature decoder.
> > 
> > As for the atmel clocksource and pwm, the counter driver needs to fill
> > some tcb capabilities in order to operate with the right configuration.
> > This is achieved in first patch of this series.
> > 
> > Please feel free to comment.
> 
> As far as I can see we have all the necessary acks etc and it looks
> good to me as well.
> 
> Shall I do an immutable branch with the whole lot or should we split it
> up?  Patches 1 and 5 need to go through the same tree, but bindings
> could go via another route.  I'm also fine if the whole lot goes
> via the appropriate soc tree if that is easier.
> 

I think the best would be an immutable branch as I have another series
that depends on the three preliminary patches that should go through the
clocksource/tip tree this cycle:

https://lore.kernel.org/linux-arm-kernel/20200710230813.1005150-1-alexandre.belloni@bootlin.com/


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
