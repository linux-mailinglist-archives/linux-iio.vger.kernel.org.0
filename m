Return-Path: <linux-iio+bounces-12466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561FA9D4D6F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 14:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033D61F24DE6
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 13:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FD21D358D;
	Thu, 21 Nov 2024 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEfCjmIq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6B1B0F0C;
	Thu, 21 Nov 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194309; cv=none; b=RQURvoPdlR252KHIVRc1I345bi1Opywu75g9I4JWzd2l/qEVuVatiWliyabhy7Hm7SCQC2UQAstXtmWGsa9o3+fA19kgRlOO1NCMI1iQzGRcMc6tolSk/j/SMAhnjpHeFI4ByGLgqf7O9FmCmPIA/9Bd7wD23/frel5r+VjPMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194309; c=relaxed/simple;
	bh=BoS8/uHin5liWNdqMchxpTB9s7NkRLLS3EYdOmq2li8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IAJ9gsxe2AvVeRtEKeLXDdFikiUKkjsqBW4xTAmPOaSIa0yaYMw97B18nR/Ml8dcMGW0zucihikP4DxuVZsi0bXxSAduuxdn1ncCkqSKajoEemyTlvMRy8zFH9VlWYwm0YkdFgnIvlZLeBgbYRhBI8Jemv5txP7ZoSP0048pYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEfCjmIq; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e59dadebso1055529e87.0;
        Thu, 21 Nov 2024 05:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732194305; x=1732799105; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCQmmnZF3gebIwVU2ozugUU8wkeUvpBfx9H0t+7tamc=;
        b=jEfCjmIqb+ic2gqcjyNxqy4a9xiGpJ0Hp8ZAo54b0gC4WCRgv/nN0OwbR9/Z38Rp0O
         amlESQTk6xjb80H8im6r/JsI96nQi5twOf9TMohXqz0ZATcElVFnrDthMMRwvvYvAI0a
         NyebZNQtpX5f334nL3PLGi6+qpcaYb4uPXAasYf1tOhgepEYU0aIS5CVOmiMVcjZUBeq
         JZ/EXYY7Da8npvQIKz0JFnizBYbBCeeQx7K1fEH/tXACxtbVIBKhMpl3Ksg/WCK4maGm
         qbE9gxzYlRWgCRDVx/txqSJyihLf4noYXX/QNVwXlh4I9HH9J7WMaYnu1LxluXd6gIvj
         bA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732194305; x=1732799105;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCQmmnZF3gebIwVU2ozugUU8wkeUvpBfx9H0t+7tamc=;
        b=tI684EQET870gltPsLgqAYLNLyGGLyAOj68jWAOfwUI3bYQQKynEC+dQMe/94R1m1Q
         pcQQXbLDkA//ZupmgN71twMY/dTdKnDh1gFV+fFGUs+bzflhDA1ZSE8ww5bQNkMWmioN
         GuhF1QAS39qe+cCFnTjRpGsjYxLRnVYtPrOJ5mH3CrF2JxaRTsuBofkv79+2I/+oibZQ
         t7fC81HT77ZyZAsl9dpSAXLueyan7Zqgj90NhTmpeoVmBsOi7bz4JZgYHUY13hYMreoz
         aSVTFXVoQBvxP+X5xpYxAIEYPNEW/h5T5L1dlFCwsuyflvs55O5hYksu1CdbKCV995xx
         uf9A==
X-Forwarded-Encrypted: i=1; AJvYcCULFjXPqAuwK8jfox7OX5POyB0U5oAFy35h26ZawWkXpXzcI2dzQ8+Tjg9ELIhIcabdGUw6QIlAl2s=@vger.kernel.org, AJvYcCXL9tsYwGfWn208mRpniaF/s7hhJ6TKwCaFC83Pij/2qH0ece8RXyjejRLcrx7lA/vLQynNJhtCeYmy5yyk@vger.kernel.org
X-Gm-Message-State: AOJu0YzaD04JSuEldOqH21ZWEvzS7jxGYX2WqxiK//Q7SCmowwmArsj4
	9QJ8+4D2wb5eBSmtpu++Z/fr+9Lp01gygYyVq4Oq8j3hRDdY0zQe
