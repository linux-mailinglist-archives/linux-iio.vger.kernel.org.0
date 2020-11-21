Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157482BC129
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 18:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgKURpe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 12:45:34 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42897 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgKURpe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2020 12:45:34 -0500
X-Originating-IP: 52.47.93.88
Received: from ip-172-31-39-236.eu-west-3.compute.internal (ec2-52-47-93-88.eu-west-3.compute.amazonaws.com [52.47.93.88])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3EC2A20003;
        Sat, 21 Nov 2020 17:45:31 +0000 (UTC)
Date:   Sat, 21 Nov 2020 17:45:30 +0000
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Kamel Bouhara as TCB counter driver
 maintainer
Message-ID: <20201121174530.GB11423@ip-172-31-39-236.eu-west-3.compute.internal>
References: <20201116131141.3985-1-vilhelm.gray@gmail.com>
 <20201121161902.5ede1a23@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121161902.5ede1a23@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 04:19:02PM +0000, Jonathan Cameron wrote:
> On Mon, 16 Nov 2020 08:11:41 -0500
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Purely for the record, Kamel, would you mind giving an
> Acked-by for this?

Hello Wiliam, Jon,

Of course, done.

Thanks,
Kamel
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 913b5eb64e44..18d34536c4bd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2095,6 +2095,12 @@ X:	drivers/net/wireless/atmel/
> >  N:	at91
> >  N:	atmel
> >  
> > +Microchip Timer Counter Block (TCB) Capture Driver
> > +M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/counter/microchip-tcb-capture.c
> > +
> >  ARM/Microchip Sparx5 SoC support
> >  M:	Lars Povlsen <lars.povlsen@microchip.com>
> >  M:	Steen Hegelund <Steen.Hegelund@microchip.com>
> 
