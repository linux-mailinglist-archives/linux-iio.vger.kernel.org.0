Return-Path: <linux-iio+bounces-11894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F25D79BB7A5
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 15:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEA91F23F84
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7B11B2180;
	Mon,  4 Nov 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R89pu2Sk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3676E1B0F12;
	Mon,  4 Nov 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730303; cv=none; b=jhWfBYjtFSmcKDpiCk3/pHN0y2r9FYgXQT7D+/7w3qQtE5g/Iy4Nc1WHblnznPFcstZA7Mxv71fzZLdwjKPCcvyVSTub3fTYQ31MQphE9hilxH5SS9GMp/IEDpE4w+K9G5ItA9ViMtvOkNAPlwoohw0gyODZqcM8J0UrLfkV7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730303; c=relaxed/simple;
	bh=aCdsocZNwSc0LaEHFPOtq6uw+UtTQbPbYCLT6rdIiSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIc9BDnYivApnUFMnoHfBmOFyTE3ZG4Kf0gfrfzK4nohbKtjaZLcXnQsX9G3rEPVidihORbmlMZSyXpyipBihx0VzJMjlkGjsPL1cAvgge/7/zRnM0FdtjOrNpthKEE/DIxcQRyYKcSdk8XzAFDtpx1TzsQskWoLK8VpDjY9mc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R89pu2Sk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A29C4CECE;
	Mon,  4 Nov 2024 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730730302;
	bh=aCdsocZNwSc0LaEHFPOtq6uw+UtTQbPbYCLT6rdIiSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R89pu2SkbTOdSoRFVO+RZw5wfgA4U27LfJeYYH88bCe+nfxHdadx02d8l9jhs8zid
	 VrhbYNlRXhCr0Q59Q9+5nKXv8H2c1BwKOpmeMl+iNfLAGzPE0TH0kXY5h82VjvBbuK
	 PVu3y1owBEg93MLEfo812PRB9qr+j1BwMNkIt7ke+Cjars0M+tMypPYeLcBc7rBZx5
	 Y9cTGR7QhoXaXhGcUbDJuLJtxMEABrinBwwWZVTLBs+DBFxogiMaitSSm4sNHLb9w1
	 PzuV8Rd94Va0gkGfpz2mNKhvLiScchTKZeAOUiGVs1SOr45IOTZePGcQYR7v98RXrt
	 Oah2MOc+r3XXg==
Date: Mon, 4 Nov 2024 23:24:58 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: fabrice.gasnier@foss.st.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, Jonathan.Cameron@huawei.com,
	benjamin.gaignard@st.com, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@outlook.com>
Subject: Re: [PATCH] counter: stm32-timer-cnt: Add check for clk_enable()
Message-ID: <ZyjZOt4LXL6vVrEC@ishi>
References: <20241103182502.8384-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A18abvT+dU0C7JZH"
Content-Disposition: inline
In-Reply-To: <20241103182502.8384-1-jiashengjiangcool@gmail.com>


--A18abvT+dU0C7JZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 06:25:02PM +0000, Jiasheng Jiang wrote:
> From: Jiasheng Jiang <jiashengjiangcool@outlook.com>
>=20
> Add check for the return value of clk_enable() in order to catch the
> potential exception.
>=20
> Fixes: c5b8425514da ("counter: stm32-timer-cnt: add power management supp=
ort")
> Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-ti=
mer-cnt.c
> index 186e73d6ccb4..0593c9b73992 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -214,11 +214,15 @@ static int stm32_count_enable_write(struct counter_=
device *counter,
>  {
>  	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
>  	u32 cr1;
> +	int ret;
> =20
>  	if (enable) {
>  		regmap_read(priv->regmap, TIM_CR1, &cr1);
> -		if (!(cr1 & TIM_CR1_CEN))
> -			clk_enable(priv->clk);
> +		if (!(cr1 & TIM_CR1_CEN)) {
> +			ret =3D clk_enable(priv->clk);
> +			if (ret)
> +				return ret;
> +		}
> =20
>  		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
>  				   TIM_CR1_CEN);
> @@ -816,7 +820,9 @@ static int __maybe_unused stm32_timer_cnt_resume(stru=
ct device *dev)
>  		return ret;
> =20
>  	if (priv->enabled) {
> -		clk_enable(priv->clk);
> +		ret =3D clk_enable(priv->clk);
> +		if (ret)
> +			return ret;
> =20
>  		/* Restore registers that may have been lost */
>  		regmap_write(priv->regmap, TIM_SMCR, priv->bak.smcr);
> --=20
> 2.25.1

It's not necessarily clear that an error in the count_enable_write()
callback or cnt_resume() callback is due to a clk_enable() failure. You
should call dev_err before returning to indicate the reason for the
error code.

William Breathitt Gray

--A18abvT+dU0C7JZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZyjZOgAKCRC1SFbKvhIj
K91QAQClpsDPi83ln4ZTMU9XMQcBPRklZisDe1L9SMCTzqjm3gEAq1L5KoqpNOaf
YPPuPhpOYxmyb3wS6y/mZ8IWf4PZ9QQ=
=zJcy
-----END PGP SIGNATURE-----

--A18abvT+dU0C7JZH--

