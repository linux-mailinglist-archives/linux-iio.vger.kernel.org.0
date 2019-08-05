Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E0381E30
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 15:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfHENzo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 09:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbfHENzn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 09:55:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3AA2087B;
        Mon,  5 Aug 2019 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565013343;
        bh=mzybu+bDFEKhAYbK0L8pnqrYvuSkK6tBQ5/YJMZrmq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rtobr340u6jDi5lqe4nMpfdooJa0O1JO+brXW4KXyunFEeS5DV9hmGpsONTDvHyzw
         MmyJ5zQ4E0Y+MX3DTOZRDa9VHgH7hEwvs9fl7uDPXtAwWRrrBpubFiqKJ/jmt7dSXW
         2ehblUjsBgtg2uKu5YDU0VAhNouL04mbc7wrRM+k=
Date:   Mon, 5 Aug 2019 14:55:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2] iio: light: cm3323: Use device-managed APIs
Message-ID: <20190805145538.4a3561c0@archlinux>
In-Reply-To: <20190728143630.7620-1-hslester96@gmail.com>
References: <20190728143630.7620-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


+CC Daniel as this is one of his I think.

On Sun, 28 Jul 2019 22:36:30 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use device-managed APIs to simplify the code.
> The remove functions are redundant now and can
> be deleted.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Split v1 into two patches.
>   - Drop the failed to register message and just
>     return devm_iio_register.
> 
>  drivers/iio/light/cm3323.c | 33 +++++++++------------------------
>  1 file changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 50f3438c2b49..0443861ba1ec 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -101,15 +101,16 @@ static int cm3323_init(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static void cm3323_disable(struct iio_dev *indio_dev)
> +static void cm3323_disable(void *data)
>  {
>  	int ret;
> -	struct cm3323_data *data = iio_priv(indio_dev);
> +	struct iio_dev *indio_dev = data;
> +	struct cm3323_data *cm_data = iio_priv(indio_dev);
>  
> -	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
> +	ret = i2c_smbus_write_word_data(cm_data->client, CM3323_CMD_CONF,
>  					CM3323_CONF_SD_BIT);
>  	if (ret < 0)
> -		dev_err(&data->client->dev, "Error writing reg_conf\n");
> +		dev_err(&cm_data->client->dev, "Error writing reg_conf\n");
>  }
>  
>  static int cm3323_set_it_bits(struct cm3323_data *data, int val, int val2)
> @@ -243,26 +244,11 @@ static int cm3323_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "failed to register iio dev\n");
> -		goto err_init;
> -	}
> -
> -	return 0;
> -err_init:
> -	cm3323_disable(indio_dev);
> -	return ret;
> -}
> -
> -static int cm3323_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	cm3323_disable(indio_dev);
> +	ret = devm_add_action_or_reset(&client->dev, cm3323_disable, indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct i2c_device_id cm3323_id[] = {
> @@ -276,7 +262,6 @@ static struct i2c_driver cm3323_driver = {
>  		.name = CM3323_DRV_NAME,
>  	},
>  	.probe		= cm3323_probe,
> -	.remove		= cm3323_remove,
>  	.id_table	= cm3323_id,
>  };
>  

