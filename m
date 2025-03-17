Return-Path: <linux-iio+bounces-16982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128D8A656DC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED808828D6
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF5F17A2F3;
	Mon, 17 Mar 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZAimQDE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11933CFC;
	Mon, 17 Mar 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226719; cv=none; b=Fl4UcUm8AA6W/QxCK6E30/DDubRcFBHAcuoMDfbvYZHlZFzskRwe72j1svl8CLFa4FzZkq0pHRZyVDvq3WamGfJy+yNkaAwHPnQ9RsR2bHqjRXw5zN0k0suPUJaY3gmB4Ll1YOEfFnUgiIM+QHU9MVaERPYEvzxJd1GHdHOISX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226719; c=relaxed/simple;
	bh=eliehQmSED6ZLdGKFLCGCL66TSgMBns2UD6vbEEW/ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhIpFj20MjDLPWHLRqU4ZnMhWUKOsUKFrc98vDIqhca7ExOdyL9nV56++mB/cITSU9Xg2LP1ybDVI9KKXpVqg5R1xXlYRoJ6AMlAcbcLtrTNoPxf6MfDjA4YZgYs8MF6MS/cT5pui2RmGk5xEp8F6VPvCdl2Doz6O/CJyzjGs30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZAimQDE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54991d85f99so5818125e87.1;
        Mon, 17 Mar 2025 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226714; x=1742831514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7RMbwD9T0YIYh1FDcbo44IKaO3bc91LZ5BiIoh4e6k=;
        b=YZAimQDED0QFqtqyEf83psS0KqUYmg3NnK/Xy+XhKJ/N8I0uiJNBlFbYnDl4jQP+WA
         +hRFXuwc1gW3FM8kl/U6yO5k1NeMd80a5EULjBD5Q1atzcweUD5knEoFC8taNTH6ciyp
         8tQB4Yc38NUcKN4zf1TXCDFWpWeHA+KXE6d/eviR3L5q3AFf3HsgvBJlWgxUtC16arHx
         LZSXGWCaebdoRUYoxmQBmVDwmVzmEc1QiyAgIVOVPCeMq5f2lXNpOjU3Xe3MGPxQi1MC
         /SgJeO6o4FNbJs3RNUlAXait40F9z8YeVTdjHkjuuWxkFD9lvRi2quNz9fXpN9u7quwQ
         XlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226714; x=1742831514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7RMbwD9T0YIYh1FDcbo44IKaO3bc91LZ5BiIoh4e6k=;
        b=iFuufDx77SckPUhQose1dRGe1zVUAowhJ1IVZdzkLWIwcP1JIYvOh+UcwuWoucC0NH
         p+5Dd/ANJHCRsjxQa6kTLBwKkDXMpWX/u4K4I1vS7sHKrx81wVfyaG7AOs4Ky8zqtpIk
         EOHUYhmDjx9kDw9uxOfcJ8eAvdsziR4sUQ2qxQxZzPCHg9rr5GuL7gHP2zkQp59ZGJNq
         GIh0Gz5MUAEQ9h9NOpZVagGLOH+7aRgPOSXn5zupcLhTAbJbQPjHI25RTpwt48JfpmGv
         jITWFy2XZmaH7J99Du3fCyyel3F3zpKzKeJGOwDIG6H9Dtr0sh6gUetds9MRlUhcBofA
         CF0A==
X-Forwarded-Encrypted: i=1; AJvYcCVmVkwu6CIr5MQctrOHqCQalCWyfwxRvI0+KlLqXAdMWuZTTnBWLLSbu+c6It0sHzpvZI2OU5DKdFs=@vger.kernel.org, AJvYcCWKZ4PtfBqlYWsDsUOSSc/B6efbsVqfQpY66o22t8iCBAsS06tm71qDijl2A5dLQ269n+xIoYMszN7ZX7qB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Huh20LhBnLMNfH5Zvk6/V1S51zlhcA9jmkj4K8uZ9UZVSCzw
	PNg0MbXcaNzyfG2t3Yu5ylYl9GNEDKs2Kdp1Ugm9HKU+upwvwR5N
X-Gm-Gg: ASbGnctTyAvKzlrDkRMmnXtfhWQQOGfJx+N8APxk7nsodpYu5dNs+J5C0PTcpTQO7q2
	FeTdiVZ7CeL2QAhdzFuZPUyaMx1aDaPUaSWzdJ64eHzlVarTPkXwMpC/Dc2Pr5XaPOOtcf3Mzan
	FpLoFNWF3veS3mMnkADeN4GQYyf+Dlvghnvg882IXq4wMCJcgbIVwW2Q16AdCMpuZrYnkdItHl4
	xvda/PlwyRqZ5tC+pi/kRSBjxDfWHcmJPz99/lHnznbV7dEz8adSKzA/AFU921TeNGh+qLtg6j9
	1SNY2aDTvXzwjVa6N8gzUUabO6oZfeBEfX8zAyjri7JeCV58rFw=
X-Google-Smtp-Source: AGHT+IG6kv0vrE71YUv2ONXRJaJI0ozx5CMID5qXI+yy8w+Va5mV8JCdilkm4x3T269NuRt/mMGKmg==
X-Received: by 2002:a05:6512:39c7:b0:549:9606:adc0 with SMTP id 2adb3069b0e04-549ba44cf26mr9417708e87.25.1742226714189;
        Mon, 17 Mar 2025 08:51:54 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c192bsm1339900e87.89.2025.03.17.08.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:51:53 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:51:49 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v8 08/10] MAINTAINERS: Add ROHM BD79124 ADC/GPO
Message-ID: <7a92d2ac28e5fba4d22b680fdd1da02a3b6b4755.1742225817.git.mazziesaccount@gmail.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DSI4xjZNs6uXpoIX"
Content-Disposition: inline
In-Reply-To: <cover.1742225817.git.mazziesaccount@gmail.com>


--DSI4xjZNs6uXpoIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ROHM BD79124 ADC/GPO driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v2 =3D>
 - No changes
RFC v1 =3D> v2:
 - Drop MFD and pinmux drivers
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b96fb864227..2e4416b59930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20547,6 +20547,11 @@ S:	Supported
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


--DSI4xjZNs6uXpoIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfYRRUACgkQeFA3/03a
ocUSOAf+Id+Vn6xRpLRDX8ynkpctX9jpnsyjVBa9PcvkgQV6VfPDgyaPt2TC4Xnh
yTv/tiw+IvT7gjNbcVzvzinpDNryrcB49J2br8Ewer6OJSgSg15PIMQlE1NexDbg
nsk5PmUnsX/OnvFsX1TmEFMx37U/s4gzdxGG8svPrCv4HwsZ8JoWXx+nx8PkQecQ
RXf9NEG9POe8k2GkVx8GBZmCnt6FoPZ0im37MsysH33TsgU3xzng9Im1VJCHxCEj
LRMkaUS/Bqq3gs+33gxLe9WoreEIKUDgpcqJ0vta1aHUfSKI001JpqQB9Swn2asB
tRMdJPoAW63fdZA5v7EzuL15OSJchA==
=lOQZ
-----END PGP SIGNATURE-----

--DSI4xjZNs6uXpoIX--

