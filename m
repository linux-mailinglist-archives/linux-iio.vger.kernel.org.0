Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCB8167D53
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 13:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgBUMVV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 07:21:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgBUMVV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 07:21:21 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C80CF206EF;
        Fri, 21 Feb 2020 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582287679;
        bh=SzoxK55YANU74un0mDIQMr1necinE4YKS3fCLL0An9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m13QhdBWIn12Vi3xYU2a49RoFx7Rvr+z6V6DnAiXf1Lnl5XejsxtksYl2TfZ1ANW6
         Yci5OPut3Sby3Gk0sBgACWsJ4nWz2ScHUj4YY3D+peI+6kXI24DMr5tM5QxwGFjSCS
         xSuQLNZqgXIBv1956GNTe+/9EF3LYtpbzs0rz7K8=
Date:   Fri, 21 Feb 2020 12:21:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH 1/5] iio: buffer-dmaengine: add dev-managed calls for
 buffer alloc/free
Message-ID: <20200221122115.48d8ca90@archlinux>
In-Reply-To: <20200220150317.1864-1-alexandru.ardelean@analog.com>
References: <20200220150317.1864-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Feb 2020 17:03:13 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Currently, when using a 'iio_dmaengine_buffer_alloc()', an matching call =
to
> 'iio_dmaengine_buffer_free()' must be made.
>=20
> With this change, this can be avoided by using
> 'devm_iio_dmaengine_buffer_alloc()'. The buffer will get free'd via the
> device's devres handling.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../buffer/industrialio-buffer-dmaengine.c    | 70 +++++++++++++++++++
>  include/linux/iio/buffer-dmaengine.h          |  5 ++
>  2 files changed, 75 insertions(+)
>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers=
/iio/buffer/industrialio-buffer-dmaengine.c
> index b129693af0fd..eff89037e3f5 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -229,6 +229,76 @@ void iio_dmaengine_buffer_free(struct iio_buffer *bu=
ffer)
>  }
>  EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
> =20
> +static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *r=
es)
> +{
> +	iio_dmaengine_buffer_free(*(struct iio_buffer **)res);
> +}
> +
> +/**
> + * devm_iio_dmaengine_buffer_alloc() - Resource-managed iio_dmaengine_bu=
ffer_alloc()
> + * @dev: Parent device for the buffer
> + * @channel: DMA channel name, typically "rx".
> + *
> + * This allocates a new IIO buffer which internally uses the DMAengine f=
ramework
> + * to perform its transfers. The parent device will be used to request t=
he DMA
> + * channel.
> + *
> + * Once done using the buffer iio_dmaengine_buffer_free() should be used=
 to
> + * release it.

Umm.  It really shouldn't!

> + */
> +struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
> +	const char *channel)
> +{
> +	struct iio_buffer **bufferp, *buffer;
> +
> +	bufferp =3D devres_alloc(__devm_iio_dmaengine_buffer_free,
> +			       sizeof(*bufferp), GFP_KERNEL);
> +	if (!bufferp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	buffer =3D iio_dmaengine_buffer_alloc(dev, channel);
> +	if (!IS_ERR(buffer)) {
> +		*bufferp =3D buffer;
> +		devres_add(dev, bufferp);

=46rom a flow point of view I'd prefer.

	if (IS_ERR(buffer) {
		devres_free(buferp)
		return buffer;
	}

	*bufferp =3D buffer;
	devres_add(dev, bufferp);

	return buffer;


> +	} else {
> +		devres_free(bufferp);
> +	}
> +
> +	return buffer;
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_alloc);
> +
> +static int devm_iio_dmaengine_buffer_match(struct device *dev, void *res,
> +	void *data)
> +{
> +	struct iio_buffer **r =3D res;
> +
> +	if (!r || !*r) {
> +		WARN_ON(!r || !*r);
> +		return 0;
> +	}
> +
> +	return *r =3D=3D data;
> +}
> +
> +/**
> + * devm_iio_dmaengine_buffer_free - iio_dmaengine_buffer_free
> + * @dev: Device this iio_buffer belongs to
> + * @buffer: The iio_buffer associated with the device
> + *
> + * Free buffer allocated with devm_iio_dmaengine_buffer_alloc().
> + */
> +void devm_iio_dmaengine_buffer_free(struct device *dev,
> +	struct iio_buffer *buffer)
> +{
> +	int rc;
> +
> +	rc =3D devres_release(dev, __devm_iio_dmaengine_buffer_free,
> +			    devm_iio_dmaengine_buffer_match, buffer);
> +	WARN_ON(rc);
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_free);
> +
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>  MODULE_DESCRIPTION("DMA buffer for the IIO framework");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buf=
fer-dmaengine.h
> index b3a57444a886..8dcd973d76c1 100644
> --- a/include/linux/iio/buffer-dmaengine.h
> +++ b/include/linux/iio/buffer-dmaengine.h
> @@ -14,4 +14,9 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct de=
vice *dev,
>  	const char *channel);
>  void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
> =20
> +struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
> +	const char *channel);
> +void devm_iio_dmaengine_buffer_free(struct device *dev,
> +	struct iio_buffer *buffer);
Please align parameters with opening bracket where possible.

Thanks,

Jonathan

> +
>  #endif

