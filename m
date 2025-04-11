Return-Path: <linux-iio+bounces-17926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17604A854A3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 08:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173699A435C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 06:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A727D79A;
	Fri, 11 Apr 2025 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHwKAcKg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D127D76A;
	Fri, 11 Apr 2025 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354149; cv=none; b=Oop1ed8prAi051GQ4CSylf7iz49zHmQsGtHj/iinWRABh8jbJTfoq2trzg2+lPHLb+D/NO6m4q/t0sPYjFxsKLyoDyza1iJBQgOLqcFQsSH5PVMiJ4CGdYgo13n0wdSMOXCzIE9+uH1uWXhEZwLPxR9112e7knnnJpUY+zZ1zDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354149; c=relaxed/simple;
	bh=ap4fFUt7Nt9pvfKKbQPIQnmk/cOf0KnT4sqhbq9PEbc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UISbM3u9lwNFuJIxu7JJ0SL3WorMijFzRBVUIdbwyf8D/s8uGIa28NxIW3XSvLbptb3SPmUrzq11SyBH4y/l1DYTdVAd24RRJ7cc640kxBVhxVLz3E+q2OJ2616nG18K4AOpTncJmiDYkKMO6yDE0g17ICNBOncJ3lUitXhnJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHwKAcKg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf257158fso12053245e9.2;
        Thu, 10 Apr 2025 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744354146; x=1744958946; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PA1WMrd1BmfdXlxY8bxgo+05D1+gze9bzZtcNu0kKvI=;
        b=LHwKAcKg3OfTsgF+M57ES7XGUwgRJESmkFkWyv6rUXDnGpQ0o56ap5lrgBQGXjc6uY
         CSlZOCuhSk7TyDvJWxO8r9NonV2qOA4jD6w7BHz6RhvsWHhY/z+72mYx/Xkm35MjFsuZ
         7qbKInpe9xE1Dsu5VT+A4LnN4iwzeXC9kkJeQ3l2hqvUibOHavH/cZrDHilq04dMZIyX
         gpyUQe1Tky98TYyCLpiTw73LI0JdvuRdn3JtJumHbRrpwKw1371Bvl1W15JoCHeAP+EE
         yl8O9ZZi4zC1NCHAcSXYolKDiA/bYQp4ZQ/X4IUuxjkKdNK0lbfBmUaQmPrP72GxsATZ
         T6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744354146; x=1744958946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PA1WMrd1BmfdXlxY8bxgo+05D1+gze9bzZtcNu0kKvI=;
        b=T881AiIFJDM2xlrooemEwmyel+RvQyTvvrS8rIC1+MD9oxDheKxu6iCBltp1UWhA8U
         94Rq8Xa7jdTYzNRjr9/vT/+0n1FGWTRI+9Sdwp0/ljP/E6YAXMvBrRfNdE4Iko/eS5XD
         n+Oun0ez39QJwJcA6+qFnyGpq/vEwPOS/adUbCJou30pi71CxT9Ob0pMulV+DahJKVXm
         CRmiDSETkzzfbWxpD27JIINfX4T2sBeiZyOZ7xrqLzOYCMWdHg++HHkPjtnOWj9/NYC7
         6EO7jymYz+QsXZL2y9k9gPWiMj3oSVpAyuXKVYYxbpMX0w9Gl9wFGC9qLdSf/KDgHljc
         p86Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2banA+i/ePR2R7qQsPcm+ZR6Ed8EFQ+xWIZgt4RDF8R/kjA1cIHb3b1FYfbbYq0oByfO/8zrmMCN+05c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJCIw0lFqHL6EgtisvIeqgswLmTMb7SvAdfTZK+HPxDmXIgS0
	J0yTYrYepqizgK4t3gUGyzIGUO7ur+dCi1H/t0m5HU3aAVgDZV6v
