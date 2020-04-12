Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624261A5E9C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 14:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgDLM52 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 08:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDLM52 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 08:57:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8368820656;
        Sun, 12 Apr 2020 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586696248;
        bh=hZPCKQzG0NL3TEQaXQBJ40NpDiVf8MbqyHuX7J4LUdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zfK9ok1s5asn9ERXHBfAiWNjNoeN5PPQDBoJZvBMcjE5j+Wu95Eiz4WInsTe5Oucd
         vP859rmjyNb85JJsQN6ZQq3BLdK+dhvhtOeWYDoJ5WSnmgv+hqLe3F998PclS5iLcS
         eONM5BfWTrVUlENEHSweDh5EaIBon4Z5h8NWCSY4=
Date:   Sun, 12 Apr 2020 13:57:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] iio: core: drop devm_iio_trigger_free() API call
Message-ID: <20200412135723.4b80bfce@archlinux>
In-Reply-To: <20200227135227.12433-5-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
        <20200227135227.12433-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 15:52:24 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It's unused so far, so it can't be removed. Also makes sense to remove it
> to discourage weird uses of this call during review.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.  For reasons I'm not sure of the character encoding
on these seems to be messed up.  I'm fixing it by hand, so hopefully
it won't break anything.

Thanks,

Jonathan

> ---
>  .../driver-api/driver-model/devres.rst        |  1 -
>  Documentation/driver-api/iio/triggers.rst     |  1 -
>  drivers/iio/industrialio-trigger.c            | 32 -------------------
>  include/linux/iio/iio.h                       |  2 --
>  4 files changed, 36 deletions(-)
>=20
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documenta=
tion/driver-api/driver-model/devres.rst
> index f638a035e6d2..6c401c74e480 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -289,7 +289,6 @@ IIO
>    devm_iio_kfifo_free()
>    devm_iio_triggered_buffer_setup()
>    devm_iio_trigger_alloc()
> -  devm_iio_trigger_free()
>    devm_iio_trigger_register()
>    devm_iio_channel_get()
>    devm_iio_channel_release()
> diff --git a/Documentation/driver-api/iio/triggers.rst b/Documentation/dr=
iver-api/iio/triggers.rst
> index 160faa810d12..dfd7ba3eabde 100644
> --- a/Documentation/driver-api/iio/triggers.rst
> +++ b/Documentation/driver-api/iio/triggers.rst
> @@ -4,7 +4,6 @@ Triggers
> =20
>  * struct :c:type:`iio_trigger` =E2=80=94 industrial I/O trigger device
>  * :c:func:`devm_iio_trigger_alloc` =E2=80=94 Resource-managed iio_trigge=
r_alloc
> -* :c:func:`devm_iio_trigger_free` =E2=80=94 Resource-managed iio_trigger=
_free
>  * :c:func:`devm_iio_trigger_register` =E2=80=94 Resource-managed iio_tri=
gger_register
>    iio_trigger_unregister
>  * :c:func:`iio_trigger_validate_own_device` =E2=80=94 Check if a trigger=
 and IIO
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
> index 611f608a9da2..53d1931f6be8 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -585,18 +585,6 @@ static void devm_iio_trigger_release(struct device *=
dev, void *res)
>  	iio_trigger_free(*(struct iio_trigger **)res);
>  }
> =20
> -static int devm_iio_trigger_match(struct device *dev, void *res, void *d=
ata)
> -{
> -	struct iio_trigger **r =3D res;
> -
> -	if (!r || !*r) {
> -		WARN_ON(!r || !*r);
> -		return 0;
> -	}
> -
> -	return *r =3D=3D data;
> -}
> -
>  /**
>   * devm_iio_trigger_alloc - Resource-managed iio_trigger_alloc()
>   * @dev:		Device to allocate iio_trigger for
> @@ -608,9 +596,6 @@ static int devm_iio_trigger_match(struct device *dev,=
 void *res, void *data)
>   * Managed iio_trigger_alloc.  iio_trigger allocated with this function =
is
>   * automatically freed on driver detach.
>   *
> - * If an iio_trigger allocated with this function needs to be freed sepa=
rately,
> - * devm_iio_trigger_free() must be used.
> - *
>   * RETURNS:
>   * Pointer to allocated iio_trigger on success, NULL on failure.
>   */
> @@ -640,23 +625,6 @@ struct iio_trigger *devm_iio_trigger_alloc(struct de=
vice *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_trigger_alloc);
> =20
> -/**
> - * devm_iio_trigger_free - Resource-managed iio_trigger_free()
> - * @dev:		Device this iio_dev belongs to
> - * @iio_trig:		the iio_trigger associated with the device
> - *
> - * Free iio_trigger allocated with devm_iio_trigger_alloc().
> - */
> -void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_t=
rig)
> -{
> -	int rc;
> -
> -	rc =3D devres_release(dev, devm_iio_trigger_release,
> -			    devm_iio_trigger_match, iio_trig);
> -	WARN_ON(rc);
> -}
> -EXPORT_SYMBOL_GPL(devm_iio_trigger_free);
> -
>  static void devm_iio_trigger_unreg(struct device *dev, void *res)
>  {
>  	iio_trigger_unregister(*(struct iio_trigger **)res);
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 2920c065ab9b..1a5d3d630ec1 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -689,8 +689,6 @@ void iio_device_free(struct iio_dev *indio_dev);
>  struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_pri=
v);
>  struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
>  						const char *fmt, ...);
> -void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_t=
rig);
> -
>  /**
>   * iio_buffer_enabled() - helper function to test if the buffer is enabl=
ed
>   * @indio_dev:		IIO device structure for device

