Return-Path: <linux-iio+bounces-13814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FAE9FD226
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 09:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DBC18830ED
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 08:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99510154BFF;
	Fri, 27 Dec 2024 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K+gKAQwx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F41154456
	for <linux-iio@vger.kernel.org>; Fri, 27 Dec 2024 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735289018; cv=none; b=GANcIpeuMKVSY8N8sX70kzTC5wj5mfIFGRiuWULlIrSptPAkFAkieJVz1CUUmlH8JR5zkgCgd2PVefnw7890gtr8V5bV+3Vp96mS7ZboHiOFaepVxFj/2k+VZjlFwzkZtPu/F3yk1Tf8WhKexuXk9oq/yW4+g7ZNn7Cc7HV3Fm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735289018; c=relaxed/simple;
	bh=THrgYM/I/2PM4lB3S8b8dKft+bfxKHUzcX53Lv5NjF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyXn3xgOUyIlhr36Br1CuIM0maEh+eNQpknxTAQEtgsG7h+QZQdyXW6C+tIgbi8+K2G+fJKCJbDyDg4aGDA0SXWegcBr9uRKG8RAPxDHB/t0MOFkq2nFoJNYfrUESQy5GortrTMGX9uGy/omWyK61VduIqijxLDWjfAtrBD20H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K+gKAQwx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so13756440a12.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Dec 2024 00:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1735289014; x=1735893814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THrgYM/I/2PM4lB3S8b8dKft+bfxKHUzcX53Lv5NjF0=;
        b=K+gKAQwxGxYrSj5qRyju2TU+O4PL5l0+n59Q3DbJMjBQ9tAAaB59yO45a+f0GGz5qG
         MGVpaIaWjuEtURw1iN01pg6whJV6NmEpz1boPuoCzqyP/cRROoLQjoyLN2+zr6YEQITj
         VT9qgK+nZ12c0MqZD9xRV6+eL9IaeWKeH/D4oWEy6j/hRO62sxbITpCM4RXZ2ROaTxR7
         bqdCmwRnxP/Es0ylzX35X6yt/KIdbVKWvupC9WODtiG4EW+1CRdUnw7iM10DCRrLxRRe
         pKSopcFaY+oGhynQZQSiMA/iZLUmGKFWciDjopLnNoSb6U81fuBTyAlJoSQcdAJhnzK1
         QZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735289014; x=1735893814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THrgYM/I/2PM4lB3S8b8dKft+bfxKHUzcX53Lv5NjF0=;
        b=ThPBCC9JrW0R5ljHxKj2PSr16K6sz6TZeuk8B7bmwqVvxYO7ANNw1u0+2ikdVPgZIT
         gJ397r6VwpQtI4nxWgkj/zckvA35WhDX+dH2Jybp9GgmFGDnjuRkPJQ2ihPp2dg/ZBkP
         3PrfCGXFl8XAqglZonQnGrnPr0Fd0QJ20Aj6GYgKrARm8tGBuwW2Or48NsSWbq5lw7LE
         Y/MwLXjLN1qjASZZABD8A21Ik8uNa74yn3eqYvTdQZUBDw19Ozhq5PAVZnCSupxNly+a
         bdPQwaJOqzAM8Q5cLZDYzQkBNyx12p5Aym5rqSKnCdTF5L11mMx3VUCBCIYJA3Va22p1
         h1tw==
X-Forwarded-Encrypted: i=1; AJvYcCXH2weEvtdSTbPw7kMAW83iO/mdezoi++gl1X19qcOBbQ9LkxQB8xtbFTb5zNMRa56kioy3V+U7u3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LUg97AMe438xzZ/y9lb5TWmuxDC01Olm7b9Db8ZPswceITeL
	O7yE0PnxuMMzc3KvAFTgHSuVkODr+gFohiL3bFv02fmMOGbFH5K8hS7UkFoFPjc=
X-Gm-Gg: ASbGncsersN+4lEcVPBjV8YRl2nlcuZY02Ol+3mg6sHYp7zYz5VrSLRUlXNh4pbxqkx
	ujwFf0NUCyVF9w2HN/BAo7AfpIBzqLZQyyXtnTRHcNVaOHE+Un2MEjbrcyYYJt9M6wYUXsmRgAx
	zaiL2RDE2W75IlHjuYb9arPB4mLT/itDseXwxdEmdu5M9G3StQwohJCdrTbFBl07lDwn4LDLnhz
	dzb1pzXZSMpa8huL33m4G+OP69Uxpiq3kxbYBnFKJO+Hl3oz5TKwEg3jaD2uzs+Ab9uuEFc674i
	VyBdKXWk8g==
X-Google-Smtp-Source: AGHT+IEzQP44dmWbe1VSp36ZAsJ+DOZkSE6XYi7+YrOQ6d2vRkiz93oSKK0gDB75cG4aLLPyuPlKHA==
X-Received: by 2002:a05:6402:26d6:b0:5d3:cd5b:64da with SMTP id 4fb4d7f45d1cf-5d81ddfd841mr20516135a12.23.1735289014387;
        Fri, 27 Dec 2024 00:43:34 -0800 (PST)
Received: from localhost (p50915bc6.dip0.t-ipconnect.de. [80.145.91.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679eeb1sm10465468a12.48.2024.12.27.00.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 00:43:33 -0800 (PST)
Date: Fri, 27 Dec 2024 09:43:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/4] iio: adc: ad7380: do not use
 iio_device_claim_direct_scoped anymore
Message-ID: <befxu7wle3sq5egcwqhxx3qkvnye6cru4shufngyqvp6uyurkh@6d62xfzzuqss>
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
 <20241224-ad7380-add-alert-support-v2-1-7c89b2bf7cb3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ladguza3gb4gzncs"
Content-Disposition: inline
In-Reply-To: <20241224-ad7380-add-alert-support-v2-1-7c89b2bf7cb3@baylibre.com>


--ladguza3gb4gzncs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH RFC v2 1/4] iio: adc: ad7380: do not use
 iio_device_claim_direct_scoped anymore
MIME-Version: 1.0

Hello Julien,

On Tue, Dec 24, 2024 at 10:34:30AM +0100, Julien Stephan wrote:
> Rollback and remove the scoped version of iio_dvice_claim_direct_mode.

Is this a preparation for one of the later patches in this series?
Mentioning the reasoning for this change in the commit log would be
good.

Best regards
Uwe

--ladguza3gb4gzncs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmduaLAACgkQj4D7WH0S
/k4ycAf+L+8MLST1YxuzyDcCM8wCXQdBnINZIVBTwtYe1wqvx/Zt6U43qIL+ECPz
O1hp7WSek8TCvNBExaUsMgD2bbKKSil9ASqWHuqQB2hHZf1I9SUJXEA3kmVi8xmi
TyDZ5Mp1T9f+Ra7NOJn453/FytLa9E9LF2apsKTSUO0P4VbDURPmejHkkKS4sNHY
8xE1wggOyZ90GSiMzhpWPC2g6RuHCCI7N95+HALO/wi85gaNC8DBla26fivc9w1x
Zf6PG4TgfnZpPyumbJtOtZkULR2w29lVLdfmwX9VMo9+345nhK4s7RPYRaHs6f6F
ZS/Km9i5VWNiRTUPWNMEJsycPZE6GA==
=+XKk
-----END PGP SIGNATURE-----

--ladguza3gb4gzncs--

