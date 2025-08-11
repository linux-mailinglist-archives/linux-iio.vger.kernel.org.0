Return-Path: <linux-iio+bounces-22547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF535B20247
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B29B4217E6
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE6E2DCC06;
	Mon, 11 Aug 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+QE087y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092442DAFC1;
	Mon, 11 Aug 2025 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902285; cv=none; b=QhgMIui4t7nfszjBTVvbmpuu4asmGumaI9yU+jlwG7+dVSQf8lfV6ZltEcIn+CSYpStcdLHEAUkHpSa1H8UmmZ9lvq+rrJBlEQgchkwAUtO9cVelBmxzjXtyOwlQT7vNMrtpTlHfDm12INkIdBzOtHr2RYtYJDTWYvFP88qrrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902285; c=relaxed/simple;
	bh=afe9bpX8W8H91FhOIAgKBIU3yH+6Fqgb4N96dBYzmkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtMWOydTSFh9OL5TSzsP2UdRk7m+mdi8MfsEZE7JCAIj2HAIHnnV2ePuJfu+iO8WqEo6lYqOjkovYstbQN/lzD17W2DqdiSwN+CJahXKobFECWBl/zBVvAnDSzaoUJM1mMogGlTdZMIb4/VMKId5UcoITXPGVPsTOv6UnLcSmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+QE087y; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b96b154bdso3812257e87.0;
        Mon, 11 Aug 2025 01:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902282; x=1755507082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfzDrXGi0CIlX0hOszfZwg+v1cWRJDc8hdky73MVyLY=;
        b=H+QE087yR5oXh3wHNV0uo2cCNNv5/DTDWbR1x2OsS784zU684fZ5sFpChC1qM4cdcy
         dFNFc17lX0uaBCfKdsHUC+tctVfkZKQQwwEegPdgAeAskCPVrSF8M8JN7wWDk+EBYIQ1
         ECitNu92tjlKNHOXVXHOd7KV6BCyxNdx2m9PTD2x6Old+CA9FdWQZ4VZdkeo9R/PRQzy
         OQ2B09TIJIuBXet4dbqGraQyWwKjk9vnmNUKk7jb4N1r89mwj09o8Dvsdehxk3a/OhqP
         dfGxZYChaDQyY6xt5YLs2w/4wOF6dwfufQ17n2yY1ZSn76n/lM4sbZnhLsIDQdvlWIzI
         N7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902282; x=1755507082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfzDrXGi0CIlX0hOszfZwg+v1cWRJDc8hdky73MVyLY=;
        b=txsExN2X1zZIzECxTlEsNnA7mGouHPi88bwcjeZaLHcH5lZh8ACaCdpuq5h6rf9vTQ
         6yrN5lpvmBYB9M0vV729QXpsd9GMl5D23i1OiL8Xvme22Jool3/1tovaVEDPtC59TxLo
         9seCETMTC8Xd12YPaEOfgCZnayC5XNV0Q12XnEU05xbmvUuDSwJigZC6nGhzat74Sa5v
         /Gjs8nejx3IfPc8D9LlmXey+bC5j30QE5kP5s9VEWFlY8aYy8nkK5VRHXGfCBhyawzCj
         o+j6MOuZe+UlnfLUSiQrpNLU1iqJPOWNgNQ5ThY8R+k53IhvTj8zzBHspSZnNXOeXl9l
         ++Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVTDHIE//lWGRLpO6OhH2C2dybJjvXGVmjpCZuzT9X3L4ZwaqTbVFTuwcLF9oNkfWDRXx2te6qcw5eP@vger.kernel.org, AJvYcCX43uj6kqKrwEREpZCLAVCkfhmEpKfWVOpo6HCxdVc6bO0Ah+e2xHTCKTQfwVx94o+IiPkMskzr7qooO6w/@vger.kernel.org, AJvYcCXKGSw+xKGQYUpdputXF65rjXxCyDvYgZlbqafYSb/HH1WLqVEv/oFPS0vYRBCYui1ALxW0ixcTgN45@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs+dApNS2t++1yHr0w77jzX9GLLzqcTuIuufWUS/eZpEqi/PyS
	FqmJNZFf6igerj05eBSeWNYxmXzj7O3yV4vOPDNZ06WkVbwijFLHMLTa
