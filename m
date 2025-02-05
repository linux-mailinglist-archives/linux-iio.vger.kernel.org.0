Return-Path: <linux-iio+bounces-15039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C1A28BE7
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 14:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC3E3A8E40
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A3148850;
	Wed,  5 Feb 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc/nQRs5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C897130A54;
	Wed,  5 Feb 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762723; cv=none; b=nbfmK4mAR/JZ9wetrxBQrEVmSAFkbB/GTBtnjc9WaB5L4O27xzXVbiS6iEr7roLctMt/wrZPtKxXJJDOLYC23zaO3JH6TIVVnt7ou4c9mBe9RZa96bwIhpGxQEavfY0/HxoVT3kSz7oGGEmw4AzaRIyU2MAeIwhQ7/h15s4oZms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762723; c=relaxed/simple;
	bh=ZwHsXvEmMRIi5pOzTmR2MEibMhbmeEz/dLa+T2t6WSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJbNkvOpZP9VUIHlj6/ypcyFT5qzt/grI2h3jQlMJ4gaX72WzrftHGQvt55iaBtypx8blM1j6/R3D7rU07QUo0uz7Exf+lPBFhiBAeZEYqC+avIkzmQvnIxSkt/hhFXG4ivXg1wF8UziiRJf2gCSSlEgo1Q+fYEUhNU6JjGx5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc/nQRs5; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5439e331cceso2035972e87.1;
        Wed, 05 Feb 2025 05:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738762719; x=1739367519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtgGZnxvJtJeAnKafkHnyoL8G9aE8xLZE3DXXxkmjAI=;
        b=Tc/nQRs5HqgezXwFc9+hz0S4XBOnFpHeZ5iFm3zglIbgrL8ehomrUTXfVZNaVb4sCT
         VgBGQCI51Czo6IV8Fz17oVog0/6hjlqsNmuadhBf+8U7Qc6iUYbKyh3/qNofORCIfhdf
         ETb6oud2gpabO/0Edc1nZhkDK1eWf2+cnw5unvYRUfonyULjWmWR6O51Hjo4vc2uvwUs
         frPM/GmRxILhVW46n7AcU4HVZU2URJ2pa7WVgwX9WY1wazVhp/PcnV0eMQt5w9bgw45K
         XPzegUVGeZ6GGDrEIfbtLs3wveD9JwbRETbM8xFrglWOmTOhweXOvD/RhFtccOzfe7eH
         NUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762719; x=1739367519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtgGZnxvJtJeAnKafkHnyoL8G9aE8xLZE3DXXxkmjAI=;
        b=W0zg5F8IyXAsh8I90friVg66Y7eRr9zOxp8X59XshiH7VidOFNciiwW7OXPfRHKkYM
         5qoPQIik7SulOaeIghIPv/MrXQ3P0R9WrNh9AS4YG/iZ6Qc2rQhefpHc1AQRzZHixTiS
         V9jba77/NZN65aGKsyo0uD4alXD34uYx0BTbeKnV3241pWJ2GxDnhe+PksPJRcbAUVmS
         rhlX1sX58o635WKkQ9Kh4EW2OlDl+v8FOUQp3VQiUrANgCuwolZjsrTd9ZIePG7yyCU1
         jbPNnBOoyxx3xCwOPCH9L54ZQjt4xiR4oNyhnDMgJlfUZ4sArVQuwQuDWTAgz2Xok1Ed
         boDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcYVYT93JNbs0O8kEJjoPnRUpBP09FoQvF8o8YHPCm6jefIHPaDhg8gReg77fW0GZUKEhI+ZCePTYj@vger.kernel.org, AJvYcCXAoKYqiIRSX+IjRWvvpVuHMD7UQwQHO1fgtsUp2eRSwNgPxMzGNClQXHuNC0tsoXfE4PZo6/yysvwa@vger.kernel.org, AJvYcCXrMZWxv4W9dY/nSYybKWMCvL2jMfVl+Tn72bImtpzgoojAzY5bZXzeuLeQDX87rx/nLZ9E+LVfAlu8B2k0@vger.kernel.org
X-Gm-Message-State: AOJu0YyxOWK0SybTH1Ix+8X6Mf8NKFwS53hMsEaM8XYB7Kkb62+1kJjr
	+FTudDXZF32VSQyFxu76T4tLz/BMErowcTWWpqjRMTckm1gxQAhT
X-Gm-Gg: ASbGncvGuypCcM4QO+jridCkrhhHMkf7U8XDDcfRQhRUsKwiWChoC0rbXo/9/VKHC9E
	ErnAN/qFRsQHoIi2MbqYbuRyqvjyd6Kb6q/dPCxHlqUJ9wmbqA0IPEvnvTBgD9iwc6gded97puD
	U1xTSxYvFp0KePgQ5IJXOjhbuqnZBjOh59LujaEWCJhthsbVgF3KGmNkUyZ9ch4vvfrBOmRjbc5
	bZktsha14LGGnjILOjNiTrZgajNkrGfSwn7z0W1YO7HlFqMm1KTpVUggSihneHDLr0p89b+F89d
	qmf0pycpm+RnNmnEPw==
X-Google-Smtp-Source: AGHT+IHuSAty8xtd65iE8dt47lbyMupprxQ9iv+n7wZBuobkrUBB0a+LSu78yYFiijXjXbsMsAE26A==
X-Received: by 2002:a05:6512:39c6:b0:53e:fa8b:8227 with SMTP id 2adb3069b0e04-54405a69921mr881351e87.45.1738762719000;
        Wed, 05 Feb 2025 05:38:39 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebca5946sm1939351e87.0.2025.02.05.05.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:38:36 -0800 (PST)
Date: Wed, 5 Feb 2025 15:38:31 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] MAINTAINERS: Add IIO ADC helpers
Message-ID: <53497726a22762f66e31dd1f3fb4e0bd273c9607.1738761899.git.mazziesaccount@gmail.com>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Yjve8DbcNVU052V"
Content-Disposition: inline
In-Reply-To: <cover.1738761899.git.mazziesaccount@gmail.com>


--9Yjve8DbcNVU052V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the IIO ADC helpers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
RFC v1 =3D> v2:
 - New patch
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a87ddad78e26..bfe2f53fa74d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11099,6 +11099,13 @@ L:	linux-media@vger.kernel.org
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


--9Yjve8DbcNVU052V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmejadYACgkQeFA3/03a
ocV3WwgAn32A7GSfN5+F9QYCJOYFz7Npx47EShU4GpEwTBGrDsllsPg3fxudfBsi
EFWwASEO1WRMa9wUf/c9MKJxILJ1T+Z1nkHoF7KUcA3FxLxKEeImMssLjoqGZELj
hH8goZ/ZIIreoQz5AKCeO/xkCCkg/FHpEJzCK9cU7jX0mNVcfTl2HqFFPUFlSR6g
InmJTBrH18g6OxFZLcmT9vyK3te8qICfUCOdnyoi4hSrkSWCiyoevkQc+We+JZg+
2TfJ0GJ3ThcrdvInhPbZ+R56zBVzG11jaCFRYFVOIpgSVrUx8W1lM4SU3HqIZjIN
KlbOK5E45PEDFYD8YyGSihvDLMu97A==
=gLMs
-----END PGP SIGNATURE-----

--9Yjve8DbcNVU052V--

