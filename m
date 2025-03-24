Return-Path: <linux-iio+bounces-17223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE1FA6D4CC
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 08:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8740016E15C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 07:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763B2512E1;
	Mon, 24 Mar 2025 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+VzRx7n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FA2505B8;
	Mon, 24 Mar 2025 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800446; cv=none; b=OIAThJjlp++wK05igh50FIJefOu4REJ/dbnSHxd65ZUkim4s2S8WUJcrds8gaREIo41EH3JrufEHXBdgkYWA7XO74n3XPddrc1zW25v3uxKftom3uXUW7Dhe/FNYhsj9Nxlj0l8Zd57OjVkH5vArTr6NsV3ilUQ8uMOB9MQ7mb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800446; c=relaxed/simple;
	bh=03F0ih1tk5WKssRMk6SjUSW/lpf6r8D8f+sSTU3X1SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7irCbWmm7yhR1+F74nXrcbDdd8fambuM23B/lZ3ZCNsUnPcM/qsNvfy8AePpvmVVOPAUro0W25BdRMAh0Q6f1+9Hraw3Vjv5qkcb157o1hv0ZjXBDZo/0gPDpAh+BHcsY6FDN8gptJ64SfiRFV4ERMbI4y6lg9FkKKII6QbCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+VzRx7n; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so4692025e87.3;
        Mon, 24 Mar 2025 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742800443; x=1743405243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5zlbJSpWOHIuaaWvEqgFmQJc2MPl83PxDlEmoP1fD0=;
        b=k+VzRx7nxMc+4PgPG/hHk9yiCFJVYXqn6Bx+MCMgX9BFGlEhDVXj20BYSGOXlx/ZFU
         Kwo+aa/w9kX4jgdRQnJjkaTVKQ+iGh7WHIpLB7922PmZ5OVIyXNanSgQRuend4f9Frwf
         +1/clJ816XIfjx9EGQlze/igpETNm9fWzY0kcFPHQMBo5DekBBoLi4ZGe9ltDujiWLC+
         qDKdFHwRgfowEDtJb6mOFYDs4jP/rnvX6FbWI4feHsdvry+eVJJ4dKyHhdN6vqhfXplL
         7qyg6uBsODqgYqySAYu12IO9AUs5fz9E3ftiUwxtU/vdCj/KGBfiK4g4RpynrUvlDRyh
         SrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800443; x=1743405243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5zlbJSpWOHIuaaWvEqgFmQJc2MPl83PxDlEmoP1fD0=;
        b=f9hcHGONWRchBkB0bOArCXiSNTpJBZl2UhQp9fFEN4lVv1TCg/j0bdytMV3iUAtdsT
         Nmn1eD/GmR3CKlF3PT+xJwYOSUB6y/xb/tQm2EDcqjt4TJSo5xaxAASyO/hv6d+nedCz
         cyfqC0F2WkVF8LNKYaV5NnUuzg3nDlQcYKOe8ieSChpZuMi+hhR+5OStn/I4RRFIL7MA
         hgeO5K6YehvWTNM2K1fGmSqYqsR7ZvN1HVAINe0oSsP2cFEff7UudOk/hs3G5X0T2q/k
         IMu4dSHhlZVKIFkzTHrErskvgEociWlH9zhwW/sS5WOYBSkdmbKndtW94nSNPH/3Os4X
         6bKA==
X-Forwarded-Encrypted: i=1; AJvYcCUYj0DWgWN0oAvYmrRVZ1sHqE/HTvb7jpydUH9EPF36NPSvHDFdq5BE03FRsB3/xWxswNcjIEK4/C/ZIl1+5We6+cY=@vger.kernel.org, AJvYcCUqXW+z/tRl71fpZJgC1RkJk8UGQERhOXhtRK4aljrY1V2id3lAvEKnXv5B45Ok9a9q6JDnCCPBiCn+aoRn@vger.kernel.org, AJvYcCWpwVqpv/xtDLMTcJZJZIiz8w8ti/mOtAEkNoGLzX52G+nb0xPViCi2/SGJ5/jMJbashvEle9Pvr4li1w==@vger.kernel.org, AJvYcCWqA+m7wav6dKuhZJDXH70Em6YTOazrBr4lZtx6O8RPTU3LaaGDASYw+7l0zB13uWhITTmKDmclUZOm@vger.kernel.org, AJvYcCXLFNRwfkufXMDXTT+z2QtwT65SPofe1OulqlNf/Hj2Gsci9SOuNQwv/dwgLer2vS8FOpHGFcd3+zYn@vger.kernel.org
X-Gm-Message-State: AOJu0YwScaWeCoetiWT3ZMpj8bv25hPKZDpsXqKxrVvZYr+d5jh5+uaL
	iZJWDZs2PprqpmoEE34TC30O0kIQqJIK2Ik+UdoPC7XtFxS1zo86
