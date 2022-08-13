Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53550591C00
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 18:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiHMQ0m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 12:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiHMQ0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 12:26:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDF313F6C
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 09:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF6360F0E
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 16:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC15CC433C1;
        Sat, 13 Aug 2022 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660408000;
        bh=iD6sVeMABw6aVF4OFUq4248FhEdBlJGdEBpcpGWr1Xg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tfV+VJVKPueby0IeD94ZnXTLr4Z8eIDj1wdJlCJLjgzhzE9G2Ag0DQFjivWNkM76a
         sOifAsPDZcRqjS3vpGqZd5gz90Mza4Fc8FXwrCCpyqxUudOjTtOF246tvNUFOFgNuN
         j5cX9k+x324EVSA2jeRvL5Uz+Y9o4jt64jAz9ZoFEtgUH7OIKxxB8sIEhhmW+KpYkE
         Ee9qJ+GY+Ksg++I09wQe9QTZ6fKo/fubBf6d7eBprDhM7YPOX8jyR8LJXiMU6Dzdk2
         OyI27iU1Q2HKacPn0bRSXvyu+QphSTrFEbcdHEII3xjDSJf3TYh9tqbrUAICMzdViA
         K2fyCqwG4xKNg==
Date:   Sat, 13 Aug 2022 17:37:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 11/13] iio: frequency: admv1013: Benefit from
 devm_clk_get_enabled() to simplify
Message-ID: <20220813173706.1cb77958@jic23-huawei>
In-Reply-To: <20220808204740.307667-11-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
        <20220808204740.307667-11-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  8 Aug 2022 22:47:38 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> Make use of devm_clk_get_enabled() to replace some code that effectively
> open codes this new function.
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Looks fine to me, but there is a subtle reordering + it does even more
non parsing stuff in a function called _parse.

Anyhow, would like Antoniu or someone else from ADI to take a quick look if
possible before I pick this one up.

> ---
>  drivers/iio/frequency/admv1013.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/adm=
v1013.c
> index b0e1f6571afb..1346d77df77f 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -490,11 +490,6 @@ static int admv1013_init(struct admv1013_state *st)
>  					  st->input_mode);
>  }
> =20
> -static void admv1013_clk_disable(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static void admv1013_reg_disable(void *data)
>  {
>  	regulator_disable(data);
> @@ -559,7 +554,7 @@ static int admv1013_properties_parse(struct admv1013_=
state *st)
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
>  				     "failed to get the common-mode voltage\n");
> =20
> -	st->clkin =3D devm_clk_get(&spi->dev, "lo_in");
> +	st->clkin =3D devm_clk_get_enabled(&spi->dev, "lo_in");
>  	if (IS_ERR(st->clkin))
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
>  				     "failed to get the LO input clock\n");
> @@ -601,14 +596,6 @@ static int admv1013_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D clk_prepare_enable(st->clkin);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, admv1013_clk_disable, st->c=
lkin);
> -	if (ret)
> -		return ret;
> -
>  	st->nb.notifier_call =3D admv1013_freq_change;
>  	ret =3D devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
>  	if (ret)

