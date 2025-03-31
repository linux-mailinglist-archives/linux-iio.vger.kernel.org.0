Return-Path: <linux-iio+bounces-17403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E9A760CA
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C532416796C
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE11CDA3F;
	Mon, 31 Mar 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNe7jhts"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4F1C84CB;
	Mon, 31 Mar 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408202; cv=none; b=IlbAlt+26x3PQ9ct3BWJHapdD9ySRRYIs7gkKD/91Sz2LVPp1J4rfYwweum5CffyF0bh9nkNi1u8jZI87+QRUMKG1JCTfWajiM8wHcP7o6WTSK/rJgrODNTN+3nhZfMirbX4BcidwWUQJVLZYUC9462BLqeusnwHYewWsaQ8wiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408202; c=relaxed/simple;
	bh=sLsOEGgbANVBmSD6KqrVtqbLk7QTOIrAcz2qcG4e+xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdPsCQlkQ29nqSk5JbXWYfIBFfX+roVGEKEHB8dDHhJxK/kMHeXhYP0YXU/lWdusSvlJbokwePGvq8R+VQ81FJzQI1JtPS1HNH+qmDPPQxknCufLBSoiGnhUg85j6jDccLLpXWF8vvv7Us4+NLRQIct9c7RK0qVUq/GAK+kIeUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNe7jhts; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a6bso42370011fa.1;
        Mon, 31 Mar 2025 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408199; x=1744012999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X730x4T2JIToViMkAJIWbDc2vHITmtIp/9sHb3iZc6A=;
        b=bNe7jhtsXYFrOjx8O0EAMXwBBWc3V9NcTtJq6Wz1MHL5XuUWPb/cG1UAvO13LqvqXA
         KRHb6h4lK0HtlGQk+62a5VkFQG05nLtRgimezJzj5ApDCtDAFn+YLyO5zfKyDmHpZHec
         p1YULW4jHGbIVvo0FDzG/1UZ0gfh19f3Z2sPQ3mtrl+KBKp1MLBtfgprM3WuEphLNCKG
         45oLcJM3nH/plGUY/638Th4NlSjDW4ohE1ilsN6RCWRKi0NDp3OHgNSrbS4VRKsmVLCS
         aC1jNgQBBPCEPhgIGLYaHNih5UIBY3We7RauzHR3+Vu/EfCMjDbDARjrEkV8OAAzsrmt
         sB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408199; x=1744012999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X730x4T2JIToViMkAJIWbDc2vHITmtIp/9sHb3iZc6A=;
        b=pm7+MifVEWmwSMtsqeMRaQVvu6PDPW66UTcCZfDj06m0I2AseT6yUZtDNB0CnlbhOo
         Tj6YNWzPiieMSEvfpZUZSAd8j18dNOz7k+GHNd1td8aAhXO16RAjRoe0B81vwKxigw7V
         PVDLToAF0nk5rc8YrxNhiSsn6w7JJafC9vmLTGrcAQRSRi0bYYvx+/iByn0SzOHWyXLf
         9YXHR7o4iMQbq1PYbdWX0/1CwC++hXIZjtDYWZbY+yRPobahB90AEMJitZNUJuxyvCsB
         K+Q3sXoZ55uVfXtJ3qegefqPeW8fe86qarZDotWbnoKLBMSuhklWChIncZm53k6MUQOh
         a1ww==
X-Forwarded-Encrypted: i=1; AJvYcCUpJ7e07hEPLl9NwM5jddRrEdpYounpiW3i4t5JCkuyye1ic3f74KxS1E7byn/9GhssDy7mHJlAA0g7@vger.kernel.org, AJvYcCWt+DT8YOS4R9bkTEJ4Tg4T5ohnEO/XpHXPPBOPyp00KkmWm0b+JjRTmq+evmB9CXyK10XlwujJQxLa6asj@vger.kernel.org, AJvYcCXF36zvcugiy0ffhzEd9T+0vvxabh1ebVr5yslZjLsKp63UinKabvYTgjsgLbOVZVI0+JjIT1/3lcMk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8FwFhFezWgEdiklxT8nr42Cq33EFmBt6Me242kZv7zABrYI/B
	h5H80Ru8ux10b7ybX9aaFvVZRzIFTVq9KZqJQah4VbFBzkrJ5poH
