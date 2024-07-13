Return-Path: <linux-iio+bounces-7576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A189303CA
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 07:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132481F21E2B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 05:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7C1AAD7;
	Sat, 13 Jul 2024 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk3PrVrc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DD4C8E;
	Sat, 13 Jul 2024 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720849695; cv=none; b=BDvSXWhLOEK7EYRim0rvGsOzyJA6Nll6LhQcHtaq21oemB1Lf3aYy6ru2ei7V0KGrupgXMFLV81gtsCERm7eT5gmsgeQn2/qQDe1QtMqLMS5+80V0QXDyBC305gDqiMLtjYnfV3DvybitRY0rr6aeMI3AT+27GD4w9qkIxK5q/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720849695; c=relaxed/simple;
	bh=5b7nlYN5UCN9Z2HgLFiZLhBBxSCOHltJ7E6mROeXVOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgEcsH+OuAiXoqJJ9h4vc6EDMUzbfcuiRHGfb+Y5f394RybcmMgHW6ohTmrZSQOduXUK4PDT7Qyj2jWVASXFkRRp6CgwsHa6iv488Qokc0lpa2zfRA/6AWHoQqVvy6lwUAqtr6nxF/m8V8FiDRejuVDhg1czxuYtYSiSTWXjlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk3PrVrc; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso2993254e87.1;
        Fri, 12 Jul 2024 22:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720849692; x=1721454492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5b7nlYN5UCN9Z2HgLFiZLhBBxSCOHltJ7E6mROeXVOU=;
        b=Zk3PrVrcwsJaS7e4f1GgtsF9vBicmmrbavWeG1fVueuD3RnQCxLrAmXdhXUHNbqVHt
         vwlCNHMuXvgXfxpmsM7viwJd2h8LczTF4+Ox2MkpAP7VryabaE38hdxoDY2U+stV16/M
         Gy0n/VuGg3UzVFdaJ0GbmphXBzcK4s8vd/IF+2Fv1WfRZFbHR3tKYCLSzwP2yF7ZsrU4
         RLpowroNdgsUZqMWK8LoocvZ7usLYvpNfRb9sDa7iFqLF58eYr4PHgKHyS54Z83bqtVw
         ZI90oAjcg0pqmPbgb+SDGGwEhYK/Ay2RDZ0qj27sPtrfx/wb4TY8o5RBib1OLiFC+rhN
         4BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720849692; x=1721454492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5b7nlYN5UCN9Z2HgLFiZLhBBxSCOHltJ7E6mROeXVOU=;
        b=Qry8SI5z8RLBXLRK2DtyHE1UE4pPBUZV9ZXkztyG5BBC/xHfXU7yQXuNbWvXU79/0u
         xmabGmvb5Pz4U8yx0C0jGWjvMw2rrlUBQG+QmW/I/vdFj07qDCVUHz4sCBicn11FktNH
         jQBsjgykY83WbAlFgXHLAekX/2+G5339451/2rGkiSFcI0u0fsu8c2pfzyREQPTm8hHT
         aszhN/H69xS2iFTFR1Fc4l3CWV7wf/APsAeQSQAiOkfawUvuzHulceIQ8dGaJjeO9nxg
         GLAmN6SPefp62XM/ncQXYV5N4yTQT5B5evcwZMmWqJvStL2zPILQ61mmDujfjch+WNLz
         LLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi5S3BbFEzBD6D1DsSOoeofTc6j2VabscCh/Pv6cNHKqjnCs5j/A5qb+uR/XQBCd+ixoz2n/V5p0m0J/Im5blliRATfJAPh/cSRDr01mHui9J2Q9yqArRF4f4pEpmovKVugDd1EsZS
X-Gm-Message-State: AOJu0YybodOo6ItmgDfO1ZSAc/V3ZqgMJ5bLlLYMLe8A9sSfJCDL2tZ4
	Z8lNYIn6BcKVK4X20M0PBQqKvO2oKzMnQkvxMkuW6tJIsBt/FXaS
X-Google-Smtp-Source: AGHT+IEXmVJ5cycab+t/oirWg73SKE3O6EhCRHZp3Dkg1QZ13yXiKjC+7g2HMZOaMi4KMOugPPklCA==
X-Received: by 2002:a05:6512:476:b0:52c:db22:efbf with SMTP id 2adb3069b0e04-52eb999547emr7539072e87.16.1720849691706;
        Fri, 12 Jul 2024 22:48:11 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed2532789sm80637e87.211.2024.07.12.22.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:48:10 -0700 (PDT)
Date: Sat, 13 Jul 2024 07:48:08 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Kent Gustavsson <kent@minoris.se>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: adc: mcp3911: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <ZpIVGIOkjiRSHq_z@gmail.com>
References: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
 <20240712-iio-regulator-refactor-round-3-v1-6-835017bae43d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeqRwliEJAvCJg5+"
Content-Disposition: inline
In-Reply-To: <20240712-iio-regulator-refactor-round-3-v1-6-835017bae43d@baylibre.com>


--EeqRwliEJAvCJg5+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 11:03:57AM -0500, David Lechner wrote:
> This makes use of the new devm_regulator_get_enable_read_voltage()
> helper function to reduce boilerplate code in the MCP3911 ADC driver.
>=20
> The error message is slightly changed since there are fewer error
> return paths.
>=20
> An extra parameter is added to the config callback to avoid adding
> state that is not used outside of the probe() function.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--EeqRwliEJAvCJg5+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmaSFRMACgkQiIBOb1ld
UjK5KhAAsjjafm/UEOfjYT4bbFoCf4u1ft1ZuatFQ1gMfnFHgvUIRkODsw9dVBGQ
FSB88H8bPoV4PLS6naEKiAhl/JuPaqsYVf/2b8eZaAIdrNc+MzDr2LdVT7y0aCVo
hUN/g6uBFwTaftO93pKUNj0H5NHNS/bhL8EkoJvyKSqqFaHaBXxIgFYTXyU2Wg0v
PvZ/ac5wCQyQ8Xamj3+3QGhtyYKN47IwFbX08RbedTkkaosmNYdqueiwBMUfNgwx
Q1a5LFO868FJQ4uy4rJQXkGWySggcSheu6wGWhl6VmPT37rZxy6AJhBOvRWn+8Zq
mW+y/uIq1Svd+NpWMi0UGB8RrcsyENXZRgkeLHZDNDqBskVjMDQpM2yHf83EVQga
ZhOLvwDuPhNKyFf6xVheChTw9RIBF7Lvlev4briOwsUnxPfpSGLY0zr1VtLj7YOU
Tr7c3yF/ExCy+lGMww9jMFRqqwlLyyd0VQSzOJ4PaFqSDKPhPGwTpK5YqqhvTzlS
MX6vUrasT7GPuVRD6K9HIN3QOSn2ASk6vD9PAYGlUsfWiakzP1MyT+ALmxayAY8h
BlvqjBRy2ZckhLgpOOOjoi2ncPdtXpp/aNfkGWGV6E02FsNsYCzsXI+yy4X8nqEl
G68WBi36dFJkiiMK29Ll0IB62NqwvprrwIpyKsG6CTBIFZtbDWU=
=QH85
-----END PGP SIGNATURE-----

--EeqRwliEJAvCJg5+--

