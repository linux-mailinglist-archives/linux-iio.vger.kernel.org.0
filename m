Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC19138150
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 13:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAKMND (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 07:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgAKMND (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 07:13:03 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0238F20678;
        Sat, 11 Jan 2020 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578744782;
        bh=y1sVGsHCvvcky7csTkfP58tOdqBtAuS2gr9fI7X6FTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hpZ44I+hNqAItGwG0qxUbkUP/2iDCpg8VvEEkXhqmdwpF9R2ZnhLZBjz4+0WAVELi
         f/idP3eps0JGy6gt5gyjgQNxs5XH+t3CAQmdBxmrmKoRrFrHyGhZvs5EifC5ALs1Kk
         iEBgf4Y0SmddFr+P5hvQe9Qm/QssFToXQEOWB+ig=
Date:   Sat, 11 Jan 2020 12:12:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: atlas-sensor: add helper function
 atlas_buffer_num_channels()
Message-ID: <20200111121258.522d215b@archlinux>
In-Reply-To: <20200104012908.17020-1-matt.ranostay@konsulko.com>
References: <20200104012908.17020-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Jan 2020 17:29:08 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Add helper function to detect the number of channels to output
> in trigger handler. This is based on IIO_TIMESTAMP channel being the
> delimiter between input and output channels.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/atlas-sensor.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 99095c80531b..2f0a6fed2589 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -86,6 +86,16 @@ static const struct regmap_config atlas_regmap_config = {
>  	.val_bits = 8,
>  };
>  
> +static int atlas_buffer_num_channels(const struct iio_chan_spec *spec)
> +{
> +	int idx = 0;
> +
> +	for (; spec->type != IIO_TIMESTAMP; spec++)
> +		idx++;
> +
> +	return idx;
> +};
> +
>  static const struct iio_chan_spec atlas_ph_channels[] = {
>  	{
>  		.type = IIO_PH,
> @@ -354,11 +364,12 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
>  	struct iio_poll_func *pf = private;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct atlas_data *data = iio_priv(indio_dev);
> +	int channels = atlas_buffer_num_channels(data->chip->channels);
>  	int ret;
>  
>  	ret = regmap_bulk_read(data->regmap, data->chip->data_reg,
>  			      (u8 *) &data->buffer,
> -			      sizeof(__be32) * (data->chip->num_channels - 2));
> +			      sizeof(__be32) * channels);
>  
>  	if (!ret)
>  		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,

