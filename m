Return-Path: <linux-iio+bounces-11869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132E79BA5DE
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 15:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC741F216FA
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 14:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1422582;
	Sun,  3 Nov 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZUlANDey"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632F33FE
	for <linux-iio@vger.kernel.org>; Sun,  3 Nov 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730642424; cv=none; b=bqzuT57dpJwwj7f/DD+GE0px7KIieDXN8Wcu5MIBVnMYqJwQ400ALi/a/fv2LMvMtK/bf3KO3qLNJiEyXhbBen+oRrsC1QjkL1hb2iHjOVInQWTWjSx49zXvG7xhYPe8tcOAJzfXRayoptkStTk8WJ9rNcSzzJ7TlUCDPgw4lC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730642424; c=relaxed/simple;
	bh=HW0xkDerZUwC1H4Kuq1940vxcFFwZNOG+FdLrgr34zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoQq4357QIMb220qfLXDXaSEKJF/GGQAAFnkMW22EBCOhxEyJ07+WlnJu2UrgNDkjanB64WbUxAsooNH9yUDJk/GiR7teXB1V2t0UUc7p5WCiXIe6bGUlXjBst9nRvmJ8Yyr2VVXacUwr6gaR2f0kZrU4yBnb4e2eCoWUUK78sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZUlANDey; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c94a7239cfso2066309a12.3
        for <linux-iio@vger.kernel.org>; Sun, 03 Nov 2024 06:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730642420; x=1731247220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Zwcc6mJ2Z+M1jD5t38WLUuaC+7Hx/sCtRGVgR6vlbk=;
        b=ZUlANDeyvzxiHScaQ2FEQ9Jq9RuXItkIYIFLsjKRosBPwOWPUzSQkKdBmQ9j9DRSaK
         t2NPdgYqRT8XQyqXTAeZ46IWepony0ntayu2WwMuFBllwStN6pVbvyScsAbiGU2+L37Z
         VHyfJEqXZZz4wQHNldqLVMJNWPISvKqMP4Z7yGfgrl+gHFCyQt9wnD/C3UW3m82wX54k
         +m6eN714llaNVAdsnpjVXkrKffAtGWYGSY8i9bReez95c4HcNZ5LNaR1XjTF6XzhkUZJ
         JWJ9BCYeoHMJCnvfVHaQex+YKzTO1hHihLRwKf4YHhiC1R4vQUa5hWJNvxrLbFVRoNgv
         2DPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730642420; x=1731247220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Zwcc6mJ2Z+M1jD5t38WLUuaC+7Hx/sCtRGVgR6vlbk=;
        b=pjhuG2jIfCpL1t4mjfs06xsljY1SdO3R57JF3sFgOlw62aT6v+QopaVlOm0hGed48E
         2z7y0px2tSZUSlmT2hLrZ/Fe+d+EJreSV6p7UMrRlbpXbaSt9Tobfl8QqJeRCJGdCUEh
         xdUbxNTVfUYEj3Yw8SXAkksJOf8pXWAShB/l8Nm3M3+6qxLT6Xk5TyCKlN+ZEILrpNDD
         0/nrzubkVk6/5s0xAhB4QumCs2b9ZwiNclAEsn28DkNxjEbHHAD+euaVXTXZJGfQbEBQ
         QRVB5YBvo60JYkRsmPvNqAS7VFHyezorxjqDP9RAYDnzEj+TmIDd9375YlqGysXT/x0E
         wvBg==
X-Forwarded-Encrypted: i=1; AJvYcCV9Nvup9bzLwkTBXQ6OZw8Pxd81RSTKqMcF2ErYUMZ+e9mLl3i0th68BU6LZkvmU0I11ZzeBtcVLi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybPJ2x+735n9vzVmNeC0JbEsCxKHSvBnh4F/i7f2gpeywHDeiG
	aTmYDiz7XO60YZh8ypkeen5nF0nKVgaJ5AAV6oO8nRXqxHOM0w2RUxNkwG7aQcE=
