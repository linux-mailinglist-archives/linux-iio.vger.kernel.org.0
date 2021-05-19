Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9822B3886CA
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 07:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhESFlL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 May 2021 01:41:11 -0400
Received: from first.geanix.com ([116.203.34.67]:49378 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345018AbhESFiy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 May 2021 01:38:54 -0400
Received: from [192.168.64.199] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 00271468010;
        Wed, 19 May 2021 05:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1621402637; bh=5bJTRIEGZKGTs+SrBoeiU/TKFA8eRT3CF1vLgc9jO2s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VgNjrXqKjVUoUjI3n8/QoX0/geCwka07Vx5TGg8DXVWxg8A+jt1cRIg21C2sa1lbU
         HumkM1pHvbkHkgRF+pYn1zOcwpCTlINJ5ZqzujZ822+86jIyKxnoG5fhSdDmB1Y1c6
         nwVkvytgRe5puT+l9u7jhhC8pACBGvAwQTP/it3nnNviYJCAbBsy2KiHTx193zh9CC
         ZyUTJ84EXdFRsXIb/jj9f0gNrU/bh5OHp6MWRhPFirRBPMnV7ziip80neKMFDtQ9rE
         qfub7N9UiwKbL2NRwz6EYFUSVjSYH5jI2rT9/fSmFu3RR151xGaE7LTa3NDfKQD6B8
         Lb3SUXTOKJ0Eg==
Subject: Re: [PATCH] iio: accel: fxls8962af: conditionally compile
 fxls8962af_i2c_raw_read_errata3()
To:     trix@redhat.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210518234828.1930387-1-trix@redhat.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <a3329058-2b2d-415a-5d2a-0bdf2f97d23d@geanix.com>
Date:   Wed, 19 May 2021 07:37:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518234828.1930387-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 19/05/2021 01.48, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The build is failing with this link error
> ld: fxls8962af-core.o: in function `fxls8962af_fifo_transfer':
> fxls8962af-core.c: undefined reference to `i2c_verify_client'
> 
> This is needed for the i2c variant, not the spi variant. So
> conditionally compile based on CONFIG_FXLS8962AF_I2C.
> 
Fixes: 68068fad0e1c ("iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads")
> Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/accel/fxls8962af-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 9fe5a18a605cc..b6d833e2058c8 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -624,6 +624,7 @@ static const struct iio_buffer_setup_ops fxls8962af_buffer_ops = {
>  	.postdisable = fxls8962af_buffer_postdisable,
>  };
>  
> +#if IS_ENABLED(CONFIG_FXLS8962AF_I2C)
>  static int fxls8962af_i2c_raw_read_errata3(struct fxls8962af_data *data,
>  					   u16 *buffer, int samples,
>  					   int sample_length)
> @@ -639,6 +640,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct fxls8962af_data *data,
>  
>  	return ret;
>  }
> +#endif
>  
>  static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
>  				    u16 *buffer, int samples)
> @@ -648,6 +650,7 @@ static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
>  	int total_length = samples * sample_length;
>  	int ret;
>  
> +#if IS_ENABLED(CONFIG_FXLS8962AF_I2C)
>  	if (i2c_verify_client(dev))
>  		/*
>  		 * Due to errata bug:
> @@ -657,6 +660,7 @@ static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
>  		ret = fxls8962af_i2c_raw_read_errata3(data, buffer, samples,
>  						      sample_length);
>  	else
> +#endif
>  		ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
>  				      total_length);
>  
> 

