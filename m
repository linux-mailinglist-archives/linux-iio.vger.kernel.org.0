Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9D612290
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJ2LsO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJ2LsM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246F6D56C
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EEC760E9C
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7D3C433C1;
        Sat, 29 Oct 2022 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667044090;
        bh=9zNf+pyN72QyA9Y6aK6VBWx8/ZgxoDw6OfzMY+eBnoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EdMoUEQGnRVgfPxCzO0ZCkukfPo3kSuq/fac63ZKxz9GM8EuibWBwH4pr5J/5Dwu/
         xEvO4MsYQp6N279SEQVGuFfJIDhq/6wH52hNS2mAu2rJa6kA64wlZYGv6OIiwYluBP
         19MqVZJdk6vajINLM1nWpHA4+Oex7DrHGwyTM3udvFuj8txzLqlujGOPka+XeIn/yD
         uBj3uNzx2kZnq+5qxZPHqLeYMSOh7VkslzFf/UJrw4Wh9HZFh1qiFeBWDtL6bFAXJu
         L0c2VIg3Uy9E7TYCw10VcXFLvVScWbIQ80G6X1LagVg92qXC6hfFhN02pE+rUcVT2B
         q9e/fyrzIAQSw==
Date:   Sat, 29 Oct 2022 13:00:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 22/23] iio: accel: st_magn: Convert to i2c's
 .probe_new()
Message-ID: <20221029130005.1048cda1@jic23-huawei>
In-Reply-To: <20221023132302.911644-23-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-23-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:23:01 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied

> ---
>  drivers/iio/magnetometer/st_magn_i2c.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magneto=
meter/st_magn_i2c.c
> index c5d8c303db4e..b4098d3b3813 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -54,8 +54,7 @@ static const struct of_device_id st_magn_of_match[] =3D=
 {
>  };
>  MODULE_DEVICE_TABLE(of, st_magn_of_match);
> =20
> -static int st_magn_i2c_probe(struct i2c_client *client,
> -			     const struct i2c_device_id *id)
> +static int st_magn_i2c_probe(struct i2c_client *client)
>  {
>  	const struct st_sensor_settings *settings;
>  	struct st_sensor_data *mdata;
> @@ -107,7 +106,7 @@ static struct i2c_driver st_magn_driver =3D {
>  		.name =3D "st-magn-i2c",
>  		.of_match_table =3D st_magn_of_match,
>  	},
> -	.probe =3D st_magn_i2c_probe,
> +	.probe_new =3D st_magn_i2c_probe,
>  	.id_table =3D st_magn_id_table,
>  };
>  module_i2c_driver(st_magn_driver);

