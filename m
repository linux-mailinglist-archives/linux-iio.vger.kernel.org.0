Return-Path: <linux-iio+bounces-19914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC5AC3844
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 05:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C185B171AEF
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 03:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDE3198E8C;
	Mon, 26 May 2025 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwpwAJ/5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC19FC0E;
	Mon, 26 May 2025 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748231055; cv=none; b=l1y8S1ISLzjGfpzIQLdQ2jGdMot3hh1UC+1Zo+vzzoFOYLYSvRWos3huwc0c+P7OgHdTxa/5kaBhU6FZtgDtz5+aEWS3nZEgimHcIDGm8+h0zWWjMn+EH62PQSKWRsTNUv3q8fRYjHXVTrQuzrHWE4rIry41c1rwcDs9CrSXjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748231055; c=relaxed/simple;
	bh=7u3tBpcnZkgEkvIyTvPmQR2vG1pN7Xke83aEITNONuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiPtDWkd2mPE8fapkMsxld0z2Aji3a4xK9o/6RUtBskBD4nMyXl+aJ2SzXa7vQdyN/Oq8dtbxBC9TYMKaLSbl3A3Dfsx7qoytR2W5QlHiMw/8YaUMDK6GX7LcR4l2Pz6/gxISSsxmn9vkuYmeN6QQi1ilj5EfVbIbvZnejoEGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwpwAJ/5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c9563fafso1115766b3a.0;
        Sun, 25 May 2025 20:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748231053; x=1748835853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htvCi6uuNOWzZcOgJpXmmHAEHI9fgNT6X7zdhfaj3PE=;
        b=cwpwAJ/5rqUM3wbUvlOCkxVEEkoHFuD2ODaPDus/NGc3X4uhtz00i7OB438egfVLDA
         gsa9NAwTSjTYx4WDsfOE7llk7SZlYx3Ff/Zy8Mj5UfM4y9m0Y8LTe9z0RUf0ZapwN+LX
         +ni3BMp7TBHm0M5cSAqxgQEMCVLqXaDSvByQHTC+qvKV4ol92eLkz4+S/R2liq2rlIkC
         RzRoujYYgPfjqB3V0FSGTviOv6okojCd6DNGfGBcXjqOGoP4bbV2BVSdwvRILzEUY4aZ
         JD6ICZUjKWdS4ur4PwwepyAniE1J+93D6yGYTUO9r/n998aP/W4me8vlM75Brf70ltny
         PFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748231053; x=1748835853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htvCi6uuNOWzZcOgJpXmmHAEHI9fgNT6X7zdhfaj3PE=;
        b=u+WLg5pZ+aBIAL1lqRtIFbAUGuMfb13IxYkrej3z/6RgA1plbvverNKhqz1iJMVg/+
         s4ppMlVxqYVBVAPrgYfroaY8JNSqJnH5Mql0VT0rOx8XVRQDFytKxKHThjSCq+g+NTMF
         eyIo/04Wm7rRpa6fN9e/YdorscNzs+IPqNuGMpf0AarxRRtoIJby1032q9jCYu5ZCfE6
         S+sW00oMr89qPlJdZ32aWkr0X2LR1I9dxY6g9JaphV0uyuFY8OvWKMm1tZLMEpZb6rZ+
         HpL2td8X0hBpqi6wYxLoEcKYg3EVTRBFZzf3gfs608zCm1QZY/AJtiumaTFnAZedjLn8
         oV0g==
X-Forwarded-Encrypted: i=1; AJvYcCWMfV7JBEUIczKUKXJtJ1J4wjmGnyq8CtYFpx8H95kWTvgYCmCwPrEKUg8zxJsG+L4voiba3pOZoWw=@vger.kernel.org, AJvYcCXQFOzpUbC1f+NKdD3EFqwhoEQqsBY9IxPLsfj5M3047Qh9OOFZBIvC95+ytQqCEbNJ94oB/Nk4y/exENqm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4d5yRpN1tod48cHOXRIBQQpXV9dhXW19F3v6WUSbCWwpxKWsy
	tEBykRkKwn2m28DjSVh2GrfVRdtEOcc+/wBY7s6d3v8usvlgnskHZItb
