Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC646A2F82
	for <lists+linux-iio@lfdr.de>; Sun, 26 Feb 2023 13:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBZMzD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Feb 2023 07:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBZMzC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Feb 2023 07:55:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428C768D;
        Sun, 26 Feb 2023 04:55:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 947FD60C1E;
        Sun, 26 Feb 2023 12:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA59C433D2;
        Sun, 26 Feb 2023 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677416101;
        bh=5OyhjofqlrqOOyWsorIMLFWex93Ul9g0YRiqHozDSzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Osl0uvNOBeLEGvInU0qW4GwskfpPy9TdCApHAbPX1V8VJObRprfE0y/Mx1VQzBIU3
         i3O0Rr3qFb7ll9HGmy+KW3TsykS09KyecpGV06s9JYAjl0HmLj03gHjCOt+e+6GHGQ
         dpT0FCSXcpxyoFYxGs7hHcFrWoUDfdtKiwLWAzhqQK15zZwI2+D6mHwq6rk+/qqI5o
         9kZ0wFj/EshlmOI3qzGiB+Nb6QdNHLvhJGeZpIESsAZnlaEk78mTCWdUkBj7APCqHR
         lNo5WuFlhI4tbuC/d2T2zn8luBC3BDfO0oMS69WEr9VRpt5Lij11TfwYyIUwo5Yoi/
         3nXsIT5RuskaA==
Date:   Sun, 26 Feb 2023 13:09:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v4 5/5] iio: temperature: tmp117: cosmetic alignment
 cleanup
Message-ID: <20230226130925.47a6e8d8@jic23-huawei>
In-Reply-To: <20230220122552.925216-6-m.felsch@pengutronix.de>
References: <20230220122552.925216-1-m.felsch@pengutronix.de>
        <20230220122552.925216-6-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Feb 2023 13:25:52 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Align the code correctly if possible and align the channel bit mask to
> make it easier to read.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Hi Marco,

Rest of the series looks good to me now.  We are early in the cycle, otherwise
I might just have made those tweaks suggested in patch 2 whilst applying to
make sure we didn't run out of time.  Given lots of time available I'm taking
the lazier approach and bouncing it back to you one last time!

Thanks,

Jonathan

> ---
> v4:
> - no changes
> v3:
> - no changes
> v2:
> - no changes
> 
>  drivers/iio/temperature/tmp117.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> index 4915aceb66ee2..5bc68c6392ff6 100644
> --- a/drivers/iio/temperature/tmp117.c
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -43,8 +43,8 @@ struct tmp117_data {
>  };
>  
>  static int tmp117_read_raw(struct iio_dev *indio_dev,
> -		struct iio_chan_spec const *channel, int *val,
> -		int *val2, long mask)
> +			   struct iio_chan_spec const *channel, int *val,
> +			   int *val2, long mask)
>  {
>  	struct tmp117_data *data = iio_priv(indio_dev);
>  	s32 ret;
> @@ -52,7 +52,7 @@ static int tmp117_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = i2c_smbus_read_word_swapped(data->client,
> -						TMP117_REG_TEMP);
> +						  TMP117_REG_TEMP);
>  		if (ret < 0)
>  			return ret;
>  		*val = sign_extend32(ret, 15);
> @@ -60,7 +60,7 @@ static int tmp117_read_raw(struct iio_dev *indio_dev,
>  
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		ret = i2c_smbus_read_word_swapped(data->client,
> -					TMP117_REG_TEMP_OFFSET);
> +						  TMP117_REG_TEMP_OFFSET);
>  		if (ret < 0)
>  			return ret;
>  		*val = sign_extend32(ret, 15);
> @@ -82,9 +82,8 @@ static int tmp117_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static int tmp117_write_raw(struct iio_dev *indio_dev,
> -		struct iio_chan_spec const *channel, int val,
> -		int val2, long mask)
> +static int tmp117_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
> +			    const *channel, int val, int val2, long mask)
>  {
>  	struct tmp117_data *data = iio_priv(indio_dev);
>  	s16 off;
> @@ -107,7 +106,9 @@ static const struct iio_chan_spec tmp117_channels[] = {
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_SCALE),
> +				      BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
>  };
>  
>  static const struct iio_chan_spec tmp116_channels[] = {