X-Gm-Gg: ASbGncvKwLlBoKFb5rg0PVvSiSbVYJ9YXU3wXnwJujNfo0F07YoVcsT3TV/wZeowGel
	6eG/C05MMAqwsEjKJqBCU6nb9A8a4NieidgS9Dk5IShzftcYIeMmUSotDBHki985QcVmvyZpVqz
	gnMsuo8MGbaSVxbS3z/NUyZNFhbbUVgti6JzI7Ee0GBzQHiQS/TU2GxTee9OagEzE5HQfaZLs/w
	erFd8n9JE8DELDLq0eKCnYmOlrKYAfOnmCIgzMRYsVPIVKTNkRxWN/krnqgU2/rxzBGApj2Sz/Q
	BsmIuyP0DLku3fzCXwaWlxohd7ub8AiSHYDVb62RO/Klbfw9jJM=
X-Google-Smtp-Source: AGHT+IE0hw/y0ZYh+MtPyuslvaGnvl9GM9JaduCS84yGygiOiK+LICzgtUkhqkQ6zjlppVQT0t4I/Q==
X-Received: by 2002:a05:6512:3a8f:b0:549:8f06:8239 with SMTP id 2adb3069b0e04-54ad6509abfmr3719359e87.51.1742800442609;
        Mon, 24 Mar 2025 00:14:02 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad65081a1sm1027115e87.163.2025.03.24.00.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:14:00 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:13:56 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v10 7/8] MAINTAINERS: Add IIO ADC helpers
Message-ID: <1263c954cfb74223f322a9c31bd57f13d5516680.1742560649.git.mazziesaccount@gmail.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ewp2VBF8ttFnYinD"
Content-Disposition: inline
In-Reply-To: <cover.1742560649.git.mazziesaccount@gmail.com>


--Ewp2VBF8ttFnYinD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the IIO ADC helpers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v2 =3D>
 - No changes
RFC v1 =3D> v2:
 - New patch
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..5b96fb864227 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11208,6 +11208,13 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/iguanair.c
=20
+IIO ADC HELPERS
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/adc/industrialio-adc.c
+F:	include/linux/iio/adc-helpers.h
+
 IIO BACKEND FRAMEWORK
 M:	Nuno Sa <nuno.sa@analog.com>
 R:	Olivier Moysan <olivier.moysan@foss.st.com>
--=20
2.49.0


--Ewp2VBF8ttFnYinD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhBjQACgkQeFA3/03a
ocXCSwgAxVnQyxRhTT58mImS7G6uU/aFQDiXlM08CUZ9gObNjgFta9MMnPovZwHU
Nr4fO3MvZD4foJ6OMB0MVKDZlTX6KOg+K2o/delnE1l+tH9PCcPnTSm8Fc5H83Oz
QwMNIhQbwKN06KMJsRyVW5iNLPIwil2Uf/3+Q4J7CNbglnrlXsocA00rke/9BFRE
K2Y5r3WxJapmyacQHa0xauNlv9kPViNh9Vy0VF2io+oy8d9hNMzfQpGM32xoqmC2
+UTIlAzEplINymAM/399yLCxCT6t2lH13ZrjeTiKsc38DvXHyz3pE6K/xX38RE+G
I+1fM4p0O/8GpMnKLKGyWhk0IyfBTQ==
=vwYn
-----END PGP SIGNATURE-----

--Ewp2VBF8ttFnYinD--

