Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90675224C7A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGRPbD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRPbD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:31:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A7C2076A;
        Sat, 18 Jul 2020 15:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595086262;
        bh=1wuiIPUiXSmhjJ5LdQ20PRNh28jticm8GjYJ/lQO3C4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fMTm3kuucoTH3NtXiv5VTUCkKBXs3MWRPXJRPJw3UaljOi4yp7wXS33ggotopxQ/L
         p1RM113L0ROPs434YgDq8uwqjNSnRZWjCyVrDLbeVBRefDpZOvwirW5r8ExBsnfcuq
         GbDHpRL2WUUkfzVz1lLDYKMlJ3Yooe/bYh06IaH4=
Date:   Sat, 18 Jul 2020 16:30:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Rachna Patil <rachna@ti.com>
Subject: Re: [PATCH 01/30] iio: adc: ti_am335x_adc: Remove a couple of
 unused 'read' variables
Message-ID: <20200718163058.672b6362@archlinux>
In-Reply-To: <20200717165538.3275050-2-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-2-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:09 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/iio/adc/ti_am335x_adc.c: In function =E2=80=98tiadc_buffer_preen=
able=E2=80=99:
>  drivers/iio/adc/ti_am335x_adc.c:297:21: warning: variable =E2=80=98read=
=E2=80=99 set but not used [-Wunused-but-set-variable]
>  297 | int i, fifo1count, read;
>  | ^~~~
>  drivers/iio/adc/ti_am335x_adc.c: In function =E2=80=98tiadc_buffer_predi=
sable=E2=80=99:
>  drivers/iio/adc/ti_am335x_adc.c:346:21: warning: variable =E2=80=98read=
=E2=80=99 set but not used [-Wunused-but-set-variable]
>  346 | int fifo1count, i, read;
>  | ^~~~
>=20
> Cc: Rachna Patil <rachna@ti.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied to the togreg branch of iio.git which will get pushed out as testin=
g for
the autobuilders to poke at these changes.
Still time or anyone one else to comment. I'm picking these up as they are
all noops and appear straight forward.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti_am335x_adc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_=
adc.c
> index 9d984f2a8ba74..93b67bb165044 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -294,7 +294,7 @@ static int tiadc_start_dma(struct iio_dev *indio_dev)
>  static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
> -	int i, fifo1count, read;
> +	int i, fifo1count;
> =20
>  	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
>  				IRQENB_FIFO1OVRRUN |
> @@ -303,7 +303,7 @@ static int tiadc_buffer_preenable(struct iio_dev *ind=
io_dev)
>  	/* Flush FIFO. Needed in corner cases in simultaneous tsc/adc use */
>  	fifo1count =3D tiadc_readl(adc_dev, REG_FIFO1CNT);
>  	for (i =3D 0; i < fifo1count; i++)
> -		read =3D tiadc_readl(adc_dev, REG_FIFO1);
> +		tiadc_readl(adc_dev, REG_FIFO1);
> =20
>  	return 0;
>  }
> @@ -343,7 +343,7 @@ static int tiadc_buffer_predisable(struct iio_dev *in=
dio_dev)
>  {
>  	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
>  	struct tiadc_dma *dma =3D &adc_dev->dma;
> -	int fifo1count, i, read;
> +	int fifo1count, i;
> =20
>  	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
>  				IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW));
> @@ -358,7 +358,7 @@ static int tiadc_buffer_predisable(struct iio_dev *in=
dio_dev)
>  	/* Flush FIFO of leftover data in the time it takes to disable adc */
>  	fifo1count =3D tiadc_readl(adc_dev, REG_FIFO1CNT);
>  	for (i =3D 0; i < fifo1count; i++)
> -		read =3D tiadc_readl(adc_dev, REG_FIFO1);
> +		tiadc_readl(adc_dev, REG_FIFO1);
> =20
>  	return 0;
>  }

