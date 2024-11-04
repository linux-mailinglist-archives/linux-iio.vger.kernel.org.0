Return-Path: <linux-iio+bounces-11895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AFA9BB7BC
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 15:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8FA28467D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCAE1AB6F1;
	Mon,  4 Nov 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXbLCapV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471672AEFE;
	Mon,  4 Nov 2024 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730505; cv=none; b=DAOFcomgCU/K+gFaJpg+wqAqcHaK8PIX9iXv5gBYBPbVVsvqGo7zhlAaP0KGRLhJ7dSP495cW6UZIlSBMebfh4OKvkyEgX2J6bgL446qNY5ikJM9OEZ1A17Ug+Gs2CDPZHyCV+0iwo1wUd7iDteio3KUUy6KG+1k4j8VX3Zri30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730505; c=relaxed/simple;
	bh=+RvpvKPAHbAWetHfa4i1WFNeuH1qBy1J2yJHuYrSv5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOWWn2Qi1E9LD3ij0KfmHWwbMJnbd8SVsiQWczdBQHFWXBl090dwStoFqSUKJr8QOktGWrtRx3sLszHqUl6u5p8QJqZFfWizf9Z9gAbGAbcRLjAZEtJd+REYFLlnT6f6BTDWRhKcKZRSOkqaarfVzDehL6gygoQCNx6YIE8bbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXbLCapV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7021DC4CECE;
	Mon,  4 Nov 2024 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730730504;
	bh=+RvpvKPAHbAWetHfa4i1WFNeuH1qBy1J2yJHuYrSv5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXbLCapVEzR0c3KczRPp4oermNy07DIC3TT7hKC5QbeHEFIWSOHIopXZv5r7hYcMq
	 XOmR0X13sgNgOTiHQjQcbN0bd+Tjs0rHEvAHjEd1VrGw0HaJDs0p6g9Z4aZ79eg/so
	 ZPA7uWo2eVXDTHeaxZDMdMmT/GdCnvAke6/j3iCnhVLumCfh6ZxHwIavmojiYBzSjz
	 HlZy/M3nFJzH234/+gPB0Ocr2r5wKBoOSuXGGAFd5kQ8Fq0T/oHqRdKzIM9HYwsfzN
	 vqUAjU7VhyjUMuLI4bWp51O32TByo/iYaNgdtIac20EYbttW0ab2N7L4kYiDjaLO+x
	 SmZs6t8LYRJLA==
Date: Mon, 4 Nov 2024 23:28:20 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: vigneshr@ti.com, jpanis@baylibre.com, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: ti-ecap-capture: Add check for clk_enable()
Message-ID: <ZyjaBMgVVKvc8Kdb@ishi>
References: <20241103213910.31976-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W2oGqzCZLTycLuKz"
Content-Disposition: inline
In-Reply-To: <20241103213910.31976-1-jiashengjiangcool@gmail.com>


--W2oGqzCZLTycLuKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 09:39:10PM +0000, Jiasheng Jiang wrote:
> Add check for the return value of clk_enable() in order to catch the
> potential exception.
>=20
> Fixes: 4e2f42aa00b6 ("counter: ti-ecap-capture: capture driver support fo=
r ECAP")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  drivers/counter/ti-ecap-capture.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-=
capture.c
> index 675447315caf..30a269fa5da0 100644
> --- a/drivers/counter/ti-ecap-capture.c
> +++ b/drivers/counter/ti-ecap-capture.c
> @@ -574,8 +574,11 @@ static int ecap_cnt_resume(struct device *dev)
>  {
>  	struct counter_device *counter_dev =3D dev_get_drvdata(dev);
>  	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter_dev);
> +	int ret;
> =20
> -	clk_enable(ecap_dev->clk);
> +	ret =3D clk_enable(ecap_dev->clk);
> +	if (ret)
> +		return ret;
> =20
>  	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
> =20
> --=20
> 2.25.1

Similar to the stm32-timer-cnt patch comment: it's not necessarily clear
that an error in the cnt_resume() callback is due to a clk_enable()
failure, so you should call dev_err() before returning to indicate the
reason for the error code.

William Breathitt Gray

--W2oGqzCZLTycLuKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZyjaBAAKCRC1SFbKvhIj
K0pDAP9QHP7AC57PDlkPDoU6P7z0kuhaTVJ/f6c77VHBju/4pgD/V890BRoIB0A5
+wk2gE1Mx4zVquZ2a0NtFHr9zonduwo=
=/a3w
-----END PGP SIGNATURE-----

--W2oGqzCZLTycLuKz--

