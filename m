Return-Path: <linux-iio+bounces-14567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AB2A1C31B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9073A6D52
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBE4207E1C;
	Sat, 25 Jan 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaKOYKv+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F291DD866;
	Sat, 25 Jan 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737807750; cv=none; b=KmsOyAibiicOjuKPINnJwKf4awoUl+pL/C3R2h8pUyNmYR8ELlZB6bMysbw6afvpYotdv3HamYFriIdGAOB/T19KotbNbMVE37vl7Y4ixKyu0GV0SsGrStho1NNgwtUBbie5NWx/kuGQMKJ1TE1hPiRwhh1cG8sQD3gB1eMqylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737807750; c=relaxed/simple;
	bh=V2RbzYdRzP0EzeTk6XJZdIM+fzGkgX1dGpIzp7UF2xU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hT+BbSjRi4Hnhrsfryoejhi7iDaopCS2q+IH1QWbTV86cmF76jJfd7gtI5ztD+aMiPTT7KSYuZ7W32zytS8mG49JPfI9E0jPkfPOgFbtrt1Lw11G3ujHHaq3bis4PvJF0cZ6UoEjMkinqmb+yVvP8HYIjC+DWiPdbO49hiNrwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaKOYKv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7075DC4CED6;
	Sat, 25 Jan 2025 12:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737807750;
	bh=V2RbzYdRzP0EzeTk6XJZdIM+fzGkgX1dGpIzp7UF2xU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YaKOYKv+sSLlUHu/p6brvOI5p65o39mnAdDgJSZT6nDzzIROa0OswDmXdvsstk9ck
	 Lu5Q4fGZeC67Tdengo5uqbDUiNdY70HolB0i0jnwHiCtKhuUfr6ubtOYh+HBx9M/Jy
	 zYokhdpj08i9/JebUHJXlblZeQP+4jquy6/92yurayxanRN+itfyLEEmvg5k/LPQJ7
	 qx/SWcU5Tme0JLlY/z8rmuzuPenhqPjUp/BXkyUmCglf+mmH6okgKW9yikpSk8oF6C
	 5Q/aYJUPjjRAl+ypWHuQxG9PbE7tE9RVqU4FP1bhylXCFAPP7oaUUXi5cUCcuizYiN
	 31fxJVtvfkWKA==
Date: Sat, 25 Jan 2025 12:22:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>
Subject: Re: [PATCH v2] iio: adc: ad7192: fix channel select
Message-ID: <20250125122222.22e3285a@jic23-huawei>
In-Reply-To: <20250124150703.97848-1-markus.burri@mt.com>
References: <20250124150703.97848-1-markus.burri@mt.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jan 2025 16:07:03 +0100
Markus Burri <markus.burri@mt.com> wrote:

> Channel configuration doesn't work as expected.
> For FIELD_PREP the bit mask is needed and not the bit number.
>=20
> Fixes: 874bbd1219c7 ("iio: adc: ad7192: Use bitfield access macros")
needs to be part of the tags block.  Hence no blank line here.

I'll tidy that up whilst applying.  Applied and marked for stable.
Note I'll not push out my tree until I can rebase on rc1 after
next weekend as right now it would make a mess of linux-next.
>=20
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 1c87db0e0460..c4effe8429c8 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1082,7 +1082,7 @@ static int ad7192_update_scan_mode(struct iio_dev *=
indio_dev, const unsigned lon
> =20
>  	conf &=3D ~AD7192_CONF_CHAN_MASK;
>  	for_each_set_bit(i, scan_mask, 8)
> -		conf |=3D FIELD_PREP(AD7192_CONF_CHAN_MASK, i);
> +		conf |=3D FIELD_PREP(AD7192_CONF_CHAN_MASK, BIT(i));
> =20
>  	ret =3D ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, conf);
>  	if (ret < 0)
>=20
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04


