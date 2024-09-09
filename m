Return-Path: <linux-iio+bounces-9388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B1971BFD
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 16:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50990B263C9
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD541BB686;
	Mon,  9 Sep 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8WSi2AD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069C3C3C;
	Mon,  9 Sep 2024 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890353; cv=none; b=QDYlOyVXyHlvYRnN2h+V/6qTPQsGWzHbRDBY8T+0lJvz/FmIOl+9qZC0GMCEj4XvELX8csYpT/6xXMH6CEds+MNFe+ApKhnIP30htzFpkiGorPNEnGxumouo8APK7Dd2uTq7Pyr6iu5eSupU4cC+eNSez32+bYxUzCJSThsUFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890353; c=relaxed/simple;
	bh=787Q5Wa5m5HrCT5V4ZDXDS5AXFc35wVlUo2l/EkAdyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Exld6qEkd2jDBK0qMbbiEe2jS9IzqsEVNIOIn1+joekK41n0m9BDbvgIQ1uyB8xSA/XwHgmDwx5E62gj9kPZxFD74/Fh6EMJqSeMsToVtcUBgsDqfpFG9lsweXU+viNCaNm6R9ofn1wZ4eJ8UrkHweQOf4FCQd8y9+u0d4fT/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8WSi2AD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso59056866b.1;
        Mon, 09 Sep 2024 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725890350; x=1726495150; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=787Q5Wa5m5HrCT5V4ZDXDS5AXFc35wVlUo2l/EkAdyk=;
        b=W8WSi2ADDy16WfopEXit+H6hTeSFPUmP+/YW/qFYDhjdLOzSqMIGWmCrdl05uYVpXH
         7kwhYVsQQXvljvQpCZLoPJ7lciyHP6GgB8ae5PWSb4YpnzVg36avvEeEHQM0oxR76UKf
         aJXCnnTOcPFg3BPmPQOaK3CAlr8TbvRcPnjixJiWKf5JT1Qt+vBqiHl1RVnut5ppvNSm
         iRB8WEGQAixH4Ql9q9ROdcazhdO8aA+2q9J7lDE5Dqx3DaPsdoufU+e4NORT1qBZxP68
         QYQ3c4otq+Yv0aEqXrkFBSOFBD7PPy0OYVn2Q8B2IvlI+BUklueHIVZ4uUtL8OCU2lsD
         K0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890350; x=1726495150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=787Q5Wa5m5HrCT5V4ZDXDS5AXFc35wVlUo2l/EkAdyk=;
        b=mh6P8BdM7OE+eEYksKhJA4qSpqO29e8dsSu/FpL+DIfH3jnRxV68eWHp7Gu/w3KBk3
         y5FvuPmRjBdlVIC8lWcIXOH3Wf04bEd+Ua0e30xDA+oKzWAFc85EqMKPG3ygfXHuTGC/
         WOhrqbGReDzKg5wi/Yhw7hCicqJ0zgntWbs9O730ILXHsuuKuTwT0F2nmRQDEOyN/y61
         rApjZ7BwVyI8XI2ZoXyLvr5YTP79eOMBCiow0M77Bn1ian3vGrEaWfDHLJc3+9/SJlQa
         RP0zY3OWhBYoSeHaNB9apDK0hd/7j8hhfEki29RftNh9lyLmoUBYg5DonApp03WhsMop
         T8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI+xn9hkdlbwObZGlck0gODGsHfPAZLI+/ZHQs8eVgEytW49onGzOadzwWSHpSLnAK8udesI6uDyMW@vger.kernel.org, AJvYcCVqyQ8HS642AKqZUFVx3gJ2CVtKTQ1MHfXq0YMIockC0fx5xKCaT0zOhIkEDa9KxsRtynIueLqm2s3rBbaf@vger.kernel.org, AJvYcCW/OmH4EYacDzgpEftlbDfsvWzN2yxcYKTFQfNnsEzkZN/AFEkHlpYY8Zxe8j31M81HTYop3G9NJao9@vger.kernel.org
X-Gm-Message-State: AOJu0YzDJ28rTUvO+cRp4g3X/evOuWoDcJMFvXEylWJgDReDkWgacJzh
	a6YWP8vjCVPRIK8bLEy8vkcnvOdyZU2D4gerqMxpMx7wjCdsAn4rzMxk7oidXag=
X-Google-Smtp-Source: AGHT+IHqYan8uVpmjjcNz83SJitrYmuJRA8f5YjQQ20wZ3TpgcLKeSt/JBwDU+whhfOI8fmFgMJ5Aw==
X-Received: by 2002:a17:907:9287:b0:a7d:c464:d5f3 with SMTP id a640c23a62f3a-a8a85fb7e90mr1225118266b.11.1725890349209;
        Mon, 09 Sep 2024 06:59:09 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a258a3sm344254966b.89.2024.09.09.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:59:08 -0700 (PDT)
Message-ID: <1dca9ce52e7c701c7fb6cbbc723e9dff5d0ace8b.camel@gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor.dooley@microchip.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
	 <dlechner@baylibre.com>
Date: Mon, 09 Sep 2024 16:03:17 +0200
In-Reply-To: <20240909-dwelled-specimen-949f44c8d04d@wendy>
References: 
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
	 <20240908132925.331c5175@jic23-huawei>
	 <20240909-dwelled-specimen-949f44c8d04d@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-09 at 13:46 +0100, Conor Dooley wrote:
> On Sun, Sep 08, 2024 at 01:29:25PM +0100, Jonathan Cameron wrote:
> > On Thu, 05 Sep 2024 17:17:31 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >=20
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > There is a version AXI DAC IP block (for FPGAs) that provides
> > > a physical bus for AD3552R and similar chips. This can be used
> > > instead of a typical SPI controller to be able to use the chip
> > > in ways that typical SPI controllers are not capable of.
> > >=20
> > > The binding is modified so that either the device is a SPI
> > > peripheral or it uses an io-backend.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > > =C2=A0
> > > =C2=A0required:
> > > =C2=A0=C2=A0 - compatible
> > > -=C2=A0 - reg
> > > -=C2=A0 - spi-max-frequency
> > Sort of feels like both reg and spi-max-frequency
> > are valid things to specify.=20
> >=20
> > Maybe we have an excellent IP and dodgy wiring so want
> > to clamp the frequency (long term - don't need to support
> > in the driver today).
> >=20
> > Maybe we have an axi_dac IP that supports multiple
> > front end devices?=C2=A0 So maybe just keep reg?
>=20
> I'd like to be convinced that this incarnation of the AXI DAC IP is not
> a spi controller and that a ref to spi-controller.yaml is not out of
> place here. It may not be something that you'd ever use generally, given
> the "weird" interface to it, but it does seem to be one regardless.
>=20

Agreed.. As weird as it get's, it's acting as a spi controller.

> I'd also really like to know how this fits in with spi-offloads. It
> /feels/, and I'd like to reiterate the word feels, like a rather similar
> idea just applied to a DAC instead of an ADC.

The offload main principle is to replay a spi transfer periodically given a=
n
input trigger. I'm not so sure we have that same principle in here. In here=
 I
guess we stream data over the qspi interface based on SCLK which can look
similar. The difference is that this IP does not need any trigger for any s=
pi
transfer replay (I think).=20

- Nuno S=C3=A1

