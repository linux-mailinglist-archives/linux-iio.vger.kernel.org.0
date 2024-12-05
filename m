Return-Path: <linux-iio+bounces-13130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E269E5E44
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 19:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C251884F2D
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFFE229B15;
	Thu,  5 Dec 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iPlLR2m8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF0CA5A
	for <linux-iio@vger.kernel.org>; Thu,  5 Dec 2024 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423468; cv=none; b=g8Qi7vt4DkWKEOxkjneyJV/CkITNoEFxmYAdDYJmJYfzLCWvVEYxntc1BH5nffoPuYt4TyGaFAva+GuvgkLV4Tpa7UJQpX0sORp/TxzNQqSbHSNSB+/IYmL2AT/jbzJbO+pAv3QA5xFLsbngu3Xxw/6XXfOrh+jJyY8H/AmCwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423468; c=relaxed/simple;
	bh=QuzwAYKP6y0WYybZ98GYlbXU/18zgti4WhdRXKNgN4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFXF8y7OZNkkI3WuW/19UJXnZWvdq5nnvlyHZzwh6YU1xGN+92bixe5zWiDG3vJCDZiXaTciSBXyMIR1biu7qCvjAU3k3HKCG9QJZgE26WDiH23/2Zb8vFL4KNAzDUbJmW6NpY9y+CrJO1CXa0Md75RxpvIiwKwgwrqK8mDc3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iPlLR2m8; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-385eed29d7fso907920f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Dec 2024 10:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733423465; x=1734028265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nI/eTNT0MeMirB96tdoKMUKUCbzlY21F1vUoI8tn+9w=;
        b=iPlLR2m8ssrYbf8yuizjEiK8dHm0HUwaDTusPRz3L5N7fPeYsWrTcXPoumjmnKPFza
         +gL7WnAQhzPrqMWILPxwa+URoxcxSRyJSK0ZOrsdA7JNxYt4Ca1+nnbAJKgYRs4cxp4r
         9yAeaZ33v3PcB8DlH/eQoorXu0asSNN92WDeDHYJkZhlht5M39gafVwj/g3XsqCQmOtt
         u0FQPUsHsIUW2ECY7auN1TSw2Mox0Me2ag4fe8DVvnuJ+0Ea3ZtQRK4mt2MQWdIH6m72
         QFqsOYf948o5lCnF2IPgR4dQQlDwTAm1DHr/GEW3/fgUHTR44AuAiR1Lu3Yj6iOSMLDO
         3isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733423465; x=1734028265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nI/eTNT0MeMirB96tdoKMUKUCbzlY21F1vUoI8tn+9w=;
        b=Nmh8khBgB74siF6F9b7DPFwlyXoNbVWgcYpPrq/8GoNLFO5s8SyeqjmYfmi5dFxnQs
         hEZG3ZislfFDBPS8lV5aX6hNDtpcVqjeqqidt4aBoJY8KAWwVlRpW7tkWj/GZnXgJFIs
         DWAUzyQj9c6uQji8BR6LvPcppLa7O9RgTOJp5ixIXbnDVXBY1qjWukxbtxhU0HvruKI/
         ThR/U7JOj7BNtI4Sox2Cq3EteFKLtC8LcDJKPwbFDgKQZLgrY5VBdYaDtKAP+z4ui3MH
         ROJoGzBzAqToRQ3CH2bELIqvivjwYzdvTLoaAOLiV4Jwf1vRNJTyz/YSNEhv3TQbbVTv
         vuJA==
X-Forwarded-Encrypted: i=1; AJvYcCVtsax9qeRwOZ9bbYXoo3r5Va+uAd+U/1Gx9/H3grQaU/KmbktYOjazkucCdXNX5fECHrP2bIljpBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgN0jz3eo9yYNpisoMsfyz6GpeB+O38GOxl7hSP7bWmqcw+yay
	Y75Zt/wLfhAKy2GRewTT2hr+cGfCnG7BagYtLDXyEy7qV0ox+uTly+8xf6U9jdE=
