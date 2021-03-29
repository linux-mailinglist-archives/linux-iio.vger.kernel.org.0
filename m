Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE334D3AC
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhC2PVV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 11:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhC2PVT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 11:21:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ECFD6187E;
        Mon, 29 Mar 2021 15:21:14 +0000 (UTC)
Date:   Mon, 29 Mar 2021 16:21:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings:iio:adc: add generic
 settling-time-us and oversampling-ratio channel properties
Message-ID: <20210329162121.5a302356@jic23-huawei>
In-Reply-To: <20210329130620.utfdlgwzixrenqka@pengutronix.de>
References: <20210329073131.1759-1-o.rempel@pengutronix.de>
        <20210329073131.1759-2-o.rempel@pengutronix.de>
        <20210329112532.174825d6@jic23-huawei>
        <20210329130620.utfdlgwzixrenqka@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Mar 2021 15:06:20 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Mon, Mar 29, 2021 at 11:25:32AM +0100, Jonathan Cameron wrote:
> > On Mon, 29 Mar 2021 09:31:29 +0200
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >   
> > > Settling time and over sampling is a typical challenge for different IIO ADC
> > > devices. So, introduce channel specific settling-time-us and oversampling-ratio
> > > properties to cover this use case.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > > index 912a7635edc4..d5bc86d2a2af 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > > @@ -39,4 +39,12 @@ properties:
> > >        The first value specifies the positive input pin, the second
> > >        specifies the negative input pin.
> > >  
> > > +  settling-time-us:
> > > +    description:
> > > +      Time between enabling the channel and firs stable readings.  
> > 
> > first  
> 
> ack
> 
> > > +
> > > +  oversampling-ratio:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: Number of data samples which are averaged for each read.  
> > 
> > I think I've asked about this in previous reviews, but I want a clear statement
> > of why you think this property is a feature of the 'board' (and hence should be
> > in device tree) rather than setting sensible defaults and leaving any control
> > to userspace?  
> 
> yes, my reply was:

Ah. I missed it somewhere along the way, thanks for repeating here.

> > Oversampling is used as replacement of or addition to the low-pass filter. The
> > filter can be implemented on board, but it will change settling time
> > characteristic. Since low-pass filter is board specific characteristic, this
> > property belongs in device tree as well.  
> 
> I could imagine that this values can be overwritten from user space for
> diagnostic, but we need some working default values. 

Hmm. So low pass filters are interesting whether they are actually a characteristic
of the board (obviously they are if they are resistors/ caps etc on the board),
or of the application. Some applications want noisy messy data,
others not so much. What filter you need to achieve a specific noise level on
a given board is indeed a characteristic of the board.  However, what that noise
level is (which actually drives the decision) is not a board characteristic.
If we have a configurable filter, then that can be argued to be a policy decision
and hence userspace, not DT.

> 
> Should I integrate this comment in to the yaml?

Definitely.  Whilst I'm not that keen on this one, you have made a reasonable argument
that it is 'sort of' a board characteristic, so I can live with that as long as
it is there.   Perhaps the slightly amended version of the above.

"Oversampling is used as replacement of or addition to the low-pass filter.
In some cases, the desired filtering characteristics are a function the
device design and can interact with other characteristics such as
settling time."

Jonathan


> 
> Regards,
> Oleksij

