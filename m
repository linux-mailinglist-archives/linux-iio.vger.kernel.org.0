Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC331612282
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ2LmQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2LmP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:42:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF286AE96
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42C77B80B89
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02785C433D6;
        Sat, 29 Oct 2022 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667043731;
        bh=z3jT122sUCituv/Mioa2SuxWt/jv2rP1GM9DN5Zp844=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FmmVULd2ZalsfcSQ7n1XG0YQA9LjKCT5jmqXrN/7Oszozg9iCs1E4nNTipg2k413u
         dMwefQTagCO6KRi2uyVqnTF6sgc6nGsdVUdNr3MS2A8quJXxL7fu+tVyg4bdt6kE1S
         2TI6FzEbgGjcXXfA8eLOQuOeLqlhbJ6NUANx5hii3ChJ5BHPrba1nK92dmStzj4rzs
         MgJy1diHpKUvDLA7j5u5ybvBiMqbf0ovKUJydUs6ZzYw290cA9QC8Exmo+RqGZsYo3
         vP+ot1BJsHFVv9kPZobRxyaC6UKQyksHyaWrXwtq0Jqqbxg6LLJK7VrDXK1Gx3YaCL
         BwVEbvSWCtZQw==
Date:   Sat, 29 Oct 2022 12:54:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.de>, Ajay Gupta <ajayg@nvidia.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 11/23] iio: accel: kxsd9: Convert to i2c's .probe_new()
Message-ID: <20221029125406.55c300cf@jic23-huawei>
In-Reply-To: <20221023132302.911644-12-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-12-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:22:50 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied

> ---
>  drivers/iio/accel/kxsd9-i2c.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> index 61346ea8ef19..6b3683ddce36 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -10,8 +10,7 @@
> =20
>  #include "kxsd9.h"
> =20
> -static int kxsd9_i2c_probe(struct i2c_client *i2c,
> -			   const struct i2c_device_id *id)
> +static int kxsd9_i2c_probe(struct i2c_client *i2c)
>  {
>  	static const struct regmap_config config =3D {
>  		.reg_bits =3D 8,
> @@ -55,7 +54,7 @@ static struct i2c_driver kxsd9_i2c_driver =3D {
>  		.of_match_table =3D kxsd9_of_match,
>  		.pm =3D pm_ptr(&kxsd9_dev_pm_ops),
>  	},
> -	.probe		=3D kxsd9_i2c_probe,
> +	.probe_new	=3D kxsd9_i2c_probe,
>  	.remove		=3D kxsd9_i2c_remove,
>  	.id_table	=3D kxsd9_i2c_id,
>  };

