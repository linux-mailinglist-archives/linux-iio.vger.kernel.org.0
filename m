Return-Path: <linux-iio+bounces-13816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B243D9FD23B
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 09:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287B2188313C
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 08:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DEC1552E4;
	Fri, 27 Dec 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qbFXrYFS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F81876
	for <linux-iio@vger.kernel.org>; Fri, 27 Dec 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735289320; cv=none; b=oJ3SnsctYTUssW/zQPI+q9/osAro3TIaOIPNmkem8Xmg2KaOX7J6AQcKu4yqv+CfD6RyhKZ/R4zACePGvN1pxG8fHurAtHzXMr0y41rvRa1plv0PSH/mMWBlZEYaTkW0EJmuEYPlUQTcxhwV7tWS8DdI33LEJkpBK8twosmUk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735289320; c=relaxed/simple;
	bh=NEbeQ3L5dRhQYyPq3yfwEYKyaUXmPWYu8jKxfnZzAzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T06EXIf3qnILOaXjW0M4jn7Sjfm+101K52PhBjRnrqE+po45rlJzSovNewRMigiuN1pdUCndxkxxXskU9E2SHaaSW8bVthk3RqoPkN8Rn3Jg44EVxjZt6HKdLx2juJZ+HjQlNnu//VQNhc4nrZPAuh5sVCxN96erH1iXbwwFc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qbFXrYFS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaedd529ba1so503438666b.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Dec 2024 00:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1735289317; x=1735894117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEbeQ3L5dRhQYyPq3yfwEYKyaUXmPWYu8jKxfnZzAzw=;
        b=qbFXrYFSFEQqMQmA2yAWHDUkUO/W6Xfs3MocgRfau49455ocIogwT2G/lTj5/1eOzo
         2XZ4Kl+iDK/sMDbFy02gfqPwNvC5Hfh4X1IhG0xU4PDWmCotbGEbvCTZSSvrStAZmmDP
         kgRphtQdH0kFOFK4UMhNzVMq6LmctzP7YqfNyh69ewL3E87xdlsfVPxR5blFPIgxTFIb
         T8xbvpgY3wdxU+JGBbin06YFgpJDSFrR6bWFispdpDKIDYSvG6jo/DwxVWP6mwsZc1PV
         kzKiMlzfx0mwUgXxuHNTFW1eUKNesy2mx6QrTQw6jcdd3s2EhqGoLNXN2i+5RNG7JB+5
         zQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735289317; x=1735894117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEbeQ3L5dRhQYyPq3yfwEYKyaUXmPWYu8jKxfnZzAzw=;
        b=lSaXxOCztX8yNO1wAlJa1DGCgO5SYaFZWbPTzdBkTy8Nyk0aWb/rJZYX50Dh6bqZJi
         coUuMZgGm8G9cgEYU2IkMTctNYFltT89STNCAWmA0Svy3+BpJzeCEj8f56Pc7NzyTvLA
         ScO05GSVS+iezfR9Kj1CfjBB6P5+GEJenwAF9RlJ6/ZYIrQJxaOCKra/x4e2Xzu+9P5H
         63X8azzCYEHSJgh6w0lLEeH1Zps9ppZwuC/KNCjUHmf8EOiyuQjVQh4dztXfvwmY5yQM
         tc/AF9cndPO4CHzWfGKhI24ZbpX0nEmT5+bAM6QmgPemW3lU97UtktCMEiFM1g2Ig1JK
         QOiA==
X-Forwarded-Encrypted: i=1; AJvYcCWUOyCjQL5pLE4saH86xbsQYKCzgjrQ0SAzHtGlVXT9/adEzqwOh0SQsn6vYK3nrOmRwon4Nqc4cEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6GJTQ5gJUuxLypLQHONbmfPnCddjV2eYZAn9uhPNMuNq3Zkj
	rwpf75tJPkh+lO4ed+ccvO5OvhRVzle3sw5eR/TQxs0AeTAcKEVTUjIw6dBBRjo=
X-Gm-Gg: ASbGncsPx3/2HOu0AK+KwU7CqGVu4uVrUb8t54LRIKF3xXHpprXbcJBZ4wRRp+wrTHU
	moahdfgtm5X/wmL0TbGXgMqm5XoYHDRBqfQOf4ckAHLIGYFMxJdr9h4iW+C3esO0Hv/5VWqRy7x
	R+89Se98EUK5xCt4TUsLlgTUS9fo7//hIuerG6OO0v7CEOXYa8pSeuJy2hQ40YumK2YPXegfbaU
	iUoNXtEsSzURFzrxRgxvkR60Hy9oGPLQwT3fk3NfjMAtuy7XAdlDmN3YBVuvNcUIAofBq8F2OT/
	HIgU39Syzg==
X-Google-Smtp-Source: AGHT+IHIGxUh3Hkutva0u4pOYR5aHeRZWySO0vQ1UMb7FPhwNKTrQdcIuNrAOUcZtoJyiQRumysVHQ==
X-Received: by 2002:a05:6402:4403:b0:5d0:d2ed:ebb with SMTP id 4fb4d7f45d1cf-5d81dd83a72mr63843512a12.3.1735289316608;
        Fri, 27 Dec 2024 00:48:36 -0800 (PST)
Received: from localhost (p50915bc6.dip0.t-ipconnect.de. [80.145.91.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89617bsm1073515366b.76.2024.12.27.00.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 00:48:36 -0800 (PST)
Date: Fri, 27 Dec 2024 09:48:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] iio: adc: ad7380: enable regmap cache
Message-ID: <zkur45la23hyqmqusjdfyzgsofhfli3n54be55dkdrwtxf5g7e@fdpdeliljyz3>
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
 <20241224-ad7380-add-alert-support-v2-2-7c89b2bf7cb3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rcviaha2xqvtyvbu"
Content-Disposition: inline
In-Reply-To: <20241224-ad7380-add-alert-support-v2-2-7c89b2bf7cb3@baylibre.com>


--rcviaha2xqvtyvbu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH RFC v2 2/4] iio: adc: ad7380: enable regmap cache
MIME-Version: 1.0

On Tue, Dec 24, 2024 at 10:34:31AM +0100, Julien Stephan wrote:
> Enable regmap cache, to avoid useless access on spi bus.
> Don't store anymore the oversampling ratio in private data structure.

I would split that. There are a few changes in this patch that I don't
understand, e.g. why does the return type of ad7380_update_xfers()
change?

Best regards
Uwe

--rcviaha2xqvtyvbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmduad8ACgkQj4D7WH0S
/k4/wQf/SEZkmkQjsGZNxZ66QsjyPc4EzFclqr1dYik9tYKEi5yDDKy/IavICRsM
URbHTmQhbciYV1nW5r/0xcZzPtWpW80cPkOVQigXXjPhUdNZzMqxL/2Sy+WMokH/
5OppjyngVWBehioSjO7ukQ8dd83NWldXZIByK5xNHSNsB8ATdHRQkzf/wCan+B+b
Nwl3Ol+fxO9F8srU8m2K36JsUQ16bveVEEbS3OeuFyXmorVvNqL9hs+fBpMzIdYm
vU5rOHub8IzK8v9R6KKZWC3CuL1/Z8AFKb40q+dG+fYIoQ5t2vQ0xbdURwSuJHSi
nGjPw71jxPHCGag9KE2qwUfYSsj1MA==
=ZL/6
-----END PGP SIGNATURE-----

--rcviaha2xqvtyvbu--

