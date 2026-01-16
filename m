Return-Path: <linux-iio+bounces-27872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D58D384FE
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D180B30EB65F
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F58348879;
	Fri, 16 Jan 2026 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="uHaFHyxX"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C01E0DE8;
	Fri, 16 Jan 2026 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589824; cv=none; b=kWspIgHDb2aV4SPXg91+NROC8z8erQUm52MQ455BvPFDjxY5LHndBm5Z53qej92VXBMXbzj+7JzOSjuG1ml8rAzpDo9Wb0sij1trQD4VseQBziaX3tFB3myP2F7Nxya7lJAUJMBOcu7VFbpGPi097vOqDypucHVwpTA9QdmdT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589824; c=relaxed/simple;
	bh=S7zoe0GY4BswkbsakSmUQQOE9GMqejbSEN7/yTk+Hfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIZbHnoUUtG4ZIPL7JcYzkWCQ0/DWM4lsb9hKP6qGSftrF5cetr6/CckyemkW3E3H8meLuqs89jLm2c2e0HyakwoweMxGQdjWmy4ZlRgD6CGA2abgYn218FSgAbIIcOWQVmMM9tBsW1QQK3DfejME2r7KxBVwJEdJo3uve8uF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=uHaFHyxX; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo.home.arpa (unknown [IPv6:2a02:2f0e:3806:a400:78be:2100:ac6b:d628])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id CB645160209;
	Fri, 16 Jan 2026 20:56:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768589812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJOmJpCC7gP9YlmX8XmgxGIyW6rrfcoWyux96EdxkO8=;
	b=uHaFHyxXAsBTLNaBV9iHo17HNLKl6cbeWLLljyZffZIvNxKzabBjrJINKyZ1dKVM5W/ZCn
	vQRz0zyWeixKBLxXH6yxVHjtfEfBJu1dV0G8gvRwgPaxOg0EM6P2lHlWjJofN0Uwgy+s5F
	YLXsrLFIL8bpr/kWquGJicUuH7T7jcUIt/ALMDvJ7o1ioMEwXue/dWgQbSj5MF3phm4HUC
	u46d4TZF2Y62u9NBy8Q2ZPENYZFvzYGIbQCeYCtz+LlaTSpGx+RsxgiEa42jxTauMkoKUK
	xdDUWgwDBFuTnAZJ/65CHaQM8+KC1ojdgjJW446C7IoygrXxB0Pqu/84AC6qwA==
Date: Fri, 16 Jan 2026 20:56:45 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 00/13] iio: pressure: mprls0025pa: driver code cleanup
Message-ID: <aWqJ7fg8e1Y2pxVL@lipo.home.arpa>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
 <aWfNwLRi4ftU5LLC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UaRTM0J7DARzyLeP"
Content-Disposition: inline
In-Reply-To: <aWfNwLRi4ftU5LLC@smile.fi.intel.com>


--UaRTM0J7DARzyLeP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jan 14, 2026 at 07:09:20PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 14, 2026 at 06:55:29PM +0200, Petre Rodan wrote:
> > This series contains a collection of patches to the MPR sensor based
> > on feedback I received for other drivers.
> >=20
> > major changes:
> >  - trigger flag fix (define edge direction only in the device tree)
> >  - fix SPI timing violation
> >  - fix scan_type struct
> >  - fix pressure calculation
> >     (does not affect users that define a sensor via the pressure-triple=
t)
> >  - stricter check for the status byte + better error return levels
> >  - drop the use of devm_kzalloc()
> >  - stick to the datasheet parameters while performing the measurement
> >     sequence
> >=20
> > minor changes:
> >  - includes added and removed
> >  - rename generic 'buffer' variable to 'rx_buf'
> >=20
> > Tested on two sensors - MPRLS0015PA0000SA and MPRLS0001BA00001A
>=20
> This version looks good to me,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>=20
> The change I mentioned can be sent as a followup.

Thank you for the review.

@Jonathan: please ping me when the series is pushed so I create the followu=
p.

best regards,
peter

--UaRTM0J7DARzyLeP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJPBAABCgA5FiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmlqiegbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEHQrJ6djOkljlwUP/RIh7m2GRbGxrKhZq6hy
72/m4+ROIYeWyhvTg2Su/JBgmMYSYYvzfR7QXBfls6JuAZT57D16or7MvP6X6uuR
MD30yHmZE7RasumepH6ffhymcoy87bDB7MVgRqsY19dj5F5Q6VlZT1oh+yJebKpz
wASv7Cu+HIR+AW3fttTl2uyfAgHDEGjhU3QsvZWfsuCCxuUwu6VrlGKFly4fISJP
g/7DcMsJ+RbyNzKgCRunlvhnDy2+tzTA8S/+NMKOWmW1d70Q07NrJTDKMqW3KZeq
d6nyZ9cp/LQM4QmgeLC1oOeijTh16TQ1qHeTP4FNUQi85CdhmcBLIsD8xPWeyQBG
xWjUcrrEzp0jMrlz9SBxFQ66XRytIbh1NsupeJ1hPX5L78+m1RqU/sz/1uJDSASr
ovnOt7kOI5+ELhDf/KrA8VUKFhUyVvYTYO8K1lYmPbX26OCPGwsGSO2LVhZardyu
I/rihLbnE24CrqgZSo5iNY0ItJy8jee5SNhmoFWrOU6dzGnqO9+Bc3r3YB+yMtdp
netpZnPb6OmUk3FEYZy38Piwx2PjrfZV1TZzR/A9YXCfk/q5wOIZ7eh0p3hN51sd
+2mR85iMQ3x2tBLOvdG64rOUwUomcohIMAI9bsngFZiHxUcwh1takomQ69JynkLy
1P+qnq4d9Hlepd+1Q/gfiu9k
=sXgu
-----END PGP SIGNATURE-----

--UaRTM0J7DARzyLeP--

