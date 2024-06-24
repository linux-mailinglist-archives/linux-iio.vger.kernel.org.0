Return-Path: <linux-iio+bounces-6797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64CE914450
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B01C1C20FEF
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243A949644;
	Mon, 24 Jun 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtj7rRyX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4C39FC5;
	Mon, 24 Jun 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216789; cv=none; b=hBG7vg2g0HNRLA/P8B0je8cWP3ke7E7zh9Cpxm3n/6QD/TN4Ajm+0KxscZaX1I1j5jYnuCNudWNpJMVOTbnKBIFQWW/zHqAnO6U9N5AQATewxHBdJmI9GZ5G7Vaa5t+BjS+Yo+aU+2VutS9NnLZwSjHeHJb2AT5kF7ZBSrwYFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216789; c=relaxed/simple;
	bh=0k3lCk0xR5XDGDPmtPoBaQZLUx7WxxxeH6tvi+xWCeA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHjrhV/c3/2w7KJr7Gept08eMXi+Kx0rHHepzUiUYfUvHwHxiQqgdZMX9CGe1nB2vY7xr+tG5MuovzfUi9we8cwy4aqfnsJKTnN5bYlWvCRMKwlgiv2796pFzMC6mPb7y8KELhX60yRYahbf81wp6Asf0kQ+Rt8gqSio5xs1WG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtj7rRyX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42278f3aea4so33557965e9.1;
        Mon, 24 Jun 2024 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719216786; x=1719821586; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Axw9NwRqOxazU1/TmMUy1avR/1C75lna5YN/CpZeJG8=;
        b=Wtj7rRyXuyL5AdkrR5aPYG2oPWMmYHZN7/q8cYYyEkVljWE3JQYsJ8qBnw8EXPcHVM
         fHEWt3sfpB/KdwPNRIMM0ynP9ut9DssxF7L7aqgNQFMZ2Zb/r34IWJTIgaUhC+ZxaU7m
         /EKHOXPnDJlSU6iAObgZc8HMnHABceNZkoy/eMuH9z7+PCNIX/Q3c3gESUHUq7kw+uRW
         mckEnM2L1fKwoPxXI37q6XlBcixMugVZxmcLkkQvccbFQFH2ysQr1kI89zcIGloRObdY
         U9BDL8zYegBofzwnG+oW/ob1173dFmTgRH8l8poofsF9Tw/6iEinKGkhVZCUCbJ8Fvs4
         AWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216786; x=1719821586;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Axw9NwRqOxazU1/TmMUy1avR/1C75lna5YN/CpZeJG8=;
        b=PJUEz8Ok6xaqdQSG40CKmx7+Z2BVoewvR0mCUehLUIqnbYQDboni9Emfa4H3ICPiCT
         2wqrLJRxebPfK0/+zlHRGGZ7gMJZ6ea6iYMN062RwZGhY+psbWR38R4efL2uatsLT+oK
         5SmwzGgmNefXRUt+qkwHaXHVoBJB8DHbYG797xfCxfuCQUymydDMixKDtb3BeSA7lsMO
         iipZyc3XR5RA3giwT711KLWfbJI/gmDHdEyWEsb75H/dWY59umQ7JMsbMBd3olj5EVE2
         h9i/6NcpLSIRkqiprfJsw3KWy8GNhUB0IXJdokUhHJbqoWLrEJcr44IIdiGErEbiZwWS
         vTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hJfXJEVpqUCxc2J6+TNC3RNhc8zTh+g6z1qKH1km/QOzj/UJIyb3jhIZuxd/GQPWA6C/+xu+tgZuTbKnFPL1Kl3jAaViF6kmZjIqL4w1R09jIL3EXegQ2xXktgWc3jr2OLRpMnss
X-Gm-Message-State: AOJu0YyFEFnKApxJ8kUWqVlM7V0+4r5haKgnxR0nRl3unjqAiEzHV86T
	m7GTpEANLlCCejKKg0fTimUEyDelV16LQjsRtym6ahpKHzN+C2mp
X-Google-Smtp-Source: AGHT+IHdeS8zdeGcqSiPU5vIU+KBaF/DajPj2HP8b1aF+fr+WL9uHKeoTUCxJOWAJQGHo31OSV1m0A==
X-Received: by 2002:adf:f14a:0:b0:366:f5e6:a1af with SMTP id ffacd0b85a97d-366f5e6a304mr860166f8f.11.1719216786319;
        Mon, 24 Jun 2024 01:13:06 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366387cf44asm9243987f8f.26.2024.06.24.01.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:13:06 -0700 (PDT)
Message-ID: <24eda02c59eb8a7c2d167af358364152a93b3440.camel@gmail.com>
Subject: Re: [PATCH 2/8] iio: add enable and disable services to iio backend
 framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Olivier MOYSAN <olivier.moysan@foss.st.com>, Nuno Sa
 <nuno.sa@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 10:13:05 +0200
