Return-Path: <linux-iio+bounces-25463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689E1C0DBA2
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 13:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B724222FA
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEEB23E355;
	Mon, 27 Oct 2025 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULgDssaI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E323D7C0
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569439; cv=none; b=SIYx0jU/ILF85wwQce8bN1ecumAvojX1QFQ5dnLEHIz7+hLRehumpxyV1nkslSQ/hCZEvKElamGOgzWl/i7wRwjenu15sMNLh/Zb4MmmFZmbYmOV0r91zOk6BgKOnz7CV0WucmhwB+eZrLLpSZRkd+T7aYxXv0ucMlGNHKgLOzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569439; c=relaxed/simple;
	bh=//LP4ZIpUIBimJnYthVI6VXTew7trKMFk+S3MMgWsos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h27HTNTPdiGGQUicQSxfS+F45pUaNZLDLdmw/U9dmx0g80i9/zImobQAbTBCBADF3f0ZCY+hSs1iCWv6hPEFjN5Ss8hMxke5CvZkTMObmwEkWY1aHO7WmuLwAVBUfZY1SiluT6wKCdCnwZKiYhmO1MKJOxIit2JnPZy3YLn0AVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULgDssaI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-591ec7af7a1so4814507e87.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761569436; x=1762174236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLy0RweOOoVTeiHNd4PNmL9sXN45PVPYR+RbrcPRfO0=;
        b=ULgDssaIY/Tr9bsr70GoY+PGDb6yVCaIncaJEcpcLKPGjN/D+k5XrJ4ETZsU7C+Fzi
         orUESjHOON5zD2ULRY0HFO8aDVBvdGOLl9YBLEyjum2AMqHMmwOZVT2z23m3S1cslIO4
         TyvxJwnT2a3dHtQKGDvfaCsLrJ2EtW0w2k6IXxFA1ZkkBUva+hUoZ/WvRgDWwSm7CGiG
         bj8bPAuX5x3sULrLhF5OnEzFdq28hgmDSNxrF/Llqvkn+ZsLf0T0B9BSS0I0z47HkNrq
         RzAsEKMkk2D/CqwcpKvYli5lpL0of9WkaCgWf1fFt7jPP2ciQamjL2u2u0pj04D0TtOj
         hO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569436; x=1762174236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLy0RweOOoVTeiHNd4PNmL9sXN45PVPYR+RbrcPRfO0=;
        b=YemqWt2hQgiUgpJFcpynsVmzQy539MK1F4u89l/VF7YgH/SQmqbM+sm/8po7DHePEp
         a6wm6jxBCd/1u6utxyxsHx4rxZHmWYt9baqUdJWRcOAc1KtkMxuXzCHVqA8EzUdV8aD6
         lE82NuLyvUG76vM5rghFQmQ28T5gfc35drwtUmeqAWPDAL7ngyeJmcmZ1Kdh/Gy56o58
         WRGJbh5zW5KNJkozpwhzKrCshpExX5Yea0nChRyPOIX8vzyy40YWf1se4KVJ3TCNFKjH
         U5lNbH78k7A1oIhztssqo7oBXDxZQAtriQukR5GUpQLYAMcahHThasNisbWG7ifZNxoX
         JV9g==
X-Forwarded-Encrypted: i=1; AJvYcCUWpiorIp2a2CEivP9jmzR1LVjtQwQMc1ts2qUiNcJHks4OKMj5VM/NevBbD3ARWCle2vpctlpUtN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr0232gJevi1cNSvh+bRyyXnMTNXAzzx0fcpDZ23QAglsYaRbH
	xTZM3LRpXfAN+6boZnr3LAKD5GYQiqpGORtPlmzWiEjncF7ksNItJKlg
X-Gm-Gg: ASbGncu5v3cVmEwS4LsknOHP6qTGAXI7nwZwuAk6tgJIdvUI2+UgcD/J8FMZTbPTWsd
	IPtFWYh+ZRIuF87qsw865IVDNKQOBBkj4VEDWFO0P8UX/TldG0m3RoiN/TqO4wFNJ4Xlo7tJrWw
	vamOGNxbXX2b9WuH9f7K666J1vhJw6+Wr4ynSkoxWb2btHHbG1oHGQWCuunJ2Jx1U9MXYUf7s7K
	jbjj3LRL76fTVfRpG/OKXUUrczXy1ishhOx9o3nOqKxjCeZ7vefS0X9AO8joBqrdHPob9WmZeRi
	VSjoIIKz9lJSBk/hoF+3/yS7bvUnKMCDZEbDqkB3LM3mrxQDI9bmh/yQtu+uHe9JNP+U9MVJ4Pz
	9sqUN+hCiQORqV6bJ3MzYy+1PteF63RT89byJiB9429ei49u3261YEhSE4EWvgHW6e5rlpEoi0T
	xmoup7zrs=
