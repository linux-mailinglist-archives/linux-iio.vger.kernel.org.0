Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E776748FC42
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 12:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiAPLQ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 06:16:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37518 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiAPLQz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 06:16:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95794B80D10
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 11:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE5DC36AE3;
        Sun, 16 Jan 2022 11:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642331813;
        bh=CzIQcibV3mQXbCAg6uhybJc917WBKF32iWLdt9S92G8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X9NT1n9CE7UJUfZ0NZEXZ9qZwrzJTRCWAvtOnRARkz1aUuKRCf3hxqy75P+OABUVS
         IWUvqMwHgGvP+sxDR76ieNS2jRKdl002qVAUqDsSQClj1wuQiyfNsrMZjpXzHLhJ6J
         z14REstT04Ndrl/PUw5nWWLezJNPnc5zfwoFWWbmgtGfRrIb21iwsasBXXwpCl+7kq
         X6BUyzofEL3vEbQ2m52Lc+rgFOm+ZzlA4yfjCj57EwCF/mISpbWroWxr5FxNx0K+tk
         Lk0y0g4H+8LZ2CLltmozINWwxwtwJrQxen4KZgqPvWrHuX8aJvRpxcpRcBYLVI48bI
         54CRmXt9Av4ow==
Date:   Sun, 16 Jan 2022 11:22:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Julia Pineda <julia.pineda@analog.com>
Subject: Re: [PATCH] iio: adis16480: fix buffering for devices with no burst
 mode
Message-ID: <20220116112254.784b9b6f@jic23-huawei>
In-Reply-To: <20220114132608.241-1-nuno.sa@analog.com>
References: <20220114132608.241-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Jan 2022 14:26:08 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The trigger handler defined in the driver assumes that burst mode is
> being used. Hence, for devices that do not support it, we have to use
> the adis library default trigger implementation.
>=20
> Tested-by: Julia Pineda <julia.pineda@analog.com>
> Fixes: 941f130881fa9 ("iio: adis16480: support burst read function")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Note I'll probably rebase that branch after rc1 before sending a pull
request.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index ed129321a14d..f9b4540db1f4 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -1403,6 +1403,7 @@ static int adis16480_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id =3D spi_get_device_id(spi);
>  	const struct adis_data *adis16480_data;
> +	irq_handler_t trigger_handler =3D NULL;
>  	struct iio_dev *indio_dev;
>  	struct adis16480 *st;
>  	int ret;
> @@ -1474,8 +1475,12 @@ static int adis16480_probe(struct spi_device *spi)
>  		st->clk_freq =3D st->chip_info->int_clk;
>  	}
> =20
> +	/* Only use our trigger handler if burst mode is supported */
> +	if (adis16480_data->burst_len)
> +		trigger_handler =3D adis16480_trigger_handler;
> +
>  	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> -						 adis16480_trigger_handler);
> +						 trigger_handler);
>  	if (ret)
>  		return ret;
> =20

