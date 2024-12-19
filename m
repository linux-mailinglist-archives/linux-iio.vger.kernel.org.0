Return-Path: <linux-iio+bounces-13635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4B9F7A8A
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 12:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DC816A086
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21522333F;
	Thu, 19 Dec 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX2hWVBe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DEF2236EB;
	Thu, 19 Dec 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608405; cv=none; b=PGhF9rFhJS85iQtDR8NP7wZWXvhZDmqlmT7ELnwWqt+Rkh12JuHK95WeW7i5trYcWie2di+eaEZo46QjtNahrZ5lSBFGITZ73xoy6vWbw4/tnwyuI9cmsabcie7ca2Ez4z5Rj5h20xR+TtoZeKukLThQyROqs+L994+KZcVHNg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608405; c=relaxed/simple;
	bh=GsWX0vVkkirrGEurGYJ73upRE090niXMZMeSM5m6kh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN20oFCJxjLrsB/GTHoT8oXDGrrpiOr6zbSJBWzAJjoOJ6+I+nmBhUZGXkCG5HOBkUyPqIUPFT98gcKZO6LIaFdEXqG5jHfbzd8Q3I9FoX95LxPiYiaBPMn5nKxMXisj0Nk3v2WUVR5wBpGMMdpsHBQIgB+93WEqSNter/KnSYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX2hWVBe; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e3778bffdso692148e87.0;
        Thu, 19 Dec 2024 03:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734608401; x=1735213201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h6kur+fgYF8cqbUvJGhld4diSdQInsPI0wEyhGiq1Sg=;
        b=ZX2hWVBejCJsrs5SWZVzNmrMYfkTtyQbZEJWQ8j1AF5dam5xSey2S4FR54H+2mkCUz
         rJGsEjYUEIRD0PgUsXnsCBkyGm03VZt4d1FW1UnlFSoH0xV5X6dyiHOctDHTkvTrHv65
         rM5Egz39MOvACztBi/PoBJqSry4rtIbmoeXuZ8YmNZkmChNiMQMz8AriqkYzDuCYwlO7
         vx6Lyj/21SSljiEIWnjbWIUWSmq7UFhC1fFDy7tKvQrVYQ1xCTWsq8Y1nx0ARneW1ROk
         lYpot/qIpFvoZELLzKy7yIme4rXuUXfrM8z0Obop00gLvTMRVH0VvMAIvbKmVwFv5sF3
         mLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734608401; x=1735213201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6kur+fgYF8cqbUvJGhld4diSdQInsPI0wEyhGiq1Sg=;
        b=sTfX6t+ICsBBi6mNkoSpBOUr5mH/2TGfetEOQawNv5A8PaLGCjZETSUoI9rTi68g1r
         gLMoSbCaXb7KuppcG3b4z9o998UrCJJlMT6IVPmAT6NTjr44rlAdTcbkDmL1Q/RRIAlW
         9iGjfS//fSQ8qyR5Qxq+SIbo6nIBoxLkGtRgnwY6Z5q3hnYR8wbWxSKUgzYibCu0dX/S
         EpUWHWlPrtc1D8BhknoOhc8HWrBTyd7xJYgFdwAnrpBT+d4Q4TuXvmihheMdg0Et2nun
         4jAKSuLcVSyQnpqJwwhxTNmF3XaEVXq0XB2+1gicHwULeyGS2lO7jC4KPxYtgleGXOc/
         kSyA==
X-Forwarded-Encrypted: i=1; AJvYcCU8KKDKxv70Dh02uOnuJW6uI9bQTju7LP3J6aXOoEtY2VRZT8XChcBGkU8zoYeai1iG2Me985NUaz2n@vger.kernel.org, AJvYcCVZD2QpXvdtWR1e+41M5lmRT+sDD+9F7PQEKp7wixuMeU6dVUv7avWqW0mplQ4HOGjaH36whuqQUQT6@vger.kernel.org, AJvYcCWxGORktWbtXADtFB4g2G0UT9OExfnh7QGHiFTzBPOWim5EsOdnoPa5jKlk7EKTJGJIRTYcQpGcTF0O+5aG@vger.kernel.org
X-Gm-Message-State: AOJu0YwsvzmBow2Y4PWlgpRJDTYa1lx1f4F+5SUgJxiX1Y874Ad0ui1f
	3w6YgGFIC0qLdv/U3jML2BciAkt3eJxUbZLGaSqTybkbqD8g8QA4
X-Gm-Gg: ASbGncvLSOiiZFp6xgynRNqLaIoujHot15eyKpZnBeypUtOZh0MZ7inLgmA6qJ+pLmv
	rYoehSDwLEtLPrP25pIOK3UJF90i/qjOg81uQcahLIV4cdqu0O1xfXNvv9NTYiZ4E7XI9t2DMc9
	4HrTJechnLQUqD9C05+TcH5qkXB2ZSVtm6bCCutNma26iveajKpaXuDOKMX5M5Vh9q9CzP48+qy
	HxSO++pvq9qLSnd6DHyfUf+gesRwWQlnh7UmUKZsSrDI/Q/HOR2EzBdvZw=
X-Google-Smtp-Source: AGHT+IEjjBezRcljXDPG5A4unoJxUR/ijpAt9XHxlqsVSoLPsvSc5YtkKgIxlBOQkA4qy7BdPW6yvQ==
X-Received: by 2002:a05:6512:224a:b0:542:24c8:e072 with SMTP id 2adb3069b0e04-54224c8e0e8mr488352e87.18.1734608401260;
        Thu, 19 Dec 2024 03:40:01 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238217f9sm146250e87.211.2024.12.19.03.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:40:00 -0800 (PST)
Date: Thu, 19 Dec 2024 13:39:55 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: Add maintainer for ROHM BD79703
Message-ID: <5e99d4153b61a0d62174b8bde2ba6ae49da1e970.1734608215.git.mazziesaccount@gmail.com>
References: <cover.1734608215.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iYubq3X35aU1OuNi"
Content-Disposition: inline
In-Reply-To: <cover.1734608215.git.mazziesaccount@gmail.com>


--iYubq3X35aU1OuNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ROHM BD79703 DAC driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e5167443cea..98a3c1e46311 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20286,6 +20286,11 @@ L:	linux-serial@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/tty/serial/rp2.*
=20
+ROHM BD79703 DAC
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Supported
+F:	drivers/iio/dac/rohm-bd79703.c
+
 ROHM BD99954 CHARGER IC
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported
--=20
2.47.0


--iYubq3X35aU1OuNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdkBgsACgkQeFA3/03a
ocXDsgf/erOfwszOIiFolJkx8xGhrowZ3vlsDrr7lBEQM+R4cQZ+WKqso9cS0aqd
FIbnBBt+jlOAklLFviyttHhzQxT/cjCle6uvgBXAN70F/WAQG4XXHI1JBrD/HsvZ
R2cBUqmADBLNtzg1Yl0Wh5/Yn3Prkzs/CwxKs4YvKc3cNAWlEFOjpPo5zgg2to8U
mDbuVMA5ZI2Dn9Y7H9sLVGjuFoHB73Czjuc+pqHvVM+RuKBaQl/U7PFRBRH0VhMT
pN1X46obvLklG2llMdZvqQ3Xu8AUWWLHErszGwvOQwhFc3u6DqHGUiThTzZr5c9r
0lIIHSuctSckEm3bq9XsIA8OYR4zsg==
=rz50
-----END PGP SIGNATURE-----

--iYubq3X35aU1OuNi--

