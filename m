Return-Path: <linux-iio+bounces-17730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA0CA7D628
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E8F1891EFB
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AFD229B0F;
	Mon,  7 Apr 2025 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFmrq6Pq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769701A23B0;
	Mon,  7 Apr 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011059; cv=none; b=eb/gJI7lkJLFPBPDr04cnkk13KBZovLzI9xb28UtYyNcBtQnSy7PuIyIfrPQh8aaOQoIeI65yMngG4AT+kbQhgmSxTBJqGshJSLC0q7NQQQf6LH36xUFxSkXbVi0snNnSxAsXTins1nHOKEVU5FejEzgBWkS1sqYSR3VoNe/iio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011059; c=relaxed/simple;
	bh=s1C/uB/imEJ2jPfVYjph52XrHhRjVbQgv0oywjeaPzc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WH4v5SUwy5h+QvYqMlAaOxAaqCb6dxeswn5lgW8fDB/BpZiXSz/gAnarujOC/TEvbBNUWclYi2qjc8hZTwqLNoZFGyWMG6rPoqPLLn8HZb04HXHaqkG2qIiepBy3RaecFgPkkYK0W88OeXAJS62vYYy20xl960j4rCsG3HqrTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFmrq6Pq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so52687471fa.1;
        Mon, 07 Apr 2025 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744011055; x=1744615855; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clTcm2By8sht0apfSlqORw6MuX9pSKCaD9NP9i7hUL8=;
        b=QFmrq6PqLbfrFUBMQMRXGvg0zyRQ3W5CqbZA3JPzuAkBv70z1OM1yG7gtbRgvgNsO2
         CvjlAd2Dh3IEtbL1u8yVWQgwq1HntrvV462YTdHFa2Tn4I5qKPl0SIhCqsI6VHtg9FpQ
         R2lVFMbJdyB3jpiz7xApX0ug7+r+OsTbyeRCfXu5mNi6KyRqy7S+VaO45C6HSmapv1a+
         HV0kI9V/yFr8GZ69D49QAtTnouJjFD364LcNhbE64BmcW6Gqj0tsGKvibqHWDcSBs0h/
         tH/6yzsGWW9TOgE4pINn8gVieRK7YP8ha4W/u9pTeVo8gpzHhMahmE5AYU6CfS9DdUKn
         vddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744011055; x=1744615855;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clTcm2By8sht0apfSlqORw6MuX9pSKCaD9NP9i7hUL8=;
        b=V+ts0YKmGKy3lSG/bzObZVZ0fRe5u8xE+JcCnMZld0DAmA2815HLZOmTdfRwEA6w2v
         rvgnkbO/I+MkXfTMxWZqUhv/yZo50nYOWJ4X9NH60VtQEOBRF8D8TYUiNRRpDelicQ4U
         7+bmoTuYAboAPx7TRFY0BIvBtWsS1lZeVopM6UCdFp4tKrDGjYPl0uOEJZYCqxwryLY1
         uuuCGJmDJnayuSyAjstL6leZMnx3VTTSLzFbk6wDUoRoWKYE8qAkIXoRd+4UfXJw/2ji
         BmV81Xe4lbPJp5XMnxtDAfteeCy+Wqn8V/50966sS4TpEtLnD129y2bhic3tqfLrvbhf
         7VTg==
X-Forwarded-Encrypted: i=1; AJvYcCV88nFHC2xQMSDAEOE0aMXggkROFZQeJCX+nluefpLEsngsuG1z/+JD+OFjUM1apZP3CiILLdLE0BMOQUiy@vger.kernel.org, AJvYcCWfTkQtO4SzOu5MaCLIX0jrG6A9RCg4Pr+FlGZrBKnjcHltDemN6ihB/QAH7dsC5NA5L0qp1f6gk1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0FyS5lKI7OH3M3AWZuVrjQTWMHHjvJwAj/T1utTQWsBgXnSL
	594Fh3+qpvnUNiI/wPJMuQWruizjGoSYymP5MhYGoPUM3FFzj/JI
X-Gm-Gg: ASbGncuL+W7D/+tZEHhDQ/0BRue4EBmqV6rJbZYQGqdTV+lSEL6IRZ1+dzPlEoFARe7
	9uuyawxNps/t3sW4AYdfdduV6vBEzSPaDDjMVaZ8iy7XutJiXPeKC7pvpqFknuHyU0G8lTZpksA
	+cF9upKe0JP3e71aFQHQqnO+byPh8pJJm6gwDT+Vsv68+sfhNsLWb2EPg3MFNuF8pJ82WubJOCn
	/UstuqUruoD6k8MHK0tRQgKl1IqEFOPWrZ54jNEUCDVxtZPPH6e9D9kPX9cSJELk9fKSvY5ufPm
	XLTJtXqa7bfAoSuSJYkaDtRv1GbUZRMi04UqVPwGUsJ96MxYQjjV8OOOfmJx/Q==
