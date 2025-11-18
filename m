Return-Path: <linux-iio+bounces-26295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD0C6A498
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 16:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EF044F6017
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB2435CB72;
	Tue, 18 Nov 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jroZHKaD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED035A930;
	Tue, 18 Nov 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478983; cv=none; b=oJuyuuogYAxbDx8ORoV3CtT6qbZmuqMi7gpRHcNjzmzji1CnIoXHyodOznGMbC5H7KkgkKrgT8yNzaxH6MayzJv2mk07XP1Fsnm8f5/fy/7SJqzDOjZZDIXUKId2wlx6W7O6WPkZuba8WDN3HUH29j40kXTj1unYCnqIhD7eE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478983; c=relaxed/simple;
	bh=mfYKMxuO9gX2vOamABwmiJX7LC6XjJnPMwHU30/EDUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLui3MbH2ogos1fYq6CzEcwvLVLfLjAIwEe77LM91B//2UbZYeI5vJ+8uqfeGqHgVFmw9uBGBmkR4rnsCcxtPtHZopwH+u3CfunNU2wrM4LvfxpBIwJA7+fSnkmVLMIQE5Iv+A0jr5eaMyQtcu8q29Z4r8E7liGdOPHQwhb11Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jroZHKaD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F2B5F4E41751;
	Tue, 18 Nov 2025 15:16:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B11B0606FE;
	Tue, 18 Nov 2025 15:16:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E897710371DF0;
	Tue, 18 Nov 2025 16:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763478976; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0SRSinwLefSg9+bDKGDMzZgFh7nU8j1QTFAMExgzYzU=;
	b=jroZHKaDVnf4f5/351kGAeYDpxy99Yhg/6qfAtTLM1oC7IZ8F4ZGJ3/qQ/M430Nu3XbGtN
	RA+yhp+W2pE2gyet9fzE6CCPGMDdHJ3r8GFBk97KrzxYQu2Km3SNWr6+skghmB20nn7HEa
	fLgPcIpTcwJlkrru1BI9Fbs8yi/iPYe6EHfp8UaOLiKRhcTFAcmEKzw2uSOtZiFwByP1ry
	s4TU63ygFA+4uocx9oqecCdsaJ71dK3EKb1KfM6RdqPa8kerybQ8HiO0Mf1FlJxv++rpcf
	EiRdGcPnJry1n3jJgIBk24vPzQFOWGO3Ite4QqOC4TK1nbA8Q+sRZejRM6v9/Q==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: add processed write API
Date: Tue, 18 Nov 2025 16:16:11 +0100
Message-ID: <2330439.iZASKD2KPV@fw-rgant>
In-Reply-To: <aQzHtqFEIA5E0ikO@smile.fi.intel.com>
References:
 <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
 <20251106-ltm8054-driver-v3-2-fd1feae0f65a@bootlin.com>
 <aQzHtqFEIA5E0ikO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2021660.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart2021660.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/5] iio: add processed write API
Date: Tue, 18 Nov 2025 16:16:11 +0100
Message-ID: <2330439.iZASKD2KPV@fw-rgant>
In-Reply-To: <aQzHtqFEIA5E0ikO@smile.fi.intel.com>
MIME-Version: 1.0

Hello Andy,

