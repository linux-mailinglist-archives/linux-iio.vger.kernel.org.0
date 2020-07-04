Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0239F21477A
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGDQnQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 12:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGDQnP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 12:43:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E0A20723;
        Sat,  4 Jul 2020 16:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593880995;
        bh=9YmlZqOePBt9kYT1qOiGBNgSekeb4d3CULja8jwafH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sf7raOm0Yx4lXfv2qsO9uopVSnFDi4YsE7eeAY7e31TG0GklqbnJzRffD6aiW7r5I
         Hv6ICDqPPkwA3mOwAaqoFhaaX4VfLZwDHHj0vs0X81DRwPhzpBhmdxFWUjSyQMJYKm
         9aKSNf0M6I6U+32/cPeIlRA83sgF8p1KRWcv297Q=
Date:   Sat, 4 Jul 2020 17:43:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: adis16480: Use irq types instead of flags
Message-ID: <20200704174311.1da73b83@archlinux>
In-Reply-To: <20200701120702.365-1-nuno.sa@analog.com>
References: <20200701120702.365-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 1 Jul 2020 14:07:02 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The value retrieved by `irqd_get_trigger_type()` is not an irq flag.
> While the values are the same, the meaning is different.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 5163749f568e..1eb4f98076f1 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -1102,12 +1102,12 @@ static int adis16480_config_irq_pin(struct device=
_node *of_node,
>  	/*
>  	 * Get the interrupt line behaviour. The data ready polarity can be
>  	 * configured as positive or negative, corresponding to
> -	 * IRQF_TRIGGER_RISING or IRQF_TRIGGER_FALLING respectively.
> +	 * IRQ_TYPE_EDGE_RISING or IRQ_TYPE_EDGE_FALLING respectively.
>  	 */
>  	irq_type =3D irqd_get_trigger_type(desc);
> -	if (irq_type =3D=3D IRQF_TRIGGER_RISING) { /* Default */
> +	if (irq_type =3D=3D IRQ_TYPE_EDGE_RISING) { /* Default */
>  		val |=3D ADIS16480_DRDY_POL(1);
> -	} else if (irq_type =3D=3D IRQF_TRIGGER_FALLING) {
> +	} else if (irq_type =3D=3D IRQ_TYPE_EDGE_FALLING) {
>  		val |=3D ADIS16480_DRDY_POL(0);
>  	} else {
>  		dev_err(&st->adis.spi->dev,

