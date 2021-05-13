Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A10E37FB1E
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhEMQAT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232830AbhEMQAS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:00:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AFE9613BC;
        Thu, 13 May 2021 15:59:04 +0000 (UTC)
Date:   Thu, 13 May 2021 17:00:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: iio: cdc: ad7746: clean up driver comments
 and probe return
Message-ID: <20210513170012.78326bfa@jic23-huawei>
In-Reply-To: <687a1923add71303da13e3a838e97a6ffc7dcda7.1620766020.git.lucas.p.stankus@gmail.com>
References: <cover.1620766020.git.lucas.p.stankus@gmail.com>
        <687a1923add71303da13e3a838e97a6ffc7dcda7.1620766020.git.lucas.p.stankus@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 May 2021 17:54:01 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> Remove vague comments, align temperature comment with indent block and
> simplify probe return on device register.
> 
> Also fix the following checkpatch warning:
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>

As Fabio pointed out, finer grained patches with one type of change per
patch would be good.

> ---
>  drivers/staging/iio/cdc/ad7746.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index dfd71e99e872..e03d010b2f4c 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -84,10 +84,6 @@
>  #define AD7746_CAPDAC_DACEN		BIT(7)
>  #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
>  
> -/*
> - * struct ad7746_chip_info - chip specific information
> - */
> -
>  struct ad7746_chip_info {
>  	struct i2c_client *client;
>  	struct mutex lock; /* protect sensor state */
> @@ -232,13 +228,14 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
>  
>  		if (chip->capdac_set != chan->channel) {
>  			ret = i2c_smbus_write_byte_data(chip->client,
> -				AD7746_REG_CAPDACA,
> -				chip->capdac[chan->channel][0]);
> +							AD7746_REG_CAPDACA,
> +							chip->capdac[chan->channel][0]);
>  			if (ret < 0)
>  				return ret;
> +
>  			ret = i2c_smbus_write_byte_data(chip->client,
> -				AD7746_REG_CAPDACB,
> -				chip->capdac[chan->channel][1]);
> +							AD7746_REG_CAPDACB,
> +							chip->capdac[chan->channel][1]);
>  			if (ret < 0)
>  				return ret;

I wondered if it might be sensible to factor this code out to reduce the indent
and make things more readable.  Having taken a look it seems there is another
place with exactly the same call sequence.  From how it's used there, I'm
assuming this is updating the offsets.  As such, I would introduce an

ad7746_offsets_set(struct iio_dev *indio_dev, int channel)

or similar.


>  
> @@ -564,10 +561,10 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -		/*
> -		 * temperature in milli degrees Celsius
> -		 * T = ((*val / 2048) - 4096) * 1000
> -		 */
> +			/*
> +			 * temperature in milli degrees Celsius
> +			 * T = ((*val / 2048) - 4096) * 1000
> +			 */
>  			*val = (*val * 125) / 256;
>  			break;
>  		case IIO_VOLTAGE:
> @@ -669,10 +666,6 @@ static const struct iio_info ad7746_info = {
>  	.write_raw = ad7746_write_raw,
>  };
>  
> -/*
> - * device probe and remove
> - */
> -
>  static int ad7746_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -730,11 +723,7 @@ static int ad7746_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
>  
>  static const struct i2c_device_id ad7746_id[] = {

