Return-Path: <linux-iio+bounces-14733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BF1A23114
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 16:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454A61889685
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 15:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896D61E9B22;
	Thu, 30 Jan 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r/A95pRI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C41E0B74
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738251614; cv=none; b=AV8a1jDWsdZuBTf0JhehD67sFDw2nE1OQ/YYDoIbvsSXD2WptB7sqPqtSrJXw7WB4qMJl9f/UI1WJsDhn9xxFBDwZZWD0iqOjTAvJkDZzS/onSmx83MZ1+Dr5T6bfAIBe4j47fN6DISEW4YKo/QrnTBt6FC2KKx4T6UEh7JP4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738251614; c=relaxed/simple;
	bh=24w1YCY0bqktSpyH2E1RxqrWFPOF58IxarOOz6drqkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn6iLQL8jYyqj+PEHBDbXzqH76AXo9I9+Tqx75U44KLxLkB9aJ1eGD+TNtfoH85atUIg4vqasbp4s/AJ2d9WleUHFZJjZyt66JKhWpQ9F3+rAwYvcr1+NShwW6kKBCxKo28vXbLmBct//0rP87wOZpc5nI2jzNcPT6ySDIJ6fls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r/A95pRI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso231733966b.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 07:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738251609; x=1738856409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3N+3RkkPcHbjkUPpzJLyQLmOOwjBGiBNGRh1iUy0svs=;
        b=r/A95pRIiJ+OxlCqyXF58kE4tmt6ex5k3j2LpGzxYIllM5U3GLf4ZLqjrYkEEvNYjn
         NNQEEoJjPJ+5fO/HVl7vCm0DzXpmHW1+f9gaZechg7Gaz6u84A4D3rVSw4bW1bHsH7nk
         efbwd9c3bibXu3b7wW4G/opzA0smZQPEuEs9Vbw8jghbmgAOtEO+d6xjAn/vVaLJ8nO9
         r2uWBbRzPrwgkz6uaZHW8xkAJHjBQN7nwdK3uxi/LjbdfcGjtDaBjVs0dP5KbN+j0l46
         Oy0O4epPwzgrkeD2zS/hQkKXpKybtAyNw+flTM1Z6BBxbsEcb2iCy+4FRtEduItnzVGB
         9KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738251609; x=1738856409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N+3RkkPcHbjkUPpzJLyQLmOOwjBGiBNGRh1iUy0svs=;
        b=CJeP9hVVjEiq65cOErsiR1up9B4B/BejDnznJgnCj+P0NYfmJfTzxx4t9yfQddvMzT
         0C6PCnoCgV1Vk6ILcNXGFoFE9qSnVJU4uTygZD4EyPrVPYbzHvF0G+gvSgJUjUOcTuhf
         CsaYtqKbuPAK3YX6MFeUb9QMH6p4jcuAnOhJMuCgWH644A3/moWpJ/f39vX6ovil/v1e
         xrCehCyvflDu/IXBZ4PcCbN+6oRY0iqCF9fttBRPsY0Zq57oN1ACV+od8mmZieZZ45PK
         Evyu0T3+6FVKy1g+n9LYikj2zMFRvYYCAiVDaKjxZuPH6dXCl88gkVYoFSGvIbgrmYVV
         JevQ==
X-Gm-Message-State: AOJu0Yxf45lp0zLWNQBmHEgpWCEiGi91LqoSelUoxFS2zbSvUjcR3QD9
	OnLh4TV2UH+/apLGsJ4N9S+i8lWS+jpHg1876gOSES8ZslP+Y9vqqUhkBqSN0SgqVZ8NydPNQrw
	EGqY=
X-Gm-Gg: ASbGncvtwrRyvjEgAChOLTdxUVDoyBlkn1t0z8dLBWyEUrVOvodCaSi+kpjIKXD0ChS
	8abPRhbt4vOlpJXAZtFXP3IBhIl4F9eNsbCEYf59VJolLSmExJBhw7Qx//YzvkSuzsRC5WAw9UK
	Xg3iPYYZoQPN17usxHsCAk6apmDZ9zbI4Z8jBLue1tRWQmAZkyzo0s3xmsj6wSJ0UUlzjHp16DU
	akthAWinJiSKsypCkHqaHeJlUptfjmzdO2FRk85HxovBMV1g6M+5g7nMRojKni54Sy3Te/4fulZ
	RO/DzLNTV/vRu8vZ1byC
X-Google-Smtp-Source: AGHT+IGp+xr76bwGqE0CGtGKq98DTxArL0p3v5AK3RPnoUn9LTUP+oovyxzrRtJYDZ3P3CZK+BdvPA==
X-Received: by 2002:a17:906:2a55:b0:ab6:d518:7cf2 with SMTP id a640c23a62f3a-ab6d5187e25mr586429466b.54.1738251609046;
        Thu, 30 Jan 2025 07:40:09 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a56399sm139508266b.174.2025.01.30.07.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 07:40:07 -0800 (PST)
Date: Thu, 30 Jan 2025 16:40:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner <dlechner@baylibre.com>, 
	Heiko Stuebner <heiko@sntech.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/20] io: adc: ina2xx-adc: Fix sign and use aligned_s64
 for timestamp.
Message-ID: <g6jrubgedsti3pi3qretmcvupyvh7lhu4uy3gnmkglb3dpjakf@dciteiogio3h>
References: <20241215182912.481706-1-jic23@kernel.org>
 <20241215182912.481706-3-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cjtm3kxypm6xhqbb"
Content-Disposition: inline
In-Reply-To: <20241215182912.481706-3-jic23@kernel.org>


--cjtm3kxypm6xhqbb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 02/20] io: adc: ina2xx-adc: Fix sign and use aligned_s64
 for timestamp.
MIME-Version: 1.0

Hello,

this patch is in next as 1b54068b5934a871f1895adc5e5ca4355781eeb7.

Maybe it's already to late for that, but if not:

	$Subject ~= s/io:/iio:/

Best regards
Uwe

--cjtm3kxypm6xhqbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmebnVIACgkQj4D7WH0S
/k4zLgf+LEHdp6gVpqWy4S6qX4UI4w+UWdJ3+IV8zJURaDDEGogrZjYDcxfznEfA
tEW7F1fX0fdHpHtZdEdFsqG2xdJE0ZZS9Lj0/R6UfuL8RiobFTwOqaU2YM0ExOP/
k/DYviCubWLEyyCyZ4oFu4srzfuCEhpmuSbuslXixmu5ZEFGMlN2gdY56Q24HcOO
XPkn2Q89q2mH7vyW9mAN0q5iERpe+XxrLqrVTsSisMuPEWTDM/XQVLRT2qekBnbk
Ax49o6XAknkV43FovmFHZDH2ZJuGw5RlhF+cyiArBu2ePWBA7cI/6GXF8K0XaHU8
8bep59OOQpvd3aPtCwyEtYAc8a4RhA==
=w/bo
-----END PGP SIGNATURE-----

--cjtm3kxypm6xhqbb--

