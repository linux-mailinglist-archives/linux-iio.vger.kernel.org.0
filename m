Return-Path: <linux-iio+bounces-15426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B3A321A4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC00C161D21
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 09:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61772205AA3;
	Wed, 12 Feb 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1t7Pi5B5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B31E7C07
	for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350927; cv=none; b=FisVSEXNSHFKkl3JlAo86YldQr20Yo46iBySlC24nFYOc7d5e6qL2hEOKauQsoa5R5lxeS2Lu4Mxkr7KXxSNdF6TLona+o4m2S6OAc9EnHJEYgKo1KL6IQxfSY0Q1dOQwsg/0UKTxd3NOD9IywoJ6MDmJ28AXsJvHHpkGluraKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350927; c=relaxed/simple;
	bh=yufpUSB3cQfxXXCZohaV3c8pGZ4bFT6VGgxrw+pIX5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PElMlgfntN9jKH+pFP6iJ/Tkl/qOLB6ozHuk1p7WirLeKtlklEiuTa4YtvmwE1Px0X51IUVjMO/zhz/mM/We+35lBZw4n49CGUUkSP0iJFmNmjyEvYnuXsFmyYU21vPc/sgzvD548aH54erqgAT2z8Qb35qm3RR5y21Xzc2fToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1t7Pi5B5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4395578be70so14226285e9.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 01:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739350922; x=1739955722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKSOEF2rU9y4E+eXKvd5VslZfOYfruAhZpwgvcMYJaw=;
        b=1t7Pi5B54sB+6cCb+caVQ2cEFRHryN7CQl0U2kYyt4UdkY1yKu43A7+22grTWdylRk
         dP8cibO75gQdvr42PNrvBh2JUhPTJwyxIWOCIShqOQ4FZFk9cVTbWR7AhkrjKIpmU4z+
         a+oycYtmMxB0JKgneiVMJfKAkKahKwHRzw2oYACdHspshCjTdNP0JIcKnxGPic2pH4Rh
         +RSYK+W/SHYfoxKKckwlVH6fpFSyY2D8iR7iHNNrlCs2O4eS/Xp3GY/tlooZ+p3UUDNL
         RGF4Ap9yH6U8w3JXWoDK0XIxMA8auFFCYNujDmbVie276SAlEYgLcUklQPv49GQIX18E
         h+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739350922; x=1739955722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKSOEF2rU9y4E+eXKvd5VslZfOYfruAhZpwgvcMYJaw=;
        b=tLc2mBd45GU4eAjKq0/j5wBjmPoiX0W3zx9XsrjIauds+6Cy7PwZm03kOfEVAKr+hz
         dZjUWp8qVQUKyDKWrOgprt0TlXhf/hz0usSd5Rb379gK7YpzW/aG3ClYDEvX84KPCfx2
         IXMunyJzCqIee1rl2j+kp6wweSOipYNErcWmTZoV6RejvBJhdXMS1tE9JOF7lqB5AAgP
         py7yNApVm0FbwwCPIRs+tSBxKigilziEiUXM7qMkR3j5vldK338YaiJTXQObR5hZzCpf
         OI7FHE0X3WZ8APhcGmZJeuWoMrEbiwBa/TyrbT4jzFYJRng++avd4o+gXEP5V6wibHL3
         78Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXAZmat2Oso5JffyErw1u0rIf8OiwNt/Sd8sWIoMMHqYOo22SSBhh06TA7lJlTgJHNkVyH/HHB5oZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ09OGG8bRggqBbCkyJNsQrvi0L4DkgXUdC73tfOh8hyJ9w8S1
	vMDdWNonw8kxCYrI2zjgDR6/aXW0QKIkONMQs4B9+qu1iHAioCWXcZo8XQIIJ70=
X-Gm-Gg: ASbGncuQcEAIq9Utr49IKewY3f2GuCA+UgHWx2jzUxNPgOSbN03b9+18J188hpXlG5Z
	S48EoGNMqmT2K6VWHdybrCO1g6XBo2tGjthHFkuSxK9DH3i9Lpv+7sNKnn6c5UrSrcu+D7AmnMk
	AVqaJr54LB2XK2N63bOvH6LW3ldxUf2OqCSX/ScMziADz4CJMzk7cdwdvMFpWp/oiR/YPM3EpUb
	hw9akvnJ6P6JiD/IrIoXqUWEthkRcWaD6e1Lj3KdO7CsCcw+9pIhg6fnqSKAcWVeswqKNysqvi1
	yuIqppvNKsMSdhpnMi82XgtYVlv246sXmOm0HpPVWIGCSl8K1s8prea7dA==
