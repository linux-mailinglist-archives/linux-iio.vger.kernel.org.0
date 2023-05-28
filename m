Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19776713A60
	for <lists+linux-iio@lfdr.de>; Sun, 28 May 2023 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjE1P2o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 May 2023 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1P2o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 May 2023 11:28:44 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77414AD
        for <linux-iio@vger.kernel.org>; Sun, 28 May 2023 08:28:42 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3IJtqzpl48SAU3IJtq75ZH; Sun, 28 May 2023 17:28:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685287720;
        bh=Aqf/4KXF2oQD4nKK6+nOSSnNPWs18SjhF6G/3g0pnj0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VTIvRMsioGuUp0O6b/GZBi/o7kCa/w9YnRyL3BvPp3dcvQdGT+g9VB67/Jfwr0TAG
         CjTqowIH/ooWbj4u2VWWllV1kJZh5zJgDbSD2aifrdpgXsnIrFJNupTepul2ONdkNg
         p5nz0hyMH9/u9T4bwHmBqP+NQX3s4tc+8p1TKbZt49ytg0UygwKeFWEkVOI+8LKeJR
         LLT8H4XYyc8RuyQeLa2ecQWeXNkKLjrsRjd9zNfWeZvmmdZS8Jwi/iyhxMAh0SIxx8
         Y5z3CWFgHXPFf0NCCAzZ9NhKOUsZW7DqeI6N9254YIs0OG8HjrZ1kfkRSSg2irr1LX
         +p6FxWVHYdKXg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 May 2023 17:28:40 +0200
X-ME-IP: 86.243.2.178
Message-ID: <4a00de86-a6a8-2970-ac88-40fc1cb8b405@wanadoo.fr>
Date:   Sun, 28 May 2023 17:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v1 1/4] iio: adc: Add Allwinner D1/T113s/R329 SoCs
 GPADC
Content-Language: fr
To:     Maxim Kiselev <bigunclemax@gmail.com>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
 <20230524082744.3215427-2-bigunclemax@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230524082744.3215427-2-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le 24/05/2023 à 10:27, Maxim Kiselev a écrit :
> The General Purpose ADC (GPADC) can convert the external signal into
> a certain proportion of digital value, to realize the measurement of
> analog signal, which can be applied to power detection and key detection.
> 
> D1, T113s and R329 contain this GPADC IP. The only difference between
> this SoCs is the number of available channels:
> 
>   T113 - 1 channel
>   D1   - 2 channels
>   R329 - 4 channels
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> ---

[...]

> +	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
> +				     "failed to get reset control\n");
> +
> +	ret = reset_control_deassert(rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				    "failed to deassert reset\n");

Should there be a reset_control_assert() somewhere?

> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(&pdev->dev, irq, "failed to get irq\n");
> +
[...]

