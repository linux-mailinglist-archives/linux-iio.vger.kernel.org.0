Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE35BBF27
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 19:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIRRdt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRRds (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 13:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA313EBF
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 10:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CD9461165
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 17:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B741BC433C1;
        Sun, 18 Sep 2022 17:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663522426;
        bh=vqn/8JdolGCqvEmVc+QKT9pOJ+MSJu8xIFtzK6wOyro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IfJ1RmjoDP8MjidrkcyPZ58ppHshN8Z3C3R0HRxVOefDGANViQPwMI7rDAyfp19/3
         RKf/XtS40V1oDgvl0D6tin+qt+lrYTIb3k7/SucbA8R29GWydb1FfskA1zl6rCdJzR
         OA5uGu3BwZ45SLv2Z1kQVW1RXpeQleAqGLVRgR92oqyZhPDbhNPo+W7/CMvADC5d3J
         Cm2pNizHw180FjYYl4txSQaA2w/IlIQrRC64Ya3fLoO5Y7ic3mxcUu5yFkucBrjbdG
         ry1HPBpU3fLXOmczLfI7wXzsMPUXiC+n9uED1BSLijnYN/ST5BNCwbyVinFV5F1XaN
         +7uCKfisx49AA==
Date:   Sun, 18 Sep 2022 18:33:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/6] iio: proximity: sx9310: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Message-ID: <20220918183350.7cbc5cdf@jic23-huawei>
In-Reply-To: <20220807185618.1038812-2-jic23@kernel.org>
References: <20220807185618.1038812-1-jic23@kernel.org>
        <20220807185618.1038812-2-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun,  7 Aug 2022 19:56:13 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These new macros avoid the need for marking the callbacks __maybe_unused
> whilst ensuring both callbacks and structure may be dropped by the compiler
> if CONFIG_PM_SLEEP is not enabled.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
Applied

> ---
>  drivers/iio/proximity/sx9310.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index ea7318b508ea..0e4747ccd3cf 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -965,7 +965,7 @@ static int sx9310_probe(struct i2c_client *client)
>  	return sx_common_probe(client, &sx9310_chip_info, &sx9310_regmap_config);
>  }
>  
> -static int __maybe_unused sx9310_suspend(struct device *dev)
> +static int sx9310_suspend(struct device *dev)
>  {
>  	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
>  	u8 ctrl0;
> @@ -991,7 +991,7 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int __maybe_unused sx9310_resume(struct device *dev)
> +static int sx9310_resume(struct device *dev)
>  {
>  	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
>  	int ret;
> @@ -1013,7 +1013,7 @@ static int __maybe_unused sx9310_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
>  
>  static const struct acpi_device_id sx9310_acpi_match[] = {
>  	{ "STH9310", SX9310_WHOAMI_VALUE },
> @@ -1041,7 +1041,7 @@ static struct i2c_driver sx9310_driver = {
>  		.name	= "sx9310",
>  		.acpi_match_table = sx9310_acpi_match,
>  		.of_match_table = sx9310_of_match,
> -		.pm = &sx9310_pm_ops,
> +		.pm = pm_sleep_ptr(&sx9310_pm_ops),
>  
>  		/*
>  		 * Lots of i2c transfers in probe + over 200 ms waiting in

