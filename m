Return-Path: <linux-iio+bounces-16034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C94A42BAD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE6A3A9A98
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D511C26659C;
	Mon, 24 Feb 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO/8n+in"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D392226618D;
	Mon, 24 Feb 2025 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422107; cv=none; b=ZF333MehNBvt3uCE52z4YMHJzb0cpd9j44E4lGDACMNkLoKoOH4hkoSL/3/cTZDq5KhIKRY9tbDVBcamMeb6726HtzwFxOvm1IBE4CX7gTX7QRW5GUG2tvMF6ir7TTZmfwh8PKwir22+k7FbPfAUrklCpNIiUn33n+Y9UWhfrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422107; c=relaxed/simple;
	bh=v5dvf50xGfv6+dkwMCERzgymEzJAyEQQxvpFgU80674=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc1/DOhQsivPnqsUrqW3hkEKSFoLHhTL1DVgFmd6E5rLdhIDEYcs08kHTXUOlcqbRXlkVwJA3r0Mxgj/J5VNJuJ4AI855NrzT0r8DFqchUvLNxE1cCFDddR0981l64/iElVEnaYtcp6tsrKWOErSlBU3VvFfx1ZBScZtMoofHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO/8n+in; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a6bso49680241fa.1;
        Mon, 24 Feb 2025 10:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740422104; x=1741026904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wB6e0LbXYe7xZo2cDjAU++WyYsDziZwYbdBjD9+h5AA=;
        b=QO/8n+inUl9ySdu0g07PDx5CHZEDl0fdEy1iI6KpieH17wJmEPOaY66xqTExa3X2+7
         G64RUOAV58SEAH+HGr7uHCYFTYPNrXR3R5Ih9J445sreMKjRsX/OHQ8lUccVIjhuZXra
         9AbeiANDwKT/830PMhrQC0QM+gCp0ZaC2/Ndt4mA4/cc4Syg70+gi3XEj6ATmJt+wcRS
         k+a2afV4GO21EdVcF4SAZuJzReG67/g5vY9BHRs76DQ1TwH9LUDUII9yoqG5JWWZ2V53
         iJ6/q9IHP3qtbvH0rkIiKk8kOSioEW22ukA2PNaPpPnp1JluztPQkhAYTMRhJYcuT4SH
         BV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422104; x=1741026904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB6e0LbXYe7xZo2cDjAU++WyYsDziZwYbdBjD9+h5AA=;
        b=BuI8NQf4WBF36RQLARBT2OqJsQWzfABigquI6cNwyRMGB0eNLj/MQEXC281JMOkbKH
         bgPHOLjIFxZqpIiTjz/XIoyDGg0Fd3G1j+0nWlKDZcqPdq//oej3/lpdYd/rO4jptJ1n
         JrGlD+ptdiCphb6paEYJD6X8OE4MTSQbXcTEwJihWSlWR68uJ2qycoESKcQrZqLqyTf+
         3GbMOh9VE3+Lm/F7GqQGdVsvhkUM60BQk/sYFMuw8S5Tls/HcGmSTYfKJN2vq4lfBo5k
         wjCgk7taPrHSA60Y3f2x+tRWakvwZy1SUpeMg/cFNAP9Zh+CEihi5K8EcFHQyY7pnH0c
         eQqA==
