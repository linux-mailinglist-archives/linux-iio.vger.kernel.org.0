Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F837655115
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 14:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiLWNvK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 08:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWNvJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 08:51:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76EA1BEB6
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 05:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67A26B820DE
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 13:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01724C433EF;
        Fri, 23 Dec 2022 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671803466;
        bh=bBWdIxaAvAn7yxcMob4qHMozRny2wX0Ul5rqYp5ZAeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=imuJtlXy4teXrbHXmx1SWKI/EPQucBgKvx0rG/P/9alD6YXYK6vp7lCEC7RC1srIe
         vjiz8+cbc08FVLBzYfBncilj3X1jkb28+OOwCZX9qoReBxXAO21L76AEzyMB5iHvEK
         B2+LO0cH+Bxdn9QbEAzisx3ES8utJ/VyU6Cct4Y4VmX0th/8WcNWUw095iomwDdoJt
         23zbe/euCQPDsbnM2VrHOn0SMK+rOXLvGm3NgNzqPAfrTdKatYpwMvaxI3oumf+IE4
         2Z0PzPT4uQuEn/bUhbqjPvdWTK6NDZebaFTZ/T+l6bwdX4h9YZrxGQte66CtTtNFhH
         9binqIH8UnYbg==
Date:   Fri, 23 Dec 2022 14:04:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] iio: light: max44009: Convert to i2c's .probe_new()
Message-ID: <20221223140415.36064aed@jic23-huawei>
In-Reply-To: <20221222145429.614781-1-u.kleine-koenig@pengutronix.de>
References: <20221222145429.614781-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Dec 2022 15:54:29 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so
> it can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> since the series that mass converted drivers to probe_new this driver
> was added with the old probe prototype. Fix is accordingly.

Nope, this driver has been there since 2019.  It's the one that I failed
to pick up your patch for originally.  I have it queued up for the coming
cycle, but not pushed out for next yet because I want to rebase my tree
on rc1 first.

Jonathan

>=20
> Best regards
> Uwe
>=20
>  drivers/iio/light/max44009.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
> index 801e5a0ad496..3dadace09fe2 100644
> --- a/drivers/iio/light/max44009.c
> +++ b/drivers/iio/light/max44009.c
> @@ -487,8 +487,7 @@ static irqreturn_t max44009_threaded_irq_handler(int =
irq, void *p)
>  	return IRQ_NONE;
>  }
> =20
> -static int max44009_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static int max44009_probe(struct i2c_client *client)
>  {
>  	struct max44009_data *data;
>  	struct iio_dev *indio_dev;
> @@ -538,7 +537,7 @@ static struct i2c_driver max44009_driver =3D {
>  	.driver =3D {
>  		.name =3D MAX44009_DRV_NAME,
>  	},
> -	.probe =3D max44009_probe,
> +	.probe_new =3D max44009_probe,
>  	.id_table =3D max44009_id,
>  };
>  module_i2c_driver(max44009_driver);
>=20
> base-commit: 9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8

