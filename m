Return-Path: <linux-iio+bounces-20082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9666AC9BDE
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 19:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFA39E4D25
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AC01494A8;
	Sat, 31 May 2025 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUnA6Hly"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AEA45C14;
	Sat, 31 May 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748711280; cv=none; b=ooY0w+wz5FFp5eAJaODxPXaD2F+jK5MhlVQwBFk3BHs8uUnJW6o52f+uVJb2ngDWbrLN95ISC7v2k8L2thMfZHelO/J8eQmecmnIz2Xgua4BGk967m6M0Sn9+3iTh6Vg8x3bs50LDMGFQaHD4KRLfpfg+C9hXWXq7xiXEW8VCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748711280; c=relaxed/simple;
	bh=aSOMo378xDNB/Q1bUszkJNg9T/8HO79eDD4pINt+f9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwS9lqhhHKNC3d1O4B536QAeQSBHe6beIeYsRzTPe41QO30VOaTi1Df1Iluh1/E9RGx0JJAkPTuzGQPw+ZtjC0o7F5hQe9HN0PIaw+CimJgFjtF2UHW+nInRdRRFJA557B8gChV/9HsWSLvQqYS7EfHNlFWsmA/eB3PzsjVXqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUnA6Hly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7B2C4CEEE;
	Sat, 31 May 2025 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748711279;
	bh=aSOMo378xDNB/Q1bUszkJNg9T/8HO79eDD4pINt+f9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UUnA6HlyqXLjdyhxTOguPm9aghp8EJvU+JZ1h2VkY7aZ3E5DtJ8DUgmBAP5YHYmgI
	 zkWDrc0Y0tv37uSFMcENWdlDDVi+B8E5ZXsCd4/4ekrtPfex3nQN4aVjCiF4pUVtFg
	 qPEBihGQQmbAXNiqLpjTjtMvzf6COL4eX26EA+DCqpM3om+bHHS54BF4PhWloXxU9B
	 n0rTuq7xARSM55BRpsjxtQha1p3sSEc4g5Pz9gQdzoM9YQ3L1KO87QfHX9Y7mITTDj
	 3/EKwmjYU5dSpgtx/LZKB5+N0mgmvkA0fIk3horV5Y1Jwz6kY8jk6m1RpBEEdPpJw8
	 spjLU1yWCphGQ==
Date: Sat, 31 May 2025 18:07:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ad4080: use lowercase device name
Message-ID: <20250531180753.12357ec5@jic23-huawei>
In-Reply-To: <20250526082228.4961-1-antoniu.miclaus@analog.com>
References: <20250526082228.4961-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 May 2025 11:22:27 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Update the .name field in the ad4080_chip_info struct
> from "AD4080" to "ad4080" to follow the common convention
> in IIO drivers of using lowercase names for device identifiers.
>=20
> Fixes: 1ff3f56f846b ("iio: adc: ad4080: add driver support")
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
I squashed both patches into the original commit as that is still
on a tree that I can rebase as I'll do that on rc1 anyway once available.

Thanks,

Jonathan

> ---
> changes in v2:
>  - drop "no functional changes" from commit body
>  - add fixes tag
>  drivers/iio/adc/ad4080.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index e8b2e5e7a68a..c36eb41d738a 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -433,7 +433,7 @@ static const struct iio_chan_spec ad4080_channel =3D {
>  };
> =20
>  static const struct ad4080_chip_info ad4080_chip_info =3D {
> -	.name =3D "AD4080",
> +	.name =3D "ad4080",
>  	.product_id =3D AD4080_CHIP_ID,
>  	.scale_table =3D ad4080_scale_table,
>  	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),


