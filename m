Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25624401098
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhIEPfp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 11:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231485AbhIEPfo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 11:35:44 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65BD660F4A;
        Sun,  5 Sep 2021 15:34:40 +0000 (UTC)
Date:   Sun, 5 Sep 2021 16:38:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH v2 11/16] iio: adc: max1027: Prevent single channel
 accesses during buffer reads
Message-ID: <20210905163804.67fca556@jic23-huawei>
In-Reply-To: <20210902211437.503623-12-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
        <20210902211437.503623-12-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:14:32 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> When hardware buffers are enabled (the cnvst pin being the trigger), one
> should not mess with the device state by requesting a single channel
> read.
> 
> There is already a iio_buffer_enabled() check in *_read_single_value()
> to merely prevent this situation but the check is inconsistent since
> buffers can be enabled after the if clause anyway. Instead, use the core
> mutex by calling iio_device_claim/release_direct_mode().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/max1027.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index f4cb5c75604b..57f62ea2d7aa 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -296,10 +296,9 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
>  	int ret;
>  	struct max1027_state *st = iio_priv(indio_dev);
>  
> -	if (iio_buffer_enabled(indio_dev)) {
> -		dev_warn(&indio_dev->dev, "trigger mode already enabled");
> -		return -EBUSY;
> -	}
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;

>  
>  	/* Configure conversion register with the requested chan */
>  	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
> @@ -325,6 +324,8 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		return ret;

Must also be released in error paths.  Treat it like a lock (there is one
internally) so to avoid permanent deadlock we must release it even if things
are going wrong

>  
> +	iio_device_release_direct_mode(indio_dev);
> +
>  	*val = be16_to_cpu(st->buffer[0]);
>  
>  	return IIO_VAL_INT;

