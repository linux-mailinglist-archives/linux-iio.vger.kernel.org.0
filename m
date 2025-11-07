Return-Path: <linux-iio+bounces-26021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B22EFC4078B
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 15:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AAAC3434AA
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCAD32860B;
	Fri,  7 Nov 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UabSgmvo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143929A9C9
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527284; cv=none; b=tDS4xAA+AhPW9R1AoNpHQ8iyAwWBYMtk8j89Nl3mOHo5OyDSMcOMpdaMmw3uEzxoRHDBxMi1s7cQ/JDX3YMe3KdE7jYN8O7BJfectLAzXMwNIhPahUA4gn/ugtZtyG2WLrjceGdUwNmEcEkbX8ZP2m7+h7A+fNapQHwve68JMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527284; c=relaxed/simple;
	bh=2Zfuuwknwc5hDDwag7QjI+SHOWoLDfi1+qT/MitF9Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsk2U/hcAM6vw+2sV9t60Pa4zDPUinYRA3NLEACiajbLbOMWLb0dr+YBpCRx3FYORNoyTuEm4oIdrtwmSaIx7vI3XZvBYoCTS+bhI7ehOY9iSE7OPFvQLqrw5R8tbJFbCRcv9UOgGfcPa7PdKj042N0u+ANoQxheYj6ZgVgM3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UabSgmvo; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B49FE1A1925;
	Fri,  7 Nov 2025 14:54:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8851B606A6;
	Fri,  7 Nov 2025 14:54:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F2DA11852830;
	Fri,  7 Nov 2025 15:54:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762527278; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+RrXgoXV3dOkYMPWy7ye0LNIEtkAh8Hi3Fbrz8hJU1M=;
	b=UabSgmvoubfdbwzci/9uOC7fJEPw6GOF8Fasdn8B7uOlMKhFhIM5ZwpUlN+9SDngbieIqZ
	HQHt5My33IA6wAxM9AChk/cTQc0vjcq8kru7CSTvP4ecPMVY+EX8QTA0tNiEs7CrIxuU5T
	3BJHFiZK5/VUQx/VQPU4tAIgOflU7D60845fS5V5KhnkUahbL3swn/7iK3VuKAFNQ3MKiO
	hdaj+YbgBvcKKs/UPTR+z5IwSguHu3WyUuBVHTlKa3aQr/Gq4TBgZct//mvAcc0YYsptqF
	i6Vl9Vkis8v3Eu5U0a5YeK1rEpnLD0miq1FgEIeFn3T6FWp0qxShSivDf+iJsg==
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
Subject:
 Re: [PATCH v3 5/5] regulator: ltm8054: Support output current limit control
Date: Fri, 07 Nov 2025 15:54:28 +0100
Message-ID: <13882660.uLZWGnKmhe@fw-rgant>
In-Reply-To: <aQzpvR-030zgA82E@smile.fi.intel.com>
References:
 <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
 <20251106-ltm8054-driver-v3-5-fd1feae0f65a@bootlin.com>
 <aQzpvR-030zgA82E@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3017360.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart3017360.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Fri, 07 Nov 2025 15:54:28 +0100
Message-ID: <13882660.uLZWGnKmhe@fw-rgant>
In-Reply-To: <aQzpvR-030zgA82E@smile.fi.intel.com>
MIME-Version: 1.0

Hello Andy,

On Thursday, 6 November 2025 19:32:29 CET Andy Shevchenko wrote:
> On Thu, Nov 06, 2025 at 03:11:50PM +0100, Romain Gantois wrote:
> > The LTM8054 supports setting a fixed output current limit using a sense
> > resistor connected to a dedicated pin. This limit can then be lowered
> > dynamically by varying the voltage level of the CTL pin.
...
> > +	ctl_dac = devm_iio_channel_get(&pdev->dev, "ctl");
> > +	if (IS_ERR(ctl_dac)) {
> > 
> > +		if (PTR_ERR(ctl_dac) == -ENODEV)
> > +			return ERR_PTR(-EPROBE_DEFER);
> 
> Hmm... Are you sure about this?

The only case where I want to defer is if the IO channel hasn't been created 
yet. From what I've read in iio_channel_get(), -ENODEV is returned specifically 
in this case. For example in fwnode_iio_channel_get_by_name() you have:

```
if (!IS_ERR(chan) || PTR_ERR(chan) != -ENODEV)
		return chan;
```

> > 
> >  	priv->rdesc.type = REGULATOR_VOLTAGE;
> >  	priv->rdesc.owner = THIS_MODULE;
> > 
> > +	if (ctl_dac) {
> > +		priv->ctl_dac = ctl_dac;
> > 
> > +		INIT_WORK(&priv->ctl_work.work, ltm8054_do_ctl_work);
> > +		init_completion(&priv->ctl_rw_done);
> 
> Do devm-helpers.h APIs help with something here? Does
> devm_add_action_or_reset() help with not covered cases?

I could definitely use a cleanup action to flush the ctl pin work item instead 
of doing it in a remove() function. It would also remove the gotos below.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart3017360.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkOCCQACgkQKCYAIARz
eA4N4w//ZG1VoCZ4y9y5UR6dM4AuEhYD/K3kpUS7HDu/6tc4OXhOcyY0JiA/Ac+Y
7F146YlRsdWF9djikBdjH7j4JYlioJ4VL68oSfHoQ2akSPDOzcGWWWEpJLAyLvqc
Qincr9O2NRkEdB9mn7rza5I9o6/tQDw6ZSy4Qdy7PKLWRd579b72PUaUGCdHAD9F
TWhdvOqpkC+Wzj7E5vF4sl62C7C3gn/Pf8JfLD6LVI1X9Wu4RyXDVfmotejBwZIO
0XSlWCf851fKAsVr++aaz8oRAnHb3K0x3ix7nNu7Za5mI19Ur7ODGNoKfOcYHg3C
VVQx1N6yBgZa9RSTNmmxj92AVNc/71oBuQiBt3c0VWv92VAmE7YudGRfCmXOZdix
iDzuy0B/8C5GO+9TQnBkrz0RSzc7AAmi9hGCmYt8FHkmPBh94CBtshnyIcb7Lpqg
NGc4AoNMXMFb1rJINlgtRIsdo14VMIOdUMGJELskYaOPwJns28UMblvDfGEKBZFE
5MEPTQDE6QUBjTG2VzZRnWRPze0LrO5ZsQQFH55mTp8L8Kjvnpg7TxUJrpTB5LAJ
zgPSpKju2Tz95hUFeQ7JXo8g2YfRsb3wsZQwwmaKpY8Xc2XnkwX62IHmlrRgmGhH
N3+nEdXAYRL0zz6VGB612VYzp0PWOwfCSajMoLp6awsmqYr325s=
=FJSm
-----END PGP SIGNATURE-----

--nextPart3017360.e9J7NaK4W3--




