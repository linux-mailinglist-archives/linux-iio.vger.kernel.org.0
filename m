Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C01AF327
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 20:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDRSXd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 14:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSXd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 14:23:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE5B21BE5;
        Sat, 18 Apr 2020 18:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587234212;
        bh=D0YLD1CWlKpcWEMow+Kk2q0B0UJPZE3Wdv2YBGnWJic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TM/WaVc93+TEUGTvUQx0MkFqN55VwlhtsfB622iwbLuaBBILnE8kj6UFczbdPbjJF
         O4Nvkaq252hnpXVhWbA5IhWr3I2jb/+gdTq/JKgt+9ZjLMQopRkh/LFVUKT57sxySM
         /kULNFwY5oaCSk/HSbTpWuca+8F1rkhnHrnpeKxY=
Date:   Sat, 18 Apr 2020 19:23:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ARM: at91: add atmel tcb capabilities
Message-ID: <20200418192327.151e3155@archlinux>
In-Reply-To: <20200417135635.GA94725@icarus>
References: <20200415130455.2222019-1-kamel.bouhara@bootlin.com>
        <20200415130455.2222019-2-kamel.bouhara@bootlin.com>
        <20200417135635.GA94725@icarus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Apr 2020 09:56:35 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Apr 15, 2020 at 03:04:53PM +0200, Kamel Bouhara wrote:
> > Some atmel socs have extra tcb capabilities that allow using a generic
> > clock source or enabling a quadrature decoder.
> > 
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>  
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
I'll need an appropriate ack from at91 maintainers for this bit

Thanks,

Jonathan

> > ---
> > Changes from v3:
> >  - Added missing kernel doc for new elements introduced in structure
> >    atmel_tcb_config.
> > 
> > Changes from v2:
> >  - Fixed first patch not applying on mainline
> > 
> >  include/soc/at91/atmel_tcb.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> > index c3c7200ce151..1d7071dc0bca 100644
> > --- a/include/soc/at91/atmel_tcb.h
> > +++ b/include/soc/at91/atmel_tcb.h
> > @@ -36,9 +36,14 @@ struct clk;
> >  /**
> >   * struct atmel_tcb_config - SoC data for a Timer/Counter Block
> >   * @counter_width: size in bits of a timer counter register
> > + * @has_gclk: boolean indicating if a timer counter has a generic clock
> > + * @has_qdec: boolean indicating if a timer counter has a quadrature
> > + * decoder.
> >   */
> >  struct atmel_tcb_config {
> >  	size_t	counter_width;
> > +	bool    has_gclk;
> > +	bool    has_qdec;
> >  };
> >  
> >  /**
> > -- 
> > 2.25.0
> >   

