Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD818550601
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiFRQKD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 12:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRQKC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 12:10:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560C814D2F;
        Sat, 18 Jun 2022 09:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E2D0B801B8;
        Sat, 18 Jun 2022 16:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1067DC3411A;
        Sat, 18 Jun 2022 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655568598;
        bh=LQc6Eh1kUN5gC2V1ssI+NDhWWqGMmKlZZdDmB46k1Ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SES/yU48xmmR/l2O/nLH7DhSYQanHXLqD2KHZuDSjpeBFJo4lhg+HZv2lsKN10h8L
         6PvIYydsPe141cRAdL0Y7+FLbVo7tGZOXmus8CxH/OIndk2Zt+z4qYzkc5uZegzmQK
         HWMEYjlEpi2SNsTNJCx72oZ7Qu99qoJGJRwyC2TVVaWvgVHW5URjgeTtS3rEWCwSAI
         /b+054D3gTFviskHrEKQAY01iGPKsalQOo+5kgPKaFXIVvaM7HmrbwT4nZcqbf275O
         HUdCODeP/buVxioT25IviRnzrLYXsuSNCQuEGPq2RqQUWx3lwAo36TsePsWnaKWGAa
         Xub9frXo7EWAQ==
Date:   Sat, 18 Jun 2022 17:19:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 4/6] iio: adc: mp2629: restrict input voltage mask
 for mp2629
Message-ID: <20220618171915.6951bee9@jic23-huawei>
In-Reply-To: <20220615145357.2370044-5-sravanhome@gmail.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
        <20220615145357.2370044-5-sravanhome@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jun 2022 16:53:55 +0200
Saravanan Sekar <sravanhome@gmail.com> wrote:

> Add support for mp2733 which is updated version of mp2629
> with a higher range of input voltage.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm assuming Lee will pick this up via mfd. Shout if you want
to do something else.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mp2629_adc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
> index e7fbfe92e884..28d048eefce3 100644
> --- a/drivers/iio/adc/mp2629_adc.c
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -64,6 +64,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
>  			int *val, int *val2, long mask)
>  {
>  	struct mp2629_adc *info = iio_priv(indio_dev);
> +	struct mp2629_data *ddata = dev_get_drvdata(info->dev);
>  	unsigned int rval;
>  	int ret;
>  
> @@ -73,8 +74,10 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		if (chan->channel == MP2629_INPUT_VOLT)
> +		if (chan->channel == MP2629_INPUT_VOLT &&
> +		    ddata->chip_id == CHIP_ID_MP2629)
>  			rval &= GENMASK(6, 0);
> +
>  		*val = rval;
>  		return IIO_VAL_INT;
>  