X-Gm-Gg: ASbGncvdJ4r33FJsVLO1qE/Eq98XjxN3ux48iSQV0zvQzecvoihIPNup2dScS/YcNWb
	mj42cJC4ErEcj7a+HQBz9CmKvTtE3AapF5TPIUEJnu8V0ytQmk9XCDtb7hHw38LexbucBeudmoP
	o8t+3FslQ2NLBVoON5Cz0cLQRu95gGge42QVqKL/GYlJ6XidmY9HcdKw5K7ILhRRymaN0wA4sZq
	xtY+LidjrjRaZn/E4MNZ6Wgf/clpJthkAXdTHRcDRPgj2PUEcJPm5yd2ZPhRjTeJGRpvOBvzW82
	W1bbkHdW6wR+5aN5dneJu6lgnUw3A5pwz0BjNf/bT881UX6+V+Krf5z1UcpCR/Pdx4bVFhgIPm7
	XmDwFanRx0hJK/NE=
X-Google-Smtp-Source: AGHT+IE0oYJ/I0kmM46PQvxHKHRpeqSNvLtBp69e//j2haDX0cFUfrAooiUaxGg3Dm5x4kDxaWDAnw==
X-Received: by 2002:a05:6000:2586:b0:39a:c9d9:877b with SMTP id ffacd0b85a97d-39ea5213d7cmr1027249f8f.27.1744354145790;
        Thu, 10 Apr 2025 23:49:05 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977fc8sm1059232f8f.48.2025.04.10.23.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 23:49:05 -0700 (PDT)
Message-ID: <10a9dd5cdf55b6a9845fb9543cdef5f2251ffa6a.camel@gmail.com>
Subject: Re: [PATCH] iio: addac: ad74115: Fix use of uninitialized variable
 rate
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Purva Yeshi
 <purvayeshi550@gmail.com>,  cosmin.tanislav@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com,  jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Apr 2025 06:49:24 +0100
In-Reply-To: <1254dfd7-e872-4c65-bd17-8015e1b2eba4@baylibre.com>
References: <20250409202945.205088-1-purvayeshi550@gmail.com>
	 <1254dfd7-e872-4c65-bd17-8015e1b2eba4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-10 at 09:51 -0500, David Lechner wrote:
> On 4/9/25 3:29 PM, Purva Yeshi wrote:
> > Fix Smatch-detected error:
> > drivers/iio/addac/ad74115.c:823 _ad74115_get_adc_code() error:
> > uninitialized symbol 'rate'.
> >=20
> > The variable rate was declared but not given any value before being use=
d
> > in a division. If the code reached that point without setting rate, it
> > would cause unpredictable behavior.
> >=20
> > Declare and initialize 'rate' to zero inside the 'else' block where it =
is
> > used. This ensures 'rate' is always initialized before being passed to
> > DIV_ROUND_CLOSEST.
> >=20
> > Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> > ---
> > =C2=A0drivers/iio/addac/ad74115.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> > index a7e480f2472d..26770c68e5fa 100644
> > --- a/drivers/iio/addac/ad74115.c
> > +++ b/drivers/iio/addac/ad74115.c
> > @@ -814,7 +814,7 @@ static int _ad74115_get_adc_code(struct ad74115_sta=
te *st,
> > =C2=A0			return -ETIMEDOUT;
> > =C2=A0	} else {
> > =C2=A0		unsigned int regval, wait_time;
> > -		int rate;
> > +		int rate =3D 0;
> > =C2=A0
> > =C2=A0		ret =3D ad74115_get_adc_rate(st, channel, &rate);
> > =C2=A0		if (ret < 0)
>=20
> I don't see how rate could be used uninitialized since we are
> returning the error if ad74115_get_adc_rate() fails.
>=20
> Also, initializing to 0 would then cause a divide by 0 error
> if that value was actually used later in the code.
>=20

Agreed... A better check could actually be (in ad74115_get_adc_rate()):


if (i >=3D ARRAY_SIZE(ad74115_get_adc_rate))
    return -EIO;

Kind of a paranoid check but just making sure a faulty chip does not lead t=
o an out
of bounds access.

- Nuno S=C3=A1=20

