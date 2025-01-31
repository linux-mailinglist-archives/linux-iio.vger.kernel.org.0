Return-Path: <linux-iio+bounces-14753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421ECA23E8A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 14:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32513AA863
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5441C5D69;
	Fri, 31 Jan 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBWNGqmW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3B1C4A2D;
	Fri, 31 Jan 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330740; cv=none; b=peWWx6yb/pKEtvuOqlc2rmoF2QGcPYiPM/f/3JWWpdQBikwyGkD+Lpqnei6ocGLt9EWm78SCHqddPoewU3m2Qjg1EQNhd9UGw7gL6Y2Ap9jzI68QUYqT/qGklksbLlalCX7Xzfj5O4xho8w2KI6FfZPx5p5NCGZ3dWs8iHlk23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330740; c=relaxed/simple;
	bh=FtgVvQJ66p7mlppcA77ZjwjToj8ifzoL0t1H7yx2hmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iepj9YVBdT+PvD+aqumiQ6j2k24j/fKy/jlXvFQLg1cG3HgzmTzokFJCvrgTyqzsnjdwpcV6MjpjimE3wKJDc5CYWUmAuQNdxC05xVQ7exRu6ZXiy5UvFZI1XqOUyPlDcxHwM7rgh/1dS48LvhkiCrx6Tldd7tm7P7RJ+jZLso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBWNGqmW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3072f8dc069so17857621fa.3;
        Fri, 31 Jan 2025 05:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738330736; x=1738935536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84Xs63QsOvkGnZtwAVo6Ip/KDUwY/ag3iPDIK7CB1Ww=;
        b=LBWNGqmW4YINzXn0nNi6U4IiRZqATQJMciwyVmi0Ica4ESFDIop9dQSiTniUJ7pEbA
         sTXaRKrZuzPyzbtRdshSclBz+CqazbWHho0Dc8oaZ5XKniCVFDPNj2nx9i9ReccHIv64
         hbzdWyhlHC61f3NwUkoboUFHyH2ZiW2yE1w9wso8pp1xEFYZIjy+rdo9HcjU4BIdLdOz
         UvELQmDrIktSuzFO42EZY+68fzh+mCu/pG4WTl9CK87rvhjfjy3L+5Ub/Bt0vRKi357B
         zuDxP8jNZG42AfUasjwPUqf5XUx+cjZ2PKVZFSwvD78Fkqetrzrco/Y7hO8G7+RarzuL
         Mf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738330736; x=1738935536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84Xs63QsOvkGnZtwAVo6Ip/KDUwY/ag3iPDIK7CB1Ww=;
        b=pqyA14swHKLD5r5U4wnnNGHGZttoeYuhIzNRQeNzrJIZkY5vwZKGnGFQ4kp7QxnSaW
         LJZArmrSxuu24Ca4a3SXimbFeFl+ZE/mP1XnnGXQpyUGPFoYcjN4ZPmcGrmlaGl/gqcH
         fyz72oIuY32+u8AiaGZ1BqXPQCTuXRnfUOZTsVzV9Kz76W4jo0ogx27GFofhN00/tqNz
         ADRlUDo94KY6n/nOGZthJPMUFlkE6rKdtSP/DkTg1cprW0bbDd0vcluQdMZJLjYxYlbB
         QWd4EiTJSAm20agUDHFCilHUeSobYNGIK8mndqo8DydPk5sLdPJCzBRnBURMY95jHZzu
         R1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV29VP/uVyE+j5cwOTuXGu7azJYY/QKE5fL+RHMqvYl4Lzr+mPJe8gSaf3zLKg3rlFlsMU9fMKRD6Il@vger.kernel.org, AJvYcCVXT3dHhmu6VwmSgh3vp4HgmTW4OFg6vv2Se5ejJk4jrWmhuQgNg2hhdEX+/LNxR2zhu+87SGOSuOEz@vger.kernel.org, AJvYcCVbEqcyWajx7m9nzbOkePx943flanxRTDIVGoeJ/9AXinSOb9Uc+5m0F+FfiS2Sqh5aweLtO8SGIxGL9A==@vger.kernel.org, AJvYcCW1Fi5LC1frsAE6yffwX36nJ65SdtDJ4E2bM+yXQypH44/Tad8sW6Rx0XldUW91CPY2LH+IvI4Z5sPO07mm@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvFxiDzctRCuE1AlEXPLWACKA/z+pezh4xmRFvXeMAKcBaWzF
	cNw2eSayZpOXJT7kM8BufPPEUwzXOnLq0XFT/8m0oJZsCFHkq0Ot