X-Gm-Gg: ASbGnctOJ4hCwSuQ6K7WuyFsI/LhhND0IsiNEmkc/VVN1G4AbIEqW+CwX7aHsyvwYjk
	RTsxAg7X75JHLkraAfEAWx6hdpkTwOJGINZEh5GlqZGfI7ZtIKVX4cmsPZv/6PlOtgWVgTuaT2f
	rQ+qPJCCBUMPxvTyCMIjlvE01whizdFdUUVhzdxLCKPuRwzgUaReFJLe3SxnYYY5uQLVwwrvWLJ
	GxE1xXDlr5tSJllOQsp6py6b7M0L/tJUMgNchU4hXBr4e3wsfdYVQiNoh6P9D03Tmzbb2bltE1u
	XnN7/23iFvAXGBmnrd9yTp7DGOTen7F1UPhZi/bUKEGRkywgvXzPj5UBnA3p4AR6DWEiquYarae
	rXTrPvuadr3OwF+WsJkqCTMDPvcHv
X-Google-Smtp-Source: AGHT+IGiU85cj7lhp+oQ5WTJ9D+AEwNpFCUaOlkKTPl4QU7aWPLEjStbJ4tBt87sG1S6bDM8oG+U3Q==
X-Received: by 2002:a05:6512:3a85:b0:55b:574c:6c01 with SMTP id 2adb3069b0e04-55cc0123d25mr2753958e87.29.1754902281995;
        Mon, 11 Aug 2025 01:51:21 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88caf6dcsm4230172e87.159.2025.08.11.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:51:21 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:51:17 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/11] iio: adc: ad7476: use *_cansleep GPIO APIs
Message-ID: <a2d4b77e9739662797a1609f436b7f9807e1ac67.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Akev5Rr95kwSAiEp"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--Akev5Rr95kwSAiEp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 driver supports ADCs which require a GPIO pin to be used to
start conversion. The GPIO line status seems to be always toggled from
a process context, either from the user-initiated "raw-read conversion",
or from a threaded IRQ handler. Furthermore, these ICs are connected via
SPI bus, which is usually implemented in a way that the access to the
device can sleep. The GPIO here is toggled from the same context which
is reading the results over SPI.

Thus it seems very likely these GPIOs are toggled from a context which
can sleep.

Swap the gpiod_set_value() to gpiod_set_value_cansleep() accordinlgy.

Suggested-by: Nuno S=E1 <noname.nuno@gmail.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>

---
Revision history:
 v3 =3D> :
 - No changes

 v2 =3D> v3:
 - New patch
---
 drivers/iio/adc/ad7476.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index fc701267358e..1445f0f599d9 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -57,9 +57,9 @@ static void ad7091_convst(struct ad7476_state *st)
 	if (!st->convst_gpio)
 		return;
=20
-	gpiod_set_value(st->convst_gpio, 0);
+	gpiod_set_value_cansleep(st->convst_gpio, 0);
 	udelay(1); /* CONVST pulse width: 10 ns min */
-	gpiod_set_value(st->convst_gpio, 1);
+	gpiod_set_value_cansleep(st->convst_gpio, 1);
 	udelay(1); /* Conversion time: 650 ns max */
 }
=20
--=20
2.50.1


--Akev5Rr95kwSAiEp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZrwUACgkQeFA3/03a
ocUnXAf/RDW+pnIiD2FSS2EPB5fx9n6LRgIg/WSFrxtg3yZcT+nCyRPSBjbZ5fwL
HFUWsHOAV4bkrm888rs0/3gBwlhTjAcx9CS0+6hRckbgtvG/i7Z4EsA05K7Kr4Uc
yDc3Eo7ax4qF2rvBiidmS8gK+DjQ6MiG5iqAH8pdzUOkrkydzpiCaLlfxwzjHgXv
6AyOxNfzwgxiwpNayAGVjqSKvX8u3ZNCC+P/HQpWwWGGqoLh7FkQnotHJibvUkGP
ThdfsaXwGD1r8F877lh2GlI4obWHk2Vyj5pbRrNeVBZs4shbd+MOvdmG+/w8XcI/
5u4p/XAdcTrlTgH9CY3XVKsqm3tNdA==
=vEfI
-----END PGP SIGNATURE-----

--Akev5Rr95kwSAiEp--

