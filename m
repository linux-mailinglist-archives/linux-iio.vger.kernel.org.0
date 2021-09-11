Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB04079FE
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 19:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhIKRmL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 13:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhIKRmL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 13:42:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A698D6109F;
        Sat, 11 Sep 2021 17:40:55 +0000 (UTC)
Date:   Sat, 11 Sep 2021 18:44:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: adc: ad7192: Add IRQ flag
Message-ID: <20210911184425.3734a369@jic23-huawei>
In-Reply-To: <20210911183921.1381d776@jic23-huawei>
References: <20210906065630.16325-1-alexandru.tachici@analog.com>
        <20210906065630.16325-2-alexandru.tachici@analog.com>
        <20210911183921.1381d776@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 11 Sep 2021 18:39:21 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 6 Sep 2021 09:56:28 +0300
> <alexandru.tachici@analog.com> wrote:
> 
> > From: Alexandru Tachici <alexandru.tachici@analog.com>
> > 
> > IRQ type in ad_sigma_delta_info struct was missing.
> > 
> > In Sigma-Delta devices the SDO line is also used as an interrupt.
> > Leaving IRQ on level instead of falling might trigger a sample read
> > when the IRQ is enabled, as the SDO line is already low. Not sure
> > if SDO line will always imediately go high in ad_sd_buffer_postenable
> > before the IRQ is enabled.
> > 
> > Also the datasheet seem to explicitly say the falling edge of the SDO
> > should be used as an interrupt:
> > From the AD7192 datasheet: "The DOUT/RDY falling edge can be used
> > as an interrupt to a processor,"
> > 
> > Fixes: da4d3d6bb9f6 ("iio: adc: ad-sigma-delta: Allow custom IRQ flags")
> > Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> As in thread discussing previous version.  This one should probably be left
> to firmware to configure.  It's not 'wrong' before this point as firmware
> should be specifying it correctly.  That allows for the interrupt line
> to the processor to be inverted and other silliness that happens on real
> boards.

Ignore that - I'd forgotten this is a joint DOUT / Data ready pin so it's
polarity needs to track that of the SPI pin and inverting that isn't
something we cope with.

So applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/ad7192.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index ee8ed9481025..2121a812b0c3 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -293,6 +293,7 @@ static const struct ad_sigma_delta_info ad7192_sigma_delta_info = {
> >  	.has_registers = true,
> >  	.addr_shift = 3,
> >  	.read_mask = BIT(6),
> > +	.irq_flags = IRQF_TRIGGER_FALLING,
> >  };
> >  
> >  static const struct ad_sd_calib_data ad7192_calib_arr[8] = {
> 

