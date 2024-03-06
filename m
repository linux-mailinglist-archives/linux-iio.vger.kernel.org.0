Return-Path: <linux-iio+bounces-3368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966AD8740AF
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 20:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526A1281B90
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9FA140380;
	Wed,  6 Mar 2024 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dt8w1k6q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D0140373
	for <linux-iio@vger.kernel.org>; Wed,  6 Mar 2024 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754241; cv=none; b=EwjIJWJlXsl4F2jHxNgKIpWGlGQFi29eFXBez85j0+YWjsxXVYbL5X2v0V1pzgFwTaxEsT3fjU8t208QWyOIFq3ci0Uu/lsuqJPkDtphsKlmdeN/GPmth6JS2RJdf6yKeaKeOpNBUdADE2c43oU7Y54r4Mtt8d/HQWNg0VhO4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754241; c=relaxed/simple;
	bh=I0ohgGabI1C1WrACCr2x2SG+mIMUemMROnv9qbAlsMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQVyrVoOqr/tF1wC5SP+CYsXHti0B509jqZW2ChcDWgrd62zdaZZgRFwKaCBsrzGVVwbG4HEI/j63qLZp8gSf/a7huG5qLWgcSbaV5h5FEadFHXPTFT0euJdM7BMXqLa74PwTHEtb7JheHAchBFWPZKOOZZIDleULQIgvKBFciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dt8w1k6q; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d5c40f874aso28552241.1
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2024 11:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709754238; x=1710359038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3h1bbnwAIyReRJZyvKPJxbEARb+nxhxtKQ4kf1OInaM=;
        b=dt8w1k6qdmI62+ZI/0mOISSQ7A+kGKGWQf4Sii7dI+Vtv5CA+yKF2/UxXEUX3z+193
         dmOo+eMuDRINw8/Huh4gMnc3+fQkh/Lg4WE/NTfNLFH2280CV9WYd81WWA/EOFyKX5q7
         uARJhjHZWTorXu3ZK4lKrRV+Mw/4X+H9votxpnmO0jhPJbaf1+iM6pnOE+SbnpZR89XK
         F2hvOZDid5fr9ULEoY31q/nOOuN3jokNyjNJANVYK4MlXqK38jzoa4fgJ7DPvczqJ0Vv
         p8if32KnVebBZftrcgZlPs5Y5jb0p87QY5RgcNDa7w3AZDcN1iDdVe+vXRzBAKiiS5oo
         4Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754238; x=1710359038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h1bbnwAIyReRJZyvKPJxbEARb+nxhxtKQ4kf1OInaM=;
        b=B6yL67qP1sIXWXLoK1HI8Uf6ClMycBHvvrvQAvjqOVe53vtv2p1iZlFJa3dCvshpD7
         +nJM8YemajvNYzueiqBA0A2x3KIcCj3cG1/F6n+8p/fygXB8ndbca1OSVRKX13eYAnLn
         GDNnfSsMNm5D+4D296oNiLStwMzNvopxjcyCdQOMNlUAjvYW/zVNUZeGoFKHdudbokHm
         RcQ9N8cqZ09A+DOVmlFBijVgrQiYILGMcT42xeAycs4FSTA9PIWrPPjbyTnhmzoCiC1j
         nvz1Vj8WPZzZRpyKctozTgo8TsSc7vd3juUEWYyd/rbvyRddiNaubAF1RrYWXgyk4oWi
         Yq0g==
X-Forwarded-Encrypted: i=1; AJvYcCWvuyAY5XdemxqDpQnqjoWWIHDWDLDesf4+zXmHLtuF54Lopauyg1ZkW7sIDnAmF4jtdTESYk6vHzd0dRfmfAA5grE9KkYWBVRz
X-Gm-Message-State: AOJu0Yz5p+J8LVJEbokYD8Pcvj5jgo08w8BvD2z54HdFuP+g7pxxhT3d
	KiIlq7t3/epqMz+bNl80AIFqNwRgb3oWMKF9bEv76ofPQJpTYzy/E9dz5gZ1xKo=
X-Google-Smtp-Source: AGHT+IEyLGk6lO2/Z0y29ajHV8WtFiOo34D73UwYULuhEUyqvjui+WV95jfXzAfgg56mvqNDNS3sgA==
X-Received: by 2002:a05:6102:55a4:b0:472:7b61:70c4 with SMTP id dc36-20020a05610255a400b004727b6170c4mr7625665vsb.20.1709754238304;
        Wed, 06 Mar 2024 11:43:58 -0800 (PST)
Received: from ishi ([185.243.57.249])
        by smtp.gmail.com with ESMTPSA id cf4-20020a056130114400b007d5d3dac7dbsm1970664uab.3.2024.03.06.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:43:57 -0800 (PST)
Date: Wed, 6 Mar 2024 14:43:55 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/11] counter: stm32-timer-cnt: introduce clock signal
Message-ID: <ZejHe8C_iy4ZNXEX@ishi>
References: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
 <20240227173803.53906-6-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UUEoCLXwhPXDowOG"
Content-Disposition: inline
In-Reply-To: <20240227173803.53906-6-fabrice.gasnier@foss.st.com>


--UUEoCLXwhPXDowOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 06:37:57PM +0100, Fabrice Gasnier wrote:
> Introduce the internal clock signal, used to count when in simple rising
> function. Also add the "frequency" extension to the clock signal.
>=20
> With this patch, signal action reports a consistent state when "increase"
> function is used, and the counting frequency:
>     $ echo increase > function
>     $ grep -H "" signal*_action
>     signal0_action:none
>     signal1_action:none
>     signal2_action:rising edge
>     $ echo 1 > enable
>     $ cat count
>     25425
>     $ cat count
>     44439
>     $ cat ../signal2/frequency
>     208877930
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Hi Fabrice,

Rebase this on the latest counter-next to account for the
COUNTER_COMP_FREQUENCY() change, and that should be the last thing left
to do for this patchset before I pick it up. :-)

Thanks,

William Breathitt Gray

--UUEoCLXwhPXDowOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZejHewAKCRC1SFbKvhIj
K1s0AP42PGLQj0Xyd8x57hYGP2PXXQJtYsVAEQunEFZk1MJQqAEAhI9IKmZMCY73
uD5bv4vCbfx4aFk0aSqwtkdXbSu4yQs=
=T9k5
-----END PGP SIGNATURE-----

--UUEoCLXwhPXDowOG--

