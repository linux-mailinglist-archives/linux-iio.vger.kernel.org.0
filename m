Return-Path: <linux-iio+bounces-17758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E932BA7DC66
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EBB175164
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3735523C8C5;
	Mon,  7 Apr 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eae/EiU0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8F51C5A;
	Mon,  7 Apr 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025829; cv=none; b=obSrSaRSg1+4KXNC3mAsX4YaY/Ok0oB6PICnFpo3sxnk5yu5vEKN0C1gydkHt0MqrlOv7PgO+Ak4h2j+ERSNXK1djQIlMFYWQe1P1mCsyEhZRHuVyEkTNFry3AePOy02JnbSdwHFcOyPVzIMivnNoOwvG4fiRkNtYH8gHvTbFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025829; c=relaxed/simple;
	bh=ne9ci4Cv6lRLDs/fOO/SIJtr05AcXjv8D8vYR/SAoIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSouLYYQYrYLlYR6+g3gD4FOT7MnWFNSnWtyfJBHmaRbleLfX4xMbpRPRnG+8sR1oM2xVbXY8FSY13qrlpsgdfk+1psZqsbv3YddPygxnVbdMJHs9/q6hGbsWJQIh7Y+i58NcFzR3LT7Aawm/CA13rONUN1yeSlo7YdadHml3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eae/EiU0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54af20849adso4164327e87.1;
        Mon, 07 Apr 2025 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744025825; x=1744630625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIogLCE25czlv8xNdvtECl+eiGQ9SQ35kVz8Q7EAQEA=;
        b=eae/EiU0lZB4x+sToUz91U31q4/Ns3oEtw2pmTncje7eX1oVbB/x9XJ89LCNEXBeM0
         3PSV67FPfRDurcuPR7mfdH66gaecsBiE/rKxXVvhoFPvxYsuXmMu4bFbdqa2erVrFDRH
         /+CaBeh+27R5JO3U/SM71IF1Mi1I2E++zm+9kY9YM/2lv+FSQSW1JbtGCVaQ3ICX7LMO
         LKjdW0vWc//hDFRS6GFn8yFAqKMzv9VlkZmIxivNQRkg8xa2VLwHVEiY4XVXJVS9nO5A
         K2q6qN+KVZRQPudmk90fSKd0nPi5smFpnsYpF+7L0nieK0JsvudaxoU+8wE3qsE0x9N4
         TwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025825; x=1744630625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIogLCE25czlv8xNdvtECl+eiGQ9SQ35kVz8Q7EAQEA=;
        b=bKpa+X64V7uRHN4ZIzIiXbcARIWrHR4K6brBexwjiBY4lErMMYKH0j7yuhX7P87VV/
         +M9qypIzgrSGAhpKFphxwKL/O0CiUhVMopoR18qcyV0vWxa3MrfL+VtwLY59USXyC8Ho
         ezfO8EMZPTjQ68AkM8/DsVmt3IwbJl5UQF5EHiLtVviRh1yQAsez6XGIXmAyBDlBvRpr
         zSl6ienF6ZD9l/fSpUkP4CwjQMgbtAJNXx1p9pkK0rbi1AcQNRQQo0qr+gtcZhe3fmdH
         7wWGtnGl+w2Mfmi+pmc5lFeJKYCji0RodOS7XTp7YDMaZ/1KhpfzNKfJFR+c2vvB1FUb
         CoxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq1rfzzUM1gL70egQOZYPTUEVBQ+V/ggJT/eaPmhowLt6yk6DNl9Ia2dSLJR978lVABvw5VUMJacEO@vger.kernel.org, AJvYcCWv03F9VOv+wQ6bURp5n6UqBcc0WMaGouVb/LXm7gGv4ZmQV/vN6bx8RvNfGkZ/V7Ru9MSCjChWz1AYLllX@vger.kernel.org, AJvYcCXEIT1IWPiHGE+7HIc1gNigdD7x2jFaX3HO6wCFLOKF9Mw7hkAeDJ6mdzmpJkV5TYhPS7ae+/QTa2T5@vger.kernel.org
