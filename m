Return-Path: <linux-iio+bounces-16350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB22A4E193
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723061763F8
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A9253F18;
	Tue,  4 Mar 2025 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdLAZTJV"
X-Original-To: linux-iio@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B656253F17
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099064; cv=pass; b=oHMsijHhXoQzVnuoOatX9mY+aZN6aUlaWdJsEi0l/Rqe55YSE7omb9zJsIj2rpAV8JMT8mIh0m9VXPR1dh5OfY/mbF2qgHmlJGDImg1M0MnzFU+D8+Of0afMOUqyx1PDARyeUglo/pVtXQerQpl4R0Mv0qsHqrqt+XPQVEqwNao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099064; c=relaxed/simple;
	bh=hIH1EtAXm1ZDL6e1wVVaoeBlRzWdkdD1nTbcRmTz+Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8GpvLKEpagPofCzsRfL9ojxt3hmbEDNsSzEAbgH9m1H+6Pv1ISuml3i3ntBVdjFlFlLl1exGl+Cu8U/mqYagAlo3Zj0348cRvW3TE0aIWQIQmd3vPItm8GxjB7bPR4X6u0WQ+6vUncRdNJ/lQ8FSTi0SWTOYIfAYJnazVFFZ3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdLAZTJV; arc=none smtp.client-ip=209.85.167.46; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id CA29B40F1CD0
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 17:37:40 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dX61tbwzFx4b
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 17:35:50 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 938B142755; Tue,  4 Mar 2025 17:35:38 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdLAZTJV
X-Envelope-From: <linux-kernel+bounces-541595-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdLAZTJV
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 20ADA41B3C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:41:42 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id A6EE32DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:41:41 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32EA3BE261
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE51FC7E6;
	Mon,  3 Mar 2025 11:34:41 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157A1F4170;
	Mon,  3 Mar 2025 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001678; cv=none; b=aNqxkUPM+mZUJBVfQjpbKzOmlfB2ime/p8CMPf52WkmWAXTeMWOD/4eVgaHhZcs+ud9fG38GJKBWkeG/1h+EHUFkGMk8jJ865Qg3rKEDJ7YVdyxxIb2gmSjlviHobKaKj9Pcx2NBP82ad2BfVLVq72g7OUqlX/I1D/ZvQV3pVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001678; c=relaxed/simple;
	bh=hIH1EtAXm1ZDL6e1wVVaoeBlRzWdkdD1nTbcRmTz+Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKSFa1KaPzaS4+Xx4v7JWXGR90ya3fir/W6Zh/59iqeS4T1+ycmLUvysh1hvbsESFPPEHdOD4PKYDr9sdL6KsGuFxanc9RAqpBG2lizq1CpoScZeNTK8WafguVO6GkcqvoldzyGTMSljeKspVD1KB/aPaZPicRDWDk4DqlsIrXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdLAZTJV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54964f8ce4bso1072978e87.2;
        Mon, 03 Mar 2025 03:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741001675; x=1741606475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3bLf2ekL2mjEzD7tkujcNOqagMHRICtK+3JCb+oWjM=;
        b=BdLAZTJV4ShtJlsbVaJR93jL81ZIG+17P6FJfrETUofCDZKZ1UYxFMZ3L7d5iNxs1X
         GSLnb+44Qjui9e+cDQnCYnjWsevbvgk4JzgD5RnxrGZ7qSzohzxkQn9fB3o9ZtuwRFhe
         xhrrwOKcvnZoDAbBRIBxDPreJmkX17v1nto71UY1QXDO+hX8+z+SQH+E26WnQ0np/k4g
         eSFCfkT4uoeVpBODQ6gePalIiQxIHfbQpZsFmRzxxdVQsrjeGSR6Nd+7mz2m+fl+LLGo
         kML5r4xe+DBcinmD6BzDhyBI1fd5sELhTNgvN2ra0Khx4r7eEMC3r083Ogld80/2ILvd
         4vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001675; x=1741606475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3bLf2ekL2mjEzD7tkujcNOqagMHRICtK+3JCb+oWjM=;
        b=KBuZsHyzWwiNd5iXuwBWRNf6OZ/e3N0xNavXVgDhUKp31Nvrzd5FfnU23pKNmYEsjh
         nYvjpcM3DEWz0sjF5Y3TxPwXWxOObiY0QI7/e0aH0KPx8l3Z1Ui5/CJAQ7aPng/SMIDQ
         HKa9E3RifpQeMLr9BB2vytSCSANLx3FM/KIAUEPGZETQvAww2AIEN9VAxlYTrhjycUtq
         tTEtXU+C0P0PvE6KEmZ249/sutVfyhu94VTBWQaUf3AsjtqwYTuj9vWi7ctF8xcxB5eh
         6nSAUkOIoHld5nTobCW8/qcOGdPimdn06n1c6+ZWLC4uAMFL6hOxP4fzYomg6mhbzO6O
         a0jg==
