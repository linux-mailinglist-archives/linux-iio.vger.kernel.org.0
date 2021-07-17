Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E673CC4E9
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 19:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhGQRiP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 17 Jul 2021 13:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233280AbhGQRiO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 13:38:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E90D96101D;
        Sat, 17 Jul 2021 17:35:15 +0000 (UTC)
Date:   Sat, 17 Jul 2021 18:37:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] iio: adc: ti-ads7950: Ensure CS is deasserted after
 reading channels
Message-ID: <20210717183738.6780f288@jic23-huawei>
In-Reply-To: <00b3dd46-48ba-3d40-36dd-79372a956085@lechnology.com>
References: <20210709101110.1814294-1-u.kleine-koenig@pengutronix.de>
        <00b3dd46-48ba-3d40-36dd-79372a956085@lechnology.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 9 Jul 2021 11:39:48 -0500
David Lechner <david@lechnology.com> wrote:

> On 7/9/21 5:11 AM, Uwe Kleine-König wrote:
> > The ADS7950 requires that CS is deasserted after each SPI word. Before
> > commit e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
> > CPU usage") the driver used a message with one spi transfer per channel
> > where each but the last one had .cs_change set to enforce a CS toggle.
> > This was wrongly translated into a message with a single transfer and
> > .cs_change set which results in a CS toggle after each word but the
> > last which corrupts the first adc conversion of all readouts after the
> > first readout.
> > 
> > Fixes: e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage")
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >   drivers/iio/adc/ti-ads7950.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> > index 2383eacada87..a2b83f0bd526 100644
> > --- a/drivers/iio/adc/ti-ads7950.c
> > +++ b/drivers/iio/adc/ti-ads7950.c
> > @@ -568,7 +568,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
> >   	st->ring_xfer.tx_buf = &st->tx_buf[0];
> >   	st->ring_xfer.rx_buf = &st->rx_buf[0];
> >   	/* len will be set later */
> > -	st->ring_xfer.cs_change = true;
> >   
> >   	spi_message_add_tail(&st->ring_xfer, &st->ring_msg);
> >   
> >   
> 
> Yes, it seems like the SPI_CS_WORD flag should have replaced this (it's
> been too long, I can't remember if it was intentional). And removing it
> doesn't seem to break anything for me.
> 
> Reviewed-by: David Lechner <david@lechnology.com>
> Tested-by: David Lechner <david@lechnology.com>

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
