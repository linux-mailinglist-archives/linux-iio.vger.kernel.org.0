Return-Path: <linux-iio+bounces-10783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DB29A4E7B
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F4E286E58
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673F28EF;
	Sat, 19 Oct 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/txGk8D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D9623
	for <linux-iio@vger.kernel.org>; Sat, 19 Oct 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729346529; cv=none; b=nfOzyQgbSf1hvgjgfwT0DVU3iqk8wH3k5PDzvJ7VXclZs9uDIrM/VAqCt41XnFFC4laZDxhVlR6BCATWOdObdhX3I9HRrZurJGP4QBJTI5cYrcb0W7HVDk+aUrQFyqDT8rsp2Pkv/b8QN3JNUHYdkv3X6sV/vhA1GE1bTysobj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729346529; c=relaxed/simple;
	bh=T4EiPweNe+vz6QmiJXjmpL+GncLb6t3H0CnWlmUlWLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZU+UmzpImS1xrs301xb5h1G5q+munU/VUucCNbjDSbRQnIzcNNrVJtGPGXwnkMstewPAJvU/reEMKY5DNa/fCJCEiKEM/uMdz1WrfC1/ZQPTTQjfJS3Xms+UVDXNg+055IjNbnYtEFANFT7xEjTVP6iY6AQVtBpI5XuxldcVJxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/txGk8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FD4C4CEC5;
	Sat, 19 Oct 2024 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729346528;
	bh=T4EiPweNe+vz6QmiJXjmpL+GncLb6t3H0CnWlmUlWLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G/txGk8D/d7jHZWaOhkF/TeeU/3B2oO1NNeImOStwK+wMRDFX18nU3rR0WppFeO6C
	 qkzOSRJMBFnCNs5+L1ZftNxFl0O5/xWvD7gwa3ApOfJyC3QKXe8lI+rhCse6J5FhU4
	 6A7bjAjbx8Ew8zyROI8MkMJDoRE7MSZYcWKWZiIt+NBeW8nNR4k5o/12bKzj0TpyrH
	 JZ1tlyHtot/+YiGnb/WVwtBmVEGUGXlLr414tdyYVGf0zkO6bGwAP7HcbeP0CqFdg0
	 qlXZ/qzlFzQ0knNyRARPceNa46fd+8+YJIiuLIU+fW1NG/L7kWqFpmwyOkOlcjVEF1
	 UqWKRh+G0RDdw==
Date: Sat, 19 Oct 2024 15:01:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: adc: ad7192: properly check
 spi_get_device_match_data()
Message-ID: <20241019150145.07fcda7d@jic23-huawei>
In-Reply-To: <20241014-fix-error-check-v1-1-089e1003d12f@analog.com>
References: <20241014-fix-error-check-v1-1-089e1003d12f@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2024 17:01:21 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> spi_get_device_match_data() can return a NULL pointer. Hence, let's
> check for it.
>=20
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied.
> ---
>  drivers/iio/adc/ad7192.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 7042ddfdfc03ee5ea58ca07fb1943feb6538175b..955e9eff0099e5c91491ca5b1=
f836534ac0db2f9 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1394,6 +1394,9 @@ static int ad7192_probe(struct spi_device *spi)
>  	st->int_vref_mv =3D ret =3D=3D -ENODEV ? avdd_mv : ret / MILLI;
> =20
>  	st->chip_info =3D spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return -ENODEV;
> +
>  	indio_dev->name =3D st->chip_info->name;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
>  	indio_dev->info =3D st->chip_info->info;
>=20
> ---
> base-commit: 465644ac29536d10178b5ca4684d0b84765b9fa4
> change-id: 20241014-fix-error-check-d34fde9780a2
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


