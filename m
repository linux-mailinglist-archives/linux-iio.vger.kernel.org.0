Return-Path: <linux-iio+bounces-6241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60DF90762F
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB601F25DE5
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1598B149C6A;
	Thu, 13 Jun 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyjHaTj6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422B31474A8;
	Thu, 13 Jun 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291512; cv=none; b=UWaIUdHWWx1EAhcj9qoAEtk9vJWImUxsbcJEFDynDCOyL5sFAL/Aqc4NsuKgqDLwE3/PSEy3Ho0W+TuYdlyNyHgKCtY9ikyVLfSjGAGf5OHuXYXHKHXEgI4MkdyguhFTGU4FoPxlEWH0Mv8NDjrNvgHqRZMwvqilKywJ0o9yJLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291512; c=relaxed/simple;
	bh=z+795azhnXvc7Z8d96JFT7XZ4xKMWAHclN8bCJF7dyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Us71fH4zVCILkheG/nsb1i72RjF30PDxxCGVw9rE7TD142d4SmUk1bN4pUI4HxUp90pl0r0ygo31Wxae5NRegaDn+s2mY+r6MX1L3YmBxpkBaO+LSCSqIHe9jk0PSuNjAxP5z7Ivxq0XcvIYHeBtS7wc62uyglcEQ+cciIaOzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyjHaTj6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so1255932a12.0;
        Thu, 13 Jun 2024 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718291509; x=1718896309; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZUuL7vfd80QBwFOZreuafWnuEJtkpQEboZUkkpavjoY=;
        b=AyjHaTj6GPCnc81AsScic4bGJtgR1YkRSG0HxJPM/x5R08rYPh1HwTE3Iiu1M3e4qi
         rjuqZr2W6AdA4voMwEnjseOK7LHLos7xhWxbWn1TijZ4Susx+WD/qI+/FNSUGNBnEgmn
         iRk8cWiQbBKMZsOgWB2wRcwbEgCPz146r3i6ODsW7pWJbyMeEKY71hYtyS+ovvxi6Od2
         U8dGGGW1kkFElMKiS/mvLRgx8AbwfxaKrcrZkUDiVF6WxN7xboYFcliSC5xGIsmfiaAO
         Q5WEyaezGnq4b1YUQcmQTzemFR1KPdLH+N8PORk3kgAnSUfVIvpIpchfvC2HcYyyJayD
         P6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291509; x=1718896309;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUuL7vfd80QBwFOZreuafWnuEJtkpQEboZUkkpavjoY=;
        b=EqzogsAtn/ecv4BlYAXv05JjEAYbBGuR3T2i6j0NR4IYwcYDMiyJf2Nc1wcpnUj+DV
         D81aoUeOKWrxSfJQbWY6nOA8zDIMED19SQre/55xteSNU47xlK/qyOfLQ3as08xeoC5B
         NhGIGM28djA1j775Gr63kWc0dq4nUfkrGmaSvf/RBqS1P+s+OJpRkxxZV+Q3IuCPYF3f
         mJC19bwh3Pevl9nE3uV2J2yfq392KT0cRNfgkHzuGgEIJTD9S6o4sokhgaGQTodsRtWO
         4EoRcb2apnITmvtWH4MLbAlqnsW4kie+Nlebh3zQ0rJcz2M1WjdPbiWxojCOZu6rI5zB
         KCow==
X-Forwarded-Encrypted: i=1; AJvYcCUr512oNZN4BPas6t1ExF92KOs1KnodaqUYpgkAHIo1p39HBp29rSmPULJwgmbR0s7hk4a3Y5Tz/BapDpkLaWgyUW0IqDJaGKxP65A1iaJLoyPR2+EAxMSMQCrgTZCgmCh0PiAQXnJIJhUcY/3KcZ0JTpImM7E9ObZAY44V9WM4TPF12llpIrrn6BY/HKAArcyaURtZG5Gef7ahOaM9/Q==
X-Gm-Message-State: AOJu0YwNPnzgsCGj3Sl0Q4mWerQw9fKTSOZ2FKAKUNo5/xs7t4LtdoKK
	p7zmUtygO1DEdtD9plNd0jiUhTgUJA+aJVArq1Kd9Eyj7lg0Lr30
X-Google-Smtp-Source: AGHT+IHvS3n0XhSSsilqaBsUgJPu+uCF+nXcgUDyisRM+IjvDSTJs6bj4z/Gic9iov+SFd1Ia0o0hw==
X-Received: by 2002:a17:906:68ca:b0:a6f:59dc:4ed1 with SMTP id a640c23a62f3a-a6f60cf2d33mr4132966b.14.1718291509171;
        Thu, 13 Jun 2024 08:11:49 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41655sm81149666b.169.2024.06.13.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:11:48 -0700 (PDT)
Message-ID: <5f0776ba5163578453e26352763ff1b4687bcf87.camel@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Krzysztof Kozlowski
 <krzk@kernel.org>,  Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Thu, 13 Jun 2024 17:11:48 +0200
In-Reply-To: <b6b52b1e-847b-44ca-87f9-095a78164771@baylibre.com>
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
	 <20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
	 <94448c2c-e7b2-4191-858c-529b254994f1@kernel.org>
	 <f765ef30-a777-4dfc-8f93-0f15b46f91ae@baylibre.com>
	 <e09fecf4-bde2-4feb-8312-22c530c6a960@kernel.org>
	 <b6b52b1e-847b-44ca-87f9-095a78164771@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 09:39 -0500, David Lechner wrote:
> On 6/13/24 9:18 AM, Krzysztof Kozlowski wrote:
> > On 13/06/2024 15:57, David Lechner wrote:
> > >=20
> > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
adi,ad4695
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
adi,ad4697-wlcsp
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
adi,ad4697
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # same chips with higher max samp=
le rate
> > >=20
> > > I suppose one could make the argument that the programming model is
> > > the same on these too, but the maximum sampling frequency does seem
> > > like an important bit of information so that you don't try to set
> > > the conversion trigger rate too high.
> > >=20
> >=20
> > which property is that? I don't see differences in the driver, so I
> > don't get how these wlcsp compatibles allow you to control value of
> > conversion trigger.
>=20
> This comment is unrelated to the package type (WLCSP or LFCSP).
>=20
> What I mean is that e.g. AD4695 and AD4696 are virtually identical
> other than the maximum allowable sample rate (500 kSPS or 1 MSPS).
>=20
> So my thinking was that it would make sense to have:
>=20
> 	compatible =3D "ad4695";
>=20
> for the lower sample rate chip and
>=20
> 	compatible =3D "ad4696", "ad4695";
>=20
> for the higher sample rate chip since ad4696 can do everything
> that ad4695 does plus a bit more.
>=20

IMO, that would make sense yes. If the higher sample rate chip fallsback, i=
t will
still work but not at full speed. The other way around is the one that we c=
an't allow
naturally.

But possibly dumb question now... since both devices will be supported at t=
he same
time, do we actually care about having the fallback compatible? My understa=
nding of
the fallback story is that we may load a DTS in an older kernel where chip =
A is
supported but chip B is not and it is ok for chip B to fallback to chip A. =
Since
these devices will be supported at the same time, do we need to care? Unles=
s out of
tree stuff enters the equation?

Or is there another usecase that I'm not aware about (or maybe it just make=
s sense to
document properly...)?

- Nuno S=C3=A1
>=20


