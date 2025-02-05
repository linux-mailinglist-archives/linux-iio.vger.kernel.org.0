Return-Path: <linux-iio+bounces-15035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6E0A28BBA
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 14:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C145B7A0796
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2314D78F35;
	Wed,  5 Feb 2025 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZi6TbfF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360CDBA38;
	Wed,  5 Feb 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762456; cv=none; b=BhturkJ0I1mT2PFyBOdhtcxV0DDx8HW0Ddhr9NgJnrcE4FoN1BFHwmTgXhe94LvYbJT3Kz7WMn7gB74Om22MpuQ0U55oKnAEB+pFbsX95NgPeTCwYr8w8AmaY5j+jU93rtICRZdqYzyFf2DCOFBT/w8ksfWHzh2jhl1cyOPvIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762456; c=relaxed/simple;
	bh=wH4INXj/yB0WM/MEDaiNTA3ukKzNoRefwQpOnYhO1Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i/UOWw1ofQ+tThQKjdCSbNEj+IAAO9KcQnzX9HGwVbFPxhe5in7E1AJS5v/jqcjm/cqTEi9I1PGb/eqDyEcHfoxbQNGSUaXXgNP22KYQGtbfL9lBzx7Q0hf67vgPbfRtSfQ07zp0kBHzz0+FxI4pMplVhLgVQbw/wBu6DrVh+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZi6TbfF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso6765012e87.0;
        Wed, 05 Feb 2025 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738762453; x=1739367253; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5VPHMQHSk22iK7PExkQd64RNhGObJs9x65xSMyDKB8=;
        b=KZi6TbfFp9vS1BOpcl3goZMcx+jwnI6nTSpKh4Gqft7vxWE+bxW7c+ZiUtC5X36ytH
         Bkli6tl6ltzySHWPNuI/j7pgfq7Byb4R+2qnxm8zJ638DC/uhc+mMTK1vhgFEoThFOao
         62vaio4F5NTKgzulTBd0AvC0+UkpN2g9VBnjfO0r1z3+Ubd8CD8C5QnN0IyeBpP08FUu
         TjFbTplWk96gkfgbtxEDhXodeRXJjVcV2n6DXhx25V8rEGjur9QJhbmDjCXJvdrngiPj
         Zdn101xFOre1KTk0ROTYIrMw16FvKowScDa3SHLJoxZCzpMiYX0TflZB8RtP1c0u/YGH
         IKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762453; x=1739367253;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5VPHMQHSk22iK7PExkQd64RNhGObJs9x65xSMyDKB8=;
        b=ZYpJQI0LPrMJqxrd668KTJO6fHwyWkzCpxAIDoJM7es/D5u6ktB143exm06w/m+/9O
         HJDTxbztXQbmR3CqLZeF2jfzLKkXpKzttB0ZZr3LM1Tf3xcOEipsX5tpmd7NgBe4ZW5g
         Jb1CtUNWCzetbEGd9xcbgRnQHXyHqaKX0LG5NZyunMdFW+bA061i2QZcEkTZ4DTlng+2
         jy9hVwwe2uRhRCMhMx9HyCM7S/mczn+8qFDXOESpG1ea742HhUs8AoTy7/+kqF6XmuXA
         QreIZ4110qpBV+VpydPRzU9aoKXC+dw+DOuHhrBNbIEEcrna90LGWrnjM6hVtAa1vC1k
         jQtw==
X-Forwarded-Encrypted: i=1; AJvYcCU6dlO3/XPId7Ewx43KmY/TpNORBLBNFPf/5VwkvTvhTd6d2gRmorJQBS/ZFx4FyP1pjwcPAGLjDQ+v@vger.kernel.org, AJvYcCVwI/VMMmnUNTvzLEJ+OPW6DxN7suB46KA5PgnDeJJ+AwC7O9qCQCMU3Vp+5WscTODwGA+2ui+czNGJq5OA@vger.kernel.org, AJvYcCWN5OrqjzzGHBBnvT20hySOi5w47SvpiTfC8n5lrtajm9GA2dfxzyamUfhQkJV1NqwFjHMOmjCYZkDK@vger.kernel.org
X-Gm-Message-State: AOJu0YytiimxUzTGKMq7QVjGCHK03F8gM4RHAqhXezR2vQCax0J4EbV3
	oZsJBEwD6kqeeI/3Tfi3VGYEcgX9xub0OPetKlwWNDpRewIucLaU
