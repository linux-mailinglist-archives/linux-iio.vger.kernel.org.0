Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C4D5302B3
	for <lists+linux-iio@lfdr.de>; Sun, 22 May 2022 13:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiEVLlR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 May 2022 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiEVLlQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2022 07:41:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96457E010
        for <linux-iio@vger.kernel.org>; Sun, 22 May 2022 04:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC793B80AF8
        for <linux-iio@vger.kernel.org>; Sun, 22 May 2022 11:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE46C385AA;
        Sun, 22 May 2022 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653219671;
        bh=0lgDhlSqT8+Ta5HFKYwuGbv9jgDahB+uTaog7/h2VpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BjCscAzhUt9Y8MTOQtHcpHYaqrvAc5MyMRiqBUMPDCtG7iJDfE+YJ9Ih8dm0GbANe
         nAWsbQvekDcs6R7pXybH5ccFfdVOl3SS5pKwmJ6B0+iKtnwGYc0YsK4TQ6UuDmR1R3
         ekaq97X7vnvCA+TN6bn8tp1F7kRfy0Y26B6kj1+PwC6dRejnpwM7NKbQcgcmynnuLa
         1R0OgT61UMGgXyDe0Jbaug8AuOZYVzgDeer0rXxP2rPUlK1xJOa7tJ/eSamO8Ly8GD
         mNePqOTONmcDz6PR1KlYh060zhjh/WMVBvMRckti8orCe3dmQGP2yzTzigpM6M/ZYS
         NV3K+i0GuIwaA==
Date:   Sun, 22 May 2022 12:49:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] iio:magnetometer:mbc150: Make bmc150_magn_remove()
 return void
Message-ID: <20220522124956.5e667720@jic23-huawei>
In-Reply-To: <20220514133250.307955-1-u.kleine-koenig@pengutronix.de>
References: <20220514133250.307955-1-u.kleine-koenig@pengutronix.de>
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

On Sat, 14 May 2022 15:32:50 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> bmc150_magn_remove() always returns zero. Make it return no value which
> makes it easier to see in the callers that there is no error to handle.
>=20
> Also the return value of i2c driver remove callbacks is ignored anyway.
> This prepares making i2c remove callbacks return void, too.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/bmc150_magn.c     | 3 +--
>  drivers/iio/magnetometer/bmc150_magn.h     | 2 +-
>  drivers/iio/magnetometer/bmc150_magn_i2c.c | 4 +++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magneto=
meter/bmc150_magn.c
> index 64e8b04e654b..06d5a1ef1fbd 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -985,7 +985,7 @@ int bmc150_magn_probe(struct device *dev, struct regm=
ap *regmap,
>  }
>  EXPORT_SYMBOL_NS(bmc150_magn_probe, IIO_BMC150_MAGN);
> =20
> -int bmc150_magn_remove(struct device *dev)
> +void bmc150_magn_remove(struct device *dev)
>  {
>  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>  	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> @@ -1008,7 +1008,6 @@ int bmc150_magn_remove(struct device *dev)
>  	mutex_unlock(&data->mutex);
> =20
>  	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> -	return 0;
>  }
>  EXPORT_SYMBOL_NS(bmc150_magn_remove, IIO_BMC150_MAGN);
> =20
> diff --git a/drivers/iio/magnetometer/bmc150_magn.h b/drivers/iio/magneto=
meter/bmc150_magn.h
> index 3b69232afd2c..98c086d10c13 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.h
> +++ b/drivers/iio/magnetometer/bmc150_magn.h
> @@ -7,6 +7,6 @@ extern const struct dev_pm_ops bmc150_magn_pm_ops;
> =20
>  int bmc150_magn_probe(struct device *dev, struct regmap *regmap, int irq,
>  		      const char *name);
> -int bmc150_magn_remove(struct device *dev);
> +void bmc150_magn_remove(struct device *dev);
> =20
>  #endif /* _BMC150_MAGN_H_ */
> diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/mag=
netometer/bmc150_magn_i2c.c
> index e39b89661ad1..65c004411d0f 100644
> --- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
> +++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
> @@ -36,7 +36,9 @@ static int bmc150_magn_i2c_probe(struct i2c_client *cli=
ent,
> =20
>  static int bmc150_magn_i2c_remove(struct i2c_client *client)
>  {
> -	return bmc150_magn_remove(&client->dev);
> +	bmc150_magn_remove(&client->dev);
> +
> +	return 0;
>  }
> =20
>  static const struct acpi_device_id bmc150_magn_acpi_match[] =3D {
>=20
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17

