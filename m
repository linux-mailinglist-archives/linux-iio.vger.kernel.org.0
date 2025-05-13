Return-Path: <linux-iio+bounces-19479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E23AB4E0F
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 10:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B35E7A6885
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 08:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115302046BA;
	Tue, 13 May 2025 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXWQreCl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319DE1CA84;
	Tue, 13 May 2025 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124782; cv=none; b=lJogQGttO6sqpGhzymRQ5ocF5h2M5w0y2L7RZIbYq1fL6StlKztuU7UvBNG5QCPjcu11iR+PbfROCnELTbQi4TuBEsGUsjkt5DMZ6C1hUwOVIxhwZUIkcQAbopWxUPLM3dPm3B9izOxzt8u269ByJVqwWtxCaxMiqLzC8hw/9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124782; c=relaxed/simple;
	bh=p5ck9nG5COzJJv2nYJgnMqJhd85ryDBipKxnhhFdCAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ICrNjwLbIfgQVrikUOrUQaWNQ7/iSudPY5uhKwK52j+XvuHXcsluu8++u9yssI1vZeNIbyvH/mF+2duLyYSwMZUvxb6DYd1bLjSzaNek3tVlT/a5JKT9srDwVB1IS7YVfX0wvIvaOaYlutnOshXCpH7t5TVJSIrHMfTND/ra/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXWQreCl; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-31062172698so58814711fa.0;
        Tue, 13 May 2025 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747124776; x=1747729576; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rg/1cq8+S7+w0LZ7f+b9UfTBqTcXKSto3s0U5JqUxVE=;
        b=VXWQreClk9Fw1QlqVrg1GSeKKo8haJQxoAX2wxv5hxOhXzHE0dcukbNUDokXNMhpPC
         2HdZqYqBZhAry6svvgxpD9+4bMTgtftJUT6P3JzVQqe6D5n8otvdBt4UDsPFTgrGDsAV
         2zIxEWM0NdQWZIQUaDsB+bSVu17YHeScqZ65rIUaIisZbPrVaqhihPKJ4hA0UIq5eL59
         xZhlbAsDohO7Iq5WxMtPZFPV8YPDtvzFcuCEzVmw2h4VFmeDzyCOYCqRxg9EJUnwZIw5
         +Jl+KXHLqm5lh0dUfwU7LQPyV+m0724qKhNkWTs/W9vjFxYAQI7pVOZHL3AMIjzRbXzp
         UjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747124776; x=1747729576;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg/1cq8+S7+w0LZ7f+b9UfTBqTcXKSto3s0U5JqUxVE=;
        b=qhwAqEbulv8IdGiwQlMx5GMOmhhzZmJJUEzoQrTB/f25MgJwz/wdVWFd8j55Zy9yDO
         C4LgZWigJUDVPht1MGxryqo4QrWxhvU76zHrNnvHYxBJk8aIhScvFn5X8KPy1uoAcccw
         JSsiIAGKIYHny6v/hd0auWzUxWgcpYXbSPavJCb9NANavzwXI5cZuuTMO36c6WDGxRS9
         rGA+PDcap+fO/gdd8hz6dvXWrpzLHFt02peu5WZUDKJMUlw88WJC3ZwGGumrBGA46f0h
         334mvZ/6raKstJoeACZyNXAGmkUnSg6IhDr4dFb20TcweB0EHsHzowVSeWFJ1plMCt1+
         bQww==
