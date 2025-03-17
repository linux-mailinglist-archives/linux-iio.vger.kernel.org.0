Return-Path: <linux-iio+bounces-16981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0145A65696
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B1E7A4B10
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B3319EEBD;
	Mon, 17 Mar 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpbREVpm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44217A2F7;
	Mon, 17 Mar 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226706; cv=none; b=J9HfEbgP4Pfllad/wzsmXdFUtJqTiWkIIomS3QdLDOsc+XKXrt0OR5rG0qqFFdc+UdNvcox5VVtj/AchxzEjteSkUX/6Dgx3JbTO+/SrClRw+7MyQ1WKaxjc0EMpmu5eji17OlNuxPrJUl6u6p7c26F8G8CjAm2aifNfgKtTRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226706; c=relaxed/simple;
	bh=Oh4plqYxXdIyOPcR3vPrbHY1zS/ykJMjhXiKqSvBciA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRTfUHsTCmAR7ol7H/59VNSGtq7H/IiVj8XGHcC4CNaG9WDkdFUXY/R52pf4d7zG1XaDJ2U+d4WGhx4RE8lMyzJ2N98mmzVm2TxCWfDU45FLdGwUcBuULdw29D7anzFE86rYit1Gz1ei8zoI3XjPQd4tbWI9ho7t6e6DMkm/bhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpbREVpm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so5374022e87.3;
        Mon, 17 Mar 2025 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226703; x=1742831503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZp/H4slk78IiHDNm1oAqEElmdRePMABQQlvBKJ8MF4=;
        b=WpbREVpmXgbbijTHnVguMNmQgYIWTmFFWz6yLZuMu0saFN/NOglvPJbideqI38IHtH
         i9z331/tfhnXmNoVRsyn66u7vIurRPWefy9wHJqbXwtLKbxuKBwM1nqFoswg6HwR8IjE
         WrQBiPUdgZfpr8QQpVcOrQuWVjFzWhe81yrEAu29cBvsXsvH8oKIcL5JED4xaxtuR9XF
         vyCqvEnT8SVIN5eNOo79W30Szj005nG/FyUDcUg50LiKuu/JizflgsHsScxaD7ioCwxs
         lMUBUJijwc8rgSSoofwRK2BVeMxgQ3c6ghalb+uyFVDs2/R3LwN37zaLvhhBNSlPmwoB
         Fyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226703; x=1742831503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZp/H4slk78IiHDNm1oAqEElmdRePMABQQlvBKJ8MF4=;
        b=E/IX9iZyecNwTp0OtsBZG/sj09TXTVHrRrQm3+l9RUs4KQonYYDg5nvcMQdq2CQZm0
         rOfRlSpAZUEPg3uBjFQTFANB6sybQFnVnWuVu8djcBs7h3Wsd1u9TIp+vbngg3hyUOEC
         WB5I52QclD9czrBH5+69IdYn0oua52///6UZ04TWDjrPW+eA+ks/NW2C3r4sKlbATcJu
         aWtSwfdCgCnBhRBeOUFuz3RT2DhFBX2GiVzE6PckpjzMvfFZchtWB3cu1/xviFukZIlG
         h1qdWBwhbRwMOD7Sp4UI1ciHHd5uEkkkEj+QOJtZ1gJwf1dllF1uGHvKeArDSrIvEO1p
         s6/w==
X-Forwarded-Encrypted: i=1; AJvYcCU5E3GC92l/B+CvUWXE2jd/yyK9h4RRvvMADoFQs7etC1HVHFozARodSPFTyBdKpBlozlb3/g0K5dVAmCJT@vger.kernel.org, AJvYcCVCqWX0GwfphjSP6j6BEER8X+kl6lLMvP4OHnJwG4PJ/8PaUZDYZ6o6sIMZh+8td0BDygG0Ctt8IaGk@vger.kernel.org, AJvYcCVNxNXnNRjaUX7A8KgfsEuS9dnoIDf6v6rh+9w6IczP+XXWs1SwGCYkBIRAi2srf4SowdSZjVk4IXb1jhRYCN6koGM=@vger.kernel.org, AJvYcCVXfAMe0Mah0V4RJ5zOdaodx1M/T1Zx33fyW1sWz5FSmCDH8oEVz0HlTdQltHNerObsVcJngj+6/tUR@vger.kernel.org, AJvYcCW7gqIM0e1Aak9W+9XCRJtHFIlHM2DGfkwlvJikGxM/VVEvHrxrcXpYxT258EVuEg77Idt9kId1onyEYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDoZ9Vcjh4c/4/pTJc8OAsAqpqMgvhfVRbJzZikCGz09VWH0US
	uZVpBTllc+jlUDOzfOJTtuXNNoJVC3y8Ehc2vkTAnBNjRsm+RUOK
X-Gm-Gg: ASbGnctvGi1Ok0LScur9brU74XFp5rICw0LwcL959Loodydb0O8vYc+fFzDKsCn8r5s
	j9/zywksUCy3lqUG/wG1C1RkX1ScCZV+JF70J1C2b60w29pXrmUbjrl/CgCPLIVcTncIA0/Lu6I
	dKoaQ+wdNm3bIUt5hjNA6BqmjcN6HFCRRy7IvIp3brQsebBwgnYZvAvvjuj0OVd5yorLaORpCne
	RsxwJC9wpbDWtlqrcsmBPcbvxA+V8AKwdN7+raQvwOm1lzRkA/TcKnEfrca/fpWrpKfTtbRfW/i
	PXoMaQBY/1VxvIzMRRSttrpSZJMNIxV75gPUrPEJYog3LyNyQgDPVGYWZxaQ8g==
X-Google-Smtp-Source: AGHT+IGvE83lD5O75qXN7tU8+BEUTnVmyQ+DR7gPnljh2efy53y9OxWZRbn1FAQt9KPWJXz11ev7ZQ==
X-Received: by 2002:a05:6512:398a:b0:545:2335:6597 with SMTP id 2adb3069b0e04-54a03d02bcfmr277694e87.50.1742226703043;
        Mon, 17 Mar 2025 08:51:43 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c0a39sm1359539e87.65.2025.03.17.08.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:51:42 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:51:38 +0200
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
Subject: [PATCH v8 07/10] MAINTAINERS: Add IIO ADC helpers
Message-ID: <a94e347b7a1dde5329bd20a34f2be99c598bf5f5.1742225817.git.mazziesaccount@gmail.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jMWN2jjOy9xOrAbO"
Content-Disposition: inline
In-Reply-To: <cover.1742225817.git.mazziesaccount@gmail.com>


--jMWN2jjOy9xOrAbO
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


--jMWN2jjOy9xOrAbO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfYRQoACgkQeFA3/03a
ocXx1QgAlMDxwtisjRwLvP8KziloblMOlFslOnZ48Q2HXhA3yRy/A2Xx0ls1xQJp
ChvCUhSiCnQbRqhx8R/4teE4qVQVNynkfbQ2Nv6S9/dc6O4SK7fPqRC0CKk8veFz
bcVWJjuVASjtXvT1uzWgPJIgnDrLeURUNeLuWDEpI5QOcc2P9eiyNOM6gi4GJRNO
v24yX4+JJ9+zC1x7o+er+8PvhFMfqNFQB8ne6YGKs8BobomFtN0OSNEaJB+9LUbr
VopSHM181zpElcvGxK9KpROKKQYANHZTf5jMq43PS+rsiifxT3YjneZ2KmRO2OJ6
RXM+hI/GkXu3MN8wUvzZ898RghADng==
=dZAB
-----END PGP SIGNATURE-----

--jMWN2jjOy9xOrAbO--

