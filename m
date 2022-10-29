Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A70D612286
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ2Lop (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJ2Lop (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D2EB1EE
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898C160C97
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CA1C433C1;
        Sat, 29 Oct 2022 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667043875;
        bh=OYzKe4Sy+sZYPAffv30XACAu6dlQS6nCqfVSmLE4fw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E+5K+qcf4nhvA2EdU/3/iFwZtjwxGRzUp3D07SskBmiI8ddOYnddRhagHnuG3tj/M
         lMTP7iCCACa9KylXT6qnzWhtiPDxHMdqVQxzz2tsytW3kwtFU9qENevU22aeZhUSGX
         QLevTmLuR20pO6stCJRWl9HYaU7C+kuusyzRGkhPgHqkJ5s1XB+kHjdgoThAw/TGjj
         Nn9/Qt5/gyH6bMWnUj/HqCjD/RB2H88SyPCNoXKgpvxWp+UqkJ38S7W1zodyNtquFy
         1p18UdKle9l4WPJmoxj+x2LsaQDip3hOdumd7uvjqTAVkPEetJiMhVV3nOKzRGlf6l
         Z56+WS3aqqPoQ==
Date:   Sat, 29 Oct 2022 12:56:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 18/23] iio: accel: mxc4005: Convert to i2c's
 .probe_new()
Message-ID: <20221029125630.79e7b162@jic23-huawei>
In-Reply-To: <20221023132302.911644-19-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-19-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:22:57 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied

> ---
>  drivers/iio/accel/mxc4005.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index df600d2917c0..b146fc82738f 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -385,8 +385,7 @@ static int mxc4005_chip_init(struct mxc4005_data *dat=
a)
>  	return 0;
>  }
> =20
> -static int mxc4005_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int mxc4005_probe(struct i2c_client *client)
>  {
>  	struct mxc4005_data *data;
>  	struct iio_dev *indio_dev;
> @@ -489,7 +488,7 @@ static struct i2c_driver mxc4005_driver =3D {
>  		.name =3D MXC4005_DRV_NAME,
>  		.acpi_match_table =3D ACPI_PTR(mxc4005_acpi_match),
>  	},
> -	.probe		=3D mxc4005_probe,
> +	.probe_new	=3D mxc4005_probe,
>  	.id_table	=3D mxc4005_id,
>  };
> =20

