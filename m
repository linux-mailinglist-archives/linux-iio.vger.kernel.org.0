Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7C9612291
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJ2Ltm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJ2Ltl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:49:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8811B6547
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B5960B98
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2306C433D6;
        Sat, 29 Oct 2022 11:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667044176;
        bh=pjDKfnBGDkotkcddUwydOM7kHSOxsLwWE27Yq+rekGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mKZXAaoZilAwDlluuZ05pE3aSBKliIE7Nh6mCpQadgdVfiQCVvQtneeppVsCBeL3A
         GGLZ/P6cczs7vXEkkdmKSvGET/DSm4Im6yaLuxRy0QfabT0s8GZ/6w+UP47Nh3pLxj
         M9JfPGTsxWy3FLnQ1VWk2H9oILROM8/2fAywuHch5cGI6tIfrXB9rXKbx7I9+b7X1e
         5VLVtayHOZ6RFjr6vTiYYrMqorPzJhij0QeT5D7kA7iSYnOk+dob5uj+L+LblDcLVm
         i+WK+j3iwTjOzBzmZ+qUww/RDeUl6jDpyBhDQ3Qega0hErwjk0M4S9FGcmq6lofJiZ
         IYAlRlLt9vYLA==
Date:   Sat, 29 Oct 2022 13:01:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 23/23] iio: accel: vl6180: Convert to i2c's .probe_new()
Message-ID: <20221029130132.6f279b5d@jic23-huawei>
In-Reply-To: <20221023132302.911644-24-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-24-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:23:02 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied.

For the cases where and i2c_client_get_device_id() type call would be
useful, I'd like you to explore that approach as it'll reduce the refactori=
ng
needed and is generally neater.

Jonathan

> ---
>  drivers/iio/light/vl6180.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index d47a4f6f4e87..8b56df26c59e 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -493,8 +493,7 @@ static int vl6180_init(struct vl6180_data *data)
>  	return vl6180_hold(data, false);
>  }
> =20
> -static int vl6180_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static int vl6180_probe(struct i2c_client *client)
>  {
>  	struct vl6180_data *data;
>  	struct iio_dev *indio_dev;
> @@ -539,7 +538,7 @@ static struct i2c_driver vl6180_driver =3D {
>  		.name   =3D VL6180_DRV_NAME,
>  		.of_match_table =3D vl6180_of_match,
>  	},
> -	.probe  =3D vl6180_probe,
> +	.probe_new =3D vl6180_probe,
>  	.id_table =3D vl6180_id,
>  };
> =20

