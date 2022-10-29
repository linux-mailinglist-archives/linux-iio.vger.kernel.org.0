Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2961227E
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ2Lkv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ2Lku (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B6B65572
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C8260E96
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68B9C433C1;
        Sat, 29 Oct 2022 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667043648;
        bh=c0RsxDMLv4JNYNdkZyg8fp8kG8HzNZ2e2EYnmh4FC+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TRi31HroH4ovHNKiGfL7CILO9qoRmGduDlorsixfQhqSVzDHmDwx20DXdVubxSwSW
         RtMhfJ6GeuBlPKwtcqtsqg59ZpNfgTQMPAATpDVqE+8CiSkZX6oqTG3vWX9eG3/K0J
         Ym5n7VIuRSakReQnWnjIJfKM4QlNCmNMr6ROffsFqKSs1PF+H+ahLtvGvuvDkTFWT1
         mKCbz2RVHGBPj4sTuxLuDjR70UfP7Z51NyumG5KlHdkrhoZ5i5LuEhnxz4zHk6u+3S
         pngfr6+l3l9VyfhEb9g0CNW2UqYPJpCCFaNyH/M6aLZCRXdAZdA2uEvZ0hQc2LIWBV
         O3mR5J0V1f1gA==
Date:   Sat, 29 Oct 2022 12:52:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Paul Lemmermann <thepaulodoom@thepaulodoom.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 08/23] iio: accel: dmard09: Convert to i2c's
 .probe_new()
Message-ID: <20221029125244.4ef04bfe@jic23-huawei>
In-Reply-To: <20221023132302.911644-9-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-9-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:22:47 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied
> ---
>  drivers/iio/accel/dmard09.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
> index cb0246ca72f3..4b7a537f617d 100644
> --- a/drivers/iio/accel/dmard09.c
> +++ b/drivers/iio/accel/dmard09.c
> @@ -88,8 +88,7 @@ static const struct iio_info dmard09_info =3D {
>  	.read_raw	=3D dmard09_read_raw,
>  };
> =20
> -static int dmard09_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int dmard09_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev;
> @@ -136,7 +135,7 @@ static struct i2c_driver dmard09_driver =3D {
>  	.driver =3D {
>  		.name =3D DMARD09_DRV_NAME
>  	},
> -	.probe =3D dmard09_probe,
> +	.probe_new =3D dmard09_probe,
>  	.id_table =3D dmard09_id,
>  };
> =20