X-Gm-Gg: ASbGncsNSrWdkblvFShVOHnIw4B1b6EoHz+AuDb5rksNdtd97EwuohYiYY8wPmfDcod
	rLzX5IS+oHwjLnx/HM0HSuT4yivqxssBfyeVN5bRhDqUFnf/CuOlnqL3oWRc7DYogLbbJhL7LpZ
	bfmCoidmQcA2ZPTNIiFkoagAT7aBwA+qmBZmztT5L7bIU0A0Tx1xvr/2grECGDlbKFIRTYduavB
	XciO8qtUQYszYSECi7m/nokJVn0IrWY3VR/yGZAbDeZZpKdgMdyPve4HoXbKsMe32RgPszJvPJ/
	kRsxCDEjJsyEeIFP4uzfzciWJVvRgNcq66aP60476AYOqAw=
X-Google-Smtp-Source: AGHT+IFu6ST6J+wp9Aosz0qs5Y5gW+bsbTLdcpz3NmH1HifLED0DOLGg5lNq2F/y6f3zo5eFT2N1Qg==
X-Received: by 2002:a05:651c:903:b0:300:33b1:f0e7 with SMTP id 38308e7fff4ca-307968d3606mr39259361fa.10.1738330736253;
        Fri, 31 Jan 2025 05:38:56 -0800 (PST)
Received: from mva-rohm (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a3428055sm5600751fa.98.2025.01.31.05.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 05:38:54 -0800 (PST)
Date: Fri, 31 Jan 2025 15:38:45 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 5/5] MAINTAINERS: Add ROHM BD79124 ADC/GPO
Message-ID: <7b767eede329fc9194925817a7350a76786478a5.1738328714.git.mazziesaccount@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o6j3hbpst1Vid1XP"
Content-Disposition: inline
In-Reply-To: <cover.1738328714.git.mazziesaccount@gmail.com>


--o6j3hbpst1Vid1XP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ROHM BD79124 ADC/GPO driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a87ddad78e26..19314bee95b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20292,6 +20292,14 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
=20
+ROHM BD79124 ADC / GPO IC
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Supported
+F:	drivers/iio/adc/rohm-bd79124-adc.c
+F:	drivers/mfd/rohm-bd79124.c
+F:	drivers/pinctrl/pinctrl-bd79124.c
+F:	include/linux/mfd/rohm-bd79124.h
+
 ROHM BH1745 COLOUR SENSOR
 M:	Mudit Sharma <muditsharma.info@gmail.com>
 L:	linux-iio@vger.kernel.org
--=20
2.48.1


--o6j3hbpst1Vid1XP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmec0mUACgkQeFA3/03a
ocWq2ggAha7RpicLCvSh1r6rcYwfhY5aGV4xKWdqbD4LSkdGH5vGmpt/8CZXI+5e
sa4djP7yNXCNcRyEzalVDALiw5YuXlAaF9VJ/Fy886h86DXbLw6Oq+tizzCZIpT7
bRusRxliMB/lVyg5DjZng1aAQsvkSApT/QqvqJaBIE1ZElsEXhegmhh0mET8R9Xa
cg1dPOZCPXTMyq8fNWHcGnR4v2IdMs9ziXSVv/yQnAgLeI0OXt0QlMAL5IyVxrqk
TVCI9RP0heeFuoks+a6tzXOeliy9CZP0yNjTErKYb2mlKgFi9SEd4TkhrF6iizA9
sOI7QaOcjq8lKjJQrp+sM5jMAulO2Q==
=cWFO
-----END PGP SIGNATURE-----

--o6j3hbpst1Vid1XP--

