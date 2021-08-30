Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6D3FB38C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 12:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhH3KEC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 06:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231708AbhH3KEA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 06:04:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D77F461090;
        Mon, 30 Aug 2021 10:03:04 +0000 (UTC)
Date:   Mon, 30 Aug 2021 11:06:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/16] iio: adc: max1027: Push only the requested
 samples
Message-ID: <20210830110616.70672ef3@jic23-huawei>
In-Reply-To: <20210818111139.330636-4-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-4-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Aug 2021 13:11:26 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> When a triggered scan occurs, the identity of the desired channels is
> known in indio_dev->active_scan_mask. Instead of reading and pushing to
> the IIO buffers all channels each time, scan the minimum amount of
> channels (0 to maximum requested chan, to be exact) and only provide the
> samples requested by the user.
> 
> For example, if the user wants channels 1, 4 and 5, all channels from
> 0 to 5 will be scanned

That's a reasonably optimisation

> but only the desired channels will be pushed to
> the IIO buffers.

Don't do this last bit.  The core handles demuxing the channels via
active_scan_masks. As a general rule it does a more efficient job of this
than a hand coded version in a driver (precached copy rules etc).
The core has to have the logic anyway to support multiple consumers
(e.g. in kernel consumer and userspace) so we reuse it for these cases.



> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/max1027.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index b753658bb41e..8ab660f596b5 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -360,6 +360,9 @@ static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
>  	struct max1027_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> +	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
> +		return -EINVAL;
> +
>  	if (state) {
>  		/* Start acquisition on cnvst */
>  		st->reg = MAX1027_SETUP_REG | MAX1027_CKS_MODE0 |
> @@ -368,9 +371,12 @@ static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
>  		if (ret < 0)
>  			return ret;
>  
> -		/* Scan from 0 to max */
> -		st->reg = MAX1027_CONV_REG | MAX1027_CHAN(0) |
> -			  MAX1027_SCAN_N_M | MAX1027_TEMP;
> +		/*
> +		 * Scan from 0 to the highest requested channel. The temperature
> +		 * could be avoided but it simplifies a bit the logic.
> +		 */
> +		st->reg = MAX1027_CONV_REG | MAX1027_SCAN_0_N | MAX1027_TEMP;
> +		st->reg |= MAX1027_CHAN(fls(*indio_dev->active_scan_mask) - 2);

This should be combined with appropriate additions to available_scan_masks arrays
so the IIO core can handle choosing the right one to match enabled channels.

>  		ret = spi_write(st->spi, &st->reg, 1);
>  		if (ret < 0)
>  			return ret;
> @@ -391,11 +397,22 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
>  	struct iio_poll_func *pf = private;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct max1027_state *st = iio_priv(indio_dev);
> +	unsigned int scanned_chans = fls(*indio_dev->active_scan_mask);
> +	u16 *buf = st->buffer;
> +	unsigned int bit;
>  
>  	pr_debug("%s(irq=%d, private=0x%p)\n", __func__, irq, private);
>  
>  	/* fill buffer with all channel */
> -	spi_read(st->spi, st->buffer, indio_dev->masklength * 2);
> +	spi_read(st->spi, st->buffer, scanned_chans * 2);
> +
> +	/* Only keep the channels selected by the user */
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		if (buf[0] != st->buffer[bit])
> +			buf[0] = st->buffer[bit];
> +		buf++;
> +	}
>  
>  	iio_push_to_buffers(indio_dev, st->buffer);
>  