X-Google-Smtp-Source: AGHT+IHuuxLDk9hwg0+iu/v28lzVF3K4zk9CZmxe8Kkj+OthvudFByHtLuWu3au1z0eWR3PyoVpO5g==
X-Received: by 2002:a05:6402:2106:b0:5ce:b715:6529 with SMTP id 4fb4d7f45d1cf-5ceb923efadmr10173655a12.3.1730642419742;
        Sun, 03 Nov 2024 06:00:19 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:d0c0:5ce1:4bb1:2797])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7c8c77sm3265183a12.61.2024.11.03.06.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 06:00:18 -0800 (PST)
Date: Sun, 3 Nov 2024 15:00:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: kernel test robot <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Guillaume Stols <gstols@baylibre.com>, oe-kbuild-all@lists.linux.dev, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
Message-ID: <d44ab5s73kmochmwis3buhd6ci7ff4rwd7kgh47aqar6xeyqna@f4plwf6qbvlm>
References: <20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>
 <202411020101.5Hs6MkwQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vwkk7mov6pa2u6sg"
Content-Disposition: inline
In-Reply-To: <202411020101.5Hs6MkwQ-lkp@intel.com>


--vwkk7mov6pa2u6sg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
MIME-Version: 1.0

Hello David,

On Sat, Nov 02, 2024 at 01:50:35AM +0800, kernel test robot wrote:
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on 6fb2fa9805c501d9ade047fc511961f3273cdcb5]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/pwm-=
core-export-pwm_get_state_hw/20241030-052134
> base:   6fb2fa9805c501d9ade047fc511961f3273cdcb5
> patch link:    https://lore.kernel.org/r/20241029-pwm-export-pwm_get_stat=
e_hw-v2-2-03ba063a3230%40baylibre.com
> patch subject: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw()=
 TODO
> config: i386-randconfig-141-20241101 (https://download.01.org/0day-ci/arc=
hive/20241102/202411020101.5Hs6MkwQ-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241102/202411020101.5Hs6MkwQ-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411020101.5Hs6MkwQ-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/iio/adc/ad7606.c: In function 'ad7606_read_raw':
> >> drivers/iio/adc/ad7606.c:765:23: error: implicit declaration of functi=
on 'pwm_get_state_hw'; did you mean 'pwm_get_state'? [-Werror=3Dimplicit-fu=
nction-declaration]
>      765 |                 ret =3D pwm_get_state_hw(st->cnvst_pwm, &cnvst=
_pwm_state);
>          |                       ^~~~~~~~~~~~~~~~
>          |                       pwm_get_state
>    cc1: some warnings being treated as errors

The problem here is that there is no declaration (and implementation) of
pwm_get_state_hw() with CONFIG_PWM=3Dn. Does it make sense to enable the
ad7606 driver without enabling PWM support? If yes, we should add a
dummy implementation of pwm_get_state_hw(), if not, a depends on PWM
should be introduced.

Best regards
Uwe

--vwkk7mov6pa2u6sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcngewACgkQj4D7WH0S
/k7XQgf/S5oqIxrk+tCZrofLS72CSpw69wFvTYhfwN/NrMGBNVp95W3Ophsa+Pkr
XdTPbdySiDYjjnL1fdSTpiQSYCm9hKuJG/656ke78cPP6duNzPVpckAyAJcvNhjb
NbbQdNn+HtQCH/MXFX4iqoTZw0jR/IT7F1KE/+1Dm5DszUQMreoC94p9IcCwUdcH
kwxwZph/2ztSwcAqOGlIQOy+qo3Jb2GXD+rTlJ46t2hNqji0P7XvMLwspODMf3EV
7qYGcw83e5J+TBvXiloklNFCaP9YBIyeijW2TrWq9SoPFLc4otl6YJUMytgjWL8H
4YxpizEk2QB8e6Qdh2eyTObScTuqIw==
=RL7H
-----END PGP SIGNATURE-----

--vwkk7mov6pa2u6sg--

