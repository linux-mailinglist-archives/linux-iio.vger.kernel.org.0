Return-Path: <linux-iio+bounces-4654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B58B6347
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 22:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E9EB21629
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1383F1411F7;
	Mon, 29 Apr 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD1Y5ukO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6C1411EF
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421495; cv=none; b=BFXvHhIKe7K7YMTAu1UWAy0lY6qXLYgiYekhl/Z/IA4A3CZBT3J0OlghYcGlUhPtF1fSk6+Ug8KOCwa27HalPjF8NblqPLhWPylXDetjz+N04oBXYsrtpjjU4l0unULM4KzhbyyOi8VZv5jL8b2TTWzIvQ1SKPNukduvWaGBrtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421495; c=relaxed/simple;
	bh=G3/WSogBbq91sBmKgNmksVVU/d/7YnvDMgutXyISjYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CITVIwikU3mVo83Q63H1Ai9tbtImMYt9bMRgoz+rNwdVGJMe3P2yNvHUehou1FRxoxPwP1Zj0cI2jovdkN4ue2hMfFp7EucNBHnWrqhcVqzBCqgjNkM93g04bQjP9xpyVRRqRL3wcA0jQNikbM8eMLC1hxoSk5BzvJDXvIsXZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD1Y5ukO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC17C4AF19;
	Mon, 29 Apr 2024 20:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714421495;
	bh=G3/WSogBbq91sBmKgNmksVVU/d/7YnvDMgutXyISjYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lD1Y5ukOZWVumcyC6B/WTDf7asx3kYizBhS3czM0rb6iBSdTp/Nz1WxDd2nBeCkLP
	 09cKPEc6yI8AA4iY4Z2bzcKT1Vlve2U5FzrT5+exBeea7S6iSetOUWaAQmxlBnGbfL
	 DUeAG8ilviUCZR5ddPZLn8JxmUppKN/KEJRY0U2m37cVGrOpP3a7RFi+nNf5q6FkVm
	 DRS5w6TVe2WwhfSWfkq6TfOlL2I0ay+TQt+qydx6ph1KE2dX+T8azocwzIg2JMduy6
	 t1ZNZbPuea8k4e1WN7ApG4W1xJuGv2TPptBki1Zedh5wou6wKcbBqOH6gSEfCKPTEc
	 bSdRKe8AXeucQ==
Date: Mon, 29 Apr 2024 21:11:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>
Subject: Re: [PATCH] iio: dac: ad9739a: write complete MU_CNT1 register
 during lock
Message-ID: <20240429211127.79dc2430@jic23-huawei>
In-Reply-To: <20240429-ad9739a-improv-v1-1-c076a06a697d@analog.com>
References: <20240429-ad9739a-improv-v1-1-c076a06a697d@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2024 15:54:39 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> As specified by the datasheet we should write the value 0x3 (enable
> plus tracking gain) into the MU_CNT1 register during the MU lock phase.
>=20
> Currently we were only setting the enable bit (bit 0) as the tracking
> gain default value is already set to 1. While we should be mostly fine
> in assuming the tracking gain will have the value it should, better to
> explicitly write it. On top of that the datasheet also states to
> re-attempt the writes in case the lock fails which we were not doing for
> the tracking gain bit.
>=20
> Lastly, the recommended value for the MU phase slope lock (bit 6) is 0
> but for some reason the default value is 1 and hence, we were not
> changing it accordingly.
>=20
> Note there was no problem with the MU lock mechanism so this is not
> being treated as a fix but rather an improvement.
>=20
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied.

> ---
>  drivers/iio/dac/ad9739a.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
> index ff33120075bf..f56eabe53723 100644
> --- a/drivers/iio/dac/ad9739a.c
> +++ b/drivers/iio/dac/ad9739a.c
> @@ -45,6 +45,7 @@
>  #define AD9739A_REG_MU_DUTY		0x25
>  #define AD9739A_REG_MU_CNT1		0x26
>  #define   AD9739A_MU_EN_MASK		BIT(0)
> +#define   AD9739A_MU_GAIN_MASK		BIT(1)
>  #define AD9739A_REG_MU_CNT2		0x27
>  #define AD9739A_REG_MU_CNT3		0x28
>  #define AD9739A_REG_MU_CNT4		0x29
> @@ -220,8 +221,8 @@ static int ad9739a_init(struct device *dev, const str=
uct ad9739a_state *st)
>  			return ret;
> =20
>  		/* Enable the Mu controller search and track mode. */
> -		ret =3D regmap_set_bits(st->regmap, AD9739A_REG_MU_CNT1,
> -				      AD9739A_MU_EN_MASK);
> +		ret =3D regmap_write(st->regmap, AD9739A_REG_MU_CNT1,
> +				   AD9739A_MU_EN_MASK | AD9739A_MU_GAIN_MASK);
>  		if (ret)
>  			return ret;
> =20
>=20
> ---
> base-commit: b22457f6c572c1b453207d13613a4e476d3dd0fb
> change-id: 20240429-ad9739a-improv-adeda16e0dd5
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