X-Google-Smtp-Source: AGHT+IHzHzJV/MeXyuL1LP7EShjpy6f1u+KCVNwR2I7dLHbnwGl8Wi5TY02j/6R81T7euK1O5hJeeQ==
X-Received: by 2002:a05:6512:150b:10b0:591:eaed:f7ac with SMTP id 2adb3069b0e04-591eaedfa75mr5565780e87.53.1761569435641;
        Mon, 27 Oct 2025 05:50:35 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59302a2420dsm2196549e87.72.2025.10.27.05.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:50:34 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:50:30 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: adc: rohm-bd79112: Use regmap_reg_range()
Message-ID: <0593569959d1e5740c53a9e232ffb2f9a708f29f.1761569177.git.mazziesaccount@gmail.com>
References: <cover.1761569177.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aTPVqzrIQiP0RGpf"
Content-Disposition: inline
In-Reply-To: <cover.1761569177.git.mazziesaccount@gmail.com>


--aTPVqzrIQiP0RGpf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Initializing the regmap_ranges using direct assignment to the range_min
and range_max members is slightly verbose. We can make it a tad cleaner
when using the regmap_reg_range() macro.

Clean up the code using regmap_reg_range() when initializing the
regmap_range structure.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Compile tested only.
---
 drivers/iio/adc/rohm-bd79112.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
index d15e06c8b94d..7420aa6627d5 100644
--- a/drivers/iio/adc/rohm-bd79112.c
+++ b/drivers/iio/adc/rohm-bd79112.c
@@ -168,15 +168,10 @@ static int _get_gpio_reg(unsigned int offset, unsigne=
d int base)
 #define GET_GPI_VAL_REG(offset)  _get_gpio_reg((offset), BD79112_REG_GPI_V=
ALUE_A0_A7)
=20
 static const struct regmap_range bd71815_volatile_ro_ranges[] =3D {
-	{
-		/* Read ADC data */
-		.range_min =3D BD79112_REG_AGIO0A,
-		.range_max =3D BD79112_REG_AGIO15B,
-	}, {
-		/* GPI state */
-		.range_min =3D BD79112_REG_GPI_VALUE_B8_15,
-		.range_max =3D BD79112_REG_GPI_VALUE_A0_A7,
-	},
+	/* Read ADC data */
+	regmap_reg_range(BD79112_REG_AGIO0A, BD79112_REG_AGIO15B),
+	/* GPI state */
+	regmap_reg_range(BD79112_REG_GPI_VALUE_B8_15, BD79112_REG_GPI_VALUE_A0_A7=
),
 };
=20
 static const struct regmap_access_table bd79112_volatile_regs =3D {
--=20
2.51.0


--aTPVqzrIQiP0RGpf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/apYACgkQeFA3/03a
ocXqwAgAzrbkjYxbIYVHh2PdAAHL6OptShkBBOnfVGKc4QvS+XzQdFhpBaeL9y6V
KcmRsDnwqAq+ArmXQvrLkIIgDnIUVBEMvYS4MbuB+Q2W3++FDZhe3Wodw+6B76F1
ilAoMXx560LWV9f2NuS6W56G/wht4iFwTImh2KMgV32vpnUaS9sgsXbshv7XIszc
d80BdTnUA1JTaCyxYkHFEw2GDZr7ImJXcn1x17QLcEjmoNOKIVet4WENn9GwM4YT
fmfyK3SmvOywRrJfHssyPBB7hm2rSNhY0Cqo2xgHxcyImbyoT/L7pbRivGZCZf5+
r+xeiXlbKAD1NpGtQ7lHWJR2GGp/vA==
=sjGx
-----END PGP SIGNATURE-----

--aTPVqzrIQiP0RGpf--

