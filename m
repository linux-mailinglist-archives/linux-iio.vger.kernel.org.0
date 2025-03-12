Return-Path: <linux-iio+bounces-16742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A528A5D6C8
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 08:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3491891A9C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 07:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D61E7C06;
	Wed, 12 Mar 2025 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="c+Z7jXJE"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00C1E32C5;
	Wed, 12 Mar 2025 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762878; cv=none; b=QQTUL1xeI3onKXHZebdJQw8GnD/mgZ/0u/+82AnwHQRLBhPfgOE7FdQWtzFs2QG7YOgCI2uQPQTZMhSZCIemy1K1Ci1Yi3Qmb0eDYo+5eBBm3H5qXtHsL9trAse0pS1OrkfGfvrk4hSJarQI0jZLNr62CcU8jqujK0V61KohU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762878; c=relaxed/simple;
	bh=pcrZWjYvWhd4C+NrPQAN3aBU6u1DILHC43lgm/p4AyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5MWiCLdtDsdasIDHXiem1FgtFFhJiB645rRN5JGb/1cXW0BVyjEriT58em4kEtCx6+EWOKIA+tMV4dBo1Wb/fn1xIvI8lSCa00L4dF7ARapAEp93suLmSNnATsLx+DdcAikjcRoeLu/QuptUbBjhuZWASUkiG7/hnlpOyqhkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=c+Z7jXJE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=T4cQcUJ36qNbXsGyNZN8cofiMvUd+P7GunVsv0lw7ng=; b=c+Z7jXJEsCDQ9/aVNgTQtUgjLQ
	9bBfzxsRzEr+7FgnoT0aLBS72UX8EMfN4yuhXInO/xqKBcWaOlQ3xJH10Hb+H//OG0D4+/Ftas+mh
	Ad7+HvP37hxYRSdvb95uLBkgh68AbtFocQlTEKGTWuuvG3R8S6HYYimbWALR7jMXOkfFiSU5LED0s
	TTp+Gw/WSL9zsvuXmkZ1sbabx/mQg/jaBGYpKSQ1nvGAT/iAUWS2XBXTgs8zrDK+e6sZwvA1ektdr
	h6h8aDqap0NSXKpjLINaomhQt51r8XDO6lRh15D7jMWSuep2VXpjQVBhbxxnsITO4n6k/qAzZQDdP
	HGE7Ru5g==;
Received: from ip-185-104-138-79.ptr.icomera.net ([185.104.138.79] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsG5P-0005ev-CI; Wed, 12 Mar 2025 08:01:03 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>, Simon Xue <xxm@rock-chips.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Shreeya Patel <shreeya.patel@collabora.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH] iio: adc: rockchip: Fix clock initialization sequence
Date: Wed, 12 Mar 2025 08:00:54 +0100
Message-ID: <10623626.nUPlyArG6x@phil>
In-Reply-To: <20250312062016.137821-1-xxm@rock-chips.com>
References: <20250312062016.137821-1-xxm@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 12. M=C3=A4rz 2025, 07:20:16 MEZ schrieb Simon Xue:
> clock_set_rate should be executed after devm_clk_get_enabled.
>=20
> Fixes: 97ad10bb2901 ("iio: adc: rockchip_saradc: Make use of devm_clk_get=
_enabled")
> Signed-off-by: Simon Xue <xxm@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/iio/adc/rockchip_saradc.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip=
_saradc.c
> index a29e54754c8f..ab4de67fb135 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -480,15 +480,6 @@ static int rockchip_saradc_probe(struct platform_dev=
ice *pdev)
>  	if (info->reset)
>  		rockchip_saradc_reset_controller(info->reset);
> =20
> -	/*
> -	 * Use a default value for the converter clock.
> -	 * This may become user-configurable in the future.
> -	 */
> -	ret =3D clk_set_rate(info->clk, info->data->clk_rate);
> -	if (ret < 0)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "failed to set adc clk rate\n");
> -
>  	ret =3D regulator_enable(info->vref);
>  	if (ret < 0)
>  		return dev_err_probe(&pdev->dev, ret,
> @@ -515,6 +506,14 @@ static int rockchip_saradc_probe(struct platform_dev=
ice *pdev)
>  	if (IS_ERR(info->clk))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
>  				     "failed to get adc clock\n");
> +	/*
> +	 * Use a default value for the converter clock.
> +	 * This may become user-configurable in the future.
> +	 */
> +	ret =3D clk_set_rate(info->clk, info->data->clk_rate);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to set adc clk rate\n");
> =20
>  	platform_set_drvdata(pdev, indio_dev);
> =20
>=20