X-Gm-Gg: ASbGncvb93C3L/cjitM2EvJK8NEz/ijxFIkrgGzHvQRr0l4FbuFhGhseRNg8rDpUEIW
	zogXAJAyspkABi1+vI7kZ5t+TAwC3WBlMt/X+9sMKXHA324yYI5BIyJLoQ/H1xMOPHE894aESkD
	oOmj7rcMuYVxoz9xUwC4R5r3AeBFMRvQL0dM/BrukXKSO7CvDSktiu+z1+7p1PU5oH5y9wZN0C2
	ZjiV8nZzPMZMoIIU1Kzq0XY2ZcpJIVAZM9GtEiU7sYJdyN9bsWYzDN2iQfCSpIVHAWUI33C4a+v
	yoFFxbEUV7gBLHGF3gfEuSIF22kOxMM9lDolOfuLNOUcPtMFbXI=
X-Google-Smtp-Source: AGHT+IERAzNCayghFl2Qub5HKcbxc0Y20Jm+zVTonO8knxjQ+9SxY5zVB2KAySyt6bWXfLV/dxzHaA==
X-Received: by 2002:a05:651c:1590:b0:30b:b132:43e5 with SMTP id 38308e7fff4ca-30de0278988mr34495131fa.19.1743408198818;
        Mon, 31 Mar 2025 01:03:18 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b597c6sm13282681fa.99.2025.03.31.01.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:03:17 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:03:13 +0300
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
Subject: [PATCH 3/6] iio: adc: ti-adc128s052: Be consistent with arrays
Message-ID: <49966043aabecad8db8eb81908d0d2995b0cfc38.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8zTsRZHbSz7wtKGP"
Content-Disposition: inline
In-Reply-To: <cover.1742474322.git.mazziesaccount@gmail.com>


--8zTsRZHbSz7wtKGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ti-adc128s052 driver has NULL terminated ID arrays for the
of_device_id, spi_device_id and acpi_device_id. All of these are
terminated by having an empty string as the last member of an array.
Only the of_device_id array uses the /* sentinel */ comment.

It's better to be consistent.

This /* sentinel */ comment serves no real purpose these days as people
are used to seeing these ID lists terminated with an empty array
element.

Drop the /* sentinel */ from the of_device_id.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/ti-adc128s052.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index d1e31122ea0d..dd1e405bf172 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -185,7 +185,7 @@ static const struct of_device_id adc128_of_match[] =3D {
 	{ .compatible =3D "ti,adc124s021", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s051", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s101", .data =3D &adc128_config[2] },
-	{ /* sentinel */ },
+	{ },
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
=20
--=20
2.48.1


--8zTsRZHbSz7wtKGP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfqTEEACgkQeFA3/03a
ocXmpggApsAABquzWfcDM8OEeIZP2TXHrScy4kZG1z0a30OuWRpW+bnItZaTZiNW
5OFxB6yF8b8G2QUa3DfaR6E3ymx4J2TibazQmNP6w0KiSjYkG+R87nCRLKSeUawu
oDvTfD85tk0c9toGNcg3vHx2G8otUQnUy7h872MxVMJ7CVz3OG4OYmwfYpH5F5/o
Zk+jzHdJoHuFSa4irnCsY3WOjWScbfZ8Cimoh5fFyiYF0NjHDCDNEliQRqm61X6U
qveylgFKZ7YXCXkiYsmf2tXx4OIeFNoP8jp4rzXMd8LL/a3V+2rUSg40Ot8O3e9S
m43fyLsBO0Sl9zuwebO/z+dA60Qa/Q==
=nY5i
-----END PGP SIGNATURE-----

--8zTsRZHbSz7wtKGP--

