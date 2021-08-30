Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F853FB7D2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbhH3OVj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237015AbhH3OVi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:21:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC4DE60F23;
        Mon, 30 Aug 2021 14:20:38 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:23:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 36/40] iio: adc: ti_am335x_adc: Add the scale
 information
Message-ID: <20210830152351.175946db@jic23-huawei>
In-Reply-To: <20210825152518.379386-37-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-37-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:25:14 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Without the scale, the values returned to the user are just a picture of
> the input voltage against the full scale range of the ADC. We need to
> provide the actual conversion factor to get milli-Volts values.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Odd no one did this before, but such is life ;)

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/ti_am335x_adc.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index d4619fd6fd54..f644898b47dd 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -417,6 +417,7 @@ static int tiadc_channel_init(struct device *dev, struct iio_dev *indio_dev,
>  		chan->indexed = 1;
>  		chan->channel = adc_dev->channel_line[i];
>  		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
>  		chan->datasheet_name = chan_name_ain[chan->channel];
>  		chan->scan_index = i;
>  		chan->scan_type.sign = 'u';
> @@ -441,6 +442,23 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	unsigned long timeout;
>  	int ret;
>  
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = 1800;
> +			*val2 = chan->scan_type.realbits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	if (iio_buffer_enabled(indio_dev))
>  		return -EBUSY;
>  

