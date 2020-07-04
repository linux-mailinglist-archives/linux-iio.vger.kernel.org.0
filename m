Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91A82147BC
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGDRaK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDRaK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:30:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4694F20748;
        Sat,  4 Jul 2020 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593883809;
        bh=AbKg6rfTzzbQCJRN1v4tg7McUv/aOvFf8vmpZzSvvUY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MtkcGTaKwS088ue6F2DX7XwHcTGUYD7bJYkICdDpEGWlQZo5rJVDkQm2gVxerXr7r
         ic5lSB1DfDBS56Tr/vk7dRcc4xwpZAu3Qyu+PVqWxq4IcQSSFxKsSoQZMcTLnaqIzT
         rrzyBEBBAzwREVsFZo6vC1drbeOfHWh1uAyKkN04=
Date:   Sat, 4 Jul 2020 18:30:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>
Subject: Re: [PATCH 17/23] iio:adc:ti-adc084s021: drop of_match_ptr
 protection
Message-ID: <20200704183005.3b7d5f69@archlinux>
In-Reply-To: <20200628123654.32830-18-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-18-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 13:36:48 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Allows ACPI PRP0001 to be used with this driver.
> Also adds mod_devicetable.h header as the driver is directly using
> struct of_device_id which is defined in that file.
>=20
> I'm also trying to clear out of_match_ptr use in IIO to avoid it
> being cut and paste into new drivers.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: M=C3=A5rten Lindahl <martenli@axis.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-adc084s021.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s=
021.c
> index c2db2435f419..5678bf7499b1 100644
> --- a/drivers/iio/adc/ti-adc084s021.c
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -10,6 +10,7 @@
>  #include <linux/err.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/interrupt.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -254,7 +255,7 @@ MODULE_DEVICE_TABLE(spi, adc084s021_id);
>  static struct spi_driver adc084s021_driver =3D {
>  	.driver =3D {
>  		.name =3D ADC084S021_DRIVER_NAME,
> -		.of_match_table =3D of_match_ptr(adc084s021_of_match),
> +		.of_match_table =3D adc084s021_of_match,
>  	},
>  	.probe =3D adc084s021_probe,
>  	.id_table =3D adc084s021_id,

