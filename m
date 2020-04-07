Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6E71A16AF
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 22:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgDGUV6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 16:21:58 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33623 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDGUV5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 16:21:57 -0400
X-Originating-IP: 78.193.40.249
Received: from kb-xps (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AD90920005;
        Tue,  7 Apr 2020 20:21:51 +0000 (UTC)
Date:   Tue, 7 Apr 2020 22:21:50 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: at91: add atmel tcb capabilities
Message-ID: <20200407202150.GD1489441@kb-xps>
References: <20200406155320.1291701-1-kamel.bouhara@bootlin.com>
 <20200406155320.1291701-2-kamel.bouhara@bootlin.com>
 <20200407165335.GF5578@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407165335.GF5578@icarus>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 07, 2020 at 12:53:35PM -0400, William Breathitt Gray wrote:
> On Mon, Apr 06, 2020 at 05:53:18PM +0200, Kamel Bouhara wrote:
> > Some atmel socs have extra tcb capabilities that allow using a generic
> > clock source or enabling a quadrature decoder.
> >
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > ---
> >  include/soc/at91/atmel_tcb.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> > index fbf5474f4484..6b9c9bec982e 100644
> > --- a/include/soc/at91/atmel_tcb.h
> > +++ b/include/soc/at91/atmel_tcb.h
> > @@ -39,7 +39,8 @@ struct clk;
> >   */
> >  struct atmel_tcb_config {
> >  	size_t	counter_width;
> > -	unsigned int has_gclk:1;
>
> Hi Kamel,
>

Hi William,

> I'm having trouble applying this patch, so I think we have different
> bases. Specifically, I'm not sure where this has_gclk member was
> introduced. It doesn't look like it's in the testing branch of the IIO
> tree yet.
>
> What branch did you base your patches on?

You're right, this line should not be here.

I'll fix it for v2.

Thanks,

Kamel

>
> Thanks,
>
> William Breathitt Gray
>
> > +	bool	has_gclk;
> > +	bool	has_qdec;
> >  };
> >
> >  /**
> > --
> > 2.25.0
> >



--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
