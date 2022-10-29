Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C5561228A
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJ2LqG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJ2LqF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:46:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE76F6C976
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A914CB80B3F
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82636C433C1;
        Sat, 29 Oct 2022 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667043962;
        bh=ziN5ukN0UVpJK8FdDYCOPB4/J1Hx1aJ1qfT/GcaZhsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ptAN6Ax3YXMSNyeGd1LM1mS/itBzkUGYMz5l/HDImOVIZ8vT6/NCV2IkGWO5xEdZx
         +ewLwNr5KRmu23xLep04W1a2XMj5Kh5exoNwdt0ED1jIkLpvvuLW0VT+Q/4ZPWRULu
         2OIDd/GXG5ACiwAhJEGxECxOxfSmPnesrdYrfw+S1KygrvroHLdRTJ1w5H+WkatV+t
         y7GAeQ2ccZUgBDFOPJM5xvzdmkrvQ6OjvT92sG2+fcTpfpKAstK+690CldmyXXQAL4
         NouG5F9yZN+JP+I+Y7lFgUuI9Nv+06CObdxNQDMRhNXwlVEMs1QVX9/cdXYXHhRC81
         60SmqpkvyO2OQ==
Date:   Sat, 29 Oct 2022 12:57:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 19/23] iio: accel: mxc6255: Convert to i2c's
 .probe_new()
Message-ID: <20221029125756.48fe61ce@jic23-huawei>
In-Reply-To: <20221023132302.911644-20-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-20-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:22:58 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied

> ---
>  drivers/iio/accel/mxc6255.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
> index 9aeeadc420d3..aa2e660545f8 100644
> --- a/drivers/iio/accel/mxc6255.c
> +++ b/drivers/iio/accel/mxc6255.c
> @@ -113,8 +113,7 @@ static const struct regmap_config mxc6255_regmap_conf=
ig =3D {
>  	.readable_reg =3D mxc6255_is_readable_reg,
>  };
> =20
> -static int mxc6255_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int mxc6255_probe(struct i2c_client *client)
>  {
>  	struct mxc6255_data *data;
>  	struct iio_dev *indio_dev;
> @@ -184,7 +183,7 @@ static struct i2c_driver mxc6255_driver =3D {
>  		.name =3D MXC6255_DRV_NAME,
>  		.acpi_match_table =3D ACPI_PTR(mxc6255_acpi_match),
>  	},
> -	.probe		=3D mxc6255_probe,
> +	.probe_new	=3D mxc6255_probe,
>  	.id_table	=3D mxc6255_id,
>  };
> =20

