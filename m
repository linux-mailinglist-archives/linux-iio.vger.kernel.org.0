Return-Path: <linux-iio+bounces-12864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2E99DF22E
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9CF161B6B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329FA1A4E76;
	Sat, 30 Nov 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK02S26j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B938468;
	Sat, 30 Nov 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732986776; cv=none; b=fMo1oLTT0QKgzwEGDUbtsgmMxgH4y/w2Jme5sUx+eKZHgcT1+8mUl1mRHCi0jJP919qfSURMwrPE+h5Gqe4nAqR9lG2+SsoWcwJSDXdDvMTQa34okMwCnnkm/i0rHhRYy3/mPgZ6wXVFOo9MTH+YqwYOr5jrwDYI/81/Hr6YO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732986776; c=relaxed/simple;
	bh=mclOeHKXTviqa2nAEWpR1AB1SceKiSEI5tptOapR1Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMJarBfZCaum3JNdKxiQ/GAoYqYf+5sgnv+wMVCRRvPXAGSfxFMZGQdtrwz3ftUBROcOwAVMK9Vdn9/V859tES2g2mMySFVNWtyh/KZlX1JYBeh0CUaphvUAeabUBJAGHG31wwEx5+fCjGYnG6TcKAdr3qbeZSiQRy/UCuZQypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK02S26j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D476C4CECC;
	Sat, 30 Nov 2024 17:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732986775;
	bh=mclOeHKXTviqa2nAEWpR1AB1SceKiSEI5tptOapR1Ac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qK02S26jjLTGhuAFsOEGad+qmKoyAld114+qhrLe7F3z4Srw/C3e6AzTD6gKWXYJx
	 TGaQni+y8Yb4R/roIHqQC8VPr0d5K9lVDEiQpfv4gURystQVB7qTI33TM8pUjdUmkh
	 K0mXVlJgKGqc1tp+tfTOR4KGU52XDSkEiTNaJNbOXDYLcmzPn0vu2qezlz+q+7aufV
	 7H1MbYrZGvnikxIBBm//iVWZh8/bOV7o1P0gC/g7iSmcBnacZ/0GK96QprfXYG9MBp
	 J6YtzhEFwMY6o3wMsU3pPkPSjQv5aJ+UdkQVPs3faa1DumhljO0Y6QV/DCRm+eyeT+
	 4ubuG1rAjvJzQ==
Date: Sat, 30 Nov 2024 17:12:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 3/7] iio: imu: adis: Add reset to custom ops
Message-ID: <20241130171244.1a05b5de@jic23-huawei>
In-Reply-To: <20241125133520.24328-4-robert.budai@analog.com>
References: <20241125133520.24328-1-robert.budai@analog.com>
	<20241125133520.24328-4-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2024 15:35:10 +0200
Robert Budai <robert.budai@analog.com> wrote:

> This patch allows the custom definition of reset funcitonality
> for adis object. It is useful in cases where the reset does not
> need to sleep after the reset since it is handled by the library.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>=20
> v2:
> -added reset ops as a different patch
> - signed of by submitter
>=20
>  drivers/iio/imu/adis.c       | 7 +++++--
>  include/linux/iio/imu/adis.h | 3 +++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index fa7a817b7d99..865f7c56717a 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -339,8 +339,11 @@ int __adis_reset(struct adis *adis)
>  	int ret;
>  	const struct adis_timeout *timeouts =3D adis->data->timeouts;
> =20
> -	ret =3D __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
> -				 ADIS_GLOB_CMD_SW_RESET);
> +	if (adis->ops->reset)
> +		ret =3D adis->ops->reset(adis);
> +	else
> +		ret =3D __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
> +					 ADIS_GLOB_CMD_SW_RESET);
#
May be simpler to use default ops and always have a reset callback.

  	if (ret) {
>  		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
>  		return ret;
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 89cfa75ae9ea..52652f51db2e 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -98,12 +98,15 @@ struct adis_data {
>   * struct adis_ops: Custom ops for adis devices.
>   * @write: Custom spi write implementation.
>   * @read: Custom spi read implementation.
> + * @reset: Custom sw reset implementation. The custom implementation doe=
s not
> + *	   need to sleep after the reset. It's done by the library already.
>   */
>  struct adis_ops {
>  	int (*write)(struct adis *adis, unsigned int reg, unsigned int value,
>  		     unsigned int size);
>  	int (*read)(struct adis *adis, unsigned int reg, unsigned int *value,
>  		    unsigned int size);
> +	int (*reset)(struct adis *adis);
>  };
> =20
>  /**


