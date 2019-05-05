Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2F13F4C
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEEMGl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 08:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEEMGl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 May 2019 08:06:41 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308212087F;
        Sun,  5 May 2019 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557058000;
        bh=i8IgdodhDZT8g5eCpvqZfSm1dEue2uSu7hzNSi3wo/g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cpZ1S1/AQ9rhuyjtEZDYnx4L2bY5l9lFvyP+OW+7a0LxVtFerBDlbkXXPdc8nm0pO
         0w1eRFNiSnFirzFkNkn7/dSeBJR7EOvvIqcJu8C2mFiBjGAFURigZcIhvu6MBT/OYb
         LCTDsoVGfOsfiXXlsWj4a8En2538tmbAQ72bj31M=
Date:   Sun, 5 May 2019 13:06:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?Sm/Do28=?= Seckler <joaoseckler@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: adt7316: match parenthesis alignment
Message-ID: <20190505130634.4bd56579@archlinux>
In-Reply-To: <20190429175939.2jvt4qwrtbmpvhl6@smtp.gmail.com>
References: <20190429175939.2jvt4qwrtbmpvhl6@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Apr 2019 14:59:40 -0300
Jo=C3=A3o Seckler <joaoseckler@gmail.com> wrote:

> This patch solves the following checkpatch.pl message:
> CHECK: Alignment should match open parenthesis.
> This makes the file more compliant with the preferred coding style for
> the Linux kernel.
>=20
> Signed-off-by: Jo=C3=A3o Seckler <joaoseckler@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/ad=
dac/adt7316.c
> index b6a65ee8d558..37ce563cb0e1 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2154,7 +2154,7 @@ int adt7316_probe(struct device *dev, struct adt731=
6_bus *bus,
>  		chip->dac_bits =3D 8;
> =20
>  	chip->ldac_pin =3D devm_gpiod_get_optional(dev, "adi,ldac",
> -						GPIOD_OUT_LOW);
> +						 GPIOD_OUT_LOW);
>  	if (IS_ERR(chip->ldac_pin)) {
>  		ret =3D PTR_ERR(chip->ldac_pin);
>  		dev_err(dev, "Failed to request ldac GPIO: %d\n", ret);

