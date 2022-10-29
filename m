Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF76122D2
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 14:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ2MQl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ2MQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 08:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B3A7A777;
        Sat, 29 Oct 2022 05:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC646068A;
        Sat, 29 Oct 2022 12:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E641C433D6;
        Sat, 29 Oct 2022 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667045798;
        bh=vxktdn6+9b/lU5nRlb5QHg++ghmjLEika/pHpgj1pDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nRRO6N82uUGpjoTvQ3CK/WcTYwVnMU8Dcor3ld9oupa22g2Kss/Jw2q8uepYZ49Yw
         JdEdO8NT70VY8UZUc1vUrzw5nRYGuz629/8HISTyZo8tCgmJyBQYvAdKr1RInCFb98
         pwGfdIFAR5XdNG7lirTlhewq+zxUqk+Z52LLIlDjltIU0HhcxAW1nImdp78lQYVoZC
         Cot9Vr2sMstcyC7w9jVlXwS7kePp0CMS9+lr/4R/z1ozhSAJIf2tDG59OBCcf6ePFN
         L5eAv3SvAYJi+JS2X9YfS36eoFeAMe4DMQ7cJd6hwKVnm7a2Om5SBQWjH33Uwfkh4n
         xw4RMDUeaTBRw==
Date:   Sat, 29 Oct 2022 13:28:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/8] iio: adc: mp2629: fix wrong comparison of
 channel
Message-ID: <20221029132833.03afb95e@jic23-huawei>
In-Reply-To: <20221029093000.45451-2-sravanhome@gmail.com>
References: <20221029093000.45451-1-sravanhome@gmail.com>
        <20221029093000.45451-2-sravanhome@gmail.com>
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

On Sat, 29 Oct 2022 11:29:53 +0200
Saravanan Sekar <sravanhome@gmail.com> wrote:

> Input voltage channel enum is compared against iio address instead
> of the channel.
> 
> Fixes: 7abd9fb64682 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,
Jonathan

> ---
>  drivers/iio/adc/mp2629_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
> index 30a31f185d08..f7af9af1665d 100644
> --- a/drivers/iio/adc/mp2629_adc.c
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -74,7 +74,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		if (chan->address == MP2629_INPUT_VOLT)
> +		if (chan->channel == MP2629_INPUT_VOLT)
>  			rval &= GENMASK(6, 0);
>  		*val = rval;
>  		return IIO_VAL_INT;

