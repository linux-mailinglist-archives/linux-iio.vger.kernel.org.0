Return-Path: <linux-iio+bounces-5627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0678D7594
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE141C20A0D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB453B290;
	Sun,  2 Jun 2024 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKVNc7ZT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F710795
	for <linux-iio@vger.kernel.org>; Sun,  2 Jun 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333792; cv=none; b=BwfZL5ztAW9w+ocgd7lC7vkyeuoRnIwF8eh+UiHGVlttK0bK/tptSAumia4QOyZxiUypYocHgzCMTMt+4lWQL5T7bx3CB+znAEJWeU3GeN0MB/vup5UksHymoTYHHhFnQfGLbMIAc1rz2pUCSr+0qvWJIlULqiqtTcudqK/m/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333792; c=relaxed/simple;
	bh=DEunoZQBJ8yC3YMZm9/UhJ6uKsGdwcLVKdSFeuN7ql0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjnRh6b3FJ+Pa0vWWqVXVgrMTQ9pSs4B5DgLYpvvl5m/kf0NiGcnLaWlrR/1tHkJBH1eS9rN2trjQI/AefT7OjeBudLD/xpomTKkmdIC+JwrcDwKeQ2R2VHj8GDagKzAQMbvk4aw1PfL1tYGwvCU/ASSnQ9ij1JthahBxPDFQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKVNc7ZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A18C2BBFC;
	Sun,  2 Jun 2024 13:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717333791;
	bh=DEunoZQBJ8yC3YMZm9/UhJ6uKsGdwcLVKdSFeuN7ql0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FKVNc7ZTpTQO+MzwwYtW42CihF9Bemzw4V/TBKkAX1ikoQ2jvjTYCQnEnP+XvbD8+
	 X8wO03uPqXBTyRYHpdxp/eTj9lYtndoUp81eparWkH8siqLpW2taoneu4Kvop8QA8B
	 pXK5EFHGQ2APoaDPmnuhSv/3T6b1Knbxck5y4PQ9soaiBXMG4dSulhJnEa4bq+YvYi
	 4ysb4dXtbj0jIvxY7/SMuituBUoBXwed5rsmG2AMoOXoaWtigoMc24yPO564sTGwuD
	 gR0Di7VbWalWx3LMKoGHIIyly5amWK9FqLL+i1gta7yPVuiYyuBszXZF3RStIef2ZU
	 WAZNRSkcDqKkg==
Date: Sun, 2 Jun 2024 14:09:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Ueti Fukunaga <gustavofukunaga@usp.br>
Cc: caiodantas@usp.br, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-adc161s626: make use of
 iio_device_claim_direct_scoped()
Message-ID: <20240602140940.7dc4fe94@jic23-huawei>
In-Reply-To: <20240527091942.53616-1-gustavofukunaga@usp.br>
References: <20240527091942.53616-1-gustavofukunaga@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 May 2024 06:19:40 -0300
Gustavo Ueti Fukunaga <gustavofukunaga@usp.br> wrote:

> Make use of iio_device_claim_direct_scoped() to make error handling more
> natural and simplify code.
>=20
> Co-developed-by: Caio Dantas Sim=C3=A3o Ug=C3=AAda <caiodantas@usp.br>
> Signed-off-by: Caio Dantas Sim=C3=A3o Ug=C3=AAda <caiodantas@usp.br>
> Signed-off-by: Gustavo Ueti Fukunaga <gustavofukunaga@usp.br>
Applied to the togreg branch of iio.git and initially pushed out as testing
for 0-day to poke at it and see what we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-adc161s626.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s=
626.c
> index b789891dc..f7c78d0dd 100644
> --- a/drivers/iio/adc/ti-adc161s626.c
> +++ b/drivers/iio/adc/ti-adc161s626.c
> @@ -137,17 +137,13 @@ static int ti_adc_read_raw(struct iio_dev *indio_de=
v,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D ti_adc_read_measurement(data, chan, val);
> -		iio_device_release_direct_mode(indio_dev);
> -
> -		if (ret)
> -			return ret;
> -
> -		return IIO_VAL_INT;
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			ret =3D ti_adc_read_measurement(data, chan, val);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT;
> +		}
> +		unreachable();
>  	case IIO_CHAN_INFO_SCALE:
>  		ret =3D regulator_get_voltage(data->ref);
>  		if (ret < 0)


