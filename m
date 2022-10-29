Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D6661228C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ2Lqn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2Lqn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0686D557
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5702760EA0
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D467C433C1;
        Sat, 29 Oct 2022 11:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667044001;
        bh=SMeAAfKpqVFgemdu1eSRxql5yliu7PgQXU13GItx1v8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cBkih4Yw40cXa+6wppf58Qyl6Z715FCGi4uguBrtDQpD5xOGRz0+3HrkElO0hqQ8J
         l28e1tOItwjAC2dWt/jwy9z1QHhVwc2cMr6HZf3xnDD0euKjMOQ8J58nbbqf5tLc+P
         Cg6q1xOiqPriMwDGT6BdpiyMgj5aOJy5Srg6WwXh94BUpb/Q1K6IKLqbpfk28cGT+h
         wyLJJ3vhIr6mcQmrgCUlIguGSLIcJ3WGenyGtOOEUw6/rhG95dRqAqNvsIHt7YfPvL
         GwxRxHY0/nyNMAHMPLTHE0qY7P/6Vyba22UUM0BMCKF1ki2O3I+TikKWeg5xXfpz2r
         i3FNgZbfS2oDw==
Date:   Sat, 29 Oct 2022 12:58:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jean Delvare <jdelvare@suse.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 20/23] iio: accel: stk8312: Convert to i2c's
 .probe_new()
Message-ID: <20221029125836.566d1991@jic23-huawei>
In-Reply-To: <20221023132302.911644-21-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-21-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:22:59 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied

> ---
>  drivers/iio/accel/stk8312.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index 7b1d6fb692b3..68f680db7505 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -498,8 +498,7 @@ static const struct iio_buffer_setup_ops stk8312_buff=
er_setup_ops =3D {
>  	.postdisable =3D stk8312_buffer_postdisable,
>  };
> =20
> -static int stk8312_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int stk8312_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev;
> @@ -645,7 +644,7 @@ static struct i2c_driver stk8312_driver =3D {
>  		.name =3D STK8312_DRIVER_NAME,
>  		.pm =3D pm_sleep_ptr(&stk8312_pm_ops),
>  	},
> -	.probe =3D            stk8312_probe,
> +	.probe_new =3D        stk8312_probe,
>  	.remove =3D           stk8312_remove,
>  	.id_table =3D         stk8312_i2c_id,
>  };

