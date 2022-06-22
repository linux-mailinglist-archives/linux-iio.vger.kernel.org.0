Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DD554860
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jun 2022 14:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiFVJg0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jun 2022 05:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiFVJg0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2022 05:36:26 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA29D2CE0C
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 02:36:22 -0700 (PDT)
Received: from [10.0.0.163] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B09792007F;
        Wed, 22 Jun 2022 11:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1655890578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abJwlkcJdUeTkgLWft0NvFTUWFTs+iy7Yb3/QnMkpgY=;
        b=YPgDGSL0qm0hgVm6xyuEorl56DFWnl7JyVDL2bE4d8Fn2AIw2io4ewllKsRCTKZuKfeVYI
        exMCCqS17nEUGL9h5DTloU/BAt9Smg1ccuhhAFJiSRrtH1pK8LE6c9A6grH/9xy3BJmmzH
        G3DBIWn4Ytnt4Sg7Z5tMqQHCtQtThpE=
Message-ID: <839b8e54-17f0-f313-a0ca-41fd38e9569c@ixit.cz>
Date:   Wed, 22 Jun 2022 11:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 19/36] iio: light: al3010: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
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
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220621202719.13644-1-jic23@kernel.org>
 <20220621202719.13644-20-jic23@kernel.org>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <20220621202719.13644-20-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

both patches 19 and 20:

Reviewed-by: David Heidelberg <david@ixit.cz>

On 21/06/2022 22:27, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Using these newer macros allows the compiler to remove the unused
> structure and functions when !CONFIG_PM_SLEEP + removes the need to
> mark pm functions __maybe_unused.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: David Heidelberg <david@ixit.cz>
> ---
>   drivers/iio/light/al3010.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> index b4e9924094cd..ce5363845b22 100644
> --- a/drivers/iio/light/al3010.c
> +++ b/drivers/iio/light/al3010.c
> @@ -200,17 +200,17 @@ static int al3010_probe(struct i2c_client *client,
>   	return devm_iio_device_register(&client->dev, indio_dev);
>   }
>   
> -static int __maybe_unused al3010_suspend(struct device *dev)
> +static int al3010_suspend(struct device *dev)
>   {
>   	return al3010_set_pwr(to_i2c_client(dev), false);
>   }
>   
> -static int __maybe_unused al3010_resume(struct device *dev)
> +static int al3010_resume(struct device *dev)
>   {
>   	return al3010_set_pwr(to_i2c_client(dev), true);
>   }
>   
> -static SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);
>   
>   static const struct i2c_device_id al3010_id[] = {
>   	{"al3010", },
> @@ -228,7 +228,7 @@ static struct i2c_driver al3010_driver = {
>   	.driver = {
>   		.name = AL3010_DRV_NAME,
>   		.of_match_table = al3010_of_match,
> -		.pm = &al3010_pm_ops,
> +		.pm = pm_sleep_ptr(&al3010_pm_ops),
>   	},
>   	.probe		= al3010_probe,
>   	.id_table	= al3010_id,

-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