X-Gm-Gg: ASbGncvJRfCdttQf+iDQVyX3gefW0U1YWJU1xl3TNVt1GpXIG6ZDeTAoT4hFdJk6r8x
	v+47LnknTyfs71KMp+Y9o+8KOqXihQtkkE4VA60IRR8W4UdFDdFnRjTKL/xOPaAzR1Qgq64jw8M
	TJOWdRlarg+5BeSXO06hhFJsT9SfaBDr6RHFlxIML6wehNKt3m1dDft7J+fTJR04hZPQgOsjOFS
	DMhEmiBEZuTK9aiRkct23qsvzg4Wi5SVdubwqPNLdJGumBiNFFPR0dYV/OZSRXbYjhEoaiHQkLA
	JFPM+z/eL7PmjX5n2yFoUL9wAJ0Jwn6M8b12j9KBXCNzFepnCsQ=
X-Google-Smtp-Source: AGHT+IH1rzKQ3uRvDiXLhHsn4C/DLNbrT3TXSTHqWN3OutTPGougKrRkJ91VElW4PWltG74RDIbOgA==
X-Received: by 2002:a05:6a00:a22:b0:742:a82b:abeb with SMTP id d2e1a72fcca58-745fdf3f47amr10589837b3a.2.1748231052719;
        Sun, 25 May 2025 20:44:12 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a985fad5sm16083813b3a.128.2025.05.25.20.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 20:44:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 001A74209E8A; Mon, 26 May 2025 10:44:09 +0700 (WIB)
Date: Mon, 26 May 2025 10:44:09 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/12] docs: iio: add ADXL313 accelerometer
Message-ID: <aDPjiVNuQyn1_zXc@archie.me>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
 <20250523223523.35218-13-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j9tiPdRZpVTOLhKB"
Content-Disposition: inline
In-Reply-To: <20250523223523.35218-13-l.rubusch@gmail.com>


--j9tiPdRZpVTOLhKB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 10:35:23PM +0000, Lothar Rubusch wrote:
> +A channel value can be read from its _raw attribute. The value returned =
is the
> +raw value as reported by the devices. To get the processed value of the =
channel,
> +apply the following formula:
> +
> +.. code-block:: bash
> +
> +        processed value =3D (_raw + _offset) * _scale

No syntax highlighting should be appropriate for this block.

> +Show accelerometer channels value:
> +
> +.. code-block:: bash
> +
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_raw
> +        2
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_y_raw
> +        -57
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_z_raw
> +        2
> +        root:/sys/bus/iio/devices/iio:device0> cat in_accel_scale
> +        0.009576806
> +

The accelerometer values will be:

> +- X-axis acceleration =3D in_accel_x_raw * in_accel_scale =3D 0.0191536 =
m/s^2
> +- Y-axis acceleration =3D in_accel_y_raw * in_accel_scale =3D -0.5458779=
 m/s^2
> +- Z-axis acceleration =3D in_accel_z_raw * in_accel_scale =3D 0.0191536 =
m/s^2
> +
> +Set calibration offset for accelerometer channels. Note, the calibration=
 will be
> +rounded according to the graduation of LSB units:

"Note that the calibration ..."

> +See ``Documentation/iio/iio_devbuf.rst`` for more information about how =
buffered
> +data is structured.
> +
> +4. IIO Interfacing Tools
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +See ``Documentation/iio/iio_tools.rst`` for the description of the avail=
able IIO

Do not inline docs cross-references to make them internal links.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--j9tiPdRZpVTOLhKB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaDPjhgAKCRD2uYlJVVFO
o8byAQDR4usG0Am2GHzc7SBtmAfdUgf+RErPAuqFskP/Ew3ZFQEA1+wwD5GEKyMp
6YBe4mfHIMPqzR8/lL5urL03q/y/xQo=
=S+Q9
-----END PGP SIGNATURE-----

--j9tiPdRZpVTOLhKB--

