Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF9550575
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiFROMc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiFROMY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 10:12:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A84217E23;
        Sat, 18 Jun 2022 07:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BB6DB802C7;
        Sat, 18 Jun 2022 14:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F52EC3411A;
        Sat, 18 Jun 2022 14:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655561540;
        bh=psM6drmWISqaLG1yD9nvqEE5SBtQuHMteerZ+w778sk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EEFQAa06XJRwywULvTdYLm8vhq8cjk/K9agQ2xq2TJyUsJ5Es2k3/NfjjFTXbrHYh
         3PkDE3/ghwb6wKY1/nsutc6OVnei5PW0+/1mN8OiYHu94+g5kBJJ3KTauMnsU85xcy
         V5KcH++Ipnl4PPN4zsen7EMgEVqGAV1N6hXcN50SZLbaDh7MKLhAtSYnuKhCuABTvW
         n6ujxwyh0UVKpX42sX73LeiifVBSHR5RLY8ZdX8bl09HD0RgQsYXEXKb0CANuTh0RY
         J41pjuc8NkVFX7cbPkTiWu4pmRBw1G5V+Z/RzoEIgDb8KXEjiqXrYq09hjcEM05EK6
         rmi/CgT3EEJYg==
Date:   Sat, 18 Jun 2022 15:21:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 2/8] iio: magnetometer: yas530: Change range of data
 in volatile register
Message-ID: <20220618152137.59de13fb@jic23-huawei>
In-Reply-To: <bd9cd1d425afc07cd9939e4b41ada39a9ca350b4.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
        <bd9cd1d425afc07cd9939e4b41ada39a9ca350b4.1655509425.git.jahau@rocketmail.com>
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

On Sat, 18 Jun 2022 02:13:10 +0200
Jakob Hauser <jahau@rocketmail.com> wrote:

> In function yas5xx_volatile_reg(), the range for measure data should end at
> "YAS5XX_MEASURE_DATA + 7" instead of "+ 8" as we count from 0 to 7 here.
> 
> This change is of low importance as the "+ 8" register isn't called.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>

Drop the Cc now you have an RB from Linus.

> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index 40192aa46b04..2799ae0784fd 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -527,7 +527,7 @@ static bool yas5xx_volatile_reg(struct device *dev, unsigned int reg)
>  {
>  	return reg == YAS5XX_ACTUATE_INIT_COIL ||
>  		reg == YAS5XX_MEASURE ||
> -		(reg >= YAS5XX_MEASURE_DATA && reg <= YAS5XX_MEASURE_DATA + 8);
> +		(reg >= YAS5XX_MEASURE_DATA && reg <= YAS5XX_MEASURE_DATA + 7);
trivial, but I'd prefer it as
reg < RAS5XX_MEASURE_DATA + 8
because we have 8 registers and do bulk reads of sizeof(u8[8]) so it is more natural
to use 8 as the constant.


>  }
>  
>  /* TODO: enable regmap cache, using mark dirty and sync at runtime resume */

