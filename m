Return-Path: <linux-iio+bounces-15825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6446AA3D32C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313E23A7F0B
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A751EB19A;
	Thu, 20 Feb 2025 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl+bv8Gg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED7B1A7264;
	Thu, 20 Feb 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040164; cv=none; b=lOQ2yCMio3Ew2ve2UwkK1M0ljpdXGwupgn8DQLD4plG5c9aBdWApXvUssNrLqX8RqYllKota8i9q7knlWmZ5va0HC70WSnfsTs7lTGZw8rm0IbISBEAAN8ikmkggpizCKohqCKeVNglMOTmY31dnHI/IryUau6MsDLmVy6bsWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040164; c=relaxed/simple;
	bh=80cf8zlzFwBqoh821Ay6AOl2kStY62G7PZJrZaBE1w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7Aizzo025AwUf+sjSP0KasWQph8KmD1WtBm+hPhqRYuktxAst4y8g9Sxc9OR1ryoedGlWs9hJSxt+sA32L4BwiIHkELc5ppVZ13/vGuGNb5r/YOirQjeq2S34wrOQT7+IOP0e/iPrOlG5iB1zXfCh2HCcb3AR6CrGzFm4uKH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl+bv8Gg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c8f38febso11584885ad.2;
        Thu, 20 Feb 2025 00:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040162; x=1740644962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F56dqNOXtbjyXTzhGsxb0Jrv3YT4/cs1TT3uTV3uBp0=;
        b=gl+bv8GgRzze0pcM0U4Tlfj9GkliBlC/cXt5H9PVx5jCcqKVvU3LO9GsL3sKRxTDSq
         IOIMJ4aXZF1vG9B9eBYMVW29uMAi5HP5DokL19JcdcAg5nLYu1uaZlHwfmAg4jPOSMCR
         Gmu86JAJZ42wsW8Tv2+vYiXjPUlHj89tCaD+6dCaalXr5a9gZo2VGtnc20CilRAeHDrE
         UdOltKrl/T4SbeRMpR15/BKf296sfh4KW2DX849LuesYbY6oYlbv/GEurBPmIWsTLpQJ
         3bJ6YjBRjUjNCxBFRGxACiKAAb2FFjnTgWTy0RkYnr5ONfDfELRyUPtgWQ0/61wQWZk3
         ZkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040162; x=1740644962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F56dqNOXtbjyXTzhGsxb0Jrv3YT4/cs1TT3uTV3uBp0=;
        b=PNdnbrLklP8rYBQE03E9GTBqMqQK5ru0qJ/a53Xm/IXSZ/PBnvIypTdL8wkb8aJBYu
         ak+LANAlHi1IL8hcmW9QnosG4b9uoThfFLjD03veWcsmBGIY5MRltFdKMrhV+7uAKH/X
         JfxJacyg1K2lLziSOGTF5mhg5AnXmX6vgFHWVL75ajQ/qmWKFMPAD4GtZvxQ3oXdrDm/
         2WSEvNjv18gwEPUcPgkaqg57lBteaFeElX36SvqC/8/Flt2fVTV9BSxjKRVzvdC+0KM7
         iTwD71lhiD393s5bV/uv/JieAakvNQUbp1zBIoRZgiROU4LkFJHjKhhyMuTZJKG43RHm
         K+6g==
X-Forwarded-Encrypted: i=1; AJvYcCVyqBI147iTC4C9cneBgqWhFYHDzlEsNWviL7AcUEWtoF0m2Srbb4rwtGNU6Xv4ZfHEIsI0cz5/prvSoO1M@vger.kernel.org, AJvYcCWdf6oiJKSzyLfdNwg5dWcSagBkzrCIN4ALTzmll8NzIq6vNjhAveygbarF5qJcEFtVGyS8K2mCLUKf@vger.kernel.org, AJvYcCWjalGba73DTVFwYu2VVKZGNV4vgipKTfTu+MvlWUXyT8k/NJ0aAbQw/T4ilpFDu8G+MMJa4pHGOtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCgnV0qOkGbWJ7u8xHof2AISi0wClwtSGXz3mg8seyWHEPdjhl
	35/iFveIm9dc4yfMg7+K3ybojNdmdifp4Fds6V0IQnLNmBqU8znY
