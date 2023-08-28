Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCB878B544
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjH1QV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 12:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjH1QV0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 12:21:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4612F;
        Mon, 28 Aug 2023 09:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85257617E8;
        Mon, 28 Aug 2023 16:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E29C433C7;
        Mon, 28 Aug 2023 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239682;
        bh=Awq66Zq2Eb/SGJZyHFDZUuO9edR+O2zgLG7NEBrFQ6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p9LDsqanasYF64wTy5CS37t7p2cVWRE9yAzkKuJPKj3NWtE4QUQ75z8b689tgVY5S
         T5UKxLWXvPunxT3WcDo9TxRMyOzedWWu2Wmqw5HMUn/c3dZlINRtwYrKn19+qTYK1P
         YDJ0PIl3KzdHyyyGZs/uHvwy53VOMQY3GWe8bjtE2ic8M2T4euHIfjKKsBgl6vwoZq
         St9+wVyEKNDJK6oATrrf/5v4PyjlDQV4xQ1TYYxB48mX84SsCHD17/OfZ+pvfUGLhU
         nUlJIJd0216cShg7fIRemWboZcszsbbQBYkjv2IpjPHG6ZA7am1yzmueOaQ/MVYrbg
         mIUG8Jb+K/zew==
Date:   Mon, 28 Aug 2023 17:21:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: ad5110: Use i2c_get_match_data()
Message-ID: <20230828172141.47f61baf@jic23-huawei>
In-Reply-To: <20230812150838.185055-1-biju.das.jz@bp.renesas.com>
References: <20230812150838.185055-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Aug 2023 16:08:38 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Replace device_get_match_data()->i2c_get_match_data by making similar I2C
> and DT-based matching table to extend matching support for ID table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Could have been a little clearer on the reasoning for doign this, but meh there
are a lot of them and this is moving things forwards.

Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiometer/ad5110.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/ad5110.c b/drivers/iio/potentiometer/ad5110.c
> index 991e745c4f93..aaf02cc7aeba 100644
> --- a/drivers/iio/potentiometer/ad5110.c
> +++ b/drivers/iio/potentiometer/ad5110.c
> @@ -278,14 +278,19 @@ static const struct of_device_id ad5110_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ad5110_of_match);
>  
> +#define AD5110_ID_TABLE(_name, cfg) {				\
> +	.name = _name,						\
> +	.driver_data = (kernel_ulong_t)&ad5110_cfg[cfg],	\
> +}
> +
>  static const struct i2c_device_id ad5110_id[] = {
> -	{ "ad5110-10", AD5110_10 },
> -	{ "ad5110-80", AD5110_80 },
> -	{ "ad5112-05", AD5112_05 },
> -	{ "ad5112-10", AD5112_10 },
> -	{ "ad5112-80", AD5112_80 },
> -	{ "ad5114-10", AD5114_10 },
> -	{ "ad5114-80", AD5114_80 },
> +	AD5110_ID_TABLE("ad5110-10", AD5110_10),
> +	AD5110_ID_TABLE("ad5110-80", AD5110_80),
> +	AD5110_ID_TABLE("ad5112-05", AD5112_05),
> +	AD5110_ID_TABLE("ad5112-10", AD5112_10),
> +	AD5110_ID_TABLE("ad5112-80", AD5112_80),
> +	AD5110_ID_TABLE("ad5114-10", AD5114_10),
> +	AD5110_ID_TABLE("ad5114-80", AD5114_80),
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5110_id);
> @@ -305,7 +310,7 @@ static int ad5110_probe(struct i2c_client *client)
>  	data->client = client;
>  	mutex_init(&data->lock);
>  	data->enable = 1;
> -	data->cfg = device_get_match_data(dev);
> +	data->cfg = i2c_get_match_data(client);
>  
>  	/* refresh RDAC register with EEPROM */
>  	ret = ad5110_write(data, AD5110_RESET, 0);

