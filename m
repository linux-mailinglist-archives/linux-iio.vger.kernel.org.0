Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC614172C
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 12:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgARLSW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 06:18:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgARLSW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 06:18:22 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFDC32468B;
        Sat, 18 Jan 2020 11:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579346301;
        bh=8VwY+FeNaHDSZkR/EGAKvPjztnT+yD2Sz/QaUPWbryM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v3Twrj1/9vzr3FsU2vRkcBYVoakgd2Oxof3gGUhw4uHDNF7cp6oExcSORRWlOo/6Y
         SUrezceMGg0JweGb5sXK9TNIa9BeXyCRW7Mq9+raxXD+Iud/odnL/LbfW2XKUmFKjV
         Wl3TSodJrhC4ruE9WKKTolgKLkJ5F0/Y1UCKnXsI=
Date:   Sat, 18 Jan 2020 11:18:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 V3] iio: adc: ad-sigma-delta: Allow custom IRQ flags
Message-ID: <20200118111817.71cd8a63@archlinux>
In-Reply-To: <20200113102653.20900-2-alexandru.tachici@analog.com>
References: <20200111112317.1cf2d878@archlinux>
        <20200113102653.20900-1-alexandru.tachici@analog.com>
        <20200113102653.20900-2-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 12:26:52 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Before this patch the ad_sigma_delta implementation hardcoded
> the irq trigger type to low, assuming that all Sigma-Delta ADCs
> have the same interrupt-type.
> 
> This patch allows all drivers using the ad_sigma_delta layer to set the
> irq trigger type to the one specified in the datasheet.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

Now, as neither of these has a fixes tag, I've taken them in the
togreg branch of iio.git.  If you want them backported to stable,
one they are in Linus's tree you can send a specific message to
request they are applied.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7124.c               | 2 ++
>  drivers/iio/adc/ad7780.c               | 1 +
>  drivers/iio/adc/ad7791.c               | 1 +
>  drivers/iio/adc/ad7793.c               | 1 +
>  drivers/iio/adc/ad_sigma_delta.c       | 2 +-
>  include/linux/iio/adc/ad_sigma_delta.h | 2 ++
>  6 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index edc6f1cc90b2..9531d8a6cb27 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> @@ -222,6 +223,7 @@ static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
>  	.addr_shift = 0,
>  	.read_mask = BIT(6),
>  	.data_reg = AD7124_DATA,
> +	.irq_flags = IRQF_TRIGGER_LOW,
>  };
>  
>  static int ad7124_set_channel_odr(struct ad7124_state *st,
> diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
> index 217a5a5c3c6d..291c1a898129 100644
> --- a/drivers/iio/adc/ad7780.c
> +++ b/drivers/iio/adc/ad7780.c
> @@ -203,6 +203,7 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
>  	.set_mode = ad7780_set_mode,
>  	.postprocess_sample = ad7780_postprocess_sample,
>  	.has_registers = false,
> +	.irq_flags = IRQF_TRIGGER_LOW,
>  };
>  
>  #define AD7780_CHANNEL(bits, wordsize) \
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index 54025ea10239..abb239392631 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -205,6 +205,7 @@ static const struct ad_sigma_delta_info ad7791_sigma_delta_info = {
>  	.has_registers = true,
>  	.addr_shift = 4,
>  	.read_mask = BIT(3),
> +	.irq_flags = IRQF_TRIGGER_LOW,
>  };
>  
>  static int ad7791_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index bbc41ecf0d2f..b747db97f78a 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -206,6 +206,7 @@ static const struct ad_sigma_delta_info ad7793_sigma_delta_info = {
>  	.has_registers = true,
>  	.addr_shift = 3,
>  	.read_mask = BIT(6),
> +	.irq_flags = IRQF_TRIGGER_LOW,
>  };
>  
>  static const struct ad_sd_calib_data ad7793_calib_arr[6] = {
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 8ba90486c787..8115b6de1d6c 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -500,7 +500,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
>  
>  	ret = request_irq(sigma_delta->spi->irq,
>  			  ad_sd_data_rdy_trig_poll,
> -			  IRQF_TRIGGER_LOW,
> +			  sigma_delta->info->irq_flags,
>  			  indio_dev->name,
>  			  sigma_delta);
>  	if (ret)
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 8a4e25a7080c..5a127c0ed200 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -40,6 +40,7 @@ struct iio_dev;
>   * @read_mask: Mask for the communications register having the read bit set.
>   * @data_reg: Address of the data register, if 0 the default address of 0x3 will
>   *   be used.
> + * @irq_flags: flags for the interrupt used by the triggered buffer
>   */
>  struct ad_sigma_delta_info {
>  	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
> @@ -49,6 +50,7 @@ struct ad_sigma_delta_info {
>  	unsigned int addr_shift;
>  	unsigned int read_mask;
>  	unsigned int data_reg;
> +	unsigned long irq_flags;
>  };
>  
>  /**

