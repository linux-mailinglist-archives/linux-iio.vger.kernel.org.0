Return-Path: <linux-iio+bounces-18959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33674AA6BD2
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C070D1B66694
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA72267709;
	Fri,  2 May 2025 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuzIrCyx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093EC2AF14;
	Fri,  2 May 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171833; cv=none; b=B2pyKGP8KskKriMR4CjiYsOmAeBho4U1T12mPmyGg7ebCBmzM9rVM1DByKUtsEz6fYjpnBasGH/8XE+sr0gpIm9HPnFUjXPe7cOYGaHI8Q4jRSefzMvyOu3Zy0PePmzS4peRl/R0xk3VyosT72eNowW+jDpG/6p0EGz1KA2T70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171833; c=relaxed/simple;
	bh=AurAdpqZJOgAuhQNXdhBCA1aC+raKZNxPlCuKktdOCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWNTYRmJgu0iTaL0kszmfA/2epp7wm9prfPs1xS+eh9PSUaOlKkPZj4+2rZnRNPusX+2Ex8notW0LP4m2JonNzCyyW8LKIjN6ycXIOUwJixk8ySW/d0SoTW6CE5Ad7Vd0BAXvaqEGGxQmhFUv+8Xp9KKxh6Z+45BGKfZ52Lx5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuzIrCyx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso935753f8f.0;
        Fri, 02 May 2025 00:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746171830; x=1746776630; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VgEF1dupp2sZXnl1NWHmmeZuFKwcbBSuM3goZum9iOI=;
        b=BuzIrCyxZumupwElboR0BiQIQDPZu5vsYg/mJN1KtJFZj3gVhqmidFonXUjl6Tq2Ac
         P2+6DhnNQeZ1Ec8CotFqJceJzpC+3OV3+pXm4o0Vypsu+QWAVKZHFTYSq9oEB41yXuna
         5Og+jIYx6tRkINaHUsZZ3WNNwqLarInuF2UrSEuOqrTY9XU92xqUOMMavfzynOq2YqqB
         EDtUHBeRZiZIWQF9mPskC4mVeJcxjHlYCCBVCuKBGewt2sEXoBfW3Yxa+4mt9J6ZxIiG
         URuvLnAvuyGAOvVIsBfFOeHKnPWdBy+kG89ACPTO0vhmT63lqYuXygd1k7s2gtkRerCq
         oguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746171830; x=1746776630;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgEF1dupp2sZXnl1NWHmmeZuFKwcbBSuM3goZum9iOI=;
        b=D4hPhvtLNE783eNU/Y4jF9nFBfuKhQRsxLUWg620wkaI+fX0mm5EZWvYX0IBdSeTmo
         oiHcXvs7JNnyag08sI5wl1ZHbsp5BTx69DskiCZFQN75aJ21jpDSXDCDQ+/E3r5wnJ9J
         8Ke0pxfBHP+2NNuQpvbSgNGQT9/WdioUQM7vU8HqNqfx4Cb12hWZ7TLVFerzxkrqrCrm
         H6FtRV6ks6j2xsVSPzrHQ4PidAWm0mCqRYBdRT2uEVcVIQx3Vdy7Ja3Q0ZNBRZC4cGMx
         qJkleV8UoT+T8/OaP4OC/LcrWl1eITA+LEtI2+CJ08YQFz25uY2x6IJ9H6gnmOaO4jCj
         GAtA==
X-Forwarded-Encrypted: i=1; AJvYcCWFCALOJ+o2S00O9V6UldJIkX1nOnWamsUhnDUwi4BSrwhNhtX7vVqmMgP+gumn/J/bvjeIeFBOa/pp@vger.kernel.org, AJvYcCXOuObCwPHwJUp4kqcxnFzXlO7AyVsenN/w92tkV++AqLDxk8pkqjA1UTWqspbuGKrvM0MmqpSMUwTU9doD@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVsRYpx3Oi/aMLNeuGxOoyqu99uQu67wCS/hRRNd7NnvO1b5N
	t6rROagBbtmDKDF6uKg0yxj+o7cHTa6kQl3fB3JSGatt4EVcU14P
