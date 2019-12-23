Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63412989F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLWQUp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:20:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfLWQUo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:20:44 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FDCD20709;
        Mon, 23 Dec 2019 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577118044;
        bh=o05589tfKIFhFEMvzgvzVMCDYH1FEEtkXwZipCBsW40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WR+8kulu5ou023bHkQ5ztYHmNRu8b8INDWo/cxspeZKL4PX9eU7u+UdztGIsZkXl2
         dmDfC0zeSzW9PzTWtxsteDjm3Xe8RaRSkGjTWiCVasD60JQSupAvZbX5eVg/k43zj0
         vRGFMu4AI8Qan6eaSmS3R3wd06F/tb2q6wO8aBtM=
Date:   Mon, 23 Dec 2019 16:20:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 4/9] iio: gyro: st_gyro: Mark gyro_pdata with
 __maybe_unused
Message-ID: <20191223162039.6282ac62@archlinux>
In-Reply-To: <20191216173853.75797-4-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
        <20191216173853.75797-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 19:38:48 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since we put static variable to a header file it's copied to each module
> that includes the header. But not all of them are actually used it.
>=20
> Mark gyro_pdata with __maybe_unused to calm a compiler down:
>=20
> In file included from drivers/iio/gyro/st_gyro_i2c.c:18:
> drivers/iio/gyro/st_gyro.h:31:46: warning: =E2=80=98gyro_pdata=E2=80=99 d=
efined but not used [-Wunused-const-variable=3D]
>    31 | static const struct st_sensors_platform_data gyro_pdata =3D {
>       |                                              ^~~~~~~~~~
> ...

Applied
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/gyro/st_gyro.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
> index 592f6b34e987..fd9171cc3aba 100644
> --- a/drivers/iio/gyro/st_gyro.h
> +++ b/drivers/iio/gyro/st_gyro.h
> @@ -28,7 +28,7 @@
>   * struct st_sensors_platform_data - gyro platform data
>   * @drdy_int_pin: DRDY on gyros is available only on INT2 pin.
>   */
> -static const struct st_sensors_platform_data gyro_pdata =3D {
> +static __maybe_unused const struct st_sensors_platform_data gyro_pdata =
=3D {
>  	.drdy_int_pin =3D 2,
>  };
> =20

