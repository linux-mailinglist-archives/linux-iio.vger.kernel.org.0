Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8112E44EB96
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 17:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhKLQxF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 11:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235142AbhKLQxE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 11:53:04 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1FA60F70;
        Fri, 12 Nov 2021 16:50:12 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:54:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio: adc: ad7124: Add update_scan_mode
Message-ID: <20211112165457.176a6c6d@jic23-huawei>
In-Reply-To: <20211110111750.27263-2-alexandru.tachici@analog.com>
References: <20211110111750.27263-1-alexandru.tachici@analog.com>
        <20211110111750.27263-2-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Nov 2021 13:17:46 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> In continuous mode neither sigma_delta.c nor ad7124.c
> will disable previously enabled channels.
> 
> Before this patch a channel stayed enabled indefinetly,
> even when one another one was supposed to be sampled.
> This causes mixed samples in continuous mode to be delivered
> to the host.
> 
> By adding an update_scan_mode callback, every time the
> continuous mode is activated, channels will be enabled/disabled
> accordingly.
> 
> Fixes: b3af341bbd966 ("iio: adc: Add ad7124 support")
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

I'm a little confused about which paths this bug affects.

If we have done a single channel read, then the channel is always
disabled afterwards so we won't leave one on in that path.

So the remaining path is on a previous buffer setup. In that path
set_channel is called as part the post_enable callback and will
enable the channel.

Currently nothing disables it again, so I guess if you then
change the enabled channels and restart the buffer you see the
condition you are covering here.

However, as I read the docs, this should also affect any
single reads of a later channel than the one that was originally enabled.
e.g. buffered capture enabled for channel 0 then disabled.  Later read of
channel 1 may get the data from channel 0.

The fix you have here won't close that path because we don't
call update_scan_mode() in the buffer disable path (we have considered
it a few times, but so many devices don't have to do an explicit disable there
that we never put it in). Perhaps with hindsight we should have always
called it in the disable path, but maybe with a parameter to allow devices
to opt out of doing anything.

We could add core callback called something like disable_all() which
is called in the remove path. Alternatively the issue can be closed
in the ad_sigma_delta core by adding a callback to disable channels
in predisable().

Jonathan
 

> ---
>  drivers/iio/adc/ad7124.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 11ce6a3729a5..30299b899799 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -669,11 +669,32 @@ static const struct attribute_group ad7124_attrs_group = {
>  	.attrs = ad7124_attributes,
>  };
>  
> +static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7124_state *st = iio_priv(indio_dev);
> +	bool bit_set;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < st->num_channels; i++) {
> +		bit_set = test_bit(i, scan_mask);
> +		ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i),
> +					    AD7124_CHANNEL_EN_MSK,
> +					    AD7124_CHANNEL_EN(bit_set),
> +					    2);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  static const struct iio_info ad7124_info = {
>  	.read_raw = ad7124_read_raw,
>  	.write_raw = ad7124_write_raw,
>  	.debugfs_reg_access = &ad7124_reg_access,
>  	.validate_trigger = ad_sd_validate_trigger,
> +	.update_scan_mode = ad7124_update_scan_mode,
>  	.attrs = &ad7124_attrs_group,
>  };
>  

