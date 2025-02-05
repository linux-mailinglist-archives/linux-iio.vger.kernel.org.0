Return-Path: <linux-iio+bounces-15040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F50A28BE3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 14:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89FC1889549
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE9C13C9C4;
	Wed,  5 Feb 2025 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAzkC6lm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA4413C809;
	Wed,  5 Feb 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762739; cv=none; b=ZpDpSyQmHcK4uqCRxZUWEtl9/VHaKn8P7ZecLsTbKTfPW60uGgfmSNdUYqgIf1LP3jlE0M5ImzGzW0LJ+cciwkaywBrlNKh9aUG1gCVs5L/pLi9GUr1Rd2KXZRfi8bMHSLQ/sJ6S3mIhtWYo45OFsA37F9Y3+aNQcDkaihcW8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762739; c=relaxed/simple;
	bh=raobH1AAqjHoDB1BwJMczFsjRLyJygwLUNUlezq+2wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bATXUhfvc+DPQo4PEHObtrWs6PHGi9+Zov4sthsSzF4o8xDn0HHR5yxJP9UjqtfkdBMqb5HniuuF25M7Qc5hEMN0W6NOD4r4Whnn+wu9YXsMdRmscCSauFzLQ2E++r7ZQSg1R69U6ytV0MkGbAQrx/Tjj5vh1oVXmN8yROcWX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAzkC6lm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-543e49a10f5so7048080e87.1;
        Wed, 05 Feb 2025 05:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738762735; x=1739367535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+eF69YJfyDUqUZ3xyozLwofvRmz2EfcOQE3v3ep5Oo=;
        b=cAzkC6lmPJyOv4v3NDdhAH9dfnMhS/Zkd2ib9k7+4C5uOZDtndeYdHd3+TI8HvgUPu
         QDiv4bLOJt3geJw+OOh47n2GwIOGUMyp5yIgkfWG8B1YsY6aRL3FPzCitmjswtUMAsok
         EYltKJ9753wPY80aLmO6NObkvTHHqDHTKJL6zXoImO9dqATkLTkg0LOtV7vS6AuTS6wx
         M6g+yZ4XAn4wM0A/92nx9aUjON74KyVsdW0LUlgLFwlGp8LvRaKZEka9cLfaR8n0HjA2
         oDzuCmHs40+02GfaIwD4GAQ8DnYlFSKJBlUxHhthjAnFWnilo7h6/QY+zl+BLcQiSpTy
         Dokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762735; x=1739367535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+eF69YJfyDUqUZ3xyozLwofvRmz2EfcOQE3v3ep5Oo=;
        b=u+xLj37OxI1TAjGwpGH65RoWRLOqC/PKj3JArrEaXDMRStPzJyLhaWB4+3k7+M8M+U
         OuuJY5vzAqx3bYfwyPK3MkjXq8fbqHsSnd0urbiEwChYGBgS27UFOMijt6/Js6YTf+28
         dy78SSeFV8XKYz+L8sn7My+px2UBzOKf1QRddGv1hWnCNb2IXPcLPCpG3dfz801i8vtO
         YbxcwgcsXrfGRQSJ5MvtCI69nypdEBi8bYsTiqhy3V1fmqY5a2fSjEiN//jZDeDxp7wu
         9HPNq7EXv8q6WXrV0/e5GF3YwR3umAFtXWwmApX4nj7AFTqCY2YF3z94rDwdqW7qgfhE
         0wFA==
