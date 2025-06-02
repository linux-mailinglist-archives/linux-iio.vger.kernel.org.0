Return-Path: <linux-iio+bounces-20119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F4ACA806
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 03:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3770E188DEBD
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 01:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1E51DE2CC;
	Mon,  2 Jun 2025 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxwJOY9D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8F13CA9C;
	Mon,  2 Jun 2025 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748826465; cv=none; b=nkwkMQS8ZGm3IZky/+KiPqCf+UqaZ2miLfzXaarsuRGktBOnZaAsZPOEH8hWftgULXafFqb/+lwBIdyEJUNclIKivK0oKPr89CNYFqluCNOQwhugmBp4npn2zlhm6hbuD9UrzTAWXxnTZ5mM/fQDkcNrKZ6yzs/Y1gfbCh0Ece4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748826465; c=relaxed/simple;
	bh=ohT+GGMz1TapD7ECEIgLcHGsU3rXUF8SnYQeTpXonL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8SwaAu3/YIYmBOz2tu8QU2agsep7pzyyzkNO+XwKp1YK8oLhcfkLkzOkWfykojVSFG06rjIh6cHbTvOReomGSg+mahi3EOoXphqmWe4vV7gQQ4NZp0OCrKVPEF8ay2rRf/sC2yslI5iaTPwM0oFcdQCdFtnfwyph1eHIP+kF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxwJOY9D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2349282084bso47024765ad.1;
        Sun, 01 Jun 2025 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748826463; x=1749431263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohT+GGMz1TapD7ECEIgLcHGsU3rXUF8SnYQeTpXonL0=;
        b=WxwJOY9DYVhNakjzi5DUTdDsUYZRW3ahgqVNtYdWg2cnUQRoQHxrY0i21/kn4Zg/HQ
         0YRsW9qU0Q/yZTT1z9vuNsxMP1gpyKULbGCBs6+Cku4hQ0bGJ8KbNziqPMsTprPoIm7X
         i4H+BRr4E4s3ENDPYZFNRc0piLphOLFBwEU0DpX6x0RgVE+cjoWkspw/K2mWtbLAozMC
         XFXclSnzoZoD2sRy9qd0/z/sgKNKX+b5NtRIfQgXgg/d/9ilHmxejyWBAnsrdKvXQMe4
         ag7voGeDT0seGl+e5xgJCJz2bUn7XzSGWLDQ2qkywHvflBDJiuKZZCm+bOJIbJSljsby
         mXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748826463; x=1749431263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohT+GGMz1TapD7ECEIgLcHGsU3rXUF8SnYQeTpXonL0=;
        b=jv3VjWJC9wj1V13stG8G7Fzb84WSQPQSJ3TWkrKy2PSXG7uRSyXtzRfG47TV6KopSt
         weUMkm1hi2s1crumGu//nKi46bz3NaTp6THWr/QpMeqCAHEMNiaLUPjrSxyhsBjYNdcF
         eQFjAryXdT5SDcEy5BAUQkH+YRcur3ss5q0yxkHQuqZ93ZYdPBTZEqt5rFad/pyAoMs2
         +pDuQBLI0SGZY/WOqXjWyR0SEEJxypFBmwjUtwou7bKWPHbXvsrBHHv88Fiuq6bPlA84
         BHMsJaa/qYccUyCEPREUsviqmEpQdTHye8nYz8gKk9xQjuPpWQ/B/YCqjCWMUVPS8Elb
         4aMA==
X-Forwarded-Encrypted: i=1; AJvYcCW2LugHtN1rmFWp6xcr2ZDXd+er/exp81hhV5gt9/m++saxv9zf8lzd0C4UPEgF308ixDJTndCxFbfRjkKZ@vger.kernel.org, AJvYcCW3jHAkGRRZMHG9cDRIH3Tc2AG46umy+jYScrCoVNqkzwwQn7ga01f10sBeyrWSVyZiNCzIeJ4GNfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfA2rgJ5RmJ0KQFqF1yqi36uzCZJRlafnnkx/p21BqDyoZIgVy
	1TrySIg4qmzf14bZitILcBUpUcshxfi1lBHd1fC7EMYH9wKXrPE9ClX6
X-Gm-Gg: ASbGncvl5u0xitdLEv/8KS+ZUyGmTJkXZ3JKN9RVibvOPntJytRz6bFlGbNyb2QcUjk
	zVoZSaDCBem+CJ+aHURcKUZVzGmAsaGXfXa16Q2V/6BQpgduwIZKxtQeP/cVjeKupomb8oTigAE
	z7Ecs1p8M8StGakvPOiYkbuir/rPK+uAZOI52QiyKW22zgGmh9sqyCQQZktqYl3JuXDTQYhgQcG
	9oI4KioVKnEUF6vkpnL7jfMWhdnWc5rrhHxnFMhPNHVYKk81OU40KWZRX0OfqLeYRGVZumSlWD5
	xwnf5Q6xWKZVWg6eLBzsGbuJemKkw3q+DV9ZUF7JTWDDtqimagL9V/QVDve/9Q==
X-Google-Smtp-Source: AGHT+IEjcp+TFNi40fMezUTKqju1rC7O1wGOvROVpKCXLAjmQii9+AcqfRSncpoIjxoSeSHhPr0igA==
X-Received: by 2002:a17:902:dac5:b0:232:11e7:47c4 with SMTP id d9443c01a7336-23528ef788amr181382675ad.15.1748826463017;
        Sun, 01 Jun 2025 18:07:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf5078sm60351535ad.172.2025.06.01.18.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 18:07:41 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1DDA14209E8C; Mon, 02 Jun 2025 08:07:39 +0700 (WIB)
Date: Mon, 2 Jun 2025 08:07:38 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] iio: accel: adxl313: add power-save on
 activity/inactivity
Message-ID: <aDz5WoBFlLiRptza@archie.me>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="31vk9IEADAFheqEJ"
Content-Disposition: inline
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>


--31vk9IEADAFheqEJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 01, 2025 at 05:21:28PM +0000, Lothar Rubusch wrote:
> The patch set covers the following topics:
> - add debug register and regmap cache
> - prepare iio channel scan_type and scan_index
> - prepare interrupt handling
> - implement fifo with watermark
> - add activity/inactivity together with auto-sleep with link bit
> - add ac coupled activity/inactivity, integrate with auto-sleep and link =
bit
> - documentation

The series doesn't cleanly apply on iio/testing tree. Base commit or tree?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--31vk9IEADAFheqEJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaDz5UQAKCRD2uYlJVVFO
o/w1AQCca8OXieBI2mq949WMX1G6UYZrshC0wL+gUVVpLZEdnwD/R68/W8h8RNlW
bPodldVoo0JYWzXwHqUwbc/431WkdwE=
=j6wZ
-----END PGP SIGNATURE-----

--31vk9IEADAFheqEJ--

