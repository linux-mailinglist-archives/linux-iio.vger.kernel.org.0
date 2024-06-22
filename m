Return-Path: <linux-iio+bounces-6709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8254B9132E9
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 11:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF1E1C215EB
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B85314D43D;
	Sat, 22 Jun 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztm1Gbkr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2214B965;
	Sat, 22 Jun 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719049415; cv=none; b=IxHKDg5ZdBYveLBmklzwTlHOIO4RuM5YS+CQqnnkNlCrKQQ1m3cysMArjrlp7KbdVwMH0x1lIUFqHyl21oTF8A8jFOqWVt4frhZlVtTt72rXZH3BnvnuiUGRo//prm8HG8BXjAWw5DMAhrYTtnG2W21hwfVK1kMfOkiatNEfvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719049415; c=relaxed/simple;
	bh=uECyP60yqfaB0U3mswQAJu4fxkYx/BeROCYGGUgcZH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNT1Em7YLJRXQeC0ElE7XwjxEQAkb2e7f8X3hCyE2zb1Bz+vIL8IWzjaSf8mVWdGDJjzL4DEDxR/NzbOLUMYYpp6uTgkM7qfiuIWmVEPv7xsArNKzDQAOdOcfCrKzv48chKq7mSOaoY95jQ8lNJu+R8ZkunTpPYoJjPahSH8ht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ztm1Gbkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3103FC3277B;
	Sat, 22 Jun 2024 09:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719049414;
	bh=uECyP60yqfaB0U3mswQAJu4fxkYx/BeROCYGGUgcZH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ztm1Gbkr6/gXKWLMPIDWdWu0OlZT4twgLMrMtVhmNo/xuaR9xRMwlzq1ltInAx19f
	 8lXVoA+r/lbsgv/Rk1PmKxysQIYkzmnut6C1fXtf8I2P2QkFZbOG5JwFNsQVewHU/g
	 OHXe9lP8VHPidyZ+mAudzf/eHGI8D1NdH51f7z8HouohNGaQyvYeJRutLr6vsQm5py
	 LwlazDqAz85cdtfQOtvp4H2f+354NJ9/1dKYhXCysf5+v3xISprRmhJc66fu44re5Y
	 DsKBK3HvQBZHDf+hMVfv3g3yzVhp48oZ0zGADxqK/mbijTndbUDv/EG70MWlQUEymB
	 ZRevAamIdbsfA==
Date: Sat, 22 Jun 2024 10:43:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Dmitry Rokosov
 <ddrokosov@sberdevices.ru>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede
 <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Saravanan Sekar
 <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Linus Walleij <linus.walleij@linaro.org>, Jean-Baptiste Maneyrol
 <jmaneyrol@invensense.com>, Crt Mori <cmo@melexis.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 02/41] iio: accel: kxsd9: Make use of
 regmap_clear_bits()
Message-ID: <20240622104319.60b0f0d5@jic23-huawei>
In-Reply-To: <20240617-review-v3-2-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
	<20240617-review-v3-2-88d1338c4cca@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jun 2024 09:49:42 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Instead of using regmap_update_bits() and passing val =3D 0, use
> regmap_clear_bits().
>=20
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>  drivers/iio/accel/kxsd9.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index ba99649fe195..03ce032e06ff 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -370,10 +370,8 @@ static int kxsd9_power_down(struct kxsd9_state *st)
>  	 * make sure we conserve power even if there are others users on the
>  	 * regulators.
>  	 */
> -	ret =3D regmap_update_bits(st->map,
> -				 KXSD9_REG_CTRL_B,
> -				 KXSD9_CTRL_B_ENABLE,
> -				 0);
> +	ret =3D regmap_clear_bits(st->map, KXSD9_REG_CTRL_B,
> +				KXSD9_CTRL_B_ENABLE);
Now fits neatly on one line at precisely 80 chars.
I rewrapped whilst applying.

Jonathan

>  	if (ret)
>  		return ret;
> =20
>=20


