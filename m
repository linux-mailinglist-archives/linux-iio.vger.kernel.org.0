Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9A6092A8
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJWM3b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJWM3a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 08:29:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FBE273D
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 05:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D6C6B8085C
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 12:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEF7C433D6;
        Sun, 23 Oct 2022 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666528165;
        bh=TDDs1cHXMpnDmygzYMXJyp3IV5gQC3ZsdkYk2W9bUE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X6DpuHVU7xC61dRlDEyVtorggXKJIGzL3p2LEkatLXdypI9zDVx38NBynmoL2ibIf
         YAl0tpZ81huNx4yjIe/gXeVLabOfARXpl1Zp5S9w6mrCd/vipCPv2UV+YNmREn4h7K
         LHKqzYJ+vmEa4eRH970JzfcwBQ2q2sSVbdCDdNQ+reHy1sYn8tcRQ7deWLcpCkqZvA
         V0gXKAFl4IB2FomuPpgKGTIbpQvIUK50cZFGbaALRitVlLcVHnh8VdjLC8itLYLq9W
         Vw1vHZ6BtGAlTilyZJF/i9QBpv6ihmqPpUFMVHgBBqalsq7lRmv8emXWzmm45CY1SH
         LhR+lBhjQD4jA==
Date:   Sun, 23 Oct 2022 13:29:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     <lars@metafoo.de>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <samuel@sholland.org>, <linux-iio@vger.kernel.org>,
        <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] iio: adc: sun4i-gpadc-iio: Fix error handle when
 devm_iio_device_register() failed in sun4i_gpadc_probe()
Message-ID: <20221023132959.662c5c4d@jic23-huawei>
In-Reply-To: <20221020124045.77678-3-zhangqilong3@huawei.com>
References: <20221020124045.77678-1-zhangqilong3@huawei.com>
        <20221020124045.77678-3-zhangqilong3@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 20 Oct 2022 20:40:45 +0800
Zhang Qilong <zhangqilong3@huawei.com> wrote:

> If devm_iio_device_register() failed, the thermal_zone may have been
> registered. So we need call thermal_zone_of_sensor_unregister() when
> CONFIG_THERMAL_OF is enabled. We fix it by adding a err_register and
> gotoing it when devm_iio_device_register() failed.

This doesn't look right.  Any devm_ registered calls should be cleaned
up automatically if we fail the probe.

However, there is an issue in what you've hightlighed here in that
on the remove path we will have ripped out the iio_map_register() before
we remove the thermal zone that is dependent on it.

Easiest fix for that is probably to use devm_iio_array_map_register()
to allow the managed handling to clean that up at the correct point.

Follow on that path you may also be able to use devm_pm_runtime_enable()
here to deal with the tear down of runtime pm (which is currently wrong
anyway as no autosuspend disable.)

Thanks,

Jonathan



> 
> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index d2535dd28af8..04717571cb2e 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -656,11 +656,17 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>  	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "could not register the device\n");
> -		goto err_map;
> +		goto err_register;
>  	}
>  
>  	return 0;
>  
> +err_register:
> +	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> +		devm_thermal_of_zone_unregister(info->sensor_device,
> +						info->tzd);
> +		info->tzd = NULL;
> +	}
>  err_map:
>  	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
>  		iio_map_array_unregister(indio_dev);

