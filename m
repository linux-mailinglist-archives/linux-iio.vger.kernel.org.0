Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118B5612281
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ2Lla (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2Lla (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A766AA30
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:41:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02A8460EA2
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E020DC433C1;
        Sat, 29 Oct 2022 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667043688;
        bh=LC51dztUt/eVUtLT7SVUHgBe+FNbuKdfzcrzzfAU7OM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=agmHXN/RL6BHzkm4n+yiQL2/v1UrA9N+l5cBt4mxfsX3LY6nZ2+z4C74iVB8iJVGr
         lW6K3awGg+Z64J6FKWqols78HNQkG7oqUQAn5gyr7gZxCaL4XgdO+bTmtj+QVlb7E3
         L2YnNIXVqI9GeS8y+u+sY4h3mNGKkZun/1yBegEjFQKQp/MpybL8DWrggiQukfuoC9
         XRipdxvV/PQCC/3uZ1KIvrao7b0YVxI1y5c8pD5ZX8PVCpovnJcQYDpv6kHPjRZS5v
         ndSvJYWskugp2czhGVqj9CcKJ9qLfl/yfG885gNhYA4htBTTupLNMIbnFtZMEWY/Bo
         8bkcxG5f+2EbA==
Date:   Sat, 29 Oct 2022 12:53:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 09/23] iio: accel: dmard10: Convert to i2c's
 .probe_new()
Message-ID: <20221029125324.35d98197@jic23-huawei>
In-Reply-To: <20221023132302.911644-10-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-10-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:22:48 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied

> ---
>  drivers/iio/accel/dmard10.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
> index 8ac62ec0a04a..07e68aed8a13 100644
> --- a/drivers/iio/accel/dmard10.c
> +++ b/drivers/iio/accel/dmard10.c
> @@ -175,8 +175,7 @@ static void dmard10_shutdown_cleanup(void *client)
>  	dmard10_shutdown(client);
>  }
> =20
> -static int dmard10_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int dmard10_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev;
> @@ -242,7 +241,7 @@ static struct i2c_driver dmard10_driver =3D {
>  		.name =3D "dmard10",
>  		.pm =3D pm_sleep_ptr(&dmard10_pm_ops),
>  	},
> -	.probe		=3D dmard10_probe,
> +	.probe_new	=3D dmard10_probe,
>  	.id_table	=3D dmard10_i2c_id,
>  };
> =20

