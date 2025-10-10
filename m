Return-Path: <linux-iio+bounces-24924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F6EBCE42D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 20:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392E93A31C5
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C9301014;
	Fri, 10 Oct 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E/WG3KLX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF820ADD6
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121322; cv=none; b=o4tk0K5WU+RQjeEd8KAdV8Na+1Yiik4v4tESbvTz5zvu8GzebAXlNWSGBCcu2BwREwcKQMHysL/ftSbSBthVOPm8xpTKf1H8S9csptCGsMjp8zE6W8Vxy35fKyAW3aLTEB+cCQKc++mcuhHnZKTBFBtlCPoq+FcaCTJeLls3kHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121322; c=relaxed/simple;
	bh=IrzJLT9iyeL7qYoWDmAzmwyBYco3e2Fyxa2T/fvYmP4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFFWkUYcigOJUQxSXnKv9qZF6LkgX1FbfpVFJXSkbbeQJsNL4Mgclfc1bjl62y9azKomjVq5KZqGnfJLwCU1sd2dgO3fljoXr6ymXh+lKCoc7o+vVRc1e/tIrYKncwDE9aJHm+kzE5GhZ6JZqTMRsVpRCjuyjfDzAf0un2E9RM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E/WG3KLX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso5007051a12.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760121319; x=1760726119; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrzJLT9iyeL7qYoWDmAzmwyBYco3e2Fyxa2T/fvYmP4=;
        b=E/WG3KLX0mo3giyPY++00P2RakGgXok8Qwyqobrs37EcK0+AB9pUZ92/CHlIeGSGIz
         oIt6XG81tH2F89ebXAoTzI9ZWjXfiLT1Oji7ysql0oxi+pCbihdbB4JjYaUHKF2eSLlh
         V0pQDFY75HvTXrsM2n6G8CsjrR5C1ScKh2i+bvZbShhbcC5HLHZpwlI3ap7PLTSlxRhy
         9Yo7lkhSn1IUtKYNTqyuduEJnNmz3Nj2HCzzlFU6zIROnkwt5mUjeQ9P3eW2iumzL04h
         NJ7aPfhl0h0C/p9eTC16SpLozzFL8o+NlSytZNLWzZJvpsB5yv4zBf+C3eHm7caO+LmK
         UCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760121319; x=1760726119;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IrzJLT9iyeL7qYoWDmAzmwyBYco3e2Fyxa2T/fvYmP4=;
        b=bl3p2Y3/sfJ6N0R4amlqRzx2ScYWBXoxfe1mMR5u+CDBOOLZt5Rwol1UuJNfP7fd3C
         0C/+zOUFRMAnN9NepcIlRUqq4lw5L7pMnzkuTBNXQpT3e1Qp3sV2jQRJZm31xa8/C7Zs
         x5cX0L0BHuwefYU7bDmkIwZWfEdBP0BtSyz+gxVlQh+s0Ayj+BcgI+L9RCC7CQtGMFpR
         yo6jJSx64xgcKE7LjqZTY+v+BJ4+IpaALOEh78GnhbDlcLPi4p7clwIhwPBs3q0exuGM
         RicUrjdRP60NrVmVCxUPJqwHANW2TDpTsGILEuVecaiUq8WQtAJyi/naLgpUxCA0xUGg
         URAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSVNNxPgFgGTbFA1+83xJC+iI8HSnP7rFmoGAz6RjflL3kY0avbNc6YR0qhyH8KF0mQlw5ImJD1GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2j6skZaMHjXf9W+qKqr5foBzPwB+qj+ebNyYjaV0pS0jZVMc
	Cmijvzyx1UbZnCgrVYott3kRdhhTzNQs+LF9gNhRZE0Qovcd7uQiLOJHsoU1cJ0LJRg=
X-Gm-Gg: ASbGncsFYx4eurEcFpplHEy7pbC14O+y53DZVhA1ug4xfdSfp0MrQCSZqKLQA/DWAxI
	xjXcaDnBihQ7WNpK7SIJzRG99mtixi0jixHswelYOQ7mJ+O3tONI9KfCOPV1tvGkDz0WXydZqEF
	FawYM5NZAKPWQU9Plt8EqrIwJKN5o5xk4ldfLxE9z8NM9diBFXXHkvaBDP5rkOLnoItOiSJqY73
	ZDl4ilgBcqVRsGvSkRUKc7uZjXCzTaBza9kUR83iDpBLK8LVmE+yOvM1Yw26H2qoxT26hypqCAk
	J76KFVbBOjqPaUYP7ssV+X+PpTqbam17niS7YdwRmxRaUv7f8ncXVHlgCOR1LtkY/XgIQqtvIcE
	UNv2Idlre12+EKH7qbJrcTyhPysTdLmTw4c6OZqlL1Iin/H8TOlI6QHLpEV/GJfGxjQwIFmKTIl
	DgXg6eqFQ=
