Return-Path: <linux-iio+bounces-24896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5DEBCC566
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 11:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA2F74E626E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE79126A0D0;
	Fri, 10 Oct 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i0gDFPxO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8F137932
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088510; cv=none; b=qW73ZQ4YW+jXja2+jeNB3FQ3c2/pit9gUsyqW+d3Xg7WFOVZ0QQl2LNOqLP1x0+eHQ0TG6dR4Vm7wl9Agre6KIs74z7CrBlzKgESreEcUbrMFsKPAxdNsdCTZoz1lo4I6pzbqW9hUvPkba/hY0hcAtPjEosXJzaaMwOn/JqdTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088510; c=relaxed/simple;
	bh=JDp5TiTDat0XossLeHCzjbP6G43RKmRxExMuYQH5fpo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X54B+w8PNYk3/ehiYEw8VXv6cz34WIkbFBHs3xjJdWPM060jbfnib+70NsBsAChkm+EslWgvBUCoBu6dWigp2Z/Tl37tltVb3sl+2LLegO1SgoGP/RvlBgQYDwnCnRdisGo2AtcmBJ1CfaA0omAlVdWPPPWlb5ChbVqh3j4b33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i0gDFPxO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-637e74e9104so2465850a12.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760088507; x=1760693307; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDp5TiTDat0XossLeHCzjbP6G43RKmRxExMuYQH5fpo=;
        b=i0gDFPxOs13rD9FQd0M7Tzb820V+5UdqwewWDr3/lEfUQsFjk4DJbLUYIqK7hl8e/k
         8x8oe4d0XMLZfvGh9um5i0bzq+hXGl+LX2sWcW3sIPVQ/uGowcg428KVa9hX9HMKuuWX
         aVB8uj52YQYSy1p3GjPiPepOgEVH/hutCvMT9qUBbuX1hZN1vQ+Qw2pGk5nxiMJ8k2jx
         Yn7dsYxjESa8mmMCovl7qIcPqzGMFhBcoMn/mIZvM6yiT0Aflfsed6GrLN9Rz2gJJgH1
         TOxewWaROhsGySRuEBaub5q9oCvwpc/jkvOc0dLD6dzZSEo5adiVNlCxLK2UW/tSBmE9
         UX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088507; x=1760693307;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JDp5TiTDat0XossLeHCzjbP6G43RKmRxExMuYQH5fpo=;
        b=lqWDnHBDbUXlCrBl0DnFmN0XQ6TN4yIloTKSAwpsa3qLxg0ubQmrbNuZ6rdTCL1VMt
         CUWJ94YETvNSAvlzypeWybd97VotONegW0nWcVQHRjgZoRUPAKv034/bqNx9FDFoSCnm
         wURVhPhVoxywhT3GtGDvgN79a+e8dSON+Koc1su4IR9LuFS5Xf2FyI+jXUnhUeC/HhbA
         Y+G54jgzzs3f6oDsHiRbgsj4sMugHu0Sp+JV5aHdFPaB8wPI6c6aVe57P1JGqvsxst85
         7JJUxsv0dw730TCw31UIqTh9Qk5l3v8fSBF/N2N2v2RsfJ77shEfxXXCHTA2FjRvXl9V
         thFw==
X-Forwarded-Encrypted: i=1; AJvYcCUHheNADT0kzezLHf2ZTo6QW2TrfndtG2CnAPekl9O2BPtYvHyEvVmacigfjnK/TC2MqqCAECtkE2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyszRpkkO045o0OQkUu8aLwPKR2cPvPro4ka93zqom+fYQVfv
	ELbYKKSTu8989ghNf80Akwg61XHfhZaGByJAIss9+5e21EuCrKwRZqHRBHdRVQ9HOFM=
X-Gm-Gg: ASbGncu9nf05AlZILVHcsu+57oHn73rQyUZxq/0f/pRAZ7NnU1gdoj37rWhDEOSb+vE
	GIbWHFWGZZIz9ccgKkK8CVJ00I0Bdpc/OkyOt8od5NTXRxkehbLeu5XN2HQjXIB7DZSHeJmBpUZ
	PN3i3x31atW8h2x3kG6tiN0Pv3XCzkz5LhDffMXk/GOM7xYoO2M+nvW/QxTuUtV8sV6xvWbNHlE
	91yEgV/Z6N1zUQXyxpWW3pUhAgz/eHGXfqTGmMqM0ZMKvbipUZFHjnqagdhKEfw3tw5xmDPKYcn
	W9TGzJcRVXTDOEZqaQsVqDe/97s1rqQ1mVm0c5f452XOg6WobiXsNPLl+5BjJXTFzdPaBPjMNpl
	QvgD6JteLRB4ajbzAoX9FeJUGe0LN1NIHJFcZ714BEKPoiAs=