X-Gm-Gg: ASbGnctyBxDD/O/dJIQa2h3jiBjMNFkRXxOXkk3qgNzhMO2HEdDGn2ds2J8INZ5XhEl
	r9ogkoQc2s9UMq3kt0/uAaX+MaLZczNAY/gJs271wth9u65Vy0GAdMtgIA29X1FakoY////KPJ8
	NNBdXUdd+A1CfAQRLLp7JvMADu0WayP3t9vcB/OiGWqwmEBG5X56OXQDGgo6eWo4uRpxxtFqo+0
	XkoQ3bRZGyY2D1HMUzf4JesQrrZ8ng6GatAficzE493dGRcP5mY0pfL7gzrtzJTW5YqNN5So9xO
	WExV5Mdd1AdynLeqd9gb+ipHVl8yq8zwZX5IGpAjiA4XKwc3sRx39qz2+zLPm8pf2JlNNAgKvIF
	1J0/AawFgCK7t
X-Google-Smtp-Source: AGHT+IEVlGWe5bnkllgQDbFGzP/LMlSyYggyuiL66DNILjRtZZNWHfrgLksBUfB2j72HpkmuXCKJxQ==
X-Received: by 2002:a5d:64a6:0:b0:39c:1257:c96e with SMTP id ffacd0b85a97d-3a099af11f5mr1052986f8f.58.1746171830150;
        Fri, 02 May 2025 00:43:50 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3cfbsm1349079f8f.40.2025.05.02.00.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 00:43:49 -0700 (PDT)
Message-ID: <29d79f863bd0352fa0e3fca36ba5cc007f467eff.camel@gmail.com>
Subject: Re: [PATCH 3/5] iio: adc: ad7606: add offset and phase calibration
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello	
 <adureghello@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen	 <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Fri, 02 May 2025 08:43:55 +0100
In-Reply-To: <b4598086-e188-4dca-b060-0dd82fc79c02@baylibre.com>
References: 
	<20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
	 <20250429-wip-bl-ad7606-calibration-v1-3-eb4d4821b172@baylibre.com>
	 <d273fa78cb3986da5249bd800dd25c4c0bcfde7e.camel@gmail.com>
	 <9c02b2bd-dabf-4818-8adf-83c9127946d1@baylibre.com>
	 <b4598086-e188-4dca-b060-0dd82fc79c02@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-30 at 13:33 -0500, David Lechner wrote:
> On 4/30/25 11:14 AM, David Lechner wrote:
> > On 4/30/25 10:36 AM, Nuno S=C3=A1 wrote:
> > > On Tue, 2025-04-29 at 15:06 +0200, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > >=20
>=20
> ...
>=20
> > > > +
> > > > +	val +=3D start_val;
> > >=20
> > > Shouldn't this be val -=3D start_val?
> > >=20
> > > I also don't think we have any strict rules in the ABI for units for =
these
> > > kind
> > > of interfaces so using "raw" values is easier. But FWIW, I think we c=
ould
> > > have
> > > this in mv (would naturally depend on scale)=20
> > >=20
> > > - Nuno S=C3=A1
> > >=20
> >=20
> > From testing, it seems to be working as expected for me, so I think thi=
s is
> > correct. The register value is not signed. 0x80 is no offset.
> >=20
>=20
> Heh, you are actually quite right. Even though it working correctly, it i=
s
> because the value that gets written to the register is val & 0xFF, so add=
ing
> or subtracting here basically has the same effect. But subtracting is the=
 more
> logical way to do it. (I tested it that way too just to be 100% sure.)

Yeps, when testing it i realized that the current form just gives the corre=
ct
value in the 2 LSB so I assumed we were doing something to cast way the inv=
alid
bits.

To be more pedantic, I think subtracting is the *correct* way :)

- Nuno S=C3=A1

