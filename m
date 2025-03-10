Return-Path: <linux-iio+bounces-16671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAC6A59563
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353A83A32BF
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68FC229B02;
	Mon, 10 Mar 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2lUq+8T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7522A1CD;
	Mon, 10 Mar 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611429; cv=none; b=OMO2wkpBAnLduFUQD5ZImW7Y4ozWFLe/BVRf9/yZ7ZbkO/32KeEyyK42vWgYI6HMFdfXjPb4TNRiWRokVhVvs/JHUUJ20Jv3T16krcSQJc+BqIw/54wQ8ttgSrZnzBfrGtSB5x3YelGy5/9gO63CvFbHHtydvEpUdr+OU+tfg8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611429; c=relaxed/simple;
	bh=TDKDDPzUaodJtc5UW4XdfLKZzE9wHy3a9yu8RMvuGOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djlbETLcKdLuVKVn/OXW+SPF7HC4p0K/Rp5DmvjRjNzayr+eBLH8FzlNQsmH2ZHZ8l/C0W9RQOaJW3Na9T9enLf2hJ2BY9eE+mwHraAJX0vLASIVp17qc6gBiL5Am6MhnQJOvOR2IaG6NXK1LMj1dl3uccih+IQSkjEEUKTCT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2lUq+8T; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5439a6179a7so4135224e87.1;
        Mon, 10 Mar 2025 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611426; x=1742216226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YGvj5iF7isPICFknfIGBgf8Vkx+OSuL7svbCQwNvKw=;
        b=Y2lUq+8TebobZ4hLm8jLkwI2JmSRefrx2tH5WFIl4VIQ9vmdOMcLf0vIuUg6m6k21z
         u7yN3hzn00I66gkVx9hmlZinryyHSE7T0NwPhkpSzd1chi5VMZricW7mdVjXcSlPW3HP
         ijqLcwnCdyfNVoLLoHTJbuLpXcVspgcbHDr3WY6agMmW3gyRiZBb/ua5PdKhEDckF+mZ
         AaIe1+05muqNtkk/i9eQjdWQMfdyvPioYDTQ8Kj2bOQSZ+JNMdmbMWvoA4066AKFg/uj
         bc65pNtVIm0HZLtFYvPgiVZKZ/YDQya/yVMBn88OFpBe5FILHwEJc3cb56/A7IoRyZxk
         zkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611426; x=1742216226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YGvj5iF7isPICFknfIGBgf8Vkx+OSuL7svbCQwNvKw=;
        b=E37ctcZ8GsOQLxVVgNaNHBuuFNjfJ75Y4qYyiKwuuyT07S0eilz2+puATAuJs9FpDq
         gNiGHI39/f42uavCbxoPWFPcxSYoxTDBEVLMZtg+ZygvVMqETkhcxr9iGXhdZDW6T2DO
         jF8RVYDZGaJ+pQa/SpS+oWCp0BtDGeDsTN1qlvMWa1g9SZaFYDKM8naMEkXrmsPFLSVB
         8v853dwKnu7gcTFPyHlcuDjCHdeYXzissh0J5I57OetlFfrjtalnjOJWZvc3YZ6Nqpu1
         e3TIASSD+m62ZOb25b6XWs5wrwWxlcR2RMW99BxeICXhfJG8qwC39w33Wg5kWbTsYcPv
         +exw==
X-Forwarded-Encrypted: i=1; AJvYcCUR0Lzvb04HILgttbMEwddkprmUZiDi37bi9rGtpeG3BQOI7aEpTyVWVsMDEdHZ4e64KPGAI5kvw0zO@vger.kernel.org, AJvYcCV4wh6DR4l1BYzkZLCyIe6SJI80wWiQLrZV5VBPPNM/BSDXIQDJQeHd3VcYCjkn3LYZksOxveWU7Z7Ysw==@vger.kernel.org, AJvYcCVDetf4Ur+t5rDajxd23kZLbJWdmewwJ0VV60kHXGtXl8nUPEFsqrFJQjXt2L/pzv6apqlptooJly6W3U4h@vger.kernel.org, AJvYcCVd7gvJUFVA8aiUo0UX6BQVS3uaM1iXtCWvNQ8YU7Bv5jIq6T0tYM+s2gu1VlQx/WLnNV3yY3p8QS0O@vger.kernel.org, AJvYcCXCllyRZAsi8Uedm+H06WlUaChgJOYj5qiqNV6+qyyXavUBjTeODWncTvIzd6vBy7zRDYFtj89cj20vA92hmSS36oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsp03NOmi9A8Nqu4Blw0ro/UjJP2rttuS0VnTEdhj8p4oswcVF
	ZOUck4idLxV5iMI7LZijq5mtfj7dXU3RVLb4aqthVmdNW57cJ09b
X-Gm-Gg: ASbGncsieSOKeYBgwPffKCPe7TVKtsiOhl062FzlOSacME+RQyzZu+EACogzz3U2ZOa
	fG9imxsQ9EE34xX9FGBwve4Id3VNoUpO+xIEOn7OvUeTz9hJ14IXWkjWsVoijjvqp4aVGm3R3SM
	eirMvnpYjrx6IuTHTrTudq9OeGye3eTCrdQitv0TA1cUu7Lyb1pvqziVuTwgwrV3xzb/EVHcM5Y
	jPWV3sfg+PmOvMUUqxn2prFrySu4OoJkOMQVeQmd1yP0fUfU3V2w7oTQuAtUZtd2ZCmYWZPduP0
	tq21HlWkL7ccJ0Pmwi6WCQyeQcW00U4+q9G0OCJYHK0zZjsHVayOUJRn+9O2nA==
X-Google-Smtp-Source: AGHT+IF1vXuuBbI7nLmEiCd1MxAiAY5UstFD2g17yL/xAwUgcupEf5SWUE4YyitfHSkIrkHA8dJSBQ==
X-Received: by 2002:a05:6512:b0a:b0:549:8c0c:ea15 with SMTP id 2adb3069b0e04-54997d99dbemr3607673e87.0.1741611425535;
        Mon, 10 Mar 2025 05:57:05 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549a17fb84csm548493e87.250.2025.03.10.05.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:57:03 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:56:59 +0200
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
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
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
Subject: [PATCH v6 07/10] MAINTAINERS: Add IIO ADC helpers
Message-ID: <e180c9de76bc478b5f25ab6f5f22377cd359d485.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w5HoDH4+gEC/QhC5"
Content-Disposition: inline
In-Reply-To: <cover.1741610847.git.mazziesaccount@gmail.com>


--w5HoDH4+gEC/QhC5
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
2.48.1


--w5HoDH4+gEC/QhC5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfO4ZsACgkQeFA3/03a
ocWNqAf+IQRt3DbNgMIf3rJrd2r+owYri/t5E1ozJOi1oIR58An+x6UmSCHr5dJv
cDtlgGwGxpuGc3iPKf37jVUxxk5kp6JLA8NCuBXKc2tLL1Qc70DU7f19BKuoSsK1
eizo1NIesoCze4Rl/q7Fnkh+KjVhvmqjM7N7L8e7z54XTXxlWnKzXXVuEcYW2DBZ
qgaMrb1PiAebugxTKLNi5Vp83oR83dfsWOggg99Tcoy8YLRckErdPegMIo2wnG3f
xRvwu6TPWSHBpWdBM/WGvHbViyzVDblOoLkhGZ/Mgc0AY7LYZDQ/Q1hiSwl2W+27
let2ZeX5sAhxe8/7wNcP++cQwQTrJQ==
=+UhA
-----END PGP SIGNATURE-----

--w5HoDH4+gEC/QhC5--

