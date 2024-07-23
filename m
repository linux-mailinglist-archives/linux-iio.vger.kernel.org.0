Return-Path: <linux-iio+bounces-7817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD34C939C6D
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 10:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68955283180
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F0A14B97E;
	Tue, 23 Jul 2024 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFlaBSiM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94F18814;
	Tue, 23 Jul 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722698; cv=none; b=MpqKiNpsaL/Tr0wVmLjP/HkgScdMWmpyb6QWup4ly2D8kU/8eA6ChmpJTs89vbH5cibv4U5i1qdRMN5bLOCLBkc3G56peWRHL3aWmnBU/60I54sepmqzGnZmpx8gBOgiNRFda7gVC+bbfS8eAAXM+Pk5H+BhqKsrChGLR9TCO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722698; c=relaxed/simple;
	bh=u7E64LWQHQVWAPK7DvBwdI1vf99nlz1Uva9cDir2Hw0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ObRm0SM+pB9UghQuu7kkzu2PGMVmoFpsb39OND1ioWDkYjM6/qZyvqrGAvSgcWCT1E0xD6dkexNAim2ml22nQIceTBPSXSwphE4GqYG8mL0+FDf8zkKsY+CISDodLjW7qG6UOSkv6CQDbKHCr1gUAXAAq0giNgkB484LOOdz7c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFlaBSiM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso4507270a12.1;
        Tue, 23 Jul 2024 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721722695; x=1722327495; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aomYwYHkUj9PIRAd01rbd7wfWXGOwCJ1e5XZ9LIok/0=;
        b=MFlaBSiMoOYQEB/TbrTuQ6u6GVeJlrGksv6LLhvsxVWFKUtJgDL4preNsWOujpgP0A
         WTPCIn5BeEq5eW7DudmXIPvANcrWA0QFjt5Ns7aHXgIK8uKoynl3m84tLZzffH3G7889
         hjv1iWYHbd5jBkO+NR1gzDUIuhlufDXeerbrr+xUhuVcM+OhIv06UnbVROHGITPj4x6J
         LFE5aTG7vlcxNfKnx56a6R2Yv5HqqUIMd77xqAqjqMcunN1NWl9ia23EFnNjDLAQEbZv
         H89/XDgE4Se/QBQQggUklFAI0q6uLz/3JlyUbOlCvon8rcc7HUZoVfivLm8LXUVCFmG0
         +zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722695; x=1722327495;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aomYwYHkUj9PIRAd01rbd7wfWXGOwCJ1e5XZ9LIok/0=;
        b=imrWUcAqIV4vp1rUFi4r+MAkJ5e3m85TMusW6Q8cUvWauBFSX1A+4krn9RRuHr9VoW
         AvoolRF8I1quhkZuxA0B2MCM12wawlJUsBX90FCmaFxd94OKppGSIP0oiMIwO6rHX4QL
         djd1yByJOeozzzue4CyjjVX17TI00MSmFwp9Ph3rzHC6wd1nFKkbUpFhBGXIw0woT7gP
         vQW5MvCg3IUdGSGibA+euVv4cRH3fwJnm5CvHbGvcx4jqPkWp0zZkzuOW6VZfZWHq/A7
         mRvKVpbYA0gz9X5y1miSKsvQOSDQGTcFCOMDhTPk4jFAceru4s5hHmt7k5bStOzqzjPn
         c/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCW93iDYOkNhPtXxs98G9JAIRbVz9ip2yFCZmwNBGIim9XgH3qBGOXohc34Hf2lT63s4KqztT74aq7pBIRcuxPvFOl3dsF7H7lGEv6G9fFX6+8qFnRg4eXIrTYXtzPmzdZfQJH4jEr9YUKgUZJMqrMRnhn7KprB2f73NGpWQ153kLBfPl1R4yT7H/Vjur53ycTW04Q1ui4aqGUlcopSkuQ==
X-Gm-Message-State: AOJu0YwtmvGjSiqNCDnyxeWrW6381Sy+MkYlFE/s22NgvIEsbGXjN5u0
	J6PeRbSPlO1Ol1fI4HQn71hm42ekdIoZTh0FUhsugkYiC27uzbM9YoDjkUji
X-Google-Smtp-Source: AGHT+IFklgcj9RMewfqoRTiDzrQB8v9waGUGNso+QDgdI3GEz3JLuAWPW3wPxn2P1BM2UQpfPFM06A==
X-Received: by 2002:a50:d681:0:b0:58c:ccc1:17f7 with SMTP id 4fb4d7f45d1cf-5a3eee84bb0mr6341358a12.15.1721722694828;
        Tue, 23 Jul 2024 01:18:14 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a7535f402fsm3363982a12.93.2024.07.23.01.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:18:14 -0700 (PDT)
Message-ID: <04f44d9dcfe67ffc71a7999dcc11b892ff1c61dd.camel@gmail.com>
Subject: Re: [PATCH RFC v3 9/9] iio: adc: ad7944: add support for SPI offload
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Tue, 23 Jul 2024 10:22:12 +0200
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-9-7420e45df69b@baylibre.com>
References: 
	<20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	 <20240722-dlech-mainline-spi-engine-offload-2-v3-9-7420e45df69b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 16:57 -0500, David Lechner wrote:
> This adds support for SPI offload to the ad7944 driver. This allows
> reading data at the max sample rate of 2.5 MSPS.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20

...

> +static void ad7944_put_clk_trigger(void *p)
> +{
> +	clk_put(p);
> +}
> +

I think this means we may still need to improve the API a bit. This asymmet=
ric
handling is (to me) and indicator that something is not very well from a de=
sign
perspective. What I mean is that if you get the clock through spi I would a=
lso
expect to put() it through SPI. Now that I think about it that's also true =
for
the DMA channel handling but in there things are a bit more complicated.

I mean, at least you're making this explicit in the docs so maybe it's
acceptable. But it stills feels strange to me that the place where the reso=
urces
are requested and bound too is not the same one responsible for releasing t=
hem.

If we go with the provider/consumer approach and having a properly refcount=
ed
spi_offload object I think we may be able to do it from the offload object
context. Maybe not worth it though... Not sure tbh.


- Nuno S=C3=A1