X-Google-Smtp-Source: AGHT+IFBNd6rbJqvm422etFRXtrB6xH60PfBEB6fumYCUg0VG+zA6fdmwsUkfn/iR22sIpStELm6yg==
X-Received: by 2002:a05:6402:1467:b0:63b:6b46:a494 with SMTP id 4fb4d7f45d1cf-63b6b46b51dmr105590a12.14.1760088506614;
        Fri, 10 Oct 2025 02:28:26 -0700 (PDT)
Received: from [10.203.83.184] ([151.35.133.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b71361sm2065143a12.28.2025.10.10.02.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:28:25 -0700 (PDT)
Message-ID: <9dbd2ae7883ec8dba65706603a29f3144076840e.camel@baylibre.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 11:28:19 +0200
In-Reply-To: <aOjAK9LRMCcBspkb@lore-desk>
References: <20251009173609.992452-1-flavra@baylibre.com>
	 <20251009173609.992452-3-flavra@baylibre.com> <aOg3dg21aWNTF47x@lore-desk>
	 <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
	 <aOjAK9LRMCcBspkb@lore-desk>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-5fS5IDHJpbjdJIp+o2Di"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-5fS5IDHJpbjdJIp+o2Di
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 10:13 +0200, Lorenzo Bianconi wrote:
> > On Fri, 2025-10-10 at 00:30 +0200, Lorenzo Bianconi wrote:
> > > > The rate at which accelerometer or gyroscope sensor samples are fed
> > > > to the hardware FIFO (batch data rate, or BDR) does not have to
> > > > coincide with the sensor sampling frequency (output data rate, or
> > > > ODR); the only requirement is for the BDR to not be greater than
> > > > the ODR. Having a BDR lower than the ODR is useful in cases where
> > > > an application requires a high sampling rate for accurate detection
> > > > of motion events (e.g. wakeup events), but wants to read sensor
> > > > sample values from the device buffer at a lower data rate.
> > >=20
> > > can you please provide more details here? Are you using the hw fifo
> > > to
> > > read
> > > data? If we configure the hw fifo according to the BDR (even assuming
> > > the
> > > watermark is set 1) the hw will generate interrupts according to the
> > > BDR
> > > (bdr < odr).
> >=20
> > Yes, I'm using the hw fifo to read data. The use case is to enable
> > event
> > detection (which works best at high sampling rates) and sensor data
> > streaming at the same time, without requiring the data stream to be at
> > the
> > same rate as the sensor sampling rate. So the amount of I2C (or SPI)
> > traffic (as well as the rate of periodic interrupts) required by the
> > data
> > stream is kept to a minimum without sacrificing the accuracy of event
> > detection.
>=20
> I guess you can get the same result (reduce sensor data interrupt rate
> keeping high odr value) configuring the hw fifo watermark.
> Does it work for you?

Setting the hw fifo watermark to a high value reduces the rate of
interrupts, but doesn't do much to reduce the amount of I2C traffic, so the
issue would still be there.

--=-5fS5IDHJpbjdJIp+o2Di
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmjo0bMACgkQ7fE7c86U
Nl9W9gwAm+3ymRu3ykadpSHWP//LrwzQgca8gmh0F8U/J1pSdd1FmkFvR73H9Jpv
iaaLh94D7fwBKWm6uWN8tP8oocIpY2SoHpbVNEN4SwEtOMz2Ra8cFotcAuqO6Cwg
OoQ1AtTjLAFFfkPIEd4g/t2p4MB+nd53XaINcDql28YtrBGOPwy8Mw0saKLD3eI6
NmHzi5nD28mEMDWc8/vqcIdyt2bXH7S39pNFt6r+zuIKl0UEA3e1aj68MRo6X+Z/
BLApwP6gmDB0Zz8EuLgKuiJvlAkn78q8bO9eiGaSlL0yf+PkUNjxmYuCfwk0dRPW
je0SvEVWJ2ENqBb70KfVE/d0/P6JiaVaSQRFI+wc1IcVce8yuKe3cYkGg0E1DLVX
Rzd2qSi47SJYQX5vQWZoneMT3RAYn1Rd7MjJ2ZH4kH+tmZAP9gqpzx8mnxszjBst
zR3Q3joZzh989MW+jZJeaYgTy5Zl4PuKqRf/hexTZNrxV2uYkImwK/dQ+9CS0INE
JhNJS80O
=kEZy
-----END PGP SIGNATURE-----

--=-5fS5IDHJpbjdJIp+o2Di--

