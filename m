Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92851A76A2
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437205AbgDNIwe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 04:52:34 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60025 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437158AbgDNIv6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 04:51:58 -0400
X-Originating-IP: 78.193.40.249
Received: from kb-xps (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 07CFBC0013;
        Tue, 14 Apr 2020 08:51:54 +0000 (UTC)
Date:   Tue, 14 Apr 2020 10:51:53 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ARM: at91: add atmel tcb capabilities
Message-ID: <20200414085153.GC161090@kb-xps>
References: <20200409141401.321222-1-kamel.bouhara@bootlin.com>
 <20200409141401.321222-2-kamel.bouhara@bootlin.com>
 <20200412113137.1763f084@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200412113137.1763f084@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 12, 2020 at 11:31:37AM +0100, Jonathan Cameron wrote:
> On Thu,  9 Apr 2020 16:13:59 +0200
> Kamel Bouhara <kamel.bouhara@bootlin.com> wrote:
>
> > Some atmel socs have extra tcb capabilities that allow using a generic
> > clock source or enabling a quadrature decoder.
> >
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > ---
> > Changes from v2:
> >  - Fixed first patch not applying on mainline
> >
> >  include/soc/at91/atmel_tcb.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> > index c3c7200ce151..7e47ace9255c 100644
> > --- a/include/soc/at91/atmel_tcb.h
> > +++ b/include/soc/at91/atmel_tcb.h
> > @@ -39,6 +39,8 @@ struct clk;
> >   */
> >  struct atmel_tcb_config {
> >  	size_t	counter_width;
>
Hi,

> This structure has existing kernel doc. Please add these new
> elements and run ./scripts/kernel-doc over it check for any issues.
>

Its fixed, thanks.

Kamel

> > +	bool    has_gclk;
> > +	bool    has_qdec;
> >  };
> >
> >  /**
> > --
> > 2.25.0
> >
>
> Thanks,
>
> Jonathan

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
