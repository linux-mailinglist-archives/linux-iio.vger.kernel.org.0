Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DE26D3100
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 15:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDANXY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjDANXY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 09:23:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150491E73D;
        Sat,  1 Apr 2023 06:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81BF6B80B4B;
        Sat,  1 Apr 2023 13:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB37BC433EF;
        Sat,  1 Apr 2023 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680355366;
        bh=Ra/4hhwYWCbPyqLnOztSvMODqSrn8z/BivmlaVY6Q7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dfEJPBrM9UHPPWBWYkNQ5cfFMSycRxXTLablSZTXNPWnzi0KyEjqzlvaE6vNkKxuz
         I3wPeZNuwPbLWfYRFdyOA+db0I8uWBuFX9luy9Uv76ArvU7qlaNlzJVkSfaUMuOcWm
         x13+fCHO6kPPUDl4B+cBJVQ4y/wmO1eFFTObGVWE9poQe0cL1t9d32kYgXl2hQGU3N
         u1h2RiHTTt/Bf41zdcRen8Ld5rvCAM8d6W/ASDTuirFRzz9cVWp/9o8hSA6Ou20Puw
         98v+n+94oGvJNlfdqZDVQtPt8mzWohjXDOagS1FlyKdgCf+S2zTep8Yb22E1fnTQlR
         bVUXq39e9yqbg==
Date:   Sat, 1 Apr 2023 14:37:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1100: fix error code in probe()
Message-ID: <20230401143754.1e561d0b@jic23-huawei>
In-Reply-To: <36fa2aeb-f392-4793-8b38-ae15514033c8@kili.mountain>
References: <36fa2aeb-f392-4793-8b38-ae15514033c8@kili.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Mar 2023 18:23:56 +0300
Dan Carpenter <error27@gmail.com> wrote:

> This code has a copy and paste bug so it accidentally returns
> "PTR_ERR(data->reg_vdd)" which is a valid pointer cast to int. It
> should return "ret" instead.
> 
> Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
Applied to the togreg branch of iio.git as this driver is not yet upstream.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads1100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index 6a478efb108b..6b5aebb82455 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -344,7 +344,7 @@ static int ads1100_probe(struct i2c_client *client)
>  
>  	ret = regulator_enable(data->reg_vdd);
>  	if (ret < 0)
> -		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
> +		return dev_err_probe(dev, ret,
>  				     "Failed to enable vdd regulator\n");
>  
>  	ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd);

