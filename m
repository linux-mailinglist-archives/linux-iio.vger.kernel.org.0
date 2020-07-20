Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A85226121
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgGTNi5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 09:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgGTNi5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 09:38:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC63422CAF;
        Mon, 20 Jul 2020 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595252336;
        bh=czVg5VP9cic+HNMM9EeJP1WPX3dNun3L9ybH81L69GU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jITVCBjAUt2cPaPDVBBKtC66dsFGpZkRHHVtvGaHcFY4mt6+CHsnnrq3FPq5A9yIy
         QSrH4PalL86AcHlQ0uBw9M1q1ba3oTJFUaNx7ey77ZGUdVR5a8YPFbKcWSa0LjW9lZ
         wd+QY+Wx460OdY9EMF3JvTwKUcDtaTdJ/Hdbdbec=
Date:   Mon, 20 Jul 2020 14:38:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
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
Message-ID: <20200720143851.2fced464@archlinux>
In-Reply-To: <20200715213003.GD23553@piout.net>
References: <20200706114347.174452-1-kamel.bouhara@bootlin.com>
        <20200712143534.278ea3c7@archlinux>
        <20200715213003.GD23553@piout.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jul 2020 23:30:03 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hi Jonathan,
> 
> On 12/07/2020 14:35:34+0100, Jonathan Cameron wrote:
> > On Mon,  6 Jul 2020 13:43:42 +0200
> > Kamel Bouhara <kamel.bouhara@bootlin.com> wrote:
> >   
> > > Hello,
> > > 
> > > Here is a new counter driver to support Microchip TCB capture devices.
> > > 
> > > Each SoC has two TCB blocks, each one including three independent
> > > channels.The following series adds support for two counter modes:
> > > increase and quadrature decoder.
> > > 
> > > As for the atmel clocksource and pwm, the counter driver needs to fill
> > > some tcb capabilities in order to operate with the right configuration.
> > > This is achieved in first patch of this series.
> > > 
> > > Please feel free to comment.  
> > 
> > As far as I can see we have all the necessary acks etc and it looks
> > good to me as well.
> > 
> > Shall I do an immutable branch with the whole lot or should we split it
> > up?  Patches 1 and 5 need to go through the same tree, but bindings
> > could go via another route.  I'm also fine if the whole lot goes
> > via the appropriate soc tree if that is easier.
> >   
> 
> I think the best would be an immutable branch as I have another series
> that depends on the three preliminary patches that should go through the
> clocksource/tip tree this cycle:
> 
> https://lore.kernel.org/linux-arm-kernel/20200710230813.1005150-1-alexandre.belloni@bootlin.com/
I've pushed applied the patches to an immutable branch
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-5.8-tcb
and merged that into the togreg branch of iio.git which is pushed out as testing or
the autobuilders to play with it.

Thanks,

Jonathan

> 
> 

