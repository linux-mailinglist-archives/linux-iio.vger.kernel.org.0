Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B011E138117
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 12:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgAKLXX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 06:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729517AbgAKLXX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 06:23:23 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839D320848;
        Sat, 11 Jan 2020 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578741802;
        bh=iv+opu/8ILwPL72sR/xt6cuOHbjVcLdweIxvjH8r9Fg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xam88gtmyR+tp8uwOooLp1xVqz/KFV6+TStVUG3VjEKKDxH063RMnNqJJ9SKA5/CC
         TWWveOnWtLgVoyZvd/cOyQicUq4eii0DyLxwuDw08gAq/UZFjhee49JNKEwoKwEtyM
         VhcFLbWvoKQHoR/ilodrXRsd8LRL0PtdD6bLLZoQ=
Date:   Sat, 11 Jan 2020 11:23:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] iio: ad_sigma_delta: Add custom irq flags
Message-ID: <20200111112317.1cf2d878@archlinux>
In-Reply-To: <20200107110636.28834-1-alexandru.tachici@analog.com>
References: <20200106105747.8244-1-alexandru.tachici@analog.com>
        <20200107110636.28834-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Jan 2020 13:06:36 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> The data-sheet of AD7124, from the Sigma-Delta ADC family,
> recommends that the falling edge of the DOUT line should be used for
> an interrupt.
> 
> The ad_sigma_delta implementation hardcodes the irq trigger type
> to low, assuming that all Sigma-Delta ADCs have the same interrupt-type.
> This causes unwanted behaviour. If DOUT line is already low, the
> interrupt will fire once, when enabled and the irq handler will send a
> read request to the device. At this time the device has not yet finished
> the previous conversion and will give a bad reading.
> 
> This patch allows drivers using the ad_sigma_delta layer to set the
> irq trigger type to the one specified in the corresponding data-sheet.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

Hi Alexandru.

Patch is fine, but I'd expect to see it in a series with the change
for the ad7124 driver.  I'm never keen to merge new features without
a user.  So send a v3, with the change to that driver (which I'm guessing
is pretty trivial!)

Thanks,

Jonathan

> ---
> Changelog V1-V2:
>  - added a V2 tag
> 
>  drivers/iio/adc/ad_sigma_delta.c       | 9 ++++++++-
>  include/linux/iio/adc/ad_sigma_delta.h | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index d10bd0c97233..0007df8d50fb 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -454,7 +454,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
>  
>  	ret = request_irq(sigma_delta->spi->irq,
>  			  ad_sd_data_rdy_trig_poll,
> -			  IRQF_TRIGGER_LOW,
> +			  sigma_delta->irq_flags,
>  			  indio_dev->name,
>  			  sigma_delta);
>  	if (ret)
> @@ -540,8 +540,15 @@ EXPORT_SYMBOL_GPL(ad_sd_cleanup_buffer_and_trigger);
>  int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
>  	struct spi_device *spi, const struct ad_sigma_delta_info *info)
>  {
> +	unsigned long set_trigger_flags;
> +
>  	sigma_delta->spi = spi;
>  	sigma_delta->info = info;
> +
> +	set_trigger_flags = sigma_delta->irq_flags & IRQF_TRIGGER_MASK;
> +	if (set_trigger_flags == IRQF_TRIGGER_NONE)
> +		sigma_delta->irq_flags |= IRQF_TRIGGER_LOW;
> +
>  	iio_device_set_drvdata(indio_dev, sigma_delta);
>  
>  	return 0;
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 5ba430cc9a87..94a91731c8e8 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -53,6 +53,7 @@ struct ad_sigma_delta_info {
>   * struct ad_sigma_delta - Sigma Delta device struct
>   * @spi: The spi device associated with the Sigma Delta device.
>   * @trig: The IIO trigger associated with the Sigma Delta device.
> + * @irq_flags: flags for the interrupt used by the triggered buffer
>   *
>   * Most of the fields are private to the sigma delta library code and should not
>   * be accessed by individual drivers.
> @@ -60,6 +61,7 @@ struct ad_sigma_delta_info {
>  struct ad_sigma_delta {
>  	struct spi_device	*spi;
>  	struct iio_trigger	*trig;
> +	unsigned long		irq_flags;
>  
>  /* private: */
>  	struct completion	completion;

