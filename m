Return-Path: <linux-iio+bounces-17379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C06AA75B9C
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5655B188852C
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0901DA0E0;
	Sun, 30 Mar 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju/Qtg5S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E11DB34B;
	Sun, 30 Mar 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743357534; cv=none; b=XbcNFPEAkTAu5cxecivbDGDdkr1moNodkDVCHk7YOEFScVBxIiuN0SEnFB/4gWSkNlXsY9a0sFLAhc8ZIE5vi56RITR2HzOZ93+OWzoxoMcNJhwSfXCuOpTfmx/0u5/LFVxFy4uT1DV/m4PRJ4iKLxJYfZmbAitcHWv2KvBXXjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743357534; c=relaxed/simple;
	bh=79aGtxjNlKiOAi5eGQXEiSM2CUssUMKm+cOw/k6dctI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXphdpm6ngF3AypeVFcEuvY0J3pX63w6annCuXVZhZRFR7GV+7lXvrOugK2AWgFYTgaUGbhd3suDW3/hbFHG5smljXmy3fhgz8DcyJsmlWk1yg6x5JEJT6hSZs8BQ7L7/qnv7pl/+0IAlTgdyJB6uhEccdGXIK8v+hA93pogccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju/Qtg5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A28C4CEDD;
	Sun, 30 Mar 2025 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743357534;
	bh=79aGtxjNlKiOAi5eGQXEiSM2CUssUMKm+cOw/k6dctI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ju/Qtg5SAV9Q80vzBL7H46BrZSE4ujV1GLzakYOSU7fXOrScfiqQov+aQtCZjG1aE
	 U4a3N3ZHG1p2ADtosUKpvxhgieOlwEFA3qEpV6Y9x+vdVIoxk3dONCkXuxXjzewxso
	 aC1FAAo6tWPabvg9fQYtASqzw1/4p4UGxS+tCYd3FGmM5YGIKOoubmQfEo8fb0bL/t
	 rGF+W2yDbQvIn9OR6Mzi644/RldRkcb9EDtflsYQrKtoV2y8dQRMyqyCdg00bMAnNq
	 VOYSo48p/ByzHgwQERYNStwt4eJJaV5BRLe7bjoyIbWVfZw7k20o1uM7N1ojLPm0cg
	 IqZgSXqbPswlA==
Date: Sun, 30 Mar 2025 18:58:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 02/10] iio: adc: ad7606_spi: check error in
 ad7606B_sw_mode_config()
Message-ID: <20250330185845.1cc4cba4@jic23-huawei>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-2-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
	<20250318-iio-adc-ad7606-improvements-v2-2-4b605427774c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Mar 2025 17:52:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add missing error check in ad7606B_sw_mode_config().
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the togreg branch of iio.git.
For now pushed out as testing. I'll rebase on rc1 before pushing
it out as a non rebasing branch.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606_spi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 885bf0b68e7775c5f4a12dfb827f502d5f782e8c..c028e08efe2c82cd97249f98e=
ec50a9a9c06471f 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -174,11 +174,13 @@ static int ad7616_sw_mode_config(struct iio_dev *in=
dio_dev)
>  static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
>  {
>  	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =20
>  	/* Configure device spi to output on a single channel */
> -	st->bops->reg_write(st,
> -			    AD7606_CONFIGURATION_REGISTER,
> -			    AD7606_SINGLE_DOUT);
> +	ret =3D st->bops->reg_write(st, AD7606_CONFIGURATION_REGISTER,
> +				  AD7606_SINGLE_DOUT);
> +	if (ret)
> +		return ret;
> =20
>  	/*
>  	 * Scale can be configured individually for each channel
>=20


