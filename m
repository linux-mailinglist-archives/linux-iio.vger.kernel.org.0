Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC7612267
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiJ2Lbo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2Lbn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:31:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAEC6A497
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCCE9B80B71
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807C7C433C1;
        Sat, 29 Oct 2022 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667043100;
        bh=+Hzaz90i9dRZdoOudA8Xb3GpA531DUNo/G9N/snzqDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CJrWcmQ2LCZhZMTO/kXGlLc8Ax2qw7i6TONB4mbzbRyVb4YWKdUcBRaKsFRnKf2Kd
         /wnqYiz2kmOz94SM4kwZ/y1aoTg151L7IDKgHBVNMi5RTLtD2cFGjkVZpTHj45FHMD
         oKRU1kn5ZzaCSHAop20bFKjS7IJTAEB6CqlzPYhgI2hFgR+1QiBNOzPEXR0SKnA1To
         T0ywF2sw0/wAevx5Ibdp3nt8/uUj7zUXhAfNIoe3Z8dpx4NfurLDK01hYa26mEW442
         GGdXJLeyZK/rpPVzIYclJLSXEBiGvVeidoA0UG2O4Ceqh09E/d7VuQsaYBs+IE28iy
         wyupIMLWVqRdw==
Date:   Sat, 29 Oct 2022 12:43:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Wolfram Sang <wsa@kernel.org>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 01/23] iio: accel: adxl367: Convert to i2c's
 .probe_new()
Message-ID: <20221029124334.77ba60db@jic23-huawei>
In-Reply-To: <20221023132302.911644-2-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-2-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 23 Oct 2022 15:22:40 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Given many of these are completely uncontroversial, I'll pick them up
one by one and then swing back around to consider the more complex ones.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day=
 to
take a look at it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl367_i2c.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_=
i2c.c
> index 3606efa25835..070aad724abd 100644
> --- a/drivers/iio/accel/adxl367_i2c.c
> +++ b/drivers/iio/accel/adxl367_i2c.c
> @@ -41,8 +41,7 @@ static const struct adxl367_ops adxl367_i2c_ops =3D {
>  	.read_fifo =3D adxl367_i2c_read_fifo,
>  };
> =20
> -static int adxl367_i2c_probe(struct i2c_client *client,
> -			     const struct i2c_device_id *id)
> +static int adxl367_i2c_probe(struct i2c_client *client)
>  {
>  	struct adxl367_i2c_state *st;
>  	struct regmap *regmap;
> @@ -78,7 +77,7 @@ static struct i2c_driver adxl367_i2c_driver =3D {
>  		.name =3D "adxl367_i2c",
>  		.of_match_table =3D adxl367_of_match,
>  	},
> -	.probe =3D adxl367_i2c_probe,
> +	.probe_new =3D adxl367_i2c_probe,
>  	.id_table =3D adxl367_i2c_id,
>  };
> =20

