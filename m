Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB96122D7
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 14:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ2MSh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 08:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ2MSg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 08:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CBD7B1CF;
        Sat, 29 Oct 2022 05:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4B7A6069C;
        Sat, 29 Oct 2022 12:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F544C433C1;
        Sat, 29 Oct 2022 12:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667045915;
        bh=De41F2BFGdJ0NGn/5FDHPBJAObUgVSu1luiFi/IMYGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lK+qmrirlAH+Yg8AJvcZdaZRnxdPPnX8So3UGCGSk+QUxICfKdkJMhN9v+PAF0weH
         76g8r8WYWU955JEpDv1T9/TjKjG+pcyETDaZfyQLJqbg9d67kGQmaSDHO30R4rrQm3
         RC8mLoQoLW7DC6Jq1dOwid2OqLJLCEkuM2fROqgn6Kmg3DktUlaGGehtEX0phWNPBW
         ksSXkl+ZnjcqLt9g4U9RFoIQy6WXbxgihk1nI+vgQEcHfwCrp0mZNi9KogwHO4wiwj
         cSLqQ7tCNd0BoFabZzdQZyMO76nVFdiFYrfsZsuBVxtehLdQSfqLIOZg0d87LYxEWe
         +HGbhJSRP483A==
Date:   Sat, 29 Oct 2022 13:30:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 3/8] iio: adc: mp2629: fix potential array out of
 bound access
Message-ID: <20221029133029.7e22973c@jic23-huawei>
In-Reply-To: <20221029093000.45451-4-sravanhome@gmail.com>
References: <20221029093000.45451-1-sravanhome@gmail.com>
        <20221029093000.45451-4-sravanhome@gmail.com>
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

On Sat, 29 Oct 2022 11:29:55 +0200
Saravanan Sekar <sravanhome@gmail.com> wrote:

> Add sentinel at end of maps to avoid potential array out of
> bound access in iio core.
> 
> Fixes: 7abd9fb6468 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mp2629_adc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
> index f7af9af1665d..88e947f300cf 100644
> --- a/drivers/iio/adc/mp2629_adc.c
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -57,7 +57,8 @@ static struct iio_map mp2629_adc_maps[] = {
>  	MP2629_MAP(SYSTEM_VOLT, "system-volt"),
>  	MP2629_MAP(INPUT_VOLT, "input-volt"),
>  	MP2629_MAP(BATT_CURRENT, "batt-current"),
> -	MP2629_MAP(INPUT_CURRENT, "input-current")
> +	MP2629_MAP(INPUT_CURRENT, "input-current"),
> +	{ }
>  };
>  
>  static int mp2629_read_raw(struct iio_dev *indio_dev,

