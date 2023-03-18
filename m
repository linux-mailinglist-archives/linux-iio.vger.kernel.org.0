Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703F16BFB7F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Mar 2023 17:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCRQXQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Mar 2023 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCRQXP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2023 12:23:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04691DBB5
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 09:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59B20B80861
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 16:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC55C433D2;
        Sat, 18 Mar 2023 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679156591;
        bh=nIQSbiUibh8ratHfMNZimLD7A+68RLLClrrpebJZOvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m94WuffTYWwT+GUIHURS8IyxDoA2wqSron60mc5rTCwdFbgHjTko4Cjz0qkBNORXN
         92RbxBqcQFkyFYGxRbmvya97ZP55FRD+NM4TV4fUh7jqg/M5YTvuu9h4ewuReE0v/y
         QTme1LkGiZjkpYBpZgMif59Eetp/c29jx9qBgRdm78ax8+vYfizBO3Cf21a5JKBO0K
         vi8mmjUAkQ20pStsSEKD7sWfvFHUF37TyE3UPPD0ubr0PTa6tmiE0zRvzO+OdziR7h
         4E0ruA4uGuWGljoX86se7UsRo5QgUDi3zQEyrW7rS7fi1i6ZyGekm/c0gujl5O9P+S
         lVvIkE5VaE6dg==
Date:   Sat, 18 Mar 2023 16:38:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] iio: frequency: admv1013: Benefit from
 devm_clk_get_enabled() to simplify
Message-ID: <20230318163804.517619e7@jic23-huawei>
In-Reply-To: <20230313185333.2776785-1-u.kleine-koenig@pengutronix.de>
References: <20230313185333.2776785-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Mar 2023 19:53:33 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Make use of devm_clk_get_enabled() to replace some code that effectively
> open codes this new function.
>=20
> To retain ordering move the request to a place that is executed later.
> This way the time of enable keeps the same.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Looks good to me.  If we were reviewing this driver for the first time
I'd be tempted to also pull the regulator get out of the
properties parsing function on basis that neither that nor this clk
retrieval are as simple as parsing the firmware.

Probably not worth making that shuffle now though - people can cope
with the small dissonance :)=20

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a poke at it.  Still time for others to comment though
as I will rebase it if any comments coming before I push it out as togreg
(probably end of next week)

Thanks,

Jonathan

> ---
> Hello,
>=20
> (implicit) v1 of this patch was part of a bigger series some time
> ago[1].
>=20
> In v1 the call to devm_clk_get_enabled() was where devm_clk_get used to
> be. Jonathan had the valid concern that this changes ordering which
> might introduce subtle regressions. Andy suggested to move the call to
> the later place.
>=20
> Best regards
> Uwe
>=20
> [1] https://lore.kernel.org/linux-iio/20220808204740.307667-11-u.kleine-k=
oenig@pengutronix.de
>=20
>  drivers/iio/frequency/admv1013.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/adm=
v1013.c
> index ed8167271358..9bf8337806fc 100644
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
> @@ -559,11 +554,6 @@ static int admv1013_properties_parse(struct admv1013=
_state *st)
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
>  				     "failed to get the common-mode voltage\n");
> =20
> -	st->clkin =3D devm_clk_get(&spi->dev, "lo_in");
> -	if (IS_ERR(st->clkin))
> -		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> -				     "failed to get the LO input clock\n");
> -
>  	return 0;
>  }
> =20
> @@ -601,13 +591,10 @@ static int admv1013_probe(struct spi_device *spi)
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
> +	st->clkin =3D devm_clk_get_enabled(&spi->dev, "lo_in");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> +				     "failed to get the LO input clock\n");
> =20
>  	st->nb.notifier_call =3D admv1013_freq_change;
>  	ret =3D devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);

