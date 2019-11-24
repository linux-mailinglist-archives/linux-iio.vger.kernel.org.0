Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1084C1084B0
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2019 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKXTLW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Nov 2019 14:11:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55949 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKXTLW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Nov 2019 14:11:22 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iYxHk-0004i4-LW; Sun, 24 Nov 2019 20:11:04 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iYxHh-0006Zd-QY; Sun, 24 Nov 2019 20:11:01 +0100
Date:   Sun, 24 Nov 2019 20:11:01 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 3/3] iio: adc: new driver to support Linear
 technology's ltc2496
Message-ID: <20191124191101.duh646kbrlackget@pengutronix.de>
References: <20191121210007.25646-1-u.kleine-koenig@pengutronix.de>
 <20191121210007.25646-4-u.kleine-koenig@pengutronix.de>
 <20191123171204.3a714322@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191123171204.3a714322@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 23, 2019 at 05:12:04PM +0000, Jonathan Cameron wrote:
> On Thu, 21 Nov 2019 22:00:07 +0100
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
> > This chip is similar to the LTC2497 ADC, it just uses SPI instead of I2C
> > and so has a slightly different protocol. Only the actual hardware
> > access is different. The spi protocol is different enough to not be able
> > to map the differences via a regmap.
> > 
> > Also generalize the entry in MAINTAINER to cover the newly introduced
> > file.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> looks good with the exception of the now overly protected DMA buffers.
> 
> See inline.  As that's all I'm seeing that needs fixing I'll just
> fix this up whilst applying.
> 
> I'd like the series to sit a little longer on the list though to give
> devicetree maintainers time to look at the bindings.

ok.

> > +struct ltc2496_driverdata {
> > +	/* this must be the first member */
> > +	struct ltc2497core_driverdata common_ddata;
> > +	struct spi_device *spi;
> > +
> > +	/*
> > +	 * DMA (thus cache coherency maintenance) requires the
> > +	 * transfer buffers to live in their own cache lines.
> > +	 */
> > +	unsigned char rxbuf[3] ____cacheline_aligned;
> > +	unsigned char txbuf[3] ____cacheline_aligned;
> Ah.  I've not explained this clearly enough.  Upshot is you only need
> to ensure that the buffers used for dma are not shared with any other
> usage.  the __cacheline_aligned marker pads the structure to ensure
> the element so marked is at the start of a new cacheline.  This means
> there is no sharing with non DMA related elements which may be accidentally
> reset when the DMA transfer ends.
> 
> Imagine we had:
> struct bob {
> 	int a; //used for all sorts of fun things not related to dma and not
>        	       //protected from happening concurrently with dma.
> 	unsigned char rx_buf[3];
> 	unsigned char tx_buf[3]
> };
> 
> The buffers are used for DMA.  The DMA engine takes a copy of the cacheline
> to start doing it's magic.
> 
> Along comes other activity and writes to 'a'.
> 
> DMA completes, then engine pushes the cacheline back to the memory including
> writing back what it had as a copy of a.  Thus the update to 'a' is lost.
> 
> Now the guarantee we make use of is that DMA engines are not allowed to
> copy cachelines that do not contain the buffers they are using (all sorts
> of things would break if they were).
> 
> However, there is no need to separate rx_buf and tx_buf as they are being
> used by the same DMA engine and nothing else is going to update them whilst
> they are in use.

Yeah, I thought about that when adding the second annotation but then
forgot to mention that in my cover letter.

So I assume you will just drop the 2nd ____cacheline_aligned? That's
fine for me; thanks.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
