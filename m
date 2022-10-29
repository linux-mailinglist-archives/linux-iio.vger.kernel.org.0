Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E73612283
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJ2Lne (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2Lnd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1566AEB1
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 327BA60E9C
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D50C433C1;
        Sat, 29 Oct 2022 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667043811;
        bh=KE2kbPsTB7TsJM2unMqb1PI+jtG1nPTSb41BmhnZiGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a2KipmIBVv/0xz4mpnq9Q2CRqocQZqZqEIfx9el7EPrA9nWnsQ6JpuTcBZR4NInMY
         V2CMESRkKSd/dTcSJPIVf4rYYVkjadezVjxiqMT7IGN2tq7NOuqn85WTv61wEgY2SL
         W99M4yle13QnF2t059V7+UmZdPRMRenhqh6EUG4BnzmXBpmffXjJ1KrWVKP0WJ52tA
         QJJnMxJQ55vsYSCXJ6DufIQAyZ1XxOJFKXnUaYXxDnjsRdcY/3nSx1jSwL0E1d6f/z
         MiJZXz/WmIdezGbHEaFhzLq1YjcSkVNrAj9CECGBklHSGXYx9JB7v9hetQmYFMSADJ
         aEevlvZ0a7rZQ==
Date:   Sat, 29 Oct 2022 12:55:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 14/23] iio: accel: mma7660: Convert to i2c's
 .probe_new()
Message-ID: <20221029125524.08c7980e@jic23-huawei>
In-Reply-To: <20221023132302.911644-15-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-15-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:22:53 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied

> ---
>  drivers/iio/accel/mma7660.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index 85829990bbad..b279ca4dcdc0 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -169,8 +169,7 @@ static const struct iio_info mma7660_info =3D {
>  	.attrs			=3D &mma7660_attribute_group,
>  };
> =20
> -static int mma7660_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int mma7660_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev;
> @@ -267,7 +266,7 @@ static struct i2c_driver mma7660_driver =3D {
>  		.of_match_table =3D mma7660_of_match,
>  		.acpi_match_table =3D mma7660_acpi_id,
>  	},
> -	.probe		=3D mma7660_probe,
> +	.probe_new	=3D mma7660_probe,
>  	.remove		=3D mma7660_remove,
>  	.id_table	=3D mma7660_i2c_id,
>  };