X-Gm-Gg: ASbGncsu65TxpLfuRFI8rBBQYXNNjcfIciSYNbcQbCO831nlA0J35tcRbRpnZHB5ytJ
	YZQyJj+nd7epVq9G8hM0waXnfvDi+vJ+N6CkU6nYZ+pwHjbqAaX5GXvJAxgXuxsofPmO0f6f+np
	B+Uu/FMukipn9fs5OyyHq5RFgo8BeuDMhB5ddnBomzWnS+Jb25gPZ4N47uJdh3mVvsa0adsRgXM
	gEVdVd0nyMjz1tn5YgyNl6INK40Jxw2vUzRPFRdBe+DacNSmCjqImdYMkqwkEOnT1EmlmogM2un
	ws1LI4ZgYORQVe4=
X-Google-Smtp-Source: AGHT+IEFoRMxUuPJ5Gn8TKY4GqpAz7yGpt5G5frKd4twOqJcw5bSWSYR4ZnKTlEykRD6+ahXb9c8GA==
X-Received: by 2002:a05:6a00:190e:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-73417248c3emr2609762b3a.4.1740040161695;
        Thu, 20 Feb 2025 00:29:21 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732532ce7f1sm11296452b3a.73.2025.02.20.00.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:29:20 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B98EA4208FB6; Thu, 20 Feb 2025 15:29:17 +0700 (WIB)
Date: Thu, 20 Feb 2025 15:29:17 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, corbet@lwn.net,
	dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 1/1] Documentation: iio: Add ADC documentation
Message-ID: <Z7bn3TEC4faXbzEj@archie.me>
References: <e6ac2a595f06ba2d5ff0eb86e5895479c9dd797f.1739998491.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fA1JDFFS27HEYYIl"
Content-Disposition: inline
In-Reply-To: <e6ac2a595f06ba2d5ff0eb86e5895479c9dd797f.1739998491.git.marcelo.schmitt@analog.com>


--fA1JDFFS27HEYYIl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 06:00:56PM -0300, Marcelo Schmitt wrote:
> +For a **single-ended bipolar** channel, the analog voltage input can go =
=66rom
> +-VREF to +VREF (where -VREF is the voltage reference that has the lower
> +electrical potential while +VREF is the reference with the higher one). =
Some ADC
> +chips derive the lower reference from +VREF, others get it from a separa=
te
                                                  "... obtain it ..."
> +input. Often, +VREF and -VREF are symmetric but they don't need to be so=
=2E When
> +-VREF is lower than system ground, these inputs are also called single-e=
nded
> +true bipolar. Also, while there is a relevant difference between bipolar=
 and
> +true bipolar from the electrical perspective, IIO makes no explicit dist=
inction
> +between them.
> +
> <snipped>...
> +In the ADC driver, ``differential =3D 1`` is set into ``struct iio_chan_=
spec`` for
> +the channel. Even though, there are three general input types, ``differe=
ntial``
> +is only used to distinguish between differential and not differential (e=
ither
                                                   "... non-differential ..=
=2E"
> +single-ended or pseudo-differential) input types. See
> +``include/linux/iio/iio.h`` for more information.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--fA1JDFFS27HEYYIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ7bn3QAKCRD2uYlJVVFO
o8LZAQCJ0CV0EgB3xzpRqTrsSdpxkbgQtEVnJBOYnClg5YanjwD9EJheU0XodKN1
1i648/jd8fjfBIgI+eEMegqo/YXBqA4=
=fjkf
-----END PGP SIGNATURE-----

--fA1JDFFS27HEYYIl--