X-Google-Smtp-Source: AGHT+IGjiQgNXQRPxbzwpbu+Mn6DkDION7kwFsM7opqGZSuRaX9H6zMBblZnEpfXsQLOvfIbn8/y0w==
X-Received: by 2002:a05:600c:3544:b0:439:57bb:2aa with SMTP id 5b1f17b1804b1-43958166727mr27532835e9.11.1739350921788;
        Wed, 12 Feb 2025 01:02:01 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7d2sm13326825e9.25.2025.02.12.01.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:02:01 -0800 (PST)
Date: Wed, 12 Feb 2025 10:01:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Michael Walle <michael@walle.cc>, Nuno Sa <nuno.sa@analog.com>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4130: Fix comparison of channel setups
Message-ID: <ewed75ppixxpbo4tgifnaqcbfp4gkqht6p42hx3usizs7zg5cl@mln2ul5fxrgk>
References: <cover.1738258777.git.u.kleine-koenig@baylibre.com>
 <584b8bae1ad158fc86bd1cd9bd3dcae54b58093e.1738258777.git.u.kleine-koenig@baylibre.com>
 <Z5vBj62990oPT0QK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqu6akjqupaopelr"
Content-Disposition: inline
In-Reply-To: <Z5vBj62990oPT0QK@smile.fi.intel.com>


--aqu6akjqupaopelr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] iio: adc: ad4130: Fix comparison of channel setups
MIME-Version: 1.0

On Thu, Jan 30, 2025 at 08:14:39PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 30, 2025 at 06:45:01PM +0100, Uwe Kleine-K=F6nig wrote:
>=20
> ...
>=20
> > +	BUILD_BUG_ON(sizeof(*a) !=3D
> > +		     sizeof(struct {
> > +				    unsigned int iout0_val;
> > +				    unsigned int iout1_val;
> > +				    unsigned int burnout;
> > +				    unsigned int pga;
> > +				    unsigned int fs;
> > +				    u32 ref_sel;
> > +				    enum ad4130_filter_mode filter_mode;
> > +				    bool ref_bufp;
> > +				    bool ref_bufm;
> > +			    }));
>=20
> Is I shuffle the fields (for whatever reason) this may give false positive
> warnings.

That's fine in by book. Whenever the struct is changed it's a good
opportunity to check if the cmp function needs adaption, too.

> I think this BUILD_BUG_ON() is unreliable and ugly looking
> (static_assert() won't help much here either), so on the second though I =
think
> it's better to simply add a comments in both places (here and near to the
> structure definition) to explain that these needs to be in sync.

The nice thing about BUILD_BUG_ON (or static assert) is that the
compiler quite reliably enforces the two being in sync. A comment
doesn't.

But I don't care much and can rework to use whatever pleases the
responsible guys.

Best regards
Uwe

--aqu6akjqupaopelr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmesY4QACgkQj4D7WH0S
/k417Af+J8LyYtehyFBfxI5yL04oA+fyy7FGSTiwnYMjUkb8OvE+FKxty+KMART3
eD5uLqFhVOiZEhtBL7SZU/6zmE9avxwYXgCbji6kaC1G69F7dTTyfQpDRHl7JZWa
SaG5QVRetZ4ipladHvbBCO4Y0D/WNNiMcEtpsM3HVWYeStD6I30QVRUlMDm15Fwu
2+vXwZTFU2q0qI4UmNt+QUwgw7eADY2kFFErsX5QEVv60LF8BXHEVbjlL/VoLRIz
HAnFoHJ97kOCdMQQV+iXc41s17PReFhBV1fKlKQ/lcF+0pmR3HqH1ZJj1bkHPb7p
59jZEU7vumnT25yTAaFkmaK9rvOVCg==
=FMsE
-----END PGP SIGNATURE-----

--aqu6akjqupaopelr--

