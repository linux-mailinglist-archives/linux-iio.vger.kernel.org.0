Return-Path: <linux-iio+bounces-7016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF9291C2AC
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8AE1C2166C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C139154423;
	Fri, 28 Jun 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D8nJ6wQN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF76200AE
	for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588677; cv=none; b=XK/0u5bf4nKE7RUzAoAvVoW2A7H1elzzv0/FMUpyj6yCfMXGLADJF2GI56mgLR3zrlKiuJnFSVKA3+KFAGfCUtiTjoiAO5pJNYwMdX4QQm302wZlNNPlTOdREH+al2eJ2pjDoNDN/ZTKVY0R3VGxlx5GfTb3AuJJ+KjdWJ7dFjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588677; c=relaxed/simple;
	bh=Cw8/Dd1AmfMRWoiS5DrGRhLSAbG/EaLyt5lWf3UMIQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB70099xYWiIvCwkEsy2mfaYggNsOE0ErlZDpeErjWXN4XNQlJs+yoJUGA0VKqsY6npXIpupDicv9/jK3SviGLfJN2xncEG5MgNVnLPwzxzvCKWWl9PiBixf++sncN5Kk0cmkn2pWfSmF/hsxK5oJeX9qkrChkFSfUWqiViJKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D8nJ6wQN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a72af03ebdfso105468566b.3
        for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719588674; x=1720193474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5JIqp/Wf4fxg2MB78rOVzzjMmA3m9XSWkuB6lP9b+k=;
        b=D8nJ6wQNocQQiDCbnusqiDmoMBtqoPB8vKKFpbaXgur+ZvuvqpkktTdRfKUIEs/fUp
         bf7QncGSqP6x4JcsaQez7rYdOixW8uqpX/y8ng9nJdmUsi9ujNwWYdXCcnIFWylFqhkz
         9pDu5G8jMW0fXef/tfNzhc8e6FXjDQdoi4OLgQ1M/fGFHec6Sfv1uLweFr3AoL8Rnj0p
         1ajMyBJ6Of+6OkbbAmrRDzOu7Mc3E0E8vPviV80hxdTTh/kQFBQ4NkrvvMTs+XxANLus
         sqo2+5+SudKSK04ObiA2PEQKzdFw2aYZa7beVvV+s0kKiWcPSGSqboV2PQ8OZRTULUdY
         3IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588674; x=1720193474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5JIqp/Wf4fxg2MB78rOVzzjMmA3m9XSWkuB6lP9b+k=;
        b=B0J1NNpUNueb3kNCjwHbtnoFNZouI9sryAo24KULKF0q2zprlmciqNkaGAXTW479L0
         TwrkdOenOEMn3l81ZjJ2N0Y9nv85hnYNrIZ2dro74L1KOrP1Ws4f04dib0eNH0+YIHbH
         OoO0mqQbUm2N2MC8wpiSeCh6DoMLzbs/dsve7SBt+sI7P88PKrVzIOHvEvWyXN+q3GXP
         n8YR+qwUv5diNmRYrDnZ5OVfW8J9yLR3X9hG0Rbda2WWXUMkjX7ZQ1BTWPNmenfso807
         Rf276py4Q7DjMVlw0dGmORVLw/xm4z0qPTkInbgEjuIHb+zaPad3OpSNy/faEM7ZxF5x
         2Cbg==
X-Forwarded-Encrypted: i=1; AJvYcCWYmlIhqQLE73M0BxCbBFHDCFvGw7if4Vc9HQsBIYfXnUbiVF/MwUDDz52ukYfML+O+RodsBeAWpiqwOKJMnTU8kUWU3ECGaTAY
X-Gm-Message-State: AOJu0YyBvqyXYnMLRve7nZ+nTrwvZf4TooXnz6DJdK22rwjyueacKX/h
	l30OH/WlxdvIhqqSj7tni48XmPWM61O4A+Oq42ZwvBycz5vEs0AwzFld4GDiq2E=
X-Google-Smtp-Source: AGHT+IFRuQ7YvA3YzYURlVYrBjCcKHGte4VTBj2Nk5k3QmyJ3xEe18nZQZz0a+CEYGABUKDkBB2m8Q==
X-Received: by 2002:a17:907:118c:b0:a6f:e50c:334e with SMTP id a640c23a62f3a-a7245ccdd60mr897244566b.23.1719588673865;
        Fri, 28 Jun 2024 08:31:13 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06519dsm88699466b.99.2024.06.28.08.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:31:13 -0700 (PDT)
Date: Fri, 28 Jun 2024 17:31:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	William Breathitt Gray <wbg@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-pwm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [GIT PULL] Immutable branch between MFD and Counter due for the
 v5.11 merge window
Message-ID: <wfhqh5jfjaecjr75fu5olxnnulxgtqyxpw46azlfa6vqe7ezlz@l5mwketc3f5j>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240626151343.GA2504017@google.com>
 <20240628142847.GN2532839@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vwml3ark6hcxxqsa"
Content-Disposition: inline
In-Reply-To: <20240628142847.GN2532839@google.com>


--vwml3ark6hcxxqsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Fri, Jun 28, 2024 at 03:28:47PM +0100, Lee Jones wrote:
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:
>=20
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>=20
> are available in the Git repository at:
>=20
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags=
/ib-mfd-counter-v5.11
>=20
> for you to fetch changes up to 304d02aa711369da89b4f8c01702bf1b5d1f7abc:
>=20
>   mfd: stm32-timers: Drop unused TIM_DIER_CC_IE (2024-06-26 16:09:58 +010=
0)

Thanks, merged into pwm/for-next!

Best regards
Uwe

--vwml3ark6hcxxqsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ+1z0ACgkQj4D7WH0S
/k7wMAf+IQqhOqwRtmvzgqxA3dQPTH3rCH8Y4z5wsmtBC5eqzlC6r3Hz0UjzxlUA
2tgx4l7hoq832LjoauTlmSckhKJywRAYHhcll0XyODku6sP00oYmsdidrWftQQYz
yJQ77dcmOLs2wbgqlC/mn48nMQKJBsWuxtTXZzERDBevXW1VcpKtYstg7WNZAkEX
cv5Xx7I5wAIklRc4fHTsvd8pPo25VVS/AcZ10aKnTdFQAFQkkjSCjJFthH9X9TQt
0GwSUGpxg/oU7sneXNoYb5zXVqMs7EijFr0MzcFFi3Y8OAgeRf5jn6WVF8pAbnqA
Z3gZNyEIRABVSWQewBB/0yxodqtP1A==
=Zv7T
-----END PGP SIGNATURE-----

--vwml3ark6hcxxqsa--