X-Forwarded-Encrypted: i=1; AJvYcCVJDJnIPyty0WAKV5wt3BcnusKRxYCoo+uobVPYS4YyZCnHWR1f2mgsaaURRcBr0Lkg5Em3/D9LxHxDsw==@vger.kernel.org, AJvYcCWGrcn+5JyBWbskjkrHdVgM0wLAOlgBPmxXmwV25RFDck4b+t2FJgvOHP6F7d+SLXpi1jNErEtnvck3eQiq@vger.kernel.org, AJvYcCX9+FTTSl3J/V1ZYgvmmYGVWa2Dhil5V/VX7yeK5CtWaDkxGTPLJUbsUhTEWLU9emxnwk0F1kTo0l1e@vger.kernel.org, AJvYcCXUoCRmqntoplBsQc8f3NzVHh/EQhrs4Ogz0FFCFjIaheQgdKTByE5Y4PJy4DRkZ2rzyhAsh7Sbsk6U@vger.kernel.org, AJvYcCXtsB+oAzH/HBMHaaGaVxrMKM8MNFDtLDRBkyowVNuq+buiQASiXih/m7QIC+PhKG/lq31U8FK0pC+JrlRHDmfH5Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQotHK19LJLqvSOlp/2C3sHsBjYH5IVN3sULdfI5AJhzsD2waF
	MseBfMArCoVe2p95U4SvKiMP3iIp4MUb5kjNk0sigdjvL3dJrSAJ
X-Gm-Gg: ASbGnctaxpWm14uwml27yYiM+vbj+TUMOf/g8wLYajQPP5tUdvUYmmwa6O4aAvaehHb
	JoJ/DMrM4kZjD360ZA/D20LbvAXQ+mrUpaL79ozhQxk5+ANppeD4NkGKSnIsbVj0rd0nsPewNdB
	C7QdTnzF5gTz2ZaMSQv30PM+SKQmz1TwJNBlCSiJtI7Cal5zTa83p/2yjZRqxyca1yD0CS8Wj7I
	v/yJvT7/N7wcudPLKWYWcK5PxJp9ODLXPtZKxnexvIg4GO4ZhKS/5r8c9WEzIde7hHU2wvpfMxX
	Fh9FadyYtgZvVsuz8iYo2ij5JEGehE4X
X-Google-Smtp-Source: AGHT+IFs7Y+fPcBuO8FWsGzVtgW29xKLHKqg2RgdPdKlbhb4D5IMevpKDqe0ksSM6DR2potkoMrNfA==
X-Received: by 2002:a2e:81d2:0:b0:2fb:cc0:2a05 with SMTP id 38308e7fff4ca-30a80cba36dmr1382731fa.37.1740422103756;
        Mon, 24 Feb 2025 10:35:03 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e0c3esm52791fa.7.2025.02.24.10.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:35:02 -0800 (PST)
Date: Mon, 24 Feb 2025 20:34:58 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
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
Subject: [PATCH v4 10/10] MAINTAINERS: Add ROHM BD79124 ADC/GPO
Message-ID: <3d7ebd442adbba2719c6028308571995ec10f468.1740421249.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SgT7ql4cmjy8U+5H"
Content-Disposition: inline
In-Reply-To: <cover.1740421248.git.mazziesaccount@gmail.com>


--SgT7ql4cmjy8U+5H
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
index c1821fa8099b..b116a497d905 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20533,6 +20533,11 @@ S:	Supported
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


--SgT7ql4cmjy8U+5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8u9IACgkQeFA3/03a
ocUZ1Qf/T7ozsozyLKeP4mSUdzZsJgJMWnZtn+6t74wkU985+m34/PssYsyOgyn+
Z7JbMjLgd6UQxIoSFaswLl+lNarmqyDACVdrYY4MBivHyFsoPlheMNal5+9IKbpK
rklDqPdlKPuBH31oEX9gi4UpZqiZ/xSpJSR34czNzWgfD1E1PnjC/dCjs75zRUqr
ZlrC9O+eTKjOU36Au17YE+uIZenzVv0Xb7dFpkFr7GwiuX4q7TpmAgodk3AqfoXq
MWa3zS6UgTWRfk7uC2rGaq6CVDnPkf9ozF2ePIJyP0FkKQab+qiYOcJmqBo25cPU
rNO7SQR0wwART+pZH+q6w+G4ARMURg==
=LnpL
-----END PGP SIGNATURE-----

--SgT7ql4cmjy8U+5H--

