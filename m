Return-Path: <linux-iio+bounces-6398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D8390B4F7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D3B1C21607
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CDF15884E;
	Mon, 17 Jun 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dcK0I0CZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170141586D2
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637454; cv=none; b=EXbFQg7PWOKrNeneKk0rZAfYhkeZ9TpuK6plv2XjdVIihxOaQAarmxlpVgDLmqQpvTeQWtB0KP345hGuc8YyZOlbZd9EEcz8k386/rcDVetpKGhhBZlSuw4SWp+7uBih9ZO0xMmhtyPwnT3A8Viv/6QbqsySUlBorQMUeRxtayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637454; c=relaxed/simple;
	bh=UCKYxTY+hYqCS9ZAIJQjiDX370B780I/Z6F9FjI6Lso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiVPQ0u4HAwxcRhRP5yM4voH4Sh/0iDmsZIo0I0PVdW8dVGIFnLNoIEfymwq/V3jq27iHf2h2jqE1amnGSfj6ME85KzuMTEUY06NoWq1udoAUxxGGzdd8m0TtFI2N0OXSBkywpN+FuGJbPY6mEk1L/Gopvl29FmyHQBD5AZnyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dcK0I0CZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f176c5c10so531591366b.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 08:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718637449; x=1719242249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCKYxTY+hYqCS9ZAIJQjiDX370B780I/Z6F9FjI6Lso=;
        b=dcK0I0CZtfdmCZXI0cw6/mRKXvpM/B1GfIVhNlqCvQnfS60mpVgg78ic+vZJ2b5DXA
         SDtmmlNBoaiztBElbX457nLLy629I8VaUO2oPw7oGEJCFucO34W2UePCybkn5v+EUmoz
         KVn3YJ85xddTB7sfwGDAJ4CwSsYHorAnjXK+mQ4LBgZ+Ww5Fjfc/fwi8PPf/L1/aPu9P
         hoR5voeXNMCYqnLPiiJwjbc6rJ1M9wfRRgOmVmQCGuy2TU9d8vJ7xcwQo7hO+K5SQCcc
         Bl7aSGMM4r+Io/HTlCYPlTA0jWl54nX9b2eIFGd9yzqKpr8XM7Ruxy2my7YsD1HSD1G/
         SU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718637449; x=1719242249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCKYxTY+hYqCS9ZAIJQjiDX370B780I/Z6F9FjI6Lso=;
        b=oB7U1bd3CYbcC9t6w75H4eVE21u88mOMKXrK3jD7UH47vvSaorZuueDC8rarbIZ1CI
         RXwbQc/8+uqX37pIdRz31NzGRbLhaYkw7g0OgUmolgI/NVz2qO+GJl+zXeV+3BjZa2lg
         UG4UPaD31iJd1XS88BAo/ClKNHST18HoL87X0k7j1dm9K0rQ31h5pYxS3oEyI7+QaAzT
         ukIw40/S+lsfat1LTQY8dhaYEew/96cu/AazcKNdUJszJrTiGnirf1l3fkel3zmWf9O+
         wmysAVLTLkloUkpdgGp/s09vOdEDcdxpBAqSw8zv+ooBws5y1wv2/qRoONKZEv2dxJ1I
         ilOg==
X-Forwarded-Encrypted: i=1; AJvYcCXMciN8xxZVIHAUzY4StRHFaPNW/skOodi05F0hpTc60CiVF79qsKVfpUH8bCgfnxJl+Ksc8B0hWNPy06UInNKsF4W/oCOGNk5a
X-Gm-Message-State: AOJu0Yza3eN33alkrg9JLJRlGMtyriLR+dVpSTkgjvqiSUbf/krjLQDr
	9SqjaHvWECCyQow8Pnuv8o8u/Go/6lOr/YmYK8dWtfaFq/VIcJr3pT3+i9kNdbg=
X-Google-Smtp-Source: AGHT+IEfTN+X5wOiZi0KL9fkXm0O9x/sBCnZG/iMDNlNOfN7WVeTQ5Ne7iOJRddWGtoR5MmcoXn6Lw==
X-Received: by 2002:a17:907:c713:b0:a6f:61c7:dead with SMTP id a640c23a62f3a-a6f61c7df96mr914573566b.17.1718637449366;
        Mon, 17 Jun 2024 08:17:29 -0700 (PDT)
Received: from localhost (p200300f65f283b00ca876ee5dd3d1e3b.dip0.t-ipconnect.de. [2003:f6:5f28:3b00:ca87:6ee5:dd3d:1e3b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f5b5ce0c2sm495737066b.78.2024.06.17.08.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 08:17:28 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:17:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Saravanan Sekar <sravanhome@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
	Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 00/41] iio: simplify with regmap_set_bits(),
 regmap_clear_bits()
Message-ID: <mv3deevgf3pp6ojy3pa4zgc5z74ajroe26sayhzvrbua2dqrdu@enqs7sobbew5>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="maebxxheapnwdayn"
Content-Disposition: inline
In-Reply-To: <20240617-review-v3-0-88d1338c4cca@baylibre.com>


--maebxxheapnwdayn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trevor,

On Mon, Jun 17, 2024 at 09:49:40AM -0400, Trevor Gamblin wrote:
> Simplify the way regmap is accessed in iio drivers.
>=20
> Instead of using regmap_update_bits() and passing the mask twice, use
> regmap_set_bits().
>=20
> Instead of using regmap_update_bits() and passing val =3D 0, use
> regmap_clear_bits().
>=20
> The series is marked as v3, but the previous two revisions were single
> patches. There was also a resend of v1 due to not properly CCing the
> mailing lists on the first attempt. Trailers were pulled in from those
> where relevant.
>=20
> Link to v2: https://lore.kernel.org/linux-iio/20240613133927.3851344-1-tg=
amblin@baylibre.com/
> Link to v1: https://lore.kernel.org/linux-iio/20240611165214.4091591-1-tg=
amblin@baylibre.com/
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Thanks
Uwe

--maebxxheapnwdayn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZwU4QACgkQj4D7WH0S
/k4UIQf+Ka6492ojVYOyOplTmwplQhYA0abavRbL4tWlzPswAQ/4yjahD+9XRbA2
m9DionXY1IXXlR3kZm2ZtPy3dXdG4QKH1gi7xcnMOjtmgb2jDay7mvbN0DNuIjV2
vciMh7NpnYac3uUovbis7d++of8lbibdzWQbtV1IIy551MJApXs2uHORUt2JMYmx
hEzyLG/q47FnN9Anbw1rS+5UsSm8zYjmMgkJ+w6jrtgCJHyMgTXZ3JnqR3G5gVjI
qOKcvDY9KrrMRn+cptE5IcGMviWhQofAJeJtKOuGmW0PlFPOd/3/zdTh0z5EzhbM
/nLUad8Wwavl+W4yf56zOmRZNUqc+w==
=pdCb
-----END PGP SIGNATURE-----

--maebxxheapnwdayn--

