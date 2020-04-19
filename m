Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEC81AF933
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSKDl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 06:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgDSKDl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 06:03:41 -0400
Received: from ROU-LT-M43218B.mchp-main.com (amontpellier-556-1-155-96.w109-210.abo.wanadoo.fr [109.210.131.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7962321841;
        Sun, 19 Apr 2020 10:03:36 +0000 (UTC)
Date:   Sun, 19 Apr 2020 12:04:01 +0200
From:   ludovic.desroches@microchip.com
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, eugen.hristev@microchip.com
Subject: Re: [PATCH v2 2/2] iio: at91-sama5d2_adc: adjust
 iio_triggered_buffer_{predisable,postenable} positions
Message-ID: <20200419100401.cfrmeilkzzdxi4w7@ROU-LT-M43218B.mchp-main.com>
References: <20200304084219.20810-1-alexandru.ardelean@analog.com>
 <20200304084219.20810-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304084219.20810-2-alexandru.ardelean@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 04, 2020 at 10:42:19AM +0200, Alexandru Ardelean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> poll functions.
> 
> In most cases the iio_triggered_buffer_postenable() should be called first
> to attach the poll function, and then the driver can init the data to be
> triggered.
> In this case it's the other way around: the DMA code should be initialized
> before the attaching the poll function and the reverse should be done when
> un-initializing.
> 
> To make things easier when removing the iio_triggered_buffer_postenable() &
> iio_triggered_buffer_predisable() functions from the IIO core API, the DMA
> code has been moved into preenable() for init, and postdisable() for
> uninit.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 32 ++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index f2a74c47c768..2e01073d401d 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -882,7 +882,7 @@ static bool at91_adc_current_chan_is_touch(struct iio_dev *indio_dev)
>                                AT91_SAMA5D2_MAX_CHAN_IDX + 1);
>  }
> 
> -static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
> +static int at91_adc_buffer_preenable(struct iio_dev *indio_dev)
>  {
>         int ret;
>         struct at91_adc_state *st = iio_priv(indio_dev);
> @@ -902,13 +902,20 @@ static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
>                 return ret;
>         }
> 
> +       return 0;
> +}
> +
> +static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +       if (at91_adc_current_chan_is_touch(indio_dev))
> +               return 0;
> +
>         return iio_triggered_buffer_postenable(indio_dev);
>  }
> 
> -static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
> +static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
>  {
>         struct at91_adc_state *st = iio_priv(indio_dev);
> -       int ret;
>         u8 bit;
> 
>         /* check if we are disabling triggered buffer or the touchscreen */
> @@ -919,13 +926,8 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
>         if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
>                 return -EINVAL;
> 
> -       /* continue with the triggered buffer */
> -       ret = iio_triggered_buffer_predisable(indio_dev);
> -       if (ret < 0)
> -               dev_err(&indio_dev->dev, "buffer predisable failed\n");
> -
>         if (!st->dma_st.dma_chan)
> -               return ret;
> +               return 0;
> 
>         /* if we are using DMA we must clear registers and end DMA */
>         dmaengine_terminate_sync(st->dma_st.dma_chan);
> @@ -952,10 +954,20 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
> 
>         /* read overflow register to clear possible overflow status */
>         at91_adc_readl(st, AT91_SAMA5D2_OVER);
> -       return ret;
> +       return 0;
> +}
> +
> +static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +       if (at91_adc_current_chan_is_touch(indio_dev))
> +               return 0;
> +
> +       return iio_triggered_buffer_predisable(indio_dev);
>  }
> 
>  static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
> +       .preenable = &at91_adc_buffer_preenable,
> +       .postdisable = &at91_adc_buffer_postdisable,
>         .postenable = &at91_adc_buffer_postenable,
>         .predisable = &at91_adc_buffer_predisable,
>  };
> --
> 2.20.1
> 
