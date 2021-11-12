Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA144EBA1
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 17:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhKLQ4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 11:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235465AbhKLQ4B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 11:56:01 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1583061056;
        Fri, 12 Nov 2021 16:53:09 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:57:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iio: adc: ad7192: Add update_scan_mode
Message-ID: <20211112165755.0504e06a@jic23-huawei>
In-Reply-To: <20211110111750.27263-3-alexandru.tachici@analog.com>
References: <20211110111750.27263-1-alexandru.tachici@analog.com>
        <20211110111750.27263-3-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Nov 2021 13:17:47 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> In continuous mode neither sigma_delta.c nor ad7192.c
> will disable previously enabled channels.
> 
> Before this patch a channel stayed enabled indefinetly,
> even when one another one was supposed to be sampled.
> This causes mixed samples in continuous mode to be delivered
> to the host.

Can you expand a bit on the path that leads to this.  As far as I can tell
in both continuous mode enable and single channel reading set_channel()
callback is called and will overwrite the channels enabled previously.

Perhaps I'm missing a path in which that call isn't made?
> 
> By adding an update_scan_mode callback, every time the
> continuous mode is activated, channels will be enabled/disabled
> accordingly.
> 
> Fixes: 3f7c3306cf38 ("staging:iio:ad7192: Use common Sigma Delta library")
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 2121a812b0c3..1fc0f4eb858e 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -782,6 +782,20 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +	int i;
> +
> +	st->conf &= ~AD7192_CONF_CHAN_MASK;
> +	for (i = 0; i < 8; i++) {
> +		if (test_bit(i, scan_mask))

for_each_set_bit()

> +			st->conf |= AD7192_CONF_CHAN(i);
> +	}
> +
> +	return ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
> +}
> +
>  static const struct iio_info ad7192_info = {
>  	.read_raw = ad7192_read_raw,
>  	.write_raw = ad7192_write_raw,
> @@ -789,6 +803,7 @@ static const struct iio_info ad7192_info = {
>  	.read_avail = ad7192_read_avail,
>  	.attrs = &ad7192_attribute_group,
>  	.validate_trigger = ad_sd_validate_trigger,
> +	.update_scan_mode = ad7192_update_scan_mode,
>  };
>  
>  static const struct iio_info ad7195_info = {
> @@ -798,6 +813,7 @@ static const struct iio_info ad7195_info = {
>  	.read_avail = ad7192_read_avail,
>  	.attrs = &ad7195_attribute_group,
>  	.validate_trigger = ad_sd_validate_trigger,
> +	.update_scan_mode = ad7192_update_scan_mode,
>  };
>  
>  #define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _extend_name, \