X-Gm-Gg: ASbGncvtJJs6gugcTnjfxOogDagWhfrSjI7dJ3CFUWa+5tfBzvgWSgpTQ0BpuiWDVSC
	HuX3AwSHnbu9xAeD5U7ckXL0qtq+1HfCwd5ItFmH3nTyL1rGTFeODeuC8vkAKVutnlhGTEULzpO
	lqqpUiZZxwDwQtcWy/vNqPygUmwMICN6zZytqofAYqc3kEFredGsXzsGVDrlgbwAQ3IUWDzgi+w
	D+f3yOPFVhdnLJuWmlz3z9taWW8xaEDSwl1DqgyCDWLjtrbU93pvu0KxAMtjiqYah0Db3zyb+IP
	RV3ghzAblOjHUuuUsw==
X-Google-Smtp-Source: AGHT+IHhu6wOkBIE1LKIVbgMbbrlaOtezxn+bPEt7EXhlFYg7ZXgjUABVFFMnRCx1ZOfE7a/bqUsBA==
X-Received: by 2002:a05:6512:3f07:b0:542:29b1:969a with SMTP id 2adb3069b0e04-54405a1edcfmr787845e87.4.1738762452832;
        Wed, 05 Feb 2025 05:34:12 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5440c35d995sm15389e87.121.2025.02.05.05.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:34:10 -0800 (PST)
Date: Wed, 5 Feb 2025 15:34:01 +0200
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
Subject: [PATCH v2 0/5] Support ROHM BD79124 ADC/GPO
Message-ID: <cover.1738761899.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OnNu6bMdQyqB6LDC"
Content-Disposition: inline


--OnNu6bMdQyqB6LDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79124 ADC.

Quite usual stuff. 12-bit, 8-channel ADC with threshold monitoring.

Except that:
 - each ADC input pin can be configured as a general purpose output.
 - manually starting an ADC conversion and reading the result would
   require the I2C _master_ to do clock stretching(!) for the duration
   of the conversion... Let's just say this is not well supported.
 - IC supports 'autonomous measurement mode' and storing latest results
   to the result registers. This mode is used by the driver due to the
   "peculiar" I2C when doing manual reads.

Furthermore, the ADC uses this continuous autonomous measuring,
and the IC keeps producing new 'out of window' IRQs if measurements are
out of window - the driver disables the event for 1 seconds when sending
it to user. This prevents generating storm of events

Revision history:
RFC v1 =3D> v2:
 - Drop MFD and pinmux.
 - Automatically re-enable events after 1 second.
 - Export fwnode parsing helpers for finding the ADC channels.

---

Matti Vaittinen (5):
  dt-bindings: ROHM BD79124 ADC/GPO
  iio: adc: add helpers for parsing ADC nodes
  iio: adc: Support ROHM BD79124 ADC
  MAINTAINERS: Add IIO ADC helpers
  MAINTAINERS: Add ROHM BD79124 ADC/GPO

 .../bindings/iio/adc/rohm,bd79124.yaml        |  114 ++
 MAINTAINERS                                   |   12 +
 drivers/iio/adc/Kconfig                       |   15 +
 drivers/iio/adc/Makefile                      |    2 +
 drivers/iio/adc/industrialio-adc.c            |  151 +++
 drivers/iio/adc/rohm-bd79124.c                | 1149 +++++++++++++++++
 include/linux/iio/adc-helpers.h               |   22 +
 7 files changed, 1465 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.=
yaml
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 drivers/iio/adc/rohm-bd79124.c
 create mode 100644 include/linux/iio/adc-helpers.h


base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
--=20
2.48.1


--OnNu6bMdQyqB6LDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmejaL4ACgkQeFA3/03a
ocX5kggAwHsYuEgX1nBpTUfwU7QJoTiUUC6wrOKMAoD/78sE5zheMMUhmqGM8d7P
9LZlV1ZHDZiTkAf+vacILf+ryMy2qkGaTh5gRIAXyznlDMWQ2bvAnz/GTX2TwvSX
qeM7zUx4p+7r+vsNAQyHwmbfY98wYOJrBH9K+6IefCxrnx8h+dIyA0usfA6Q4D8a
UPBjw+nOTLuRF42fT1ZsIaNf5XpWcYdSR5tSA7ErunBX2pyyE983chdeHoWDS9Zi
jBXEzzXW0NvVwCnoM1wE272xp7EuzrPKd8yDO58voXw4rnb09hovRxJOcHrfuqEk
y8FzBY9T1wA7ZPt7GFAEJ6lveE95IA==
=ZtbX
-----END PGP SIGNATURE-----

--OnNu6bMdQyqB6LDC--

