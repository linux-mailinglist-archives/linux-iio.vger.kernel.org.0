Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C192E612288
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 13:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJ2LpM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 07:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ2LpL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 07:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CE23ED6F
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 04:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5417D60EA0
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B9FC433C1;
        Sat, 29 Oct 2022 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667043907;
        bh=XLScMBgiAEGPsDsuS472yPecDPDCCs1Wymkq5BnLQqA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ljuN9D+RX9oFtvUo634Kxec9K3dWxTbxP/2kNPNTlCGmfmMFx8RnPDgHs4kHt/NHv
         TX4eTQp1r4SpIWQeEtg24skvdwDJw31VJot8dPzZm9SKH2aqAs6maZyyZWlWakKJ//
         NKR7kY9HuGyLEtq1x+71VgTjTLc13XXL4iWzdm2hlXIOxg2dmJ5JI8Ik2ULLCbnfOB
         DGzj5IeKUq2f3rDRusTzAYy/SSMQzSe5tkQ8M4k1AHjVraot+VtKYSey0/6yctWIRB
         aBwoI8fCLW/3pAxlI/QdFV0fZaWATE/ptlx8iN9/LSYr9UUCNrExwkAfFCQ2aHsFsO
         6WS9Svn1RQkCQ==
Date:   Sat, 29 Oct 2022 12:57:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ajay Gupta <ajayg@nvidia.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 12/23] iio: accel: mc3230: Convert to i2c's .probe_new()
Message-ID: <20221029125703.50728cf4@jic23-huawei>
In-Reply-To: <20221023132302.911644-13-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
        <20221023132302.911644-13-u.kleine-koenig@pengutronix.de>
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

On Sun, 23 Oct 2022 15:22:51 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied
> ---
>  drivers/iio/accel/mc3230.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index 2462000e0519..efc21871de42 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -106,8 +106,7 @@ static const struct iio_info mc3230_info =3D {
>  	.read_raw	=3D mc3230_read_raw,
>  };
> =20
> -static int mc3230_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int mc3230_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev;
> @@ -191,7 +190,7 @@ static struct i2c_driver mc3230_driver =3D {
>  		.name =3D "mc3230",
>  		.pm =3D pm_sleep_ptr(&mc3230_pm_ops),
>  	},
> -	.probe		=3D mc3230_probe,
> +	.probe_new	=3D mc3230_probe,
>  	.remove		=3D mc3230_remove,
>  	.id_table	=3D mc3230_i2c_id,
>  };

