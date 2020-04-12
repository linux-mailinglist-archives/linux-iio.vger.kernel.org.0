Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1871C1A5E99
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgDLMvH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 08:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgDLMvH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 08:51:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B04520656;
        Sun, 12 Apr 2020 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586695866;
        bh=vgOYoTgOemKNQXEJrgLImC5TrfmXS/SaE4m2AACqjh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O9bhQsx52SQeVJXVreqqEqJTa1r3904Tz6Hzpilhr2AWF29FtjC4ZSHamWqdzPuUI
         D0P5U4vnH7/2jHLGlcU2O8tUrTm0Iv00gJiMI3Ey6oGji0Zx4GK8bKdYQb+ZwFk0XW
         2gITU01zqBsI+bOFBUdkSIUNYtc9AJITIkKqvRro=
Date:   Sun, 12 Apr 2020 13:51:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] iio: core: drop devm_iio_trigger_unregister() API
 call
Message-ID: <20200412135103.5723715f@archlinux>
In-Reply-To: <20200227135227.12433-4-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
        <20200227135227.12433-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 15:52:23 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It's unused so far, so it can't be removed. Also makes sense to remove it
> to discourage weird uses of this call during review.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  .../driver-api/driver-model/devres.rst        |  1 -
>  Documentation/driver-api/iio/triggers.rst     |  1 -
>  drivers/iio/industrialio-trigger.c            | 21 -------------------
>  include/linux/iio/trigger.h                   |  3 ---
>  4 files changed, 26 deletions(-)
>=20
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documenta=
tion/driver-api/driver-model/devres.rst
> index 6ae6c67dfec0..f638a035e6d2 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -291,7 +291,6 @@ IIO
>    devm_iio_trigger_alloc()
>    devm_iio_trigger_free()
>    devm_iio_trigger_register()
> -  devm_iio_trigger_unregister()
>    devm_iio_channel_get()
>    devm_iio_channel_release()
>    devm_iio_channel_get_all()
> diff --git a/Documentation/driver-api/iio/triggers.rst b/Documentation/dr=
iver-api/iio/triggers.rst
> index 5c2156de6284..160faa810d12 100644
> --- a/Documentation/driver-api/iio/triggers.rst
> +++ b/Documentation/driver-api/iio/triggers.rst
> @@ -6,7 +6,6 @@ Triggers
>  * :c:func:`devm_iio_trigger_alloc` =E2=80=94 Resource-managed iio_trigge=
r_alloc
>  * :c:func:`devm_iio_trigger_free` =E2=80=94 Resource-managed iio_trigger=
_free
>  * :c:func:`devm_iio_trigger_register` =E2=80=94 Resource-managed iio_tri=
gger_register
> -* :c:func:`devm_iio_trigger_unregister` =E2=80=94 Resource-managed
>    iio_trigger_unregister
>  * :c:func:`iio_trigger_validate_own_device` =E2=80=94 Check if a trigger=
 and IIO
>    device belong to the same device
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
> index 3908a9a90035..611f608a9da2 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -673,9 +673,6 @@ static void devm_iio_trigger_unreg(struct device *dev=
, void *res)
>   * calls iio_trigger_register() internally. Refer to that function for m=
ore
>   * information.
>   *
> - * If an iio_trigger registered with this function needs to be unregiste=
red
> - * separately, devm_iio_trigger_unregister() must be used.
> - *
>   * RETURNS:
>   * 0 on success, negative error number on failure.
>   */
> @@ -701,24 +698,6 @@ int __devm_iio_trigger_register(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(__devm_iio_trigger_register);
> =20
> -/**
> - * devm_iio_trigger_unregister - Resource-managed iio_trigger_unregister=
()
> - * @dev:	device this iio_trigger belongs to
> - * @trig_info:	the trigger associated with the device
> - *
> - * Unregister trigger registered with devm_iio_trigger_register().
> - */
> -void devm_iio_trigger_unregister(struct device *dev,
> -				 struct iio_trigger *trig_info)
> -{
> -	int rc;
> -
> -	rc =3D devres_release(dev, devm_iio_trigger_unreg, devm_iio_trigger_mat=
ch,
> -			    trig_info);
> -	WARN_ON(rc);
> -}
> -EXPORT_SYMBOL_GPL(devm_iio_trigger_unregister);
> -
>  bool iio_trigger_using_own(struct iio_dev *indio_dev)
>  {
>  	return indio_dev->trig->attached_own_device;
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 84995e2967ac..cad8325903f9 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -141,9 +141,6 @@ int __devm_iio_trigger_register(struct device *dev,
>   **/
>  void iio_trigger_unregister(struct iio_trigger *trig_info);
> =20
> -void devm_iio_trigger_unregister(struct device *dev,
> -				 struct iio_trigger *trig_info);
> -
>  /**
>   * iio_trigger_set_immutable() - set an immutable trigger on destination
>   *

