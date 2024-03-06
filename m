Return-Path: <linux-iio+bounces-3365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A97187409C
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 20:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D3D1F24626
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41114036A;
	Wed,  6 Mar 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+756lvs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8327E13E7C4
	for <linux-iio@vger.kernel.org>; Wed,  6 Mar 2024 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754022; cv=none; b=HYK0A+eAg8CDkrPYGREwdN4LF+sD65tb812n6VtCON0c26XDB/DvZIiFt1jg0eH1uWBVrdqbyr8kDQMXfandaZ98wuJZVGEoPPhWd052Upa41vPZICIa1Kh3fvUyfS8Xs5o1EVrgvwP5uCFJbxAe+Mse2JnnLlF0/6P4XpDNGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754022; c=relaxed/simple;
	bh=FimmtqSvqEqbFvMuJNijf2tqqdZSK3fWXSJq7n19k98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah9ypIpx8SGgHsImyNzowKCb/DqoaXvbgfI7ao4QBUFAzG13+S+iNP5ZMoEjK83t8i2YS+MkyB2gW97dxOAlT6GB1L6F8vpdoCdcdtAFJ1KhLE63YsrbiVyU3TQIPzwEHpbmHReeoLeMcz6f5AyeocX719AV7mPOj94ZqntJI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+756lvs; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4727ca88800so32597137.1
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2024 11:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709754019; x=1710358819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FimmtqSvqEqbFvMuJNijf2tqqdZSK3fWXSJq7n19k98=;
        b=K+756lvs+a4bRvQG5dp9hox4T/iRhEVLEMv779e7mJE4QG7DwmMO8Uo57kxVRYMq8I
         HBBr6lUS88Nr0YL46hW1sjYWJHLf4HVdg5k5axmCbPuOxNcmP0sDRSi9bzoLaC4Dyfjp
         j2GhgW+p8p1B7wR3uktsOIWwaq/5++xTxadTmvghJbqPGaP13m7R/om/2Kc4cCLQGLMp
         R4Hal64G8WJSHo5sBdDok2cJ81xfypyTRX0nWhc03mOnx6WzK2LIF1cvv5em84idxhI9
         ipE9SJEAl06m7sDGsKPLvNFGtn4D/AOtj6dhA0nUvssTzFEu0gPDl0N8d9cRYhHR3u7r
         3Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754019; x=1710358819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FimmtqSvqEqbFvMuJNijf2tqqdZSK3fWXSJq7n19k98=;
        b=u48pRBNadJmXVovznmVprWCVuwb4aqlSRiO6Df889gSZWRI5cT24W0Gms2h/hUVuFK
         waEWnl+Wk7zUOp9KNYxm5t6o3Bz2/5DL1fFuq+x2fxmDKm56HuwM3szb++P5GLpGzkkr
         UkmSwwecTHgFwBRC1RmIvEiIlzi+i28AmwEzUiQ/AnLVgfy0VBSA667Y2YfktjPwmYpZ
         /bTjtaa4qwclCgOCvLV14gPtxnB/hinpw1Mu9G3CPuR1YYrKCQphMnWbhpBH19C96Yas
         vbfiW0Ozqw50IILQ+AmytD4zbI6YH6yjqny89Yech78EITTp1uDVgbzEtCgAL/bpwjZ8
         t0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5W0wNTLcAM8IDKRwAN8SiL4TNDveXAeN1mg/gd9nNLZa+aLA7hiaXZ6z/4STZbmDCbJT/sujTTpzaRpXE5VaGY3JY95bxcmae
X-Gm-Message-State: AOJu0Yzn/5WNoMyQnrnIB1po3nVx3NUniqFDfe7fvIJh4Sg1KsngiYr7
	UwtHFhNHg0kwDjF88gxLew+rx/u1pBAzKjwU1BRmyYhj2WoDqHgWVVxT+ZoI8Eo=
X-Google-Smtp-Source: AGHT+IFOhv+r/bUzCCGiBr5OHd5VcarVt4eCtbw0P5hHbSyBkgUa/QGZ5B+jCpn573A0lhwZV9TGmw==
X-Received: by 2002:a67:c412:0:b0:472:e292:3933 with SMTP id c18-20020a67c412000000b00472e2923933mr4977115vsk.17.1709754019440;
        Wed, 06 Mar 2024 11:40:19 -0800 (PST)
Received: from ishi ([185.243.57.249])
        by smtp.gmail.com with ESMTPSA id 38-20020a9f22a9000000b007cb1514c862sm2305766uan.10.2024.03.06.11.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:40:18 -0800 (PST)
Date: Wed, 6 Mar 2024 14:40:17 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] counter: stm32-timer-cnt: probe number of
 channels from registers
Message-ID: <ZejGoa8J5uReN0fg@ishi>
References: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
 <20240227173803.53906-10-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TYYl/++2NBOFjIIm"
Content-Disposition: inline
In-Reply-To: <20240227173803.53906-10-fabrice.gasnier@foss.st.com>


--TYYl/++2NBOFjIIm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 06:38:01PM +0100, Fabrice Gasnier wrote:
> Probe the number of capture compare channels, by writing CCER register bi=
ts
> and read them back. Take care to restore the register original value.
>=20
> This is a precursor patch to support capture channels.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

--TYYl/++2NBOFjIIm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZejGoQAKCRC1SFbKvhIj
K9rKAP4tIgFMewvSx7gbLKhcLYNMVQevAg9siIMXNnOlzExhTAD/TwMoxemDO0+A
xgY8nsPjYelz/A1209HizxjuPRgMfQo=
=roE/
-----END PGP SIGNATURE-----

--TYYl/++2NBOFjIIm--