X-Gm-Gg: ASbGncvcY4yUUgLSrGJQ6XNQtQvCiDZ1Y5qpJf8eojqov6SxlaOut0STdJiSDRVtoTy
	fbhL7mePTgEe404NXN4R3NeHg5Rma1Zcar/RriTWQ+25YLVfrizyvx0E0RvVGo12KvVw6ep97uq
	ZZQ59AzMfAbXxxTxj5x8Xobkhn8Vb3kdvkbBFw+dwInlB0q3qn3JpWYdgqL5qorFKn8snMxv6oC
	F8NNyFo2Zy81XgMavHHOhXrBPpTvrFd0eZn78D1GeXIuAFB3kFD
X-Google-Smtp-Source: AGHT+IHTYv18lm1PLy18W5Yt8qSmWxkXFYKYAUAvrkIB+Rs3LsU9QMmhUEJPH87iwBAVKEGZM4Wopg==
X-Received: by 2002:a05:6512:15a9:b0:53d:d137:d7a4 with SMTP id 2adb3069b0e04-53dd137d8a2mr86610e87.53.1732194304808;
        Thu, 21 Nov 2024 05:05:04 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3edcf2sm981480e87.34.2024.11.21.05.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 05:05:03 -0800 (PST)
Date: Thu, 21 Nov 2024 15:04:53 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: Use __cleanup for a few ROHM sensors
Message-ID: <cover.1732193263.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3IiQhOulKrWJowbp"
Content-Disposition: inline


--3IiQhOulKrWJowbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use __cleanup.

The series converts the rest of the ROHM sensors (maintained by me) to
use guard(mutex). This simplifies the error paths.

As a note, kx022a accelerometer driver is handled in another series,
which also adds support for two new accelerometers. I did also patch the
driver for the BU27008 and BU27010 - but when I was testing the changes
I found that the BU27008 status is set to "obsolete". I'll try to dig
some information about the BU27010 and decide if having the driver
in-tree is still worth the effort, or if I should just send out patches
to drop it all. Hence patch to rohm-bu27008.c is not included in the
series. If someone is actually using the BU27008 or BU27010 and wants
to patch it - feel free to pick
131315de97ff ("iio: bu27008: simplify using guard(mutex)")
=66rom
https://github.com/M-Vaittinen/linux/tree/bu27008-cleanup

---

Matti Vaittinen (2):
  iio: bu27034: simplify using guard(mutex)
  iio: bm1390: simplify using guard(mutex)

 drivers/iio/light/rohm-bu27034.c   | 73 ++++++++++------------------
 drivers/iio/pressure/rohm-bm1390.c | 78 ++++++++++++------------------
 2 files changed, 55 insertions(+), 96 deletions(-)


base-commit: adc218676eef25575469234709c2d87185ca223a
--=20
2.47.0


--3IiQhOulKrWJowbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc/L/EACgkQeFA3/03a
ocU24Af9ESs1sce3yqeHLWWLg3aetPZ1Ew2fD0r5Pk0TzgAYPSBGY7weNBJw7z1B
ooOSX6c4cL+dejMfVEUvsyvHLxOhgk+X1Q0K/M5TcqQejWaH0S+3mF2UCzkPJaFP
j1Mli55cdMtluc+nxF4oIKQ3ipfErWiP79+w0phbS8py/lUCBLLNkTJ6JgdlnXhS
7m1BKvlUcUVhaPq/YEUuOBmyZyODsrp3GFAc2uDzsOECyCJXQG+nG+dhuR7FSzth
XjYfCm8Md9l6Jx3NKGTXExN/12wD6bYyyxRGHiCc5oelkakR9F55Djd70teJZE/b
5iXjxt5P9GuH+Wl2hE3Rv3ivLhYdxA==
=YARU
-----END PGP SIGNATURE-----

--3IiQhOulKrWJowbp--