X-Forwarded-Encrypted: i=1; AJvYcCU0DNwdfKvVLriaSNYAtVKH+Gs/tc80YmN8CaXgiZjO8IJER/fDreZvp2eI5gwwP2517hh0CwP3FKpOneu8@vger.kernel.org, AJvYcCXGt4cRmWmDTtV7YhYkNS83QUmOiSgwqdQH5kU3uHM90d/U+atSE/yWCNhUKK4m5x+PMLuy58AfUUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjvjGCk4Krc5SfW05ooJgPObRsS2A/olDHfyshehB0lrk3k7Uh
	BhwBQUBgfmZYCaQyQaqV0aZvi9d1FLhw04dCQpqmc3/srLjEcxW/
X-Gm-Gg: ASbGncvzokYuFJndhG01x//wJACkqeIiDR/8GXaTIzP8Y0RgT1+56kllSgfRw2+Q8Dl
	6G3KMxbc0PERwoJWyQrdKjiXpMeQBLDmTm5dYrQhFGWct9eVHq18ntnQakOhdOrP+YIhsTEYy6M
	yP/oLV1i0sY9zlzk9xA9Wh7hc8JJwZ/pR+Q/xNCI5NYv0lwBW01e9l3fIObZQ081iI11U+SZlX7
	6ciyB+56lmwEOdfcbFlFY5LhuKRTTdA3O9SzaKa9UiQUw9fo3VOkaMhOWqZti2Y8GvgZJHsZkln
	Hk2xArp2Px6ufvw/5bzZ2DqaeN5W7cUDkFLhugCNDYtwUqCgR036zz6OBfzBnxRiI+5HLuSdpwo
	nznU30EEeWiI=
X-Google-Smtp-Source: AGHT+IEP82kzQb79FpLajjOBMO2V96WoIqxu0JlVkEgDMCgt2ecdJx0G1lKCMssIMejcLev9HvQw7w==
X-Received: by 2002:a05:6512:3d0e:b0:545:576:cbca with SMTP id 2adb3069b0e04-5494c129f87mr4424033e87.8.1741001674446;
        Mon, 03 Mar 2025 03:34:34 -0800 (PST)
Received: from mva-rohm (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54962415d13sm441244e87.257.2025.03.03.03.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:34:33 -0800 (PST)
Date: Mon, 3 Mar 2025 13:34:28 +0200
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
Subject: [PATCH v5 09/10] MAINTAINERS: Add ROHM BD79124 ADC/GPO
Message-ID: <155ab72096f96a0bcd30dea58c681322e825d09b.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wDFfFH4w+vNHhxIE"
Content-Disposition: inline
In-Reply-To: <cover.1740993491.git.mazziesaccount@gmail.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dX61tbwzFx4b
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703756.38812@LxtF6WiFwuqeul2p2lQeCg
X-ITU-MailScanner-SpamCheck: not spam


--wDFfFH4w+vNHhxIE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ROHM BD79124 ADC/GPO driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
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


--wDFfFH4w+vNHhxIE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfFk8QACgkQeFA3/03a
ocUebgf+KOZVTupqMHJ1wPEqgTrD4SUVuhs8pHOvDFao/DTG8OwV8sgVd0TYCcBO
zCdoj8i17vb0DbWAGLbp4pccSCaUf/DOcOjISfiTCuoDAz1u0RWCNimOKmMIyU5x
fKIqmnsFp3jztJHIB6YriEUOlHUEX9eNNZt6A3U39CGs+azqHThxByIWXjykmJwv
rItqFdGnrhsTXIjaH9icQ4WWYbDXJBGukV9Mr7xqpLfkWZjwWGMlaR18MtjNT+Mt
d6S9fF0dsUvzLCLXVJV6ZrBer5TV+R4VIZH4mD/iAnPIFsVoRQe6MAwWLJExZ5dO
h8poDH9Gf18kslPITvMcEsTsBtUfcA==
=XRnx
-----END PGP SIGNATURE-----

--wDFfFH4w+vNHhxIE--


