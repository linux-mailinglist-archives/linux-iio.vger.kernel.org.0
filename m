Return-Path: <linux-iio+bounces-4954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B86D68C311C
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F931F216AF
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A18A55C1A;
	Sat, 11 May 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNW/H8vm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB72F26;
	Sat, 11 May 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715428688; cv=none; b=iw3R73y8CWyl+unuafzgwHUP00xhaQJi933vSGnkUyAwAu3kW2rT7uxDvKT9b0aVNn5cXyAAoYnL3uxRUR+UnYM0tMK74GSb1x+vJfKYlBxbIv0X7Htm/poa+vsj+hXhnJjUhwF8TAyBwbx9Tlz10DpB1r/TY71nojO7fB2gfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715428688; c=relaxed/simple;
	bh=gjlQgxDeLWMzgEXhqTDm//+OK210zyv+xkYRFyDwhgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddXNvlKfTJCrBmaXouERBBYZcQ0rZLT7Bj8E60snPhEfdFXZDqJJJngqjvV73oDBFsZs7TDR5QDpP4PQYx6TrHeDtDuUQgq+MAMG3jL63P9noCdtaAeWlG1RsKFq/Id/3/IVwy3OjOquvDvfqlPFosTzDiSkXKfNUBtdGdT6sTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNW/H8vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A412FC2BBFC;
	Sat, 11 May 2024 11:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715428688;
	bh=gjlQgxDeLWMzgEXhqTDm//+OK210zyv+xkYRFyDwhgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNW/H8vmaPeF4dto6WxuLX6V/qQzhZzEviwddkfFZefnAKLe5lJz39qm+tiR8YioL
	 Cxnoe1YD17CQDQnb7FgE3+jPbDOxvkWeZswq13YHxRtR+X88FBG0MEbk2nLn4mPqX6
	 YtgYElu2PivcquvHMv/oygaFwoL1Wbkd5r8dYo5/UWbU/ovga7KMTs9OG7SHENAYd0
	 H7+1lSdkxW8wx6GaC0FTN0EW5aRbD7RywR0R7VmhFv+HcAUW73QZvJoSH9fZTIqpsI
	 p3oSuUNlskSG+r9m6DmkAi6CzqkrY8JYTapMKNV1pX4Y5ILlI1XAgLYWhcDfITkXmN
	 rzimgzTShd9Ag==
Date: Sat, 11 May 2024 20:58:03 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vigneshr@ti.com, jpanis@baylibre.com, linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: ti-ecap-capture: Handle error for clk_enable
Message-ID: <Zj9dSy63GIWQSe_j@ishi>
References: <20240510090059.2126666-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sMiffhJRWiWAmyPi"
Content-Disposition: inline
In-Reply-To: <20240510090059.2126666-1-nichen@iscas.ac.cn>


--sMiffhJRWiWAmyPi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 05:00:59PM +0800, Chen Ni wrote:
> As the potential failure of the clk_enable(), it should be better to
> check it and return error if fails.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
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

Hi Chen,

Would you add a Fixes tag so we can pick this up for the stable kernels
too?

Thanks,

William Breathitt Gray

--sMiffhJRWiWAmyPi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZj9dSwAKCRC1SFbKvhIj
K8/wAQCVVSZwQZDUzxdIr/+KuCzooJAFd7NxCoG7kZttM8bV+gEAn5JeCDuljDN4
cVmWnRV9mHbP9SVYUmab5iYNnkM1Eg4=
=pcXp
-----END PGP SIGNATURE-----

--sMiffhJRWiWAmyPi--

