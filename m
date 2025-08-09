Return-Path: <linux-iio+bounces-22496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E305B1F5BA
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 19:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D19189E120
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4945D279323;
	Sat,  9 Aug 2025 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAaK5BRA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D41F237A
	for <linux-iio@vger.kernel.org>; Sat,  9 Aug 2025 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754761934; cv=none; b=n5tbbVE3YmakXnagHbVURD7lPK9gJErSgRbK+KtRoTUUuGELgD9p/RkBdvqcq8TnTbU8v94B5GZmBFd7shv7vGGE9iGWjf+K+WvLVcVyc5LpZpeAVx/2B9RmsPnEgMUpJIr9n9CF6j8M8fipD2bLUQJOt58MkPkREHWEteIyKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754761934; c=relaxed/simple;
	bh=UALtNULVjX+O5xym9pFtDLvVOD1LuefVwUPO8J8v6N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cscPT3obxJeaI18wyQXQzOT2n49i3Nj0Ay9GDFYs0J8fnwmVxGuW5tjm273YIoV2JCTOUsxN5Xvu6zzc4oyZyqrYzUddHt78um6GAenrIvWJLqyu8hVUX3UpKvCAMkD9jPc1ZmHCyCZyQnLcedMM8dH/GmpTj047Pmd117VsvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAaK5BRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541E1C4CEE7;
	Sat,  9 Aug 2025 17:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754761933;
	bh=UALtNULVjX+O5xym9pFtDLvVOD1LuefVwUPO8J8v6N4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TAaK5BRAAhOro/NWMRPy3EbOBf3n5xGsorud5Pz8P1CH2AcJu3eGuZwZnCkdZEWWz
	 dwcybrljAU7dwqHsOUmrfxABJnptlWuYuc5rgU1KMenXCIpox+C6fyh48+qJcbiLg1
	 7kqncY6Xj6Bud1BPuurSQbrfIEFPJMSDJetxFbmJqqtN/mXSSjg9DB634v/rAFBeYd
	 GuLwTEWIDRay8GMPUHQp9qkI+jTO+7BpHDiFsaQCvioBm2Y9t80yM3RFZv3ul6ykPy
	 zL/osaI63HCqdoAgbEolu2kVeaNfSkxj/nbKcz/Dkd4/Sr8ebPBFytx1K1HNC+YVbB
	 HcUFtfEYqvfBw==
Date: Sat, 9 Aug 2025 18:52:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
Message-ID: <20250809185207.04a3665e@jic23-huawei>
In-Reply-To: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 08 Aug 2025 17:09:42 +0100
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> The ADF4350/1 features a programmable dual-modulus prescaler of 4/5 or 8/=
9.
> When set to 4/5, the maximum RF frequency allowed is 3 GHz.
> Therefore, when operating the ADF4351 above 3 GHz, this must be set to 8/=
9.
> In this context not the RF output frequency is meant
> - it's the VCO frequency.
>=20
> Therefore move the prescaler selection after we derived the VCO frequency
> from the desired RF output frequency.
>=20
> This BUG may have caused PLL lock instabilities when operating the VCO at
> the very high range close to 4.4 GHz.
>=20
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Fixes tag?

> ---
> The Signed-off is because I'm just carrying Michael's patch without any
> change from me.
> ---
>  drivers/iio/frequency/adf4350.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4=
350.c
> index 47f1c7e9efa9f425a4c7cf82be930234e2c18434..2b8b935965ed4536bda835844=
ed6c7d0a7b88330 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -149,6 +149,13 @@ static int adf4350_set_freq(struct adf4350_state *st=
, unsigned long long freq)
>  	if (freq > ADF4350_MAX_OUT_FREQ || freq < st->min_out_freq)
>  		return -EINVAL;
> =20
> +	st->r4_rf_div_sel =3D 0;
> +
> +	while (freq < ADF4350_MIN_VCO_FREQ) {
> +		freq <<=3D 1;
> +		st->r4_rf_div_sel++;
> +	}
> +
>  	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
>  		prescaler =3D ADF4350_REG1_PRESCALER;
>  		mdiv =3D 75;
> @@ -157,13 +164,6 @@ static int adf4350_set_freq(struct adf4350_state *st=
, unsigned long long freq)
>  		mdiv =3D 23;
>  	}
> =20
> -	st->r4_rf_div_sel =3D 0;
> -
> -	while (freq < ADF4350_MIN_VCO_FREQ) {
> -		freq <<=3D 1;
> -		st->r4_rf_div_sel++;
> -	}
> -
>  	/*
>  	 * Allow a predefined reference division factor
>  	 * if not set, compute our own
>=20
> ---
> base-commit: 6408dba154079656d069a6a25fb3a8954959474c
> change-id: 20250808-adf4350-fix-3e0b9b7c3420
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20
>=20


