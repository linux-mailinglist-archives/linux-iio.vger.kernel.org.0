Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B056122DD
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 14:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ2MXM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ2MXM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 08:23:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5583B13FA5;
        Sat, 29 Oct 2022 05:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0BD7CE0691;
        Sat, 29 Oct 2022 12:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951CDC433D6;
        Sat, 29 Oct 2022 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667046187;
        bh=v06jAg9hAvsKxAOUy65CZ38r94S4ygiEbDbpNXiL1GE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L2QzKAw4H3p29banHYiELab6iffzHBMfhjCC5APi4Z/jUtK73EtdVvKHHjuRqBQrE
         Owx3fN1/g9tJvESSugOsUVpCl7o9JNoxnFszDoX57sNZorU0M/a7AybzH0yrANa40y
         rBHnGQkKHaqSO8fC+zjccuWtXd61aUwGFEq/DqmL/RZZRZ5QQHHkLtvy1PXzH2MVGL
         dvXv3rtVdBFgX4iIp6Vy3A9naCAeIm4gOTRaj+yOjmGK0FliQJgSHr1bbdkGWEZMs7
         OQu8kbqBaYO43nLi1ySGS48in95NcZxOxNGHoff/8xJ8ltNKeoPKTa242PX2ZRnhCB
         qtDi8IRBKThJw==
Date:   Sat, 29 Oct 2022 13:35:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 6/8] iio: adc: mp2629: restrict input voltage mask
 for mp2629
Message-ID: <20221029133503.207cfd48@jic23-huawei>
In-Reply-To: <20221029093000.45451-7-sravanhome@gmail.com>
References: <20221029093000.45451-1-sravanhome@gmail.com>
        <20221029093000.45451-7-sravanhome@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Oct 2022 11:29:58 +0200
Saravanan Sekar <sravanhome@gmail.com> wrote:

> Add support for mp2733 which is updated version of mp2629
> with a higher range of input voltage.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Hmm. this is going to slow things down wrt to this series going in.
We want the associated fix to go in during this cycle, and this
is dependant on a change going via MFD.  Ah well.

Generally I prefer to avoid using chip IDs for this sort of check
because they don't generalize as well as an actual flag for this
'feature' stored in a chip_info type structure.

However, we can tidy that up if it becomes relevant as more parts
are added to the driver.

On basis this might end up going via MFD,

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/mp2629_adc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
> index 88e947f300cf..18290e176e1e 100644
> --- a/drivers/iio/adc/mp2629_adc.c
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -66,6 +66,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
>  			int *val, int *val2, long mask)
>  {
>  	struct mp2629_adc *info = iio_priv(indio_dev);
> +	struct mp2629_data *ddata = dev_get_drvdata(info->dev);
>  	unsigned int rval;
>  	int ret;
>  
> @@ -75,8 +76,10 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
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