X-Forwarded-Encrypted: i=1; AJvYcCVcajM1+82kE1CpVE6gmw16nXo7X4vqhLpjWtDiOfUWmugv42O/i6JwHGgvJmEjFF0RYO5ccqo4h5GV@vger.kernel.org, AJvYcCVxQwKhxsru1dMyapF361RQ3sZSazI6Bf4qEh7iYqdwj0sbcRwRM3RXIu//l1USZk/CUmqxxSyEUdAy@vger.kernel.org, AJvYcCXfaVg3eLXnOAMjpv/+j4I7087VTymVidapjhZo5yXDsFE455Xlqo733eVj61h/EvO4F1DC4N+eYejXtYmV@vger.kernel.org
X-Gm-Message-State: AOJu0YzT2bP0fE7UMarUbEaBOutcGTx3YENOg4FVN11Bj1h+Ezm89ndG
	zBZp0YwGHFM7adegrGg4DVYRz/pEF19VDuV1GcuzexbnMN5KwbhD
X-Gm-Gg: ASbGncuXvcJ+G4ZNfNbczOnuDxt4zFWVO7WGaLVHEwmg9Pw5gz9eMRry4ZrMLeRJd+h
	It7pvMtv27MbbMBTqr4D8fy65CQveC5neZlHp9tg7CRhyQLmGMqmMTjA5b+Pv047NSigfr1dwnW
	GZUP8KzBQvrSH9TGzW2Gqzvxe17O5A631oy+2tKMm5EBfwToQ4gTiBZdEh+fAN/idiPVlWafJd1
	e+32df4BJsgkPD/CjuVodOnmF++i+jbonsgjvuRp3sAH5ku5yibrqOiU8kke/OZjsH2b6hG51pQ
	vaaMxAgpdg2747HXl4DsGJ80lvBX2C/Htjhc+ngwoqTE9XFsp4XxR48ONg==
X-Google-Smtp-Source: AGHT+IHTImCBULxY06nF8EuF3418B8lbffZA1UHyoq5YhOo6ENt4lFUaKjr2Vt0u/VDw5Axd1lzu0g==
X-Received: by 2002:a2e:bc07:0:b0:30b:f775:bae0 with SMTP id 38308e7fff4ca-326c468a5bbmr67848341fa.36.1747124775811;
        Tue, 13 May 2025 01:26:15 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-326c321f2d7sm15975151fa.0.2025.05.13.01.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 01:26:14 -0700 (PDT)
Date: Tue, 13 May 2025 11:26:06 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Support ROHM BU79100G ADC
Message-ID: <cover.1747123883.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zoqxGlgN8VRwJAJP"
Content-Disposition: inline


--zoqxGlgN8VRwJAJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for the ROHM BU79100G ADC.

The BU79100G is a simple 12-bit, 1 channel ADC which can be read using
SPI. The BU79100G does not have MOSI pin, and has only VCC supply pin
which does also work as a Vref.

Series was based on v6.15-rc1. I can rebase if needed.

Matti Vaittinen (2):
  dt-bindings: iio: adc: Add ROHM BD79100G
  iio: adc: ad7476: Support ROHM BU79100G

 Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml | 2 ++
 drivers/iio/adc/ad7476.c                                  | 8 ++++++++
 2 files changed, 10 insertions(+)


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
--=20
2.49.0


--zoqxGlgN8VRwJAJP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmgjAh4ACgkQeFA3/03a
ocV7rAgAilK0YwO89eNJudw0GIGodJ1vowTf5yb84ap/9gNyTAKi62teM1NZSF+4
aZ0SgHRLXn3Nc12+oTtBfDQC5714wJvlqGa4jKWyvIfiHF3NlIYDniumE0RokZXp
FwZ8IMNyC/q7YGAAA8vrKjtCZr6Hs+rL3mIHtZNUzAjiIS7rRlAbEzZQQrPqFoju
EWLtk2pXdm+hEkHxpDSF+kb4JyfdYNbkvrIAs3VM1MQsVYQ6HB0d94rQ//k+sFys
J29ogjJVHhEWfpexpzJzPFFeuhdLXhyZO2kuYCM6JfRVq6oX5SJdE38ybn700mlH
f3SH5YV09DZzl5sJilrG5gmDTuol3Q==
=6l8o
-----END PGP SIGNATURE-----

--zoqxGlgN8VRwJAJP--

