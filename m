Return-Path: <linux-iio+bounces-16771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3983A5ECC5
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 08:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B963B57B5
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1381FC7F5;
	Thu, 13 Mar 2025 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwNQlxQ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A01FC0ED;
	Thu, 13 Mar 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850367; cv=none; b=bOvazebPc+kBl/GR4F3JIsYk+J/2kJ3u8zYSbdxUwYUGg1tZ24ZMdDBDVDzmG/9Hb1Aj7YBrlaEbZQAX0q1AW0wdwJInNgaSjgCO6Xzk5j4qyqNbBN9glnWhUoSVBRkFP2wiX8JUVC74d0B9zVxtAs1+1thmjWujkP4axw6q8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850367; c=relaxed/simple;
	bh=Ybr4ppd4ggfhezGrA8SGEZN+uoR4U/7erGa8s7nsu5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlL3Ymr0ELMFVStbpsC3jxD75CqroRkHqKaZNSbk5X0RrEKxXbBm3HIUOFfhxzDHKsvCGU7M9qZZqPVfteegCoQH3AaDaaVMZ7DN118RXV4uc/sVf/DMBLDnQQZ8RdzVTahq1aEIMwKgeVQIA+vDcLUXYjRrDzDAaVebS0vy3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwNQlxQ+; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bd21f887aso5509391fa.1;
        Thu, 13 Mar 2025 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741850364; x=1742455164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFwqzBXDybwuD2vjc1RKwbgfdx/o0MRc2L5yNvshUHo=;
        b=dwNQlxQ+wC0d3jXCdfEhHVUbQe2q7DyJGgyluwoOuMeHBgmKUBsEznEYy5Vfticld1
         WrnRj2i1O1Q5Zqhzq+yIbIA/0dQsbj9UartQOnkCBiAQUIUqm5rH39kofM40m0sj5mtg
         AE+M2qOVej6OVIBUxGa2thu3Z0x0T8tlmSSNsoxrNuM7qQmZLD2Go5pqE/2Hg/i0rMmg
         Gu6RSxieGg4PNwYD9jn9GxGXCijO8s66Bn4bn1sJD679n77hIXVeW6lQZBHpVOGKhtMl
         plsKf+DDaEy0wbmYpre7aBtJvf1yTNPWIJ8tWhkR4ubSG0jM6mis/dbEGUX4uMwksXTF
         G3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850364; x=1742455164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFwqzBXDybwuD2vjc1RKwbgfdx/o0MRc2L5yNvshUHo=;
        b=L4++30+uswUmPT7MGKP3ZTS/AGuYw3uiCCdv62mR9CjJtKtT3GjlQifA3hOtKtqrpg
         OV3Sr2hqb4Y2IZCJ+FF657e/pj4mjieqaJrUDrCNM7WqS733eY9wVust3Kpx3nNE8CQn
         LNXNIT3U1+nVwcVc9ZAEHqVyh5xjxQeRGxZ0qanFioC17geJE8DgtBpEnwXiiwUA9sAz
         ooOd4nQ+ZZDNRUidYdArF1mVs22tCXQdLPQIG0v+f6ejymUsblL0OJnThv6jeLZEPIkp
         PCk6D7EkcW3RlceE9+VKIkdokrife1FKJ0LBZYFYcoEGeRYtTIwx0oD8nC+im3LTFFbn
         FcEA==
