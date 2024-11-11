Return-Path: <linux-iio+bounces-12118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7F99C3DFB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 13:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AED1F2216E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 12:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114AB19AD93;
	Mon, 11 Nov 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B2A3pUY4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE655C29
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326934; cv=none; b=dWvQeZHMXZi1XLFhjAry7OOfZPAA0Ywz8ukLvlbXtWb9Hrc0CfpCpiQAMAA5a22e5i0KuVkq5tzZ72C/TcZkAMPITLIKJs5evj0vHFkL7WT+hI1MA7F6aHQ4bkSfQG21qoehSTfah3n6ATrPFQnKr7NXDleugW/MrNB/3nEByf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326934; c=relaxed/simple;
	bh=zizQgxUJjUFrPYu/U95nAIDgqBgMs8uy7LcYBXmA8Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O23nNO8/C93bg+ZNEXcGdtufwWu985Flfkw9HUmLHyR9tS21fKrfBGzi+g2r47ITULU5WmJ0zPg2hFcskyZ4IenBTPve3Rzrl/oZlonASg5mrGxiWNRgI8PZBVdmuqeAx4WaD4GhDsVSzA73i3O9jgD9zgsfN9J4zYhJZdOUJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B2A3pUY4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so36124825e9.0
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 04:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731326930; x=1731931730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zizQgxUJjUFrPYu/U95nAIDgqBgMs8uy7LcYBXmA8Hg=;
        b=B2A3pUY4RTH0z5k4LtZuBVQU5bVNdW7ksm6fxZdDHUgG/B1SCIid5hDCFXn+wmX9ko
         RwqFx9WHbmCp1sMgWgmH/wrft5IaT6Ot2h+Jsg7/FEmWern99iC2Zw5L12Iq8FBibq4N
         NdgXCqawbGqEpZN/ZUhQBc4veuHMrhUDUdTNG8H7fYgy0agC4FdUMYAzblQIYGgpgiXM
         iCzVa9sh4wkiZWkEPHLB1cTqDRZ/q7RkZq0yK2uTarVPpjdNZar+ZyP2dSnuvhytVKZo
         8GYD6MvAg53gmQcw8MjxSsVt8XPgTiEnDgQyWBigPEpiQ/SHz+z2Ubb56sRqh/RJ/bbX
         RkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731326930; x=1731931730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zizQgxUJjUFrPYu/U95nAIDgqBgMs8uy7LcYBXmA8Hg=;
        b=Ax6dsyiv8J3pucHPoJgHAc6xkgLQB988JI+g1YEPHkRIhrgcm3r111Iz5bU2hlXGm4
         u9/YFhz3pZTuH5vzkfGS8iroG9N0UcsUTvlTyks9U+7SqEuwc2HNbISNYwJY6e98KplM
         hwSBMdq0uq9gOA3HX7xNVKNgv4O7a1azgZozuFHR2NKLY+S1+nkJBhj62PSHnuAZa+Z4
         hFDgbet8k573XVqjohJNLPFVC9vcv7NQzCgWOuV7vtI1brpBVx24j1Iv+t1SM3H3RQkf
         0ml/3HnP5hwEydEAokxg5Z6n2s/p2qm8OCDGKyfm7dkGwjE/3ezyiSp/o+NzoIQ5f4dJ
         MBVg==
X-Forwarded-Encrypted: i=1; AJvYcCWYQpsCuhZ70dKMzo/h6VNBJmyMTByn4GF4hA/TQ3MRvfpNeFlL+AAdUZBUcuMvLfOpIZDyxsT0JMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSpcWA4J+ay+IDBi/69wtzLHt0/2EADUlvLNAgY+dKCi676lu
	M2bDvJZAHTZs+5w8jz1hh+pXcnzU8Ay7T5Xt4U5oBi3i3Kun3QNUH280cmd+jkM=
X-Google-Smtp-Source: AGHT+IESb2lgi5llcF/0yneUYuBGSTFn5srS4ez8tf3me+ouGpBVRxiy7S3mll8POcwSSd1avTopZw==
X-Received: by 2002:a5d:6482:0:b0:37d:4517:acdb with SMTP id ffacd0b85a97d-381f172a860mr11659759f8f.20.1731326930553;
        Mon, 11 Nov 2024 04:08:50 -0800 (PST)
Received: from localhost (p200300f65f28bb0063ffae39110fa2df.dip0.t-ipconnect.de. [2003:f6:5f28:bb00:63ff:ae39:110f:a2df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97cd97sm12694879f8f.27.2024.11.11.04.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 04:08:50 -0800 (PST)
Date: Mon, 11 Nov 2024 13:08:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad7124: Don't create more channels than
 the hardware is capable of
Message-ID: <c2mdg4pn5rgjdlwet2gmgqvmym36ttlyg5ag2u62a3qtkdwqce@p45gyz5ghgel>
References: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
 <20241108181813.272593-5-u.kleine-koenig@baylibre.com>
 <c94271b1-924b-4de6-b3bb-77e16265bb0d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gi7kmm2hjevdp2sm"
Content-Disposition: inline
In-Reply-To: <c94271b1-924b-4de6-b3bb-77e16265bb0d@baylibre.com>


--gi7kmm2hjevdp2sm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] iio: adc: ad7124: Don't create more channels than
 the hardware is capable of
MIME-Version: 1.0

[dropped Mircea Caprioru from Cc: as their address bounces.]

Hello David,

On Fri, Nov 08, 2024 at 12:52:35PM -0600, David Lechner wrote:
> On 11/8/24 12:18 PM, Uwe Kleine-K=F6nig wrote:
> > The ad7124-4 and ad7124-8 both support 16 channel registers. Don't
> > accept more (logical) channels from dt than that.
>=20
> Why should the devicetree be limited by the number of channel
> registers? Channel registers are a resource than can be
> dynamically assigned, so it doesn't seem like the devicetree
> should be specifying that assignment.

Note the device tree isn't limited as I didn't adapt the binding. It's
just that the driver doesn't bind if too many channels are specified.
And while your statement about the channels being a dynamic resource is
right, currently the driver doesn't cope and allocates resources
statically, and happily assumes there is a CHANNEL_16 register if the
device tree specifies 17 (or more) logical channels and writes to
CONFIG_0 then which very likely results in strange effects.

So as long as the driver doesn't implement this (possible) dynamic
mapping to the CHANNEL registers, it's IMHO right to refuse to bind (or
alternatively only use the 16 first logical channels).

Best regards
Uwe

--gi7kmm2hjevdp2sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcx884ACgkQj4D7WH0S
/k5H9QgAp/z9QnQ+sHCZdd1yNdGqXRp99Z5F8+7pq9w0DDblAy098aK0u2OOhbg0
+Ts38CwizZ6LrPTuYfpkkPPH+03i5ZKb2vFdJSLgPVJve2kwSxELpu6S4oR+p1nh
5a9O9xou5u1cXL9R39df4I98zdPaz+CKM430/iJFhzcPDqkC7PyqTgia9l7QWVSG
T2W/cIEBXyoH/SJcLt53hGi7ZXetbXA8Zp9RM6ZZJ1szBtB4SoHcRVslT1tMDk2q
jd2hiHWOu6DrZvMb5F26Oq2vL9uv4cM8eBiT3EzsufW5aeo5CB6DMdacorsQjKEe
PlFARzxFj/M59Df0ctC6uNQllbe8Aw==
=LIet
-----END PGP SIGNATURE-----

--gi7kmm2hjevdp2sm--