X-Forwarded-Encrypted: i=1; AJvYcCV3yNTPQXy3Hb/TgevijkOi4lRuYQEwdK0zZ0+0zqQCrFf4sS+1gImhabbBHbSP0Vs0CSRkUVfPhnsv@vger.kernel.org, AJvYcCVCJjJBtciR/gr9wEMmOBaSGOJ0VXPXJ8cvTRRN/45QoxEh2AHu++5ECuTS1U7VE6glFIqtHUXnNXiSTk0g@vger.kernel.org, AJvYcCWnhavXLMdmWRHGcsG3ae7Vv26Rdvt9kBg9Ac2F7SrV9eq9yCw1JV8xyETZEHoMisuKjVqUCAOZIck7@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNaRp5bBxg6hlL0IXjFRXuC4YIraY6YQ73s3pU6XHivCsIPTU
	6UHtb7hKCVoF56QJJB9AxQcDUpDuZXSaBzsHAibHs8PtnzzTUAoO
X-Gm-Gg: ASbGncuJJollCsV0qWanp0m2by7JmNOuIKro/RwOqpO/AJ0YZ0P/uCPMrYAAqbBH7rf
	TzBAizXX28v/P/ACzD+6zVzvVlPvRk9SoqALFDWU0lymbzmOO5gvgEURRtFqRcxEV8nRFn51MJI
	wXAnnMp0ToZGr0cd23fmno7PwUgXPelXpME/wdp9i7YeaqxcFtbNgA4ywPcuaW3xeIAY2SKQiOP
	pgMg5m/Xq1/r7rjQkajc2uqHB9vKxTiSejvo4dmRVUpscbI3EoOxSSP75oVjrdiaEIUnzVoXC8v
	RoDGOoIw2ZYO1RwtZw==
X-Google-Smtp-Source: AGHT+IG3bOHMuIMp9zVT9UKfUzyVJFfsg7I9dpDQnc16U0PPfNqdG903ZKhuGgJOTGXEJSQDwfbIxg==
X-Received: by 2002:a05:6512:3054:b0:540:1dac:c038 with SMTP id 2adb3069b0e04-54405a10648mr850283e87.1.1738762735064;
        Wed, 05 Feb 2025 05:38:55 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb797fsm1890124e87.189.2025.02.05.05.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:38:53 -0800 (PST)
Date: Wed, 5 Feb 2025 15:38:49 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] MAINTAINERS: Add ROHM BD79124 ADC/GPO
Message-ID: <d04f6066d251f7d8c395aa33284ee8aebf7d941a.1738761899.git.mazziesaccount@gmail.com>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SO60h9fXL5bOVNze"
Content-Disposition: inline
In-Reply-To: <cover.1738761899.git.mazziesaccount@gmail.com>


--SO60h9fXL5bOVNze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ROHM BD79124 ADC/GPO driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
RFC v1 =3D> v2:
 - Drop MFD and pinmux drivers
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bfe2f53fa74d..2021327e665e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20299,6 +20299,11 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
=20
+ROHM BD79124 ADC / GPO IC
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Supported
+F:	drivers/iio/adc/rohm-bd79124.c
+
 ROHM BH1745 COLOUR SENSOR
 M:	Mudit Sharma <muditsharma.info@gmail.com>
 L:	linux-iio@vger.kernel.org
--=20
2.48.1


--SO60h9fXL5bOVNze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmejaekACgkQeFA3/03a
ocW5Kwf/QrSJ32W+sePn6wWf/kiqMcr7B4lCp/BsiVJ0Nl+OzQiZoqGl/NgOC8kI
fL/cx8hHdQDsqk18jh2uBdKl5523Ay57VFZHICFcaF7CoM6+x7SabgfMBBPOeNjw
9T1NKJ/RZGb2d9NEQr4otzlMqcVQ+solyHAZ6iZKToykSVPI73RllpRzDKhFS2/G
c4A2qitGOh2osBIe/A+9fYh8C99pG/QXu2YbFC78AWtJG1Ug17xYRdHJe1XvCEJz
ChTMBR4NleVDS1ci1T6gG4tJw0I2o5qvBSLloS3TN6LwzmmHI5K+vJa9N5M4bY4X
zmK9qNQrPf7BjaGEGpRXSwEWoOXELA==
=Oz7P
-----END PGP SIGNATURE-----

--SO60h9fXL5bOVNze--