X-Forwarded-Encrypted: i=1; AJvYcCUKS2PUv4YvaLwtZ7H7DS1Kz9yzM/79jY6AjwWHKvO5yjbU88EI1MdnNmo51NrqpfIsxRUz4DeLcaXBuA==@vger.kernel.org, AJvYcCUh7uvkqCVDXVtFCHOtiXw2FUPcO4S8cvmw3dHidJ6yQG3zDPQfjAc4cxl8EOl3UZLRo/GtM+n/Rv1U@vger.kernel.org, AJvYcCVkyAVPUQ6k+UefXx/j7ldNeCjbUZlKe3NBVMv0I48hPTnN5VPTiy4kBvzrnqYMW8SOr5FhFYnlqWMfwPia@vger.kernel.org, AJvYcCWZ4n8uyfoRPg2/g4E+JIHitKyEB6w6JbnnRXQnLi2FspQ2QCI5J1w1YAPpTUbyS3rE5Ng0EbpWHPsL@vger.kernel.org, AJvYcCWfTa58u6XxRdPraQEk8cGprMtG0OktL9OeoTz94IDQ5a/nYYSGHiay2pUWIMwZJh0EgoMXTG9FbSqzoe9AI5bhBU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQZMlH11OmuzA6T/q9K2IPlvbkAaUGXJmH+1VoYcftb9aDrdJ
	UuoRBdvpVggHu8z+ZyqP9Fr4+Ja3rXYnIZvXVMxZ52SP/YMYA2YW
X-Gm-Gg: ASbGncvOdt+XdHcy6J8CSzu0ZAfDuxOVmBbtTuMcvalkepuLVqK4Ur6RZvsLnw+T8mD
	oX6A7AN/PJf7AShAdDbYVfNRkX7UqzrEO/AHmDfDoYxmzsO02Oavd4DHVH6fpfTbK1aB10OECbr
	dcwu/kgYBH+a0LnMQFFlHmext2tILQPTLc/jYMNvg6Wpt5j4+jBa2OR0GMQLWo4KoEtQcVoiQdM
	JUkShb6tuttFzV38ApnquWicJNMVHSPgSJx3fBj+SEE9N9lK0Y27DddNurjfJ1asBnNXcLWbmP1
	/q9UGTQPFR1DF+DIC2P+2qVITaDwBMQHXwF2k2XBiPvnneoW5ss=
X-Google-Smtp-Source: AGHT+IEjv3VEotqH5VFMYNkLSITb7yxLQ+/ZPsDGqrkSfM+X1MuBHj1FF3/q86MbLY14fdbT78uThw==
X-Received: by 2002:a05:6512:3da3:b0:545:1082:91a1 with SMTP id 2adb3069b0e04-54990e2bd29mr8607537e87.7.1741850363715;
        Thu, 13 Mar 2025 00:19:23 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8851c4sm117554e87.199.2025.03.13.00.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:19:21 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:19:17 +0200
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
Subject: [PATCH v7 07/10] MAINTAINERS: Add IIO ADC helpers
Message-ID: <b1d1358a6e8f436fe6a6d5704e63abab660950c8.1741849323.git.mazziesaccount@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H8QAWWuku4uOTwSt"
Content-Disposition: inline
In-Reply-To: <cover.1741849323.git.mazziesaccount@gmail.com>


--H8QAWWuku4uOTwSt
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


--H8QAWWuku4uOTwSt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfShvUACgkQeFA3/03a
ocXgIAf/SYEOEjN0fysrCaCgrEuPeg5uKTPDg9mCm7K35bm36KYpZkrUX4WcZFsG
HxF+grWO98il0+w8YpYtNFVU0ureaf+sM0frxSTd5Iv2BfQMa2flmcnrEqXPgPtP
FZ/hZA6gUAgExUU+fs+nQbSqLkYxuYp8z0NxwnipVYJz6JupSNgI3jevCBY/mXXp
Deb88x3LzC9x2iwaGd1yaMhs2JeSbkeZWSz0fmvinB0881zxkId2EvLR3eJ5NBuZ
pOJXGC/SACubM7oIo4BTJ3UQhODieMHUZEhaMgbxzwuuvpDWhCqwz90UvNj5ZSGy
jv61+IuPJ3I14vufpID4JxSi7Xe2ig==
=01Pj
-----END PGP SIGNATURE-----

--H8QAWWuku4uOTwSt--