X-Gm-Gg: ASbGncuT+UCUO80HNdnTSIeKeb6YYebdFRneCeeD0P1UGh8FH4oZYKozehojnzChZJa
	eAGrrxZfH8USrSDczvOhW9/6/D4GIf5+F0m5IfPqYqQchEy5rbme8ivZAvqEfz5Lb8gNK51vJ1X
	UpTzA8cFjmEu0kmUSVrEm75dRBbG0upihM7NiPP5wl+7QnBsgRCQab8GuJo5b7BoMAVhxNkRQvy
	s1EPq/Wv8qwLjFBIwVd74zOh2xNJcNEOqlqRh4g7sToBQQn0KZxw4FDoEhKRgvab5rVNoqW7T7i
	mRoK
X-Google-Smtp-Source: AGHT+IGqQWdQdSDbu6y+4Nqk1tOE7EZS/rmgFfu8XR0kvbW+Ek3dvWuMR5u6gUY7Znay64mPAiGNXQ==
X-Received: by 2002:a5d:64ab:0:b0:385:e10a:4d97 with SMTP id ffacd0b85a97d-3862a914a05mr271364f8f.21.1733423464813;
        Thu, 05 Dec 2024 10:31:04 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbd70sm2576996f8f.90.2024.12.05.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:31:04 -0800 (PST)
Date: Thu, 5 Dec 2024 19:31:02 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Renato Lui Geh <renatogeh@gmail.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, devicetree@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v5 00/10] iio: adc: ad7124: Various fixes
Message-ID: <izv2vupxttrq6jqemmnkwqtwb5ar5mzaimwity7mqnk32alwgl@elwhe3piv4n3>
References: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5nu6lfvefddqxt2"
Content-Disposition: inline
In-Reply-To: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>


--t5nu6lfvefddqxt2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 00/10] iio: adc: ad7124: Various fixes
MIME-Version: 1.0

Hello,

On Tue, Dec 03, 2024 at 12:00:20PM +0100, Uwe Kleine-K=F6nig wrote:
> changes since v4, https://lore.kernel.org/linux-iio/20241127145929.679408=
-12-u.kleine-koenig@baylibre.com
>=20
>  - Drop | after description in the binding docs (Rob in v2)
>  - Dynamically allocate spi buffer (Jonathan)
>  - Fix capitalisation of a comment (Jonathan)
>  - drop comments about already emitted error messages (Jonathan)
>=20
> As before this is based on v6.12 + 64612ec9b909 ("iio: adc:
> ad7124: Disable all channels at probe time").

In case you intended to apply this despite Andy's concern: Please don't,
I found a bug in one of the patches. Will send a fixed series tomorrow.

Best regards
Uwe

--t5nu6lfvefddqxt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdR8WQACgkQj4D7WH0S
/k6GoggAg85Z6D9vWjKd90Y7O1hgRuFkvNEFe+7bMIFaLWf7OjUYQEK1Ya5AJ7CK
yH1w10J68l21qEYJNnR3kRi58Ucau9L/j6eXBnJntZkjN97W0Eo8nNajXgGimGKF
yTHLsPGapcyd0Sz6n4NYENRAaNXmuT7DS4eQKjoXW0pcnoortD7sAlfnNYutvwUJ
shU0f6Sa/nM7Pu1+p6YS9bdztq/SJZHVP5/0sfaqzIvBPlEdW/TNE6LqOebyLaWn
yLIm3scUmUygVsjxNRnUco4wBa2LJF5j/5jHeDTfeYJvt0TVUiBjfLGw9bkM5rlM
3lh0IdcKcoc0mxHYn7AK6RRWsA4RYg==
=pEaV
-----END PGP SIGNATURE-----

--t5nu6lfvefddqxt2--

