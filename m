Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231EB673CF3
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jan 2023 16:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjASPBL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Jan 2023 10:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjASPBK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2023 10:01:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C8B298FD;
        Thu, 19 Jan 2023 07:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4240361C2F;
        Thu, 19 Jan 2023 15:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B5BC433D2;
        Thu, 19 Jan 2023 15:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674140465;
        bh=jtw/ZizwoNTsLpGN/pS2yl4aMhOQh+qg2c0Qa/WImKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjFDprlT7EJ8Nrwkz4CXAKiCBu7tVEE603oN6sj2eaMf9hWE6psoiVfycnTW01hJh
         lBzLACWXf/3WoIsz185DB2VhBUBTGB4muMGLjYmPJTq8MU0hST8paR4d2mt8j9NWmh
         3hXtSqA0eU3HKP+jkkwvrcYVi371U2FVx76BuUyf5NR+df3fQCCdPUmCmy9qWHALi5
         e14EEAVeOLgCt/b5j/c0AU7ezDJqzVjzUR+IhI+S7WdlZRqpZ+Wm10do2vQbHKuULC
         N/2xvPCmqbwNuB54YTP8WsUIgnYH/HYBynyr2G4qt90SMCUrT8SLSbF4hbdDYQgSit
         Cj4768SIUY4Ig==
Date:   Thu, 19 Jan 2023 15:00:59 +0000
From:   Lee Jones <lee@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 1/7] mfd: mp2629: fix failed to get iio channel by
 device name
Message-ID: <Y8lbKy1jjkeSHJL3@google.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
 <20221123175425.564042-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221123175425.564042-2-sravanhome@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Nov 2022, Saravanan Sekar wrote:

> The mfd cell devices name populated on sysfs entry is dynamically derived

Could you please make an attempt to capitalise words that require it?

MFD, ADC, IIO, etc.  Also the start of the subject line description.

> from an auto instance which introduced a regression. As a result
> mpc2629_charger driver failed to get adc channel because of iio consumer

How can you regress something that doesn't appear to exist?

$ git grep -i mpc2629 next/master

> name mismatch with the sysfs.

Why is the charger driver reading sysfs?

> /sys/class/i2c-adapter/i2c-1/mp2629_adc.0.auto/
> /sys/class/i2c-adapter/i2c-1/mp2629_charger.1.auto/

Can you provide an error message or some debug prints or something that
will help describe the exact issue you are facing please?
 
> Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/mfd/mp2629.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
> index 16840ec5fd1c..f4c5aa06f38c 100644
> --- a/drivers/mfd/mp2629.c
> +++ b/drivers/mfd/mp2629.c
> @@ -51,7 +51,7 @@ static int mp2629_probe(struct i2c_client *client)
>  		return PTR_ERR(ddata->regmap);
>  	}
>  
> -	ret = devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO, mp2629_cell,
> +	ret = devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_NONE, mp2629_cell,
>  				   ARRAY_SIZE(mp2629_cell), NULL, 0, NULL);
>  	if (ret)
>  		dev_err(ddata->dev, "Failed to register sub-devices %d\n", ret);
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
