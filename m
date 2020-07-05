Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC2214C51
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jul 2020 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGEMET (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jul 2020 08:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGEMET (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jul 2020 08:04:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8612D20720;
        Sun,  5 Jul 2020 12:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593950658;
        bh=xElX9DIEPWBIPNDGxqYSPWbTFAH+JqylYPH3jjP06p0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ETAWNp3GiDl1HL3EWbbtWa0geFnXEExjcnjBLZSWwm4hFos38WH5+boqIDQp3/2lh
         1r4NpWa+h9bmtw8LNTEetVNV7uYwwg6gzloBTFTRP+EPstbvznQacNP/PxylqP4dg9
         GFw0BWd5h7sRxeFduUDZG9JRcXoFhpNU+/0jr0hc=
Date:   Sun, 5 Jul 2020 13:04:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rachna@ti.com>, <mugunthanvnm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>
Subject: Re: [PATCH 1/3] iio: adc: ti_am335x_adc: alloc channels via
 devm_kcalloc()
Message-ID: <20200705130414.0aa2ac9b@archlinux>
In-Reply-To: <20200428111430.71723-1-alexandru.ardelean@analog.com>
References: <20200428111430.71723-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Apr 2020 14:14:28 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change attaches the life-cycle of the channels array to the parent
> device object that is attached to the IIO device.
> This way we can remove from the cleanup code, the explicit
> tiadc_channels_remove() which simply does a kfree() on the channels array.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Still not sure on patch 3 but I'll pick up the first 2 so we can forget
about those.

Applied to the togreg branch of iio.git and pushed out as testing for
all the usual reasons.

Thanks,

Jonathan

> ---
> 
> The reason I'm targetting this driver, is because it's among the few
> places where 'indio_dev->buffer' is accessed directly in the driver, and
> that makes it difficult to think of a sane-backwards-compatible way to
> do multiple IIO buffers.
> 
>  drivers/iio/adc/ti_am335x_adc.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 9d984f2a8ba7..d932fe383a24 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -428,7 +428,8 @@ static const char * const chan_name_ain[] = {
>  	"AIN7",
>  };
>  
> -static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
> +static int tiadc_channel_init(struct device *dev, struct iio_dev *indio_dev,
> +			      int channels)
>  {
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>  	struct iio_chan_spec *chan_array;
> @@ -436,7 +437,8 @@ static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
>  	int i;
>  
>  	indio_dev->num_channels = channels;
> -	chan_array = kcalloc(channels, sizeof(*chan_array), GFP_KERNEL);
> +	chan_array = devm_kcalloc(dev, channels, sizeof(*chan_array),
> +				  GFP_KERNEL);
>  	if (chan_array == NULL)
>  		return -ENOMEM;
>  
> @@ -459,11 +461,6 @@ static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
>  	return 0;
>  }
>  
> -static void tiadc_channels_remove(struct iio_dev *indio_dev)
> -{
> -	kfree(indio_dev->channels);
> -}
> -
>  static int tiadc_read_raw(struct iio_dev *indio_dev,
>  		struct iio_chan_spec const *chan,
>  		int *val, int *val2, long mask)
> @@ -635,7 +632,7 @@ static int tiadc_probe(struct platform_device *pdev)
>  	tiadc_writel(adc_dev, REG_FIFO1THR, FIFO1_THRESHOLD);
>  	mutex_init(&adc_dev->fifo1_lock);
>  
> -	err = tiadc_channel_init(indio_dev, adc_dev->channels);
> +	err = tiadc_channel_init(&pdev->dev, indio_dev, adc_dev->channels);
>  	if (err < 0)
>  		return err;
>  
> @@ -666,7 +663,6 @@ static int tiadc_probe(struct platform_device *pdev)
>  err_buffer_unregister:
>  	tiadc_iio_buffered_hardware_remove(indio_dev);
>  err_free_channels:
> -	tiadc_channels_remove(indio_dev);
>  	return err;
>  }
>  
> @@ -684,7 +680,6 @@ static int tiadc_remove(struct platform_device *pdev)
>  	}
>  	iio_device_unregister(indio_dev);
>  	tiadc_iio_buffered_hardware_remove(indio_dev);
> -	tiadc_channels_remove(indio_dev);
>  
>  	step_en = get_adc_step_mask(adc_dev);
>  	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);

