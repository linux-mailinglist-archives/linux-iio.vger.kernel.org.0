Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22B069BA49
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 14:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBRNqV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 08:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRNqV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 08:46:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BC313D5D
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 05:46:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01C9760B85
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 13:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FA2C433EF;
        Sat, 18 Feb 2023 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676727979;
        bh=1bkyQ6yFGjccaoPPpLm2wR7jld/kIsiz4a9H7FkviPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jf8EII5kMO0w+eEOgqSGsryEEbeOinH/ELtogF7prfxAjZnmPKKaJZcpUmDUibr5G
         BL8IfkaI2dwxmU/gz/tPnqZQ6lzXVdkNdpOrAFBjUqQijtGOP9/nQ2MHp6y5oN8gpL
         gHzqawglKzXOzwkHum2z+S5jxBvV62+DFHq5nDDykrWrxnPFCSY7enfkK39AU3ZdRe
         TqJnj0HDsu70zbxPmkXEa+IdIbu5/6wL7uPCHTh0Phqvrfw1sls6ru4+5NUxg/UeMw
         Ark6GZrEAmka2vtxzYUFz+OJqqVedg8UdJ2Z/+SkVY8Py08TfosTruEDNZhow+kYgB
         nDK/SYerzpDUQ==
Date:   Sat, 18 Feb 2023 14:00:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: imu: adis16475: correct copy paste mistake in
 comment block
Message-ID: <20230218140038.7293feb2@jic23-huawei>
In-Reply-To: <20230213153208.1027602-1-nuno.sa@analog.com>
References: <20230213153208.1027602-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Mon, 13 Feb 2023 16:32:08 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The minimal advised lower rate for adis16475 compatible devices is
> 1900HZ and not 4000HZ. Set that right in the comments so that it does
> not generate any confusion.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16475.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index aec55f7e1f26..3abffb01ba31 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -326,11 +326,11 @@ static int adis16475_set_freq(struct adis16475 *st,=
 const u32 freq)
> =20
>  		/*
>  		 * This is not an hard requirement but it's not advised to run the IMU
> -		 * with a sample rate lower than 4000Hz due to possible undersampling
> +		 * with a sample rate lower than 1900Hz due to possible undersampling
>  		 * issues. However, there are users that might really want to take the=
 risk.
>  		 * Hence, we provide a module parameter for them. If set, we allow sam=
ple
> -		 * rates lower than 4KHz. By default, we won't allow this and we just =
roundup
> -		 * the rate to the next multiple of the input clock bigger than 4KHz. =
This
> +		 * rates lower than 1.9KHz. By default, we won't allow this and we jus=
t roundup
> +		 * the rate to the next multiple of the input clock bigger than 1.9KHz=
. This
>  		 * is done like this as in some cases (when DEC_RATE is 0) might give
>  		 * us the closest value to the one desired by the user...
>  		 */