On Thursday, 6 November 2025 17:07:18 CET Andy Shevchenko wrote:
> On Thu, Nov 06, 2025 at 03:11:47PM +0100, Romain Gantois wrote:
> > Add a function to allow IIO consumers to write a processed value to a
> > channel.
> 
> ...
> 
> > +int iio_divide_by_value(int *result, s64 numerator,
> > +			unsigned int type, int val, int val2)
> > +{
> > +	s64 tmp_num, tmp_den;
> > +
> > +	switch (type) {
> > +	case IIO_VAL_INT:
> > +		tmp_num = numerator;
> > +		tmp_den = val;
> > +		break;
> > +	case IIO_VAL_INT_PLUS_MICRO:
> > +	case IIO_VAL_INT_PLUS_NANO:
> > +		switch (type) {
> > +		case IIO_VAL_INT_PLUS_MICRO:
> > +			tmp_num = MICRO;
> > +			tmp_den = MICRO;
> > +			break;
> > +
> > +		case IIO_VAL_INT_PLUS_NANO:
> > +			tmp_num = NANO;
> > +			tmp_den = NANO;
> > +			break;
> > +		}
> > 
> > +		tmp_num *= numerator;
> > +		tmp_den = (s64)abs(val) * tmp_den + (s64)abs(val2);
> 
> Here is a subtle bug. The problematic piece is abs(). See
> https://lore.kernel.org/r/20251106152051.2361551-1-andriy.shevchenko@linux.i
> ntel.com for the answer.

Oh wow, that's a nasty one indeed.

> > +EXPORT_SYMBOL_GPL(iio_write_channel_processed_scale);
> 
> Can we start using namespaced exports?
> 

Sounds good, but won't it look strange to have only 
iio_write_channel_processed_scale() use a namespaced export?

...
> > +/**
> > + * iio_write_channel_processed_scale() - scale and write processed value
> > to a given channel + * @chan:		The channel being queried.
> > + * @val:		Value to write.
> > + * @scale:		Processed value is divided by this scale factor 
during the
> > conversion. + *
> > + * This function writes a processed value to a channel. A processed value
> > means + * that this value will have the correct unit and not some device
> > internal + * representation. If the device does not support writing a
> > processed value, the + * function will query the channel's scale and
> > offset and write an appropriately + * transformed raw value.
> > 
> > + * Context: May sleep.
> 
> The above kernel-doc doesn't have this!
> 
> > + * Return: an error code or 0.
> 
> Be consistent with the existing code, and even in your own change.
> 
> ("Return" section name, "Context" section presence, etc.)

I'll match the "Return" section with what I used for iio_divide_by_value() 
then, since the format used for iio_read_channel_label() is broken.

> 
> Use Perl (original) kernel-doc for now, the Python has a significant
> regression (the fix is pending to go to Linus' branch).

Thanks for the heads up.

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2021660.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkcjbsACgkQKCYAIARz
eA4fXQ//QGqz4H4ENFNq72qkhITnSHxMsfBoWU9KFy/lCTcNjVfXuNc6E3pHe44i
KZBZUjb7XejpuBM44tGA5x2rTUE225ox1Ikz0ODonv+qE5olH8DqQoGpry60Y1lc
rfwJDkrV2mitZsnIGGnJI7OCRN7gW0FXufRtG/aq3EeMKbLpgriRbXvLv7D91bkf
aEdyTUuQP+1ffigvegflOH9hfs/BVg4AhVXPymJXe/vcc7pB/uwXY2ahmh5SlM3q
tV9XRGWYTXZvFRVpTIDqQYUFN8IW+/DfuuEU40hej1U0h4Y16uR4Ffmzp7bnLbHs
N9j4OwOCiA0WCMsr2B/bGpUXAEPHyQo2dZ+PUHYeyXOZkXIpGsj2cAD+b6EDdE21
ZXsbiU/BtgMDi4OML/ATVkVYGG9nwbiuYB8ug+VsgnqTqsPYdtGm8aczgiJjRySp
TxV1So3jAEvQ5WJD9PajGFJl/wN4cTxqU4BNNHsljxn8f4Kn11JxFZG8oCmiORpT
rjwhqxsg24rTGrXtuRbrfa6KA7DY0FW8/P0OdsdO1QR/AhIl0G37I6G4TYT6fWk8
KvH7deUJIzjiV3PILGi9KebRkPdSWC+Df4oyulCx0C1EXWKT6C9J5DduRQjBZz38
aVwrUT8r9dxO/lvarxVZVILCuGvYsAX5Qp26N/zdWK1t4+qMoiQ=
=/z3o
-----END PGP SIGNATURE-----

--nextPart2021660.PYKUYFuaPT--




