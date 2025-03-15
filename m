Return-Path: <linux-iio+bounces-16877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D5A631C0
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FCF1894AE8
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC97205AB3;
	Sat, 15 Mar 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYKTwSu+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A01F8901;
	Sat, 15 Mar 2025 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064036; cv=none; b=gcMDf70iuJl9vivoNUcIGQSN5PcBrVN3dMYLsxjNEbx+lARsSSnXi+1kHPJW/UeLaIu2Z+eX5xP2D/HItJCvRNxVRm7BO644iUuliyxi+i+w9xsPf48vJubtFAakDhO7j3UR54aqEVMlrRFLrhYsaQ3RD2QdO15UwDfUCG8JDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064036; c=relaxed/simple;
	bh=00RmH4uBlvkSbz6rfOkjFvbEmq2n+WwmAs6qZnlIY2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMHzn+Y28fqzVNxYkLf4vW4CQ2G1edm6EOdev9V24ZxXO++5W+0XXKYSvHkjO8DdoWUvFhkBU6/w+WubZITFYNirsLsLPAPW+hgKndONKVgCZD2euVgGXZ/AlurKsaifn6/4a9skgnxqZKErL6HN9hKRymCbkFDsh3z7EMVFSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYKTwSu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E57AC4CEE5;
	Sat, 15 Mar 2025 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742064036;
	bh=00RmH4uBlvkSbz6rfOkjFvbEmq2n+WwmAs6qZnlIY2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qYKTwSu+jSfZi4orffYnERK0ro+MZCC0aG9Ccz6itSm5oeGfBdat6ovAVDBtyfOVE
	 kNyMg8vS7cl0TAlVD4aXWOq+qlX9kZLGhfggeTQMfqpDYLps3E2+gpSVEge6rI1ki0
	 VZ6S4+vxVXVOI6CGOr0iuqi9vDd23lcOyARxOoGVlewz7RU/kToieksHnvPD3cEP4S
	 znpU2Oo4YkLJuAT4aev1rsB0g2TmGJvjDUZp7JKjmUN4LKcMFVmWVAaFCAEjTYTmND
	 FXP5K6wrEiKmS3m4hzH3NrPKRvY1k5OXVlKbrKGAgXQzdmVzirvxoGJLrOWqRl8/Pu
	 TlnQ0FKNps/XA==
Date: Sat, 15 Mar 2025 18:40:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Simon Xue <xxm@rock-chips.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Shreeya Patel
 <shreeya.patel@collabora.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rockchip: Fix clock initialization sequence
Message-ID: <20250315184028.46053659@jic23-huawei>
In-Reply-To: <10623626.nUPlyArG6x@phil>
References: <20250312062016.137821-1-xxm@rock-chips.com>
	<10623626.nUPlyArG6x@phil>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Mar 2025 08:00:54 +0100
Heiko Stuebner <heiko@sntech.de> wrote:

> Am Mittwoch, 12. M=C3=A4rz 2025, 07:20:16 MEZ schrieb Simon Xue:
> > clock_set_rate should be executed after devm_clk_get_enabled.
> >=20
> > Fixes: 97ad10bb2901 ("iio: adc: rockchip_saradc: Make use of devm_clk_g=
et_enabled")
> > Signed-off-by: Simon Xue <xxm@rock-chips.com> =20
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
ouch.

Applied and marked for stable.

Thanks,

Jonathan

>=20
> > ---
> >  drivers/iio/adc/rockchip_saradc.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockch=
ip_saradc.c
> > index a29e54754c8f..ab4de67fb135 100644
> > --- a/drivers/iio/adc/rockchip_saradc.c
> > +++ b/drivers/iio/adc/rockchip_saradc.c
> > @@ -480,15 +480,6 @@ static int rockchip_saradc_probe(struct platform_d=
evice *pdev)
> >  	if (info->reset)
> >  		rockchip_saradc_reset_controller(info->reset);
> > =20
> > -	/*
> > -	 * Use a default value for the converter clock.
> > -	 * This may become user-configurable in the future.
> > -	 */
> > -	ret =3D clk_set_rate(info->clk, info->data->clk_rate);
> > -	if (ret < 0)
> > -		return dev_err_probe(&pdev->dev, ret,
> > -				     "failed to set adc clk rate\n");
> > -
> >  	ret =3D regulator_enable(info->vref);
> >  	if (ret < 0)
> >  		return dev_err_probe(&pdev->dev, ret,
> > @@ -515,6 +506,14 @@ static int rockchip_saradc_probe(struct platform_d=
evice *pdev)
> >  	if (IS_ERR(info->clk))
> >  		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
> >  				     "failed to get adc clock\n");
> > +	/*
> > +	 * Use a default value for the converter clock.
> > +	 * This may become user-configurable in the future.
> > +	 */
> > +	ret =3D clk_set_rate(info->clk, info->data->clk_rate);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to set adc clk rate\n");
> > =20
> >  	platform_set_drvdata(pdev, indio_dev);
> > =20
> >  =20
>=20
>=20
>=20
>=20


