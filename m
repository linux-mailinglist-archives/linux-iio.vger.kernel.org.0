Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E1B2C172B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 22:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgKWU5n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 15:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgKWU5n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Nov 2020 15:57:43 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 083C2206B7;
        Mon, 23 Nov 2020 20:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606165062;
        bh=3RNDJzOWiD85IYyAHYIvb7mYZk5j7kJsGG+OaDPykV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h6ows1NGdvRNFsMQi8xtK6l8ZfaBpVJF8jwBbArnJq2xhHn/5KmjxITogxO5Lawt2
         hLWqHUKcjI4aGxIc0b3D5q9Qj2L8bpSfsu9G1YDf9FiPlB5tOvAeAtSXYlAwIQrc+Y
         oRzcP/kYPJgL7d3R49MVn91yfDRTM3pYLaRfdkbM=
Date:   Mon, 23 Nov 2020 20:57:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Nicolas.Ferre@microchip.com, kamel.bouhara@bootlin.com,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] MAINTAINERS: Add Kamel Bouhara as TCB counter driver
 maintainer
Message-ID: <20201123205737.4f5f06b3@archlinux>
In-Reply-To: <X7uragBU7qwcs62L@shinobu>
References: <20201121185824.451477-1-vilhelm.gray@gmail.com>
        <df14f643-e80e-6ae6-dcef-90adefe6d733@microchip.com>
        <X7uragBU7qwcs62L@shinobu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Nov 2020 07:30:34 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Mon, Nov 23, 2020 at 09:50:34AM +0000, Nicolas.Ferre@microchip.com wrote:
> > On 21/11/2020 at 19:58, William Breathitt Gray wrote:  
> > > Acked-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > ---
> > >   Changes in v3:
> > >    - Reorder entries to match preferred MAINTAINERS ordering
> > > 
> > >   MAINTAINERS | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 913b5eb64e44..1ee380dfe189 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2104,6 +2104,13 @@ S:       Supported
> > >   F:     arch/arm64/boot/dts/microchip/
> > >   N:     sparx5
> > > 
> > > +ARM/Microchip Timer Counter Block (TCB) Capture Driver  
> > 
> > Nit: we don't use the ARM/Microchip string for drivers which could be 
> > multi-architecture. Only AT91 and Sparx5 families have these entries.
> > 
> > I'm not holding the patch for this:
> > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>  
> 
> Jonathan,
> 
> If you would like me to submit a v4 with the "ARM/" string removed, just
> let me know. Otherwise, feel free to make an adjustment if you want when
> you merge this.

No problem, I'll tweak it when I pick it up.

Thanks,

Jonathan

> 
> Thanks,
> 
> William Breathitt Gray
> 
> > > +M:     Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > +L:     linux-iio@vger.kernel.org
> > > +S:     Maintained
> > > +F:     drivers/counter/microchip-tcb-capture.c
> > > +
> > >   ARM/MIOA701 MACHINE SUPPORT
> > >   M:     Robert Jarzmik <robert.jarzmik@free.fr>
> > >   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > --
> > > 2.29.2
> > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > >   
> > 
> > 
> > -- 
> > Nicolas Ferre  

