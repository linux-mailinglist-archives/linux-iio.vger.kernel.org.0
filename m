Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A905261228D
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ2LrV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2LrV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:47:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEC81ADA1
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6968960E96
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07021C433D6;
        Sat, 29 Oct 2022 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667044039;
        bh=rfNlE6153GtLsIpHDe3ZUYkOoKV9zMkeUE5IMEF9qRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XgVTsAhvkUWgIDPexY+W99EI9TGIvSkfMaGqEBTNSYYaz0ozRy2QVni40NWrjpJdI
         X10Jc/Jj7uoNKrpSYHCOIC1EDaPQCCgyc4Yy71nuICgSTiyOeAwgYard/YWErPKHad
         j5qQy6cPpY1Vm+eP73bn45u2QdUTRNVnKi2apk4Gl6/MufugQ15jey+WwAeYMC4bGq
         AqoWIcIdMLocdrWs1mZeRvBL7umNHSXZW37EIq24ZPodYp81shN8InD6RLltORKf1g
         O0TcXidVMXCsD4orLxZqEXIt4lp13+udnFrAeINNruQKh9BvFfnqrzYHd5s8l67dKb
         Kyra2cJvKTW9Q==
Date:   Sat, 29 Oct 2022 12:59:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Peter Rosin <peda@axentia.se>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 21/23] iio: accel: stk8ba50: Convert to i2c's
 .probe_new()
Message-ID: <20221029125914.53971ddc@jic23-huawei>
In-Reply-To: <20221023132302.911644-22-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-22-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:23:00 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied

> ---
>  drivers/iio/accel/stk8ba50.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 2f5e4ab2a6e7..44f6e0fbdfcc 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -379,8 +379,7 @@ static const struct iio_buffer_setup_ops stk8ba50_buf=
fer_setup_ops =3D {
>  	.postdisable =3D stk8ba50_buffer_postdisable,
>  };
> =20
> -static int stk8ba50_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static int stk8ba50_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev;
> @@ -544,7 +543,7 @@ static struct i2c_driver stk8ba50_driver =3D {
>  		.pm =3D pm_sleep_ptr(&stk8ba50_pm_ops),
>  		.acpi_match_table =3D ACPI_PTR(stk8ba50_acpi_id),
>  	},
> -	.probe =3D            stk8ba50_probe,
> +	.probe_new =3D        stk8ba50_probe,
>  	.remove =3D           stk8ba50_remove,
>  	.id_table =3D         stk8ba50_i2c_id,
>  };

