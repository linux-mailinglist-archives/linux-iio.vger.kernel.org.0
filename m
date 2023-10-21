Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913817D1DF1
	for <lists+linux-iio@lfdr.de>; Sat, 21 Oct 2023 17:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjJUPhC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Oct 2023 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjJUPhB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Oct 2023 11:37:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE76BF4
        for <linux-iio@vger.kernel.org>; Sat, 21 Oct 2023 08:36:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B65C433C8;
        Sat, 21 Oct 2023 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697902619;
        bh=lsSNzc/z5nbRrPva0TfQTdHdkuLyunOlnhgP3mMQ1/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fubMWGRCyBSMR7PZZnkQwYNzvjc7RFQ4twO8EzdVmZaPpYWaF0DwnMMTS9OaX86Kf
         v8x9pv7nXNVDFBMuVqC5uxsis2VgUbFBmVuQ8FOT7NhUmOq452OCZg/Y5n4j6q0Mne
         uqxDq9lGc+ctysYh1vDjCR98Y5V9IKZGMb3Dfg0DGpxjEH4+9eFaGHtcrlYoR+haI+
         O6SAKjX+2rM5hbDLCjZOTftbyJL3HfATg68O6U0YutSv+Ug+M5rWW05StCwpRrc0z9
         b/KuFabwNjwLlvo430vtgzxnd5YfWbfj2KT5r1LFQfyi0hIygVeowxHcNdXJvyuxzk
         03hF8D00vTLlA==
Date:   Sat, 21 Oct 2023 16:36:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Li peiyu <579lpy@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure:  fix some word spelling errors
Message-ID: <20231021163654.0e1ada88@jic23-huawei>
In-Reply-To: <20231021070903.6051-1-579lpy@gmail.com>
References: <20231021070903.6051-1-579lpy@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Oct 2023 15:09:03 +0800
Li peiyu <579lpy@gmail.com> wrote:

> They are appear to be spelling mistakes,
> drivers/iio/pressure/bmp280.h:413        endianess->endianness
> drivers/iio/pressure/bmp280-core.c:923   dregrees->degrees
> drivers/iio/pressure/bmp280-core.c:1388  reescale->rescale
> drivers/iio/pressure/bmp280-core.c:1415  reescale->rescale
>=20
> Signed-off-by: Li peiyu <579lpy@gmail.com>
Applied. Will initially be pushed out as the testing branch of iio.git
and I'll probably be rebasing that on 6.7-rc1 once available, before
pushing it out to get picked up by Linux next.
> ---
>  drivers/iio/pressure/bmp280-core.c | 6 +++---
>  drivers/iio/pressure/bmp280.h      | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bm=
p280-core.c
> index a2ef1373a274..4c493db7db96 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -920,7 +920,7 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cm=
d)
>  }
> =20
>  /*
> - * Returns temperature in Celsius dregrees, resolution is 0.01=C2=BA C. =
Output value of
> + * Returns temperature in Celsius degrees, resolution is 0.01=C2=BA C. O=
utput value of
>   * "5123" equals 51.2=C2=BA C. t_fine carries fine temperature as global=
 value.
>   *
>   * Taken from datasheet, Section Appendix 9, "Compensation formula" and =
repo
> @@ -1385,7 +1385,7 @@ static int bmp580_read_temp(struct bmp280_data *dat=
a, int *val, int *val2)
> =20
>  	/*
>  	 * Temperature is returned in Celsius degrees in fractional
> -	 * form down 2^16. We reescale by x1000 to return milli Celsius
> +	 * form down 2^16. We rescale by x1000 to return milli Celsius
>  	 * to respect IIO ABI.
>  	 */
>  	*val =3D raw_temp * 1000;
> @@ -1412,7 +1412,7 @@ static int bmp580_read_press(struct bmp280_data *da=
ta, int *val, int *val2)
>  	}
>  	/*
>  	 * Pressure is returned in Pascals in fractional form down 2^16.
> -	 * We reescale /1000 to convert to kilopascal to respect IIO ABI.
> +	 * We rescale /1000 to convert to kilopascal to respect IIO ABI.
>  	 */
>  	*val =3D raw_press;
>  	*val2 =3D 64000; /* 2^6 * 1000 */
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 5c0563ce7572..9d9f4ce2baa6 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -410,7 +410,7 @@ struct bmp280_data {
>  		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
>  		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
>  		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
> -		/* Miscellaneous, endianess-aware data buffers */
> +		/* Miscellaneous, endianness-aware data buffers */
>  		__le16 le16;
>  		__be16 be16;
>  	} __aligned(IIO_DMA_MINALIGN);

