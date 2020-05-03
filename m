Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193011C2B66
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgECKiM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 06:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgECKiM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 06:38:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1975A20757;
        Sun,  3 May 2020 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588502291;
        bh=eMxME0+Eg46hELjOnYbsaxHgLKs+NXA38J0XX9hpq/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i4DKc0Hbip0XlgKqqKBe+kxGCpPuDxjngVTgqteHl5EN74mqSO98s6HvSu9y0vmWi
         BWttfHLlyJT/6+CqQXAbZcAHbKLf+OJkhxMoAKtMSw+/Yl3xkIofRGAX7+shmQX3KR
         qQmtHEaFCjagRLd6E6ftePGT5ZLfWF1zjQ56A0P8=
Date:   Sun, 3 May 2020 11:38:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rachna@ti.com>, <mugunthanvnm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>
Subject: Re: [PATCH 3/3] iio: adc: ti_am335x_adc: convert rest of probe to
 devm_ functions
Message-ID: <20200503113807.07c5237e@archlinux>
In-Reply-To: <20200428111430.71723-3-alexandru.ardelean@analog.com>
References: <20200428111430.71723-1-alexandru.ardelean@analog.com>
        <20200428111430.71723-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Apr 2020 14:14:30 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change converts the rest of the probe to use devm_ functions.
> Consequently this allows us to remove the remove hook.
>=20
> It tries to preserve the initial order or probe & remove.
> The devm_add_action() call hooks the cleanup routine (what's needed still
> for the remove part).
> If that doesn't work the DMA channel is cleaned up manually inside the
> probe hook. This done (like this) because the remove hook has a peculiar
> cleanup that tries to restore a step-mask, and that only seems to happen =
on
> the remove hook, and not in any probe error-cleanup paths.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

First two patches are fine, but this last one is (as you've noted) more
complex.  I'd like to cleanup the complexity rather than papering over
it.

So the real question is why we need to restore the step-mask on exit, but
not in other paths in the code.

=46rom what I recall (and it's been quite a lot of years) the step mask
is controlling the 'scan' so that we capture the set of enabled channels
and no others (there is a mux that is being controlled).

The current optimization is to not bother resetting that to empty when
we read individual channels, or come out of buffered mode because we
will set it anyway when moving to some new mode.

What I can't understand is why we need to set it in the exit path?
This is a complex corner given the involvement of the touchscreen
driver and mfd.  My first inclination is we may be better off leaving
it alone unless we have a test setup to make sure we fully understand
what is going on.

Given your stated reason for tidying this up was to deal with the
buffer stuff and this has no impact on that, I'll take patches 1 and 2 for
now and leave this one out.

However, I'd like to leave more time for comments on those two as well
(though they seem 'obviously' correct to me).

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ti_am335x_adc.c | 63 +++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_=
adc.c
> index 03b2ab649cc3..9fac83e036c1 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -562,6 +562,18 @@ static int tiadc_request_dma(struct platform_device =
*pdev,
>  	return -ENOMEM;
>  }
> =20
> +static void tiadc_cleanup_dma(struct tiadc_device *adc_dev)
> +{
> +	struct tiadc_dma *dma =3D &adc_dev->dma;
> +
> +	if (!dma->chan)
> +		return;
> +
> +	dma_free_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
> +			  dma->buf, dma->addr);
> +	dma_release_channel(dma->chan);
> +}
> +
>  static int tiadc_parse_dt(struct platform_device *pdev,
>  			  struct tiadc_device *adc_dev)
>  {
> @@ -593,6 +605,17 @@ static int tiadc_parse_dt(struct platform_device *pd=
ev,
>  	return 0;
>  }
> =20
> +static void tiadc_cleanup(void *data)
> +{
> +	struct tiadc_device *adc_dev =3D data;
> +	u32 step_en;
> +
> +	tiadc_cleanup_dma(adc_dev);
> +
> +	step_en =3D get_adc_step_mask(adc_dev);
> +	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
> +}
> +
>  static int tiadc_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev		*indio_dev;
> @@ -635,48 +658,27 @@ static int tiadc_probe(struct platform_device *pdev)
>  		IRQF_SHARED,
>  		&tiadc_buffer_setup_ops);
> =20
> +	err =3D devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (err)
> -		goto err_free_channels;
> -
> -	err =3D iio_device_register(indio_dev);
> -	if (err)
> -		goto err_buffer_unregister;
> +		return err;
> =20
>  	platform_set_drvdata(pdev, indio_dev);
> =20
>  	err =3D tiadc_request_dma(pdev, adc_dev);
>  	if (err && err =3D=3D -EPROBE_DEFER)
> -		goto err_dma;
> +		return err;
> +
> +	err =3D devm_add_action(&pdev->dev, tiadc_cleanup, adc_dev);
> +	if (err)
> +		goto err_free_dma;
> =20
>  	return 0;
> =20
> -err_dma:
> -	iio_device_unregister(indio_dev);
> -err_buffer_unregister:
> -err_free_channels:
> +err_free_dma:
> +	tiadc_cleanup_dma(adc_dev);
>  	return err;
>  }
> =20
> -static int tiadc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> -	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
> -	struct tiadc_dma *dma =3D &adc_dev->dma;
> -	u32 step_en;
> -
> -	if (dma->chan) {
> -		dma_free_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
> -				  dma->buf, dma->addr);
> -		dma_release_channel(dma->chan);
> -	}
> -	iio_device_unregister(indio_dev);
> -
> -	step_en =3D get_adc_step_mask(adc_dev);
> -	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
> -
> -	return 0;
> -}
> -
>  static int __maybe_unused tiadc_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> @@ -723,7 +725,6 @@ static struct platform_driver tiadc_driver =3D {
>  		.of_match_table =3D ti_adc_dt_ids,
>  	},
>  	.probe	=3D tiadc_probe,
> -	.remove	=3D tiadc_remove,
>  };
>  module_platform_driver(tiadc_driver);
> =20

