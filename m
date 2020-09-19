Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE1C270ECA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgISPOo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 11:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgISPOo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 11:14:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 527842098B;
        Sat, 19 Sep 2020 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600528483;
        bh=zP8Pa38cTNoem5fU+XzQBXZ+YfedHS0wIZJdarVDrUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xUhA/rgcIjgaNupVjczPNhAIbsTj7s8d53STO50rzbjkA9a29CYOPxdFoX4D34lZv
         6UVeEkPZS67mddp6xyj7deYa8M20f49FvepHxAccl8Oukr5Ycok8JJ5gXr3hinI8nu
         6i3Tyo7oF53JC6oNr6y5zBrDhtrmmR7TlnLTQnQA=
Date:   Sat, 19 Sep 2020 16:14:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: adc: ad7768-1: Add channel label example
Message-ID: <20200919161440.2cb17583@archlinux>
In-Reply-To: <20200918093356.93670-1-cristian.pop@analog.com>
References: <20200918093356.93670-1-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 12:33:56 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

> This is a demo usage of new "label" attribute for channel.
While I can see this is a demo in someways, I assume we also have
a valid usecase for doing this beyond as a demo!

So perhaps rephrase that intro.

> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> Changes in V5:
> Create a separate patch file for this commit
>  drivers/iio/adc/ad7768-1.c | 49 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 0d132708c429..5ca9f9febb5a 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -161,6 +161,7 @@ struct ad7768_state {
>  	struct completion completion;
>  	struct iio_trigger *trig;
>  	struct gpio_desc *gpio_sync_in;
> +	const char **labels;
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -407,6 +408,14 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int ad7768_read_label(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, char *label)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(label, "%s\n", st->labels[chan->channel]);
> +}
> +
>  static struct attribute *ad7768_attributes[] = {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL
> @@ -420,6 +429,7 @@ static const struct iio_info ad7768_info = {
>  	.attrs = &ad7768_group,
>  	.read_raw = &ad7768_read_raw,
>  	.write_raw = &ad7768_write_raw,
> +	.read_label = ad7768_read_label,
>  	.debugfs_reg_access = &ad7768_reg_access,
>  };
>  
> @@ -538,6 +548,41 @@ static void ad7768_clk_disable(void *data)
>  	clk_disable_unprepare(st->mclk);
>  }
>  
> +static int ad7768_set_channel_label(struct iio_dev *indio_dev,
> +						int num_channels)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	struct device *device = indio_dev->dev.parent;
> +	struct fwnode_handle *fwnode;
> +	struct fwnode_handle *child;
> +	const char *label;
> +	int crt_ch = 0;
> +
> +	st->labels = devm_kcalloc(indio_dev->dev.parent,
> +					num_channels,
> +					sizeof(**st->labels),

I think that ends up being the size of a single character which isn't
the intent.  I assume aim is a suitable sized array of pointers to
strings which we will fill in later?

If so we can probably just use a static sized array as the maximum
number of channels is well constrained.  In this particular driver
that is 1 I think!

> +					GFP_KERNEL);
> +
> +	if (!st->labels)
> +		return -ENOMEM;
> +
> +	fwnode = dev_fwnode(device);
> +	fwnode_for_each_child_node(fwnode, child) {
> +		if (fwnode_property_read_u32(child, "reg", &crt_ch))
> +			continue;
> +
> +		if (crt_ch >= num_channels)
> +			continue;
> +
> +		if (fwnode_property_read_string(child, "label", &label))
> +			continue;
> +
> +		st->labels[crt_ch] = label;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ad7768_probe(struct spi_device *spi)
>  {
>  	struct ad7768_state *st;
> @@ -611,6 +656,10 @@ static int ad7768_probe(struct spi_device *spi)
>  
>  	init_completion(&st->completion);
>  
> +	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_request_irq(&spi->dev, spi->irq,
>  			       &ad7768_interrupt,
>  			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,

