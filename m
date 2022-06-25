Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1352B55AA39
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiFYM4p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiFYM4o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 08:56:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E9018385
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 05:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33AB6B8090B
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 12:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F328CC341C6;
        Sat, 25 Jun 2022 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656161801;
        bh=aJL/VSRFnRWX6erZu8diBm70Cl3kWhJFpbOLPj5tSA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gyESkeQ5A1G4yPaX4gQJXy+19T+Fa4I5vqs9J/yHJQ1vsRfp6w81e4TF0IvFn+wKU
         2l96W/ZeGb1/+qQ70/+Ob8HrSNn5qt8SBKs7FXqhuLRohrhile0EDQ3lIKyQdqDMvh
         5gv1hO5TV9tAosftNU/1wzCgr5xH9JFGGhciVVAvDdncWdH037N0BhzjfMPB0eGLug
         0Jb9FB8UYQAFrIU00cHaws37BemoTfjbtY/2gQTslzLhz2GyGLlmvfv9vnQMICofOm
         DL+zlUKmcYXnnOiwIVp+S1/Toc1S7WcxQyy5ve7YKgMImA+QMTktnE5mCXYdiWZc33
         iO4uGpOVussGQ==
Date:   Sat, 25 Jun 2022 14:06:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 20/36] iio: light: al3320a: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Message-ID: <20220625140602.1d6967c2@jic23-huawei>
In-Reply-To: <20220621202719.13644-21-jic23@kernel.org>
References: <20220621202719.13644-1-jic23@kernel.org>
        <20220621202719.13644-21-jic23@kernel.org>
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

On Tue, 21 Jun 2022 21:27:03 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Using these newer macros allows the compiler to remove the unused
> structure and functions when !CONFIG_PM_SLEEP + removes the need to
> mark pm functions __maybe_unused.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: David Heidelberg <david@ixit.cz>
I'll just copy this here from reply to patch 19 so b4 will do
everything automatically for me. 

both patches 19 and 20:

Reviewed-by: David Heidelberg <david@ixit.cz>

> ---
>  drivers/iio/light/al3320a.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index cc1407ccc10a..bc99179728ed 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -223,17 +223,18 @@ static int al3320a_probe(struct i2c_client *client,
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> -static int __maybe_unused al3320a_suspend(struct device *dev)
> +static int al3320a_suspend(struct device *dev)
>  {
>  	return al3320a_set_pwr(to_i2c_client(dev), false);
>  }
>  
> -static int __maybe_unused al3320a_resume(struct device *dev)
> +static int al3320a_resume(struct device *dev)
>  {
>  	return al3320a_set_pwr(to_i2c_client(dev), true);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend, al3320a_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend,
> +				al3320a_resume);
>  
>  static const struct i2c_device_id al3320a_id[] = {
>  	{"al3320a", 0},
> @@ -251,7 +252,7 @@ static struct i2c_driver al3320a_driver = {
>  	.driver = {
>  		.name = AL3320A_DRV_NAME,
>  		.of_match_table = al3320a_of_match,
> -		.pm = &al3320a_pm_ops,
> +		.pm = pm_sleep_ptr(&al3320a_pm_ops),
>  	},
>  	.probe		= al3320a_probe,
>  	.id_table	= al3320a_id,

