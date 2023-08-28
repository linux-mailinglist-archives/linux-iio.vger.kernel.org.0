Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94FB78B0AC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjH1Mj1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 08:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjH1MjR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 08:39:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF2E5;
        Mon, 28 Aug 2023 05:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06F87646FF;
        Mon, 28 Aug 2023 12:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FC3C433C8;
        Mon, 28 Aug 2023 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693226354;
        bh=AJ/D0dSNKs2WWkqHEkyhtlNB/RFmUtCukj/4gBGXlfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qVKFNV3Dg2ayGodF9JLgDjB7/QOGFGEz1TysL0qbWNeA7QgB85aN+i02LWHZitO8J
         PiThcHdIVGBdlsh8L0zRAdU9JqyUfI21ZN6/yh6/rpnJxh4BkDEjaeJQ1YtgrzKNqn
         2FM/slyu/HcNkxuUKWTutEaxZ3gFKjdAESB7oq50loVrDUNAyrqHJn0yYEVc5kCuY/
         gnFxqMv9tM68zTlLJNJiRwKTe7QHB06ySK/eC8fjn8TN1YCxgfCCmhlIThTIXMfS/x
         5hakxJCZlJO25Ak8yJiM+W9LpmCtoHL5xYZBpsk4NxdBfS6xG4hdcf7TnerPHXdG0Q
         GwE44WhsAS6qQ==
Date:   Mon, 28 Aug 2023 13:39:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2] iio: proximity: sx9310: Convert enum->pointer for
 match data table
Message-ID: <20230828133933.1ef5145a@jic23-huawei>
In-Reply-To: <20230818175819.325663-1-biju.das.jz@bp.renesas.com>
References: <20230818175819.325663-1-biju.das.jz@bp.renesas.com>
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

On Fri, 18 Aug 2023 18:58:19 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Convert enum->pointer for data in match data table, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Add struct sx931x_info and replace enum->sx931x_info in the match table
> and simplify sx9310_check_whoami().

+CC Gwendal,

I've applied this but note there is a comment inline + there is still plenty
of time for others to comment before I push this out as non rebasing.

Thanks,

Jonathan

> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v1->v2:
>  * Replaced EINVAL->ENODEV if there is a mismatch in whoami against
>    whoami match data from device_get_match_data().
>  * Kept trailing comma for sx9310_info and sx9311_info.
>  * Added Rb tag from Andy.
> ---
>  drivers/iio/proximity/sx9310.c | 46 +++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index d977aacb7491..0d230a0dff56 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -159,6 +159,11 @@ static_assert(SX9310_NUM_CHANNELS <= SX_COMMON_MAX_NUM_CHANNELS);
>  }
>  #define SX9310_CHANNEL(idx) SX9310_NAMED_CHANNEL(idx, NULL)
>  
> +struct sx931x_info {
> +	const char *name;
> +	unsigned int whoami;
> +};
> +
>  static const struct iio_chan_spec sx9310_channels[] = {
>  	SX9310_CHANNEL(0),			/* CS0 */
>  	SX9310_CHANNEL(1),			/* CS1 */
> @@ -902,7 +907,7 @@ static int sx9310_check_whoami(struct device *dev,
>  			       struct iio_dev *indio_dev)
>  {
>  	struct sx_common_data *data = iio_priv(indio_dev);
> -	unsigned int long ddata;
> +	const struct sx931x_info *ddata;
>  	unsigned int whoami;
>  	int ret;
>  
> @@ -910,20 +915,11 @@ static int sx9310_check_whoami(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	ddata = (uintptr_t)device_get_match_data(dev);
> -	if (ddata != whoami)
> -		return -EINVAL;
> -
> -	switch (whoami) {
> -	case SX9310_WHOAMI_VALUE:
> -		indio_dev->name = "sx9310";
> -		break;
> -	case SX9311_WHOAMI_VALUE:
> -		indio_dev->name = "sx9311";
> -		break;
> -	default:
> +	ddata = device_get_match_data(dev);
> +	if (ddata->whoami != whoami)
>  		return -ENODEV;
> -	}
The original code is more strict than it should be.  To enable the use
of fallback compatibles - such that a newer device can be declared
compatible with an older device (except typically for the whoami value)
this code should at most print a dev_info() to say we are carrying on even
though we don't fully recognise the device.

It would be great to have a follow up patch make that small relaxation here.

Thanks,

Jonathan



> +
> +	indio_dev->name = ddata->name;
>  
>  	return 0;
>  }
> @@ -1015,23 +1011,33 @@ static int sx9310_resume(struct device *dev)
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
>  
> +static const struct sx931x_info sx9310_info = {
> +	.name = "sx9310",
> +	.whoami = SX9310_WHOAMI_VALUE,
> +};
> +
> +static const struct sx931x_info sx9311_info = {
> +	.name = "sx9311",
> +	.whoami = SX9311_WHOAMI_VALUE,
> +};
> +
>  static const struct acpi_device_id sx9310_acpi_match[] = {
> -	{ "STH9310", SX9310_WHOAMI_VALUE },
> -	{ "STH9311", SX9311_WHOAMI_VALUE },
> +	{ "STH9310", (kernel_ulong_t)&sx9310_info },
> +	{ "STH9311", (kernel_ulong_t)&sx9311_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
>  
>  static const struct of_device_id sx9310_of_match[] = {
> -	{ .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
> -	{ .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
> +	{ .compatible = "semtech,sx9310", &sx9310_info },
> +	{ .compatible = "semtech,sx9311", &sx9311_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sx9310_of_match);
>  
>  static const struct i2c_device_id sx9310_id[] = {
> -	{ "sx9310", SX9310_WHOAMI_VALUE },
> -	{ "sx9311", SX9311_WHOAMI_VALUE },
> +	{ "sx9310", (kernel_ulong_t)&sx9310_info },
> +	{ "sx9311", (kernel_ulong_t)&sx9311_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, sx9310_id);

