Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429A72C762A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbgK1W3q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 17:29:46 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42045 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbgK1W3q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 17:29:46 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id F4074240002;
        Sat, 28 Nov 2020 22:28:59 +0000 (UTC)
Date:   Sat, 28 Nov 2020 23:28:59 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] iio: adc: at91_adc: remove platform data
Message-ID: <20201128222859.GL1296649@piout.net>
References: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
 <20201117140656.1235055-2-alexandre.belloni@bootlin.com>
 <20201128140427.61dbaceb@archlinux>
 <20201128142342.GJ1296649@piout.net>
 <20201128152645.0e0a7e4a@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128152645.0e0a7e4a@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 28/11/2020 15:26:45+0000, Jonathan Cameron wrote:
> On Sat, 28 Nov 2020 15:23:42 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > Hi,
> > 
> > On 28/11/2020 14:04:27+0000, Jonathan Cameron wrote:
> > > On Tue, 17 Nov 2020 15:06:46 +0100
> > > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > >   
> > > > The at91 platforms have been DT only for a while, remove platform data.
> > > > 
> > > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>  
> > > 
> > > Hi Alexandre,
> > > 
> > > I'd completely forgotten that we actually had a similar patch that
> > > is already applied from Alexandru back in September.
> > >   
> > 
> > I actually have seen that yesterday too. I even reviewed them...
> > 
> > > Given vast majority matched, I've just changed your patch into one
> > > that drops the id_table (which Alexandru didn't do).
> > > 
> > > So with that tweak applied to the togreg branch of iio.git.
> > >   
> > 
> > Ok, thanks, I guess you didn't push yet, I wanted to check and I didn't
> > find the patches on kernel.org.
> 
> I've actually just backed my try at this out.  It gets a bit messy around
> patch 6-7 so I'd rather you did a rebase.
> 
> Please rebase on current togreg branch.

Done!


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
