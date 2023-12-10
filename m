Return-Path: <linux-iio+bounces-788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6249180BA6D
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F35B20A05
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B674882A;
	Sun, 10 Dec 2023 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnyKY92t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F8848D
	for <linux-iio@vger.kernel.org>; Sun, 10 Dec 2023 11:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BFDC433C7;
	Sun, 10 Dec 2023 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702208627;
	bh=VzyHZzlBa+R+7haIJrPEX/Rju0fHnHyZwgkAFn8Hv40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dnyKY92t745paSZDvyv6P1hMg+29NovkyuqwBRoKy4js8TbuHjJL3gfOvMmfuPLN5
	 CqbmxMjjhSEeAdcocPgtm0K7d2EH+zTyW5tCOiaC34r+tRnwmZDAHpMdyIxjfkZIxw
	 CuBZxdBlc8Si/qqXomya/rZZ9XejLAzEhVz/vNFNVNAWI3fGaaZ0t+f1UOmXe8lEjy
	 DEITM1mSWTq7QL2Sn0uMDUxGCPG3MIQt2VpyyYbZPxvQL1ByILeWlZQbG38GpDgt/9
	 zBizfDuLiPsw650iTha/ipl1EF0qKnvCFB6CWlZ5CrQaPBZuOwXgnjdOqI0op936yv
	 Ks3Uf5QUdJiUg==
Date: Sun, 10 Dec 2023 11:43:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 0/8] iio: ad9467 and axi-adc cleanups
Message-ID: <20231210114338.1189c2ea@jic23-huawei>
In-Reply-To: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Dec 2023 13:39:23 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> As requested in [1], this is a preparatory series with some basic cleanup=
s for
> the ad9467 and adi-axi-adc drivers.
>=20
> This means that the iio backend series [2] will depend on this one but
> hopefully we'll quickly get this one in.
>=20
> [1]: https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huaw=
ei/T/#ma7ed8a58d747e78e1ff2273c2d6cdd11de22f177
> [2]: https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huaw=
ei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
>=20
Series applied to the togreg branch of iio.git.
Note I haven't marked the fixes for stable, or taken them through the fixes=
 tree.
If you want them backported then please request that after the next merge w=
indow

Thanks,

Jonathan

> ---
> Changes in v2:
> - Patch 1.
>   * Use IS_ERR_OR_NULL() and PTR_ERR_OR_ZERO();
>   * Improved commit message (mention it's inverted polarity).
> - Patch 4:
>   * Properly allocate enough memory for the scale array;
>   * Use devm_kmalloc_array() as we don't need to zero initialize it;
>   * Don't multiple by 2 in the for() loop. We just want to go over the
>     rows.
> =20
> - Link to v1: https://lore.kernel.org/r/20231205-iio-backend-prep-v1-0-7c=
9bc18d612b@analog.com
>=20
> ---
> Nuno Sa (8):
>       iio: adc: ad9467: fix reset gpio handling
>       iio: adc: ad9467: don't ignore error codes
>       iio: adc: ad9467: add mutex to struct ad9467_state
>       iio: adc: ad9467: fix scale setting
>       iio: adc: ad9467: use spi_get_device_match_data()
>       iio: adc: ad9467: use chip_info variables instead of array
>       iio: adc: ad9467: use the more common !val NULL check
>       iio: adc: adi-axi-adc: convert to regmap
>=20
>  drivers/iio/adc/ad9467.c            | 207 +++++++++++++++++++++++-------=
------
>  drivers/iio/adc/adi-axi-adc.c       | 159 ++++++++++++---------------
>  include/linux/iio/adc/adi-axi-adc.h |   4 +
>  3 files changed, 204 insertions(+), 166 deletions(-)
> ---
> base-commit: 5c8f90655a7bdb6232b2cea6503df16367b11a53
> change-id: 20231205-iio-backend-prep-4d96ef364080
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