X-Google-Smtp-Source: AGHT+IEM3aTsP/5N9kPBJapIvwVUcRHJzmjjoanH+9ead7Knc5q/F15ef5LMrwvlGX5NAQ6lpuresg==
X-Received: by 2002:a2e:bd02:0:b0:30b:f0da:3ae7 with SMTP id 38308e7fff4ca-30f0a70e09dmr32749071fa.14.1744011055304;
        Mon, 07 Apr 2025 00:30:55 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0314b343sm14943791fa.49.2025.04.07.00.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:30:54 -0700 (PDT)
Date: Mon, 7 Apr 2025 10:30:47 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: bd79124: Use set_rv and set_multiple_rv
Message-ID: <Z_N_J52IZ2IaWawl@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WiRUV7c9FT6YZaSm"
Content-Disposition: inline


--WiRUV7c9FT6YZaSm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new GPIO callbacks 'set_rv' and 'set_multiple_rv' allow returning a
success code to indicate failures when setting GPIO status. Use them to
allow callers to know when things go south.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/rohm-bd79124.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index 13673f4347d4..bb7c93ae4055 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -196,17 +196,18 @@ static int bd79124gpo_direction_get(struct gpio_chip =
*gc, unsigned int offset)
 	return GPIO_LINE_DIRECTION_OUT;
 }
=20
-static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int =
value)
+static int bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int v=
alue)
 {
 	struct bd79124_data *data =3D gpiochip_get_data(gc);
=20
-	regmap_assign_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset), value);
+	return regmap_assign_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset),
+				  value);
 }
=20
-static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *m=
ask,
+static int bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *ma=
sk,
 				    unsigned long *bits)
 {
-	unsigned int all_gpos, set_gpos;
+	unsigned int all_gpos;
 	int ret;
 	struct bd79124_data *data =3D gpiochip_get_data(gc);
=20
@@ -219,17 +220,15 @@ static void bd79124gpo_set_multiple(struct gpio_chip =
*gc, unsigned long *mask,
 	 */
 	ret =3D regmap_read(data->map, BD79124_REG_PINCFG, &all_gpos);
 	if (ret)
-		return;
+		return ret;
=20
 	if (all_gpos ^ *mask) {
 		dev_dbg(data->dev, "Invalid mux config. Can't set value.\n");
-		/* Do not set value for pins configured as ADC inputs */
-		set_gpos =3D *mask & all_gpos;
-	} else {
-		set_gpos =3D *mask;
+
+		return -EINVAL;
 	}
=20
-	regmap_update_bits(data->map, BD79124_REG_GPO_VAL, set_gpos, *bits);
+	return regmap_update_bits(data->map, BD79124_REG_GPO_VAL, *mask, *bits);
 }
=20
 static int bd79124_init_valid_mask(struct gpio_chip *gc,
@@ -247,8 +246,8 @@ static int bd79124_init_valid_mask(struct gpio_chip *gc,
 static const struct gpio_chip bd79124gpo_chip =3D {
 	.label			=3D "bd79124-gpo",
 	.get_direction		=3D bd79124gpo_direction_get,
-	.set			=3D bd79124gpo_set,
-	.set_multiple		=3D bd79124gpo_set_multiple,
+	.set_rv			=3D bd79124gpo_set,
+	.set_multiple_rv	=3D bd79124gpo_set_multiple,
 	.init_valid_mask	=3D bd79124_init_valid_mask,
 	.can_sleep		=3D true,
 	.ngpio			=3D 8,

base-commit: e3ee177e2a3e21ef4502f68336023154049d2acd
--=20
2.49.0


--WiRUV7c9FT6YZaSm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfzfyQACgkQeFA3/03a
ocUFlwgAo+Lo08XziQm2EZru6mEOwYFAofIyUGzYtrDUrN2XwQiHtg+AtiPL/KjI
pjP034GkRBeowVOGSTK2A9Tw9hxeGgKc5L4o5OD2zsOn7CW0Pi60ywGlk0FvFb7C
UNJCTq/Sr8YXTzUdCZzMB3JQcs8osYd+ktb2hTJx0eAPouF0eNYge0o4WTDN//ie
vd5oN9KBtahFP6lsjmd55C+b30VyZrxuXCZkqrRU/mgfU1BCkiSh6ey4PqNPpymJ
OLeI46yyQjfNzsJ/VcrUEnQSlg8Kd0rwBma1WVckNZyGb3e6GDL+uZATfmjmOpoH
KhmJnJRM9Vfti3tF9f4uuFSaK/Ezlg==
=8gQl
-----END PGP SIGNATURE-----

--WiRUV7c9FT6YZaSm--

