Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6262BC09A
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 17:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKUQoH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 11:44:07 -0500
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:35834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726398AbgKUQoH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2020 11:44:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4189A1867;
        Sat, 21 Nov 2020 16:44:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3503:3504:3622:3865:3866:3867:3868:3873:4321:5007:6120:7514:7901:10004:10400:10848:10967:11232:11658:11914:12043:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21451:21627:30030:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: mom16_400890627355
X-Filterd-Recvd-Size: 1958
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Nov 2020 16:44:04 +0000 (UTC)
Message-ID: <cbc88878ecfc8e8994bb61e03b55f0384609e6eb.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add Kamel Bouhara as TCB counter driver
 maintainer
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Date:   Sat, 21 Nov 2020 08:44:03 -0800
In-Reply-To: <20201121161902.5ede1a23@archlinux>
References: <20201116131141.3985-1-vilhelm.gray@gmail.com>
         <20201121161902.5ede1a23@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-11-21 at 16:19 +0000, Jonathan Cameron wrote:
> On Mon, 16 Nov 2020 08:11:41 -0500
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Purely for the record, Kamel, would you mind giving an
> Acked-by for this?
[]
> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > @@ -2095,6 +2095,12 @@ X:	drivers/net/wireless/atmel/
> >  N:	at91
> >  N:	atmel
> > 
> > +Microchip Timer Counter Block (TCB) Capture Driver
> > +M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/counter/microchip-tcb-capture.c
> > +

Alphabetic ordering of section names please
And perhaps rename this to ARM/Microchip etc...

> >  ARM/Microchip Sparx5 SoC support
> >  M:	Lars Povlsen <lars.povlsen@microchip.com>
> >  M:	Steen Hegelund <Steen.Hegelund@microchip.com>
> 