X-Gm-Message-State: AOJu0YyktPOCCy2ZEoHSrbtHUiGI3TKINbxKnGJ8EWi8lOWgClh81Ew3
	4rFfFQAmZ7SOZC0+IBESOgmStTV9sAWNu9gDTFPPmOeBbwFWV7vn
X-Gm-Gg: ASbGncsGyYgwWw2O7fkI4LQOrVf3t8sa1dZbjnxsRIIYcX6YmcpyosMmNhPp9mYALd7
	l9Oul+L9G+AR2faZIv2O7d9cO8h489IYOxJF9Vw2cJg6LcqjqxlxbnoY8pFNRFxEGPrneLWecBY
	XNLgbziJDRW/+MKFGM1rPYac65vXIjAbfonYMzhvDnMSHVlOWNCmns5lNrISlv+Jf/79nz4bIle
	fbPgCy96ghsK3o6a05GCH3x/7sOwVVsFsOxCV9VxbBe8fwkEyM2/Iy4UW3L/h9n+uLUkzJQNbQl
	JxzSJJd32r6dRWt2vUM6XrowzIq/ahkw+aXhznFKJ49lBKkeW48=
X-Google-Smtp-Source: AGHT+IHPjqSB+GMfYyqjrh0Aak/fd3rm/itfCJmw71upKIgTCVa+ejcRCY+2WOdK6x+/sOM0mRE1Kg==
X-Received: by 2002:a05:6512:36cc:b0:549:965f:5960 with SMTP id 2adb3069b0e04-54c1ca66e14mr4256481e87.16.1744025825176;
        Mon, 07 Apr 2025 04:37:05 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e65d57csm1209885e87.182.2025.04.07.04.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:37:03 -0700 (PDT)
Date: Mon, 7 Apr 2025 14:36:59 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] MAINTAINERS: A driver for TI/ROHM ADCs
Message-ID: <b303bf42b84e7ab143ff6a4a810f7d788e210b86.1744022065.git.mazziesaccount@gmail.com>
References: <cover.1744022065.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qBKxDlqBy7DI+4xu"
Content-Disposition: inline
In-Reply-To: <cover.1744022065.git.mazziesaccount@gmail.com>


--qBKxDlqBy7DI+4xu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ti-adc128s052.c which supports a
few TI's ADCs and the ROHM Semiconductor BD79704 ADC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v2 =3D> v3:
 - New patch

I only have access to the ROHM BD79704. Maintainers with access to the
TIs ICs (and time, energy and the knowledge) would be welcome :)
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..bb705fac9279 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24088,6 +24088,12 @@ M:	Robert Richter <rric@kernel.org>
 S:	Odd Fixes
 F:	drivers/gpio/gpio-thunderx.c
=20
+TI ADC12xs and ROHM BD79104 ADC driver
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Maintained
+F:	drivers/iio/adc/ti-adc128s052.c
+L:	linux-iio@vger.kernel.org
+
 TI ADS1119 ADC DRIVER
 M:	Francesco Dolcini <francesco@dolcini.it>
 M:	Jo=E3o Paulo Gon=E7alves <jpaulo.silvagoncalves@gmail.com>
--=20
2.49.0


--qBKxDlqBy7DI+4xu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfzuNsACgkQeFA3/03a
ocWa6Qf/YE0bhGFpgue7OaIJA1MgbzrquXNmuLyFPXFOLU13qd/xdwyaE/y37UL+
mFgR5OxQFGlqcOugf+oy6Euaoz3vFhRluVObKuVJ4wj1pLXrhbh1MvvOXBo0Z0jx
KZK0sa8IygzGDXVhKptJ5YSairkrVzUhKkR0cYia75Q6GwVra2qjDGp1N4pILcOh
lXsKULzWqOSm1Xp4fqhBGx81Wny53RhEpOmhQh9r7HkN3uBWYtwFpyYhYV5Mfh3D
LdlZLACTcUycnwPYjaejI+8syV7kzQUzR1qzIk2fZhu0ljtW5XMWFpVVEniGKLEK
dm7hxbzDeszv9UY4GjACZauZzL/hQg==
=8JHG
-----END PGP SIGNATURE-----

--qBKxDlqBy7DI+4xu--