In-Reply-To: <20240623145614.1639d5a4@jic23-huawei>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	 <20240618160836.945242-3-olivier.moysan@foss.st.com>
	 <5b7b8a7132934b77b43ffde0650c68c1dd9a5b7e.camel@gmail.com>
	 <8c3de47c-bd72-4560-a43b-5275f2f7a059@foss.st.com>
	 <1e38d2638a2cc62f8a73c6eaf4fd4f79637dbb47.camel@gmail.com>
	 <20240623145614.1639d5a4@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-06-23 at 14:56 +0100, Jonathan Cameron wrote:
> On Thu, 20 Jun 2024 12:07:47 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Wed, 2024-06-19 at 17:59 +0200, Olivier MOYSAN wrote:
> > > Hi Nuno,
> > >=20
> > > On 6/19/24 07:21, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > On Tue, 2024-06-18 at 18:08 +0200, Olivier Moysan wrote:=C2=A0=20
> > > > > Add iio_backend_disable() and iio_backend_enable() APIs to allow
> > > > > IIO backend consumer to request backend disabling and enabling.
> > > > >=20
> > > > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > > > ---=C2=A0=20
> > > >=20
> > > > Hi Olivier,
> > > >=20
> > > > small notes from me...
> > > > =C2=A0=20
> > > > > =C2=A0=C2=A0drivers/iio/industrialio-backend.c | 26 +++++++++++++=
+++++++++++++
> > > > > =C2=A0=C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > > > > =C2=A0=C2=A02 files changed, 28 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > > b/drivers/iio/industrialio-
> > > > > backend.c
> > > > > index b950e30018ca..d3db048c086b 100644
> > > > > --- a/drivers/iio/industrialio-backend.c
> > > > > +++ b/drivers/iio/industrialio-backend.c
> > > > > @@ -166,6 +166,32 @@ int devm_iio_backend_enable(struct device *d=
ev,
> > > > > struct
> > > > > iio_backend *back)
> > > > > =C2=A0=C2=A0}
> > > > > =C2=A0=C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_enable, IIO_BAC=
KEND);
> > > > > =C2=A0=20
> > > > > +/**
> > > > > + * iio_backend_enable - Backend enable
> > > > > + * @dev: Consumer device for the backend
> > > > > + * @back: Backend device
> > > > > + *
> > > > > + * RETURNS:
> > > > > + * 0 on success, negative error number on failure.
> > > > > + */
> > > > > +int iio_backend_enable(struct device *dev, struct iio_backend *b=
ack)
> > > > > +{
> > > > > +	return iio_backend_op_call(back, enable);
> > > > > +}
> > > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_enable, IIO_BACKEND);=C2=A0=20
> > > >=20
> > > > We do already have devm_iio_backend_enable(). From a correctness st=
and point
> > > > and even
> > > > scalability, that API should now call your new iio_backend_enable()=
 instead
> > > > of
> > > > directly call iio_backend_op_call(). I guess that change could be i=
n this
> > > > patch.
> > > > =C2=A0=20
> > >=20
> > > Sure. I have updated the patch.
> > > =C2=A0=20
> > > > > +
> > > > > +/**
> > > > > + * iio_backend_disable - Backend disable
> > > > > + * @dev: Consumer device for the backend
> > > > > + * @back: Backend device
> > > > > + *
> > > > > + */
> > > > > +void iio_backend_disable(struct device *dev, struct iio_backend =
*back)
> > > > > +{
> > > > > +	iio_backend_void_op_call(back, disable);
> > > > > +}
> > > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_disable, IIO_BACKEND);
> > > > > +=C2=A0=20
> > > >=20
> > > > We also have __iio_backend_disable() which is static since all user=
s were
> > > > using
> > > > devm_iio_backend_enable(). I understand that's not suitable for you=
 but I
> > > > would
> > > > instead rename the existing function to iio_backend_disable() and e=
xport it.
> > > > =C2=A0=20
> > >=20
> > > Just renaming is not sufficient. The reason is that=20
> > > devm_add_action_or_reset() require an action with action(void *)=20
> > > prototype. So the prototype of iio_backend_disable() has to be change=
d=20
> > > to void iio_backend_disable(void *back).
> > > I placed the same arguments in enable and disable for symmetry, but *=
dev=20
> > > is not required for time being in disable API. So it can make sense t=
o=20
> > > change iio_backend_disable() prototype.
> > > alternatively, we can call __iio_backend_disable() through this API.
> > > Please, let me know is you have a preference.
> > > =C2=A0=20
> >=20
> > Oh, yes, you're right. I would prefer your later option. Call
> > __iio_backend_disable() from __iio_backend_disable() with a proper type=
d
> ?=C2=A0 That looks like an infinite loop :)=C2=A0=20

Ahaha, yes it looks. But hopefully you got what I really meant :)

- Nuno S=C3=A1
>=20