X-Google-Smtp-Source: AGHT+IFfvfcLY9EpH48b8KUoBKLc3ABghjOCvKmqW+GJKDAY8JIvC48/YhBRUDCQtcjEqLdQEiiFDg==
X-Received: by 2002:aa7:c54d:0:b0:639:7781:ea20 with SMTP id 4fb4d7f45d1cf-639d5b807bfmr8070467a12.11.1760121318814;
        Fri, 10 Oct 2025 11:35:18 -0700 (PDT)
Received: from [10.203.83.193] (mob-176-247-62-200.net.vodafone.it. [176.247.62.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c1348b2sm2872205a12.37.2025.10.10.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 11:35:18 -0700 (PDT)
Message-ID: <2039f9bfcadfd9189ecf84b780e1e5542aa0a4a1.camel@baylibre.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Lorenzo Bianconi
	 <lorenzo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 20:35:07 +0200
In-Reply-To: <CAHp75Vd8MmDXm_OPooHC3B+HdHoTn-TvGbRg-C3-gjNSZQoU7Q@mail.gmail.com>
References: <20251009173609.992452-1-flavra@baylibre.com>
	 <20251009173609.992452-3-flavra@baylibre.com> <aOg3dg21aWNTF47x@lore-desk>
	 <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
	 <aOjAK9LRMCcBspkb@lore-desk>
	 <9dbd2ae7883ec8dba65706603a29f3144076840e.camel@baylibre.com>
	 <aOkG-jBOYXxWy1z3@lore-desk>
	 <007e87d2-92f5-417a-a6bf-1babd4c60c61@baylibre.com>
	 <aOkysKyWX2hYEnED@lore-desk>
	 <CAHp75Vd8MmDXm_OPooHC3B+HdHoTn-TvGbRg-C3-gjNSZQoU7Q@mail.gmail.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ZugHdSKtu42cytraGbrO"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ZugHdSKtu42cytraGbrO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 19:23 +0300, Andy Shevchenko wrote:
> On Fri, Oct 10, 2025 at 7:22=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.=
org>
> wrote:
> > On Oct 10, David Lechner wrote:
> > > On 10/10/25 8:15 AM, Lorenzo Bianconi wrote:
>=20
> ...
>=20
> > > In the IIO subsystem, we prefer to include the units in the variable/
> > > field name as well, e.g. hw_fifo_odr_mHz.
> >=20
> > ack, but please avoid camel case :)
>=20
> Don't mix up a camel case with units.
> Or do you have a way to distinguish milli from mega, please?

OK, I will use hwfifo_odr_mHz

--=-ZugHdSKtu42cytraGbrO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmjpUdsACgkQ7fE7c86U
Nl9GAQwAolP2iIbwn+F+PHxtffg9p4cZFn2qiRdUxAOOjGAbO9iRWPP2VPQqf9Kd
1RNFbKjgT1ELCIYLTqMYa08skUgN5SUUmyv1C6W3fe5KswRk2s0GBq0T9Q6ZdSqJ
k+qdSdlCxiFJoG4JXwb24F00F41yftsnExjQ6pswy8Wp9xHwyf8g+uza2gaU31ie
JYgnRBa6dip+mM6oib6J/epjeV2Gwn/RNViQuQj5ucmALw0NlL4YPnF+M1Ts/RTx
Vzr64aWsq9YjxwunC4gxrqFtXQnfBs9cZEtHWYzdew8OHNUfpw7RpLYpxA5wPuKl
K/VpNAJgjZ3nD5zFiPP1YMvvaDEeWusM4CQGz/gOurGpahYfDT/pKNjl171Kd+bL
UZq9WbbU67eqO582A1oc1b2t4UxGywthCpDoSmejdNMYEJZE4+ZwU3w6SUvCoAe+
5mMtrFsE12q+doUKc6s/YBXpCp4PSviDXSPm9XkUu3oDljc0dQs1xzFgt6kWP3mG
IntWiwqc
=2k7z
-----END PGP SIGNATURE-----

--=-ZugHdSKtu42cytraGbrO--

